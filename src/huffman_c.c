#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "../lib/heap_c.h"
#include "../lib/huffman_c.h"

void c_huffman_build_tree(Heap *h, HeapNode **t)
{
	while (h->n != 0) {
		if (h->n == 1) {

			c_heap_remove(h, *t);
		} else {
				HeapNode *x = malloc(sizeof(HeapNode));
				HeapNode *y = malloc(sizeof(HeapNode));

				c_heap_remove(h, x);
				c_heap_remove(h, y);

				HeapNode *z = malloc(sizeof(HeapNode));
				z->left = x;
				z->right = y;
				z->frequency = x->frequency + y->frequency;

				c_heap_insert(h, z);
		}
	}
}

void c_huffman_initialize_table(HuffmanNode *t)
{
	int i;
	for (i = 0; i < MAX_HEAP_SIZE; i++) {
		t[i].huffman_code = 0;
		t[i].bit_size = 0;
	}
}

void c_huffman_build_table(HeapNode *root, HuffmanNode *t, int code, int size) {
	if (root->right != NULL) {
		c_huffman_build_table(root->right, t, (code << 1) + 1, size + 1);
	}
	if (root->left != NULL) {
		c_huffman_build_table(root->left, t, (code << 1), size + 1);
	}
	if (root->right == NULL && root->left == NULL) {
		t[(int) root->c].huffman_code = code;
		t[(int) root->c].bit_size = size;
	}
}
