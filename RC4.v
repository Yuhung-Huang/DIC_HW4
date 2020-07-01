`timescale 1ns/10ps
module RC4(clk,rst,key_valid,key_in,plain_read,plain_in_valid,plain_in,plain_write,plain_out,cipher_write,cipher_out,cipher_read,cipher_in,cipher_in_valid,done);
    input clk,rst;
    input key_valid,plain_in_valid,cipher_in_valid;
    input [7:0] key_in,cipher_in,plain_in;
    output done;
    output plain_write,cipher_write,plain_read,cipher_read;
    output [7:0] cipher_out,plain_out;

    
integer a;


always @(posedge clk or negedge rst)begin
    if(rst)begin
        key <= 8'b0;
    end
    else begin
        if(key_valid)begin
            key[key_cnt] <= key_in; 
        end
    end
end

assign KSA_en = ~key_valid; // adjust

always @(posedge clk or negedge rst)begin
    if(rst)begin
        key_cnt <= 5'b0;
    end
    else begin
        if(key_valid || KSA_en)begin
            key_cnt <= key_cnt + 1'b1;
        end
    end
end

reg [7:0] sbox[0:63];

always @(posedge clk or negedge rst)begin
    if(rst)begin
        for(a=0;a<64;a=a+1)begin
            sbox[a]<=a;
        end
    end
    else begin
        if(KSA_en)begin
            sbox[i] <= sbox[j];
            sbox[j] <= sbox[i];
        end
    end
end

always @(posedge clk or negedge rst) begin
    if(rst)begin
        j<=0;
    end
    else begin
        if(KSA_en)begin
            j <= ( j + sbox[i] + key_select ) >> 6;
        end
    end
end

always @(posedge clk or negedge rst) begin
    if(rst) begin
        i <= 6'b0;
    end
    else begin    
        if(KSA_en)begin
            i <= i + 1'b1;
        end
    end
end
    
    
assign key_select = key[key_cnt];
    
    
    
    
    
    
    
endmodule
