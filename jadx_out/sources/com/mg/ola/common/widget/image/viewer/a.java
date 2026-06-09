package com.mg.ola.common.widget.image.viewer;

import android.os.Build;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
public class a {
    public static void a(View view, Runnable runnable) {
        if (Build.VERSION.SDK_INT >= 16) {
            c.a(view, runnable);
        } else {
            view.postDelayed(runnable, 16L);
        }
    }
}
