using System;
using UnityEngine;

// Token: 0x0200003A RID: 58
public class Phone_MathNumber : PhoneMainMenu
{
	// Token: 0x06000211 RID: 529 RVA: 0x0000DEF0 File Offset: 0x0000C0F0
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x06000212 RID: 530 RVA: 0x0000DF04 File Offset: 0x0000C104
	public override void OnLoad()
	{
		base.OnLoad();
		this.SetupGame();
	}

	// Token: 0x06000213 RID: 531 RVA: 0x0000DF14 File Offset: 0x0000C114
	private string NumToString(float num)
	{
		return num.ToString("0.0");
	}

	// Token: 0x06000214 RID: 532 RVA: 0x0000DF24 File Offset: 0x0000C124
	private void SetupGame()
	{
		float num = UnityEngine.Random.Range(-5f, 5f);
		float num2 = UnityEngine.Random.Range(-5f, 5f);
		float num3 = num * num2;
		this.win_label.text = string.Empty;
		this.win_label.overrideColor = true;
		this.answer = this.NumToString(num3);
		if (this.num1_label)
		{
			this.num1_label.text = this.NumToString(num);
		}
		if (this.num2_label)
		{
			this.num2_label.text = this.NumToString(num2);
		}
		foreach (PhoneButton phoneButton in this.auto_buttons)
		{
			phoneButton.text = this.NumToString(UnityEngine.Random.Range(-28f, 28f));
			phoneButton.command = ".accept";
		}
		this.auto_buttons[UnityEngine.Random.Range(0, this.auto_buttons.Count)].text = "Recycle";
		this.auto_buttons[UnityEngine.Random.Range(0, this.auto_buttons.Count)].text = this.answer;
	}

	// Token: 0x06000215 RID: 533 RVA: 0x0000E08C File Offset: 0x0000C28C
	private bool CheckAnswer(string text)
	{
		if (text == this.answer)
		{
			this.OnWin();
		}
		else
		{
			this.OnLose();
		}
		return true;
	}

	// Token: 0x06000216 RID: 534 RVA: 0x0000E0B4 File Offset: 0x0000C2B4
	private void OnWin()
	{
		if (this.win_label)
		{
			this.win_label.text = "CORRECT!!";
			this.win_label.color = Color.green;
			this.win_label.renderer.material.color = Color.green;
		}
		base.Invoke("SetupGame", 1f);
	}

	// Token: 0x06000217 RID: 535 RVA: 0x0000E11C File Offset: 0x0000C31C
	private void OnLose()
	{
		if (this.win_label)
		{
			this.win_label.text = "WRONG!!";
			this.win_label.color = Color.red;
			this.win_label.renderer.material.color = Color.red;
		}
		base.Invoke("SetupGame", 1f);
	}

	// Token: 0x06000218 RID: 536 RVA: 0x0000E184 File Offset: 0x0000C384
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message.StartsWith("accept"))
		{
			this.CheckAnswer(button.text);
			return true;
		}
		return base.ButtonMessage(button, message);
	}

	// Token: 0x0400020B RID: 523
	private string answer;

	// Token: 0x0400020C RID: 524
	public PhoneLabel num1_label;

	// Token: 0x0400020D RID: 525
	public PhoneLabel num2_label;

	// Token: 0x0400020E RID: 526
	public PhoneLabel win_label;
}
