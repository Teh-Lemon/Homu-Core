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

## Manual
1. Copy the Homu-Core folder
2. Paste it anywhere into your project's Assets folder

# How to Use

1. If you are using Assembly Definition files  
a. Include the `Homu-Core.asmdef` file in your dependencies 
2. Include the namespace **WakabaGames.Core** in your code to use its functions and classes  
b. E.g.  
```csharp
using UnityEngine;
using WakabaGames.Core;

class Test
{
    Vector3 position;

    Test()
    {
        position = position.With(y: 10f);
    }
}
```