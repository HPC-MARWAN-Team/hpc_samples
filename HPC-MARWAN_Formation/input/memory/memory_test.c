#include <stdio.h>
#include <stdlib.h>

int main() {
    // Début de l'allocation de mémoire
    while (1) {
        // Allouer 1 Mo de mémoire
        int* mem_block = (int*)malloc(1024 * 1024 * sizeof(int));
        
        // Vérifier si l'allocation a réussi
        if (mem_block == NULL) {
            printf("Memory allocation failed.\n");
            break;
        }
        
        // Initialiser la mémoire allouée
        for (int i = 0; i < 1024 * 1024; ++i) {
            mem_block[i] = i;
        }
        
        // Afficher un message pour montrer que l'allocation est en cours
        printf("Allocated 1 MB of memory.\n");
    }

    return 0;
}
