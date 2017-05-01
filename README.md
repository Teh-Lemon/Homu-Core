# Melon Core
## Collection of Unity utilities

This is the folder I always copy into any new Unity project. I use these with Unity 5.6.  

Any scripts found in the Editor folder must also be in an Editor folder in your project.  
Any extra instructions will listed in the comments at the top of the file or functions.  
Some of these may require the TehLemon namespaces.  

I make no promises over the quality or up-to-date-ness of the code.

## Contents

### Editor Tools

#### Color Space Converter (ConvertRGBToLinearEditor.cs)
Converts colors between the gamma and linear color space.  
Access from the **Tools** menu.  
![Color Converter Screenshot](Images/ColorConverter.png)

#### Extra Hotkeys (EditorShortcutHotkeys.cs)
Hit **alt+D** in the Editor to deselect any gameobjects in the scene.  
Hit **F5** to Play and Stop the game.

#### Mascot Panel (MascotPanel.cs)
A panel for the Editor that displays an image.  
Access from the **Windows** menu.  
Name your image "mascot" and place it in the folder "**Assets/Resources/EditorResources**".  
![Mascot Screenshot](Images/Mascot.png)

#### Revert to Prefab (RevertAllPrefabs.cs)
Reverts selected gameobjects in the Editor back to their prefab state.
Found in the **Tools** menu.

### Extensions

#### Colors (Colors.cs)
Extends the Unity Color class to add extra color presets.

#### Custom Behaviour (CustomBehaviour.cs)
Extends the Monobehaviour class to add additional functionality that I find myself needing often.  
I don't recommend you use this directly as it has some dependencies and I tend to completely rewrite it often but it might be useful as reference.  
Features:  
* Defer the Start function till after my GameManager has intiialized.  
Needed as the script order is not guarunteed when the game is played from the Editor.  
* Cache regularly accessed components. Only caches the first time its called. 

### Shaders

#### Nothing
The Standard shader at 0% opacity still has draw calls even though you can't see it.  
This surface shader however literally renders nothing and does as few calculations as possible.  
Useful for hiding parts of a mesh via materials.  
Found in the **TehLemon/Nothing shader menu**.

#### StandardPacked
A surface shader that aims to replicate the functionality of the Standard shader and can be found in the **TehLemon/StandardPacked** shader menu.  
Unity's Standard shader packs both the metallic and smoothness maps into 1 file.  
This shader packs 4 textures into 1 file to save texture samples and memory.

Red: Metallic  
Green: Ambient Occlusion  
Blue: Emission Mask  
Alpha: Smoothness  

StandardPackedExtra also includes the secondary detail maps and the height map.

I'd like to further improve the inspector GUI of the shader to include some of the conveniences of the Standard shader but this has no impact on its current functionality.

### Static Utilities

#### Math functions (UtilHelper.cs)
A collection of static math helper functions. Check the comments for more details on each function.

### Recommended Third Party Utilities
I also include these third party scripts into every new project:
* https://github.com/madsbangh/EasyButtons  
Very quickly add buttons for any function of a script into the inspector window.  
Great for debugging without the need to make an editor script for each script.
* https://github.com/thefuntastic/Unity3d-Finite-State-Machine  
Finite State Machine. Simple and flexible.
* https://www.assetstore.unity3d.com/en/#!/content/24227  
I use this for my game manager.



