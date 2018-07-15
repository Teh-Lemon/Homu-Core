# Homu-Core

## A collection of static Unity utilities

Any extra instructions will listed in the comments at the top of the file or functions.  
Requires setting Unity to use .net 4.6/C# 6.0.  
These are only tested against whichever Unity version I happen to be using (usually the latest).

I make no promises over the quality or up-to-date-ness of the code.  

### [How to Install](Documentation/Install.md)

## Contents

#### DestroyOnPlay.cs

Destroys the object in Awake().

### Extensions

#### Colors (Colors.cs)

Extends the Unity Color class to add extra color presets.

#### Vector3 (VectorHelper.cs)

Adds a shortcut method to Vector3s which allows you to change it by only specifying 1 or more components.  
Example:  

```csharp

    Vector3 position = new Vector3(5,5,5);  
    position = position.With(y: 10);  
    // position is now 5, 10, 5  

```

### Shaders

#### Nothing

The Standard shader at 0% opacity still has draw calls even though you can't see it.  
This surface shader however literally renders nothing and does as few calculations as possible.  
Useful for hiding parts of a mesh via materials.  
Found in the **WakabaGames/Core** shader menu.

### Static Utilities

#### Math functions (MathHelper.cs)

A collection of static math helper functions. Check the comments for more details on each function.  

## Homu Suite

Also consider checking out the other packages in the [Homu Suite](https://github.com/search?q=Teh-Lemon%2FHomu) for Unity.