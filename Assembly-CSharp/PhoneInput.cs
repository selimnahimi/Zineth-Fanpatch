using System;
using UnityEngine;

// Token: 0x0200004B RID: 75
public static class PhoneInput
{
	// Token: 0x060002C2 RID: 706 RVA: 0x00012474 File Offset: 0x00010674
	public static Vector2 GetControlDir()
	{
		return Vector2.ClampMagnitude(PhoneInput.GetRStickVec(), 1f);
	}

	// Token: 0x060002C3 RID: 707 RVA: 0x00012488 File Offset: 0x00010688
	public static Vector2 GetArrowsVec()
	{
		return Vector2.zero;
	}

	// Token: 0x060002C4 RID: 708 RVA: 0x0001249C File Offset: 0x0001069C
	public static Vector2 GetControlDirPressed()
	{
		if (Time.frameCount == PhoneInput.last_dirpress_frame)
		{
			return PhoneInput.last_dirpress;
		}
		PhoneInput.last_dirpress_frame = Time.frameCount;
		Vector2 controlDir = PhoneInput.GetControlDir();
		PhoneInput.last_dirpress = Vector2.zero;
		if (controlDir.magnitude < 0.6f)
		{
			PhoneInput.dirpressready = true;
		}
		else if (PhoneInput.dirpressready)
		{
			PhoneInput.last_dirpress = controlDir;
			PhoneInput.dirpressready = false;
		}
		return PhoneInput.last_dirpress;
	}

	// Token: 0x060002C5 RID: 709 RVA: 0x00012510 File Offset: 0x00010710
	public static void DetectControlType()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			PhoneInput.controltype = PhoneInput.ControlType.Mouse;
		}
		if (PhoneInput.GetControlDir().magnitude != 0f || Input.GetButtonDown("CellFire"))
		{
			PhoneInput.controltype = PhoneInput.ControlType.Keyboard;
			PhoneInput.GetControlDirPressed();
		}
		Vector2 vector = Input.mousePosition;
		if (PhoneInput.controltype != PhoneInput.ControlType.Mouse && PhoneInput._oldmousepos != vector)
		{
			Vector3 touchPoint = PhoneInput.GetTouchPoint();
			if (touchPoint != PhoneInput._oldtouchpos)
			{
				PhoneInput.controltype = PhoneInput.ControlType.Mouse;
			}
			PhoneInput._oldtouchpos = touchPoint;
		}
		PhoneInput._oldmousepos = vector;
	}

	// Token: 0x060002C6 RID: 710 RVA: 0x000125B0 File Offset: 0x000107B0
	public static bool IsPressedDown()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return true;
		}
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
		{
			return !(PhoneInput.GetTouchPoint() == Vector3.one * -1f) && Input.GetButtonDown("CellClick");
		}
		return PhoneInput.controltype == PhoneInput.ControlType.Keyboard && PhoneInput.GetRStickButtonDown();
	}

	// Token: 0x060002C7 RID: 711 RVA: 0x00012614 File Offset: 0x00010814
	public static bool IsPressed()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return true;
		}
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
		{
			return !(PhoneInput.GetTouchPoint() == Vector3.one * -1f) && Input.GetButton("CellClick");
		}
		return PhoneInput.controltype == PhoneInput.ControlType.Keyboard && PhoneInput.GetRStickButton();
	}

	// Token: 0x060002C8 RID: 712 RVA: 0x00012678 File Offset: 0x00010878
	public static Vector3 GetTouchPoint()
	{
		if (Time.time == PhoneInput.last_update_time)
		{
			return PhoneInput.last_touchpoint;
		}
		PhoneInput.last_update_time = Time.time;
		Vector3 result = PhoneInput._GetTouchPoint();
		PhoneInput.last_touchpoint = result;
		return result;
	}

	// Token: 0x060002C9 RID: 713 RVA: 0x000126B4 File Offset: 0x000108B4
	private static Vector3 _GetTouchPoint()
	{
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse || true)
		{
			Vector3 mousePosition = Input.mousePosition;
			if (PhoneInput.phonescreencamera == null)
			{
				return new Vector3(Input.mousePosition.x / (float)Screen.width, Input.mousePosition.y / (float)Screen.height);
			}
			Ray ray = PhoneInput.phonescreencamera.ScreenPointToRay(mousePosition);
			int layerMask = 1 << LayerMask.NameToLayer("PhoneView");
			RaycastHit raycastHit;
			if (Physics.Raycast(ray, out raycastHit, 20f, layerMask) && raycastHit.collider == PhoneInput.phonescreencollider)
			{
				Vector2 textureCoord = raycastHit.textureCoord;
				return new Vector3(textureCoord.x, textureCoord.y, 0f);
			}
			return Vector3.one * -1f;
		}
		else
		{
			if (PhoneInput.controltype == PhoneInput.ControlType.TouchScreen)
			{
				return Vector3.one * -1f;
			}
			Debug.LogWarning("Your touch mode is not correct ~_^");
			return Vector3.one * -1f;
		}
	}

	// Token: 0x060002CA RID: 714 RVA: 0x000127CC File Offset: 0x000109CC
	public static Vector3 TransformPoint(Vector3 point)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return point;
		}
		Vector3 vector = new Vector3(point.x, 0f, point.y);
		vector -= new Vector3(1f, 0f, 1f) * 0.5f;
		vector *= PhoneInput.phonescenecamera.orthographicSize * 2f;
		vector.x *= PhoneInput.phonescreencollider.bounds.size.x / PhoneInput.phonescreencollider.bounds.size.y;
		vector += PhoneInput.phonecontroller.transform.position;
		return vector;
	}

	// Token: 0x060002CB RID: 715 RVA: 0x00012898 File Offset: 0x00010A98
	public static Vector3 GetTransformedTouchPoint()
	{
		return PhoneInput.TransformPoint(PhoneInput.GetTouchPoint());
	}

	// Token: 0x060002CC RID: 716 RVA: 0x000128A4 File Offset: 0x00010AA4
	public static bool GetTouchRay(out Ray ray)
	{
		Vector3 touchPoint = PhoneInput.GetTouchPoint();
		if (touchPoint == Vector3.one * -1f)
		{
			ray = default(Ray);
			return false;
		}
		ray = PhoneInput.phonescenecamera.ScreenPointToRay(touchPoint);
		return true;
	}

	// Token: 0x060002CD RID: 717 RVA: 0x000128EC File Offset: 0x00010AEC
	private static Vector2 GetRStickVec()
	{
		Vector2 result = new Vector2(Input.GetAxis("RHorizontal"), Input.GetAxis("RVertical"));
		if (PhoneInput.invert_stick)
		{
			result.y = -result.y;
		}
		return result;
	}

	// Token: 0x060002CE RID: 718 RVA: 0x00012930 File Offset: 0x00010B30
	private static bool GetRStickButton()
	{
		return Input.GetButton("CellFire");
	}

	// Token: 0x060002CF RID: 719 RVA: 0x0001293C File Offset: 0x00010B3C
	private static bool GetRStickButtonDown()
	{
		return Input.GetButtonDown("CellFire");
	}

	// Token: 0x04000295 RID: 661
	public static PhoneController phonecontroller;

	// Token: 0x04000296 RID: 662
	public static Collider phonescreencollider;

	// Token: 0x04000297 RID: 663
	public static Camera phonescreencamera;

	// Token: 0x04000298 RID: 664
	public static Camera phonescenecamera;

	// Token: 0x04000299 RID: 665
	public static PhoneInput.ControlType controltype = PhoneInput.ControlType.Keyboard;

	// Token: 0x0400029A RID: 666
	private static Vector3 last_touchpoint = Vector3.one * -1f;

	// Token: 0x0400029B RID: 667
	private static float last_update_time = -1f;

	// Token: 0x0400029C RID: 668
	private static bool dirpressready = true;

	// Token: 0x0400029D RID: 669
	private static int last_dirpress_frame = -1;

	// Token: 0x0400029E RID: 670
	private static Vector2 last_dirpress;

	// Token: 0x0400029F RID: 671
	private static Vector2 _oldmousepos = Vector2.one * -1f;

	// Token: 0x040002A0 RID: 672
	private static Vector3 _oldtouchpos = Vector3.one * -1f;

	// Token: 0x040002A1 RID: 673
	public static bool invert_stick = false;

	// Token: 0x0200004C RID: 76
	public enum ControlType
	{
		// Token: 0x040002A3 RID: 675
		Mouse,
		// Token: 0x040002A4 RID: 676
		TouchScreen,
		// Token: 0x040002A5 RID: 677
		Keyboard
	}
}
