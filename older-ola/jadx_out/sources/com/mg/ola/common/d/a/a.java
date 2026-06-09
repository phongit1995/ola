package com.mg.ola.common.d.a;

import android.text.TextPaint;
import android.text.style.ClickableSpan;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
public class a extends ClickableSpan {
    private int a;
    private boolean b;

    public a() {
        this.b = true;
    }

    public a(int i, boolean z) {
        this.b = true;
        this.a = i;
        this.b = z;
    }

    @Override // android.text.style.ClickableSpan
    public void onClick(View view) {
    }

    @Override // android.text.style.ClickableSpan, android.text.style.CharacterStyle
    public void updateDrawState(TextPaint textPaint) {
        textPaint.setColor(this.a == 0 ? textPaint.linkColor : this.a);
        textPaint.setUnderlineText(this.b);
    }
}
