#ifndef TS_H
#define TS_H

#define NAME_LEN 64
#define CODE_LEN 32
#define TYPE_LEN 16
#define VAL_LEN 64

typedef struct Symbol {
    char name[NAME_LEN];
    char code[CODE_LEN];   
    char type[TYPE_LEN];  
    char value[VAL_LEN];   
    struct Symbol *next;
} Symbol;

typedef Symbol TS;

TS* ts_create();
Symbol* ts_find(const char *name, TS* head);
int ts_insert_symbol(const char *name, const char *code, const char *type, const char *value, TS* head);
int ts_insert_var_with_type(const char *name, const char *type, TS* head);
int ts_insert_const(const char *value, const char *type, TS* head);

void ts_print(TS* head);
void ts_free(TS* head);

#endif
