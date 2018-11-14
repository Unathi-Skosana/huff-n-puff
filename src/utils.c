#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "../lib/huffman_c.h"
#include "../lib/heap_c.h"

char buffer = 0;
int packet_cnt = 0;

void write_header(int *freq_arr, int num_unique_chars, FILE *out)
{
    int i, j, cnt, freq_binary;


    cnt = num_unique_chars;
    for (i = 0; i < 4; i++) {
        fprintf(out, "%c", (char) cnt);
        cnt >>= 8;
    }

    for (i = 0; i < MAX_HEAP_SIZE; i++) {
        if (freq_arr[i] != 0) {
            fprintf(out, "%c", (char) i);
            freq_binary = freq_arr[i];
            for (j = 0; j < 4; j++) {
                fprintf(out, "%c", (char) freq_binary);
                freq_binary >>= 8;
            }
        }
    }
}


void encode_bits(HuffmanNode *table, FILE *in, FILE *out)
{
    int code, c , b, shift, i;

    while ((c = fgetc(in)) != EOF) {
        code = table[c].huffman_code;
        for (i = table[c].bit_size - 1; i >= 0; i--) {
            b = (code >> i) % 2;
            if (b == 1) {
                shift = 1 << (7 - packet_cnt);
                buffer = (buffer | shift);
            }
            packet_cnt++;
            if (packet_cnt == 8) {
                fprintf(out, "%c", buffer);
                packet_cnt = 0;
                buffer = 0;
            }
        }
    }

    if (packet_cnt != 0) {
        fprintf(out, "%c", buffer);
    }
}
