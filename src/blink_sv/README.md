# blink_sv

SystemVerilogで記述したLED点滅回路のサンプルプロジェクト

**機能:**
- 1つのLED（LD2）を約1秒周期で点滅
- 100MHz システムクロックを分周して1Hz動作
- ck_rst（リセット信号）でリセット可能（負論理）
- モジュール構造化: prescaler（分周器）とcpu（制御ロジック）を分離

**ファイル構成:**
- [src/top.sv](src/top.sv) - トップモジュール（各モジュールの接続）
- [src/prescaler.sv](src/prescaler.sv) - クロック分周器モジュール
- [src/cpu.sv](src/cpu.sv) - LED制御ロジックモジュール
- [blink.xdc](blink.xdc) - ピン配置・タイミング制約ファイル
- [blink_sv.xpr](blink_sv.xpr) - Vivadoプロジェクトファイル

## 開発環境

- **FPGAボード:** Digilent Arty S7-50
- **開発ツール:** Xilinx Vivado 2024.2
- **言語:** SystemVerilog

## アーキテクチャ

このプロジェクトは3つのモジュールで構成されています：

### 1. prescaler.sv - クロック分周器

```systemverilog
module prescaler #(parameter RATIO = 2)
```

- 高速クロックを低速クロックに分周
- パラメータ `RATIO` で分周比を指定（デフォルト: 2）
- 100MHz → 1Hz変換では `RATIO=100_000_000` を使用

### 2. cpu.sv - LED制御ロジック

```systemverilog
module cpu(input logic clk, n_reset, output logic led)
```

- 分周されたクロックでLEDを制御
- クロックの立ち上がりごとにLED状態を反転
- 負論理リセット対応

### 3. top.sv - トップモジュール

```systemverilog
module top(input logic pin_clock, pin_n_reset, output logic pin_led)
```

- prescalerとcpuモジュールを接続
- FPGAのピンとモジュールを結びつける

## 使い方

### プロジェクトを開く

```bash
cd src/blink_sv
# Vivadoでblink_sv.xprを開く
```

### ビルドと書き込み

1. Vivadoでプロジェクトを開く
2. `Generate Bitstream` を実行してビルド
3. Arty S7-50ボードをUSBで接続
4. `Open Hardware Manager` を選択
5. `Open target` → `Auto Connect`
6. `Program device` でビットストリームを書き込み

### 動作確認

- LD2（LED[2]）が約1秒周期で点滅します
- ck_rstボタン（C18ピン）を押すとLEDが消灯します

## ピン配置

| 信号名 | モジュールポート | XDCピン | 説明 |
|--------|------------------|---------|------|
| CLK | pin_clock | R2 | 100MHz システムクロック |
| RST | pin_n_reset | C18 | リセット信号（負論理） |
| LED | pin_led | E18 | LED[2]出力 |

## Verilog版との違い

このプロジェクト（[blink_sv](./))とVerilog版（[blink_v](../blink_v/)）の主な違い：

| 項目 | blink_sv (SystemVerilog) | blink_v (Verilog) |
|------|--------------------------|-------------------|
| 言語 | SystemVerilog | Verilog HDL |
| モジュール構成 | 3モジュール構成（top, prescaler, cpu） | 1モジュール構成 |
| LED制御 | 1個のLEDを点滅 | 4個のLEDをナイトライダー風に点灯 |
| 分周器 | パラメータ化された汎用prescaler | blink専用の分周ロジック |
| リセット | 負論理（active-low） | 負論理（active-low） |
| 設計方針 | モジュール化・再利用性重視 | シンプルな実装 |

## ボード情報

- **製品ページ:** [Digilent Arty S7-50](https://digilent.com/shop/arty-s7-spartan-7-fpga-development-board/)
- **制約ファイル参考:** [Arty-S7-50-Master.xdc](https://github.com/Digilent/digilent-xdc/blob/master/Arty-S7-50-Master.xdc)

## カスタマイズ

### 点滅周期の変更

[top.sv:7](src/top.sv#L7) のRATIOパラメータを変更：

```systemverilog
prescaler #(.RATIO(100_000_000)) prescaler(  // 1Hz (1秒周期)
```

例：
- 2Hz（0.5秒周期）: `.RATIO(50_000_000)`
- 10Hz（0.1秒周期）: `.RATIO(10_000_000)`

### LED制御ロジックの拡張

[cpu.sv](src/cpu.sv) を編集して、より複雑なLEDパターンを実装できます。

## ライセンス

このプロジェクトのライセンスについては、リポジトリのルートディレクトリを参照してください。
