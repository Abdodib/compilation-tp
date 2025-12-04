typedef struct
{
int state;    
char name [20];
char code [20];
char type [20];
char val [20];
} TS1;

typedef struct 
{
int state;
char name [20];
char type [20];
}TS2;


typedef struct
{
    TS1 data;
    struct TS *next;
} TS;

typedef struct
{
    TS2 data;
    struct tabs *next;
} tabs;

typedef struct
{
    TS2 data;
    struct tabm *next;
} tabm;
