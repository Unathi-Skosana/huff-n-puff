#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "../lib/heap_c.h"

void c_heap_initialize(Heap *H)
{
  int i;

  H->n = 0;
  for (i = 0; i < MAX_HEAP_SIZE; i++) {
    H->a[i].frequency = 0;
    H->a[i].c = 0;
    H->a[i].left = NULL;
    H->a[i].right = NULL;
  }
}

void c_heap_insert(Heap *H, HeapNode *node)
{
  int c, p;
  HeapNode temp;

  c = H->n;
  p = (c - 1)/2;
  H->a[c] = *node;
  while (p >= 0) {
    if ((H->a[p].frequency) > (H->a[c].frequency)) {
      temp = H->a[p];
      H->a[p] = H->a[c];
      H->a[c] = temp;
      c = p;
      p = (c - 1) / 2;
    } else {
      p = -1;
    }
  }
  H->n++;
}

void c_heap_remove(Heap *H, HeapNode *node)
{
  int p, c, n;
  HeapNode temp;

  n = H->n;

  if (n >= 0) {
    *node = H->a[0];
    H->a[0] = H->a[n - 1];
    n--;
    p = 0;
    c = 2 * p + 1;
    while (c <= n - 1) {
      if (H->a[c].frequency >= H->a[c + 1].frequency) {
        c++;
      }

      if (H->a[c].frequency <= H->a[p].frequency) {
        temp = H->a[p];
        H->a[p] = H->a[c];
        H->a[c] = temp;
        p = c;
        c = 2 * p + 1;
      } else {
        c = n;
      }
    }
  }

  H->n = n;
}
