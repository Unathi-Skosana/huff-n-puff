#ifndef UTILS_H
#define UTILS_H


void *emalloc(unsigned int size);
void write_header(int *freqs_arr, int num_unique_chars, FILE *out);
void encode_bits(HuffmanNode *tree, FILE *in, FILE *out);

#endif
