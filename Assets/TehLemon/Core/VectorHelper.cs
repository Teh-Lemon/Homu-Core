using UnityEngine;

public static class VectorHelper
{
    public static Vector3 With(this Vector3 self, float? x = null, float? y = null, float? z = null)
    {
        return new Vector3(x ?? self.x, y ?? self.y, z ?? self.z);
    }
}

class Test
{
    Vector3 position;

    Test()
    {
        position = position.With(y: 10f);
    }
}