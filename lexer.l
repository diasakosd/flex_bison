%{
// Header files and global variable declarations
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include "bison1.tab.h"

#define MAX_SIZE 5000  // Maximum number of elements in the array
#define MAX_LENGTH 100  // Maximum length of each alphanumeric element
// Function prototypes
void showError();
void print_token(int token_id);
int check_numbers(int count,int numbers);
float extract_number(const char* str);
bool is_float_integer(float num);
int idExists(const char id_array[][MAX_LENGTH], const char* id, int size);

int flag=0;
int flag1=0;
int flag2=0;
int flag3=0;
int flag4=0;
int flag5=0;
int flag6=0;
int count=0;
int numbers=0;
int max=0;
char id_array[MAX_SIZE][MAX_LENGTH];
int size = 0; 
int sizebutton = 0; 
char checked_button[MAX_LENGTH];
char idbuttons[MAX_SIZE][MAX_LENGTH];


%}

%option noyywrap

string ["]([^"\\\r\n]|\\(.|\n))*

/* Start conditions */
%x COMMENT

%%

"<!--"      { BEGIN(COMMENT); printf("%s",yytext);}
<COMMENT>"-->"    { BEGIN(INITIAL); printf("%s",yytext);}
<COMMENT>[^-]+   { /* Ignore comment content */ printf("%s",yytext);}

"<LinearLayout" {printf("%s",yytext);return OPEN_LINEAR_LAYOUT;}
"<RelativeLayout" {printf("%s",yytext);return OPEN_RELATIVE_LAYOUT;}
"</LinearLayout>" {printf("%s",yytext);return CLOSE_LINEAR_LAYOUT;}
"</RelativeLayout>" {printf("%s",yytext);return CLOSE_RELATIVE_LAYOUT;}
"<TextView" {printf("%s",yytext);return TEXT_VIEW;}
"<ImageView" {printf("%s",yytext);return IMAGE_VIEW;}
"<RadioGroup" {flag4=1;printf("%s",yytext);return OPEN_RADIO_GROUP;}
"<Button" {printf("%s",yytext);return BUTTON;}	
"<ProgressBar" {printf("%s",yytext);return PROGRESS_BAR;}
"<RadioButton" {flag1 = 1; count++; printf("%s",yytext);return OPEN_RADIO_BUTTON;}
"</RadioGroup>" { if(check_numbers(count,numbers)==1){ 
                  printf("ERROR: Wrong number of Buttons\n");
                  return CLOSE2;
                 }
                 if (idExists(idbuttons, checked_button, sizebutton)==0 && flag2==1){
                  printf("ERROR: The value should correspond to one of the values received by the android:id elements of the nested <RadioButton/> elements.\n");
                  flag1 = 0;
                  for (int i = 0; i < MAX_SIZE; ++i) {
                   memset(idbuttons[i], '\0', sizeof(idbuttons[i]));
                  }
                  return CLOSE2;
                 }printf("%s",yytext);
                 flag2=0;
				 flag3=0;
				 flag4=0;
				 flag5=0;
				 flag6=0;
                 count=0;
                 return CLOSE_RADIO_GROUP;}
"android:layout_width=" {flag=6; flag5=1; printf("%s",yytext);return ANDROID_LAYOUT_WIDTH;}
"android:layout_height=" {flag=6; flag5=1; printf("%s",yytext);return ANDROID_LAYOUT_HEIGHT;}
"android:numberButtons=" {flag=1; flag3=1;printf("%s",yytext);return ANDROID_NUMBER_BUTTONS;}
"android:id=" {flag=4; ;printf("%s",yytext);return ANDROID_ID;}
"android:text=" {flag=0;printf("%s",yytext);return ANDROID_TEXT;}
"android:textColor=" {flag=0;printf("%s",yytext);return ANDROID_TEXT_COLOR;}
"android:src=" {flag=0;printf("%s",yytext);return ANDROID_SRC;}
"android:padding=" {flag=1;printf("%s",yytext);return ANDROID_PADDING;}
"android:max=" {flag=2;printf("%s",yytext);return ANDROID_MAX;}
"android:progress=" {flag=3;printf("%s",yytext);return ANDROID_PROGRESS;}
"android:orientation=" {flag=0;printf("%s",yytext);return ANDROID_ORIENTATION;}
"android:checkedButton=" {flag=5; flag2=1;printf("%s",yytext);return ANDROID_CHECKED_BUTTON;} 
["]wrap_content["] {flag=0; flag6=1;printf("%s",yytext);return WRAP;} 
["]match_parent["] {flag=0; flag6=1;printf("%s",yytext);return MATCH;} 
[ \t]+ {printf("%s",yytext);}
[\r\n]+ {printf("%s",yytext); yylineno++;}




{string}["] { 
    if(flag==1){
        float num = extract_number(yytext); 
         if(num>0 && is_float_integer(num)){
            numbers=num;
            printf("%s", yytext);
            return NUMBER;
            }else{
                printf("\nERROR: Attribute Should be a Positive Integer Number\n");
                return CLOSE;
            }
    } else if (flag==2){
           float num = extract_number(yytext); 
           if(num>0 && is_float_integer(num)){
           max=num;
            printf("%s", yytext);
            return NUMBER;
            }else{
                printf("\n ERROR: Max Should be a Positive Integer Number\n");
                return CLOSE;
            }
    } else if (flag==3){
            float num = extract_number(yytext); 
            if(num>0 && num<=max && is_float_integer(num)){
            printf("%s", yytext);
            return NUMBER;
            }else{
                printf("\n ERROR: Progress Should be a Positive Integer Number smaller than the value given in Max \n");
            }return CLOSE;
    }else if (flag==4){

            if (idExists(id_array, yytext, size)==0) {
                strcpy(id_array[size], yytext);
                printf("%s",yytext);
                size++;
            } else{
                printf("\n ERROR: ID Already Exists \n");
                 return CLOSE; 
            }  

            if (flag1==0){
                return ALPHANUMERIC;
            }else if(flag1==1){
               strcpy(idbuttons[sizebutton], yytext);
               sizebutton++;
               return ALPHANUMERIC;
            }
                
    }else if (flag==5){
       strcpy(checked_button, yytext);
       printf("%s",yytext);
       return ALPHANUMERIC;
    }else if (flag==6){
       float num = extract_number(yytext); 
         if(num>0 && is_float_integer(num)){
            numbers=num;
            printf("%s", yytext);
            return NUMBER;
            }else{
                printf("\nERROR: Attribute Should be a Positive Integer Number or wrap_content or match_parent\n");
                return CLOSE;
            }
    }else{
        printf("%s",yytext); 
        return ALPHANUMERIC;
     } 

}
   
">" {printf("%s",yytext);return CLOSE;}
"/>" {printf("%s",yytext);return CLOSE2;}
. {printf("%s",yytext);return(OTHER);}
%%




int idExists(const char id_array[][MAX_LENGTH], const char* id, int size) {
    for (int i = 0; i < size; i++) {
        if (strcmp(id_array[i], id) == 0) {
            return 1;  // Element already exists
        }
    }
    return 0;  // Element does not exist
}

float extract_number(const char* str) {
    float num;
    int has_quotes = (str[0] == '"' && str[strlen(str) - 1] == '"');
    char* buf = strdup(has_quotes ? str + 1 : str);
    char* p = strchr(buf, ',');
    if (p) *p = '.';
    if (sscanf(buf, "%f", &num) != 1) {
        num = 0.0;
    }
    free(buf);
    return num;
}

bool is_float_integer(float num) {
    float int_part;
    float frac_part = modff(num, &int_part);
    return (frac_part == 0.0);
}


int check_numbers(int count,int numbers) 
{
  if (count!=numbers) 
  return 1;
  else
  return 0;
}