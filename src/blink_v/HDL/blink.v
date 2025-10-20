/* Copyright(C) 2016 Cobac.Net All Rights Reserved. */
/* chapter: 第2章       */
/* project: blink       */
/* outline: LED点滅回路 */
/* URL: https://www.shuwasystem.co.jp/support/7980html/6326.html */

module blink (
    input               CLK,    // 100MHzクロック入力
    input               RST,    // 非同期リセット入力（アクティブハイ）
    output  reg [3:0]   LED     // LED出力
);

// 分周カウンタ
// 23ビットカウンタで約0.084秒周期を生成（100MHz想定: 2^23 / 100MHz ≒ 84ms）
reg [22:0] cnt23;
// 分周器 (prescaler)
always @( posedge CLK ) begin
    // 負論理リセット
    if ( ~RST )
        cnt23 <= 23'h0;  // リセット時にカウンタをクリア
    else
        cnt23 <= cnt23 + 1'h1;  // クロックごとにインクリメント
end

// カウンタが最大値に達したらLEDカウンタを更新
wire ledcnten = (cnt23==23'h7fffff);

// LED用6進カウンタ
// 0〜5の6状態をカウント（往復パターン用）
reg [2:0] cnt3;
// リセット付き DFF によるカウンタ更新
always @( posedge CLK ) begin
    // 負論理リセット・分周カウンタが最大値のときのみ更新
    if ( ~RST )
        cnt3 <= 3'h0;  // リセット時に0に戻す
    else
        if ( ledcnten )
            if ( cnt3==3'd5)
                cnt3 <=3'h0;  // 5の次は0に戻る
            else
                cnt3 <= cnt3 + 1'h1;  // 0→1→2→3→4→5とカウントアップ
end

// LEDデコーダ
// カウント値に応じてLEDを点灯（往復パターン: 右→左→右）
always @* begin
    case ( cnt3 )
        3'd0:   LED = 4'b0001;  // LED0のみ点灯（一番右）
        3'd1:   LED = 4'b0010;  // LED1のみ点灯
        3'd2:   LED = 4'b0100;  // LED2のみ点灯
        3'd3:   LED = 4'b1000;  // LED3のみ点灯（一番左）
        3'd4:   LED = 4'b0100;  // LED2のみ点灯（戻り）
        3'd5:   LED = 4'b0010;  // LED1のみ点灯（戻り）
        default:LED = 4'b0000;  // 該当なしの場合は全消灯
    endcase
end

endmodule
