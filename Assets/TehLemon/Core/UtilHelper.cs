// Static class of math helper functions

using UnityEngine;
using UnityEngine.Assertions;

namespace TehLemon.Utilities
{
    public static class MathUtil
    {
        /// <summary>
        /// Maps a value from some arbitrary range to the 0 to 1 range
        /// </summary>
        /// <param name="value">Value.</param>
        /// <param name="min">Lminimum value.</param>
        /// <param name="max">maximum value</param>
        public static float Map01(float value, float min, float max)
        {
            return (value - min) * 1f / (max - min);
        }


        /// <summary>
        /// Maps a value from some arbitrary range to the 1 to 0 range. this is just the reverse of map01
        /// </summary>
        /// <param name="value">Value.</param>
        /// <param name="min">Lminimum value.</param>
        /// <param name="max">maximum value</param>
        public static float Map10(float value, float min, float max)
        {
            return 1f - Map01(value, min, max);
        }


        /// <summary>
        /// mapps value (which is in the range leftMin - leftMax) to a value in the range rightMin - rightMax
        /// </summary>
        /// <param name="value">Value.</param>
        /// <param name="leftMin">Left minimum.</param>
        /// <param name="leftMax">Left max.</param>
        /// <param name="rightMin">Right minimum.</param>
        /// <param name="rightMax">Right max.</param>
        public static float Map(float value, float leftMin, float leftMax, float rightMin, float rightMax)
        {
            return rightMin + (value - leftMin) * (rightMax - rightMin) / (leftMax - leftMin);
        }


        /// <summary>
        /// rounds value to the nearest number in steps of roundToNearest. Ex: found 127 to nearest 5 results in 125
        /// </summary>
        /// <returns>The to nearest.</returns>
        /// <param name="value">Value.</param>
        /// <param name="roundToNearest">Round to nearest.</param>
        public static float RoundToNearest(float value, float roundToNearest)
        {
            return Mathf.Round(value / roundToNearest) * roundToNearest;
        }


        /// <summary>
        /// Rotate a vector to face the direction given. Only works on flat planes. I.e. Y = 0
        /// </summary>
        /// <param name="vector">Your vector</param>
        /// <param name="direction">The direction. Y MUST BE 0</param>
        /// <returns></returns>
        public static Vector3 OrientateVec(Vector3 vector, Vector3 direction)
        {
            direction = new Vector3(direction.x, 0, direction.z).normalized;

            return (direction * vector.z)
                + (Vector3.Cross(Vector3.up, direction) * vector.x)
                + (Vector3.up * vector.y);
        }
		
		// Frame rate independant lerping: http://www.rorydriscoll.com/2016/03/07/frame-rate-independent-damping-using-lerp/
        /// <summary>
        /// Rotate a vector to face the direction given. Only works on flat planes.
        /// </summary>
        /// <param name="vector">Your vector</param>
        /// <param name="direction">The direction. X = X, Y = Z, up is 0</param>
        /// <returns></returns>
        public static Vector3 OrientateVec(Vector2 vector, Vector3 direction)
        {
            direction = new Vector3(direction.x, 0, direction.z).normalized;

            return (direction * vector.y)
                + (Vector3.Cross(Vector3.up, direction) * vector.x);
        }
        /// <summary>
        /// Frame rate independant damping using lerp
        /// </summary>
        /// <param name="speed">Range: 0 to infinity. The lower the slower/more damping.</param>
        /// <returns></returns>
        public static float Damp(float source, float target, float speed)
        {
            return Mathf.Lerp(source, target, 1 - Mathf.Exp(-speed * Time.deltaTime));
        }
        /// <summary>
        /// Frame rate independant damping using lerp
        /// </summary>
        /// <param name="speed">Range: 0 to infinity. The lower the slower/more damping.</param>
        /// <returns></returns>
        public static Vector3 Damp(Vector3 source, Vector3 target, float speed)
        {
            return Vector3.Lerp(source, target, 1 - Mathf.Exp(-speed * Time.deltaTime));
        }
        /// <summary>
        /// Frame rate independant damping using slerp
        /// </summary>
        /// <param name="speed">Range: 0 to infinity. The lower the slower/more damping.</param>
        /// <returns></returns>
        public static Quaternion DampS(Quaternion source, Quaternion target, float speed)
        {
            return Quaternion.Slerp(source, target, 1 - Mathf.Exp(-speed * Time.deltaTime));
        }

        /// <summary>
        /// Frame rate independant damping using slerp
        /// </summary>
        /// <param name="speed">Range: 0 to infinity. The lower the slower/more damping.</param>
        /// <param name="dt">delta time between frames</param>
        /// <returns></returns>
        public static Quaternion DampS( Quaternion source, Quaternion target, float speed, float dt )
        {
            return Quaternion.Slerp(source, target, 1 - Mathf.Exp(-speed * dt));
        }

        /// <summary>
        /// Adjusts a linear intepolation to match an ease in and ease out curve. Wikipedia smoothstep for image.
        /// </summary>
        /// <param name="percentage">Between 0.0 and 1.0</param>
        public static float SmoothStep(float percentage)
        {
            return percentage * percentage * (3f - 2f * percentage);
        }

        /// <summary>
        /// Adjusts a linear intepolation to match an ease in and ease out curve. Wikipedia smoothstep for image.
        /// </summary>
        /// <param name="percentage">Between 0.0 and 1.0</param>
        public static float SmootherStep(float percentage)
        {
            return percentage * percentage * percentage * (percentage * (6f * percentage - 15f) + 10f);
        }

        /// <summary>
        /// Convert any square mappings (eg xbone gamepad) to a circle map 
        /// https://mathproofs.blogspot.com/2005/07/mapping-square-to-circle.html
        /// </summary>
        public static Vector2 ConvertSquareMapToCircle(float x, float y)
        {
            if (x > 1 || y > 1)
            {
                Debug.LogErrorFormat("ConvertSquareMapToCircle: Value larger than 1 passed in. x {0} y {1}", x, y);
                return Vector2.zero;
            }

            float newX = x * Mathf.Sqrt(1f - (0.5f * y * y));
            float newY = y * Mathf.Sqrt(1f - (0.5f * x * x));

            return new Vector2(newX, newY);
        }

        /// <summary>
        /// Convert any square mappings (eg xbone gamepad) to a circle map 
        /// https://mathproofs.blogspot.com/2005/07/mapping-square-to-circle.html
        /// </summary>
        public static Vector2 ConvertSquareMapToCircle(Vector2 axis)
        {
            return ConvertSquareMapToCircle(axis.x, axis.y);
        }
    }

    public static class GraphicUtil
    {

    }
}
