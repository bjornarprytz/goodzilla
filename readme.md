# goodzilla

game on itch.io: [link](https://thewarlock.itch.io/goodzilla)

Based on two themes:

1. You are the monster
2. Keep them alive

Stipulation: 3 color palette

- Current Palette
- Gray:     9c9c9c
- Rust:     b84000
- Emerald:  40c080

## TODO

- GameObjects
  - Character
    - Keep tweaking movement
  - Building (Skyscraper)
    - When alert reaches 100% -> **Game over**
    - Tweak alertness buildup
  - Background
- GameLoop
  - Game Win (all eggs?)
  - Game Loss (alert building)
- UI
  - Jumping
    - Arrow for direction and strength meter
  - Apply palette
- Sound
  - Music
  - Effects
    - pickup egg
- Attribution
  - Character sprites: <https://omniclause.itch.io/lizard-character-sprites>

- Push release with `./push_release.sh`

## Nice to have

- Parallax background
- Time limit: Dawn approaches
  - Base alert increases over time
- Ground
  - Sewer (For escaping with the eggs)
- Cool Lighting (would it break the palette stipulation?)

### Extra

- itch.io
  - Rename the game
  - Write a short description
  - Make a nice cover image (630x500)
  - Add screenshots (recommended: 3-5)
  - Pick a genre
  - Add a tag or two
  - Publish a devlog on instagram

### Meta

- Figure out how to use these Godot tools
  - Theme
  - UI
- Tackle multiplayer in HTML5
  - https://www.reddit.com/r/godot/comments/bux2hs/how_to_use_godots_high_level_multiplayer_api_with/
