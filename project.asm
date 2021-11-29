; Scientific calculator
;******* MACRO *******
; this macro get character input without echo to AL
GETCH MACRO
mov ah, 7
int 21h
ENDM
; this macro prints a char in AL and advances
; the current cursor position:
PUTC MACRO char
push ax
mov al, char
mov ah, 0eh
int 10h
pop ax
ENDM
org 100h
precision = 30
.data
ten dw 10 ; used as multiplier/divider by SCAN_NUM & PRINT_NUM_UNS.
ToO db "Table of Operation:",0dh,0ah
db " Sum (+): 0",0dh,0ah
db " Sub (-): 1",0dh,0ah
db " Mul (*): 2",0dh,0ah
db " Div (/): 3",0dh,0ah
db " X^Y (^): 4",0dh,0ah
db " And (&): 5",0dh,0ah
db " Or (|): 6",0dh,0ah
db " XOR (^): 7",0dh,0ah
db " Not (~): 8",0dh,0ah
db " Sin (x): 9",0dh,0ah
db " Cos (x): 10",0dh,0ah
db " Tan (x): 11",0dh,0ah
db " Fact(!): 12",0dh,0ah
db " Sqr (^2): 13",0dh,0ah
db " Cube(^3): 14",0dh,0ah
db " BMI: 15",0dh,0ah
db " celsius to faranheit: 16",0dh,0ah
db "fahrenheit to celsius: 17",0dh,0ah  

db "f to k: 18",0dh,0ah    
db "c to k: 19",0dh,0ah    
db "k to c:20",0dh,0ah   
db "k to f:21",0dh,0ah  
db "m to cm:22",0dh,0ah 
db "m to km:23",0dh,0ah  
db "cm to m:24",0dh,0ah  

db "km to m:25",0dh,0ah 
db "gram to kilogram:26",0dh,0ah    

db "kilogram to gram:27",0dh,0ah     
db "kilogram to miligram:28",0dh,0ah 
db "gram to miligram:29",0dh,0ah  

db "km to cm:30",0dh,0ah,24h      






msg_wel db "********* SCIENTIFIC CALCULATOR *********",0dh,0ah
db "Note: It takes only integer number as input.",0dh,0ah
db "For trignometry, angle is in Degree unit.",0dh,0ah
db "For BMI, first number is weight in kilograms and second is Height in meters.",0dh,0ah,24h
msg_agn db "Press any key to use again or press E to exit.",0dh,0ah,24h
msg_bye db "Thank you for using the calculator.$"
msg_fn db "Enter first number: $" 
msg_mtcm db "enter the number in meters to get your result in centimeters:$" 
msg_mtkm db "enter the number in meters to get your result in kilometers:$"    
msg_cmtm db "enter the number in centimeters to get your result in meter:$" 
msg_kmtm db "enter the number in kilometer to get your result in meter:$"
msg_gtkg db "enter the number in gram to get your result in kilogram:$" 
msg_kgtg db "enter the number in kilogram to get your result in gram:$"
msg_kgtm db "enter the number in kilogram to get your result in miligram:$" 
msg_gtm db "enter the number in gram to get your result in miligram:$"            
msg_kmtcm db "enter the number in kilometer to get your result in centimeter:$" 
msg_ktf db "enter the number in kelvin to get your result in faranheit:$"  
msg_ktc db "enter the number in kelvin to get your result in celsius:$"    
msg_ctk db "enter the number in celsius to get your result in kelvin:$"                                                              
msg_ftk db "enter the number in faranheit to get your result in kelvin:$" 
msg_ftc db "enter the number in faranheit to get your result in celsius:$"      
msg_ctf db "enter the number in celsiust to get your result in faranheit:$"  
msg_sumf db "enter the first number to find sum:$"   
msg_sums db "enter the second number to find sum:$"    
msg_subf db "enter the first number to find differnce:$"   
msg_subs db "enter the second number to find differnce:$"
msg_mulf db "enter the first number to find product:$"   
msg_muls db "enter the second number to find product:$"  
msg_divf db "enter the first number to find division:$"   
msg_divs db "enter the second number to find division:$"    
msg_powf db "enter the first number to find power:$"   
msg_pows db "enter the second number to find power:$" 
msg_andf db "enter the first number to find AND:$"   
msg_ands db "enter the second number to find AND:$"    
msg_orf db "enter the first number to find OR:$"   
msg_ors db "enter the second number to find OR:$" 
msg_xorf db "enter the first number to find XOR:$"   
msg_xors db "enter the second number to find XOR:$"  
msg_notf db "enter a number to find NOT:$"    
msg_sinf db "enter tita value to find sin(x):$" 
msg_cosf db "enter tita value to find cos(x):$"  
msg_tanf db "enter tita value to find tan(x):$"  
msg_factf db "enter a number to find factorial:$"                                                    
                                                              
                                                                            
msg_sn db "Enter second number: $"
msg_on db "Enter the operation number [0-30]: $"
msg_r db "The result is: $"
msg_und db "Infinity.$"
msg_on_i db "Invalid operation number. See Table of Operation for more information.$"
operand1 dd ?
linefeed db 13, 10, "$"  
abc dd 100000
def dd ?
ghi dw ? 
abd dd 1000000

c dd ?
;KEL32FP  real4  273.15
operand2 dw ?
operator db ?
result dd ?,?,? ;store upto 32-bit
;lookup table for Trigonometric functions, made using excel, giving a formula and extending the table
sin dw 0000,0175,0349,0523,0698,0872,1045,1219,1392,1564,1736,1908,2079,2250,2419,2588,2756,2924,3090,3256,3420,3584,3746,3907,4067,4226,4384,4540,4695,4848,5000,5150,5299,5446,5592,5736,5878,6018,6157,6293,6428,6561,6691,6820,6947,7071,7193,7314,7431,7547,7660,7771,7880,7986,8090,8192,8290,8387,8480,8572
dw 8660,8746,8829,8910,8988,9063,9135,9205,9272,9336,9397,9455,9511,9563,9613,9659,9703,9744,9781,9816,9848,9877,9903,9925,9945,9962,9976,9986,9994,9998,0000,9998,9994,9986,9976,9962,9945,9925,9903,9877,9848,9816,9781,9744,9703,9659,9613,9563,9511,9455,9397,9336,9272,9205,9135,9063,8988,8910,8829,8746
dw 8660,8572,8480,8387,8290,8192,8090,7986,7880,7771,7660,7547,7431,7314,7193,7071,6947,6820,6691,6561,6428,6293,6157,6018,5878,5736,5592,5446,5299,5150,5000,4848,4695,4540,4384,4226,4067,3907,3746,3584,3420,3256,3090,2924,2756,2588,2419,2250,2079,1908,1736,1564,1392,1219,1045,0872,0698,0523,0349,0175
dw 0000,0175,0349,0523,0698,0872,1045,1219,1392,1564,1736,1908,2079,2250,2419,2588,2756,2924,3090,3256,3420,3584,3746,3907,4067,4226,4384,4540,4695,4848,5000,5150,5299,5446,5592,5736,5878,6018,6157,6293,6428,6561,6691,6820,6947,7071,7193,7314,7431,7547,7660,7771,7880,7986,8090,8192,8290,8387,8480,8572
dw 8660,8746,8829,8910,8988,9063,9135,9205,9272,9336,9397,9455,9511,9563,9613,9659,9703,9744,9781,9816,9848,9877,9903,9925,9945,9962,9976,9986,9994,9998,0000,9998,9994,9986,9976,9962,9945,9925,9903,9877,9848,9816,9781,9744,9703,9659,9613,9563,9511,9455,9397,9336,9272,9205,9135,9063,8988,8910,8829,8746
dw 8660,8572,8480,8387,8290,8192,8090,7986,7880,7771,7660,7547,7431,7314,7193,7071,6947,6820,6691,6561,6428,6293,6157,6018,5878,5736,5592,5446,5299,5150,5000,4848,4695,4540,4384,4226,4067,3907,3746,3584,3420,3256,3090,2924,2756,2588,2419,2250,2079,1908,1736,1564,1392,1219,1045,0872,0698,0523,0349,0175
tan dw 0,0000,0,0175,0,0349,0,0524,0,0699,0,0875,0,1051,0,1228,0,1405,0,1584,0,1763,0,1944,0,2126,0,2309,0,2493,0,2679,0,2867,0,3057,0,3249,0,3443,0,3640,0,3839,0,4040,0,4245,0,4452,0,4663,0,4877,0,5095,0,5317,0,5543
dw 0,5774,0,6009,0,6249,0,6494,0,6745,0,7002,0,7265,0,7536,0,7813,0,8098,0,8391,0,8693,0,9004,0,9325,0,9657,1,0000,1,0355,1,0724,1,1106,1,1504,1,1918,1,2349,1,2799,1,3270,1,3764,1,4281,1,4826,1,5399,1,6003,1,6643
dw 1,7321,1,8040,1,8807,1,9626,2,0503,2,1445,2,2460,2,3559,2,4751,2,6051,2,7475,2,9042,3,0777,3,2709,3,4874,3,7321,4,0108,4,3315,4,7046,5,1446,5,6713,6,3138,7,1154,8,1443,9,5144,11,4301,14,3007,19,0811,28,6363,57,2900
dw 65535,0000
.code
main PROC
mov ax,@data
mov ds,ax
call welcome
start_again:
xor ax,ax
mov result,ax
mov [result+2],ax
mov [result+4],ax
call print_ToO

call input_operator
;checks for unary operator
mov al,operator
cmp al,8
je c8
cmp al,9
je c9
cmp al,10
je c10
cmp al,11
je c11
cmp al,12
je c12
cmp al,13
je c13
cmp al,14
je c14   
cmp al,16
je c16 
cmp al,17
je c17   
cmp al,18
je c18 
cmp al,19
je c19
cmp al,20
je c20
cmp al,21
je c21
cmp al,22
je c22
cmp al,23
je c23   
cmp al,24
je c24
cmp al,25
je c25
cmp al,26
je c26
cmp al,27
je c27 
cmp al,28
je c28 
cmp al,29
je c29 
cmp al,30
je c30



binary_operator:

;checks for binary operator
mov al,operator
cmp al,0
je c0
cmp al,1
je c1
cmp al,2
je c2
cmp al,3
je c3
cmp al,4
je c4
cmp al,5
je c5
cmp al,6
je c6
cmp al,7
je c7
cmp al,15
je c15
c0:    

call input_opsum1
call input_opsum2
call addition
jmp ans
c1:        
call input_opsub1
call input_opsub2
call substract
jmp ans
c2:     
call input_opmul1
call input_opmul2
call multiply
jmp ans
c3:    
call input_opdiv1
call input_opdiv2
call divide
jmp ans
c4:       
call input_oppow1
call input_oppow2
call power
jmp ans
c5:     
call input_opand1
call input_opand2
call anding
jmp ans
c6:    
call input_opor1
call input_opor2
call oring
jmp ans
c7:   
call input_opxor1
call input_opxor2
call xoring
jmp ans
c8:   
call input_opnot1
call complement
jmp ans
c9:   
call input_opsin1
call sine
jmp ans
c10:
call input_opcos1
call cosine
jmp ans
c11:    
call input_optan1
call tangent
jmp ans
c12:     
call input_opfact1
call factorial
jmp ans
c13: 
call input_op1
mov cx,2
mov operand2, cx
call power
jmp ans
c14:      
call input_op1
mov cx,3
mov operand2, cx
call power
jmp ans
c15:      
call input_op1
call input_op2
call bmi
jmp ans 
c16:
call input_opctf
call cf
jmp ans
c17:   
call input_opftc
call fc
jmp ans   
c18:  
call input_opftk
call fk
jmp ans 
c19:  
call input_opctk
call ck
jmp ans
c20:  
call input_opktc
call kc
jmp ans
c21: 
call input_opktf
call kf
jmp ans 
c22:   
call input_opmtcm
call mtcm
jmp ans
c23:  
call input_opmtkm
call mtkm
jmp ans
c24:  
call input_opcmtm
call cmtm
jmp ans

c25:    
call input_opkmtm
call kmtm
jmp ans 
c26: 
call input_opgtkg
call gtkg
jmp ans
c27:     
call input_opkgtg
call kgtg
jmp ans
c28: 
call input_opkgtm
call kgtm     
jmp ans
c29: 
call input_opgtm
call gtm
jmp ans

c30:   
call input_opkmtcm
call kmtcm     
jmp ans  


ans:
call print_result
GETCH
cmp al,'e'
je exit
cmp al,'E'
je exit
jmp start_again
exit:
call good_bye
;Exit the program
mov ax,4c00h
int 21h
main endp
;******** Procedures ********

welcome PROC
mov dx, offset msg_wel
mov ah, 9
int 21h
ret
welcome endp
good_bye PROC
call new_line
mov dx, offset msg_bye
mov ah, 9
int 21h
ret
good_bye endp
;function to print table of operation
print_ToO PROC
call new_line
mov dx, offset ToO
mov ah, 9
int 21h
ret
print_ToO endp
print_result PROC
call new_line   
mov dx, offset msg_r
mov ah, 9
int 21h  
;call    print_float 
cmp operator,9
jl r_simple
cmp operator,15
je r_simple     

cmp [result+4],1
jne r_simple
PUTC '-'
r_simple: ;simple result
mov ax, result
cmp ax,65535
jne r_num
cmp operator,11
jne r_num
;print infinity only if tan(90)
mov dx, offset msg_und
mov ah, 9
int 21h
jmp r_done
r_num:
call print_num
cmp [result+2],0
je r_done
PUTC '.'
mov ax,[result+2]
cmp ax,999
jg r_dec
cmp operator,9
jl r_dec
cmp operator,15
je r_dec
PUTC '0'
r_dec:
call print_num
r_done:
call new_line
mov dx, offset msg_agn
mov ah, 9
int 21h
ret
print_result endp
;function to move cursor to new line
new_line PROC
putc 0Dh
putc 0Ah
ret
new_line endp
;function to input first operand
input_op1 PROC
call new_line
mov dx, offset msg_fn
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_op1 endp  


            
input_opsum1 PROC
call new_line
mov dx, offset msg_sumf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opsum1 endp   

input_opsin1 PROC
call new_line
mov dx, offset msg_sinf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opsin1 endp  

input_opcos1 PROC
call new_line
mov dx, offset msg_cosf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opcos1 endp  

input_opfact1 PROC
call new_line
mov dx, offset msg_factf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opfact1 endp 

input_optan1 PROC
call new_line
mov dx, offset msg_tanf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_optan1 endp    

input_opsum2 PROC
call new_line
mov dx, offset msg_sums
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opsum2 endp    

            
input_opand1 PROC
call new_line
mov dx, offset msg_andf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opand1 endp    

input_opand2 PROC
call new_line
mov dx, offset msg_ands
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opand2 endp    

input_opor1 PROC
call new_line
mov dx, offset msg_orf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opor1 endp    

input_opor2 PROC
call new_line
mov dx, offset msg_ors
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opor2 endp      

input_opxor1 PROC
call new_line
mov dx, offset msg_xorf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opxor1 endp 

input_opnot1 PROC
call new_line
mov dx, offset msg_notf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opnot1 endp    

input_opxor2 PROC
call new_line
mov dx, offset msg_xors
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opxor2 endp  


input_opsub1 PROC
call new_line
mov dx, offset msg_subf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opsub1 endp    

input_opsub2 PROC
call new_line
mov dx, offset msg_subs
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opsub2 endp  
                   
input_opmul1 PROC
call new_line
mov dx, offset msg_mulf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opmul1 endp    

input_opmul2 PROC
call new_line
mov dx, offset msg_muls
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opmul2 endp  

input_opdiv1 PROC
call new_line
mov dx, offset msg_divf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opdiv1 endp    

input_opdiv2 PROC
call new_line
mov dx, offset msg_divs
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_opdiv2 endp       

input_oppow1 PROC
call new_line
mov dx, offset msg_powf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_oppow1 endp    

input_oppow2 PROC
call new_line
mov dx, offset msg_pows
mov ah, 9
int 21h
call scan_num
mov operand2, cx
mov def,cx
ret
input_oppow2 endp  

input_opmtcm PROC
call new_line
mov dx, offset msg_mtcm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opmtcm endp 

input_opgtm PROC
call new_line
mov dx, offset msg_gtm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opgtm endp 

input_opktf PROC
call new_line
mov dx, offset msg_ktf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opktf endp      

input_opftc PROC
call new_line
mov dx, offset msg_ftc
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opftc endp  

input_opctf PROC
call new_line
mov dx, offset msg_ctf
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opctf endp
                      
  

input_opktc PROC
call new_line
mov dx, offset msg_ktc
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opktc endp   

input_opctk PROC
call new_line
mov dx, offset msg_ctk
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opctk endp   

input_opkmtcm PROC
call new_line
mov dx, offset msg_kmtcm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opkmtcm endp 

input_opkgtg PROC
call new_line
mov dx, offset msg_kgtg
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opkgtg endp     

input_opkgtm PROC
call new_line
mov dx, offset msg_kgtm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opkgtm endp  

input_opgtkg PROC
call new_line
mov dx, offset msg_gtkg
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opgtkg endp

input_opkmtm PROC
call new_line
mov dx, offset msg_kmtm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opkmtm endp   

input_opftk PROC
call new_line
mov dx, offset msg_ftk
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opftk endp  

input_opcmtm PROC
call new_line
mov dx, offset msg_mtcm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opcmtm endp

input_opmtkm PROC
call new_line
mov dx, offset msg_mtkm
mov ah, 9
int 21h
call scan_num
mov operand1, cx
mov def,cx
ret
input_opmtkm endp
;function to input second operand
input_op2 PROC
call new_line
mov dx, offset msg_sn
mov ah, 9
int 21h
call scan_num
mov operand2, cx
ret
input_op2 endp 

;function to input operator
input_operator PROC
call new_line
mov dx, offset msg_on
mov ah, 9
int 21h
call scan_num
mov operator, cl
cmp cl,34 ;change
jb return_io
call new_line
mov dx, offset msg_on_i
mov ah, 9
int 21h
call input_operator
return_io:
ret
input_operator endp

;function to add two operand
;and store in result variable
addition PROC
mov ax,operand1
add ax,operand2
mov result,ax
ret
addition endp
;function to subtract two operand
;and store in result variable
substract PROC
mov ax,operand1
sub ax,operand2
mov result,ax
ret
substract endp
;function to calculate product of two operand
;and store in result variable
multiply PROC
mov ax,operand1
imul operand2
mov result,ax
ret
multiply endp
;function to divide of two operand
;and store in result variable
divide PROC
xor dx,dx
mov ax,operand1
idiv operand2
mov result,ax
cmp dx,0
je div_r
mov ax,dx
mov bx,10
mul bx
idiv operand2
mov [result+2],ax
div_r:
ret
divide endp
;function to calculate exponent of two operand
;and store in result variable
power PROC
mov ax,operand1
mov cx,operand2
cmp cx,0
je power_sc
power_l:
dec cx
cmp cx,1
jl power_r
imul operand1
jmp power_l
power_sc:
mov ax,1
power_r:
mov result,ax
ret
power endp
;function to find AND of two operand
;and store in result variable
anding PROC
mov ax,operand1
and ax,operand2
mov result,ax
ret
anding endp
;function to find OR of two operand
;and store in result variable
oring PROC
mov ax,operand1
or ax,operand2
mov result,ax
ret
oring endp
;function to find XOR of two operand
;and store in result variable
xoring PROC
mov ax,operand1
xor ax,operand2
mov result,ax
ret
xoring endp
;function to find complement(additive inverse) of operand1
;and store in result variable
complement PROC
mov ax,operand1
not ax
inc ax
mov result,ax
ret
complement endp
;function to find sine of operand1
;and store in result variable
sine PROC
mov bx,operand1
cmp bx,0
jl sine_in
sine_ip: ;invalid positive angle
cmp bx,360
jl sine_v
sub bx,360
jmp sine_ip
sine_in: ;invalid negative angle
cmp bx,0
jge sine_v
add bx,360
jmp sine_in
sine_v: ;valid angle (0 >= angle < 360)
cmp bx,90
je sine1
cmp bx,270
je sine1
jmp sine0
sine1:
mov ax,1
mov result,ax
sine0:
mov ax,bx
mov cx,2
mul cx
mov bx,ax
mov ax,[sin+bx]
mov [result+2],ax
cmp bx,360
jle sine_r
mov ax,1
mov [result+4],ax
sine_r:
ret
sine endp
;function to find cosine of operand1
;and store in result variable
cosine PROC
add operand1,90
call sine
ret
cosine endp
;function to find tangent of operand1
;and store in result variable
tangent PROC
mov bx,operand1
cmp bx,0
jl tan_in
tan_ip: ;invalid positive angle
cmp bx,180
jl tan_v
sub bx,180
jmp tan_ip
tan_in: ;invalid negative angle
cmp bx,0
jge tan_v
add bx,180
jmp tan_in
tan_v: ;valid angle (0 >= angle < 180)
cmp bx,90
jle tan_p
mov ax,180
sub ax,bx
mov bx,ax
mov ax,1
mov [result+4],ax
tan_p:
mov ax,bx
mov cx,4
mul cx
mov bx,ax
mov ax,[tan+bx]
mov result,ax
add bx,2
mov ax,[tan+bx]
mov [result+2],ax
ret
tangent endp    
;function to convert celsius to F
cf PROC   
   mov ax,operand1                                              
   mov operand2,09h
     
   imul operand2   
   mov cx,05h
   idiv cx
   add ax,20h
   mov result,ax
ret
cf endp   

;function to conert Fahrenheit to celsius
fc PROC
    mov ax,operand1
    sub ax, 32
    mov cx, 5
    imul cx
    mov cx, 9
    idiv cx
    mov result, ax
ret
fc endp  

;function to convert c to k   
fk PROC
      mov ax,operand1
      sub ax,32
      mov cx,5
      imul cx
      mov cx,9
      idiv cx
      add ax,273
      mov result,ax 
      ret
fk endp

kc PROC
    mov ax,operand1
    sub ax,273 
    mov result,ax
    
    ret
kc endp   

kf PROC
    mov ax,operand1
      sub ax,273
      mov cx,9
      imul cx
      mov cx,5
      idiv cx
      add ax,32
      mov result,ax
    ret
    
ck PROC
    mov ax,operand1
    add ax,273
    mov result,ax
    ret
ck endp    
;m to cm
mtcm PROC
    mov ax,operand1
    mov cx,100
    imul cx
    mov result,ax
    ret
mtcm endp
;m to km
mtkm PROC
     mov ax,operand1 
      xor dx,dx
     mov bx,1000
    idiv bx   
    call print_float 
    ;mov result,ax
    ret
mtkm endp 
;cm to m
cmtm PROC  
  
    mov ax,operand1 
    xor dx,dx
    mov bx,100
    idiv bx   
    
    call    print_float 
    
    
    ;mov result,ax
    ret
cmtm endp  
      
;km to cm
kmtcm PROC    

mov ax, word ptr abc

mul word ptr def
mov word ptr ghi, ax
mov cx, dx
mov ax, word ptr abc+2
mul word ptr def
add cx, ax
mov bx, dx
jnc move
add bx,0001H    
   
 move: mov ax,word ptr abc
mul word ptr def+2
add cx, ax
mov word ptr ghi+2, cx
mov cx,dx
 
jnc ma
add bx, 0001H
ma: mov ax, word ptr abc+2
mul word ptr def+2
add cx, ax
 
jnc mb
add dx, 0001H
mb: add cx, bx
mov word ptr ghi+4, cx
 
jnc mc
add dx, 0001H
mc: mov word ptr ghi+6, dx      
      
             ;ghi is result
    
    
    
   
    ret
kmtcm endp



;km to m
kmtm PROC
     mov ax,operand1
     xor dx,dx
     mov bx,1000
     imul bx   
     mov result,ax
     ret
    
    
kmtm endp  




;g to kg
gtkg PROC
    mov ax,operand1
    xor dx,dx
    mov bx,1000
    idiv bx
    call print_float
    ret
    
gtkg endp

       
    
;kg to g
kgtg PROC
 mov ax,operand1
 mov bx,1000
 imul bx
 mov result,ax
 ret
kgtg endp

;kg to m   
kgtm PROC
    mov ax, word ptr abd
mul word ptr def
mov word ptr ghi, ax
mov cx, dx
mov ax, word ptr abd+2
mul word ptr def
add cx, ax
mov bx, dx
jnc movee
add bx,0001H
 
movee: mov ax,word ptr abd
mul word ptr def+2
add cx, ax
mov word ptr ghi+2, cx 

mov cx,dx
 
jnc maa
add bx, 0001H
maa: mov ax, word ptr abd+2
mul word ptr def+2
add cx, ax
 
jnc mbb
add dx, 0001H
mbb: add cx, bx
mov word ptr ghi+4, cx
 
jnc mcc
add dx, 0001H
mcc: mov word ptr ghi+6, dx    
  
ret                ;ghi is result
           
          
kgtm endp  

;g to m
gtm PROC
    mov ax,operand1
    mov bx,1000
    imul bx
    mov result,ax
    ret
gtm endp



print_float     proc    near
        push    cx
        push    dx

        ; because the remainder takes the sign of divident
        ; its sign should be inverted when divider is negative
        ; (-) / (-) = (+)
        ; (+) / (-) = (-)
        cmp     bx, 0
        jns     div_not_signed
        neg     dx              ; make remainder positive.
div_not_signed:

        ; print_num procedure does not print the '-'
        ; when the whole part is '0' (even if the remainder is
        ; negative) this code fixes it:
        cmp     ax, 0
        jne     checked         ; ax<>0
        cmp     dx, 0
        jns     checked         ; ax=0 and dx>=0
        push    dx
        mov     dl, '-'
        call    write_char      ; print '-'
        pop     dx
checked:

        ; print whole part:
        call    print_num

        ; if remainder=0, then no need to print it:
        cmp     dx, 0
        je      done

        push    dx
        ; print dot after the number:
        mov     dl, '.'
        call    write_char
        pop     dx

        ; print digits after the dot:
        mov     cx, precision
        call    print_fraction
done:
        pop     dx
        pop     cx
        ret
print_float     endp

print_fraction  proc    near
        push    ax
        push    dx
next_fraction:
        ; check if all digits are already printed:
        cmp     cx, 0
        jz      end_rem
        dec     cx      ; decrease digit counter.

        ; when remainder is '0' no need to continue:
        cmp     dx, 0
        je      end_rem

        mov     ax, dx
        xor     dx, dx
        cmp     ax, 0
        jns     not_sig1
        not     dx
not_sig1:

        imul    ten             ; dx:ax = ax * 10

        idiv    bx              ; ax = dx:ax / bx   (dx - remainder)

        push    dx              ; store remainder.
        mov     dx, ax
        cmp     dx, 0
        jns     not_sig2
        neg     dx
not_sig2:
        add     dl, 30h         ; convert to ascii code.
        call    write_char      ; print dl.
        pop     dx

        jmp     next_fraction
end_rem:
        pop     dx
        pop     ax
        ret
print_fraction  endp
  




;Function to calculate factorial of operand1
factorial PROC
; factorial of 0 = 1:
mov ax, 1
cmp operand1, 0
je fact_ret
; move the number to bx:
; cx will be a counter:
mov cx, operand1
mov ax, 1
mov bx, 1
fact_calc:
mul bx
inc bx
loop fact_calc
fact_ret:
mov result, ax
ret
factorial endp
;Function to calculate BMI
bmi PROC
;BMI = weight/(height)^2
mov ax,operand1
push ax ;store weight into stack
mov ax,operand2
mov operand1,ax
mov cx,2
mov operand2, cx
call power ;get height square in result
mov ax,result
mov operand2,ax
pop ax ;restore weight from stack
mov operand1,ax
call divide
ret
bmi endp

; gets the multi-digit SIGNED number from the keyboard,
; and stores the result in CX register:
SCAN_NUM PROC NEAR
PUSH DX
PUSH AX
PUSH SI
MOV CX, 0
; reset flag:
MOV CS:make_minus, 0
next_digit:
; get char from keyboard
; into AL:
MOV AH, 00h
INT 16h
; and print it:
MOV AH, 0Eh
INT 10h
; check for MINUS:
CMP AL, '-'
JE set_minus
; check for ENTER key:
CMP AL, 0Dh ; carriage return?
JNE not_cr
JMP stop_input
not_cr:
CMP AL, 8 ; 'BACKSPACE' pressed?
JNE backspace_checked
MOV DX, 0 ; remove last digit by
MOV AX, CX ; division:
DIV CS:ten ; AX = DX:AX / 10 (DX-rem).
MOV CX, AX
PUTC ' ' ; clear position.
PUTC 8 ; backspace again.
JMP next_digit
backspace_checked:
; allow only digits:
CMP AL, '0'
JAE ok_AE_0
JMP remove_not_digit
ok_AE_0:
CMP AL, '9'
JBE ok_digit
remove_not_digit:
PUTC 8 ; backspace.
PUTC ' ' ; clear last entered not digit.
PUTC 8 ; backspace again.
JMP next_digit ; wait for next input.
ok_digit:
; multiply CX by 10 (first time the result is zero)
PUSH AX
MOV AX, CX
MUL CS:ten ; DX:AX = AX*10
MOV CX, AX
POP AX
; check if the number is too big
; (result should be 16 bits)
CMP DX, 0
JNE too_big
; convert from ASCII code:
SUB AL, 30h
; add AL to CX:
MOV AH, 0
MOV DX, CX ; backup, in case the result will be too big.
ADD CX, AX
JC too_big2 ; jump if the number is too big.
JMP next_digit
set_minus:
MOV CS:make_minus, 1
JMP next_digit
too_big2:
MOV CX, DX ; restore the backuped value before add.
MOV DX, 0 ; DX was zero before backup!
too_big:
MOV AX, CX
DIV CS:ten ; reverse last DX:AX = AX*10, make AX = DX:AX / 10
MOV CX, AX
PUTC 8 ; backspace.
PUTC ' ' ; clear last entered digit.
PUTC 8 ; backspace again.
JMP next_digit ; wait for Enter/Backspace.
stop_input:
; check flag:
CMP CS:make_minus, 0
JE not_minus
NEG CX
not_minus:
POP SI
POP AX
POP DX
RET
make_minus DB ? ; used as a flag.
SCAN_NUM ENDP
; this procedure prints number in AX,
; used with PRINT_NUM_UNS to print signed numbers:
PRINT_NUM PROC NEAR
PUSH DX
PUSH AX
CMP AX, 0
JNZ not_zero
PUTC '0'
JMP printed
not_zero:
; the check SIGN of AX,
; make absolute if it's negative:
CMP AX, 0
JNS positive
NEG AX
PUTC '-'
positive:
CALL PRINT_NUM_UNS
printed:
POP AX
POP DX
RET
PRINT_NUM ENDP
; this procedure prints out an unsigned
; number in AX (not just a single digit)
; allowed values are from 0 to 65535 (FFFF)
PRINT_NUM_UNS PROC NEAR
PUSH AX
PUSH BX
PUSH CX
PUSH DX
; flag to prevent printing zeros before number:
MOV CX, 1
; (result of "/ 10000" is always less or equal to 9).
MOV BX, 10000 ; 2710h - divider.
; AX is zero?
CMP AX, 0
JZ print_zero
begin_print:
; check divider (if zero go to end_print):
CMP BX,0
JZ end_print
; avoid printing zeros before number:
CMP CX, 0
JE calc
; if AX<BX then result of DIV will be zero:
CMP AX, BX
JB skip
calc:
MOV CX, 0 ; set flag.
MOV DX, 0
DIV BX ; AX = DX:AX / BX (DX=remainder).
; print last digit
; AH is always ZERO, so it's ignored
ADD AL, 30h ; convert to ASCII code.
PUTC AL
MOV AX, DX ; get remainder from last div.
skip:
; calculate BX=BX/10
PUSH AX
MOV DX, 0
MOV AX, BX
DIV CS:ten ; AX = DX:AX / 10 (DX=remainder).
MOV BX, AX
POP AX
JMP begin_print
print_zero:
PUTC '0'
end_print:
POP DX
POP CX
POP BX
POP AX
RET
PRINT_NUM_UNS ENDP 

write_char      proc    near
        push    ax
        mov     ah, 02h
        int     21h
        pop     ax
        ret
write_char      endp

END main
