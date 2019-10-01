using System.Collections;
using System.Collections.Generic;

using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
#endif

/// <summary>
/// Component that computes a Bezier curve
/// </summary>
public class BezierCurve : MonoBehaviour
{
	#region PublicMembers
	/// <summary>
	/// Transform used to get the starting position
	/// </summary>
	public Transform StartingPointTransform;
	/// <summary>
	/// Transform used to get the starting tangent position
	/// </summary>
	public Transform StartingTangentTransform;
	/// <summary>
	/// Transform used to get the ending tangent position
	/// </summary>
	public Transform EndingTangentTransform;
	/// <summary>
	/// Transform used to get the ending position
	/// </summary>
	public Transform EndingPointTransform;
	#endregion

	#region Properties
	/// <summary>
	/// Tells if all the required reference are set
	/// </summary>
	public bool AreReferncesTransformFilled
	{
		get
		{
			return StartingPointTransform != null &&
				StartingTangentTransform != null &&
				EndingTangentTransform != null &&
				EndingPointTransform != null;
		}
	}
	/// <summary>
	/// Tells if the curve has changed
	/// </summary>
	public bool HasChanged
	{
		get
		{
			return StartingPointTransform.hasChanged ||
				StartingTangentTransform.hasChanged ||
				EndingTangentTransform.hasChanged ||
				EndingPointTransform.hasChanged;
		}
	}
	#endregion

	#region MonoBehaviourFunction
	void OnDrawGizmosSelected()
	{
		if (AreReferncesTransformFilled)
		{
#if UNITY_EDITOR
			Handles.DrawBezier(StartingPointTransform.position, EndingPointTransform.position, StartingTangentTransform.position, EndingTangentTransform.position, Color.green, null, 2f);

			float ratio = Mathf.Sin(Time.realtimeSinceStartup) * 0.5f + 0.5f;

			Vector3 positionOneCurve = GetPosition(ratio);
			//Gizmos.DrawSphere(positionOneCurve, .5f);
			Vector3 velocityOnCurve = GetVelocity(ratio);
			Gizmos.color = Color.magenta;
			Gizmos.DrawLine(positionOneCurve, positionOneCurve + velocityOnCurve.normalized);

			//Handles.CubeHandleCap(0, positionOneCurve, GetRotation(ratio), 3, EventType.Repaint);

#endif
		}
	}
	#endregion

	#region Custom Function
	/// <summary>
	/// Compute the position on the bezier curve at ratio
	/// </summary>
	/// <param name="ratio">The reference "percentage" to query on the curve</param>
	/// <returns>The position at ratio</returns>
	public Vector3 GetPosition(float ratio)
	{
		if (!AreReferncesTransformFilled)
		{
			return Vector3.zero;
		}

		Vector3 lerpBetweenStartingPoints = Vector3.Lerp(StartingPointTransform.position, StartingTangentTransform.position, ratio);
		Vector3 lerpBetweenEndingPoints = Vector3.Lerp(EndingTangentTransform.position, EndingPointTransform.position, ratio);
		Vector3 lerpBetweenTangents = Vector3.Lerp(StartingTangentTransform.position, EndingTangentTransform.position, ratio);

		Vector3 entryCurve = Vector3.Lerp(lerpBetweenStartingPoints, lerpBetweenTangents, ratio);
		Vector3 exitCurve = Vector3.Lerp(lerpBetweenTangents, lerpBetweenEndingPoints, ratio);

		Vector3 interpoledCurves = Vector3.Lerp(entryCurve, exitCurve, ratio);

		return interpoledCurves;

		//lerp(a,b,r) = a + r * (b - a)
	}

	/// <summary>
	/// Compute the velocity (direction *speed) on the curve at ratio
	/// </summary>
	/// <param name="ratio">The reference "percentage" to query on the curve</param>
	/// <returns>The velocity (direction *speed) of the curve at ratio</returns>
	public Vector3 GetVelocity(float ratio)
	{
		if (!AreReferncesTransformFilled)
		{
			return Vector3.zero;
		}

		//velocity = derivatives of position = derivatives of GetPosition(ratio)

		float inverseRatio = 1.0f - ratio;
		Vector3 startingPosition = StartingPointTransform.position;
		Vector3 startingTangent = StartingTangentTransform.position;
		Vector3 endingPosition = EndingPointTransform.position;
		Vector3 endingTangent = EndingTangentTransform.position;
		Vector3 velocity = 3.0f * inverseRatio * inverseRatio * (startingTangent - startingPosition) +
			6.0f * inverseRatio * ratio * (startingTangent - startingTangent) +
			3.0f * ratio * ratio * (endingPosition - endingTangent);

		return velocity;
	}

	/// <summary>
	/// Compute the rotation of the curve at ratio
	/// </summary>
	/// <param name="ratio">The reference "percentage" to query on the curve</param>
	/// <returns>The rotation of the curve at ratio</returns>
	public Quaternion GetRotation(float ratio)
	{
		return Quaternion.LookRotation(GetVelocity(ratio).normalized);
	}

	/// <summary>
	/// Compute the matrix on the curve at raio
	/// </summary>
	/// <param name="ratio">The reference "percentage" to query on the curve</param>
	/// <returns>The matrix at ratio </returns>
	public Matrix4x4 GetMatrix(float ratio)
	{
		Vector3 position = GetPosition(ratio);
		Quaternion rotation = GetRotation(ratio);

		return Matrix4x4.TRS(position, rotation, Vector3.one);
	}
	#endregion
}