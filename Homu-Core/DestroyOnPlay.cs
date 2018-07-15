// Created by Teh Lemon on 2018/07/15
using UnityEngine;

namespace WakabaGames.Core
{
    public class DestroyOnPlay : MonoBehaviour
    {
        void Awake()
        {
            Destroy(gameObject);
        }
    }
}