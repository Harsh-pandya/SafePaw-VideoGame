## Safepaws Game Readme

Folder Structure

- [**addons**](./addons/) - Holds External Game Plugins and Addons. Currently only dialogue manage is an external plugin installed
  - [**dialogue_manager**](./addons/dialogue_manager/)
- [**assets**](./assets/) - Holds game assets like background images, game sounds, character sprites
- [**dialogue**](./dialogue/) - In game dialogue are stored in this file as dialogue text.
- [**dialogue_ballon**](./dialogue_ballon/) - This is an custome dialogue ballon create for this game. It contains both the game scene file and dialogue ballon script.
- [**scenes**](./scenes/) - This folder contains all the game scene. A game scene is a collection of game node with associated game script
  - [Chapter2.tscn](./scenes/Chapter2.tscn) - This is chapter 2 scene
  - [JamesCharacter.tscn](./scenes/JamesCharacter.tscn) - Character 2d Node For Mr. James Character. The charater sprites can be updated here to update the Mr. James character across the game.
  - [actionable.tscn](./scenes/actionable.tscn) - Node2d to handle game dialogue
  - [background.tscn](./scenes/background.tscn) - Contributes towards game background UI. Create using parallax effect to showcase the moving cloud
  - [coin_label.tscn](./scenes/coin_label.tscn) - Contains Sprites for coin animation
  - [dog.tscn](./scenes/dog.tscn) - Character2D for dog character
  - [game.tscn](./scenes/game.tscn) - Chapter 1 Game file. Contains all the Game UI and nodes for chapter 1. This is first file to visit when starting to update the code
  - [game_bg_music.tscn](./scenes/game_bg_music.tscn) - Created this node to add background music to the game, created as a seperate scene to add as an autoload
  - [game_video_player.tscn](./scenes/game_video_player.tscn) - Scene that controls chapeter 1 introduction video
  - [main.tscn](./scenes/main.tscn) - Game Menu scene. This is first scene to render.
  - [player.tscn](./scenes/player.tscn) - Character 2D node for player character.
- [**scripts**](./scripts/) - Contains all the related Game script

#### Navigating Godot Game Engine

[Game Engine Navigation Image (click to view)](../../HelperFiles/Game%20Engine%20Navigation.png)

#### Installing Godot

- Step 1: https://godotengine.org/ . Click on this link to download the official package for godot
- Step 2: Clone this repository
- Step 3: Open godot on your machine and click Import project and locate the folder code/simplesafepaw and click open
