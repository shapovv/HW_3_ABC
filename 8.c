#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>
#define MAX_I 100000
 
 
static int count=0;
 
double f (double x){
    count++;
    return x*x*x*x*x-x-0.2;
}

int chord_method (double (*f)(double), double a, double b, double eps, double *x){
    double fa, fb;
    int i;
    for (i=0; i < MAX_I; i++){
            if (fabs(b - a) < eps) break;
            fa = f(a); fb = f(b);
            a = b - (b-a)*fb / (fb - fa);
            b = a - (a-b)*fa / (fa - fb);
        }
    if (i < MAX_I){
            *x = b;
            return count;
        }
    return -1;
}
 
int main(int argc, char *argv[]) {
  if((argc != 2) && (argc != 4)&& (argc != 3)){
    printf("Incorrect input, check README.md\n");
    return 0;
  }
  clock_t start, end;
  if(strcmp(argv[1], "-h") == 0){
    printf("\n-h help\n");
    printf("-f use numbers from first file and save result in second file\n");
    printf("-s take numbers from terminal and print result in file\n");
  }
  else if(strcmp(argv[1], "-f") == 0){
    if(argc != 4){
      printf("Incorrect input, check README.md\n");
      return 0;
    }
    FILE *input = fopen(argv[2], "r");
    FILE *out = fopen(argv[3], "w");
    if((input == NULL) || (out == NULL)){
      printf("incorrect file\n");
      return 0;
    }
    double a, b, eps, x;
    start = clock(); 
    fscanf(input, "%lf", &a);
    fscanf(input, "%lf", &b);
    fscanf(input, "%lf", &eps);
    if ( chord_method(f, a, b, eps, &x) > 0 ) fprintf(out, "Root: %lf\nIterations: %d\n", x, count);
    else fprintf(out, "I cant find root:(\n");
    end = clock();
    double t = (double)(end-start)/(CLOCKS_PER_SEC);
    fprintf(out, "time: %.6lf\n",t);
    fclose(input);
    fclose(out);
  }
  else if((strcmp(argv[1], "-s") == 0)){
    if(argc != 3){
      printf("Incorrect input, check README.md\n");
      return 0;
    }
    FILE *out = fopen(argv[2], "w");
    if((out == NULL)){
      printf("incorrect file\n");
      return 0;
    }
    double a, b, eps, x;
    start = clock(); 
    scanf("%lf", &a);
    scanf("%lf", &b);
    scanf("%lf", &eps);
    if ( chord_method(f, a, b, eps, &x) > 0 ) fprintf(out, "Root: %lf\nIterations: %d\n", x, count);
    else fprintf(out, "I cant find root:(\n");
    end = clock();
    double t = (double)(end-start)/(CLOCKS_PER_SEC);
    fprintf(out, "time: %.6lf\n", t);
    fclose(out);
  }
  return 0;
}

