// A tool that converts colours between gamma and linear space
// Access in the Unity Editor top menu - Tools
// Written by Teh Lemon 2016/08/19

using UnityEngine;
using UnityEditor;

namespace TehLemon.Editor
{
    public class ConvertColorToLinearEditor : EditorWindow
    {
        Color m_gamma = Color.white;
        Color m_linear = Color.white;

        Color m_gammaOld = Color.white;

        [MenuItem("Tools/Convert Colour Space")]
        public static void ShowWindow()
        {
            EditorWindow thisWindow = EditorWindow.GetWindow(typeof(ConvertColorToLinearEditor));
            thisWindow.titleContent.text = "Color Converter";
        }

        void OnGUI()
        {
            GUILayout.Label("Gamma", EditorStyles.boldLabel);
            m_gamma = EditorGUILayout.ColorField(m_gamma);

            GUILayout.Space(5);

            GUILayout.Label("Linear", EditorStyles.boldLabel);
            m_linear = EditorGUILayout.ColorField(m_linear);

            if (GUI.changed)
            {
                if (m_gamma != m_gammaOld)
                {
                    m_linear = m_gamma.linear;
                }
                else
                {
                    m_gamma = m_linear.gamma;
                }

                m_gammaOld = m_gamma;
            }
        }
    }
}
