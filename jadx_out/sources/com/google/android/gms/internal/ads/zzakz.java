package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.view.View;
import android.view.ViewGroup;

/* JADX INFO: loaded from: classes.dex */
@TargetApi(19)
public class zzakz extends zzakx {
    @Override // com.google.android.gms.internal.ads.zzakx, com.google.android.gms.internal.ads.zzakq
    public final boolean isAttachedToWindow(View view) {
        return view.isAttachedToWindow();
    }

    @Override // com.google.android.gms.internal.ads.zzakq
    public final ViewGroup.LayoutParams zzro() {
        return new ViewGroup.LayoutParams(-1, -1);
    }
}
