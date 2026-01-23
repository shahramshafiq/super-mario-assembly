
INCLUDE Irvine32.inc
INCLUDELIB kernel32.lib
INCLUDELIB winmm.lib

PlaySoundA PROTO, pszSound:ptr byte, hmod:dword, fdwSound:dword

.data

;sound variables
bgmusicfile byte "background.wav",0
jumpsoundfile byte "jump.wav",0
coinsoundfile byte "coin.wav",0
enemysoundfile byte "enemy.wav",0
powerupsoundfile byte "powerup.wav",0
lifelostsoundfile byte "lifelost.wav",0
flagpolesoundfile byte "flagpole.wav",0
SND_LOOP equ 00000008h
SND_ASYNC equ 00000001h
SND_FILENAME equ 00020000h
SND_NOSTOP equ 00000010h  
SND_RESOURCE equ 00040004h
SND_MEMORY equ 00000004h
SND_PURGE equ 00000040h
musicPlaying byte 0
musicCounter byte 0

;ground (present in 24th row)
ground byte "################################################################################",0

;display variables
mariodisplay byte "MARIO",0
worlddisplay byte "WORLD 1-1",0
worlddisplay2 byte "WORLD 1-2",0
timedisplay byte "TIME",0
coinsdisplay byte "COINS",0
livesdisplay byte "LIVES",0

score dword 0
highscore dword 0
coins byte 0
timeleft dword 300
lives byte 5    
coinvalue equ 200

;player position
xposition byte 13
yposition byte 23          

inputchar byte ?
gamestate byte 0
menuchoice byte ?

rectangleleftx equ 25      
rectanglerightx equ 40    
rectangletopy equ 18    
rectanglefloory equ rectangletopy-1

;coin data
coincount byte 10  
coinx byte 20, 35, 52, 40, 68, 15, 45, 60, 72, 30
coiny byte 19, 17, 23, 12, 15, 21, 16, 14, 18, 11
coinactive byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1  

;question marks
blockcount byte 4
blockx byte 25, 45, 55, 30
blocky byte 15, 13, 18, 10
blockcharacter byte "?",0

;for decor
decorplatform1 byte "########",0
decorplatform2 byte "######",0
decorplatform3 byte "#########",0
decorplatform4 byte "#######",0
decorplatform5 byte "########",0
decorplatform6 byte "######",0

;positions of decor
decorplatform1x equ 12
decorplatform1y equ 18
decorplatform2x equ 32
decorplatform2y equ 16
decorplatform3x equ 48
decorplatform3y equ 19
decorplatform4x equ 20
decorplatform4y equ 14
decorplatform5x equ 60
decorplatform5y equ 17
decorplatform6x equ 38
decorplatform6y equ 21

;platforms
realplatform1 byte "===|?o====",0
realplatform2 byte "===|?|====",0
realplatform3 byte "===|?o====",0
realplatform4 byte "===|?|====",0
realplatform5 byte "===|?|====",0
realplatform6 byte "===|?o====",0
realplatform7 byte "===|?|====",0
realplatform8 byte "===|?o====",0

realplatform1x equ 10
realplatform1y equ 19
realplatform2x equ 25
realplatform2y equ 17
realplatform3x equ 40
realplatform3y equ 15
realplatform4x equ 55
realplatform4y equ 18
realplatform5x equ 20
realplatform5y equ 13
realplatform6x equ 60
realplatform6y equ 14
realplatform7x equ 35
realplatform7y equ 20
realplatform8x equ 45
realplatform8y equ 16

realplatform1end equ realplatform1x + 9
realplatform1floory equ realplatform1y - 1
realplatform2end equ realplatform2x + 9
realplatform2floory equ realplatform2y - 1
realplatform3end equ realplatform3x + 9
realplatform3floory equ realplatform3y - 1
realplatform4end equ realplatform4x + 9
realplatform4floory equ realplatform4y - 1
realplatform5end equ realplatform5x + 9
realplatform5floory equ realplatform5y - 1
realplatform6end equ realplatform6x + 9
realplatform6floory equ realplatform6y - 1
realplatform7end equ realplatform7x + 9
realplatform7floory equ realplatform7y - 1
realplatform8end equ realplatform8x + 9
realplatform8floory equ realplatform8y - 1

;power-up data
powercount byte 8
powerx byte realplatform1x+3, realplatform2x+3, 26, 46, 56, 31, realplatform3x+3, realplatform6x+3
powery byte realplatform1y,   realplatform2y,   15, 13, 18, 10, realplatform3y,   realplatform6y
poweractive byte 1, 1, 1, 1, 1, 1, 1, 1
powertype byte 0, 0, 0, 0, 0, 0, 1, 1
powermessage byte "POWER UP! +1 LIFE",0

;hills
hillfirstline byte " _____ ",0
hillsecondline byte "|     |",0
hillthirdline byte "|     |",0
hillfourthline byte "|     |",0

;decor triangles
decorsmalltrianglefirstline byte "  /\\  ",0
decorsmalltrianglesecondline byte " /  \\ ",0
decorsmalltrianglethirdline byte "/____\\",0

decorlargetrianglefirstline byte "   /\\   ",0
decorlargetrianglesecondline byte "  /  \\  ",0
decorlargetrianglethirdline byte " /    \\ ",0
decorlargetrianglefourthline  byte "/______\\",0

;cloud patterns
largecloudfirstline byte "  ___  ",0
largecloudsecondline byte " (   ) ",0
largecloudthirdline byte "(_____)",0

smallcloudfirstline byte " ____ ",0
smallcloudsecondline byte "(    )",0

;for menu screen
supertitlelineone byte " _____  _    _ _____  ______ _____  ",0
supertitlelinetwo byte "/ ____ | |  | |  __ \|  ____|  __ \ ",0
supertitlelinethree byte "| (___ | |  | | |__) | |__  | |__) |",0
supertitlelinefour byte " \___ \| |  | |  ___/|  __| |  _  / ",0
supertitlelinefive byte " ____) | |__| | |    | |____| | \ \ ",0
supertitlelinesix byte "|_____/ \____/|_|    |______|_|  \_\",0

mariotitlelineone byte "  __  __          _____  _____ ____  ",0
mariotitlelinetwo byte " |  \/  |   /\   |  __ \|_   _/ __ \ ",0
mariotitlelinethree byte " | \  / |  /  \  | |__) | | || |  | |",0
mariotitlelinefour byte " | |\/| | / /\ \ |  _  /  | || |  | |",0
mariotitlelinefive byte " | |  | |/ ____ \| | \ \ _| || |__| |",0
mariotitlelinesix byte " |_|  |_/_/    \_\_|  \_\_____\____/ ",0

brostitlelineone byte " ____  _____   ____  _____ ",0
brostitlelinetwo byte "|  _ \|  __ \ / __ \/ ____|",0
brostitlelinethree byte "| |_) | |__) | |  | | (___  ",0
brostitlelinefour byte "|  _ <|  _  /| |  | |\___ \ ",0
brostitlelinefive byte "| |_) | | \ \| |__| |____) |",0
brostitlelinesix byte "|____/|_|  \_\\____/|_____/ ",0

welcomerollnumber byte "               Roll No: 24I-2541                   ",0
welcomeprompt byte "       >>> Press ANY KEY to Start the Game <<<     ",0
welcomeextramessage byte "           (c) 2025 Assembly Edition               ",0

menuline1 byte "+================================================================+",0
menuline2 byte "+================================================================+",0
menuline3 byte "|                                                                |",0
menuline4 byte "|            <==>  M A I N   M E N U  <==>                       |",0
menuline5 byte "|----------------------------------------------------------------|",0
menuline6 byte "|      [1] >> START GAME     - Begin Your Adventure              |",0
menuline7 byte "|      [2] >> HIGH SCORE     - View Your Best Run                |",0
menuline8 byte "|      [3] >> INSTRUCTIONS   - Learn The Controls                |",0
menuline9 byte "|      [4] >> EXIT           - Return to Reality                 |",0
menuline10  byte "|                                                                |",0
menuline11 byte "|          Press 1, 2, 3, or 4...                                |",0

;instructions page
instructionsline1 byte "+================================================================+",0
instructionsline2 byte "+================================================================+",0
instructionsline3 byte "|                                                                |",0
instructionsline4 byte "|          <==>  I N S T R U C T I O N S  <==>                   |",0
instructionsline5 byte "|----------------------------------------------------------------|",0
instructionsline6 byte "|   >> MOVEMENT:  A - Left / D - Right                           |",0
instructionsline7 byte "|   >> JUMP:      w = Short Jump,  W = High Jump                 |",0
instructionsline8 byte "|   >> PAUSE:     Press 'P' anytime during gameplay              |",0
instructionsline9 byte "|   >> COINS:     Collect (o) to boost your score!               |",0
instructionsline10 byte "|   >> EXIT:      Press 'X' to quit game                         |",0
instructionsline11 byte "|                                                                |",0
instructionsline12 byte "|          Press 'B' to return to Main Menu                      |",0

;pause menu
pausemenuline1 byte "+================================================================+",0
pausemenuline2 byte "+================================================================+",0
pausemenuline3 byte "|                                                                |",0
pausemenuline4 byte "|             <==>  GAME PAUSED  <==>                            |",0
pausemenuline5 byte "|----------------------------------------------------------------|",0
pausemenuline6 byte "|         [1] >> RESUME      - Continue Playing                  |",0
pausemenuline7 byte "|         [2] >> MAIN MENU   - Return to Menu                    |",0
pausemenuline8 byte "|                                                                |",0
pausemenuline9 byte "|            Press 1 or 2...                                     |",0

;high score data
highscoremenuline1 byte "+================================================================+",0
highscoremenuline2 byte "+================================================================+",0
highscoremenuline3 byte "|             <==>  H I G H   S C O R E  <==>                    |",0
highscoremenuline4 byte "|----------------------------------------------------------------|",0
;highscoremenuline5 byte "|    Your Best Score So Far:                                     |",0
highscoremenuline6 byte "|                                                                |",0
highscoremenuline7 byte "|       Press 'B' to return to Main Menu                         |",0

;decor purposes
topdecor1 byte "################################################################################",0
topdecor2 byte "********************************************************************************",0

;pipe boundaries
hill1leftbound byte 18
hill1rightbound byte 24
hill1topbound byte 20      
hill1bottombound byte 24

hill2leftbound byte 70
hill2rightbound byte 76
hill2topbound byte 21      
pipe2Bottom byte 24

;flagpole data
flagpolex byte 79

;level completion data
levelcompletionmenuline1 byte "********************************************************************************",0
levelcompletionmenuline2 byte "*                                                                              *",0
levelcompletionmenuline3 byte "*                          CONGRATULATIONS!                                    *",0

levelcompletionmenuline4 byte "  _       _______          _ ______ _      ",0
levelcompletionmenuline5 byte " | |     |  ____\\        //| _____|||     ",0
levelcompletionmenuline6 byte " | |     | |____ \\      // | |____ ||     ",0
levelcompletionmenuline7 byte " | |     |  ____| \\    //  |  ____|||     ",0
levelcompletionmenuline8 byte " | |____ | |____   \\  //   | |_____||______ ",0
levelcompletionmenuline9 byte " |______||______|   \\//    |_______||______|",0

levelcompletionmenuline10 byte "   ____   ____  ___  __  _____  _      ______  _______  ______ ",0
levelcompletionmenuline11 byte "  / ___| /____\|  \\/  ||  __ || |    |  ____||__   __||  ____|",0
levelcompletionmenuline12 byte " | |    ||    || \\  / |||__| || |    | |____    | |   | |____ ",0
levelcompletionmenuline13 byte " | |    ||    || |\\/| || ___/ | |    |  ____|   | |   |  ____|",0
levelcompletionmenuline14 byte " | |___ ||____|| |  || ||      | |____| |____    | |   | |____ ",0
levelcompletionmenuline15 byte "  \\____|\\___/|_|  || ||      |______|______|   |_|   |______|",0

levelcompletionmenuline16 byte "          *  .  *  .  *  .  *  .  *  .  *  .  *  .  *  .  *         ",0
levelcompletionmenuline17 byte "       .  *  .  *  .  *  .  *  .  *  .  *  .  *  .  *  .  *  .      ",0

levelcompletionmenuline18 byte "               *           *           *           *                ",0
levelcompletionmenuline19 byte "            *     *     *     *     *     *     *     *             ",0
levelcompletionmenuline20 byte "         *           *           *           *           *          ",0

levelScoreMsg byte "                  YOUR SCORE:                   ",0
levelcompletionmenuline21 byte "              COINS COLLECTED:                  ",0
levelcompletionmenuline22 byte "              TIME REMAINING:                   ",0

levelcompletionmenuline23 byte "          >>> Press ENTER to Continue to Level 2 <<<       ",0
levelcompletionmenuline24 byte "          >>> Press ESC to Return to Main Menu <<<         ",0

levelcompletionmenuline25 byte "         =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=          ",0
levelcompletionmenuline26 byte "              YOU HAVE BEATEN LEVEL 1!                     ",0
levelcompletionmenuline27 byte "         =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=          ",0

;enemy data
enemyCount byte 5
enemyx byte 12, 27, 42, 57, 70  
enemyy byte 18, 16, 14, 17, 23  
enemyactive byte 1, 1, 1, 1, 1        
enemydirection byte 1, -1, 1, -1, -1    
enemyminxcoordinate byte 10, 25, 40, 55, 0    
enemymaxxcoordinate byte 19, 34, 49, 64, 79  

enemyshellactive byte 0, 0, 0, 0, 0    
enemyhitcount byte 0, 0, 0, 0, 0     ;0=alive, 1=shell, 2=dead
shellmsg byte "SHELL KICKED! +100", 0

;life lost message
lifelostmessage byte "You lost 1 life! Be careful!",0

;enemy movement timing
enemymovementcounter byte 0
enemymovementdelay byte 200    ;higher value means enemies move slower

;game over screen
gameovermenuline1 byte "********************************************************************************",0
gameovermenuline2 byte "*                                                                              *",0
gameovermenuline3 byte "*                           G A M E   O V E R                                  *",0
gameovermenuline4 byte "*                                                                              *",0
gameovermenuline5 byte "          You ran out of lives! Better luck next time!          ",0
gameovermenuline6 byte "                  Press any key to continue...                  ",0

;enemy destroyed message
enemydestroyedmessage byte "Enemy destroyed! +300 points!",0

;jump state data
jumpstate byte 0      ;0 means no jump, 1 means short jump, 2 means high jump
jumpcounter byte 0
jumpheight byte 0

;timer data
timercounter byte 0
timerdelay byte 60    ;higher value means slow timer and vice versa
timeovermessage byte "TIME OVER! You lost 1 life!",0

;file handling data
playername byte 50 DUP(0)
namepromptmessage byte "Enter your name: ",0
welcomemessageprompt byte "Welcome, ",0
filename byte "players.txt",0
filehandle dword ?
newlinecharacter byte 13,10,0
scorebuffer byte 20 DUP(0)
spacesbetweenentries byte "    ",0
   
;leaderboard data
totalplayers equ 50              
playernamelength equ 50            

;arrays to store player records
allplayernames byte totalplayers * playernamelength DUP(0)  
allplayerscores dword totalplayers DUP(0)                  
playerrecordcount byte 0                                  

;temporary data
tempnamestorage byte 50 DUP(0)
tempscorestorage byte 20 DUP(0)
tempscore dword 0

;for file parsing
bufferindex dword 0
bytesread dword 0
filebuffer byte 2000 DUP(0)
tempnamestoragebuffer byte 50 DUP(0)      

;leaderboard display
leaderboardmenuline1 byte "           =-=-= L E A D E R B O A R D =-=-=",0
noscorescurrentlymessage byte "           No scores recorded yet. Be the first!",0
rank1 byte "1. ",0
rank2 byte "2. ",0
rank3 byte "3. ",0
rank4 byte "4. ",0
rank5 byte "5. ",0

;save game data
currentlevel byte 1
levelsofallplayers byte totalplayers DUP(0)
templevel byte 0
currentlysavedscore dword 0
checkifplayerexists byte 0
indexofplayerfound byte 0
       
resumefromlevelline1 byte "+================================================================+",0
resumefromlevelline2 byte "+================================================================+",0
resumefromlevelline3 byte "|          <==>  WELCOME BACK!  <==>                             |",0
resumefromlevelline4 byte "|----------------------------------------------------------------|",0
resumefromlevelline5 byte "|   Your previous game was found!                                |",0
resumefromlevelline6 byte "|   You were on Level 2 with score:   ",0
resumefromlevelline7 byte "|                                                                |",0
resumefromlevelline8 byte "|      [1] >> RESUME     - Continue from Level 2                 |",0
resumefromlevelline9 byte "|      [2] >> RESTART    - Start fresh from Level 1              |",0
resumefromlevelline10 byte "|                                                                |",0
resumefromlevelline11 byte "|          Press 1 or 2 to continue...                           |",0
newplayermessage byte "New player detected! Starting fresh...",0

;golden mushroom powerup
goldenmushroomsprite1 byte "(",0
goldenmushroomsprite2 byte ")",0
goldenmushroommessage byte "GOLDEN MUSHROOM!+1000 points,5s invincibility",0

;golden mushroom positions
goldenmushroomcount byte 2
goldenmushroomx byte realplatform3x+3, realplatform6x+3
goldenmushroomy byte realplatform3y, realplatform6y
goldenmushroomactive byte 1, 1

;invincibility data
invincible byte 0
invinciblecounter dword 0
invincibleduration equ 3000    ;3000 frames means 50 seconds as 1 sec = 60fps

;golden glow effect
powerupglowcounter byte 0
powerupglowcolors byte yellow, white, lightRed, white
mariocolor dword lightGreen + (lightBlue * 16)   ;current mario colour

;level2 decor
level2data byte 0; ===================== LEVEL 2 (UNDERGROUND) DATA =====================
tunnelceilinghashesline byte "############################################################################",0
tunneldecor1 byte "#                                                                          #",0
tunneldecor2 byte "#        ||||            ||||                   ||||            ||||       #",0
tunnelplatform1 byte "[===]",0
tunnelplatform2 byte "[===]",0
tunnelplatform3 byte "[===]",0
tunnelplatform4 byte "[===]",0
lampline1 byte "  \ /  ",0
lampline2 byte "   *   ",0
enemylevel2 byte "EE",0
scorelabellevel2 byte "SCORE:",0
highlabellevel2 byte "HIGH :",0
coinslabellevel2 byte "COINS:",0
liveslabellevel2 byte "LIVES:",0
timelabellevel2 byte "TIME :",0

lavaline1 byte "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*",0
lavaline2 byte "*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~",0
lavaanimframe byte 0
lavacolors byte lightRed, yellow, lightRed, yellow  ; color cycle array

;secret area data
secretareax byte 2
secretareay byte 15
secretareawidth byte 8
secretareaheight byte 8
secretareaactive byte 1
secretareaentered byte 0

;secret area platforms
secretplatform1 byte "====", 0
secretplatform2 byte "====", 0
secretplatform3 byte "====", 0

secretplatform1x byte 2
secretplatform1y byte 20
secretplatform2x byte 4
secretplatform2y byte 17
secretplatform3x byte 2
secretplatform3y byte 14

; Secret coins
secretcoin1x byte 3
secretcoin1y byte 19
secretcoin2x byte 5
secretcoin2y byte 16
secretcoin3x byte 3
secretcoin3y byte 13
secretcoin1active byte 1
secretcoin2active byte 1
secretcoin3active byte 1

;secret area messages
secretfoundmsg byte "SECRET AREA FOUND! +500", 0
secretcolor dword ?

;game complete data
gamecompletemenuline1 byte "    *  .  *    .   *  .    *   .  *    .   *  .    *   .  *    .   *    ",0
gamecompletemenuline2 byte "  .    *    .   *    .  *    .   *   .   *    .  *    .   *   .   *     ",0
gamecompletemenuline3 byte "================================================================================",0
gamecompletemenuline4 byte "|                                                                              |",0
gamecompletemenuline5 byte "********************************************************************************",0
gamecompletemenuline6 byte "   ####    ####   #   #  ####  #####    #   #####  ####  ",0
gamecompletemenuline7 byte "  #    #  #    #  ##  #  #     #   #   # #    #    #     ",0
gamecompletemenuline8 byte "  #       #    #  # # #  # ##  ####   #   #   #    #### ",0
gamecompletemenuline9 byte "  #    #  #    #  #  ##  #  #  #  #   #####   #       # ",0
gamecompletemenuline10 byte "   ####    ####   #   #  ####  #   #  #   #   #    #### ",0

gamecompletemenuline11 byte "  #   #   ####   #   #     #   #   #  #  #   #  #",0
gamecompletemenuline12 byte "   # #   #    #  #   #     #   #   #  #  ##  #  #",0
gamecompletemenuline13 byte "    #    #    #  #   #     #   #   #  #  # # #  #",0
gamecompletemenuline14 byte "    #    #    #  #   #     #   # # #  #  #  ##   ",0
gamecompletemenuline15 byte "    #     ####    ###      # # # # #  #  #   #  #",0

gamecompletemenuline16 byte "   ####      #     #       #  #####     ####   ####   #   #  #####  #      #####  #####  #####",0
gamecompletemenuline17 byte "  #    #    # #    ##     ##  #        #    # #    #  ## ##  #   #  #      #        #    #    ",0
gamecompletemenuline18 byte "  #        #   #   # #   # #  ####     #      #    #  # # #  ####   #      ####     #    #### ",0
gamecompletemenuline19 byte "  #  ###  #######  #  # #  #  #        #    # #    #  #   #  #      #      #        #    #    ",0
gamecompletemenuline20 byte "   ####  #       # #   #   #  #####     ####   ####   #   #  #      #####  #####    #    #####",0

;grophy
trophyline1 byte "           ___________          ",0
trophyline2 byte "          '._==_==_=_.'         ",0
trophyline3 byte "          .-\\:      /-.        ",0
trophyline4 byte "         | (|:.     |) |        ",0
trophyline5 byte "          '-|:.     |-'         ",0
trophyline6 byte "            \\::.    /          ",0
trophyline7 byte "             '::. .'            ",0
trophyline8 byte "               ) (              ",0
trophyline9 byte "             _.' '._            ",0
trophyline10 byte "            '-------'           ",0

finalscoreaftergamecompletemessage byte "                    FINAL SCORE: ",0
finalcoinsaftergamecompletemessage byte "                    COINS COLLECTED: ",0
thankyouaftergamecompletemessage byte "              THANK YOU FOR PLAYING SUPER MARIO BROS!",0
presskeyaftergamecompletemessage byte "                  Press ANY KEY to close the window...",0

firework1 byte "        *  .  *     ",0
firework2 byte "     .  * \\|/ *  . ",0
firework3 byte "    *  . -O- .  *  ",0
firework4 byte "     .  * /|\\  * . ",0
firework5 byte "        *  .  *     ",0

;supermario data
mariosize byte 1    ;1 means it is stacked, 2 means it is not
supermushroomcount byte 3
supermushroomxposition byte 25, 45, 65
supermushroomyposition byte 14, 12, 16
supermushroomactive byte 1, 1, 1
superpowermessage byte " SUPER MARIO! ",0
sizedownmessage byte " SIZE DOWN! ",0
supermushroomsprite byte "())",0
 
;code section starts here
.code

;super mushroom procedures
drawsupermushrooms PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, supermushroomcount
    mov esi, 0
   
dsm_loop:
    cmp esi, ecx
    jge dsm_done
    mov al, supermushroomactive[esi]
    cmp al, 0
    je dsm_next
   
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, supermushroomxposition[esi]
    mov dh, supermushroomyposition[esi]
    call Gotoxy
    mov edx, OFFSET supermushroomsprite
    call WriteString              
   
dsm_next:
    inc esi
    jmp dsm_loop
   
dsm_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawsupermushrooms ENDP

checksupermushroom PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    mov al, currentlevel
    cmp al, 2
    jne csmc_done
   
    mov al, mariosize
    cmp al, 2
    jge csmc_done
   
    movzx ecx, supermushroomcount
    mov esi, 0
   
csmc_loop:
    cmp esi, ecx
    jge csmc_done
   
    mov al, supermushroomactive[esi]
    cmp al, 0
    je csmc_next
   
    mov al, xposition
    mov bl, supermushroomxposition[esi]
    cmp al, bl
    jge csmc_xright

    sub bl, al                      
    jmp csmc_xcheck
   
csmc_xright:
    sub al, bl                      
    mov bl, al
   
csmc_xcheck:
    cmp bl, 3                      
    ja csmc_next
   
    mov al, yposition
    mov dl, supermushroomyposition[esi]
    cmp al, dl
    jge csmc_ybelow
    sub dl, al                      
    jmp csmc_ycheck
   
csmc_ybelow:
    sub al, dl                      
    mov dl, al
   
csmc_ycheck:
    cmp dl, 3                    
    ja csmc_next
   
    mov supermushroomactive[esi], 0
    mov mariosize, 2
    push eax
    push ecx
    mov eax, black + (black * 16)
    call SetTextColor
    mov dl, supermushroomxposition[esi]
    mov dh, supermushroomyposition[esi]
    call Gotoxy
    mov ecx, 3  
   
csmc_eraseloop:
    mov al, ' '
    call WriteChar
    loop csmc_eraseloop
    pop ecx
    pop eax
    
    mov ebx, 1000
    mov eax, ebx
    add score, eax

    call playsoundpowerup
    call showsuperpowermsg
    call drawhud
    jmp csmc_done
   
csmc_next:
    inc esi
    jmp csmc_loop
   
csmc_done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
checksupermushroom ENDP

;power up message
showsuperpowermsg PROC
    push eax
    push edx
    push ebx
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET superpowermessage
    call WriteString
    mov ecx, 2

spm_flash:
    push ecx
    mov eax, 200
    call Delay
   
    mov eax, black + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET superpowermessage
    call WriteString
   
    mov eax, 150
    call Delay
   
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET superpowermessage
    call WriteString
   
    pop ecx
    loop spm_flash
   
    mov eax, black + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov ecx, 20

spm_clear:
    mov al, ' '
    call WriteChar
    loop spm_clear
 
    pop ebx
    pop edx
    pop eax
    ret
showsuperpowermsg ENDP

showsizedownmsg PROC
    push eax
    push edx
    push ecx
   
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET sizedownmessage
    call WriteString
   
    mov eax, 300
    call Delay
   
    mov eax, black + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov ecx, 20

sdm_clear:
    mov al, ' '
    call WriteChar
    loop sdm_clear
   
    pop ecx
    pop edx
    pop eax
    ret
showsizedownmsg ENDP

;game complete
displaygamecomplete PROC
    push eax
    push ecx
    push edx
    push ebx
    ;mov ebx, 0
    call saveplayertofile
    call stopmusic
    call clearblackscreen

    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline1
    call WriteString
   
    mov dl, 0
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline2
    call WriteString

    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline3
    call WriteString

    mov eax, lightMagenta + (black * 16)
    call SetTextColor
   
    mov dl, 10
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline6
    call WriteString
    call shortdelay
   
    mov dl, 10
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline7
    call WriteString
    call shortdelay
   
    mov dl, 10
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline8
    call WriteString
    call shortdelay
   
    mov dl, 10
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline9
    call WriteString
    call shortdelay
   
    mov dl, 10
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline10
    call WriteString
    call mediumdelay

    mov eax, lightGreen + (black * 16)
    call SetTextColor
   
    mov dl, 15
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline11
    call WriteString
    call shortdelay
   
    mov dl, 15
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline12
    call WriteString
    call shortdelay
   
    mov dl, 15
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline13
    call WriteString
    call shortdelay
   
    mov dl, 15
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline14
    call WriteString
    call shortdelay
   
    mov dl, 15
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline15
    call WriteString
    call mediumdelay
   
    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 25
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET trophyline1
    call WriteString
   
    add dl, 0
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET trophyline2
    call WriteString
   
    mov dl, 25
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET trophyline3
    call WriteString
   
    mov dl, 25
    mov dh, 18
    call Gotoxy
    mov edx, OFFSET trophyline4
    call WriteString
   
    mov dl, 25
    mov dh, 19
    call Gotoxy
    mov edx, OFFSET trophyline5
    call WriteString
   
    mov dl, 25
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET trophyline6
    call WriteString
   
    mov dl, 25
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET trophyline7
    call WriteString
   
    mov dl, 25
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET trophyline8
    call WriteString
   
    mov dl, 25
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET trophyline9
    call WriteString
   
    mov dl, 25
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET trophyline10
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 2
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET finalscoreaftergamecompletemessage
    call WriteString
   
    mov eax, score
    call WriteDec

    mov dl, 2
    mov dh, 18
    call Gotoxy
    mov edx, OFFSET finalcoinsaftergamecompletemessage
    call WriteString
   
    movzx eax, coins
    call WriteDec
   
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 10
    mov dh, 26
    call Gotoxy
    mov edx, OFFSET thankyouaftergamecompletemessage
    call WriteString

    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 27
    call Gotoxy
    mov edx, OFFSET gamecompletemenuline3
    call WriteString
   
    mov ecx, 3

blink_prompt:
    push ecx
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 29
    call Gotoxy
    mov edx, OFFSET presskeyaftergamecompletemessage
    call WriteString
    call mediumdelay
    mov eax, black + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 29
    call Gotoxy
    mov edx, OFFSET presskeyaftergamecompletemessage
    call WriteString
    call shortdelay
    pop ecx
    loop blink_prompt

    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 29
    call Gotoxy
    mov edx, OFFSET presskeyaftergamecompletemessage
    call WriteString
    call ReadChar

    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
displaygamecomplete ENDP

;level2 layout
drawlava PROC
    push eax
    push ebx
    push ecx
    push edx
    
    ;increment animation frame
    inc lavaanimframe
    mov al, lavaanimframe
    and al, 3  ; Keep it 0-3
    mov lavaanimframe, al
    
    ;get current color from cycle
    movzx ebx, lavaanimframe
    mov al, lavacolors[ebx]
    movzx eax, al
    add eax, (black * 16)  ;lava color on black background
    call SetTextColor
    
    ;draw lava line 1 (row 26)
    mov dl, 0
    mov dh, 26
    call Gotoxy
    
    ;alternate between two wave patterns
    mov al, lavaanimframe
    and al, 1
    cmp al, 0
    je draw_pattern1
    
draw_pattern2:
    mov edx, OFFSET lavaline2
    call WriteString
    jmp draw_line2
    
draw_pattern1:
    mov edx, OFFSET lavaline1
    call WriteString
    
draw_line2:
    ;get color again for line 2
    movzx ebx, lavaanimframe
    mov al, lavacolors[ebx]
    movzx eax, al
    add eax, (black * 16)
    call SetTextColor
    
    ;draw lava line 2 (row 27)
    mov dl, 0
    mov dh, 27
    call Gotoxy
    
    ;opposite pattern for wave effect
    mov al, lavaanimframe
    and al, 1
    cmp al, 0
    je draw_pattern2_line2
    
draw_pattern1_line2:
    mov edx, OFFSET lavaline1
    call WriteString
    jmp lava_done
    
draw_pattern2_line2:
    mov edx, OFFSET lavaline2
    call WriteString
    
lava_done:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
drawlava ENDP

drawsecretarea PROC
    push eax
    push ebx
    push ecx
    push edx
    
    cmp secretareaactive, 0
    je dsa_done
    
    ;draw bg
   mov eax, lightCyan + (Gray * 16)
    call SetTextColor
    
    ; Draw top border
    mov dl, secretareax
    mov dh, secretareay
    call Gotoxy
    mov ecx, 8
dsa_topborder:
    mov al, '='
    call WriteChar
    loop dsa_topborder
    
    ; Draw side borders
    mov ecx, 6
    movzx edx, secretareay
    inc edx
dsa_sideborders:
    push ecx
    mov dh, dl
    movzx edx, secretareax
    mov dl, al
    call Gotoxy
    mov al, '|'
    call WriteChar
    
    movzx edx, secretareax
    add dl, 7
    call Gotoxy
    mov al, '|'
    call WriteChar
    
    pop ecx
    inc dh
    loop dsa_sideborders
    
    ; Draw platforms
    mov eax, gray + (brown * 16)
    call SetTextColor
    
    mov dl, secretplatform1x
    mov dh, secretplatform1y
    call Gotoxy
    mov edx, OFFSET secretplatform1
    call WriteString
    
    mov dl, secretplatform2x
    mov dh, secretplatform2y
    call Gotoxy
    mov edx, OFFSET secretplatform2
    call WriteString
    
    mov dl, secretplatform3x
    mov dh, secretplatform3y
    call Gotoxy
    mov edx, OFFSET secretplatform3
    call WriteString
    
    ; Draw secret coins
    mov eax, yellow + (black * 16) 
    call SetTextColor
    
    cmp secretcoin1active, 0
    je dsa_coin2
    mov dl, secretcoin1x
    mov dh, secretcoin1y
    call Gotoxy
    mov al, 'o'
    call WriteChar
    
dsa_coin2:
    cmp secretcoin2active, 0
    je dsa_coin3
    mov dl, secretcoin2x
    mov dh, secretcoin2y
    call Gotoxy
    mov al, 'o'
    call WriteChar
    
dsa_coin3:
    cmp secretcoin3active, 0
    je dsa_done
    mov dl, secretcoin3x
    mov dh, secretcoin3y
    call Gotoxy
    mov al, 'o'
    call WriteChar
    
dsa_done:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
drawsecretarea ENDP

checksecretareaentry PROC
    push eax
    push ebx
    push edx
    
    cmp secretareaactive, 0
    je csae_done
    
    cmp secretareaentered, 1
    je csae_checkcoins
    
    ;check if mario enters secret area
    mov al, xposition
    movzx ebx, secretareax
    cmp al, bl
    jb csae_done
    
    add bl, 8
    cmp al, bl
    ja csae_done
    
    mov al, yposition
    movzx ebx, secretareay
    cmp al, bl
    jb csae_done
    
    add bl, 8
    cmp al, bl
    ja csae_done
    
    ; Mario entered secret area!
    mov secretareaentered, 1
    call showsecretfoundmsg
    add score, 500
    call drawhud
    
csae_checkcoins:
    ;check coin1
    cmp secretcoin1active, 0
    je csae_coin2
    
    mov al, xposition
    mov bl, secretcoin1x
    sub al, bl
    cmp al, 1
    ja csae_coin2
    
    mov al, yposition
    mov bl, secretcoin1y
    sub al, bl
    cmp al, 1
    ja csae_coin2
    
    mov secretcoin1active, 0
    add score, 200
    call playcoinsound
    call drawhud
    
csae_coin2:
    ;check coin2
    cmp secretcoin2active, 0
    je csae_coin3
    
    mov al, xposition
    mov bl, secretcoin2x
    sub al, bl
    cmp al, 1
    ja csae_coin3
    
    mov al, yposition
    mov bl, secretcoin2y
    sub al, bl
    cmp al, 1
    ja csae_coin3
    
    mov secretcoin2active, 0
    add score, 200
    call playcoinsound
    call drawhud
    
csae_coin3:
    ;check coin3
    cmp secretcoin3active, 0
    je csae_done
    
    mov al, xposition
    mov bl, secretcoin3x
    sub al, bl
    cmp al, 1
    ja csae_done
    
    mov al, yposition
    mov bl, secretcoin3y
    sub al, bl
    cmp al, 1
    ja csae_done
    
    mov secretcoin3active, 0
    add score, 200
    call playcoinsound
    call drawhud
    
csae_done:
    pop edx
    pop ebx
    pop eax
    ret
checksecretareaentry ENDP

showsecretfoundmsg PROC
    push eax
    push edx
    push ecx
    
    mov eax, lightGreen + (lightBlue * 16)
    call SetTextColor
    
    mov dl, 20
    mov dh, 3
    call Gotoxy
    
    mov edx, OFFSET secretfoundmsg
    call WriteString
    
    mov ecx, 2
ssfm_flash:
    push ecx
    mov eax, 300
    call Delay
    
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET secretfoundmsg
    call WriteString
    
    mov eax, 200
    call Delay
    
    mov eax, lightGreen + (lightBlue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET secretfoundmsg
    call WriteString
    
    pop ecx
    loop ssfm_flash
    
    ;clear message
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 3
    call Gotoxy
    mov ecx, 30
ssfm_clear:
    mov al, ' '
    call WriteChar
    loop ssfm_clear
    
    pop ecx
    pop edx
    pop eax
    ret
showsecretfoundmsg ENDP

drawtunnelbg PROC
    push eax
    push ecx
    push edx
    push ebx
    mov eax, lightGray + (black * 16)
    call SetTextColor
    call Clrscr

    mov ebx, eax
    mov eax, gray + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET tunnelceilinghashesline
    call WriteString

    mov eax, Gray + (black * 16)
    call SetTextColor
    mov dh, 4
    mov ecx, 17
   
midline_loop:
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET tunneldecor1
    call WriteString
    inc dh
    ;dec dh
    ;inc dh
    loop midline_loop

    mov eax, Gray + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET tunneldecor2
    call WriteString

    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
drawtunnelbg ENDP

drawgroundlevel2 PROC
    push eax
    push ecx
    push edx
    push esi
    mov eax, gray + (black * 16)
    call SetTextColor
    mov dh, 24
    mov dl, 0
    call Gotoxy
    mov ecx, 80
    ;mov esi, 0

row24_draw:
    mov al, 176              
    call WriteChar
    loop row24_draw

    mov eax, Gray + (black * 16)
    call SetTextColor
    mov dh, 25
    mov dl, 0
    call Gotoxy
    mov ecx, 80

row25_draw:
    mov al, 219
    ;inc esi              
    call WriteChar
    loop row25_draw
    
    call drawlava

    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawgroundlevel2 ENDP

drawplatforms2 PROC
    push eax
    push edx
    push ecx
    mov eax, brown + (black * 16)
    call SetTextColor

    mov dl, 10
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET tunnelplatform1
    call WriteString

    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET tunnelplatform2
    call WriteString

    ;mov ecx, 0
    mov dl, 50
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET tunnelplatform3
    call WriteString

    mov dl, 65
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET tunnelplatform4
    call WriteString

    pop ecx
    pop edx
    pop eax
    ret
drawplatforms2 ENDP

drawquestionplatforms2 PROC
    push eax
    push edx
    push ebx

    mov eax, yellow + (black * 16)
    call SetTextColor

    mov dl, realplatform1x
    mov dh, realplatform1y
    call Gotoxy
    mov edx, OFFSET realplatform1
    call WriteString

    mov dl, realplatform2x
    mov dh, realplatform2y
    call Gotoxy
    mov edx, OFFSET realplatform2
    call WriteString

    mov ebx, edx
    mov dl, realplatform3x
    mov dh, realplatform3y
    call Gotoxy
    mov edx, OFFSET realplatform3
    call WriteString

    mov dl, realplatform4x
    mov dh, realplatform4y
    call Gotoxy
    mov edx, OFFSET realplatform4
    call WriteString

    mov dl, realplatform5x
    mov dh, realplatform5y
    call Gotoxy
    mov edx, OFFSET realplatform5
    call WriteString

    ;add dl, 0
    mov dl, realplatform6x
    mov dh, realplatform6y
    call Gotoxy
    mov edx, OFFSET realplatform6
    call WriteString

    mov dl, realplatform7x
    mov dh, realplatform7y
    call Gotoxy
    mov edx, OFFSET realplatform7
    call WriteString

    mov dl, realplatform8x
    mov dh, realplatform8y
    call Gotoxy
    mov edx, OFFSET realplatform8
    call WriteString

    pop ebx
    pop edx
    pop eax
    ret
drawquestionplatforms2 ENDP

drawpipes2 PROC
    push eax
    push edx
    push ecx

    mov eax, lightGreen + (black * 16)
    call SetTextColor

    mov dl, hill1leftbound
    mov dh, hill1topbound
    call Gotoxy
    mov edx, OFFSET hillfirstline
    call WriteString

    mov dl, hill1leftbound
    mov dh, hill1topbound+1
    call Gotoxy
    mov edx, OFFSET hillsecondline
    call WriteString

    mov ecx, edx
    mov dl, hill1leftbound
    mov dh, hill1topbound+2
    call Gotoxy
    mov edx, OFFSET hillthirdline
    call WriteString

    mov dl, hill1leftbound
    mov dh, hill1topbound+3
    call Gotoxy
    mov edx, OFFSET hillfourthline
    call WriteString

    ;sub dl, dl
    mov dl, hill2leftbound
    mov dh, hill2topbound
    call Gotoxy
    mov edx, OFFSET hillfirstline
    call WriteString

    mov dl, hill2leftbound
    mov dh, hill2topbound+1
    call Gotoxy
    mov edx, OFFSET hillsecondline
    call WriteString

    mov dl, hill2leftbound
    mov dh, hill2topbound+2
    call Gotoxy
    mov edx, OFFSET hillthirdline
    call WriteString

    pop ecx
    pop edx
    pop eax
    ret
drawpipes2 ENDP

drawflagpole2 PROC
    push eax
    push ecx
    push edx
    push ebx
    mov eax, white + (black * 16)
    call SetTextColor

    mov dl, flagpolex
    mov dh, 8
    call Gotoxy
    mov al, 'O'
    call WriteChar

    mov ebx, 15
    mov ecx, ebx          
    mov dh, 9

pole_loop:
    mov dl, flagpolex
    call Gotoxy
    mov al, '|'
    call WriteChar
    inc dh
    ;cmp dh, 24
    loop pole_loop

    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
drawflagpole2 ENDP

drawblocks2 PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    mov eax, yellow + (black * 16)
    call SetTextColor

    movzx ecx, blockcount
    mov esi, 0
    ;mov ebx, 0

block_draw_loop:
    cmp esi, ecx
    jge blocks_done

    mov dl, blockx[esi]
    mov dh, blocky[esi]
    call Gotoxy
    mov al, '['
    call WriteChar
    mov al, '?'
    call WriteChar
    mov al, ']'
    call WriteChar

    inc esi
    ;inc ebx
    jmp block_draw_loop

blocks_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawblocks2 ENDP

drawcoins2 PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, coincount
    mov esi, 0

coin_loop:
    cmp esi, ecx
    jge coins_done

    mov al, coinactive[esi]
    cmp al, 0
    je skip_coin

    mov dl, coinx[esi]
    mov dh, coiny[esi]
    mov eax, yellow + (black * 16)
    call SetTextColor
    call Gotoxy
    ;mov ebx, eax
    mov al, 'o'
    call WriteChar

skip_coin:
    inc esi
    jmp coin_loop

coins_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawcoins2 ENDP

showshellmsg PROC
    push eax
    push edx
    push ecx
    
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dl, 22
    mov dh, 3
    call Gotoxy
    
    mov edx, OFFSET shellmsg
    call WriteString
    
    mov ecx, 2
ssm_flash:
    push ecx
    mov eax, 200
    call Delay
    
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 22
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET shellmsg
    call WriteString
    
    mov eax, 150
    call Delay
    
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 22
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET shellmsg
    call WriteString
    pop ecx
    loop ssm_flash
    
    ;clear message
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 22
    mov dh, 3
    call Gotoxy
    mov ecx, 25
ssm_clear:
    mov al, ' '
    call WriteChar
    loop ssm_clear
    
    pop ecx
    pop edx
    pop eax
    ret
showshellmsg ENDP


drawenemies2 PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx

    movzx ecx, enemyCount
    mov esi, 0

enemy_loop:
    cmp esi, ecx
    jge enemies_done

    mov al, enemyactive[esi]
    cmp al, 0
    je next_enemy

    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call Gotoxy
    
    ;check if shell or normal enemy
    mov al, enemyshellactive[esi]
    cmp al, 1
    je draw_shell
    
    ;draw normal enemy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov al, 'E'
    call WriteChar
    mov al, 'E'
    call WriteChar
    jmp next_enemy
    
draw_shell:
    ;draw shell
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov al, '0'
    call WriteChar
    mov al, '0'
    call WriteChar

next_enemy:
    inc esi
    jmp enemy_loop

enemies_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawenemies2 ENDP


drawgoldenmushrooms2 PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx

    movzx ecx, goldenmushroomcount
    mov esi, 0

    inc powerupglowcounter
    ;mov ebx, 0

golden_loop:
    cmp esi, ecx
    jge golden_done

    mov al, goldenmushroomactive[esi]
    cmp al, 0
    je skip_golden

    mov al, powerupglowcounter
    and al, 3
    movzx ebx, al
    mov al, powerupglowcolors[ebx]
    movzx eax, al
    add eax, (black * 16)
    call SetTextColor

    mov dl, goldenmushroomx[esi]
    mov dh, goldenmushroomy[esi]
    call Gotoxy

    mov al, '('
    call WriteChar
    inc dl
    call Gotoxy
    mov al, ')'
    call WriteChar

skip_golden:
    inc esi
    ;dec esi
    ;inc esi
    jmp golden_loop

golden_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawgoldenmushrooms2 ENDP

drawplayer2 PROC
    push eax
    push ebx
    mov eax, mariocolor          
    and eax, 00FFh              
    add eax, (black * 16)
    ;mov ebx, eax    
    call SetTextColor
    mov dl, xposition
    mov dh, yposition
    call Gotoxy
    mov al, 'M'
    call WriteChar
    pop ebx
    pop eax
    ret
drawplayer2 ENDP

drawlevel2scene PROC
    push eax
    call drawtunnelbg
    call drawhud
    call drawgroundlevel2
    call drawlava
    call drawplatforms2
    call drawquestionplatforms2
    call drawpipes2
    call drawflagpole2
    call drawblocks2
    call drawcoins2
    call drawsecretarea
    call drawgoldenmushrooms2
    call drawenemies2
    call drawsupermushrooms    
    call drawplayer
    ;call drawhud
    pop eax
    ret
drawlevel2scene ENDP

;draw timer, coins, lives etc.
drawhud PROC
    push ebx
    mov al, currentlevel
    cmp al, 2
    je hud_level2
   
    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor
    mov dl, 2
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET mariodisplay
    call WriteString

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 8
    mov dh, 2
    call Gotoxy
    mov eax, score
    call WriteDec

    mov eax, yellow + (lightBlue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET coinsdisplay
    call WriteString

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 27
    mov dh, 2
    call Gotoxy
    movzx eax, coins
    call WriteDec

    ;mov ebx, 38
    mov eax, lightGreen + (lightBlue * 16)
    call SetTextColor
    mov dl, 38
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET worlddisplay    
    call WriteString

    mov eax, lightMagenta + (lightBlue * 16)
    call SetTextColor
    mov dl, 58
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET timedisplay
    call WriteString

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 63
    mov dh, 2
    call Gotoxy
    jmp draw_timer
   
hud_level2:
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 2
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET mariodisplay
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 8
    mov dh, 2
    call Gotoxy
    mov eax, score
    call WriteDec

    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET coinsdisplay
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 27
    mov dh, 2
    call Gotoxy
    movzx eax, coins
    call WriteDec

    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov dl, 38
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET worlddisplay2  
    call WriteString

    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 58
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET timedisplay
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 63
    mov dh, 2
    call Gotoxy
   
draw_timer:
    mov eax, timeleft
    cmp eax, 100
    jge three_digits
    cmp eax, 10
    jge two_digits
   
    mov al, '0'
    call WriteChar
    mov al, '0'
    call WriteChar
    mov eax, timeleft
    call WriteDec
    jmp timer_continue
   
two_digits:
    mov al, '0'
    call WriteChar
    mov eax, timeleft
    call WriteDec
    jmp timer_continue
   
three_digits:
    mov eax, timeleft
    call WriteDec

timer_continue:
    mov al, currentlevel
    cmp al, 2
    je lives_level2

    mov eax, lightCyan + (lightBlue * 16)
    jmp show_lives
   
lives_level2:
    mov eax, lightCyan + (black * 16)
   
show_lives:
    call SetTextColor
    mov dl, 72
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET livesdisplay
    call WriteString

    mov al, currentlevel
    cmp al, 2
    jne lives_count_level1

    mov eax, white + (black * 16)
    jmp write_lives
   
lives_count_level1:
    mov eax, white + (lightBlue * 16)
   
write_lives:
    call SetTextColor
    mov dl, 78
    mov dh, 2
    call Gotoxy
    movzx eax, lives
    call WriteDec

    pop ebx
    ret
drawhud ENDP

;draw clouds for level1
drawclouds PROC
    push eax
    push edx
    mov eax, white + (lightBlue * 16)
    call SetTextColor

    mov dl, 8
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET largecloudfirstline
    call WriteString
   
    mov dl, 8
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET largecloudsecondline
    call WriteString
   
    mov dl, 8
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET largecloudthirdline
    call WriteString

    ;add dl, 40
    mov dl, 48
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET smallcloudfirstline
    call WriteString
   
    mov dl, 48
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET smallcloudsecondline
    call WriteString

    mov dl, 28
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET largecloudfirstline
    call WriteString
   
    mov dl, 28
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET largecloudsecondline
    call WriteString

    mov dl, 65
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET smallcloudfirstline
    call WriteString
   
    mov dl, 65
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET smallcloudsecondline
    call WriteString

    mov dl, 5
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET largecloudfirstline
    call WriteString

    mov dl, 5
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET largecloudsecondline
    call WriteString

    mov dl, 35
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET smallcloudfirstline
    call WriteString

    mov dl, 35
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET smallcloudsecondline
    call WriteString

    pop edx
    pop eax
    ret
drawclouds ENDP

drawhills PROC
    push eax
    push edx
    push ebx
    mov eax, brown + (brown * 16)   ;brown text on brown background
    call SetTextColor

    mov dl, 5
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET decorsmalltrianglefirstline
    call WriteString
   
    mov dl, 5
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET decorsmalltrianglesecondline
    call WriteString
   
    mov dl, 5
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET decorsmalltrianglethirdline
    call WriteString

    mov ebx, edx
    mov dl, 35
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET decorlargetrianglefirstline
    call WriteString
   
    mov dl, 35
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET decorlargetrianglesecondline
    call WriteString
   
    mov dl, 35
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET decorlargetrianglethirdline
    call WriteString
   
    mov dl, 35
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET decorlargetrianglefourthline
    call WriteString

    ;mov ebx, 68
    mov dl, 68
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET decorsmalltrianglefirstline
    call WriteString
   
    mov dl, 68
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET decorsmalltrianglesecondline
    call WriteString
   
    mov dl, 68
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET decorsmalltrianglethirdline
    call WriteString

    pop ebx
    pop edx
    pop eax
    ret
drawhills ENDP

drawpipes PROC
    push eax
    push edx
    push ecx
    
    ;filled with green background
    mov eax, green + (green * 16)    ;green text on green background
    call SetTextColor
   
    mov dl, 18
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET hillfirstline
    call WriteString
   
    mov dl, 18
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET hillsecondline
    call WriteString
   
    ;mov ecx, 0
    mov dl, 18
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET hillthirdline
    call WriteString
   
    mov dl, 18
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET hillfourthline
    call WriteString

    ;second green hill with green background
    mov eax, green + (green * 16) 
    call SetTextColor
    
    mov dl, 70
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET hillfirstline
    call WriteString
   
    mov dl, 70
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET hillsecondline
    call WriteString
   
    mov dl, 70
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET hillthirdline
    call WriteString

    pop ecx
    pop edx
    pop eax
    ret
drawpipes ENDP

;draw floating question marks
drawblocks PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    mov eax, yellow + (lightBlue * 16)
    call SetTextColor

    movzx ecx, blockcount
    mov esi, 0

block_loop:
    cmp esi, ecx
    jge blocks_done

    mov dl, blockx[esi]
    mov dh, blocky[esi]
    call Gotoxy
   
    mov al, '['
    call WriteChar
    mov al, '?'
    call WriteChar
    ;mov ebx, eax
    mov al, ']'
    call WriteChar

next_block:
    inc esi
    jmp block_loop

blocks_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawblocks ENDP

;draw real question marks
drawquestionplatforms PROC
    push eax
    push edx
    push ebx
    mov eax, brown + (lightBlue * 16)
    call SetTextColor

    mov dl, realplatform1x
    mov dh, realplatform1y
    call Gotoxy
    mov edx, OFFSET realplatform1
    call WriteString

    mov dl, realplatform2x
    mov dh, realplatform2y
    call Gotoxy
    mov edx, OFFSET realplatform2
    call WriteString

    mov ebx, edx
    mov dl, realplatform3x
    mov dh, realplatform3y
    call Gotoxy
    mov edx, OFFSET realplatform3
    call WriteString

    mov dl, realplatform4x
    mov dh, realplatform4y
    call Gotoxy
    mov edx, OFFSET realplatform4
    call WriteString

    ;add dl, 0
    mov dl, realplatform5x
    mov dh, realplatform5y
    call Gotoxy
    mov edx, OFFSET realplatform5
    call WriteString

    mov dl, realplatform6x
    mov dh, realplatform6y
    call Gotoxy
    mov edx, OFFSET realplatform6
    call WriteString

    mov dl, realplatform7x
    mov dh, realplatform7y
    call Gotoxy
    mov edx, OFFSET realplatform7
    call WriteString

    mov dl, realplatform8x
    mov dh, realplatform8y
    call Gotoxy
    mov edx, OFFSET realplatform8
    call WriteString

    pop ebx
    pop edx
    pop eax
    ret
drawquestionplatforms ENDP

drawplatforms PROC
    push eax
    push edx
    push ecx
    mov eax, brown + (lightBlue * 16)
    call SetTextColor

    mov dl, decorplatform1x
    mov dh, decorplatform1y
    call Gotoxy
    mov edx, OFFSET decorplatform1
    call WriteString

    mov dl, decorplatform2x
    mov dh, decorplatform2y
    call Gotoxy
    mov edx, OFFSET decorplatform2
    call WriteString

    ;mov ecx, 3
    mov dl, decorplatform3x
    mov dh, decorplatform3y
    call Gotoxy
    mov edx, OFFSET decorplatform3
    call WriteString

    mov dl, decorplatform4x
    mov dh, decorplatform4y
    call Gotoxy
    mov edx, OFFSET decorplatform4
    call WriteString

    mov dl, decorplatform5x
    mov dh, decorplatform5y
    call Gotoxy
    mov edx, OFFSET decorplatform5
    call WriteString

    mov dl, decorplatform6x
    mov dh, decorplatform6y
    call Gotoxy
    mov edx, OFFSET decorplatform6
    call WriteString

    pop ecx
    pop edx
    pop eax
    ret
drawplatforms ENDP

drawflagpole PROC
    push eax
    push ecx
    push edx
    push ebx
    mov eax, white + (lightBlue * 16)
    call SetTextColor

    mov dl, flagpolex
    mov dh, 10
    call Gotoxy
    mov al, 'O'
    call WriteChar

    mov ebx, 13
    mov ecx, ebx            
    mov dh, 11

flagpole_loop:
    mov dl, flagpolex
    call Gotoxy
    mov al, '|'
    call WriteChar
    inc dh
    ;cmp dh, 24
    loop flagpole_loop

    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
drawflagpole ENDP

;draw enemy at specific position
drawenemyatpos PROC
    push eax
    push ebx
    ;mov ebx, edx
    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor
    call Gotoxy
    mov al, 'E'
    call WriteChar
    pop ebx
    pop eax
    ret
drawenemyatpos ENDP

drawenemies PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor

    movzx ecx, enemyCount
    mov esi, 0

enemy_draw_loop:
    cmp esi, ecx
    jge enemies_drawn

    mov al, enemyactive[esi]
    cmp al, 0
    je skip_enemy

    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call drawenemyatpos

skip_enemy:
    inc esi
    ;add esi, 0
    jmp enemy_draw_loop

enemies_drawn:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawenemies ENDP

drawgoldenmushrooms PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, goldenmushroomcount
    mov esi, 0
    inc powerupglowcounter

golden_mushroom_loop:
    cmp esi, ecx
    jge golden_mushrooms_done

    mov al, goldenmushroomactive[esi]
    cmp al, 0
    je next_golden_mushroom

    mov al, powerupglowcounter
    and al, 3        
    movzx ebx, al      
    mov al, powerupglowcolors[ebx]  
    movzx eax, al      
    add eax, (lightBlue * 16)
    call SetTextColor

    mov dl, goldenmushroomx[esi]
    mov dh, goldenmushroomy[esi]
    call Gotoxy

    mov al, '('
    call WriteChar
   
    inc dl
    call Gotoxy
    mov al, ')'
    call WriteChar

next_golden_mushroom:
    inc esi
    ;dec esi
    ;inc esi
    jmp golden_mushroom_loop

golden_mushrooms_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawgoldenmushrooms ENDP

eraseenemyatpos PROC
    push eax
    push edx
    push ebx
    push ecx

    mov bl, currentlevel
    cmp bl, 2
    je eep_level2

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    call Gotoxy
   
    call getbackgroundatpos
    call WriteChar
    jmp eep_done

eep_level2:
    mov eax, black + (black * 16)
    call SetTextColor
    call Gotoxy
    mov al, ' '
    call WriteChar
    call WriteChar    ;erases 2nd character for shell

eep_done:
    pop ecx
    pop ebx
    pop edx
    pop eax
    ret
eraseenemyatpos ENDP


drawground PROC
    push eax
    push edx
    push ecx
    push ebx

    mov eax, yellow + (lightGreen * 16)  
    call SetTextColor
    mov dh, 24
    mov dl, 0
    call Gotoxy
    mov ecx, 80

grass_top_loop:
    mov al, '"'                          
    call WriteChar
    loop grass_top_loop

    ;mov ebx, 80
    mov eax, green + (green * 16)        
    call SetTextColor
    mov dh, 25
    mov dl, 0
    call Gotoxy
    mov ecx, 80

green_base_loop:
    mov al, 219                        
    call WriteChar
    loop green_base_loop

    pop ebx
    pop ecx
    pop edx
    pop eax
    ret
drawground ENDP

drawanimatedsky PROC
    push eax
    push ecx
    push edx
    push ebx
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 0
    call Gotoxy
    mov ecx, 80

sky_row_loop:
    mov bl, cl
    and bl, 15                    
    cmp bl, 0
    je draw_star

    mov al, ' '                
    jmp write_sky_char

draw_star:
    mov al, '.'      
   
write_sky_char:
    call WriteChar
    loop sky_row_loop

    ;mov ebx, 10
    mov eax, white + (lightCyan * 16)  
    call SetTextColor
    mov dl, 0
    mov dh, 1
    call Gotoxy

    mov ecx, 10                    
    mov dl, 5        
   
cloud_loop:
    push ecx
    push edx
   
    mov dh, 1
    call Gotoxy
    mov al, '('
    call WriteChar
    mov al, '_'
    call WriteChar
    mov al, '_'
    call WriteChar
    mov al, ')'
    call WriteChar
   
    pop edx
    pop ecx
    add dl, 8                      
    loop cloud_loop

    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
drawanimatedsky ENDP

drawcoins PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, coincount
    mov esi, 0

coin_draw_loop:
    cmp esi, ecx
    jge coins_drawn
    mov al, coinactive[esi]
    cmp al, 0
    je next_coin

    mov dl, coinx[esi]
    mov dh, coiny[esi]
    mov eax, yellow + (lightBlue * 16)
    call SetTextColor
    call Gotoxy
    ;mov ebx, eax
    mov al, 'o'
    call WriteChar

next_coin:
    inc esi
    jmp coin_draw_loop

coins_drawn:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
drawcoins endp

erasepowerupatpos PROC
    push eax
    push edx
    push ebx  
    call Gotoxy
    ;mov ebx, edx
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
   
    pop ebx
    pop edx
    pop eax
    ret
erasepowerupatpos ENDP

drawplayer PROC
    push eax
    push ebx
    push ecx

    mov bl, currentlevel
    cmp bl, 2
    je dp_level2
   
    mov eax, mariocolor
    call SetTextColor
    mov dl, xposition
    mov dh, yposition
    call Gotoxy
    mov al, 'M'
    call WriteChar
    jmp dp_done
   
dp_level2:
    ;mov ecx, 0
    mov eax, mariocolor
    and eax, 0Fh
    or eax, (black * 16)
    call SetTextColor

    mov al, mariosize
    cmp al, 2
    je dp_supermario
   
    mov dl, xposition
    mov dh, yposition
    call Gotoxy
    mov al, 'M'
    call WriteChar
    mov al, 'M'
    call WriteChar
    jmp dp_done
   
dp_supermario:
    mov dl, xposition
    mov dh, yposition
    dec dh                        
    call Gotoxy
    mov al, 'M'
    call WriteChar
    mov al, 'M'
    call WriteChar

    mov dl, xposition
    mov dh, yposition                  
    call Gotoxy
    mov al, 'M'
    call WriteChar
    mov al, 'M'
    call WriteChar
   
dp_done:
    pop ecx
    pop ebx
    pop eax
    ret
drawplayer ENDP

eraseplayer PROC
    push eax
    push edx
    push ebx
    push ecx
    mov dl, xposition
    mov dh, yposition
    mov bl, currentlevel
    cmp bl, 2
    je ep_level2

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov al, ' '

    cmp dh, 23
    jb ep_notground_l1
    mov eax, green + (green * 16)
    mov al, '#'

ep_notground_l1:
    cmp dl, hill1leftbound
    jb ep_checkpipe2_l1
    cmp dl, hill1rightbound
    ja ep_checkpipe2_l1
    cmp dh, hill1topbound
    jb ep_checkpipe2_l1
    cmp dh, hill1bottombound
    ja ep_checkpipe2_l1
    mov eax, green + (lightBlue * 16)
    mov al, '|'

ep_checkpipe2_l1:
    cmp dl, hill2leftbound
    jb ep_checkplatform_l1
    cmp dl, hill2rightbound
    ja ep_checkplatform_l1
    cmp dh, hill2topbound
    jb ep_checkplatform_l1
    cmp dh, pipe2Bottom
    ja ep_checkplatform_l1
    mov eax, green + (lightBlue * 16)
    mov al, '|'

ep_checkplatform_l1:
    call getbackgroundatpos
    jmp ep_done

ep_level2:
    ;mov ecx, 0
    mov bl, mariosize
    cmp bl, 2
    je ep_erasesuper
   
    mov eax, black + (black * 16)
    call SetTextColor
    call Gotoxy
    mov al, ' '
    call WriteChar
    inc dl
    call Gotoxy
    call WriteChar
    jmp ep_done
   
ep_erasesuper:
    dec dh
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    inc dl
    call Gotoxy
    call WriteChar

    inc dh
    dec dl
    call Gotoxy
    mov al, ' '
    call WriteChar
    inc dl
    call Gotoxy
    call WriteChar
    jmp ep_done

ep_done:
    call Gotoxy
    call WriteChar

    pop ecx
    pop ebx
    pop edx
    pop eax
    ret
eraseplayer ENDP

;checkerboard background
drawcheckerboard PROC
    push eax
    push ecx
    push edx
    push ebx
    mov dh, 0
    mov ecx, 25
   
row_loop:
    mov dl, 0
    push ecx
    mov ecx, 80
   
col_loop:
    push edx
    call Gotoxy

    mov al, dh
    add al, dl
    and al, 1          
   
    cmp al, 0
    je draw_black_square

    mov eax, white + (white * 16)
    jmp draw_square
   
draw_black_square:
    ;mov ebx, 0
    mov eax, black + (black * 16)
   
draw_square:
    call SetTextColor
    mov al, 219      
    call WriteChar
   
    pop edx
    inc dl
    loop col_loop
   
    pop ecx
    inc dh
    loop row_loop
   
    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
drawcheckerboard ENDP

;music procedures
playbackgroundmusic PROC
    push eax
    push edx
    push ebx

    INVOKE PlaySoundA,
        OFFSET bgmusicfile,
        0,
        SND_FILENAME OR SND_ASYNC OR SND_LOOP

    mov musicPlaying, 1
    ;mov ebx, 1
    pop ebx
    pop edx
    pop eax
    ret
playbackgroundmusic ENDP

stopmusic PROC
    push eax
    push ebx
    INVOKE PlaySoundA, 0, 0, 0

    mov musicPlaying, 0  
    pop ebx
    pop eax
    ret
stopmusic ENDP

playjumpsound PROC
    push eax
    push edx
    push ecx

    INVOKE PlaySoundA,
        OFFSET jumpsoundfile,
        0,
        SND_FILENAME OR SND_ASYNC OR SND_NOSTOP
   
    pop ecx
    pop edx
    pop eax
    ret
playjumpsound ENDP

playcoinsound PROC
    push eax
    push edx
    push ecx

    INVOKE PlaySoundA,
        OFFSET coinsoundfile,
        0,
        SND_FILENAME OR SND_ASYNC OR SND_NOSTOP
   
    pop ecx
    pop edx
    pop eax
    ret
playcoinsound ENDP

playenemydefeat PROC
    push eax
    push edx
    push ebx

    INVOKE PlaySoundA,
        OFFSET enemysoundfile,
        0,
        SND_FILENAME OR SND_ASYNC OR SND_NOSTOP
   
    pop ebx
    pop edx
    pop eax
    ret
playenemydefeat ENDP

playsoundpowerup PROC
    push eax
    push edx
    push ecx

    INVOKE PlaySoundA,
        OFFSET powerupsoundfile,
        0,
        SND_FILENAME OR SND_ASYNC OR SND_NOSTOP
   
    pop ecx
    pop edx
    pop eax
    ret
playsoundpowerup ENDP

playlifelostsound PROC
    push eax
    push edx
    push ebx
   
    INVOKE PlaySoundA,
        OFFSET lifelostsoundfile,
        0,
        SND_FILENAME OR SND_ASYNC
   
    pop ebx
    pop edx
    pop eax
    ret
playlifelostsound ENDP

playflagpolesound PROC
    push eax
    push edx
    push ecx

    INVOKE PlaySoundA,
        OFFSET flagpolesoundfile,
        0,
        SND_FILENAME OR SND_ASYNC
   
    pop ecx
    pop edx
    pop eax
    ret
playflagpolesound ENDP

updatemusic PROC
    ;mov eax, 0
    ret
updatemusic ENDP

startmusic PROC
    push eax
    call playbackgroundmusic
    pop eax
    ret
startmusic ENDP

playshortsound PROC
    push eax
    INVOKE PlaySoundA,
        OFFSET coinsoundfile,
        0,
        SND_FILENAME OR SND_ASYNC OR SND_NOSTOP

    pop eax
    ret
playshortsound ENDP

;golden mushrooms power-up procs
checkgoldenmushroom PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, goldenmushroomcount      
    cmp ecx, 0                  
    je cgmc_done            

    mov esi, 0            

cgmc_loop:
    cmp esi, ecx              
    jge cgmc_done          
   
    cmp esi, 2                
    jae cgmc_next          

    mov al, goldenmushroomactive[esi]  
    cmp al, 0                  
    je cgmc_next          

    cmp esi, 2              
    jae cgmc_next

    mov dl, goldenmushroomx[esi]  
    cmp esi, 2                
    jae cgmc_next

    ;mov ebx, edx
    mov dh, goldenmushroomy[esi]    
    mov al, xposition              
    sub al, dl            
    cmp al, 1                
    jbe cgmc_checkvertical
   
    mov al, dl                  
    sub al, xposition          
    cmp al, 1                  
    jbe cgmc_checkvertical
    jmp cgmc_next              

cgmc_checkvertical:
    mov al, yposition            
    sub al, dh              
    cmp al, 1      
    jbe cgmc_collect
   
    mov al, dh              
    sub al, yposition              
    cmp al, 1                
    jbe cgmc_collect
    jmp cgmc_next          

cgmc_collect:
    mov goldenmushroomactive[esi], 0
    mov eax, 1000
    add score, eax
   
    mov invincible, 1
    mov invinciblecounter, 0
    call showgoldenmushroommsg
    call erasegoldenmushatpos
    call playsoundpowerup
    call playsoundpowerup
    call drawhud

cgmc_next:
    inc esi                  
    jmp cgmc_loop            

cgmc_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
checkgoldenmushroom ENDP

erasegoldenmushatpos PROC
    push eax
    push edx
    push ecx
    cmp esi, 2
    jae egm_done          
   
    mov dl, goldenmushroomx[esi]
    mov dh, goldenmushroomy[esi]
    push edx
    call Gotoxy
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    pop edx
    inc dl
    call Gotoxy
    mov al, ' '
    call WriteChar
   
egm_done:
    pop ecx
    pop edx
    pop eax
    ret
erasegoldenmushatpos ENDP

showgoldenmushroommsg PROC
    push eax
    push edx
    push ebx
    mov ecx, 3

flash_golden_msg:
    push ecx
    mov eax, yellow + (lightBlue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET goldenmushroommessage
    call WriteString
   
    mov eax, 300
    call Delay

    ;mov ebx, 45
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 3
    call Gotoxy
    mov ecx, 45

clear_msg_loop:
    mov al, ' '
    call WriteChar
    loop clear_msg_loop
   
    mov eax, 150
    call Delay
    pop ecx
    loop flash_golden_msg
   
    pop ebx
    pop edx
    pop eax
    ret
showgoldenmushroommsg ENDP

updateinvincibility PROC
    push eax
    push ebx
   
    cmp invincible, 0
    je ui_done
   
    inc invinciblecounter
   
    mov eax, invinciblecounter
    cmp eax, invincibleduration
    jb ui_continue
   
    mov invincible, 0
    mov dword ptr invinciblecounter, 0
    jmp ui_done
   
ui_continue:
    mov eax, invinciblecounter
    and eax, 8      
    jz ui_blinkon
    jmp ui_blinkoff

ui_blinkon:
    mov ebx, lightMagenta + (lightBlue * 16)
    mov mariocolor, ebx
    jmp ui_done
   
ui_blinkoff:
    mov ebx, lightGreen + (lightBlue * 16)
    mov mariocolor, ebx
   
ui_done:
    pop ebx
    pop eax
    ret
updateinvincibility ENDP

convertleveltostr PROC
    push eax
    push edi
    push ebx
   
    mov edi, OFFSET scorebuffer
    movzx eax, currentlevel
    add al, '0'
    mov [edi], al
    mov byte ptr [edi+1], 0
   
    pop ebx
    pop edi
    pop eax
    ret
convertleveltostr ENDP

checkplayerexists PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov checkifplayerexists, 0
    mov indexofplayerfound, 0
    call readallplayersfromfile
   
    movzx ecx, playerrecordcount
    cmp ecx, 0
    je cpe_notfound              

    xor ebx, ebx  
   
cpe_searchloop:
    cmp ebx, ecx
    jge cpe_notfound          
   
    mov eax, ebx
    push edx
    mov edx, playernamelength
    mul edx
    pop edx
    mov edi, OFFSET allplayernames
    add edi, eax              
    mov esi, OFFSET playername  
   
cpe_compareloop:
    mov al, [esi]
    mov ah, [edi]          
    cmp al, 0
    je cpe_checkendmatch

    cmp al, ' '
    je cpe_checkendmatch
   
    cmp ah, 0
    je cpe_nextplayer

    cmp ah, ' '
    je cpe_nextplayer

    cmp al, ah
    jne cpe_nextplayer        

    inc esi
    inc edi
    jmp cpe_compareloop

cpe_checkendmatch:
    cmp ah, 0
    je cpe_found
    cmp ah, ' '
    je cpe_found
    jmp cpe_nextplayer      
   
cpe_nextplayer:
    inc ebx
    ;add ebx, 0
    jmp cpe_searchloop
   
cpe_found:
    mov checkifplayerexists, 1
    mov eax, ebx
    mov indexofplayerfound, al
    mov eax, ebx
    push edx
    mov edx, 4
    mul edx
    pop edx
    mov esi, OFFSET allplayerscores
    add esi, eax
    mov eax, [esi]
    mov currentlysavedscore, eax
    movzx eax, byte ptr indexofplayerfound
    mov edi, OFFSET levelsofallplayers
    add edi, eax
    mov al, [edi]
    mov templevel, al
    jmp cpe_done
   
cpe_notfound:
    mov checkifplayerexists, 0
   
cpe_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
checkplayerexists ENDP

;show resume menu
showresumemenu PROC
    LOCAL choice:byte
   
    push eax
    push edx
    push ebx
    call clearbluesky

    mov eax, white + (lightBlue * 16)
    call SetTextColor
   
    mov dh, 5
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline1
    call WriteString
    call Crlf
   
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline3
    call WriteString
    call Crlf
   
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline4
    call WriteString
    call Crlf

    mov eax, yellow + (lightBlue * 16)
    call SetTextColor
   
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline5
    call WriteString
    call Crlf
   
    ;mov ebx, 0
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline6
    call WriteString
   
    mov eax, lightGreen + (lightBlue * 16)
    call SetTextColor
    mov eax, currentlysavedscore
    call WriteDec
   
    call Crlf
    call Crlf
   
    mov eax, lightCyan + (lightBlue * 16)
    call SetTextColor
   
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline8
    call WriteString
    call Crlf
   
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline9
    call WriteString
    call Crlf
    call Crlf
   
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline11
    call WriteString
    call Crlf
   
    mov dl, 8
    call Gotoxy
    mov edx, OFFSET resumefromlevelline2
    call WriteString

srm_getchoice:
    call ReadChar
    mov choice, al  
    cmp choice, '1'
    je srm_resume

    cmp choice, '2'
    je srm_restart

    jmp srm_getchoice      
   
srm_resume:
    mov eax, currentlysavedscore
    mov score, eax
    mov currentlevel, 2
    jmp srm_done
   
srm_restart:
    mov score, 0
    mov currentlevel, 1
    call saveplayertofile  
   
srm_done:
    pop ebx
    pop edx
    pop eax
    ret
showresumemenu ENDP

startgamefromlevel PROC
    push eax
    push ebx
    mov al, currentlevel
    cmp al, 2
    je sgfcl_level2
   
sgfcl_level1:
    mov xposition, 10
    mov yposition, 23
    cmp score, 0
    jne sgfcl_l1_keepprogress

    mov coins, 0
    mov lives, 5
   
sgfcl_l1_keepprogress:
    mov timeleft, 300
   
    mov byte ptr coinactive[0], 1
    mov byte ptr coinactive[1], 1  
    mov byte ptr coinactive[2], 1
    mov byte ptr coinactive[3], 1
    mov byte ptr coinactive[4], 1
    mov byte ptr coinactive[5], 1
    mov byte ptr coinactive[6], 1
    mov byte ptr coinactive[7], 1
    mov byte ptr coinactive[8], 1
    mov byte ptr coinactive[9], 1
   
    mov byte ptr goldenmushroomactive[0], 1
    mov byte ptr goldenmushroomactive[1], 1
   
    push ebx
    mov ebx, lightGreen + (lightBlue * 16)
    mov mariocolor, ebx
    pop ebx

    mov invincible, 0
    mov dword ptr invinciblecounter, 0

    mov byte ptr poweractive[0], 1
    mov byte ptr poweractive[1], 1
    mov byte ptr poweractive[2], 1
    mov byte ptr poweractive[3], 1
    mov byte ptr poweractive[4], 1
    mov byte ptr poweractive[5], 1

    ;mov ebx, 0
    mov enemymovementcounter, 0
    mov byte ptr enemyx[0], 15
    mov byte ptr enemyx[1], 30
    mov byte ptr enemyx[2], 45
    mov byte ptr enemyx[3], 60
    mov byte ptr enemyx[4], 50
   
    mov byte ptr enemyy[0], 18
    mov byte ptr enemyy[1], 16
    mov byte ptr enemyy[2], 14
    mov byte ptr enemyy[3], 17
    mov byte ptr enemyy[4], 23
   
    mov byte ptr enemyactive[0], 1
    mov byte ptr enemyactive[1], 1
    mov byte ptr enemyactive[2], 1
    mov byte ptr enemyactive[3], 1
    mov byte ptr enemyactive[4], 1
   
    mov byte ptr enemydirection[0], 1
    mov byte ptr enemydirection[1], -1
    mov byte ptr enemydirection[2], 1
    mov byte ptr enemydirection[3], -1
    mov byte ptr enemydirection[4], -1
   
    jmp sgfcl_done
   
sgfcl_level2:
    mov xposition, 10
    mov yposition, 23
    mov timeleft, 300

    mov byte ptr goldenmushroomactive[0], 1  
    mov byte ptr goldenmushroomactive[1], 1    

    mov byte ptr coinactive[2], 1
    mov byte ptr coinactive[3], 1
    mov byte ptr coinactive[4], 1
    mov byte ptr coinactive[5], 1
    mov byte ptr coinactive[6], 1
    mov byte ptr coinactive[7], 1
    mov byte ptr coinactive[8], 1
    mov byte ptr coinactive[9], 1
   
    mov byte ptr goldenmushroomactive[0], 1
    mov byte ptr goldenmushroomactive[1], 1
   
    mov byte ptr supermushroomactive[0], 1
    mov byte ptr supermushroomactive[1], 1
    mov byte ptr supermushroomactive[2], 1
   
    mov mariosize, 1

    push ebx
    mov ebx, lightGreen + (lightBlue * 16)
    mov mariocolor, ebx
    pop ebx
   
    mov invincible, 0
    mov dword ptr invinciblecounter, 0

    mov byte ptr poweractive[0], 1
    mov byte ptr poweractive[1], 1
    mov byte ptr poweractive[2], 1
    mov byte ptr poweractive[3], 1
    mov byte ptr poweractive[4], 1
    mov byte ptr poweractive[5], 1
   
    mov enemymovementcounter, 0
    mov byte ptr enemyx[0], 15
    mov byte ptr enemyx[1], 30
    mov byte ptr enemyx[2], 45
    mov byte ptr enemyx[3], 60
    mov byte ptr enemyx[4], 50
   
    mov byte ptr enemyy[0], 18
    mov byte ptr enemyy[1], 16
    mov byte ptr enemyy[2], 14
    mov byte ptr enemyy[3], 17
    mov byte ptr enemyy[4], 23
   
    mov byte ptr enemyactive[0], 1
    mov byte ptr enemyactive[1], 1
    mov byte ptr enemyactive[2], 1
    mov byte ptr enemyactive[3], 1
    mov byte ptr enemyactive[4], 1
   
    mov byte ptr enemydirection[0], 1
    mov byte ptr enemydirection[1], -1
    mov byte ptr enemydirection[2], 1
    mov byte ptr enemydirection[3], -1
    mov byte ptr enemydirection[4], -1
   
sgfcl_done:
    pop ebx
    pop eax
    ret
startgamefromlevel ENDP

displaytop5leaderboard PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    call readallplayersfromfile

    movzx eax, playerrecordcount
    cmp eax, 0
    je dt5_noscores

    mov ecx, eax                
    cmp ecx, 5
    jle dt5_startdisplay
    mov ecx, 5              
   
dt5_startdisplay:
    mov esi, 0                      
    mov dh, 12                
   
dt5_loop:
    cmp esi, ecx
    jge dt5_done                    

    mov dl, 0
    call Gotoxy
    cmp esi, 0
    je dt5_color1st

    cmp esi, 1
    je dt5_color2nd

    cmp esi, 2
    je dt5_color3rd

    cmp esi, 3
    je dt5_color4th

    cmp esi, 4
    je dt5_color5th

    jmp dt5_colordefault
   
dt5_color1st:
    mov eax, yellow + (black * 16)
    jmp dt5_setcolor
   
dt5_color2nd:
    mov eax, lightGray + (black * 16)
    jmp dt5_setcolor
   
dt5_color3rd:
    mov eax, brown + (black * 16)
    jmp dt5_setcolor
   
dt5_color4th:
    mov eax, lightCyan + (black * 16)
    jmp dt5_setcolor
   
dt5_color5th:
    mov eax, lightMagenta + (black * 16)
    jmp dt5_setcolor
   
dt5_colordefault:
    mov eax, white + (black * 16)
   
dt5_setcolor:
    call SetTextColor
    cmp esi, 0
    jne dt5_try2
    mov edx, OFFSET rank1
    call WriteString
    jmp dt5_printname
   
dt5_try2:
    cmp esi, 1
    jne dt5_try3
    mov edx, OFFSET rank2
    call WriteString
    jmp dt5_printname
   
dt5_try3:
    cmp esi, 2
    jne dt5_try4
    mov edx, OFFSET rank3
    call WriteString
    jmp dt5_printname
   
dt5_try4:
    cmp esi, 3
    jne dt5_try5
    mov edx, OFFSET rank4
    call WriteString
    jmp dt5_printname
   
dt5_try5:
    mov edx, OFFSET rank5
    call WriteString
   
dt5_printname:
    push esi
    push ecx
    push edx
    mov eax, esi
    mov ebx, playernamelength
    mul ebx
    mov esi, OFFSET allplayernames
    add esi, eax
    mov ecx, 0
   
dt5_nameloop:
    cmp ecx, 20
    jge dt5_namecomplete
   
    mov al, [esi]
    cmp al, 0
    je dt5_namepad
   
    call WriteChar
    inc esi
    inc ecx
    jmp dt5_nameloop
   
dt5_namepad:
    mov al, ' '
    call WriteChar
    inc ecx
    jmp dt5_nameloop
   
dt5_namecomplete:
    pop edx
    pop ecx
    pop esi
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    call WriteChar
    call WriteChar
    push esi
    push ecx
    mov eax, esi
    mov ebx, 4
    mul ebx
    mov edx, OFFSET allplayerscores
    add edx, eax
    mov eax, [edx]
    call WriteDec
    pop ecx
    pop esi
    call crlf
    inc dh
    inc esi
    jmp dt5_loop
   
dt5_noscores:
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET noscorescurrentlymessage
    call WriteString
   
dt5_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
displaytop5leaderboard ENDP

readallplayersfromfile PROC
    LOCAL recordIndex:BYTE
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov playerrecordcount, 0
    mov bufferindex, 0
    mov bytesread, 0
    mov edx, OFFSET filename

    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je rapf_done

    mov filehandle, eax
    mov edx, OFFSET filebuffer
    mov ecx, 1999

    call ReadFromFile
    mov bytesread, eax
    mov eax, filehandle

    call CloseFile
    mov bufferindex, 0
    mov recordIndex, 0

rapf_parseloop:
    mov eax, bufferindex
    cmp eax, bytesread
    jge rapf_done

    mov al, recordIndex
    cmp al, totalplayers
    jge rapf_done

    call parseoneline
    cmp al, 0
    je rapf_done

    movzx eax, recordIndex
    mov ebx, playernamelength
    mul ebx
    mov edi, OFFSET allplayernames
    add edi, eax
    mov esi, OFFSET tempnamestorage
    mov ecx, playernamelength
    rep movsb

    ;add eax, 0
    movzx eax, recordIndex
    mov ebx, 4
    mul ebx
    mov edi, OFFSET allplayerscores
    add edi, eax
    mov eax, tempscore
    mov [edi], eax
    movzx eax, recordIndex
    mov edi, OFFSET levelsofallplayers
    add edi, eax
    mov al, templevel
    mov [edi], al
    inc recordIndex
    jmp rapf_parseloop

rapf_done:
    mov al, recordIndex
    mov playerrecordcount, al
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
readallplayersfromfile ENDP

;to parse a line
parseoneline PROC
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov edi, OFFSET tempnamestorage
    mov ecx, 50
    mov al, 0
    rep stosb

    mov edi, OFFSET tempscorestorage
    mov ecx, 20
    mov al, 0
    rep stosb

    mov tempscore, 0
    mov esi, OFFSET filebuffer
    mov eax, bufferindex
    add esi, eax
    mov eax, bufferindex
    cmp eax, bytesread
    jge pol_failed

    mov edi, OFFSET tempnamestorage
    mov ecx, 0

pol_readname:
    mov al, [esi]
    inc esi
    inc bufferindex
    cmp al, 0
    je pol_failed

    cmp al, 13
    je pol_failed

    cmp al, 10
    je pol_failed

    cmp al, ' '
    je pol_namedone

    cmp al, 9
    je pol_namedone
   
    mov [edi], al
    inc edi
    inc ecx
    cmp ecx, 49
    jge pol_namedone

    jmp pol_readname
   
pol_namedone:
pol_skipspaces:
    mov eax, bufferindex
    cmp eax, bytesread
    jge pol_failed
   
    mov al, [esi]
    cmp al, ' '
    je pol_skipone

    cmp al, 9
    je pol_skipone
    jmp pol_readscore
 
pol_skipone:
    inc esi
    inc bufferindex
    jmp pol_skipspaces
   
pol_readscore:
    ;mov ebx, 0
    mov edi, OFFSET tempscorestorage
    mov ecx, 0
pol_readscoreloop:
    mov eax, bufferindex
    cmp eax, bytesread
    jge pol_convertscore
   
    mov al, [esi]
    cmp al, 0
    je pol_convertscore

    cmp al, 13
    je pol_convertscore

    cmp al, 10
    je pol_convertscore

    cmp al, ' '
    je pol_convertscore

    cmp al, '0'
    jb pol_convertscore

    cmp al, '9'
    ja pol_convertscore

    mov [edi], al
    inc edi
    inc esi
    inc bufferindex
    inc ecx
    cmp ecx, 19
    jge pol_convertscore

    jmp pol_readscoreloop
   
pol_convertscore:
    call convertstrtoscore
   
pol_skipspaces2:
    mov eax, bufferindex
    cmp eax, bytesread
    jge pol_nolevel
   
    mov al, [esi]
    cmp al, ' '
    je pol_skiponespace

    cmp al, 9
    je pol_skiponespace

    jmp pol_readleveldigit

pol_skiponespace:
    inc esi
    inc bufferindex
    jmp pol_skipspaces2

pol_readleveldigit:
    mov al, [esi]
    cmp al, '1'
    je pol_validlevel

    cmp al, '2'
    je pol_validlevel
   
pol_nolevel:
    mov templevel, 1
    jmp pol_skiptoeol

pol_validlevel:
    sub al, '0'
    mov templevel, al
    inc esi
    inc bufferindex

pol_skiptoeol:
    mov eax, bufferindex
    cmp eax, bytesread
    jge pol_success
   
    mov al, [esi]
    inc esi
    inc bufferindex
    cmp al, 10
    je pol_success

    jmp pol_skiptoeol

pol_success:
    mov al, 1
    jmp pol_done
   
pol_failed:
    mov al, 0

pol_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
parseoneline ENDP

convertstrtoscore PROC
    push eax
    push ebx
    push ecx
    push esi
    push edx
    mov esi, OFFSET tempscorestorage
    xor eax, eax
    xor ebx, ebx
    mov ecx, 10

csts_loop:
    mov bl, [esi]
    cmp bl, 0
    je csts_done
   
    cmp bl, '0'
    jb csts_done

    cmp bl, '9'
    ja csts_done

    mul ecx
    sub bl, '0'
    add eax, ebx
    inc esi
    jmp csts_loop
   
csts_done:
    mov tempscore, eax
    pop edx
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
convertstrtoscore ENDP

sortplayersbyscore PROC
    LOCAL i:BYTE, j:BYTE, swapped:BYTE, tempscoreVal:DWORD
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov al, playerrecordcount
    cmp al, 1
    jle sps_done
   
    dec al
    mov i, al

sps_outerloop:
    cmp i, 0
    jle sps_done
   
    mov swapped, 0
    mov j, 0

sps_innerloop:
    mov al, j
    cmp al, i
    jge sps_innerdone
   
    movzx eax, j
    mov ebx, 4
    mul ebx
    mov esi, OFFSET allplayerscores
    add esi, eax
    mov ecx, [esi]
    mov edx, [esi+4]
    cmp ecx, edx
    jge sps_noswap
 
    ;add ecx, 0
    mov [esi], edx
    mov [esi+4], ecx
    push esi
    push edi
    movzx eax, j
    mov esi, OFFSET levelsofallplayers
    add esi, eax
    mov al, [esi]
    movzx ebx, j
    inc ebx
    mov edi, OFFSET levelsofallplayers
    add edi, ebx
    mov bl, [edi]
    mov [esi], bl
    mov [edi], al
    pop edi
    pop esi
    movzx eax, j
    mov ebx, playernamelength
    mul ebx
    mov esi, OFFSET allplayernames
    add esi, eax
    mov edi, OFFSET tempnamestoragebuffer
    mov ecx, playernamelength
    rep movsb

    movzx eax, j
    mov ebx, playernamelength
    mul ebx
    mov edi, OFFSET allplayernames
    add edi, eax
    movzx eax, j
    inc eax
    mov ebx, playernamelength
    mul ebx
    mov esi, OFFSET allplayernames
    add esi, eax
    mov ecx, playernamelength
    rep movsb

    movzx eax, j
    inc eax
    mov ebx, playernamelength
    mul ebx
    mov edi, OFFSET allplayernames
    add edi, eax
    mov esi, OFFSET tempnamestoragebuffer
    mov ecx, playernamelength
    rep movsb
    mov swapped, 1

sps_noswap:
    inc j
    jmp sps_innerloop
   
sps_innerdone:
    cmp swapped, 0
    je sps_done
   
    dec i
    jmp sps_outerloop
   
sps_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
sortplayersbyscore ENDP

writeallplayerstofile PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov edx, OFFSET filename
    call CreateOutputFile
    mov filehandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    je waptf_done
    xor esi, esi

waptf_loop:
    movzx eax, playerrecordcount
    cmp esi, eax
    jge waptf_closefile

    mov eax, esi
    mov ebx, playernamelength
    mul ebx
    mov edx, OFFSET allplayernames
    add edx, eax
    push esi
    mov esi, edx
    mov ecx, 0

waptf_namelen:
    cmp BYTE ptr [esi + ecx], 0
    je waptf_namelendone

    inc ecx
    cmp ecx, playernamelength
    jge waptf_namelendone
    jmp waptf_namelen
   
waptf_namelendone:
    pop esi
    mov eax, filehandle
    call WriteToFile

    ;mov ebx, 4
    mov eax, filehandle
    mov edx, OFFSET spacesbetweenentries
    mov ecx, 4
    call WriteToFile
   
    mov eax, esi
    mov ebx, 4
    mul ebx
    mov edx, OFFSET allplayerscores
    add edx, eax
    mov eax, [edx]
    push score
    mov score, eax
    call convertscoretostr

    pop score
    mov edi, OFFSET scorebuffer
    mov ecx, 0

waptf_scorelen:
    cmp BYTE ptr [edi + ecx], 0
    je waptf_scorelendone

    inc ecx
    cmp ecx, 20
    jge waptf_scorelendone

    jmp waptf_scorelen
   
waptf_scorelendone:
    mov eax, filehandle
    mov edx, OFFSET scorebuffer
    call WriteToFile

    mov eax, filehandle
    mov edx, OFFSET spacesbetweenentries
    mov ecx, 4
    call WriteToFile

    push esi
    mov edi, OFFSET levelsofallplayers
    add edi, esi
    movzx eax, BYTE ptr [edi]
    add al, '0'
    mov BYTE ptr scorebuffer, al
    mov BYTE ptr scorebuffer+1, 0
    pop esi
    mov eax, filehandle
    mov edx, OFFSET scorebuffer
    mov ecx, 1
    call WriteToFile

    mov eax, filehandle
    mov edx, OFFSET newlinecharacter
    mov ecx, 2
    call WriteToFile
   
    inc esi
    jmp waptf_loop
   
waptf_closefile:
    mov eax, filehandle
    call CloseFile
   
waptf_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
writeallplayerstofile ENDP

convertscoretostr PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi
    mov edi, OFFSET scorebuffer
    mov ecx, 20
    mov al, 0
    rep stosb

    mov eax, score
    mov edi, OFFSET scorebuffer
    mov ecx, 0
    cmp eax, 0
    jne cts_convert

    mov BYTE ptr [edi], '0'
    jmp cts_done
   
cts_convert:
    mov ebx, 10
   
cts_loop:
    cmp eax, 0
    je cts_reverse
   
    xor edx, edx
    div ebx
    add dl, '0'
    push edx
    inc ecx
    jmp cts_loop
   
cts_reverse:
    mov edi, OFFSET scorebuffer
cts_poploop:
    cmp ecx, 0
    je cts_done

    pop eax
    mov [edi], al
    inc edi
    dec ecx
    ;add ecx, 0
    jmp cts_poploop
   
cts_done:
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
convertscoretostr ENDP

;get player name
getplayername PROC
    push eax
    push edx
    push ecx
    push ebx
    call clearbluesky

    mov eax, yellow + (lightBlue * 16)
    call SetTextColor

    mov dl, 25
    mov dh, 12
    call Gotoxy

    mov edx, OFFSET namepromptmessage
    call WriteString

    ;mov ebx, 0
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov edx, OFFSET playername
    mov ecx, 49
    call ReadString

    call checkplayerexists

    cmp checkifplayerexists, 1
    jne gpn_newplayer

    mov al, templevel
    cmp al, 2
    je gpn_showresume

    call clearbluesky

    mov eax, lightCyan + (lightBlue * 16)
    call SetTextColor

    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET welcomemessageprompt
    call WriteString

    mov edx, OFFSET playername
    call WriteString

    mov al, '!'
    call WriteChar
   
    mov score, 0
    mov currentlevel, 1
   
    mov eax, 2000
    call Delay
    jmp gpn_done
   
gpn_newplayer:
    call clearbluesky
    mov eax, lightMagenta + (lightBlue * 16)
    call SetTextColor

    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET newplayermessage
    call WriteString
   
    mov eax, 1500
    call Delay
    call clearbluesky

    mov eax, red + (lightBlue * 16)
    call SetTextColor

    mov dl, 30
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET welcomemessageprompt
    call WriteString
    mov edx, OFFSET playername
    call WriteString
    mov al, '!'
    call WriteChar
   
    mov score, 0
    mov currentlevel, 1
    mov eax, 2000
    call Delay
    jmp gpn_done
   
gpn_showresume:
    call showresumemenu
   
gpn_done:
    pop ebx
    pop ecx
    pop edx
    pop eax
    ret
getplayername ENDP

saveplayertofile PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    call readallplayersfromfile
    call findplayerinarray
    cmp al, 1
    je snf_updateexisting
   
snf_addnew:
    movzx eax, playerrecordcount
    cmp al, totalplayers
    jge snf_skip

    mov ebx, playernamelength
    mul ebx
    mov edi, OFFSET allplayernames
    add edi, eax
    mov esi, OFFSET playername
    mov ecx, playernamelength
    rep movsb

    ;add eax, 0
    movzx eax, playerrecordcount
    mov ebx, 4
    mul ebx
    mov edi, OFFSET allplayerscores
    add edi, eax
    mov eax, score
    mov [edi], eax
    movzx eax, playerrecordcount
    mov edi, OFFSET levelsofallplayers
    add edi, eax
    mov al, currentlevel
    mov [edi], al
    inc playerrecordcount
    jmp snf_sort
   
snf_updateexisting:
    movzx eax, indexofplayerfound
    mov ebx, 4
    mul ebx
    mov edi, OFFSET allplayerscores
    add edi, eax
    mov eax, score
    mov [edi], eax
    movzx eax, indexofplayerfound
    mov edi, OFFSET levelsofallplayers
    add edi, eax
    mov al, currentlevel
    mov [edi], al

snf_sort:
    call sortplayersbyscore
    call writeallplayerstofile
   
snf_skip:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
saveplayertofile ENDP

findplayerinarray PROC
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov indexofplayerfound, 0
    movzx ecx, playerrecordcount
    cmp ecx, 0
    je fpa_notfound
    xor ebx, ebx

fpa_searchloop:
    cmp ebx, ecx
    jge fpa_notfound

    mov eax, ebx
    push edx
    mov edx, playernamelength
    mul edx
    pop edx
    mov edi, OFFSET allplayernames
    add edi, eax
    mov esi, OFFSET playername

fpa_compareloop:
    mov al, [esi]
    mov ah, [edi]
    cmp al, 0
    jne fpa_checkchar

    cmp ah, 0
    je fpa_found
    jmp fpa_nextplayer
   
fpa_checkchar:
    cmp al, ah
    jne fpa_nextplayer
   
    inc esi
    inc edi
    jmp fpa_compareloop
   
fpa_nextplayer:
    inc ebx
    ;add ebx, 0
    jmp fpa_searchloop
   
fpa_found:
    mov eax, ebx
    mov indexofplayerfound, al
    mov al, 1
    jmp fpa_done
   
fpa_notfound:
    mov al, 0
fpa_done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
findplayerinarray ENDP

updatetimer PROC
    push eax
    push ebx
    inc timercounter
    mov al, timerdelay
    cmp timercounter, al
    jb ut_done

    mov timercounter, 0
    cmp timeleft, 0
    jle ut_checktimeover

    dec timeleft
    call drawhud
   
    cmp timeleft, 0
    jne ut_done

ut_checktimeover:
    ;mov ebx, 0
    cmp timeleft, 0
    jg ut_done

    call showtimeovermsg
    dec lives
    call drawhud

    cmp lives, 0
    jle ut_gameover

    mov timeleft, 300
    call resetlevelafterdeath
    jmp ut_done

ut_gameover:
    call showgameover
    mov gamestate, 0
ut_done:
    pop ebx
    pop eax
    ret
updatetimer ENDP

showtimeovermsg PROC
    push eax
    push edx
    push ecx
    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET timeovermessage
    call WriteString
    mov ecx, 3

tom_flash:
    push ecx
    mov eax, 400
    call Delay

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET timeovermessage
    call WriteString
   
    mov eax, 300
    call Delay

    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET timeovermessage
    call WriteString
    pop ecx
    loop tom_flash

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov ecx, 30

tom_clear:
    mov al, ' '
    call WriteChar
    loop tom_clear
   
    pop ecx
    pop edx
    pop eax
    ret
showtimeovermsg ENDP

updateenemies PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    movzx ecx, enemyCount
    mov esi, 0

ue_loop:
    cmp esi, ecx
    jge ue_done

    mov al, enemyactive[esi]
    cmp al, 0
    je ue_next

    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call eraseenemyatpos

    mov bl, currentlevel
    cmp bl, 2
    jne ue_aftererase

    inc dl
    call eraseenemyatpos

ue_aftererase:
    mov al, enemydirection[esi]
    add enemyx[esi], al
    cmp esi, 4
    je ue_groundenemy

    mov al, enemyx[esi]
    cmp al, enemyminxcoordinate[esi]
    jle ue_reverseplatform

    cmp al, enemymaxxcoordinate[esi]
    jge ue_reverseplatform
    jmp ue_draw

ue_reverseplatform:
    mov al, enemydirection[esi]
    neg al
    mov enemydirection[esi], al
    mov al, enemydirection[esi]
    add enemyx[esi], al
    jmp ue_draw

ue_groundenemy:
    mov al, enemyx[esi]
    cmp al, 0
    jle ue_reverseground
    cmp al, 79
    jge ue_reverseground
   
    call checkgroundobstacle
    cmp al, 1
    je ue_reverseground
    jmp ue_draw

ue_reverseground:
    mov al, enemydirection[esi]
    neg al
    mov enemydirection[esi], al
    mov al, enemydirection[esi]
    add enemyx[esi], al

ue_draw:
    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    push eax
    mov al, currentlevel
    cmp al, 2
    pop eax
    je ue_drawl2
   
    call drawenemyatpos
    jmp ue_continue
   
ue_drawl2:
    ;check if this is a shell or normal enemy
    mov al, enemyshellactive[esi]
    cmp al, 1
    je ue_drawshell
    
    ;draw normal enemy
    push eax
    mov eax, lightRed + (black * 16)
    call SetTextColor
    call Gotoxy
    mov al, 'E'
    call WriteChar
    mov al, 'E'
    call WriteChar
    pop eax
    jmp ue_continue
    
ue_drawshell:
    ;draw shell (egg)
    push eax
    mov eax, yellow + (black * 16)
    call SetTextColor
    call Gotoxy
    mov al, '0'
    call WriteChar
    mov al, '0'
    call WriteChar
    pop eax

ue_continue:
ue_next:
    inc esi
    jmp ue_loop

ue_done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
updateenemies ENDP


getbackgroundatpos PROC
    push ebx
    mov al, ' '
    cmp dh, 24
    jne gbp_checkplatforms
    mov al, '#'
    pop ebx
    ret

gbp_checkplatforms:
    cmp dh, realplatform1y
    jne gbp_qp2

    movzx ebx, dl
    cmp bl, realplatform1x
    jb gbp_qp2

    cmp bl, realplatform1end
    ja gbp_qp2

    sub bl, realplatform1x
    mov al, realplatform1[ebx]
    pop ebx
    ret

gbp_qp2:
    cmp dh, realplatform2y
    jne gbp_qp3

    movzx ebx, dl
    cmp bl, realplatform2x
    jb gbp_qp3

    cmp bl, realplatform2end
    ja gbp_qp3

    sub bl, realplatform2x
    mov al, realplatform2[ebx]
    pop ebx
    ret

gbp_qp3:
    cmp dh, realplatform3y
    jne gbp_qp4

    movzx ebx, dl
    cmp bl, realplatform3x
    jb gbp_qp4

    cmp bl, realplatform3end
    ja gbp_qp4

    sub bl, realplatform3x
    mov al, realplatform3[ebx]
    pop ebx
    ret

gbp_qp4:
    cmp dh, realplatform4y
    jne gbp_sky

    movzx ebx, dl
    cmp bl, realplatform4x
    jb gbp_sky

    cmp bl, realplatform4end
    ja gbp_sky

    sub bl, realplatform4x
    mov al, realplatform4[ebx]
    pop ebx
    ret

gbp_sky:
    mov al, ' '
    pop ebx
    ret
getbackgroundatpos ENDP

checkgroundobstacle PROC
    push ebx
    push ecx
    mov bl, enemyx[4]
    mov al, enemyy[4]
    cmp al, 23
    jne cgo_clear
   
    cmp bl, hill1leftbound
    jb cgo_checkpipe2

    cmp bl, hill1rightbound
    ja cgo_checkpipe2

    mov al, 1
    jmp cgo_done

cgo_checkpipe2:
    cmp bl, hill2leftbound
    jb cgo_checkhill1

    cmp bl, hill2rightbound
    ja cgo_checkhill1

    mov al, 1
    jmp cgo_done

cgo_checkhill1:
    cmp bl, 5
    jb cgo_checkhill2

    cmp bl, 10
    ja cgo_checkhill2

    mov al, 1
    jmp cgo_done

cgo_checkhill2:
    ;mov ecx, 0
    cmp bl, 35
    jb cgo_checkhill3

    cmp bl, 42
    ja cgo_checkhill3

    mov al, 1
    jmp cgo_done

cgo_checkhill3:
    cmp bl, 68
    jb cgo_checkflag

    cmp bl, 73
    ja cgo_checkflag

    mov al, 1
    jmp cgo_done

cgo_checkflag:
    cmp bl, flagpolex
    jne cgo_clear

    mov al, 1
    jmp cgo_done

cgo_clear:
    mov al, 0
cgo_done:
    pop ecx
    pop ebx
    ret
checkgroundobstacle ENDP

applygravityenemy PROC
    push eax
    push ebx
    push edx

aeg_loop:
    mov bl, enemyx[esi]
    mov dl, bl
    mov dh, enemyy[esi]
    call getfloory
    mov bl, al
    cmp enemyy[esi], bl
    jge aeg_done

    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call eraseenemyatpos
    inc enemyy[esi]

aeg_done:
    pop edx
    pop ebx
    pop eax
    ret
applygravityenemy ENDP

checkenemycollision PROC
    push ebx
    push ecx
    push edx
    push esi
    cmp invincible, 1
    jne cec_notinvincible
    mov al, 0
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

cec_notinvincible:
    movzx ecx, enemyCount
    xor esi, esi

cec_nextenemy:
    cmp esi, ecx
    jge cec_nocollision

    mov al, enemyactive[esi]
    cmp al, 0
    je cec_incindex

    mov al, xposition
    mov bl, enemyx[esi]
    cmp al, bl
    jge cec_x_marioright

    sub bl, al
    jmp cec_x_ready

cec_x_marioright:
    sub al, bl
    mov bl, al

cec_x_ready:
    cmp bl, 1
    ja cec_incindex

    mov al, yposition
    mov dl, enemyy[esi]
    mov bh, al
    sub bh, dl
    cmp bh, 0
    jle cec_trystomp
    cmp bh, 1
    ja cec_incindex

    mov al, currentlevel
    cmp al, 2
    je cec_level2_mechanics
    
    ;level 1, normal one-hit kill
    mov byte ptr enemyactive[esi], 0
    call playenemydefeat

    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call eraseenemyatpos

    mov eax, 300
    add score, eax
    call drawhud
    call showenemydestroyedmsg
    call bounceafterenemykill

    mov al, 0
    jmp cec_done

cec_level2_mechanics:
    ;level2 , two-hit shell system
    mov al, enemyhitcount[esi]
    cmp al, 0
    je cec_firsthit
    
    ;second hit, shell is destroyed
    mov byte ptr enemyactive[esi], 0
    mov byte ptr enemyshellactive[esi], 0
    call playenemydefeat

    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call eraseenemyatpos

    mov eax, 500
    add score, eax
    call drawhud
    call showenemydestroyedmsg
    call bounceafterenemykill

    mov al, 0
    jmp cec_done

cec_firsthit:
    ;first hit, enemy becomes shell
    mov byte ptr enemyshellactive[esi], 1
    mov byte ptr enemyhitcount[esi], 1
    call playenemydefeat
    
    ;erase old enemy
    mov dl, enemyx[esi]
    mov dh, enemyy[esi]
    call eraseenemyatpos
    
    mov eax, 300
    add score, eax
    call drawhud
    call showshellmsg
    call bounceafterenemykill

    mov al, 0
    jmp cec_done

cec_trystomp:
    mov bh, dl
    sub bh, yposition
    cmp bh, 2
    ja cec_incindex

    mov al, mariosize
    cmp al, 2
    je cec_sizedown

    dec lives
    call drawhud
    call showlifelostmsg

    cmp lives, 0
    jle cec_gameover

    call resetlevelafterdeath
    mov al, 1
    jmp cec_done

cec_sizedown:
    push eax
    push edx
    mov eax, black + (black * 16)
    call SetTextColor
    mov dl, xposition
    mov dh, yposition
    dec dh
    call Gotoxy
    mov al, ' '
    call WriteChar
    inc dl
    call Gotoxy
    call WriteChar
   
    pop edx
    pop eax
    mov mariosize, 1
    call showsizedownmsg

    mov invincible, 1
    mov invinciblecounter, 0
    mov al, 0
    jmp cec_done

cec_gameover:
    call showgameover
    mov al, 2
    jmp cec_done

cec_incindex:
    inc esi
    jmp cec_nextenemy

cec_nocollision:
    mov al, 0
cec_done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
checkenemycollision ENDP

stepenemiesandcheck PROC
    push eax
    push ebx
    inc enemymovementcounter
    mov al, enemymovementdelay
    cmp enemymovementcounter, al
    jb sec_skipmove

    mov enemymovementcounter, 0
    call updateenemies

sec_skipmove:
    call checkenemycollision
    pop ebx
    pop eax
    ret
stepenemiesandcheck ENDP

bounceafterenemykill PROC
    push eax
    push ecx
    push ebx
    mov ecx, 3

baek_bounceup:
    call eraseplayer
    dec yposition
    call drawplayer
    call shortdelay
    loop baek_bounceup

baek_fall:
    call getfloory
    mov bl, al
    cmp yposition, bl
    jge baek_done

    call eraseplayer
    inc yposition
    call drawplayer
    call shortdelay
    jmp baek_fall
   
baek_done:
    pop ebx
    pop ecx
    pop eax
    ret
bounceafterenemykill ENDP

showenemydestroyedmsg PROC
    push eax
    push edx
    push ecx
    mov eax, lightGreen + (lightBlue * 16)
    call SetTextColor

    mov dl, 25
    mov dh, 3
    call Gotoxy

    mov edx, OFFSET enemydestroyedmessage
    call WriteString

    mov ecx, 2
sedm_flash:
    push ecx
    mov eax, 200
    call Delay

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET enemydestroyedmessage
    call WriteString
   
    mov eax, 150
    call Delay
   
    mov eax, lightGreen + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET enemydestroyedmessage
    call WriteString
    pop ecx
    loop sedm_flash

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov ecx, 30

sedm_clear:
    mov al, ' '
    call WriteChar
    loop sedm_clear
   
    pop ecx
    pop edx
    pop eax
    ret
showenemydestroyedmsg ENDP

;show the message that a life is lost
showlifelostmsg PROC
    call playlifelostsound
    push eax
    push edx
    push ecx
    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET lifelostmessage
    call WriteString
    mov ecx, 3

llm_flash:
    push ecx
    mov eax, 300
    call Delay
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET lifelostmessage
    call WriteString

    mov eax, 200
    call Delay
    mov eax, lightRed + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET lifelostmessage
    call WriteString
    pop ecx
    loop llm_flash

    mov eax, white + (lightBlue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 3
    call Gotoxy
    mov ecx, 30

llm_clear:
    mov al, ' '
    call WriteChar
    loop llm_clear
   
    pop ecx
    pop edx
    pop eax
    ret
showlifelostmsg ENDP

resetlevelafterdeath PROC
    push eax
    push ebx
    mov timeleft, 300
    mov enemymovementcounter, 99
    mov timercounter, 0
    mov jumpstate, 0
    mov jumpcounter, 0
    mov jumpheight, 0
    mov xposition, 10
    mov yposition, 23
    push ebx
    mov ebx, lightGreen + (lightBlue * 16)
    mov mariocolor, ebx
    pop ebx
    mov invincible, 0
    mov dword ptr invinciblecounter, 0

    ;mov eax, 15
    mov byte ptr enemyx+0, 15
    mov byte ptr enemyx+1, 30
    mov byte ptr enemyx+2, 45
    mov byte ptr enemyx+3, 60
    mov byte ptr enemyx+4, 50

    mov byte ptr enemyy+0, 18
    mov byte ptr enemyy+1, 16
    mov byte ptr enemyy+2, 14
    mov byte ptr enemyy+3, 17
    mov byte ptr enemyy+4, 23

    mov byte ptr enemyactive+0, 1
    mov byte ptr enemyactive+1, 1
    mov byte ptr enemyactive+2, 1
    mov byte ptr enemyactive+3, 1
    mov byte ptr enemyactive+4, 1

    mov byte ptr enemydirection+0, 1
    mov byte ptr enemydirection+1, -1
    mov byte ptr enemydirection+2, 1
    mov byte ptr enemydirection+3, -1
    mov byte ptr enemydirection+4, -1
   
    mov BYTE ptr goldenmushroomactive[0], 1
    mov BYTE ptr goldenmushroomactive[1], 1

    mov BYTE ptr supermushroomactive[0], 1
    mov BYTE ptr supermushroomactive[1], 1
    mov BYTE ptr supermushroomactive[2], 1

    mov mariosize, 1
    mov invincible, 0
    mov invinciblecounter, 0
    mov al, currentlevel
    cmp al, 2
    je rlad_level2

    call clearbluesky
    call drawanimatedsky
    call drawhud
    call drawclouds
    call drawhills
    call drawground
    call drawplatforms
    call drawquestionplatforms
    call drawpipes
    call drawflagpole
    call drawblocks
    call drawcoins
    call drawenemies
    call drawplayer
   
    pop ebx
    pop eax
    ret

rlad_level2:
    call drawlevel2scene
    pop ebx
    pop eax
    ret
resetlevelafterdeath ENDP

showgameover PROC
    push eax
    push edx
    call stopmusic
    call saveplayertofile
    call clearblackscreen

    mov eax, lightRed + (black * 16)
    call SetTextColor
   
    mov dl, 0
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET gameovermenuline1
    call WriteString
   
    mov dl, 0
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET gameovermenuline2
    call WriteString
   
    mov dl, 0
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameovermenuline3
    call WriteString
   
    mov dl, 0
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET gameovermenuline4
    call WriteString
   
    mov dl, 0
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET gameovermenuline1
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
   
    mov dl, 15
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET gameovermenuline5
    call WriteString
   
    mov dl, 15
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET gameovermenuline6
    call WriteString
    call ReadChar
   
    pop edx
    pop eax
    ret
showgameover ENDP

clearwiththeme PROC
    push eax
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    pop eax
    ret
clearwiththeme ENDP

clearbluesky PROC
    push eax
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    call Clrscr
    pop eax
    ret
clearbluesky ENDP

clearblackscreen PROC
    push eax
    push ebx
    push ecx
    push edx  
    mov dh, 0
    
cwb_rowloop:
    cmp dh, 30
    jge cwb_done
    
    mov dl, 0
    
cwb_colloop:
    cmp dl, 80
    jge cwb_nextrow
    
    movzx eax, dh
    movzx ebx, dl
    add eax, ebx
    and eax, 1
    cmp eax, 0
    je cwb_black
    
cwb_white:
    mov eax, white + (white * 16)
    jmp cwb_draw
    
cwb_black:
    ;mov ebx, 0
    mov eax, black + (black * 16)
    
cwb_draw:
    call SetTextColor
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    inc dl
    jmp cwb_colloop
    
cwb_nextrow:
    inc dh
    jmp cwb_rowloop
    
cwb_done:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
clearblackscreen ENDP

shortdelay PROC
    push eax
    push ebx
    mov eax, 100
    call Delay
    pop ebx
    pop eax
    ret
shortdelay ENDP

mediumdelay PROC
    push eax
    push ebx
    mov eax, 300
    call Delay
    pop ebx
    pop eax
    ret
mediumdelay ENDP

getfloory PROC
    push ebx
    push edx
    push ecx
    mov al, 23
    mov bl, xposition
    mov dl, yposition
    cmp bl, realplatform1x
    jb gf_qp2

    cmp bl, realplatform1end
    ja gf_qp2

    cmp dl, realplatform1floory
    ja gf_qp2

    cmp al, realplatform1floory
    jle gf_qp2

    mov al, realplatform1floory

gf_qp2:
    cmp bl, realplatform2x
    jb gf_qp3

    cmp bl, realplatform2end
    ja gf_qp3

    cmp dl, realplatform2floory
    ja gf_qp3

    cmp al, realplatform2floory
    jle gf_qp3

    mov al, realplatform2floory

gf_qp3:
    cmp bl, realplatform3x
    jb gf_qp4

    cmp bl, realplatform3end
    ja gf_qp4

    cmp dl, realplatform3floory
    ja gf_qp4

    cmp al, realplatform3floory
    jle gf_qp4

    mov al, realplatform3floory

gf_qp4:
    cmp bl, realplatform4x
    jb gf_qp5

    cmp bl, realplatform4end
    ja gf_qp5

    cmp dl, realplatform4floory
    ja gf_qp5

    cmp al, realplatform4floory
    jle gf_qp5

    mov al, realplatform4floory

gf_qp5:
    ;mov ecx, 5
    cmp bl, realplatform5x
    jb gf_qp6

    cmp bl, realplatform5end
    ja gf_qp6

    cmp dl, realplatform5floory
    ja gf_qp6

    cmp al, realplatform5floory
    jle gf_qp6

    mov al, realplatform5floory

gf_qp6:
    cmp bl, realplatform6x
    jb gf_qp7

    cmp bl, realplatform6end
    ja gf_qp7

    cmp dl, realplatform6floory
    ja gf_qp7

    cmp al, realplatform6floory
    jle gf_qp7

    mov al, realplatform6floory

gf_qp7:
    cmp bl, realplatform7x
    jb gf_qp8

    cmp bl, realplatform7end
    ja gf_qp8

    cmp dl, realplatform7floory
    ja gf_qp8

    cmp al, realplatform7floory
    jle gf_qp8

    mov al, realplatform7floory

gf_qp8:
    cmp bl, realplatform8x
    jb gf_hills

    cmp bl, realplatform8end
    ja gf_hills

    cmp dl, realplatform8floory
    ja gf_hills

    cmp al, realplatform8floory
    jle gf_hills

    mov al, realplatform8floory

gf_hills:
    cmp bl, 5
    jb gf_hill2

    cmp bl, 10
    ja gf_hill2

    cmp dl, 22
    ja gf_hill2

    cmp al, 22
    jle gf_hill2
    mov al, 22

gf_hill2:
    cmp bl, 35
    jb gf_hill3

    cmp bl, 42
    ja gf_hill3

    cmp dl, 22
    ja gf_hill3

    cmp al, 22
    jle gf_hill3
    mov al, 22

gf_hill3:
    cmp bl, 68
    jb gf_pipe2

    cmp bl, 73
    ja gf_pipe2

    cmp dl, 22
    ja gf_pipe2

    cmp al, 22
    jle gf_pipe2
    mov al, 22

gf_pipe2:
    cmp bl, hill2leftbound
    jb gf_pipe1

    cmp bl, hill2rightbound
    ja gf_pipe1

    cmp dl, 20
    ja gf_pipe1

    cmp al, 20
    jle gf_pipe1
    mov al, 20

gf_pipe1:
    cmp bl, hill1leftbound
    jb gf_done

    cmp bl, hill1rightbound
    ja gf_done

    cmp dl, 19
    ja gf_done

    cmp al, 19
    jle gf_done
    mov al, 19

gf_done:
    movzx eax, al
    pop ecx
    pop edx
    pop ebx
    ret
getfloory ENDP

showwelcomescreen PROC
    push eax
    push edx
    call clearblackscreen
    mov eax, lightRed + (black * 16)
    call SetTextColor
   
    mov dl, 8
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET supertitlelineone
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET supertitlelinetwo
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET supertitlelinethree
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET supertitlelinefour
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET supertitlelinefive
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET supertitlelinesix
    call WriteString
    call shortdelay

    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 8
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET mariotitlelineone
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET mariotitlelinetwo
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET mariotitlelinethree
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET mariotitlelinefour
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET mariotitlelinefive
    call WriteString
    call shortdelay
   
    mov dl, 8
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET mariotitlelinesix
    call WriteString
    call shortdelay

    mov eax, lightRed + (black * 16)
    call SetTextColor
   
    mov dl, 25
    mov dh, 19
    call Gotoxy
    mov edx, OFFSET brostitlelineone
    call WriteString
    call shortdelay
   
    mov dl, 25
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET brostitlelinetwo
    call WriteString
    call shortdelay
   
    mov dl, 25
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET brostitlelinethree
    call WriteString
    call shortdelay

    mov dl, 25
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET brostitlelinefour
    call WriteString
    call shortdelay

    mov dl, 25
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET brostitlelinefive
    call WriteString
    call shortdelay

    mov dl, 25
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET brostitlelinesix
    call WriteString
    call shortdelay

    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 26
    call Gotoxy
    mov edx, OFFSET welcomerollnumber
    call WriteString

    mov ecx, 3

ws_blinkloop:
    push ecx
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 28
    call Gotoxy
    mov edx, OFFSET welcomeprompt
    call WriteString
    call mediumdelay
    pop ecx
    loop ws_blinkloop

    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 27
    call Gotoxy
    mov edx, OFFSET welcomeextramessage
    call WriteString

    call ReadChar
    pop edx
    pop eax
    ret
showwelcomescreen ENDP

showinstructions PROC
    push eax
    push edx
instr_loop:
    call clearblackscreen

    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 4
    call Gotoxy
    mov edx, OFFSET instructionsline1
    call WriteString

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET instructionsline4
    call WriteString

    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET instructionsline5
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
   
    mov dl, 6
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET instructionsline3
    call WriteString

    mov dl, 6
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET instructionsline6
    call WriteString

    mov dl, 6
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET instructionsline7
    call WriteString

    mov dl, 6
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET instructionsline8
    call WriteString

    mov dl, 6
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET instructionsline9
    call WriteString

    mov dl, 6
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET instructionsline10
    call WriteString

    mov dl, 6
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET instructionsline11
    call WriteString

    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET instructionsline12
    call WriteString

    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET instructionsline2
    call WriteString

    call ReadChar
    cmp al, 'b'
    je instr_exit
    cmp al, 'B'
    je instr_exit
    jmp instr_loop

instr_exit:
    pop edx
    pop eax
    ret
showinstructions ENDP

showhighscore PROC
    push eax
    push edx
    call clearblackscreen

    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 0
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET highscoremenuline1
    call WriteString
   
    mov dl, 0
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET highscoremenuline3
    call WriteString
   
    mov dl, 0
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET highscoremenuline4
    call WriteString
   
    mov dl, 0
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET highscoremenuline1
    call WriteString

    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov dl, 12
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET leaderboardmenuline1
    call WriteString

    call displaytop5leaderboard

    mov eax, yellow + (black * 16)
    call SetTextColor
   
    mov dl, 0
    mov dh, 19
    call Gotoxy
    mov edx, OFFSET highscoremenuline1
    call WriteString
   
    mov dl, 0
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET highscoremenuline6
    call WriteString
   
    mov dl, 0
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET highscoremenuline7
    call WriteString
   
    mov dl, 0
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET highscoremenuline1
    call WriteString

shs_wait:
    call ReadChar
    cmp al, 'b'
    je shs_back
    cmp al, 'B'
    je shs_back
    jmp shs_wait
   
shs_back:
    pop edx
    pop eax
    ret
showhighscore ENDP

showmainmenu PROC
    push eax
    push edx
menu_loop:
    call clearwiththeme

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET menuline1
    call WriteString
    call shortdelay

    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET menuline4
    call WriteString
    call shortdelay

    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET menuline5
    call WriteString

    mov eax, lightGreen + (black * 16)
    call SetTextColor

    mov dl, 6
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET menuline3
    call WriteString

    mov dl, 6
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET menuline6
    call WriteString
    call shortdelay

    mov dl, 6
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET menuline7
    call WriteString
    call shortdelay

    mov dl, 6
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET menuline8
    call WriteString
    call shortdelay

    mov dl, 6
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET menuline9
    call WriteString
    call shortdelay

    mov dl, 6
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET menuline10
    call WriteString

    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET menuline11
    call WriteString

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET menuline2
    call WriteString

    call ReadChar

    mov menuchoice, al
    cmp al, '1'
    je startgame_choice

    cmp al, '2'
    je highscore_choice

    cmp al, '3'
    je instructions_choice

    cmp al, '4'
    je exit_choice

    jmp menu_loop

startgame_choice:
    call getplayername
    call startgamefromlevel

    mov gamestate, 1
    call startmusic
    pop edx
    pop eax
    ret

highscore_choice:
    call showhighscore
    jmp menu_loop

instructions_choice:
    call showinstructions
    jmp menu_loop

exit_choice:
    exit
showmainmenu ENDP

showpausemenu PROC
    push eax
    push edx
    call stopmusic

pause_loop:
    call clearwiththeme

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET pausemenuline1
    call WriteString

    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET pausemenuline4
    call WriteString

    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET pausemenuline5
    call WriteString

    mov eax, lightGreen + (black * 16)
    call SetTextColor

    mov dl, 6
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET pausemenuline3
    call WriteString

    mov dl, 6
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET pausemenuline6
    call WriteString

    mov dl, 6
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET pausemenuline7
    call WriteString

    mov dl, 6
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET pausemenuline8
    call WriteString

    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET pausemenuline9
    call WriteString

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 6
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET pausemenuline2
    call WriteString

    call ReadChar

    cmp al, '1'
    je pause_resume

    cmp al, '2'
    je pause_exit

    jmp pause_loop

pause_resume:
    call startmusic
    pop edx
    pop eax
    ret

pause_exit:
    call stopmusic
    mov gamestate, 0
    pop edx
    pop eax
    ret
showpausemenu ENDP

;check collision with coins
checkcoincollision PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, coincount
    cmp ecx, 0
    je ccc_done

    mov esi, 0

ccc_loop:
    cmp esi, ecx
    jge ccc_done

    cmp esi, 10
    jae ccc_next
   
    mov al, coinactive[esi]
    cmp al, 0
    je ccc_next

    cmp esi, 10
    jae ccc_next

    mov dl, coinx[esi]
    cmp esi, 10
    jae ccc_next

    ;mov ebx, edx
    mov dh, coiny[esi]
    mov al, xposition
    sub al, dl
    cmp al, 1
    jbe ccc_checkvertical1
   
    mov al, dl
    sub al, xposition
    cmp al, 1
    ja ccc_next

ccc_checkvertical1:
    mov al, yposition
    sub al, dh
    cmp al, 2
    jbe ccc_collect
   
    mov al, dh
    sub al, yposition
    cmp al, 2
    jbe ccc_collect
    jmp ccc_next

ccc_collect:
    mov coinactive[esi], 0
    push eax
    mov eax, white + (lightBlue * 16)
    call SetTextColor
    call Gotoxy

    mov al, ' '
    call WriteChar

    pop eax
    call playcoinsound

    inc coins
    mov eax, coinvalue
    add score, eax
    mov eax, score
    cmp eax, highscore
    jle ccc_afterhs

    mov highscore, eax
   
ccc_afterhs:
    call drawhud

    push eax
    mov eax, 100
    call Delay

    pop eax

ccc_next:
    inc esi
    jmp ccc_loop

ccc_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
checkcoincollision ENDP

checkpowerupcollision PROC
    push eax
    push ecx
    push edx
    push esi
    push ebx
    movzx ecx, powercount
    cmp ecx, 0
    je cpc2_done

    mov esi, 0

cpc2_loop:
    cmp esi, ecx
    jge cpc2_done

    cmp esi, 8
    jae cpc2_next

    mov al, poweractive[esi]
    cmp al, 0
    je cpc2_next

    cmp esi, 8
    jae cpc2_next

    mov dl, powerx[esi]
    cmp esi, 8
    jae cpc2_next

    mov dh, powery[esi]
    mov al, xposition
    sub al, dl
    cmp al, 1
    jbe cpc2_checkvertical
   
    mov al, dl
    sub al, xposition
    cmp al, 1
    jbe cpc2_checkvertical

    jmp cpc2_next

cpc2_checkvertical:
    mov al, yposition
    sub al, dh
    cmp al, 1
    jbe cpc2_collect
   
    mov al, dh
    sub al, yposition
    cmp al, 1
    jbe cpc2_collect

    jmp cpc2_next

cpc2_collect:
    cmp esi, 8
    jae cpc2_next
    mov al, powertype[esi]
    cmp al, 1
    je cpc2_goldenmushroom

    mov byte ptr poweractive[esi], 0
    call playsoundpowerup
   
    inc lives
    add score, 500
    push eax
    push edx
    mov eax, white + (lightBlue * 16)
    call SetTextColor

    mov dl, 20
    mov dh, 3
    call Gotoxy

    mov edx, OFFSET powermessage
    call WriteString

    pop edx
    pop eax
    jmp cpc2_updatehud
   
cpc2_goldenmushroom:
    mov byte ptr poweractive[esi], 0
    call playsoundpowerup
    call playsoundpowerup
   
    mov eax, 1000
    add score, eax
    mov invincible, 1
    mov invinciblecounter, 0
    call showgoldenmushroommsg
   
cpc2_updatehud:
    call drawhud

    mov dl, powerx[esi]
    mov dh, powery[esi]
    call erasepowerupatpos

cpc2_next:
    inc esi
    jmp cpc2_loop

cpc2_done:
    pop ebx
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
checkpowerupcollision ENDP

checkpipecollision PROC
    push ebx
    push edx
    push ecx
    cmp dl, hill1leftbound
    jb cpc_checkpipe2

    cmp dl, hill1rightbound
    ja cpc_checkpipe2

    cmp dh, hill1topbound
    jb cpc_checkpipe2

    cmp dh, hill1bottombound
    ja cpc_checkpipe2

    mov al, 1
    jmp cpc_exit

cpc_checkpipe2:
    ;mov ecx, 0
    cmp dl, hill2leftbound
    jb cpc_nocollision

    cmp dl, hill2rightbound
    ja cpc_nocollision

    cmp dh, hill2topbound
    jb cpc_nocollision

    cmp dh, pipe2Bottom
    ja cpc_nocollision

    mov al, 1
    jmp cpc_exit

cpc_nocollision:
    mov al, 0

cpc_exit:
    pop ecx
    pop edx
    pop ebx
    ret
checkpipecollision ENDP

checkflagcollision PROC
    push ebx
    mov al, xposition
    mov bl, flagpolex
    cmp al, bl
    jb cfc_no

    call playflagpolesound

    mov al, 1
    pop ebx
    ret

cfc_no:
    mov al, 0
    pop ebx
    ret
checkflagcollision ENDP

applygravity PROC
    push eax
    push ebx
ag_loop:
    call getfloory
    mov bl, al
    cmp yposition, bl
    jge ag_done

    call eraseplayer

    inc yposition
    call drawplayer

    call shortdelay

    jmp ag_loop

ag_done:
    pop ebx
    pop eax
    ret
applygravity ENDP

jumpshort PROC
    push eax
    push ecx
    push ebx
    call playjumpsound

    mov ecx, 4
    mov bl, 0
   
js_uploop:
    call eraseplayer

    dec yposition
    call drawplayer
   
    inc bl
    cmp bl, 2
    jb js_noenemyupdateup
   
    call updateenemies
    call checkenemycollision

    cmp al, 1
    je js_exit

    cmp al, 2
    je js_exit

    mov bl, 0
   
js_noenemyupdateup:
    call shortdelay
    loop js_uploop

js_fall:
    call getfloory
    mov bh, al
    cmp yposition, bh
    jge js_exit
   
    call eraseplayer
    inc yposition
    call drawplayer

    cmp invincible, 1
    je js_skipenemycheck

    call updateenemies
    call checkenemycollision

    cmp al, 1
    je js_exit

    cmp al, 2
    je js_exit
   
js_skipenemycheck:
    call shortdelay
    jmp js_fall

js_exit:
    call checkcoincollision
    pop ebx
    pop ecx
    pop eax
    ret
jumpshort ENDP

jumphigh PROC
    push eax
    push ecx
    push ebx
    call playjumpsound

    mov ecx, 8
    mov bl, 0
   
jh_uploop:
    call eraseplayer
    dec yposition
    call drawplayer
   
    inc bl
    cmp bl, 2
    jb jh_noenemyupdateup
   
    call updateenemies
    call checkenemycollision

    cmp al, 1
    je jh_exit

    cmp al, 2
    je jh_exit

    mov bl, 0
   
jh_noenemyupdateup:
    call shortdelay
    loop jh_uploop

jh_fall:
    call getfloory
    mov bh, al
    cmp yposition, bh
    jge jh_exit
   
    call eraseplayer
    inc yposition
    call drawplayer

    cmp invincible, 1
    je jh_skipenemycheck

    call updateenemies
    call checkenemycollision

    cmp al, 1
    je jh_exit

    cmp al, 2
    je jh_exit
   
jh_skipenemycheck:
    call shortdelay
    jmp jh_fall

jh_exit:
    call checkcoincollision
    pop ebx
    pop ecx
    pop eax
    ret
jumphigh ENDP

updateenemiesandcheck PROC
    push eax
    push ebx
    inc enemymovementcounter
    mov al, enemymovementdelay
    cmp enemymovementcounter, al
    jb ueac_nomove

    mov enemymovementcounter, 0
    call updateenemies
   
ueac_nomove:
    call checkenemycollision

    pop ebx
    pop eax
    ret
updateenemiesandcheck ENDP

updatejump PROC
    push eax
    push ebx
    cmp jumpstate, 0
    je uj_done

    cmp jumpcounter, 0
    jle uj_fall

    call eraseplayer
    dec yposition
    dec jumpcounter
    call drawplayer
    jmp uj_done
   
uj_fall:
    call getfloory
    mov bl, al
    cmp yposition, bl
    jge uj_endjump

    call eraseplayer

    inc yposition
    call drawplayer

    jmp uj_done
   
uj_endjump:
    mov jumpstate, 0
    call checkcoincollision
    call checkpowerupcollision
   
uj_done:
    pop ebx
    pop eax
    ret
updatejump ENDP

showlevelcomplete PROC
    push eax
    push edx
    push ecx
    call stopmusic

    call playbackgroundmusic

    call clearblackscreen

    mov ecx, 3
slc_starblink:
    push ecx
    mov eax, yellow + (black * 16)
    call SetTextColor

    mov dl, 5
    mov dh, 2
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline16
    call WriteString
   
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline17
    call WriteString
   
    call mediumdelay
   
    mov eax, black + (black * 16)
    call SetTextColor

    mov dl, 5
    mov dh, 2
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline16
    call WriteString
   
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline17
    call WriteString
   
    call shortdelay
    pop ecx
    loop slc_starblink

    mov eax, yellow + (black * 16)
    call SetTextColor

    mov dl, 5
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline16
    call WriteString
   
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline17
    call WriteString

    mov eax, lightCyan + (black * 16)
    call SetTextColor

    mov dl, 0
    mov dh, 4
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline1
    call WriteString
   
    mov dl, 0
    mov dh, 5
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline2
    call WriteString

    mov eax, lightMagenta + (black * 16)
    call SetTextColor

    mov dl, 0
    mov dh, 6
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline3
    call WriteString
   
    mov dl, 0
    mov dh, 7
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline2
    call WriteString

    call mediumdelay

    mov eax, lightRed + (black * 16)
    call SetTextColor
   
    mov dl, 20
    mov dh, 9
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline4
    call WriteString

    call shortdelay
   
    mov dl, 20
    mov dh, 10
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline5
    call WriteString

    call shortdelay
   
    mov dl, 20
    mov dh, 11
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline6
    call WriteString

    call shortdelay
   
    mov dl, 20
    mov dh, 12
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline7
    call WriteString

    call shortdelay
   
    mov dl, 20
    mov dh, 13
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline8
    call WriteString

    call shortdelay
   
    mov dl, 20
    mov dh, 14
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline9
    call WriteString

    call mediumdelay

    mov eax, lightGreen + (black * 16)
    call SetTextColor
   
    mov dl, 8
    mov dh, 16
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline10
    call WriteString

    call shortdelay
   
    mov dl, 8
    mov dh, 17
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline11
    call WriteString

    call shortdelay
   
    mov dl, 8
    mov dh, 18
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline12
    call WriteString

    call shortdelay
   
    mov dl, 8
    mov dh, 19
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline13
    call WriteString

    call shortdelay
   
    mov dl, 8
    mov dh, 20
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline14
    call WriteString

    call shortdelay
   
    mov dl, 8
    mov dh, 21
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline15
    call WriteString

    call mediumdelay

    mov ecx, 2

slc_fireworks:
    push ecx
    mov eax, yellow + (black * 16)
    call SetTextColor

    mov dl, 5
    mov dh, 23
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline18
    call WriteString
   
    mov eax, lightRed + (black * 16)
    call SetTextColor

    mov dl, 5
    mov dh, 24
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline19
    call WriteString
   
    mov eax, lightGreen + (black * 16)
    call SetTextColor

    mov dl, 5
    mov dh, 25
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline20
    call WriteString
   
    call mediumdelay
    pop ecx
    loop slc_fireworks

    mov eax, white + (black * 16)
    call SetTextColor
   
    mov dl, 10
    mov dh, 26
    call Gotoxy

    mov edx, OFFSET levelScoreMsg
    call WriteString
   
    push eax
    mov dl, 52
    mov dh, 26
    call Gotoxy

    mov eax, score
    call WriteDec
    pop eax

    mov dl, 10
    mov dh, 27
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline21
    call WriteString
   
    push eax
    mov dl, 52
    mov dh, 27
    call Gotoxy

    movzx eax, coins
    call WriteDec
    pop eax

    mov dl, 10
    mov dh, 28
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline22
    call WriteString
   
    push eax
    mov dl, 52
    mov dh, 28
    call Gotoxy

    mov eax, timeleft
    call WriteDec

    pop eax
    mov ecx, 3

slc_blinkinstructions:
    push ecx
    mov eax, lightCyan + (black * 16)
    call SetTextColor

    mov dl, 8
    mov dh, 30
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline23
    call WriteString
   
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 8
    mov dh, 31
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline24
    call WriteString
    call mediumdelay
   
    mov eax, black + (black * 16)
    call SetTextColor

    mov dl, 8
    mov dh, 30
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline23
    call WriteString
   
    mov dl, 8
    mov dh, 31
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline24
    call WriteString
   
    call shortdelay
    pop ecx
    loop slc_blinkinstructions

    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov dl, 8
    mov dh, 30
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline23
    call WriteString
   
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov dl, 8
    mov dh, 31
    call Gotoxy

    mov edx, OFFSET levelcompletionmenuline24
    call WriteString

    pop ecx
    pop edx
    pop eax
    ret
showlevelcomplete ENDP

main PROC
    push eax
    push ebx
    call showwelcomescreen

mainmenuentry:
    mov gamestate, 0
    call showmainmenu
    cmp gamestate, 1
    jne exitgame

    call startgamefromlevel
    mov timercounter, 0

    mov al, currentlevel
    cmp al, 2
    je drawinitiallevel2

    call clearbluesky
    call drawanimatedsky
    call drawhud
    call drawclouds
    call drawhills
    call drawground
    call drawplatforms
    call drawquestionplatforms
    call drawpipes
    call drawflagpole
    call drawblocks
    call drawcoins
    call drawenemies
    call drawplayer
    jmp startgameloop

drawinitiallevel2:
    call drawlevel2scene
    jmp startgameloop

startgameloop:
gameloop:
    call drawhud
    call updatemusic
    call updatetimer
    call updateinvincibility

    mov al, currentlevel
    cmp al, 2
    jne skip_lava_animation
    call drawlava
    
skip_lava_animation:
    cmp gamestate, 0
    je mainmenuentry

    inc enemymovementcounter
    mov al, enemymovementdelay
    cmp enemymovementcounter, al
    jb skipenemyupdate
    mov enemymovementcounter, 0
    call updateenemies
   
skipenemyupdate:
    cmp invincible, 1
    je skipenemydamagecheck
   
    call checkenemycollision
    cmp al, 1
    je gameloop

    cmp al, 2
    je mainmenuentry
   
skipenemydamagecheck:
    call checkcoincollision
    call checkpowerupcollision
    call checksecretareaentry
    call checkgoldenmushroom
    call checksupermushroom  
    call checkflagcollision
    cmp al, 1
    je levelcompleted

afterflagcheck:
    call ReadKey
    jz gameloop
   
    mov inputchar, al
    cmp inputchar, 'x'
    je exitgame

    cmp inputchar, 'X'
    je exitgame

    cmp inputchar, 'p'
    je dopause

    cmp inputchar, 'P'
    je dopause

    cmp inputchar, 'a'
    je moveleft

    cmp inputchar, 'A'
    je moveleft

    cmp inputchar, 'd'
    je moveright

    cmp inputchar, 'D'
    je moveright

    cmp inputchar, 'w'
    je doshortjump

    cmp inputchar, 'W'
    je dohighjump

    jmp gameloop

moveleft:
    call eraseplayer
    dec xposition
    cmp xposition, 0

    jge ml_checkpipe
    mov xposition, 0
    jmp ml_ok
   
ml_checkpipe:
    mov dl, xposition
    mov dh, yposition
    call checkpipecollision
    cmp al, 1
    jne ml_ok

    inc xposition
   
ml_ok:
    call drawplayer
    call applygravity
    call updateenemies
    call checkenemycollision
    cmp al, 1
    je gameloop

    cmp al, 2
    je mainmenuentry

    call checkflagcollision
    cmp al, 1
    je levelcompleted

    jmp gameloop

moveright:
    call eraseplayer
    inc xposition
    cmp xposition, 79
    jle mr_checkpipe

    mov xposition, 79
    jmp mr_ok
   
mr_checkpipe:
    mov dl, xposition
    mov dh, yposition
    call checkpipecollision
    cmp al, 1
    jne mr_ok

    dec xposition
   
mr_ok:
    call drawplayer
    call applygravity
    call updateenemies
    call checkenemycollision
    cmp al, 1
    je gameloop

    cmp al, 2
    je mainmenuentry

    call checkflagcollision
    cmp al, 1
    je levelcompleted

    jmp gameloop

doshortjump:
    call jumpshort
    jmp gameloop

dohighjump:
    call jumphigh
    jmp gameloop

dopause:
    call showpausemenu
    cmp gamestate, 1
    jne mainmenuentry

    mov al, currentlevel
    cmp al, 2
    je redrawlevel2afterpause

    call clearbluesky
    call drawanimatedsky
    call drawhud
    call drawclouds
    call drawhills
    call drawground
    call drawplatforms
    call drawquestionplatforms
    call drawpipes
    call drawflagpole
    call drawblocks
    call drawcoins
    call drawgoldenmushrooms
    call drawenemies
    call drawplayer
    jmp gameloop

redrawlevel2afterpause:
    call drawlevel2scene
    jmp gameloop

levelcompleted:
    mov al, currentlevel
    cmp al, 2
    je lc_gamecomplete        
   
    call showlevelcomplete
    call stopmusic
    call clearbluesky

    mov eax, yellow + (lightBlue * 16)
    call SetTextColor
    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline25
    call WriteString
   
    mov eax, red + (lightBlue * 16)
    call SetTextColor
    mov dh, 12
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline26
    call WriteString
   
    mov eax, yellow + (lightBlue * 16)
    call SetTextColor
    mov dh, 14
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelcompletionmenuline27
    call WriteString
   
lc_waitinput:
    call ReadChar
    cmp al, 13
    je lc_golevel2
    cmp al, 27
    je lc_backtomenu
    jmp lc_waitinput
   
lc_golevel2:
    mov currentlevel, 2
    call saveplayertofile
    call startgamefromlevel
    call drawlevel2scene
    call playbackgroundmusic
    jmp gameloop

lc_gamecomplete:
    call displaygamecomplete
    call stopmusic
    exit
   
lc_backtomenu:
    call saveplayertofile
    call stopmusic
    mov byte ptr enemyx+0, 70
    mov byte ptr enemyx+1, 60
    mov byte ptr enemyx+2, 50
    mov byte ptr enemyx+3, 40
    mov byte ptr enemyx+4, 30
    mov byte ptr enemyactive+0, 1
    mov byte ptr enemyactive+1, 1
    mov byte ptr enemyactive+2, 1
    mov byte ptr enemyactive+3, 1
    mov byte ptr enemyactive+4, 1
    mov gamestate, 0
    jmp mainmenuentry

exitgame:
    call stopmusic
    call saveplayertofile
    exit
main ENDP

END main

