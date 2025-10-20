// クロック分周器モジュール: 高速クロックを低速クロックに変換
// パラメータ RATIO で分周比を指定（例: RATIO=100なら100分の1の周波数に）
module prescaler #(parameter RATIO = 2) (
  input  logic quick_clock,  // 入力: 高速クロック（例: 100MHz）
  output logic slow_clock    // 出力: 低速クロック（例: 1Hz）
);
  // カウンタレジスタ: 0からRATIO/2-1までカウント
  logic [31:0] counter, next_counter;

  // カウンタが最大値に達したかを判定
  // RATIO/2で反転することで、デューティ比50%の出力クロックを生成
  logic inv;
  assign inv = (counter == (RATIO/2 - 1));

  // 次のカウンタ値を計算
  // 最大値に達したら0にリセット、そうでなければ+1
  assign next_counter = inv ? 32'd0 : counter + 32'd1;

  // カウンタを更新（高速クロックの立ち上がりエッジで動作）
  always_ff @(posedge quick_clock) counter <= next_counter;

  // 次の低速クロック値を計算
  // カウンタが最大値に達したら反転、そうでなければ現在の値を維持
  logic next_slow_clock;
  assign next_slow_clock = inv ? ~slow_clock : slow_clock;

  // 低速クロックを更新（高速クロックの立ち上がりエッジで動作）
  always_ff @(posedge quick_clock) slow_clock <= next_slow_clock;
endmodule
