using System.Collections;
using System.Collections.Generic;

using UnityEngine;

/// <summary>
/// Contains transformation local to a Spline
/// </summary>
[System.Serializable]
public struct SplineTransformation
{
	#region Public Region
	/// <summary>
	/// The wanted type of transformation
	/// </summary>
	public SplineTransformationType Type;
	/// <summary>
	/// The intensity of the transformation
	/// </summary>
	public float Intensity;
	/// <summary>
	/// The curve used to modulate the intensity
	/// </summary>
	public AnimationCurve curve;
	#endregion

	#region Functions
	/// <summary>
	/// Compute the local transformation matrix corresponding to the parameters
	/// </summary>
	/// <param name="ratio">The reference "percentage" to query on the curve</param>
	/// <returns> The local transformation matrix </returns>
	public Matrix4x4 GetMatrix(float ratio)
	{
		float modulatedIntensity = curve.Evaluate(ratio) * Intensity;
		switch (Type) //Builds and returns a matrix according to the "type" of transformation
		{
			case SplineTransformationType.Translation:
				{
					return Matrix4x4.TRS(Vector3.right * modulatedIntensity, Quaternion.identity, Vector3.one);
				}
			case SplineTransformationType.Rotation:
				{
					return Matrix4x4.TRS(Vector3.zero, Quaternion.Euler(0.0f, 0.0f, modulatedIntensity % 360.0f), Vector3.one);
				}
			default:
				{
					return Matrix4x4.identity;
				}
		}

	}
	#endregion
}