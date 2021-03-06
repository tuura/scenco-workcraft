#ifndef __PERMUTATIONS_H__
#define __PERMUTATIONS_H__

#if defined(__linux) || defined(__APPLE__)
	#include "config.h"
#else
	#include "D:\Projects\SCENCO\inc\config.h"
#endif

void permutation_stdalgo(int, int);
void permutation(int*,int,int*,int, int);
void rand_permutation(int, int);
void best_permutations(int, int,int);
void same_perm(int);
void rand_permutations_constraints_v2(int,int,int);

#endif
