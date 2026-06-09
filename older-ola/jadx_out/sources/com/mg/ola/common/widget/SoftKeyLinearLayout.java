package com.mg.ola.common.widget;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Point;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.Display;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.LinearLayout;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.mg.ola.common.d.g;

/* JADX INFO: loaded from: classes2.dex */
public class SoftKeyLinearLayout extends LinearLayout {
    private WindowManager a;
    private com.mg.ola.common.widget.a.a b;
    private boolean c;
    private Rect d;
    private int e;
    private int f;

    public SoftKeyLinearLayout(Context context) {
        super(context);
        this.f = 0;
        b();
    }

    public SoftKeyLinearLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f = 0;
        b();
    }

    private void b() {
        this.a = (WindowManager) getContext().getSystemService("window");
    }

    @TargetApi(13)
    private int getDisplayHeight() {
        Display defaultDisplay = this.a.getDefaultDisplay();
        if (!g.e()) {
            return defaultDisplay.getHeight();
        }
        Point point = new Point();
        defaultDisplay.getSize(point);
        return point.y;
    }

    private int getStatusBarHeight() {
        try {
            Resources resources = getContext().getResources();
            int identifier = resources.getIdentifier("status_bar_height", "dimen", AccountKitGraphConstants.SDK_TYPE_ANDROID);
            return identifier > 0 ? resources.getDimensionPixelSize(identifier) : (int) Math.ceil(resources.getDisplayMetrics().density * 25.0f);
        } catch (Throwable unused) {
            return 75;
        }
    }

    public boolean a() {
        return this.c;
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        if (this.d == null || !this.d.contains((int) motionEvent.getX(), (int) motionEvent.getY())) {
            return super.onInterceptTouchEvent(motionEvent);
        }
        return true;
    }

    @Override // android.widget.LinearLayout, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
    }

    @Override // android.widget.LinearLayout, android.view.View
    @SuppressLint({"ParserError"})
    protected void onMeasure(int i, int i2) {
        try {
            if (this.f == 0) {
                this.f = getStatusBarHeight();
            }
            int displayHeight = getDisplayHeight() - this.f;
            int size = View.MeasureSpec.getSize(i2);
            boolean z = true;
            if (size != this.e) {
                this.c = size < displayHeight;
            } else {
                z = false;
            }
            this.e = size;
            if (this.b != null && z) {
                this.b.a(this.c, size);
            }
        } catch (Throwable unused) {
        }
        try {
            super.onMeasure(i, i2);
        } catch (Throwable unused2) {
        }
    }

    public void setInterceptMargin(Rect rect) {
        this.d = rect;
    }

    public void setOnSoftKeyboardListener(com.mg.ola.common.widget.a.a aVar) {
        this.b = aVar;
    }
}
