package chat.ola.vn.view;

import android.app.Activity;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.RelativeLayout;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public class PreviewFrameLayout extends RelativeLayout {
    private double a;
    private int b;
    private int c;

    public PreviewFrameLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        setAspectRatio(1.7777777777777777d);
    }

    @Override // android.widget.RelativeLayout, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i + this.c, i2 + this.b, i3 + this.c, i4 + this.b);
    }

    @Override // android.widget.RelativeLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        int size = View.MeasureSpec.getSize(i);
        int size2 = View.MeasureSpec.getSize(i2);
        double d = size;
        double d2 = size2;
        double d3 = d / d2;
        this.b = 0;
        this.c = 0;
        if (d3 < this.a) {
            int i3 = (int) (this.a * d2);
            this.c = (-(i3 - size)) / 2;
            size = i3;
        } else if (d3 > this.a) {
            int i4 = (int) (d / this.a);
            this.b = (-(i4 - size2)) / 2;
            size2 = i4;
        }
        super.onMeasure(View.MeasureSpec.makeMeasureSpec(size, CrashUtils.ErrorDialogData.SUPPRESSED), View.MeasureSpec.makeMeasureSpec(size2, CrashUtils.ErrorDialogData.SUPPRESSED));
    }

    public void setAspectRatio(double d) {
        if (d <= 0.0d) {
            throw new IllegalArgumentException();
        }
        try {
            if (((Activity) getContext()).getRequestedOrientation() == 1) {
                d = 1.0d / d;
            }
        } catch (Throwable unused) {
        }
        if (this.a != d) {
            this.a = d;
            requestLayout();
        }
    }
}
