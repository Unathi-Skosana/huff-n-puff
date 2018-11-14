#ifndef HUFFMANC_H
#define HUFFMANC_H

#include "heap.h"
#include "huffman.h"

void c_huffman_build_tree(Heap *h, HeapNode **t);
void c_huffman_initialize_table(HuffmanNode *t);
void c_huffman_build_table(HeapNode *root, HuffmanNode *t, int code, int size);
void c_huffman_show_table(HuffmanNode *t);
void c_huffman_show_tree(HeapNode *t, int l);

#endif
