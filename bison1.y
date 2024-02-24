// Header files and global variable declarations
%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
extern int flag3;
extern int flag4;
extern int flag5;
extern int flag6;
%}

// Token definitions
%token ALPHANUMERIC COMMENT_BEGIN COMMENT_END COMMENT_CONTENT OTHER WRAP MATCH
%token LINEAR_LAYOUT RELATIVE_LAYOUT EQU NUMBER
%token OPEN_LINEAR_LAYOUT CLOSE_LINEAR_LAYOUT
%token OPEN_RELATIVE_LAYOUT 
%token CLOSE_RELATIVE_LAYOUT
%token OPEN_RADIO_GROUP CLOSE_RADIO_GROUP
%token OPEN_RADIO_BUTTON
%token TEXT_VIEW IMAGE_VIEW BUTTON PROGRESS_BAR
%token ANDROID_LAYOUT_WIDTH ANDROID_LAYOUT_HEIGHT ANDROID_ID 
%token ANDROID_ORIENTATION ANDROID_TEXT ANDROID_TEXT_COLOR
%token ANDROID_SRC ANDROID_PADDING ANDROID_MAX ANDROID_PROGRESS 
%token ANDROID_CHECKED_BUTTON ANDROID_NUMBER_BUTTONS
%token CLOSE CLOSE2

// Type definitions for semantic values
%type <name> ALPHANUMERIC
%type <number> NUMBER

// Union definition for semantic values
%union {
	char name[100];
	int number;
}

%%

// Starting symbol of the program
program: layout
		;
		
// Represents a layout (either linear or relative)
layout: linear_layout 
	| relative_layout
	;
		
// Represents a linear layout
linear_layout:
    OPEN_LINEAR_LAYOUT linear_layout_attributes CLOSE content CLOSE_LINEAR_LAYOUT  
    ;

// Represents a relative layout
relative_layout:
    OPEN_RELATIVE_LAYOUT layout_attributes CLOSE content CLOSE_RELATIVE_LAYOUT  
	| OPEN_RELATIVE_LAYOUT layout_attributes CLOSE CLOSE_RELATIVE_LAYOUT  
    ;

// Represents the attributes of a linear layout
linear_layout_attributes:
    android_layout_width 
	android_layout_height 
	android_id_orientation_optional
    ;

// Represents the width attribute of an Android layout
android_layout_width:
	ANDROID_LAYOUT_WIDTH WRAP
	| ANDROID_LAYOUT_WIDTH MATCH
	| ANDROID_LAYOUT_WIDTH NUMBER
	;
	
// Represents the height attribute of an Android layout
android_layout_height:
	ANDROID_LAYOUT_HEIGHT WRAP
	| ANDROID_LAYOUT_HEIGHT MATCH
	| ANDROID_LAYOUT_HEIGHT NUMBER
	;
	
// Represents the optional attributes of an Android linear layout (ID and orientation)
android_id_orientation_optional:
     // Empty
     | ANDROID_ID ALPHANUMERIC 
	  ANDROID_ORIENTATION ALPHANUMERIC
	 | ANDROID_ORIENTATION ALPHANUMERIC
	  ANDROID_ID ALPHANUMERIC 
	 | ANDROID_ORIENTATION ALPHANUMERIC
	 | ANDROID_ID ALPHANUMERIC 
    ;

// Represents the attributes of a layout (either linear or relative)
layout_attributes:
    android_layout_width
    android_layout_height
	|
	android_layout_width
    android_layout_height
    ANDROID_ID ALPHANUMERIC  
    ;
	
// Represents the content within a layout
content:
     // Empty
     | element content
    ;

// Represents an element within a layout
element:
    TEXT_VIEW text_view_attributes CLOSE2 
    | IMAGE_VIEW image_view_attributes CLOSE2 
    | BUTTON button_attributes CLOSE2 
    | PROGRESS_BAR progressbar_attributes CLOSE2 
    | OPEN_RADIO_GROUP radio_group_attributes CLOSE radio_button CLOSE_RADIO_GROUP 
	| relative_layout	
    ;

// Represents a radio button within a radio group
radio_button:
	// Empty
	| OPEN_RADIO_BUTTON radio_button_attributes CLOSE2 radio_button
	;
	
// Represents the optional ID and text color attributes of an Android view
android_id_color_optional:
     // Empty
     | ANDROID_ID ALPHANUMERIC
	  ANDROID_TEXT_COLOR ALPHANUMERIC 
	 | ANDROID_TEXT_COLOR ALPHANUMERIC
	  ANDROID_ID ALPHANUMERIC 
     | ANDROID_ID ALPHANUMERIC
	 | ANDROID_TEXT_COLOR ALPHANUMERIC
    ;
	
// Represents the attributes of a text view
text_view_attributes:
    android_layout_width
    android_layout_height
    ANDROID_TEXT ALPHANUMERIC  
    android_id_color_optional
	| android_layout_width
     android_layout_height
	 android_id_color_optional
     ANDROID_TEXT ALPHANUMERIC  	
    ;
		
// Represents the optional ID and padding attributes of an Android view
android_id_padding_optional:
     // Empty
     | ANDROID_ID ALPHANUMERIC 
	  ANDROID_PADDING NUMBER
	 | ANDROID_PADDING NUMBER
	  ANDROID_ID ALPHANUMERIC
	 | ANDROID_ID ALPHANUMERIC
	 | ANDROID_PADDING NUMBER
    ;
	
// Represents the attributes of an image view
image_view_attributes:
    android_layout_width
    android_layout_height
    ANDROID_SRC ALPHANUMERIC 
    android_id_padding_optional 
    ;
	
// Represents the attributes of a button
button_attributes:
    android_layout_width
    android_layout_height
    ANDROID_TEXT ALPHANUMERIC  
    android_id_padding_optional
    ;
	
// Represents the optional ID and max attributes of a progress bar
android_id_max_optional:
     // Empty
     | ANDROID_ID ALPHANUMERIC 
	  ANDROID_MAX NUMBER
	 | ANDROID_MAX NUMBER
	  ANDROID_ID ALPHANUMERIC
	 | ANDROID_ID ALPHANUMERIC
	 | ANDROID_MAX NUMBER
    ;

// Represents the optional ID, max, and progress attributes of a progress bar
android_id_max_progress_optional:  
    // Empty
    | android_id_max_optional  
    ANDROID_PROGRESS NUMBER
    | ANDROID_PROGRESS NUMBER
    android_id_max_optional
    | ANDROID_PROGRESS NUMBER
    | android_id_max_optional 
    ;
	
// Represents the attributes of a progress bar
progressbar_attributes:
    android_layout_width 
	android_layout_height  
	android_id_max_progress_optional
    ;

// Represents the optional ID and checked button attributes of a radio group
android_id_checked_optional:
     // Empty
     | ANDROID_ID ALPHANUMERIC 
	ANDROID_CHECKED_BUTTON ALPHANUMERIC
	| ANDROID_CHECKED_BUTTON ALPHANUMERIC
	ANDROID_ID ALPHANUMERIC
	| ANDROID_ID ALPHANUMERIC
	| ANDROID_CHECKED_BUTTON ALPHANUMERIC
    ;
	
// Represents the attributes of a radio group
radio_group_attributes:
    android_layout_width
    android_layout_height
	ANDROID_NUMBER_BUTTONS NUMBER	
    android_id_checked_optional
    ;
	
// Represents the attributes of a radio button
radio_button_attributes:
	android_layout_width
    android_layout_height
    ANDROID_TEXT ALPHANUMERIC  
	| android_layout_width
    android_layout_height
    ANDROID_TEXT ALPHANUMERIC 
    ANDROID_ID ALPHANUMERIC  
	| android_layout_width
    android_layout_height
	ANDROID_ID ALPHANUMERIC
    ANDROID_TEXT ALPHANUMERIC 
    ;

%%

// Global variable to track if there is an error
int has_error = 0;

// Main function
int main(int argc, char *argv[]) {
    // Open the input file for reading
    yyin = fopen(argv[1], "r");
    // Start the parsing process
    yyparse();

    if (has_error == 0) {
        printf("\n\nSuccessful parsing\n");
    }
    
    return 0;
}

// Error handling function
void yyerror(char *s) {
    // Print the syntax error message along with the line number
	if(flag5==1 && flag6==1 && flag4==1 && flag3==0){printf("\nThe element android:numberButtons is missing!\n"); yylineno--;}
    fprintf(stderr, "Syntax ERROR on line %d which is shown below:\n", yylineno, s);
    has_error = 1;
}
