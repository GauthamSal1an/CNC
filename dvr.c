#include<stdio.h>

struct node{
    int dist[20];
    int from[20];
}rt[10];

int main(){
    int dmat[20][20];
    int n, i, j, k, count = 1;

    printf("Enter the number of nodes: ");
    scanf("%d", &n);

    printf("Enter the cost matrix: ");
    for (i = 0; i < n; i++){
        for (j = 0; j < n; j++){
            scanf("%d", &dmat[i][j]);
            dmat[i][i] = 0;
            r[i].dist[j] = dmat[i][j];
            r[i].from[j] = j;
        }
    }

    do{
        for (i=0; i < n; i++){
            for (j=0; j < n; j++){
                for (k=0; k < n; k++){
                    if (rt[i].dist[j] > dmat[i][k] + dmat[k][j]){
                        rt[i].dist[j] = dmat[i][k] + dmat[k][j];
                        rt[i].from[j] = k;
                    }
                }
            }
        }
        count++;
    }while(count < n);

    for (i = 0; i < n; i++){
        printf("Distance table for router %c is");
        for (j = 0; j < n; j++){
            printf("Node %d via %d Distance %d\n", j, rt[i].from[j], rt[i].dist[j]);
        }
    }
}