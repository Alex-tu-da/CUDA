#include <stdio.h>

__global__ void square(int *A, int *B) {

    int id = blockIdx.x * blockDim.x + threadIdx.x;

    B[id] = A[id] * A[id];
}

int main() {

    int N = 8;

    int A[8] = {1,2,3,4,5,6,7,8};
    int B[8];

    int *d_A;
    int *d_B;

    cudaMalloc(&d_A, N*sizeof(int));
    cudaMalloc(&d_B, N*sizeof(int));

    cudaMemcpy(d_A, A, N*sizeof(int), cudaMemcpyHostToDevice);

    square<<<1,8>>>(d_A,d_B);

    cudaMemcpy(B, d_B, N*sizeof(int), cudaMemcpyDeviceToHost);

    cudaDeviceSynchronize();

    for(int i=0;i<N;i++)
        printf("%d^2 = %d\n",A[i],B[i]);

    cudaFree(d_A);
    cudaFree(d_B);

    return 0;
}