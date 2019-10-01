using System.Collections;
using System.Collections.Generic;


using UnityEngine;

/// <summary>
/// Component allowing to make the line renderer follow a Bezier curves
/// </summary>
[ExecuteInEditMode, RequireComponent(typeof(LineRenderer))]
public class SplineRenderer : MonoBehaviour
{
	#region Public Member
	/// <summary>
	/// The reference Bezier curve to follow
	/// </summary>
	public BezierCurve BezierCurve;
	/// <summary>
	/// Amount of segments on the line
	/// </summary>
	public int Resolution = 50;
	/// <summary>
	/// Curve used for the width of the line
	/// </summary>
	public AnimationCurve WidthCurve = AnimationCurve.Linear(0, 1, 1, 1);
	/// <summary>
	/// Curve used for the width of the line
	/// </summary>
	public float WidthFactor = 1.0f;
	/// <summary>
	/// Color of the line
	/// </summary>
	public Gradient ColorGradient;
	/// <summary>
	/// Local transformation to  be successively applied
	/// </summary>
	public SplineTransformation[] Transformations = new SplineTransformation[0];
	#endregion

	#region Private Member
	/// <summary>
	/// Reference to the line renderer
	/// </summary>
	private LineRenderer lineRendererComponent;
	/// <summary>
	/// Length of the current line renderer
	/// </summary>
	private float length;
	/// <summary>
	/// Material of the line
	/// </summary>
	private Material material;

	private int frameCount;
	#endregion  

	#region Properties
	public float Length
	{
		get
		{
			return length;
		}
	}
	#endregion

	#region MonoBehaviour Functions
	private void OnEnable()
	{
		lineRendererComponent = GetComponent<LineRenderer>();
		lineRendererComponent.useWorldSpace = true;
		material = lineRendererComponent.sharedMaterial;
	}

	void Update()
	{
		frameCount++;
		Resolution = Mathf.Max(Resolution, 1);
		lineRendererComponent.widthCurve = WidthCurve;
		lineRendererComponent.widthMultiplier = WidthFactor;
		lineRendererComponent.colorGradient = ColorGradient;

		if ((BezierCurve.HasChanged || lineRendererComponent.positionCount != Resolution + 1) && frameCount % 10 == 0)
			UpdateLine();
	}
	#endregion

	#region Custom Function
	/// <summary>
	/// Updates the line renderer and make it follow the Bezier curve
	/// </summary>
	public void UpdateLine()
	{
		if (BezierCurve != null)
		{
			length = 0.0f;
			//Add the last point
			lineRendererComponent.positionCount = Resolution + 1;

			// interates through all the points
			for (int i = 0; i < lineRendererComponent.positionCount; i++)
			{
				// computes the current point's ratio
				float ratio = (float) i / (float) Resolution;
				//gets the matrix on the spline at ratio
				Matrix4x4 localTransformationMatrix = BezierCurve.GetMatrix(ratio);
				//iterates through all the transformation
				for (int j = Transformations.Length - 1; j >= 0; j--)
				{
					SplineTransformation currentTransformation = Transformations[j];
					localTransformationMatrix *= currentTransformation.GetMatrix(ratio);
				}

				//transform the origin point with the martiw and assign it to the line renderer
				lineRendererComponent.SetPosition(i, localTransformationMatrix.MultiplyPoint(Vector3.zero));

				if (i > 0)
				{
					length += Vector3.Distance(lineRendererComponent.GetPosition(i), lineRendererComponent.GetPosition(i - 1));
				}
			}
			material.SetFloat("_Lenght", length);
		}
	}

	#endregion
}