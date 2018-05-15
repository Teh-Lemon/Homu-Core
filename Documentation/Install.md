# How to Install

## Unity Package Manager (remote)
* Not yet supported by Unity.

## Unity Package Manager (local)
1. Download the repository onto your machine
2. Navigate to your project's Package folder
3. Open the manifest.json file
4. Add the line `"com.wakabagames.homu-core": "file:<YOUR FILE PATH HERE>"`
5. Change the file path so it points to the root of Homu-Core's folder
6. The file path is relative and you can use `..` to go up a folder
7. E.g. `"com.wakabagames.homu-core": "file:../../Homu-Core"`
8. Include the namespace **WakabaGames.Core** to use its functions and classes

## Manual
1. Copy and the Homu-Core folder
2. Paste it anywhere into your project's Assets folder
3. Include the namespace **WakabaGames.Core** to use its functions and classes