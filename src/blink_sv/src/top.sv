// トップモジュール: FPGAのピンと内部モジュールを接続
module top(
  input  logic pin_clock,    // FPGAボード上の100MHzクロック入力
  input  logic pin_n_reset,  // リセット信号（負論理：0でリセット、1で動作）
  output logic pin_led       // LED出力ピン
);
  // 内部信号: 分周後の低速クロック（1Hz）
  logic clk;

  // クロック分周器インスタンス
  // 100MHz → 1Hz に分周（100_000_000 = 100MHz / 1Hz）
  prescaler #(.RATIO(100_000_000)) prescaler(
    .quick_clock(pin_clock),  // 入力: 100MHzの高速クロック
    .slow_clock(clk)          // 出力: 1Hzの低速クロック
  );

  // LED制御CPUインスタンス
  // 1HzクロックでLEDをトグル（点滅周期: 2秒）
  cpu cpu(
    .clk(clk),                 // 入力: 1Hzクロック
    .n_reset(pin_n_reset),     // 入力: リセット信号
    .led(pin_led)              // 出力: LED制御信号
  );
endmodule
