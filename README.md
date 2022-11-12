# Zineth Fanpatch
![Zineth Fanpatch](https://raw.githubusercontent.com/HUNcamper/Zineth-Fanpatch/main/ScreenSelector.bmp)

This is an attempt to revive Arcane Kids' [Zineth](https://zinethgame-blog.tumblr.com/) game with occasional updates. Yes, THAT Zineth.

## How to install
Head to the [latest release](https://github.com/HUNcamper/Zineth-Fanpatch/releases/latest) and follow the installation instructions.

## How to compile
Prerequisites:
- [Visual Studio 2022 Community](https://visualstudio.microsoft.com/vs/community/) or later (previous versions will likely work too)
- .NET dev tools for VS 2022 Community
- .NET 3.5 (can be enabled in the Control Panel, please refer to online guides)
- An instance of Zineth v0_24

Compilation under Windows 10:
1. Open the VS solution. If prompted, do not upgrade the .NET version.
2. Navigate to your Zineth installation, and open the `Managed` folder. Copy all DLL files from here. Navigate to this project and paste the files into `Assembly-CSharp/bin/Debug/`
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
