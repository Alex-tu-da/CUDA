#include <stdio.h>

__global__ void helloCUDA() {

    int threadId = threadIdx.x;
    int blockId = blockIdx.x;

    printf("Hallo von Thread %d im Block %d\n", threadId, blockId);
}

int main() {

    int threadsPerBlock = 8;
    int blocks = 2;

    helloCUDA<<<blocks, threadsPerBlock>>>();

    cudaDeviceSynchronize();

    return 0;
}