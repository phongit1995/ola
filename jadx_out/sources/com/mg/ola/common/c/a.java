package com.mg.ola.common.c;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.View;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes2.dex */
public class a {
    public Drawable a;
    public CharSequence b;
    public int c = -1;
    public WeakReference<View> d;

    public a(Context context, int i, CharSequence charSequence) {
        if (i != 0) {
            this.a = context.getResources().getDrawable(i);
        }
        this.b = charSequence;
    }
}
