#ifndef HEAP_H
#define HEAP_H

#define MAX_HEAP_SIZE 256

typedef struct heap_node HeapNode;
struct heap_node {
	int frequency;
	char c;
	HeapNode *left;
	HeapNode *right;
};

typedef struct heap {
	int n;
	HeapNode a[MAX_HEAP_SIZE];
} Heap;

/**
 * Initializes the heap by filling its memory area with 0 bits.
 *
 * @param[in/out]  H     the heap space to initialize
 */
void heap_initialize(Heap *H);

/**
 * Removes a node from the heap <code>H</code> according to Algorithm 3.
 *
 * @param[in]      H     the heap
 * @param[out]     node  the node that was removed
 */
void heap_remove(Heap *H, HeapNode *node);

/**
 * Inserts the <code>node</code> into the heap <code>H</code> according to
 * Algorithm 2.
 *
 * @param[in]      H     the heap
 * @param[in]      node  the node to insert
 */
void heap_insert(Heap *H, HeapNode *node);

#endif

/* vim: textwidth=80 tabstop=4:
 */
