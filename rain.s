.data
arr: .word 20,1,0,2,1,16,1,3,2,1,2,17
size: .word 12
.text
main:
    la s0 arr
    lw s1 size
    j findmax
    add s2 zero zero #i=0
    add s3 zero zero #maxh
    add s4 zero zero #maxhi
    add s5 zero zero #rain
    add s6 zero zero #water_l
    
findmax:
    bge s2 s1 leftmax 
    add t1 zero s2 #t1=i
    add t1 t1 t1 #i*2
    add t1 t1 t1 #i*4
    add s7 t1 s0 
    lw t2 0[s7] #arr[i]=t2
    blt s3 t2 process1 
    addi s2 s2 1 #i++
    j findmax 
process1: 
    add s4 zero s2 #maxhi=i
    add s3 t2 zero #arr[i]=maxh
    addi s2 s2 1 #i++
    j findmax 
leftmax:
    mul  s2 s2 zero 
    j process2 
process2:
    bge s2 s4 maxleft 
    add t1 zero s2 #t1=s2=i
    add t1 t1 t1 #s2*2
    add t1 t1 t1 #s2*4
    add s7 s0 t1 #s2*4+address
    lw t2 0[s7] #t2=arr[i]
    blt s6 t2 changeprocess 
    add s5 s5 s6 #rain=rain+water_l
    sub s5 s5 t2 #rain=rain+water_l-arr[i]
    addi s2 s2 1 #i++
    j process2 
changeprocess:
    add s6 t2 zero #water_l(s6)=arr[i](t2)
    add s5 s5 s6 #rain=rain+water_l
    sub s5 s5 t2 #rain=rain+water_l-arr[i]
    addi s2 s2 1 #i++
    j process2 
maxleft:
    mul s2 s2 zero 
    mul s6 s6 zero 
    addi s1 s1 -1 #size-1
    add s2 s2 s1 #i=size-1
    j process3 
process3:
    bge s4 s2 print 
    add t1 s2 zero #t1=i
    add t1 t1 t1 #i*2
    add t1 t1 t1 #i*4
    add s7 t1 s0 
    lw t2 0[s7] #t2=arr[i]
    blt s6 t2 changeprocess2 
    add s5 s5 s6 #=rain=rain+water_l
    sub s5 s5 t2 #rain=rain+water_l-arr[i]
    addi s2 s2 -1 #i--
    j process3
changeprocess2:
    add s6 t2 zero #water_l=t2
    add s5 s5 s6 #rain=rain+water_l
    sub s5 s5 t2 #rain=rain+water_l-arr[i]
    addi s2 s2 -1 #i--
    j process3 
print:
    addi a0 s5 0
    li a7 1
    ecall
    li a7 10
    ecall 
