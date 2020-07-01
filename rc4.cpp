
#include <bits/stdc++.h>
using namespace std;
int main (){
    int key[32]={0x78,0x46,0x4c,0x33,0x4d,0x32,0x53,0x5a,0x51,0x39,0x4a,0x35,0x75,0x48,0x33,0x62,0x36,0x6e,0x4c,0x78,0x31,0x63,0x4d,0x30,0x44,0x41,0x36,0x43,0x34,0x5a,0x43,0x4d};
    int sbox[64];
    for(int i=0;i<64;i++){
        sbox[i] = i;
    }
    
    int j;
    for(int i=0;i<64;i++){
        j = (j+sbox[i]+key[i%32])%64;
        int tmp;
        cout<<"i = "<<i<<"j = "<<j<<endl;
        cout<<"s[i]= "<<sbox[i]<<" s[j]= "<<sbox[j]<<endl;
        tmp=sbox[i];
        sbox[i]=sbox[j];
        sbox[j]=tmp;
        cout<<"after swap"<<endl;
        cout<<"s[i]= "<<sbox[i]<<" s[j]= "<<sbox[j]<<endl;
    }

}




