// CPUモジュール: LED制御ロジック
// クロックの立ち上がりごとにLEDの状態を反転（トグル）
module cpu(
  input  logic clk,      // 入力: クロック信号（1Hz）
  input  logic n_reset,  // 入力: リセット信号（負論理：0でリセット）
  output logic led       // 出力: LED制御信号
);
  // 内部状態レジスタ: LEDの現在の状態（0=消灯、1=点灯）
  logic a, next_a;

  // 状態レジスタの更新（クロックの立ち上がりエッジで動作）
  always_ff @(posedge clk) begin
    if (~n_reset) a <= 1'b0;  // リセット時: LEDを消灯
    else          a <= next_a; // 通常時: 次の状態に遷移
  end

  // 出力: 内部状態をLEDピンに接続
  assign led = a;

  // 組み合わせ回路: 次の状態を計算
  // 現在の状態を反転することで、クロックごとに点滅
  always_comb begin
    next_a = ~a;  // 0→1、1→0 と反転
  end
endmodule
