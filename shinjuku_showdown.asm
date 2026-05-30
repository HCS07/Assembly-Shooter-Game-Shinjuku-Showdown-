; ────┤ Shinjuku Showdown ├────
; Shooter inspirado no CS-Assembly

jmp main

;********************************************************;
;                         DADOS                          ;
;********************************************************;

; ------------- PLAYER -----------------;
posPlayer    : var #1       ; Posicao do player na tela
posPlayerAnt : var #1       ; Posicao anterior do player
dirPlayer    : var #1       ; Direcao atual do player (UP=0 RIGHT=4 DOWN=8 LEFT=12)
dirPlayerAnt : var #1       ; Direcao anterior do player
corPlayer    : var #1
    static corPlayer + #0, #10240     ; azul
vidaPlayer   : var #1

; -------------- TIRO DO PLAYER ------------------;
posTiro1 : var #1           ; Posicao do tiro do player
dirTiro1 : var #1           ; Direcao do tiro (NULL = 1)

; ------------- BOT -----------------;
posBot    : var #1
posBotAnt : var #1
dirBot    : var #1
dirBotAnt : var #1
corBot    : var #1
    static corBot + #0, #2560   ; vermelho
vidaBot  : var #1

; -------------- TIRO DO BOT ------------------;
posTiro2 : var #2
dirTiro2 : var #1           ; Direcao do tiro (NULL = 1)

; -> CARACTERES DE BONECO (fixos, independente de direcao)
playerChar1: string "X"   ; linha de cima do player
playerChar2: string "H"   ; linha de baixo do player
botChar1:    string "Q"   ; linha de cima do bot
botChar2:    string "Z"   ; linha de baixo do bot

; -> CARACTERES DE TIRO DO PLAYER (@) - roxo
tiroCharsPlayer: string "@@  @@  @@  @@"
corTiroPlayer: var #1
    static corTiroPlayer + #0, #10240    ; roxo

; -> CARACTERES DE TIRO DO BOT ()) - vermelho
tiroCharsBot: string "((  ((  ((  (("
corTiroBot: var #1
    static corTiroBot + #0, #2560     ; vermelho

; -> TABELA DE NUMEROS RANDOMICOS
IncRand: var #1
Rand : var #100
    static Rand + #0,  #1
    static Rand + #1,  #4
    static Rand + #2,  #7
    static Rand + #3,  #8
    static Rand + #4,  #4
    static Rand + #5,  #2
    static Rand + #6,  #4
    static Rand + #7,  #6
    static Rand + #8,  #6
    static Rand + #9,  #3
    static Rand + #10, #7
    static Rand + #11, #5
    static Rand + #12, #8
    static Rand + #13, #4
    static Rand + #14, #7
    static Rand + #15, #2
    static Rand + #16, #5
    static Rand + #17, #3
    static Rand + #18, #5
    static Rand + #19, #2
    static Rand + #20, #10
    static Rand + #21, #7
    static Rand + #22, #1
    static Rand + #23, #7
    static Rand + #24, #10
    static Rand + #25, #8
    static Rand + #26, #1
    static Rand + #27, #9
    static Rand + #28, #10
    static Rand + #29, #9
    static Rand + #30, #5
    static Rand + #31, #7
    static Rand + #32, #1
    static Rand + #33, #1
    static Rand + #34, #4
    static Rand + #35, #3
    static Rand + #36, #6
    static Rand + #37, #3
    static Rand + #38, #7
    static Rand + #39, #2
    static Rand + #40, #10
    static Rand + #41, #6
    static Rand + #42, #8
    static Rand + #43, #4
    static Rand + #44, #5
    static Rand + #45, #9
    static Rand + #46, #8
    static Rand + #47, #5
    static Rand + #48, #6
    static Rand + #49, #5
    static Rand + #50, #9
    static Rand + #51, #2
    static Rand + #52, #7
    static Rand + #53, #1
    static Rand + #54, #5
    static Rand + #55, #1
    static Rand + #56, #5
    static Rand + #57, #9
    static Rand + #58, #3
    static Rand + #59, #2
    static Rand + #60, #5
    static Rand + #61, #6
    static Rand + #62, #1
    static Rand + #63, #10
    static Rand + #64, #2
    static Rand + #65, #4
    static Rand + #66, #2
    static Rand + #67, #5
    static Rand + #68, #1
    static Rand + #69, #4
    static Rand + #70, #7
    static Rand + #71, #3
    static Rand + #72, #10
    static Rand + #73, #10
    static Rand + #74, #2
    static Rand + #75, #7
    static Rand + #76, #7
    static Rand + #77, #3
    static Rand + #78, #7
    static Rand + #79, #4
    static Rand + #80, #5
    static Rand + #81, #6
    static Rand + #82, #6
    static Rand + #83, #9
    static Rand + #84, #5
    static Rand + #85, #6
    static Rand + #86, #10
    static Rand + #87, #3
    static Rand + #88, #7
    static Rand + #89, #1
    static Rand + #90, #9
    static Rand + #91, #8
    static Rand + #92, #2
    static Rand + #93, #7
    static Rand + #94, #9
    static Rand + #95, #8
    static Rand + #96, #2
    static Rand + #97, #6
    static Rand + #98, #6
    static Rand + #99, #3

;--------------------------------------------------------;
; FUNDO ESTATICO: predios decorativos (intangiveis)
; Tela 30 linhas x 40 colunas, sem colisao
; Predios representados por | e _ e # apenas para visual
;--------------------------------------------------------;

; Camada dinamica (parte onde ocorre o jogo)
dinamicaLinha0:  string "                                        "
dinamicaLinha1:  string "                                        "
dinamicaLinha2:  string "                                        "
dinamicaLinha3:  string "                                        "
dinamicaLinha4:  string "                                        "
dinamicaLinha5:  string "                                        "
dinamicaLinha6:  string "                                        "
dinamicaLinha7:  string "                                        "
dinamicaLinha8:  string "                                        "
dinamicaLinha9:  string "                                        "
dinamicaLinha10: string "                                        "
dinamicaLinha11: string "                                        "
dinamicaLinha12: string "                                        "
dinamicaLinha13: string "                                        "
dinamicaLinha14: string "                                        " 
dinamicaLinha15: string "                                        "
dinamicaLinha16: string "                                        "
dinamicaLinha17: string "                                        "
dinamicaLinha18: string "                                        "
dinamicaLinha19: string "                                        "
dinamicaLinha20: string "                                        "
dinamicaLinha21: string "                                        "
dinamicaLinha22: string "                                        "
dinamicaLinha23: string "                                        "
dinamicaLinha24: string "                                        "
dinamicaLinha25: string "                                        "
dinamicaLinha26: string "                                        "
dinamicaLinha27: string "                                        "
dinamicaLinha28: string "                                        "
dinamicaLinha29: string "                                        "

; Camada estatica (fundo imutavel e intangivel)
fundoLinha0:  string " ____________________________________  "
fundoLinha1:  string "|                                    | "
fundoLinha2:  string "|                                    | "
fundoLinha3:  string "|                                    | "
fundoLinha4:  string "|                                    | "
fundoLinha5:  string "|                                    | "
fundoLinha6:  string "|                                    | " 
fundoLinha7:  string "|                                    | "
fundoLinha8:  string "|                                    | "
fundoLinha9:  string "|                                    | "
fundoLinha10: string "|                                    | "
fundoLinha11: string "|                                    | "
fundoLinha12: string "|                                    | "
fundoLinha13: string "|   ____                             | "
fundoLinha14: string "|  |    |                            | "
fundoLinha15: string "|  | || |                            | "
fundoLinha16: string "|  | || |          _                 | "
fundoLinha17: string "|  | || |         / |                | "
fundoLinha18: string "|  | || |        /  |                | "
fundoLinha19: string "|  | || |       /   |                | "
fundoLinha20: string "|  | || |      /____|                | "
fundoLinha21: string "|  |    |      |    |                | "
fundoLinha22: string "|  |    |      |    |                | "
fundoLinha23: string "|  |    |      | ** |                | " 
fundoLinha24: string "|  | SK |      |    |                | "
fundoLinha25: string "|  |    |      | MK |                | "
fundoLinha26: string "|  |    |      |    |       0--|     | "
fundoLinha27: string "|  |    |      |    |          |     | "
fundoLinha28: string "|==|====|======|====|==========|=====| "
fundoLinha29: string "|____________________________________| "

; Tela de titulo
tituloLinha0:  string "  ### #  #  # #   #   ## # # #   # # # "
tituloLinha1:  string "  #   #  #    ##  #   #  # # #  #  # # "
tituloLinha2:  string "  #   #  #  # ##  #   #  # # # #   # # "
tituloLinha3:  string "  ### ####  # # # #   #  # # ##    # # "
tituloLinha4:  string "    # #  #  # #  ##   #  # # # #   # # "
tituloLinha5:  string "    # #  #  # #  ## # #  # # #  #  # # "
tituloLinha6:  string "  ### #  #  # #   # ###   #  #   #  #  "
tituloLinha7:  string "                                       "
tituloLinha8:  string "                                       "
tituloLinha9:  string "                                       "
tituloLinha10: string "                                       "
tituloLinha11: string " ### # # ### #   # ##  ### #   # #   # "
tituloLinha12: string " #   # # # # #   # # # # # #   # ##  # "
tituloLinha13: string " #   # # # # #   # # # # # #   # ##  # "
tituloLinha14: string " ### ### # # #   # # # # # #   # # # # "
tituloLinha15: string "   # # # # # # # # # # # # # # # #  ## "
tituloLinha16: string "   # # # # # ## ## # # # # ## ## #  ## "
tituloLinha17: string " ### # # ### #   # ##  ### #   # #   # "
tituloLinha18: string "                                       "
tituloLinha19: string "                                       "
tituloLinha20: string "                                       "
tituloLinha21: string "                                       "
tituloLinha22: string "                                       "
tituloLinha23: string "                                       "
tituloLinha24: string "                                       "
tituloLinha25: string "        PRESS [SPACE] TO FIGYT         "
tituloLinha26: string "                                       "
tituloLinha27: string "                                       "
tituloLinha28: string "                                       "
tituloLinha29: string "                                       "

; Tela de vitoria do player
playerGanhouLinha0:  string  "        #     #    #    #    #         "
playerGanhouLinha1:  string  "        ##    #   # #   #    #         "
playerGanhouLinha2:  string  "        # #   #  #   #  #    #         "
playerGanhouLinha3:  string  "        #  #  #  #####  ######         "
playerGanhouLinha4:  string  "        #   # #  #   #  #    #         "
playerGanhouLinha5:  string  "        #    ##  #   #  #    #         "
playerGanhouLinha6:  string  "        #     #  #   #  #    #         "
playerGanhouLinha7:  string  "                                       "
playerGanhouLinha8:  string  "    ### `| ##     #   #  #  #     #    "
playerGanhouLinha9:  string  "     #   ) # #    #   #     ##    #    "
playerGanhouLinha10:  string "     #     # #    #   #  #  # #   #    "
playerGanhouLinha11:  string "     #     # #    #   #  #  #  #  #    "
playerGanhouLinha12:  string "     #     # #    # # #  #  #   # #    "
playerGanhouLinha13:  string "     #     # #    ## ##  #  #    ##    "
playerGanhouLinha14:  string "    ###    ##     #   #  #  #     #    "
playerGanhouLinha15:  string "                                       "
playerGanhouLinha16:  string "                                       "
playerGanhouLinha17:  string "                                       "
playerGanhouLinha18:  string "                                       "
playerGanhouLinha19:  string "                                       "
playerGanhouLinha20:  string "                                       "
playerGanhouLinha21:  string "                                       "
playerGanhouLinha22:  string "         -- NAY,  I'D  WIN. --         "
playerGanhouLinha23:  string "                                       "
playerGanhouLinha24:  string "                                       "
playerGanhouLinha25:  string "                                       "
playerGanhouLinha26:  string "                                       "
playerGanhouLinha27:  string "        PRESS [SPACE] TO RESTART       "
playerGanhouLinha28:  string "                                       "
playerGanhouLinha29:  string "                                       "

; Tela de vitoria do bot
botGanhouLinha0:  string "  ###  ###   ###   ##  #### #  # ##    "
botGanhouLinha1:  string "  #  # #     #  #  # # #  # #  # # #   "  
botGanhouLinha2:  string "  #  # #     #  #  ##  #  # #  # # #   "
botGanhouLinha3:  string "  ###  ##    ###   # # #  # #  # # #   "
botGanhouLinha4:  string "  #  # #     #     # # #  # #  # # #   "
botGanhouLinha5:  string "  #  # #     #     # # #  # #  # # #   "
botGanhouLinha6:  string "  ###  ###   #     # # #### #### ##    "
botGanhouLinha7:  string "                                       "
botGanhouLinha8:  string "  #   # #### #  #   #   # ### ##  ###  "
botGanhouLinha9:  string "   # #  #  # #  #   #   # #   # # #    "
botGanhouLinha10: string "    #   #  # #  #   #   # #   ##  #    "
botGanhouLinha11: string "    #   #  # #  #   #   # ##  # # ##   "
botGanhouLinha12: string "    #   #  # #  #   # # # #   # # #    "
botGanhouLinha13: string "    #   #  # #  #   ## ## #   # # #    "
botGanhouLinha14: string "    #   #### ####   #   # ### # # ###  "
botGanhouLinha15: string "                                       "
botGanhouLinha16: string "                                       "
botGanhouLinha17: string "     ### ### ##   #### #   # ###       "
botGanhouLinha18: string "     #    #  # #  #  # ##  # # #       "
botGanhouLinha19: string "     #    #  ##   #  # ##  # #         "
botGanhouLinha20: string "     ###  #  # #  #  # # # # # ##      "
botGanhouLinha21: string "       #  #  # #  #  # #  ## #  #      "
botGanhouLinha22: string "       #  #  # #  #  # #  ## #  #      "
botGanhouLinha23: string "     ###  #  # #  #### #   # ####      "
botGanhouLinha24: string "                                       "
botGanhouLinha25: string "                                       "
botGanhouLinha26: string "                                       "
botGanhouLinha27: string "        PRESS [SPACE] TO RESTART       "
botGanhouLinha28: string "                                       "
botGanhouLinha29: string "                                       "

;********************************************************;
;                         CODIGO                         ;
;********************************************************;

main:
    call ApagaTela

    ; Imprime tela de titulo
    call ImprimeTitulo
  
    ; Aguarda SPACE para comecar
    loadn r2, #' '
Loop_inicial:
    inchar r1
    cmp r2, r1
    jne Loop_inicial

    call ApagaTela

    ; Imprime fundo de predios
    call ImprimeFundo

    ; Spawna os personagens
    call spawnaPlayer
    call spawnaBot

    ; Loop principal: c = 0
    loadn r0, #0
Loop:
    call MoveBoneco     ; Input e movimento do player

    ; Bot se move a cada 2 loops (mesma velocidade do player em media)
    loadn r1, #0
    loadn r2, #2
    mod r2, r0, r2
    cmp r2, r1
    ceq iaBot

    ; Bot atira a cada 5 loops
    loadn r1, #0
    loadn r2, #5
    mod r2, r0, r2
    cmp r2, r1
    ceq atiraBot

    ; Tiros se movem a cada loop (mais rapido que os personagens)
    call AtualizaTiro

    call Delay
    inc r0
    jmp Loop

    halt

;========================================================;
;                     SPAWN PLAYER
spawnaPlayer:
    push r0

    ; Posicao inicial: 
    loadn r0, #1045
    store posPlayer, r0

    loadn r0, #0        ; Direcao inicial = UP
    store dirPlayer, r0

    loadn r0, #1        ; Tiro nulo
    store dirTiro1, r0

    loadn r0, #99       ; Vida inicial
    store vidaPlayer, r0

    loadn r0, #0        ; posicao anterior segura (linha 0, col 0)
    store posPlayerAnt, r0

    pop r0
    rts
;                   FIM SPAWN PLAYER
;========================================================;

;========================================================;
;                      SPAWN BOT
spawnaBot:
    push r0

    ; Posicao inicial: 
    loadn r0, #1075
    store posBot, r0

    loadn r0, #8        ; Direcao inicial = DOWN
    store dirBot, r0

    loadn r0, #1        ; Tiro nulo
    store dirTiro2, r0

    loadn r0, #99       ; Vida inicial
    store vidaBot, r0

    loadn r0, #0
    store posBotAnt, r0

    pop r0
    rts
;                    FIM SPAWN BOT
;========================================================;

;========================================================;
;                     APAGA BONECO
; <- r6 = endereco da posicao anterior do boneco
ApagaBoneco:
    push r0
    push r1
    push r2
    push r6

    loadi r0, r6        ; r0 = posicao anterior do boneco
    loadn r1, #' '
    loadn r2, #40

    ; Apaga apenas 1x2: uma posicao na linha de cima e uma na linha de baixo
    outchar r1, r0
    nop
    nop
    nop
    nop
    nop
    nop
    add r0, r0, r2
    outchar r1, r0
    nop
    nop
    nop
    nop
    nop
    nop

    pop r6
    pop r2
    pop r1
    pop r0
    rts
;                   FIM APAGA BONECO
;========================================================;

;========================================================;
;                    ATUALIZA BONECO
; <- r7 = endereco da posicao atual
; <- r6 = endereco da posicao anterior
; <- r5 = endereco da direcao atual
; <- r4 = endereco da direcao anterior
; <- r3 = cor do boneco
AtualizaBoneco:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadi r1, r7        ; r1 = posicao atual
    loadi r2, r6        ; r2 = posicao anterior
    cmp r1, r2
    jne atualiza

    loadi r1, r5        ; r1 = direcao atual
    loadi r2, r4        ; r2 = direcao anterior
    cmp r1, r2
    jne atualiza

fim_atualizaBoneco:
    loadi r1, r7
    storei r6, r1

    loadi r1, r5
    storei r4, r1

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

atualiza:
    loadi r0, r7        ; r0 = posicao do boneco

    call ApagaBoneco    ; Apaga da posicao anterior

    ; Verifica se e player ou bot pelo endereco de posicao
    ; r7 = endereco da posicao atual
    ; Se r7 == #posPlayer -> usa playerChar1/playerChar2
    ; Senao               -> usa botChar1/botChar2
    push r4
    loadn r4, #posPlayer
    cmp r7, r4
    pop r4
    jne atualiza_bot

atualiza_player:
    ; Linha de cima: X
    loadn r1, #playerChar1
    loadi r2, r1
    add r2, r2, r3
    outchar r2, r0
    nop
    nop
    nop
    nop
    nop
    nop

    ; Linha de baixo: H
    loadn r2, #40
    add r0, r0, r2
    loadn r1, #playerChar2
    loadi r2, r1
    add r2, r2, r3
    outchar r2, r0
    nop
    nop
    nop
    nop
    nop
    nop
    jmp fim_atualizaBoneco

atualiza_bot:
    ; Linha de cima: Q
    loadn r1, #botChar1
    loadi r2, r1
    add r2, r2, r3
    outchar r2, r0
    nop
    nop
    nop
    nop
    nop
    nop

    ; Linha de baixo: Z
    loadn r2, #40
    add r0, r0, r2
    loadn r1, #botChar2
    loadi r2, r1
    add r2, r2, r3
    outchar r2, r0
    nop
    nop
    nop
    nop
    nop
    nop
    jmp fim_atualizaBoneco
;                   FIM ATUALIZA BONECO
;========================================================;

;========================================================;
;                      MOVE BONECO
MoveBoneco:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    inchar r1           ; Pega input do player

    loadn r7, #posPlayer
    loadn r6, #dirPlayer
    loadn r5, #posTiro1
    loadn r4, #dirTiro1

    load r3, vidaPlayer
    loadn r2, #90
    cmp r3, r2
    cle incrementaVida1
    jle playerMorto

    ; Verifica teclas de movimento
    loadn r2, #'w'
    cmp r1, r2
    jeq UP_boneco

    loadn r2, #'d'
    cmp r1, r2
    jeq RIGHT_boneco

    loadn r2, #'s'
    cmp r1, r2
    jeq DOWN_boneco

    loadn r2, #'a'
    cmp r1, r2
    jeq LEFT_boneco

    loadn r2, #'f'
    cmp r1, r2
    ceq Tiro
    jeq continuaBoneco

playerMorto:
    load r3, vidaBot
    loadn r2, #90
    cmp r3, r2
    cle incrementaVida2
    jle continuaBoneco

continuaBoneco:
    load r3, vidaPlayer
    loadn r2, #90
    cmp r3, r2
    jle naoAtualizaPlayer

    loadn r7, #posPlayer
    loadn r6, #posPlayerAnt
    loadn r5, #dirPlayer
    loadn r4, #dirPlayerAnt
    load r3, corPlayer
    call AtualizaBoneco

naoAtualizaPlayer:
    load r3, vidaBot
    loadn r2, #90
    cmp r3, r2
    jle naoAtualizaBot

    loadn r7, #posBot
    loadn r6, #posBotAnt
    loadn r5, #dirBot
    loadn r4, #dirBotAnt
    load r3, corBot
    call AtualizaBoneco

naoAtualizaBot:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

incrementaVida1:
    load r3, vidaPlayer
    inc r3
    store vidaPlayer, r3
    loadn r2, #10
    cmp r3, r2
    ceg spawnaPlayer
    rts

incrementaVida2:
    load r3, vidaBot
    inc r3
    store vidaBot, r3
    loadn r2, #10
    cmp r3, r2
    ceg spawnaBot
    rts
;                   FIM MOVE BONECO
;========================================================;

;========================================================;
; UP / RIGHT / DOWN / LEFT  BONECO
; Sem colisao com mapa (tela livre), apenas com bordas da tela

UP_boneco:
    loadi r0, r7

    loadn r1, #0
    storei r6, r1       ; dir = UP

    loadn r2, #40
    sub r0, r0, r2      ; sobe uma linha

    ; Borda superior (linha 0 = posicao < 40, nao pode subir mais)
    loadn r1, #2        ; linha 1 como limite (para nao sumir)
    loadn r2, #40
    mul r1, r1, r2      ; r1 = 80
    cmp r0, r1
    jle continuaBoneco  ; se for menor que linha 2, nao move

    storei r7, r0
    jmp continuaBoneco

RIGHT_boneco:
    loadi r0, r7

    loadn r1, #4
    storei r6, r1       ; dir = RIGHT

    inc r0              ; vai um pra direita

    ; Borda direita: coluna maxima = 37 (40 - 3, boneco tem 2 de largura)
    loadn r1, #37
    loadn r2, #40
    mod r3, r0, r2      ; r3 = coluna
    cmp r3, r1
    jgr continuaBoneco  ; se coluna > 37, nao move

    storei r7, r0
    jmp continuaBoneco

DOWN_boneco:
    loadi r0, r7

    loadn r1, #8
    storei r6, r1       ; dir = DOWN

    loadn r2, #40
    add r0, r0, r2      ; desce uma linha

    ; Borda inferior: linha maxima = 26 (linha 27 e o chao)
    loadn r1, #1080     ; 27 * 40 = 1080
    cmp r0, r1
    jgr continuaBoneco  ; se posicao > 1080, nao move

    storei r7, r0
    jmp continuaBoneco

LEFT_boneco:
    loadi r0, r7

    loadn r1, #12
    storei r6, r1       ; dir = LEFT

    dec r0              ; vai um pra esquerda

    ; Borda esquerda: coluna minima = 1
    loadn r1, #1
    loadn r2, #40
    mod r3, r0, r2      ; r3 = coluna
    cmp r3, r1
    jle continuaBoneco  ; se coluna <= 1, nao move

    storei r7, r0
    jmp continuaBoneco
;              FIM UP/RIGHT/DOWN/LEFT BONECO
;========================================================;

;========================================================;
;                         TIRO
; <- r7 = endereco da posicao do boneco
; <- r6 = endereco da direcao do boneco
; <- r5 = endereco da posicao do tiro
; <- r4 = endereco da direcao do tiro
Tiro:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    ; Se ja existe um tiro, nao cria outro
    loadn r0, #1
    loadi r1, r4
    cmp r1, r0
    jne naoAtira

    loadi r0, r7        ; r0 = posicao do boneco
    loadi r1, r6        ; r1 = direcao do boneco
    storei r4, r1       ; dirTiro = dirBoneco

    ; Calcula posicao inicial do tiro baseado na direcao
    loadn r2, #0
    cmp r1, r2
    jne not_tiro_UP
    loadn r2, #40
    sub r0, r0, r2      ; tiro comeca uma linha acima
    loadn r2, #40
    cmp r0, r2
    jle not_tiro_valido
    jmp fimTiro

not_tiro_UP:
    loadn r2, #4
    cmp r1, r2
    jne not_tiro_RIGHT
    inc r0
    inc r0              ; tiro comeca duas colunas a direita
    loadn r2, #37
    loadn r3, #40
    mod r3, r0, r3
    cmp r3, r2
    jgr not_tiro_valido
    jmp fimTiro

not_tiro_RIGHT:
    loadn r2, #8
    cmp r1, r2
    jne not_tiro_DOWN
    loadn r2, #80
    add r0, r0, r2      ; tiro comeca duas linhas abaixo
    loadn r2, #1080
    cmp r0, r2
    jgr not_tiro_valido
    jmp fimTiro

not_tiro_DOWN:
    loadn r2, #12
    cmp r1, r2
    jne not_tiro_valido
    dec r0              ; tiro comeca uma coluna a esquerda
    loadn r2, #1
    loadn r3, #40
    mod r3, r0, r3
    cmp r3, r2
    jle not_tiro_valido
    jmp fimTiro

not_tiro_valido:
    loadn r1, #1
    storei r4, r1       ; dirTiro = NULO

fimTiro:
    storei r5, r0       ; salva posicao do tiro

naoAtira:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                       FIM TIRO
;========================================================;

;========================================================;
;                      ATIRA BOT
atiraBot:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r7, #posBot
    loadn r6, #dirBot
    loadn r5, #posTiro2
    loadn r4, #dirTiro2

    call Tiro

    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                    FIM ATIRA BOT
;========================================================;

;========================================================;
;                         IA BOT
; Bot com IA baseada em posicao relativa ao player
iaBot:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r7, #posBot
    loadn r6, #dirBot

    ; Pega numero randomico
    loadn r2, #Rand
    load r1, IncRand
    add r2, r2, r1
    loadi r3, r2
    inc r1
    loadn r2, #100
    cmp r1, r2
    jne iaBot_SalvaInc
    loadn r1, #0
iaBot_SalvaInc:
    store IncRand, r1

    ; Compara posicao do bot com a do player para decidir direcao
    load r0, posBot
    load r1, posPlayer

    ; Calcula linha do bot e do player
    loadn r2, #40
    div r4, r0, r2      ; r4 = linha do bot
    div r5, r1, r2      ; r5 = linha do player

    cmp r4, r5
    jgr iaBot_SubeOuLado    ; bot esta abaixo do player -> tende a subir
    jle iaBot_DesceOuLado   ; bot esta acima do player -> tende a descer

iaBot_SubeOuLado:
    ; Peso: 60% UP, 20% direita/esquerda randomico, 20% DOWN
    loadn r2, #6
    cmp r3, r2
    jgr iaBot_LadoNorte
    jmp UP_boneco

iaBot_LadoNorte:
    loadn r2, #8
    cmp r3, r2
    jgr iaBot_DownNorte
    ; move lateral randomico
    loadn r2, #40
    mod r2, r0, r2      ; r2 = coluna do bot
    loadn r1, #20
    cmp r2, r1
    jle RIGHT_boneco
    jmp LEFT_boneco

iaBot_DownNorte:
    jmp DOWN_boneco

iaBot_DesceOuLado:
    ; Peso: 60% DOWN, 20% lateral, 20% UP
    loadn r2, #6
    cmp r3, r2
    jgr iaBot_LadoSul
    jmp DOWN_boneco

iaBot_LadoSul:
    loadn r2, #8
    cmp r3, r2
    jgr iaBot_UpSul
    loadn r2, #40
    mod r2, r0, r2
    loadn r1, #20
    cmp r2, r1
    jle RIGHT_boneco
    jmp LEFT_boneco

iaBot_UpSul:
    jmp UP_boneco
;                       FIM IA BOT
;========================================================;

;========================================================;
;                      APAGA TIRO
; <- r7 = endereco da posicao do tiro
; <- r6 = endereco da direcao do tiro
ApagaTiro:
    push r0
    push r1
    push r2

    loadi r0, r6        ; r0 = direcao do tiro
    loadi r1, r7        ; r1 = posicao do tiro

    loadn r2, #8
    mod r2, r0, r2
    jz apagaTiroHorizontal

    ; Apaga tiro vertical (RIGHT ou LEFT): dois chars lado a lado
    loadn r0, #' '
    outchar r0, r1
    nop
    nop
    nop
    nop
    nop
    nop
    inc r1
    outchar r0, r1
    nop
    nop
    nop
    nop
    nop
    nop
    jmp fim_apagaTiro

apagaTiroHorizontal:
    ; Apaga tiro horizontal (UP ou DOWN): dois chars em linhas diferentes
    loadn r0, #' '
    outchar r0, r1
    nop
    nop
    nop
    nop
    nop
    nop
    loadn r2, #40
    add r1, r1, r2
    outchar r0, r1
    nop
    nop
    nop
    nop
    nop
    nop

fim_apagaTiro:
    pop r2
    pop r1
    pop r0
    rts
;                    FIM APAGA TIRO
;========================================================;

;========================================================;
;                     IMPRIME TIRO
; <- r7 = endereco da posicao do tiro
; <- r6 = endereco da direcao do tiro
; <- r4 = endereco do tiroChars do dono do tiro
; <- r3 = cor do tiro
ImprimeTiro:
    push r0
    push r1
    push r2
    push r3
    push r4

    loadi r0, r6        ; r0 = direcao
    loadi r1, r7        ; r1 = posicao

    loadn r2, #8
    mod r2, r0, r2
    jz imprimeTiroHorizontal

    ; Tiro vertical
    add r4, r4, r0
    loadi r2, r4
    add r2, r2, r3
    outchar r2, r1
    nop
    nop
    nop
    nop
    nop
    nop
    inc r1
    inc r4
    loadi r2, r4
    add r2, r2, r3
    outchar r2, r1
    nop
    nop
    nop
    nop
    nop
    nop
    jmp fim_imprimeTiro

imprimeTiroHorizontal:
    ; Tiro horizontal
    add r4, r4, r0
    loadi r2, r4
    add r2, r2, r3
    outchar r2, r1
    nop
    nop
    nop
    nop
    nop
    nop
    loadn r2, #40
    add r1, r1, r2
    inc r4
    loadi r2, r4
    add r2, r2, r3
    outchar r2, r1
    nop
    nop
    nop
    nop
    nop
    nop

fim_imprimeTiro:
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                   FIM IMPRIME TIRO
;========================================================;

;========================================================;
;                    ATUALIZA TIRO
AtualizaTiro:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    ; --- Tiro 1 (do player) ---
    load r0, dirTiro1
    loadn r1, #1
    cmp r0, r1
    jeq tiro1_nao_existe

    loadn r7, #posTiro1
    loadn r6, #dirTiro1
    call ApagaTiro
    call ImprimeFundo   ; Reimprime fundo para efeito de flickering

    load r5, posBot     ; Alvo do tiro 1 = bot

    loadn r2, #8
    mod r2, r0, r2
    cz MoveTiroUP_DOWN
    loadn r2, #8
    mod r2, r0, r2
    cnz MoveTiroRIGHT_LEFT

    call compara_tiros

    load r0, dirTiro1
    loadn r1, #1
    cmp r0, r1
    jeq tiro1_nao_existe
    loadn r4, #tiroCharsPlayer  ; chars do player (@)
    load r3, corTiroPlayer      ; cor roxa
    call ImprimeTiro

tiro1_nao_existe:
    ; --- Tiro 2 (do bot) ---
    load r0, dirTiro2
    loadn r1, #1
    cmp r0, r1
    jeq tiro2_nao_existe

    loadn r7, #posTiro2
    loadn r6, #dirTiro2
    call ApagaTiro
    call ImprimeFundo

    load r5, posPlayer  ; Alvo do tiro 2 = player

    loadn r2, #8
    mod r2, r0, r2
    cz MoveTiroUP_DOWN
    loadn r2, #8
    mod r2, r0, r2
    cnz MoveTiroRIGHT_LEFT

    call compara_tiros

    load r0, dirTiro2
    loadn r1, #1
    cmp r0, r1
    jeq tiro2_nao_existe
    loadn r4, #tiroCharsBot     ; chars do bot ())
    load r3, corTiroBot         ; cor vermelha
    call ImprimeTiro

tiro2_nao_existe:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                  FIM ATUALIZA TIRO
;========================================================;

;========================================================;
;                  MOVE TIRO UP OU DOWN
; <- r7 = endereco da posicao do tiro
; <- r6 = endereco da direcao do tiro
; <- r5 = posicao do boneco inimigo
MoveTiroUP_DOWN:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadi r0, r7
    loadi r1, r6

    loadn r2, #40
    loadn r3, #0
    cmp r1, r3
    jne moveTiroDown
    sub r0, r0, r2      ; UP: sobe uma linha
    jmp continuaTiroUP_DOWN

moveTiroDown:
    add r0, r0, r2      ; DOWN: desce uma linha

continuaTiroUP_DOWN:
    loadn r1, #40
    cmp r0, r1
    cle acaba_tiro
    jle fim_moveTiroUP_Down

    loadn r1, #1120
    cmp r0, r1
    cgr acaba_tiro
    jgr fim_moveTiroUP_Down

    storei r7, r0

    cmp r0, r5
    ceq acaba_tiro
    ceq kill

    inc r0
    cmp r0, r5
    ceq acaba_tiro
    ceq kill

    dec r0
    dec r0
    cmp r0, r5
    ceq acaba_tiro
    ceq kill

fim_moveTiroUP_Down:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

acaba_tiro:
    loadn r2, #1
    storei r6, r2
    rts
;              FIM MOVE TIRO UP OU DOWN
;========================================================;

;========================================================;
;                MOVE TIRO RIGHT OU LEFT
; <- r7 = endereco da posicao do tiro
; <- r6 = endereco da direcao do tiro
; <- r5 = posicao do boneco inimigo
MoveTiroRIGHT_LEFT:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadi r0, r7
    loadi r1, r6

    loadn r2, #4
    cmp r1, r2
    jne MoveTiroLeft
    inc r0              ; RIGHT
    jmp continuaTiroRIGHT_LEFT

MoveTiroLeft:
    dec r0              ; LEFT

continuaTiroRIGHT_LEFT:
    loadn r1, #1
    loadn r2, #40
    mod r2, r0, r2
    cmp r2, r1
    cle acaba_tiro
    jle fim_moveTiroRIGHT_LEFT

    loadn r1, #38
    cmp r2, r1
    cgr acaba_tiro
    jgr fim_moveTiroRIGHT_LEFT

    storei r7, r0

    cmp r0, r5
    ceq acaba_tiro
    ceq kill

    loadn r2, #40
    add r0, r0, r2
    cmp r0, r5
    ceq acaba_tiro
    ceq kill

    sub r0, r0, r2
    sub r0, r0, r2
    cmp r0, r5
    ceq acaba_tiro
    ceq kill

fim_moveTiroRIGHT_LEFT:
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;             FIM MOVE TIRO RIGHT OU LEFT
;========================================================;

;========================================================;
;                    COMPARA TIROS
compara_tiros:
    push r1
    push r2
    push r6
    push r7

    load r1, dirTiro1
    loadn r2, #1
    cmp r1, r2
    jeq nao_comparaTiros

    load r1, dirTiro2
    cmp r1, r2
    jeq nao_comparaTiros

    load r1, posTiro1
    load r2, posTiro2
    cmp r1, r2
    loadn r7, #posTiro1
    loadn r6, #dirTiro1
    ceq ApagaTiro
    ceq acaba_tiro
    loadn r7, #posTiro2
    loadn r6, #dirTiro2
    ceq ApagaTiro
    ceq acaba_tiro

nao_comparaTiros:
    pop r7
    pop r6
    pop r2
    pop r1
    rts
;                  FIM COMPARA TIROS
;========================================================;

;========================================================;
;                         KILL
; <- r5 = posicao do boneco que morreu
kill:
    push r1
    push r2
    push r6

    load r1, posPlayer
    cmp r1, r5
    jne kill_Bot

    loadn r6, #posPlayerAnt
    jmp playerPerdeu

kill_Bot:
    loadn r6, #posBotAnt
    jmp botPerdeu

    pop r6
    pop r2
    pop r1
    rts
;                       FIM KILL
;========================================================;

playerPerdeu:
    loadn r1, #0
    loadn r2, #20
loop_playerperdeu:
    call Delay
    inc r1
    cmp r1, r2
    jle loop_playerperdeu
    call ApagaTela
    call ImprimeBotGanhou
    call jogar_novamente
    jmp main

botPerdeu:
    loadn r1, #0
    loadn r2, #20
loop_botperdeu:
    call Delay
    inc r1
    cmp r1, r2
    jle loop_botperdeu
    call ApagaTela
    call ImprimePlayerGanhou
    call jogar_novamente
    jmp main

jogar_novamente:
    loadn r2, #' '
loop_jogarNovamente:
    inchar r1
    cmp r2, r1
    jne loop_jogarNovamente
    rts

;========================================================;
;                    IMPRIME FUNDO
ImprimeFundo:
    push r1
    push r2
    loadn r1, #fundoLinha0
    loadn r2, #0      ; cor branca
    call ImprimeTela
    pop r2
    pop r1
    rts
;                   FIM IMPRIME FUNDO
;========================================================;

;========================================================;
;                   IMPRIME TITULO
; Linhas 0-6:   SHINJUKU -> vermelho (#2560)
; Linhas 11-17: SHOWDOWN -> azul (#10240)
; Restante:     branco (#0)
ImprimeTitulo:
    push r0
    push r1
    push r2
    push r3

    loadn r1, #tituloLinha0  ; ponteiro para a primeira linha
    loadn r0, #0             ; posicao na tela (linha 0)
    loadn r3, #0             ; contador de linha

loop_titulo:
    ; Escolhe cor baseado no numero da linha (r3)
    loadn r2, #0             ; cor padrao = branco

    loadn r2, #6
    cmp r3, r2
    jgr titulo_check_showdown
    loadn r2, #2560          ; linhas 0-6: vermelho (SHINJUKU)
    jmp titulo_imprime

titulo_check_showdown:
    loadn r2, #10
    cmp r3, r2
    jgr titulo_check_showdown2
    loadn r2, #0             ; linhas 7-10: branco
    jmp titulo_imprime

titulo_check_showdown2:
    loadn r2, #17
    cmp r3, r2
    jgr titulo_branco
    loadn r2, #10240         ; linhas 11-17: azul (SHOWDOWN)
    jmp titulo_imprime

titulo_branco:
    loadn r2, #0             ; linhas 18-29: branco

titulo_imprime:
    call ImprimeLinha

    loadn r2, #40
    add r0, r0, r2
    add r1, r1, r2
    inc r3

    loadn r2, #30
    cmp r3, r2
    jne loop_titulo

    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                  FIM IMPRIME TITULO
;========================================================;

;========================================================;
;                IMPRIME PLAYER GANHOU
ImprimePlayerGanhou:
    push r1
    push r2
    loadn r1, #playerGanhouLinha0
    loadn r2, #10240
    call ImprimeTela
    pop r2
    pop r1
    rts
;              FIM IMPRIME PLAYER GANHOU
;========================================================;

;========================================================;
;                 IMPRIME BOT GANHOU
ImprimeBotGanhou:
    push r1
    push r2
    loadn r1, #botGanhouLinha0
    loadn r2, #2560
    call ImprimeTela
    pop r2
    pop r1
    rts
;               FIM IMPRIME BOT GANHOU
;========================================================;

;========================================================;
;                      IMPRIME TELA
; <- r1 = ponteiro para a primeira linha
; <- r2 = cor
ImprimeTela:
    push r0
    push r1
    push r2
    push r3
    push r4

    loadn r0, #0
    loadn r3, #40
    loadn r4, #1200

loop_imprimeTela:
    call ImprimeLinha
    add r0, r0, r3
    add r1, r1, r3
    cmp r0, r4
    jne loop_imprimeTela

    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                    FIM IMPRIME TELA
;========================================================;

;========================================================;
;                     IMPRIME LINHA
; <- r0 = posicao de inicio
; <- r1 = endereco da string
; <- r2 = cor
ImprimeLinha:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6

    loadn r4, #38
    loadn r5, #0
    loadn r6, #' '

loop_imprimeLinha:
    loadi r3, r1
    cmp r3, r6
    jeq continua_imprimeLinha
    add r3, r2, r3
    outchar r3, r0
    nop
    nop
    nop
    nop
    nop
    nop

continua_imprimeLinha:
    inc r0
    cmp r5, r4
    inc r5
    jeq loop_imprimeLinha
    inc r1
    cmp r5, r4
    jel loop_imprimeLinha

    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;                   FIM IMPRIME LINHA
;========================================================;

;========================================================;
;                       APAGA TELA
ApagaTela:
    push r0
    push r1

    loadn r0, #1200
    loadn r1, #' '

ApagaTela_Loop:
    dec r0
    outchar r1, r0
    jnz ApagaTela_Loop

    pop r1
    pop r0
    rts
;                    FIM APAGA TELA
;========================================================;

;========================================================;
;                         DELAY
Delay:
    push r0
    push r1

    loadn r0, #60
loop_delay1:
    loadn r1, #300
loop_delay2:
    dec r1
    jnz loop_delay2
    dec r0
    jnz loop_delay1

    pop r1
    pop r0
    rts
;                       FIM DELAY
;========================================================;