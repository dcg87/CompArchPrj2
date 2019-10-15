#ifndef FORMULA_H
#define FORMULA_H


int
nCr(int n, int r);
typedef struct Term
{
  int coefficient;
  int exponent;
  char variable;
}Term;
#endif
