# DwarfGame
Dwarf game

There is lots to do! We're porting it to HaxeFlixel.

## Development Requirements

[Download Visual Studio Code](https://code.visualstudio.com)
[Download Haxe](https://haxe.org/download/)
[Setup HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)

```
haxelib install lime
haxelib install openfl
haxelib install flixel

haxelib run lime setup flixel

haxelib run lime setup

haxelib install flixel-tools
haxelib run flixel-tools setup

```

To update flixel:

```
haxelib update flixel
```

## Set up Visual Studio Code

[Read the instructions here](https://haxeflixel.com/documentation/visual-studio-code/)

## Setting up as3hx for "automatic" porting

[Clone as3hx](https://github.com/HaxeFoundation/as3hx.git)

go into that dir and run this

```
haxe --no-traces as3hx.hxml
haxe -debug as3hx.hxml
```

[Download NekoVM](https://nekovm.org/download/)

Put it into your windows path. I made `c:\bin` into part of the path so I just put things there.
