.text 
.globl _start

_start:

li s0, 0x00000100
li t0, 0x00000200    #ultimo led
li t1, 0x00000001    #primeiro led
li t2, 0x00000001    #comeco(fofo) uWu

senhorloop:

slli t2,t2,1
sw t2,4(s0)
bne t0,t2,senhorloop

corinthiansmenotti2012:
srli t2,t2,1
sw t2,4(s0)
bne t2,t1,corinthiansmenotti2012
j senhorloop
