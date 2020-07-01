`timescale 1ns/10ps
module RC4(clk,rst,key_valid,key_in,plain_read,plain_in_valid,plain_in,plain_write,plain_out,cipher_write,cipher_out,cipher_read,cipher_in,cipher_in_valid,done);
    input clk,rst;
    input key_valid,plain_in_valid,cipher_in_valid;
    input [7:0] key_in,cipher_in,plain_in;
    output reg done;
    output reg plain_write,cipher_write,plain_read,cipher_read;
    output  [7:0] cipher_out,plain_out;


parameter [2:0] KEYIN           = 2'b00,
                SBOX            = 2'b01,
                ENCRYPT         = 2'b10,
                DECODE          = 2'b11;

reg [1:0]state;
reg [1:0]next_state;

reg KEYIN_done;
reg SBOX_done;
reg ENCRYPT_done;
reg DECODE_done;
reg [7:0]key[0:31];
reg [5:0]key_cnt;
reg [6:0]sbox_i;
reg [6:0]sbox_i_gate;
reg [5:0]j;
wire[9:0]tmp_j;
reg gate;
reg [10:0]encrypt_i;
reg [10:0]encrypt_j;
wire [5:0]en_i;
wire [5:0]en_j;
wire [8:0]tmp_sbox;
reg cipher_write_gate;
reg encrypt_gate;
reg encrypt_done_gate;
reg plain_write_gate;
reg decode_write_gate;
reg decode_done_gate;


reg [10:0] encrypt_i_gate;

reg decode_done_gate2;

reg plain_in_valid_gate;
reg plain_in_valid_gate2;
reg plain_in_valid_gate3;
reg cipher_in_valid_gate;
reg cipher_in_valid_gate2;
reg cipher_in_valid_gate3;

integer a;
always @(posedge clk or posedge rst) begin
    if(rst)begin
        state <= KEYIN;
    end
    else begin
        state <= next_state;
    end
end
       
always @(*) begin
    next_state = state;
    case(state)
        KEYIN:          next_state = KEYIN_done         ? SBOX              : KEYIN;
        SBOX:begin 
            if(SBOX_done)begin
                if(encrypt_done_gate)begin
                    next_state = DECODE;
                end
                else begin
                    next_state = ENCRYPT;
                end
            end
            else begin
                next_state = SBOX;
            end
        end
        ENCRYPT:        next_state = ENCRYPT_done       ? SBOX              : ENCRYPT;
        DECODE:         next_state = DECODE_done        ? KEYIN             : DECODE;
    endcase
end

always @(*) begin
    KEYIN_done = 1'b0;
    SBOX_done = 1'b0;
    ENCRYPT_done = 1'b0;
    DECODE_done = 1'b0;
    done = 1'b0;
    plain_read = 1'b0;
    cipher_write_gate = 1'b0;
    cipher_read = 1'b0;
    plain_write_gate = 1'b0;
    case(state)
        KEYIN:begin
            KEYIN_done = key_cnt==6'd32 ? 1'b1 : 1'b0;
        end
        SBOX:begin
            SBOX_done = sbox_i==7'd64 ? 1'b1: 1'b0;
        end
        ENCRYPT:begin
            plain_read          = gate ? 1'b0 : 1'b1;
            cipher_write_gate   = gate ? 1'b1 : 1'b0;
            ENCRYPT_done        = encrypt_done_gate;/////check here how other people write this signal
        end
        DECODE:begin
           cipher_read = gate ? 1'b0 : 1'b1;
           plain_write_gate = gate ? 1'b1 : 1'b0;
           done = decode_done_gate2;
        end
    endcase
end

reg key_valid_gate;
always @(posedge clk or posedge rst)begin
    if(rst)begin
        decode_done_gate2 <= 1'b0;
    end
    else begin
        decode_done_gate2 <= decode_done_gate;
    end
end

always @(posedge clk or posedge rst)begin
    if(rst)begin
        for(a=0;a<32;a=a+1)begin
            key[a] <= 8'b0;
        end
    end
    else begin
        if(key_valid_gate)begin
            key[key_cnt] <= key_in;
        end
    end
end


always @(posedge clk or posedge rst)begin
    if(rst)begin
    end
    else begin
        key_valid_gate <= key_valid;
    end
end
always @(posedge clk or posedge rst) begin
    if(rst)begin
        key_cnt <= 6'b0;
    end
    else begin
        if(key_valid_gate)begin
            key_cnt <= key_cnt + 1'b1;
        end
    end
end

reg [7:0] sbox[0:63];

always @(posedge clk or posedge rst)begin
    if(rst)begin
        for(a=0;a<64;a=a+1)begin
            sbox[a]<=a;
        end
    end
    else begin
        if(ENCRYPT_done)begin
            for(a=0;a<64;a=a+1)begin
                sbox[a]<=a;
            end
        end
        else begin
          if(gate)begin
              if(state==SBOX)begin
                  sbox[sbox_i_gate[5:0]] <= sbox[j];
                  sbox[j] <= sbox[sbox_i_gate[5:0]];
              end
               if((state==ENCRYPT || state == DECODE) && (encrypt_i_gate>11'b0) && (~encrypt_gate))begin
                  sbox[encrypt_i_gate[5:0]] <= sbox[encrypt_j[5:0]];
                  sbox[encrypt_j[5:0]] <= sbox[encrypt_i_gate[5:0]];
              end
          end
        end
    end
end

always @(posedge clk or posedge rst) begin
    if(rst)begin
        sbox_i <= 7'b0;
        sbox_i_gate <= 7'b0;
    end
    else begin
        if(ENCRYPT_done)begin
            sbox_i_gate <= 7'b0;
            sbox_i <= 7'b0;
        end
        else begin
            if(state==SBOX)begin
                if(~gate)begin
                    if(sbox_i!=7'd64)begin
                        sbox_i <= sbox_i + 1'b1;
                        sbox_i_gate <= sbox_i;
                    end
                    else begin
                        sbox_i <= 7'b0;
                        sbox_i_gate <= sbox_i;
                    end
                end 
            end
        end
    end
end


assign tmp_j = (j + sbox[sbox_i] + key[sbox_i[4:0]]);

always @(posedge clk or posedge rst)begin
    if(rst)begin
        j<=6'b0;
    end
    else begin
        if(ENCRYPT_done)begin
            j<=6'b0;
        end
        else begin
            if(state == SBOX)begin
                if(~gate)begin
                    if(sbox_i != 7'd64)begin
                        j <= tmp_j[5:0];
                    end
                end
            end
        end
    end
end

always @(posedge clk or posedge rst)begin
    if(rst)begin
        gate<=1'b0;
    end
    else begin
        gate<=~gate;
    end
end



always @(posedge clk or posedge rst) begin
    if(rst)begin
        encrypt_i<=11'b0;
        encrypt_i_gate<=11'b0;
    end
    else begin
        if(ENCRYPT_done)begin
            encrypt_i <= 11'b0;
            encrypt_i_gate <= 11'b0;
        end
        else begin
          if(~gate)begin
              if(state == ENCRYPT||state == DECODE)begin
                  encrypt_i <= encrypt_i + 1'b1;
                  encrypt_i_gate <= encrypt_i;
              end
          end
        end
    end
end

always @(posedge clk or posedge rst)begin
    if(rst)begin
        encrypt_j <= 11'b0;
    end
    else begin
        if(ENCRYPT_done)begin
            encrypt_j <= 11'b0;
        end
        else begin
          if(~gate)begin
              if(encrypt_gate)begin
                  encrypt_j <= en_j + sbox[encrypt_i[5:0]];
              end
          end
        end
    end
end

assign en_j = encrypt_j[5:0];
assign tmp_sbox = sbox[encrypt_i_gate[5:0]]+sbox[encrypt_j[5:0]];


always @(posedge clk or posedge rst)begin// encrypt_gate and cipher_write_gate can combine
    if(rst)begin
        encrypt_gate <= 1'b0;
    end
    else begin
        if(state == ENCRYPT)begin
            encrypt_gate <= cipher_write_gate;
        end
        else if(state == DECODE) begin
            encrypt_gate <= plain_write_gate;
        end
        else begin
            encrypt_gate <= 1'b0;
        end
    end
end

reg cipher_write_gate2;
reg cipher_write_gate3;
always @(posedge clk or posedge rst)begin
    if(rst)begin
        cipher_write <= 1'b0;
        cipher_write_gate2<= 1'b0;
        cipher_write_gate3<=1'b0;
        plain_write <= 1'b0;
    end
    else begin
        if(state == ENCRYPT)begin
            cipher_write_gate3 <= cipher_write_gate;
            cipher_write <= cipher_write_gate2;
        end
        if(state == DECODE) begin
            cipher_write_gate3 <= plain_write_gate;
            plain_write <= cipher_write_gate2;
        end
        cipher_write_gate2 <= cipher_write_gate3;
    end
end

reg [7:0]plain_in_reg;
reg [7:0]plain_in_reg2;
always @(posedge clk or posedge rst)begin
    if(rst)begin
        plain_in_reg <= 8'b0;
        plain_in_reg2 <= 8'b0;
    end
    else begin
        if(~gate)begin
            if(state == ENCRYPT)begin
                plain_in_reg <= plain_in;
            end
            if(state == DECODE) begin
                plain_in_reg <= cipher_in;
            end
            plain_in_reg2<= plain_in_reg;
        end
    end
end

assign cipher_out = (cipher_write) ? plain_in_reg2^sbox[tmp_sbox[5:0]] : 8'b0;
assign plain_out = (plain_write) ? plain_in_reg2^sbox[tmp_sbox[5:0]] : 8'b0;



always @(posedge clk or posedge rst)begin
    if(rst)begin
        plain_in_valid_gate <= 1'b0;
        plain_in_valid_gate2<=1'b0;
        plain_in_valid_gate3<=1'b0;
        cipher_in_valid_gate <= 1'b0;
        cipher_in_valid_gate2<= 1'b0;
        cipher_in_valid_gate3<=1'b0;
    end
    else begin
        if(state==ENCRYPT)begin
            plain_in_valid_gate3 <= plain_in_valid;
            plain_in_valid_gate2 <= plain_in_valid_gate3;
            plain_in_valid_gate  <= plain_in_valid_gate2;
        end
        if(state==DECODE)begin
            cipher_in_valid_gate3 <= cipher_in_valid;
            cipher_in_valid_gate2 <= cipher_in_valid_gate3;
            cipher_in_valid_gate  <= cipher_in_valid_gate2;
        end
    end
end

always @(posedge clk or posedge rst)begin
    if(rst)begin
        encrypt_done_gate<=1'b0;
        decode_done_gate<=1'b0;
    end
    else begin
        if(state == ENCRYPT)begin
            if(~plain_in_valid_gate && encrypt_i > 11'd10) encrypt_done_gate <= 1'b1;
        end
        if(state == DECODE)begin
            if(~cipher_in_valid_gate && encrypt_i > 11'd10) decode_done_gate <= 1'b1;
        end
    end
end





endmodule

