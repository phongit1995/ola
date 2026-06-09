package chat.ola.vn.view;

import android.R;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;

/* JADX INFO: loaded from: classes.dex */
public class RotateLayout extends ViewGroup {
    private int a;
    private View b;

    public RotateLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        setBackgroundResource(R.color.transparent);
    }

    @Override // android.view.View
    protected void onFinishInflate() {
        this.b = getChildAt(0);
        com.mg.ola.a.a.c.b.b(this.b, 0.0f);
        com.mg.ola.a.a.c.b.c(this.b, 0.0f);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        int i5 = i3 - i;
        int i6 = i4 - i2;
        int i7 = this.a;
        if (i7 != 0) {
            if (i7 != 90) {
                if (i7 != 180) {
                    if (i7 != 270) {
                        return;
                    }
                }
            }
            this.b.layout(0, 0, i6, i5);
            return;
        }
        this.b.layout(0, 0, i5, i6);
    }

    /* JADX WARN: Removed duplicated region for block: B:8:0x0013  */
    /* JADX WARN: Removed duplicated region for block: B:9:0x0025  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void onMeasure(int r6, int r7) {
        /*
            r5 = this;
            int r0 = r5.a
            r1 = 270(0x10e, float:3.78E-43)
            r2 = 180(0xb4, float:2.52E-43)
            r3 = 90
            r4 = 0
            if (r0 == 0) goto L25
            if (r0 == r3) goto L13
            if (r0 == r2) goto L25
            if (r0 == r1) goto L13
            r6 = 0
            goto L36
        L13:
            android.view.View r0 = r5.b
            r5.measureChild(r0, r7, r6)
            android.view.View r6 = r5.b
            int r4 = r6.getMeasuredHeight()
            android.view.View r6 = r5.b
            int r6 = r6.getMeasuredWidth()
            goto L36
        L25:
            android.view.View r0 = r5.b
            r5.measureChild(r0, r6, r7)
            android.view.View r6 = r5.b
            int r4 = r6.getMeasuredWidth()
            android.view.View r6 = r5.b
            int r6 = r6.getMeasuredHeight()
        L36:
            r5.setMeasuredDimension(r4, r6)
            int r7 = r5.a
            r0 = 0
            if (r7 == 0) goto L5c
            if (r7 == r3) goto L50
            if (r7 == r2) goto L4c
            if (r7 == r1) goto L45
            goto L61
        L45:
            android.view.View r6 = r5.b
            float r7 = (float) r4
            com.mg.ola.a.a.c.b.e(r6, r7)
            goto L5c
        L4c:
            android.view.View r7 = r5.b
            float r0 = (float) r4
            goto L52
        L50:
            android.view.View r7 = r5.b
        L52:
            com.mg.ola.a.a.c.b.e(r7, r0)
            android.view.View r7 = r5.b
            float r6 = (float) r6
            com.mg.ola.a.a.c.b.f(r7, r6)
            goto L61
        L5c:
            android.view.View r6 = r5.b
            com.mg.ola.a.a.c.b.f(r6, r0)
        L61:
            android.view.View r6 = r5.b
            int r7 = r5.a
            int r7 = -r7
            float r7 = (float) r7
            com.mg.ola.a.a.c.b.d(r6, r7)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.RotateLayout.onMeasure(int, int):void");
    }

    public void setOrientation(int i) {
        int i2 = i % 360;
        if (this.a == i2) {
            return;
        }
        this.a = i2;
        requestLayout();
    }
}
