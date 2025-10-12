# blink

LED点滅回路のサンプルプロジェクト

**機能:**
- 4つのLED（LD0～LD3）をナイトライダー風に順次点灯
- 100MHz システムクロックを分周して約0.084秒周期で動作
- BTN0（プッシュボタン）でリセット可能

**ファイル構成:**
- [HDL/blink.v](blink/HDL/blink.v) - Verilogソースコード
- [blink.xdc](blink/blink.xdc) - ピン配置・タイミング制約ファイル
- [blink.xpr](blink/blink.xpr) - Vivadoプロジェクトファイル
- [blink.bit](blink/blink.bit) - ビットストリームファイル（ビルド済み）

## 開発環境

- **FPGAボード:** Digilent Arty S7-50
- **開発ツール:** Xilinx Vivado
- **言語:** Verilog HDL

## 使い方

### プロジェクトを開く

```bash
cd blink
# Vivadoでblink.xprを開く
```

### ビットストリームの書き込み

1. Arty S7-50ボードをUSBで接続
2. Vivadoで `Open Hardware Manager` を選択
3. `Open target` → `Auto Connect`
4. `Program device` でblink.bitを書き込み

## ボード情報

- **製品ページ:** [Digilent Arty S7-50](https://digilent.com/shop/arty-s7-spartan-7-fpga-development-board/)
- **制約ファイル参考:** [Arty-S7-50-Master.xdc](https://github.com/Digilent/digilent-xdc/blob/master/Arty-S7-50-Master.xdc)

## 参考資料

- プロジェクト元: https://www.shuwasystem.co.jp/support/7980html/6326.html
- Copyright(C) 2016 Cobac.Net

## ライセンス

各プロジェクトは元のライセンスに従います。
