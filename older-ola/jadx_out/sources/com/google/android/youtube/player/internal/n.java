package com.google.android.youtube.player.internal;

import android.R;
import android.content.Context;
import android.support.v4.view.ViewCompat;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes2.dex */
public final class n extends FrameLayout {
    private final ProgressBar a;
    private final TextView b;

    public n(Context context) {
        super(context, null, z.c(context));
        m mVar = new m(context);
        setBackgroundColor(ViewCompat.MEASURED_STATE_MASK);
        this.a = new ProgressBar(context);
        this.a.setVisibility(8);
        addView(this.a, new FrameLayout.LayoutParams(-2, -2, 17));
        int i = (int) ((context.getResources().getDisplayMetrics().density * 10.0f) + 0.5f);
        this.b = new TextView(context);
        this.b.setTextAppearance(context, R.style.TextAppearance.Small);
        this.b.setTextColor(-1);
        this.b.setVisibility(8);
        this.b.setPadding(i, i, i, i);
        this.b.setGravity(17);
        this.b.setText(mVar.a);
        addView(this.b, new FrameLayout.LayoutParams(-2, -2, 17));
    }

    public final void a() {
        this.a.setVisibility(8);
        this.b.setVisibility(8);
    }

    public final void b() {
        this.a.setVisibility(0);
        this.b.setVisibility(8);
    }

    public final void c() {
        this.a.setVisibility(8);
        this.b.setVisibility(0);
    }

    @Override // android.widget.FrameLayout, android.view.View
    protected final void onMeasure(int i, int i2) {
        float f;
        int mode = View.MeasureSpec.getMode(i);
        int mode2 = View.MeasureSpec.getMode(i2);
        int size = View.MeasureSpec.getSize(i);
        int size2 = View.MeasureSpec.getSize(i2);
        if (mode != 1073741824 || mode2 != 1073741824) {
            if (mode == 1073741824 || (mode == Integer.MIN_VALUE && mode2 == 0)) {
                size2 = (int) (size / 1.777f);
            } else {
                if (mode2 == 1073741824 || (mode2 == Integer.MIN_VALUE && mode == 0)) {
                    f = size2;
                } else if (mode == Integer.MIN_VALUE && mode2 == Integer.MIN_VALUE) {
                    f = size2;
                    float f2 = size / 1.777f;
                    if (f >= f2) {
                        size2 = (int) f2;
                    }
                } else {
                    size = 0;
                    size2 = 0;
                }
                size = (int) (f * 1.777f);
            }
        }
        super.onMeasure(View.MeasureSpec.makeMeasureSpec(resolveSize(size, i), CrashUtils.ErrorDialogData.SUPPRESSED), View.MeasureSpec.makeMeasureSpec(resolveSize(size2, i2), CrashUtils.ErrorDialogData.SUPPRESSED));
    }
}
