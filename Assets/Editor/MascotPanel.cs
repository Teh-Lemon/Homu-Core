// Creates a panel in the Unity Editor that displays an image
// Image needs to be called "mascot" and placed in "Assets/Resources/EditorResources"

using UnityEngine;
using UnityEditor;

namespace TehLemon.Editor
{
    public class MascotPanel : EditorWindow
    {
        Texture2D m_texture = null;

        [MenuItem ( "Window/Mascot ")]
        static void Open()
        {
            EditorWindow.GetWindow<MascotPanel>("Mascot");
        }

        void OnGUI()
        {
            if (m_texture == null)
            {
                m_texture = Resources.Load("EditorResources/mascot") as Texture2D;
                return;
            }

            // Size of the image to be displayed
            var textureWidth = (float)m_texture.width;
            var textureHeight = (float)m_texture.height;

            if (position.width < textureWidth 
                || position.height < textureHeight)
            {
                // If the image is larger than our window size 
                var shrinkWidth = Mathf.Min(position.width / textureWidth, position.height / textureHeight);

                // Re-size the image
                textureWidth *= shrinkWidth;
                textureHeight *= shrinkWidth;
            }

            // Centre of the window
            var posX = (position.width - textureWidth) / 2;
            var posY = (position.height - textureHeight) / 2;

            // Draw the image
            EditorGUI.DrawPreviewTexture(new Rect(posX, posY, textureWidth, textureHeight), m_texture);
        }
    }
}
