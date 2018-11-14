#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "../lib/huffman_c.h"
#include "../lib/heap_c.h"
#include "../lib/utils.h"

FILE *input_file;
FILE *output_file;
int ch, i, total_count = 0;
int freq_arr[MAX_HEAP_SIZE];
char out[1024];

Heap *heap;
HeapNode *node = NULL;
HeapNode *root = NULL;
HuffmanNode *table = NULL;

int main(int argc, char *argv[])
{

    assert(argc == 2);
    if ((input_file = fopen(argv[1], "r")) == NULL) {
        fprintf(stderr, "File '%s' could not be opened:\n", argv[1]);
        exit(1);
    }

    ch = fgetc(input_file);
    while (ch != EOF) {
        ++freq_arr[ch];
        ch = fgetc(input_file);
    }

    rewind(input_file);
    sprintf(out, "%s.cz", argv[1]);

    if ((output_file = fopen(out, "wb")) == NULL) {
        fprintf(stderr, "Could not create output file");
		exit(1);
	}

    heap = malloc(MAX_HEAP_SIZE * sizeof(Heap));
    table = malloc(MAX_HEAP_SIZE * sizeof(HuffmanNode));
    root = malloc(sizeof(HeapNode));


    c_heap_initialize(heap);

    for (i = 0; i < MAX_HEAP_SIZE; i++) {
        if (freq_arr[i] != 0) {
            node = malloc(sizeof(HeapNode));
            node->frequency = freq_arr[i];
            node->c = i;
            c_heap_insert(heap, node);
            ++total_count;
        }
    }


    c_huffman_initialize_table(table);
    c_huffman_build_tree(heap, &root);
    c_huffman_build_table(root, table, 0, 0);


    write_header(freq_arr, total_count, output_file);
    encode_bits(table, input_file, output_file);

    fclose(output_file);
	fclose(input_file);

	free(root->right);
	free(root->left);
	free(node);
	free(root);
    free(table);
    free(heap);

}
