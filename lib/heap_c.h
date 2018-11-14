#ifndef C_HEAP_H
#define C_HEAP_H

#include "heap.h"

void c_show_heap(Heap *h);
void c_heap_initialize(Heap *H);
void c_heap_remove(Heap *H, HeapNode *node);
void c_heap_insert(Heap *H, HeapNode *node);

#endif
