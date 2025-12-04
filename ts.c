#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

int recherche(char entite[], TS* head)
{
    TS* p = head;
    int i = 0;
    while (p != NULL)
    {
        if (strcmp(entite, p->data.nomEntite) == 0)
            return i;
        p = p->next;
        i++;
    }
    return -1;
}

void inserer(char entite[], char code[], TS* head)
{
    if (recherche(entite, head) == -1)
    {
        TS* q = (TS*)malloc(sizeof(TS));
        strcpy(q->data.nomEntite, entite);
        strcpy(q->data.code, code);
        q->next = NULL;

        TS* p = head;
        while (p->next != NULL)
            p = p->next;

        p->next = q;
    }
}

void afficher(TS* head)
{
    printf("\n/*************** Table des symboles ******************/\n");
    printf("____________________________________\n");
    printf("\t| NomEntite |  CodeEntite  | \n");
    printf("____________________________________\n");
    TS* p = head->next;
    while (p != NULL)
    {
        printf("\t|%10s |%12s |\n", p->data.nomEntite, p->data.code);
        p = p->next;
    }
}
