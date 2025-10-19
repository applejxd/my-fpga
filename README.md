# My FPGA examples using Arty-S7-50

Digilent Arty S7-50 FPGA ボード用の Vivado (System Verilog) プロジェクト集

## セットアップ

サブモジュールを含めてクローンする場合:

```bash
git clone --recursive https://github.com/yourusername/my-fpga.git
```

既にクローン済みの場合は、サブモジュールを初期化:

```bash
git submodule update --init --recursive
```

## サブモジュール

- `third_party/cpubook`: [cpubook-code](https://github.com/amane-uehara/cpubook-code.git) - 「作ろう！CPU」のサンプルコード
