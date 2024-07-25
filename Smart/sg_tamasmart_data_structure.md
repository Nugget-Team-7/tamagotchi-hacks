# TamaSma Card Data Structure

## Card Header
*80 bytes total*
- *2 bytes:* Number of 0x1000 sectors after the header
- *2 bytes:* Checksum of every 16-bit word from 0x1000 onwards (read words as ushorts and add them together, allowing overflow)
- *4 bytes:* ID of Paired Device 1
- *4 bytes:* ID of Paired Device 2
- *4 bytes:* ID of Paired Device 3
- *16 bytes:* Vendor ID, 16 ASCII chars (BANDAINTPD_0_0_0)
- *16 bytes:* Product ID, 16 ASCII chars (TAMASUMA_TIM0000)
- *2 bytes:* Card type (TamaSmaCard = 0, PromoTreasure = 1, PromoItem = 2)
- *2 Bytes:* Card ID
- *2 bytes:* <Empty>
- *2 bytes:* Build Year
- *2 bytes:* Build Month
- *2 bytes:* Build Day
- *2 bytes:* Build Revision
- *2 bytes:* <Empty>
- *16 bytes:* Checksum (MD5 hash of header bytes 0-63)
- *Padded with 0s or Fs until 0x1000*

## Package Summary
- *2 bytes:* <Empty>
- *2 bytes:* Package Count
- Per Package (8 bytes each):
	- *4 bytes:* Package Offset, in bytes
	- *4 bytes:* Package Size, in bytes

## Data Package
- *80 bytes:* Table Offsets, 20 tables x 4 bytes each (each offset = number of 16-bit words from start of data package)
- *Table Data Follows*

### Font Offsets (Table 0)
*Not defined on TamaSma cards*

### Fonts (Table 1)
*Not defined on TamaSma cards*

### Particle Emitters (Table 2)
- Per Particle Emitter (66 bytes each):
	- *2 bytes x 33 bytes:* <Unknown>

### Scene Offsets (Table 3)
- *Every 2 bytes:* Scene Offset, measured in 16-bit words from start of Scene Layer table
- *Final 2 bytes:* Length of Scene Layer table, measured in 16-bit words

### Scene Layer Offsets (Table 4)
- Per Scene:
	- *Every 2 bytes:* Layer Offset, measured in 16-bit words from start of Scene Layers table

### Scene Layers (Table)
- Per Layer:
	- *2 bytes* Bitmask
	- (if bit 0 set) *2 bytes:* X Position
	- (if bit 1 set) *2 bytes:* Y Position
	- (if bit 2 set) *2 bytes:* Image ID
	- (if bit 6 set) *2 bytes:* Subimage Index
	- (if bit 10 set) <Unknown>
	- (if bit 12 set) <Unknown>
	- (if bit 14 set) <Unknown>

### Strings (Table 6)
- Per String:
	- *2 bytes:* ID
	- *2 bytes:* <Unknown>
	- *2 bytes:* <Unknown>
	- *2 bytes:* <Unknown>
	- String as series of 2-byte tama-encoded chars, terminating in 0x0000

### String Offsets (Table 7)
- *Every 2 bytes:* Offset, measured in 16-bit words from start of Strings table
- *Final 2 bytes:* 0xFFFF

### ??? Offsets (Table 8)
- *Every 2 bytes:* Offset, measured in 16-bit words from start of ??? table
- *Final 2 bytes:* Length of ??? table, measured in 16-bit words

### ??? (Table 9)
*Seems to always be 10 entities, with only 2nd, 4th, and 9th entities having a nonzero bitmask)
- Per Entity:
	- *2 bytes:* Bitmask
	- (if bit 0 set) *2 bytes:* Some Kind of ID
	- (if bit 1 set) *2 bytes:* Some Kind of ID
	- (if bit 1 set) *2 bytes:* Some Kind of ID

### Items (Table 10)
*First item is always the game, except on 1996 VR Card*
- Per Item (42 bytes each):
	- *2 bytes:* ID
	- *2 bytes:* Type (Meal = 0, Snack = 1, Toy = 2, Head Accessory = 3, Face Accessory = 4, Body Accessory = 5, Hand Accessory = 6, Room = 7, Game = 8, ??? = 9)
	- *20 bytes:* Name, 10 tama-encoded chars
	- *2 bytes:* Image ID
	- *2 bytes:* Worn Image ID (for Accessories)
	- *2 bytes:* Close Image ID (for Accessories)
	- *2 bytes:* <Unknown>
	- *2 bytes:* Price
	- *2 bytes:* <Unknown>
	- *2 bytes:* <Unknown>
	- *2 bytes:* <Unknown>
	- *2 bytes:* Unlocked Character, character index (for Non-Games) or Game Type (GuessingGame = 10, TimingGame = 11, MemoryGame = 12, DodgingGame = 13, ShakingGame = 14, SwipingGame = 15)

### Characters (Table 11)
*First character is always NPC, not sure if it's actually used*
- Per Character (96 bytes each):
	- *2 bytes:* ID
	- *2 bytes:* Type (First Entry = 6, All Others = 5)
	- *20 bytes:* Name, 10 tama-encoded chars (eg. いちごっち█████)
	- *2 bytes:* Profile Image ID
	- *2 bytes:* Icon Image ID
	- *2 bytes:* Composition ID
	- *2 bytes:* <Unknown>
	- *12 bytes:* Pronoun String, 6 tama-encoded chars (eg. わたし███)
	- *12 bytes:* Statement String, 6 tama-encoded chars (eg. んです███)
	- *12 bytes:* Question String 1, 6 tama-encoded chars (eg. んですか██)
	- *12 bytes:* Question String 2, 6 tama-encoded chars (eg. ですか███)
	- *2 bytes:* <Unknown>
	- *2 bytes:* <Unknown>
	- *2 bytes:* Global ID
	- *2 bytes:* Minutes Per Fullness/Happiness Loss
	- *2 bytes:* Minutes Per Happiness/Fullness Loss
	- *2 bytes:* <Unknown>
	- *2 bytes:* <Unknown>
	- *2 bytes:* Gender (Female = 0, Male = 1)

### Padding (Table 12)
*What determines length of this table is unknown*

### Graphics Node Offsets (Table 13)
- *Every 2 bytes:* Offset, measured in 32-bit double-words from start of Graphics Nodes table
- *Final 2 bytes:* Length of Graphics Nodes table, measured in 32-bit double-words

### Graphics Nodes (Table 14)
- Per Graphics Node:
	- *2 bytes:* ID
	- *Remaining bytes:* <Unknown>

### Character Composition Layers (Table 15)
- Per Layer:
	- *2 bytes:* Bitmask
	- (if bit 0 set) *2 bytes:* X Position
	- (if bit 1 set) *2 bytes:* Y Position
	- (if bit 2 set) *2 bytes:* Subimage Index
	- (if bit 4 set) *2 bytes:* <Unknown>
	- (if bit 5 set) *2 bytes:* <Unknown>
	- (if bit 8 set) *2 bytes:* <Unknown>
	- (if bit 9 set) *2 bytes:* Layer Type (Face = 1, NPC = 2, Body = 3, Head Accessory = 4, Face Accessory = 6, Body Accessory = 8, Dirt Clouds = 9, Hand Accessory = 10)
	- (if bit 10 set) *2 bytes:* Image ID

### Character Composition Layer Offsets (Table 16)
- *Every 4 bytes:* Offset, measured in 16-bit words from start of Character Composition Layers table
- *Final 4 bytes:* Length of Character Composition Layers table, measured in 16-bit words

### Padding (Table 17)
*What determines length of this table is unknown*

### Character Composition Groups (Table 18)
*Every character gets 53 composition groups*
- Per Group (4 bytes):
	- *2 bytes:* First Layer Index *or* 0xFFFF (if group is defined implicitly)
	- *2 bytes:* Layer Count

### Card ID (Table 19)
- *2 bytes:* Card ID

## Sprite Package
- *4 bytes:* Images Table Offset
- *4 bytes:* Sprite Definitions Table Offset
- *4 bytes:* Palettes Table Offset
- *4 bytes:* Pixel Data Table Offset

### Images (Table 0)
- Per Image (6 bytes):
	- *2 bytes:* First Sprite Index
	- *1 byte:* Width, in sprites
	- *1 byte:* Height, in sprites
	- *2 bytes:* First Palette Index

### Sprite Definitions (Table 1)
- Per Sprite (8 bytes each):
	- *2 bytes:* Pixel Data Index
	- *2 bytes:* X Offset
	- *2 bytes:* Y Offset
	- *2 bytes:* Properties Bitmask
		- *2 bits:* Bits Per Pixel (2bpp = 0, 4bpp = 1, 6bpp = 2, 8bpp = 3)
		- *2 bits:* Flipped (Unflipped = 0, Flipped Horizontally = 1, Flipped Vertically = 2; unused on Smart)
		- *2 bits:* Width (8px = 0, 16px = 1, 32px = 2, 64px = 3)
		- *2 bits:* Height (8px = 0, 16px = 1, 32px = 2, 64px = 3)
		- *4 bits:* Palette Bank (unsure what this does)
		- *2 bits:* Depth (unused on Smart)
		- *1 bits:* Blend (unused on Smart)
		- *1 bits:* Quadruple (unused on Smart)

### Palettes (Table 2)
*Palettes are groups of four colors for purposes of indexing*
- Per Color (1 byte each):
	- *1 bit:* Transparent (Opaque = 0, Transparent = 1)
	- *5 bits:* Red
	- *5 bits:* Green
	- *5 bits:* Blue

### Pixel Data (Table 3)
- Per Sprite (offset to start of data is defined by pixel data index * width * height * bpp / 8):
	- *Every n bits, where n = bpp as defined by sprite definition:* Color Index (where 0 = first color in first palette, as defined by image; color index can extend into following palettes)
