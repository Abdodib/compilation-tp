#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

TS* ts_create() {
    TS* head = (TS*)malloc(sizeof(TS));
    if (!head) { perror("malloc"); exit(1); }
    head->next = NULL;
    head->name[0] = '\0';
    head->code[0] = '\0';
    head->type[0] = '\0';
    head->value[0] = '\0';
    return head;
}

Symbol* ts_find(const char *name, TS* head) {
    Symbol* p = head->next;
    while (p) {
        if (strcmp(p->name, name) == 0) return p;
        p = p->next;
    }
    return NULL;
}

int ts_insert_symbol(const char *name, const char *code, const char *type, const char *value, TS* head) {
    if (ts_find(name, head) != NULL) return 0; // already exists
    Symbol* node = (Symbol*)malloc(sizeof(Symbol));
    if (!node) { perror("malloc"); exit(1); }
    strncpy(node->name, name, NAME_LEN-1); node->name[NAME_LEN-1] = '\0';
    strncpy(node->code, code, CODE_LEN-1); node->code[CODE_LEN-1] = '\0';
    if (type) { strncpy(node->type, type, TYPE_LEN-1); node->type[TYPE_LEN-1] = '\0'; } else node->type[0]='\0';
    if (value) { strncpy(node->value, value, VAL_LEN-1); node->value[VAL_LEN-1]='\0'; } else node->value[0]='\0';
    node->next = NULL;

    Symbol* p = head;
    while (p->next) p = p->next;
    p->next = node;
    return 1;
}

int ts_insert_var_with_type(const char *name, const char *type, TS* head) {
    return ts_insert_symbol(name, "IDF", type, "", head);
}

int ts_insert_const(const char *value, const char *type, TS* head) {
    char namebuf[VAL_LEN+8];
    snprintf(namebuf, sizeof(namebuf), "CONST_%s", value);
    return ts_insert_symbol(namebuf, "CONST", type, value, head);
}

void ts_print(TS* head) {
    printf("\n/*************** Table des symboles ******************/\n");
    printf("____________________________________________________\n");
    printf("| %-20s | %-8s | %-8s | %-10s |\n", "NomEntite", "Code", "Type", "Value");
    printf("____________________________________________________\n");
    Symbol* p = head->next;
    while (p) {
        printf("| %-20s | %-8s | %-8s | %-10s |\n",
               p->name, p->code, p->type[0] ? p->type : "-", p->value[0] ? p->value : "-");
        p = p->next;
    }
    printf("____________________________________________________\n");
}

void ts_free(TS* head) {
    Symbol* p = head;
    while (p) {
        Symbol* nxt = p->next;
        free(p);
        p = nxt;
    }
}
