# CUDA-Grundlagen

Zwei kleine CUDA-Kernel-Beispiele zum Einstieg in GPU-Programmierung.

- **`hello.cu`**: Minimaler Kernel, der Thread-/Block-ID pro Thread ausgibt.
- **`main.cu`**: Elementweises Quadrieren eines Arrays auf der GPU
  (Host→Device-Kopie, Kernel-Aufruf, Device→Host-Kopie).

## Ausführen

```bash
nvcc hello.cu -o hello && ./hello
nvcc main.cu -o main && ./main
```

Benötigt eine NVIDIA-GPU mit installiertem CUDA-Toolkit.
