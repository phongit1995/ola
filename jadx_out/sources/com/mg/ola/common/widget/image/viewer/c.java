package com.mg.ola.common.widget.image.viewer;

import android.annotation.TargetApi;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
@TargetApi(16)
public class c {
    public static void a(View view, Runnable runnable) {
        view.postOnAnimation(runnable);
    }
}
