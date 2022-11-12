# Zineth Fanpatch
![Zineth Fanpatch](https://raw.githubusercontent.com/HUNcamper/Zineth-Fanpatch/main/ScreenSelector.bmp)

This is an attempt to revive Arcane Kids' [Zineth](https://zinethgame-blog.tumblr.com/) game with occasional updates. Yes, THAT Zineth.

## How to install
Head to the [latest release](https://github.com/HUNcamper/Zineth-Fanpatch/releases/latest) and follow the installation instructions.

## How to compile
Prerequisites:
- [Visual Studio 2022 Community](https://visualstudio.microsoft.com/vs/community/) or later (and possibly the .NET toolkit for it)

Compilation under Windows 10:
1. Enable .NET 3.5 in the Control Panel. Follow online guides on how to do this.
2. Open the VS solution. If prompted, do not update the .NET version.
3. Build `Assembly-CSharp`
4. Copy the `Assembly-CSharp/bin/<Build Config>/Assembly-CSharp.dll` file from the project to the game's `zineth_Data/Managed` folder, where `<Build Config>` is either Debug or Release
5. Done!

## Debugging:
Debugging the code is currently not possible.

## Suggestions, contribution
- Suggestions and feedback are welcome as Issues or Discussion posts
- Feel free to contribute using Pull Requests!

## Technologies used

- The game was decompiled using [dnSpy](https://github.com/dnSpy/dnSpy)
- The assets were extracted using [AssetStudio](https://github.com/Perfare/AssetStudio)
- The assets were repacked using [UABE](https://github.com/SeriousCache/UABE)

### Disclaimer: The project is NOT associated in any way with Arcane Kids.
