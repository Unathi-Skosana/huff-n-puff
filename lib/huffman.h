#ifndef HUFFMAN_H
#define HUFFMAN_H

#include "heap.h"

typedef struct huffman_node {
	int huffman_code;
	int bit_size;
} HuffmanNode;

/**
 * Builds a Huffman tree <code>t</code> by consuming the minheap <code>h</code>.
 * Uses Algorithm 1, but does not construct the minheap of character
 * frequencies; instead the minheap is passed as <code>h</code>.
 *
 * @param[in/out] h     the minheap constructed to character frequencies
 * @param[out]    t     the root of the Huffman tree
 */
void huffman_build_tree(Heap *h, HeapNode **t);

/**
 * Initializes the Huffman table by filling its memory area with 1 bits.  This
 * function assumes that its called has already allocated space for
 * <code>t</code> by a call to <code>malloc</code>.  It uses <code>malloc</code>
 * to allocate space for heap nodes.
 *
 * @param[in/out] t     a pointer to the space allocated for the Huffman table
 */
void huffman_initialize_table(HuffmanNode *t);

/**
 * Builds the Huffman table by recursively visiting nodes in-order in a Huffman
 * tree, as described in Section 2.2.
 *
 * @param[in]     root  the current node to visit; to be called from the main
 *                      routine with a Huffman tree built by
 *                      <code>huffman_build_tree</code>
 * @param[in/out] t     the Huffman table (an array)
 * @param[in]     code  the partial bitstring, determined by the left-right 1-0
 *                      label of the Huffman tree traversal; to be called from
 *                      the main routine with <code>0</code>
 * @param[in]     size  the current length of the bitstring; to be called from
 *                      the main routine with <code>0</code>
 */
void huffman_build_table(HeapNode *root, HuffmanNode *t, int code, int size);

#endif

/* vim: textwidth=80 tabstop=4:
 */
