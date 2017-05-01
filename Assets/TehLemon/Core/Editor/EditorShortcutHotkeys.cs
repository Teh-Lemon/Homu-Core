// Adds extra hotkeys to the Unity Editor
// F5 to Play and Stop the game
// alt+D to deselect all gameobjects

using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;

namespace TehLemon.Editor
{
    public class EditorShortCutKeys : ScriptableObject
    {
        [MenuItem("Edit/Run _F5")] // shortcut key F5 to Play (and exit playmode also)
        static void PlayGame()
        {
            if (!Application.isPlaying)
            {
                EditorSceneManager.SaveScene(SceneManager.GetActiveScene(), "", false); // optional: save before run
            }
            EditorApplication.ExecuteMenuItem("Edit/Play");
        }

        public static class DeselectAll
        {
            [MenuItem("Edit/Deselect All &d", false, -101)]
            static void Deselect()
            {
                Selection.activeGameObject = null;
            }
        }
    }
}