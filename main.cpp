#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

//TODO: maybe big flower-bitmasks can be somehow calculated (they all look pretty similar)
struct Bitmask{
	int width;
	uint64_t* mask;
	Bitmask(int W,uint64_t i,bool inv){
		width = W;
		mask = (uint64_t*)malloc(sizeof(uint64_t)*W*W);
		memset(mask,0,sizeof(uint64_t)*W*W);
		if(i != 0){
			create_mask(i,inv);
		}
	}
	friend void operator&=(Bitmask bm1,Bitmask bm2){
		for(int x=0;x<bm1.width;x++){
			for(int y=0;y<bm1.width;y++){
				bm1.mask[x+y*bm1.width] &= bm2.mask[x+y*bm1.width];
			}
		}
	}
	void create_mask(uint64_t i,bool inv){
		uint64_t bm = 1;
		while(bm <= i){
			bm *= 2;
		}
		bm -= 1;
		
		uint64_t bp = 1;
		int pos = 0;
		for(int x=1;x<width+1;x++){
			uint64_t n = 0;
			for(int y=1;y<width+1;y++){
				n += x;
				if(!inv){
					if(((n & i) == i)){
						mask[pos] |= bp;
					}
				}else{
					if(((n & i) != i)){
						mask[pos] |= bp;
					}					
				}
				if(bp == 0x1000000000000000){
					bp = 1;
					pos++;
				}else{
					bp *= 2;
				}
			}
		}
	}
	void to_string(char* txt){
		uint64_t bp = 1;
		int pos = 0;
		for(int x=1;x<width+1;x++){
			for(int y=1;y<width+1;y++){
				if((mask[pos] & bp)!=0){
					*txt = '1';
				}else{
					*txt = '0';
				}
				txt++;
				if(bp == 0x1000000000000000){
					bp = 1;
					pos++;
				}else{
					bp *= 2;
				}
			}
			*txt='\n';
			txt++;
		}
		*txt=0;
	}
};

int main(){
	uint64_t factorize = 4*3*2;
	int bits = 0;
	int f = 1;
	while(f<factorize){
		bits++;
		f *= 2;
	}
	
	
	uint64_t i = 1;
	uint64_t bp = 1;
	int W = 64;
	char txt[W*W+W+1];
	Bitmask curBm(W,0,false);
	int pos = 0;
	// This massively reduces the use/perfomance, maybe there is a better way?
	for(int x=1;x<W+1;x++){
		uint64_t n = 0;
		for(int y=1;y<W+1;y++){
			n += x;
			if (n <= factorize){ // maybe this not dependend on factorize, but on 2^x
				curBm.mask[pos] |= bp;
			}
			if(bp == 0x1000000000000000){
				bp = 1;
				pos++;
			}else{
				bp *= 2;
			}
		}
	}
	//memset(curBm.mask,0xFFFFFFFFFFFFFFFF,sizeof(uint64_t)*W*W);
	
	printf("\n\n\n----------------\n");
	//curBm.to_string(txt);
	//printf("%s----------------\n\n\n",txt);
	for(int k=0;k<bits;k++){
		bool inv = ((factorize & i) == 0);
		Bitmask bm(W,i,inv);
		curBm &= bm;
		/*char name[100];
		sprintf(name,"factor_layers/%d.dat");
		FILE* f = fopen(name,"w+");
		fwrite(bm,sizeof(uint64_t),W*W,f);
		fclose(f);*/
		i *= 2;
	}
	printf("\n\n\n----------------\n");
	curBm.to_string(txt);
	printf("%s----------------\n\n\n",txt);
	return 0;
}