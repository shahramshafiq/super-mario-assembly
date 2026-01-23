===================================================================================
                        COAL SUPER MARIO BROS - README
===================================================================================

A classic-style 2D platformer developed in x86 assembly (Irvine32), inspired by
Super Mario Bros. Navigate through two themed levels, collect coins, defeat
enemies, and reach the flagpole to complete the game.

-------------------------------------------------------------------------------
                         1. GAME OVERVIEW
-------------------------------------------------------------------------------

This game is console-based that uses ASCII characters and colors
to create a Mario-style world. The game features:

- Two distinct levels: an overworld (World 1-1) and an underground tunnel (World 1-2).
- A full menu system with welcome screen, main menu, pause, high scores, and game over.
- Player movement, jumping, gravity, and collision with platforms, enemies, and items.
- Scoring, lives, a timer, and persistent save/load via a text file.

This README documents all core features, controls, and technical details.

-------------------------------------------------------------------------------
                         2. GAMEPLAY FEATURES
-------------------------------------------------------------------------------

### 2.1 Core Mechanics

**Player Movement**
- Move left: press `A` or `a`.
- Move right: press `D` or `d`.
- Short jump: press `W` or `w`.
- High jump: press `W` or `w` (held for longer jump).
- Gravity pulls Mario down when not on a platform.
- Collision with platforms, pipes, and ground prevents falling through.

**Power-up System**
- **Super Mushroom (yellow)**: Hit a question block from below to grow into Super Mario (2×2 size). Grants 1000 points and 1 extra life.
- **Golden Mushroom**: Grants 1000 points and 5 seconds of invincibility (Mario flashes between green and magenta).
- **Extra Life Mushroom**: Gives +1 life and 500 points.
- **Size Down**: If Super Mario is hit by an enemy, he shrinks back to small Mario and becomes temporarily invincible.

**Character States**
- Small Mario: 1×1 character (M).
- Super Mario: 2×2 stacked character (MM on two rows).
- Invincibility: Mario flashes between green and magenta for a short time after being hit or after collecting a Golden Mushroom.
- Damage: When hit by an enemy (not invincible), Mario loses a life and respawns.

### 2.2 Collectibles

**Coins**
- Coins are represented by `o` and are scattered across both levels.
- Each coin is worth 200 points.
- A coin collection sound plays when a coin is picked up.
- The HUD shows the current coin count (COINS).

**Secret Area (Level 2)**
- In Level 2 (underground), there is a hidden secret area that can be entered by moving into a specific region.
- Entering the secret area awards +500 points and displays a special message.
- The secret area contains 3 extra coins (each worth 200 points) on small platforms.

### 2.3 Enemy System

**Enemy Types & Behaviors**
- Ground enemies (Koopa-style) patrol back and forth on platforms.
- Enemies move within defined left/right boundaries on each platform.
- Two-hit enemy system:
  - First hit (stomp from above): enemy becomes a shell (yellow 00).
  - Second hit (stomp or shell kick): enemy is destroyed and removed.
- Enemy-to-shell transformation: after the first hit, the enemy sprite changes to a shell.
- Shell kicking: if Mario touches a shell from the side, it is kicked and destroyed, giving 500 points.

**Enemy Interactions**
- Stomp from above: Mario jumps on the enemy’s head to defeat it.
- Side collision: if Mario touches an enemy from the side (not invincible), he loses a life and respawns.
- Shell destruction bonus: destroying a shell gives +500 points.

### 2.4 Level Design

**Two Complete Levels**
- **Level 1 (World 1-1)**: Overworld theme with sky, clouds, green hills, and grassy ground.
- **Level 2 (World 1-2)**: Underground tunnel theme with a dark background, lava at the bottom, and pipes.

**Environment Elements**
- Question mark blocks (`?`): floating blocks that can be hit from below to reveal power-ups.
- Solid platforms: platforms that Mario can walk on.
- Pipes/hills: green hills and pipes that act as obstacles and platforms.
- Animated lava (Level 2): lava at the bottom of Level 2 has a wave-like animation and color cycling (red/yellow).
- Flagpole: a white pole at the far right of each level; touching it completes the level.
- Checkerboard background patterns: used in some menus and screens.

-------------------------------------------------------------------------------
                     3. USER INTERFACE & MENUS
-------------------------------------------------------------------------------

### 3.1 Screen System

**Welcome Screen**
- Displays an animated title (SUPER MARIO BROS) and subtitle.
- Shows your roll number: "Roll No 24I-2541".
- Displays "Press ANY KEY to Start the Game".
- Includes a copyright notice: "c 2025 Assembly Edition".

**Main Menu**
- Options:
  - 1 START GAME – Begin from Level 1.
  - 2 HIGH SCORE – View the top 5 scores.
  - 3 INSTRUCTIONS – Show the control scheme.
  - 4 EXIT – Quit the game.
- Navigation: press 1, 2, 3, or 4 to select.

**Pause Menu**
- Appears when pressing `P` during gameplay.
- Options:
  - 1 RESUME – Continue playing.
  - 2 MAIN MENU – Return to the main menu.
- Navigation: press 1 or 2 to select.

**Game Over Screen**
- Appears when all lives are lost.
- Message: "You ran out of lives! Better luck next time!".
- Prompt: "Press any key to continue..." to return to the main menu.

**Level Completion Screen**
- Appears after reaching the flagpole in Level 1.
- Shows:
  - "CONGRATULATIONS!"
  - "YOU HAVE BEATEN LEVEL 1!"
  - Your score, coins collected, and time remaining.
- Options:
  - Press ENTER to continue to Level 2.
  - Press ESC to return to the main menu.

**Game Complete Screen**
- Appears after completing both levels.
- Shows:
  - A trophy ASCII art.
  - "THANK YOU FOR PLAYING SUPER MARIO BROS!".
  - Final score and total coins collected.
  - Firework animations.
- Prompt: "Press ANY KEY to close the window...".

### 3.2 HUD Elements

**Real-time Displays (top of screen)**
- MARIO: label for the score.
- SCORE: current score (updates when collecting coins, defeating enemies, etc.).
- COINS: number of coins collected so far.
- WORLD: shows "WORLD 1-1" in Level 1 and "WORLD 1-2" in Level 2.
- TIME: countdown timer (starts at 300 seconds).
- LIVES: number of remaining lives (starts at 5).

-------------------------------------------------------------------------------
                        4. AUDIO SYSTEM
-------------------------------------------------------------------------------

### 4.1 Sound Effects
- Background music: loops continuously during gameplay.
- Jump sound: plays when Mario jumps.
- Coin collection sound: plays when a coin is collected.
- Enemy defeat sound: plays when an enemy is stomped or destroyed.
- Power-up sound: plays when a power-up is collected.
- Life lost sound: plays when Mario loses a life.
- Flagpole completion sound: plays when the flagpole is reached.
- Sound priority: short sounds (coin, jump, etc.) can overlap without stopping the background music (SND_NOSTOP).

### 4.2 Music Control
- Background music starts automatically when the game begins.
- Music pauses when the game is paused or when menus are shown.
- Music resumes when gameplay continues.
- Music is played asynchronously and loops until explicitly stopped.

-------------------------------------------------------------------------------
                   5. SCORING, LIVES & PROGRESSION
-------------------------------------------------------------------------------

### 5.1 Scoring System
- Coins: +200 points each.
- Enemy first hit (shell): +300 points.
- Enemy destruction (shell kicked): +500 points.
- Secret area discovery: +500 points.
- Golden Mushroom: +1000 points.
- Extra Life Mushroom: +500 points.
- Time bonus: remaining time is added to the score at the end of each level.

### 5.2 Life System
- Starting lives: 5.
- Life loss:
  - Side collision with an enemy (when not invincible).
  - Timer runs out (TIME OVER!).
- Life gain:
  - Collecting an Extra Life Mushroom (+1 life).
- Game over: when lives reach 0, the game over screen is shown.

### 5.3 Timer System
- Each level starts with 300 seconds (5 minutes).
- Timer counts down in real time.
- When time reaches 0:
  - "TIME OVER! You lost 1 life!" is displayed.
  - One life is lost.
  - If lives > 0, Mario respawns; if lives = 0, game over.
- Remaining time is shown as a bonus on the level completion screen.

-------------------------------------------------------------------------------
                     6. DATA PERSISTENCE
-------------------------------------------------------------------------------

### 6.1 File Handling System
- Player name: entered at the start of a new game.
- Score saving: current score is saved to `players.txt`.
- Level progression: the current level (1 or 2) is saved so the game can resume.
- Multiple players: supports up to 50 player records in `players.txt`.
- Persistent high scores: scores are saved between game sessions and sorted by value.

### 6.2 Leaderboard System
- High Score menu shows the top 5 scores.
- Each entry displays:
  - Rank (1. to 5.).
  - Player name.
  - Score.
- Rank colors:
  - 1st: yellow.
  - 2nd: light gray.
  - 3rd: brown.
  - 4th and 5th: default white.
- If no scores exist, shows: "No scores recorded yet. Be the first!".

### 6.3 Resume System
- On startup, the game checks `players.txt` for a saved game.
- If a saved game is found:
  - Shows: "Your previous game was found! You were on Level 2 with score [score]".
  - Options:
    - 1 RESUME – Continue from Level 2 with the saved score.
    - 2 RESTART – Start fresh from Level 1 with 0 score.
- If no saved game is found, starts a new game from Level 1.

-------------------------------------------------------------------------------
                      7. VISUAL EFFECTS
-------------------------------------------------------------------------------

### 7.1 Animation System
- Mario sprite animation: movement and jumping are smooth.
- Enemy movement: enemies walk back and forth with a simple animation.
- Lava animation (Level 2): lava at the bottom has a wave-like pattern that animates and cycles colors (red/yellow).
- Power-up glow: question blocks and mushrooms have a subtle color glow effect.
- Firework animations: shown on the game complete screen.
- Star blink effects: used on the level completion screen.

### 7.2 Color System
- Mario colors:
  - Normal: light green on light blue (Level 1) or black (Level 2).
  - Invincible: flashes between light green and light magenta.
  - Super Mario: same color scheme, just larger.
- Enemy colors:
  - Normal enemy: light red on light blue/black.
  - Shell: yellow on black.
- Background colors:
  - Level 1: light blue sky, green ground.
  - Level 2: black background, gray/brown tunnel.
- Menu color schemes: different colors for titles, options, and messages.
- Text colors: used to highlight important messages (score, lives, warnings, etc.).

### 7.3 Special Effects
- Invincibility flashing: Mario rapidly changes color when invincible.
- Message flashing/clearing: messages like "Enemy destroyed!", "SHELL KICKED!", etc., flash briefly and then clear.
- Bounce effects: after defeating an enemy, Mario bounces up once before falling.
- Screen clearing with themes: different clear routines for sky, black, and checkerboard backgrounds.

-------------------------------------------------------------------------------
                      8. INPUT HANDLING
-------------------------------------------------------------------------------

### 8.1 Keyboard Controls
- Movement:
  - `A` / `a` – Move left.
  - `D` / `d` – Move right.
- Jumping:
  - `W` / `w` – Short jump.
  - `W` / `w` (held) – High jump.
- Game control:
  - `P` / `p` – Pause the game.
  - `X` / `x` – Exit the game (from main menu or pause menu).
- Menu navigation:
  - `1`, `2`, `3`, `4` – Select main menu options.
  - `ENTER` – Confirm/continue (e.g., on level completion).
  - `ESC` – Return to main menu.
  - `B` / `b` – Back to main menu (from instructions or high scores).

### 8.2 Menu Navigation
- Main menu: press 1–4 to select an option.
- Pause menu: press 1 or 2 to resume or return to main menu.
- Instructions / High Score: press `B` to go back to the main menu.
- Level completion: press `ENTER` to continue to Level 2 or `ESC` to return to main menu.

-------------------------------------------------------------------------------
                      9. GAME STATES
-------------------------------------------------------------------------------

The game uses a state machine with the following states:

- Welcome state: shows the welcome screen and waits for a key press.
- Menu state: main menu, high score, instructions.
- Gameplay state:
  - Level 1 (World 1-1).
  - Level 2 (World 1-2).
- Pause state: pause menu during gameplay.
- Level completion state: after reaching the flagpole.
- Game over state: when lives reach 0.
- Game complete state: after finishing both levels.

Transitions between states are handled by menu choices, level completion, and game over conditions.

-------------------------------------------------------------------------------
                     10. COLLISION SYSTEM
-------------------------------------------------------------------------------

### 10.1 Collision Detection
- Platform collision: Mario cannot fall through platforms or ground.
- Enemy collision:
  - Top collision (stomp): Mario jumps on the enemy’s head to defeat it.
  - Side collision: Mario touches the enemy from the side, causing damage (if not invincible).
- Pipe/hill collision: pipes and hills act as solid obstacles.
- Coin collision: Mario collects a coin when overlapping its position.
- Power-up collision: Mario collects a power-up when overlapping its position.
- Flagpole collision: touching the flagpole completes the level.
- Secret area entry: Mario enters the secret area when overlapping its region.
- Ground obstacle detection: enemies check for ground and obstacles to avoid falling.

### 10.2 Physics Simulation
- Gravity: continuously pulls Mario down when not on a platform.
- Jump trajectory: short jump (fewer frames) vs. high jump (more frames).
- Falling mechanics: Mario falls until he lands on a platform or the ground.
- Bounce physics: after defeating an enemy, Mario bounces up once before falling normally.

-------------------------------------------------------------------------------
                     11. TECHNICAL FEATURES
-------------------------------------------------------------------------------

### 11.1 Memory Management
- Arrays for game objects:
  - Coins, enemies, power-ups, platforms, etc., are stored in arrays.
- Buffer handling:
  - File I/O uses buffers to read and write player data.
  - Temporary storage for parsing and formatting scores and names.
- Dynamic color assignment:
  - Colors are stored in variables and updated based on Mario’s state (normal, invincible, super).

### 11.2 Timing Systems
- Frame-based timing: game logic runs per frame.
- Enemy movement delay: a counter controls how often enemies move.
- Timer countdown: a timer counter decrements every few frames to simulate seconds.
- Animation frame counters: used for lava, power-up glow, and other effects.
- Delay functions: used for flashing messages, bounce effects, and screen transitions.

### 11.3 Error Handling
- File open/close validation: checks if `players.txt` can be opened and closed.
- Boundary checking: ensures Mario and enemies stay within screen bounds.
- Array bounds checking: prevents reading/writing outside array limits.
- Invalid input handling: ignores keys that are not part of the control scheme.

-------------------------------------------------------------------------------
                     12. SPECIAL FEATURES
-------------------------------------------------------------------------------

### 12.1 Bonus Content
- Roll number display: "Roll No 24I-2541" on the welcome screen.
- Copyright notice: "c 2025 Assembly Edition".
- Assembly Edition credit: acknowledges the game as an assembly language project.
- Decorative elements:
  - Clouds and hills in Level 1.
  - Triangles and other ASCII decorations.
  - Lava waves and tunnel details in Level 2.

### 12.2 Accessibility Features
- Clear visual feedback: colors and messages clearly indicate state changes.
- Audio cues: every action (jump, coin, enemy, power-up, life lost) has a sound.
- Color coding: different colors for Mario, enemies, shells, and UI elements.
- Consistent control scheme: same keys work in all levels and menus.

### 12.3 Polish Elements
- Smooth animations: Mario and enemies move fluidly.
- Responsive controls: immediate reaction to key presses.
- Clear game state transitions: smooth transitions between screens and states.
- Professional menu layouts: aligned text, separators, and clear options.
- Thematic consistency: overworld and underground levels have distinct but coherent themes.

-------------------------------------------------------------------------------
                     13. FILE STRUCTURE
-------------------------------------------------------------------------------

### 13.1 Data Files
- `players.txt`: stores player names, scores, and current level for each player.
- `.wav` files: audio files for background music, jump, coin, enemy, power-up, life lost, and flagpole sounds.
- Player name storage: each player’s name is saved along with their score and level.
- Score sorting and ranking: scores are sorted in descending order to display the top 5 on the leaderboard.

### 13.2 Required Files
To run the game, the following files must be in the same directory:
- The compiled executable (e.g., `coal.exe`).
- `players.txt` (can be empty or missing; the game will create it).
- Sound files:
  - `background.wav` – background music.
  - `jump.wav` – jump sound.
  - `coin.wav` – coin collection sound.
  - `enemy.wav` – enemy defeat sound.
  - `powerup.wav` – power-up sound.
  - `lifelost.wav` – life lost
