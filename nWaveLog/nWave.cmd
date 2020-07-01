wvResizeWindow -win $_nWave1 1920 23 1920 1137
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/yuhong/DIC/DIC2020/DIC_HW4/HW4/rc4_2.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/testfixture2"
wvGetSignalSetScope -win $_nWave1 "/testfixture2/rc4"
wvSetPosition -win $_nWave1 {("G1" 21)}
wvSetPosition -win $_nWave1 {("G1" 21)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/testfixture2/rc4/DECODE_done} \
{/testfixture2/rc4/ENCRYPT_done} \
{/testfixture2/rc4/cipher_in\[7:0\]} \
{/testfixture2/rc4/cipher_in_valid} \
{/testfixture2/rc4/cipher_in_valid_gate} \
{/testfixture2/rc4/cipher_in_valid_gate2} \
{/testfixture2/rc4/cipher_in_valid_gate3} \
{/testfixture2/rc4/clk} \
{/testfixture2/rc4/decode_done_gate} \
{/testfixture2/rc4/decode_done_gate2} \
{/testfixture2/rc4/decode_write_gate} \
{/testfixture2/rc4/done} \
{/testfixture2/rc4/plain_in_valid} \
{/testfixture2/rc4/plain_in_valid_gate} \
{/testfixture2/rc4/plain_in_valid_gate2} \
{/testfixture2/rc4/plain_in_valid_gate3} \
{/testfixture2/rc4/plain_out\[7:0\]} \
{/testfixture2/rc4/plain_read} \
{/testfixture2/rc4/plain_write} \
{/testfixture2/rc4/plain_write_gate} \
{/testfixture2/rc4/sbox\[0:63\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 )} 
wvSetPosition -win $_nWave1 {("G1" 21)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 211304.367983 -snap {("G2" 0)}
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/testfixture2"
wvGetSignalSetScope -win $_nWave1 "/testfixture2/rc4"
wvSetPosition -win $_nWave1 {("G1" 27)}
wvSetPosition -win $_nWave1 {("G1" 27)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/testfixture2/rc4/DECODE_done} \
{/testfixture2/rc4/ENCRYPT_done} \
{/testfixture2/rc4/cipher_in\[7:0\]} \
{/testfixture2/rc4/cipher_in_valid} \
{/testfixture2/rc4/cipher_in_valid_gate} \
{/testfixture2/rc4/cipher_in_valid_gate2} \
{/testfixture2/rc4/cipher_in_valid_gate3} \
{/testfixture2/rc4/clk} \
{/testfixture2/rc4/decode_done_gate} \
{/testfixture2/rc4/decode_done_gate2} \
{/testfixture2/rc4/decode_write_gate} \
{/testfixture2/rc4/done} \
{/testfixture2/rc4/plain_in_valid} \
{/testfixture2/rc4/plain_in_valid_gate} \
{/testfixture2/rc4/plain_in_valid_gate2} \
{/testfixture2/rc4/plain_in_valid_gate3} \
{/testfixture2/rc4/plain_out\[7:0\]} \
{/testfixture2/rc4/plain_read} \
{/testfixture2/rc4/plain_write} \
{/testfixture2/rc4/plain_write_gate} \
{/testfixture2/rc4/sbox\[0:63\]} \
{/testfixture2/rc4/encrypt_done_gate} \
{/testfixture2/rc4/encrypt_gate} \
{/testfixture2/rc4/encrypt_i\[10:0\]} \
{/testfixture2/rc4/encrypt_i_gate\[10:0\]} \
{/testfixture2/rc4/encrypt_j\[10:0\]} \
{/testfixture2/rc4/state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 22 23 24 25 26 27 )} 
wvSetPosition -win $_nWave1 {("G1" 27)}
wvGetSignalClose -win $_nWave1
wvSelectGroup -win $_nWave1 {G2}
wvSetCursor -win $_nWave1 190561.260304 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 26 )} 
wvSelectSignal -win $_nWave1 {( "G1" 25 26 )} 
wvSelectSignal -win $_nWave1 {( "G1" 24 25 26 )} 
wvSelectSignal -win $_nWave1 {( "G1" 24 25 26 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetCursor -win $_nWave1 194138.999161 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 1029976.573132 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 17 )} 
wvSelectSignal -win $_nWave1 {( "G1" 19 )} 
wvSelectSignal -win $_nWave1 {( "G1" 17 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/testfixture2"
wvGetSignalSetScope -win $_nWave1 "/testfixture2/rc4"
wvGetSignalSetScope -win $_nWave1 "/testfixture2/rc4"
wvSetPosition -win $_nWave1 {("G1" 28)}
wvSetPosition -win $_nWave1 {("G1" 28)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/testfixture2/rc4/DECODE_done} \
{/testfixture2/rc4/ENCRYPT_done} \
{/testfixture2/rc4/cipher_in\[7:0\]} \
{/testfixture2/rc4/cipher_in_valid} \
{/testfixture2/rc4/cipher_in_valid_gate} \
{/testfixture2/rc4/cipher_in_valid_gate2} \
{/testfixture2/rc4/cipher_in_valid_gate3} \
{/testfixture2/rc4/clk} \
{/testfixture2/rc4/decode_done_gate} \
{/testfixture2/rc4/decode_done_gate2} \
{/testfixture2/rc4/decode_write_gate} \
{/testfixture2/rc4/done} \
{/testfixture2/rc4/plain_in_valid} \
{/testfixture2/rc4/plain_in_valid_gate} \
{/testfixture2/rc4/plain_in_valid_gate2} \
{/testfixture2/rc4/plain_in_valid_gate3} \
{/testfixture2/rc4/plain_out\[7:0\]} \
{/testfixture2/rc4/plain_read} \
{/testfixture2/rc4/plain_write} \
{/testfixture2/rc4/plain_write_gate} \
{/testfixture2/rc4/sbox\[0:63\]} \
{/testfixture2/rc4/encrypt_done_gate} \
{/testfixture2/rc4/encrypt_gate} \
{/testfixture2/rc4/encrypt_i\[10:0\]} \
{/testfixture2/rc4/encrypt_i_gate\[10:0\]} \
{/testfixture2/rc4/encrypt_j\[10:0\]} \
{/testfixture2/rc4/state\[1:0\]} \
{/testfixture2/rc4/cipher_read} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 28 )} 
wvSetPosition -win $_nWave1 {("G1" 28)}
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 23)}
wvSetPosition -win $_nWave1 {("G1" 21)}
wvSetPosition -win $_nWave1 {("G1" 20)}
wvSetPosition -win $_nWave1 {("G1" 19)}
wvSetPosition -win $_nWave1 {("G1" 18)}
wvSetPosition -win $_nWave1 {("G1" 17)}
wvSetPosition -win $_nWave1 {("G1" 16)}
wvSetPosition -win $_nWave1 {("G1" 15)}
wvSetPosition -win $_nWave1 {("G1" 14)}
wvSetPosition -win $_nWave1 {("G1" 13)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetCursor -win $_nWave1 1778029.657625 -snap {("G1" 3)}
wvExit
