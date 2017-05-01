// Extended monobehaviour with frequently used functionality - Teh Lemon 2016/09/08
// Includes:
// Cache components
// a Start() method that runs after the GameManager has started

using UnityEngine;
using MovementEffects;
using System.Collections.Generic;

namespace TehLemon
{
    public class CustomBehaviour : MonoBehaviour
    {
        protected bool m_finishedInit;

        /// <summary>
        /// Don't override if you need to wait for the GameManager first
        /// </summary>
        protected virtual void Start()
        {
            Timing.RunCoroutine(_WaitForManager());
        }

        // Waits for the gamemanager 
        IEnumerator<float> _WaitForManager()
        {
            while (GameManager.Instance == null)
            { yield return 0f; }

            PostGMStart();
        }

        /// <summary>
        /// Add Start() content here if you need to wait for the GameManager
        /// MAKE SURE YOU OVERRIDE START() AND CALL BASE.START() OR THIS WON'T BE CALLED
        /// </summary>
        protected virtual void PostGMStart()
        {
            m_finishedInit = true;
        }

        #region cached components
        Rigidbody m_rigidbody;
        public new Rigidbody rigidbody { get { return m_rigidbody ? m_rigidbody : (m_rigidbody = GetComponent<Rigidbody>()); } }

        Transform m_transform;
        public new Transform transform { get { return m_transform ? m_transform : (m_transform = GetComponent<Transform>()); } }

        ParticleSystem m_particleSystem;
        public new ParticleSystem particleSystem { get { return m_particleSystem ? m_particleSystem : (m_particleSystem = GetComponent<ParticleSystem>()); } }

        //Animator m_animator;
        //public Animator animator { get { return m_animator ? m_animator : (m_animator = GetComponent<Animator>()); } }
        #endregion

        [HideInInspector]
        public string DebugText = "";

    }
}