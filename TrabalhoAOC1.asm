.data
   num: .asciiz "\nDigite um numero maior que 1 e igual ou menor que 50000: "
   erro: .asciiz "\nNumero invalido. Tente novamente"
   primoAntes: .asciiz "\nPrimo anterior: "
   primoDepois: .asciiz "\nPrimo posterior: "
   naoExiste: .asciiz "\nNao existe primo anterior"
   nl: .asciiz "\n"

.text
.main

main:
  leitura:
   li $v0, 4
   la $a0, num
   syscall
   li $v0, 5
   syscall
   add $s0, $v0, $zero

   ble $s0, 1, invalido
   bgt $s0, 50000, invalido
   j ok

   invalido:
   li $v0, 4
   la $a0, erro
   syscall
   j leitura

   ok:
     addi $s1, $s0, -1

   antes:
     blt $s1, 2, fimAntes
     li $t0, 2

  teste1:
    mul $t1, $t0, $t0
    bgt $t1, $s1, fimAntes

    rem $t2, $s1, $t0

    beq $t2, $zero, proximo1
    addi $t0, $t0, 1
    j teste1

  proximo1:
    addi $s1, $s1, -1
    j antes

  fimAntes:
   addi $s2, $s0, 1

  depois:
   li $t0, 2

  teste2:
   mul $t1, $t0, $t0
   bgt $t1, $s2, fimDepois
   rem $t2, $s2, $t0
   beq $t2, $zero, proximo2
   addi $t0, $t0, 1
   j teste2

  proximo2:
   addi $s2, $s2, 1
   j depois

  fimDepois:
   blt $s1, 2, semAntes

   li $v0, 4
   la $a0, primoAntes
   syscall
   li $v0, 1
   add $a0, $s1, $zero
   syscall
   j mostraDepois

  semAntes:
   li $v0, 4
   la $a0, naoExiste
   syscall

  mostraDepois:
   li $v0, 4
   la $a0, primoDepois
   syscall

   li $v0, 1
   add $a0, $s2, $zero
   syscall

   li $v0, 4
   la $a0, nl
   syscall

   li $v0, 10
   syscall