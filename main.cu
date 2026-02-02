#include <cstdio>
#include <cuda_runtime.h>

__global__ void kernel() {

    // Lokale Thread-Koordinaten im Block
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int tz = threadIdx.z;

    // Block-Koordinaten im Grid
    int bx = blockIdx.x;
    int by = blockIdx.y;
    int bz = blockIdx.z;   // hier immer 0, da grid.z = 1

    // Dimensionen
    int bdx = blockDim.x;
    int bdy = blockDim.y;
    int bdz = blockDim.z;

    int gdx = gridDim.x;
    int gdy = gridDim.y;

    // Globaler 3D-Index (optional, für Verständnis)
    int global_x = bx * bdx + tx;
    int global_y = by * bdy + ty;
    int global_z = tz;  // da nur eine Grid-Ebene in z

    // Ausgabe (nur für Demo – in Praxis vermeiden!)
    printf(
        "Block(%d,%d,%d) Thread(%d,%d,%d) -> Global(%d,%d,%d)\n",
        bx, by, bz,
        tx, ty, tz,
        global_x, global_y, global_z
    );
}

int main() {

    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, 0);

    printf("SMs: %d\n", prop.multiProcessorCount);
    printf("Max threads per SM: %d\n",
        prop.maxThreadsPerMultiProcessor);


    // Grid: 4 x 3 Blocks
    dim3 gridDim(4, 3);

    // Block: 4 x 4 x 3 Threads
    dim3 blockDim(4, 4, 3);

    kernel<<<gridDim, blockDim>>>();
    cudaDeviceSynchronize();

    return 0;
}
