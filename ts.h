#ifndef TS_H
#define TS_H

typedef struct {
    char nomEntite[20];
    char code[20];
} TS1;

typedef struct TS {
    TS1 data;
    struct TS *next;
} TS;

int recherche(char entite[], TS* head);
void inserer(char entite[], char code[], TS* head);
void afficher(TS* head);

#endif
