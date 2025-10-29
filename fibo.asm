.text 
.globl _start

_start:

addi s0,zero, 0x100
addi t0,zero, 0x200    #ultimo led
addi t1, zero,0x1    #primeiro led
addi t2, zero,0x1    #comeco(fofo) uWu

senhorloop:

slli t2,t2,1
sw t2,4(s0)
bne t0,t2,senhorloop

corinthiansmenotti2012:
srli t2,t2,1
sw t2,4(s0)
bne t2,t1,corinthiansmenotti2012
j senhorloop
