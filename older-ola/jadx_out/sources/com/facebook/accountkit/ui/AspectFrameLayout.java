package com.facebook.accountkit.ui;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Point;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.view.View;
import android.view.WindowManager;
import android.widget.FrameLayout;
import com.facebook.accountkit.R;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public final class AspectFrameLayout extends FrameLayout {
    private int aspectHeight;
    private int aspectWidth;
    private Point displaySize;

    public AspectFrameLayout(Context context) {
        super(context);
    }

    public AspectFrameLayout(Context context, @Nullable AttributeSet attributeSet) {
        super(context, attributeSet);
        init(context, attributeSet);
    }

    public AspectFrameLayout(Context context, @Nullable AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        init(context, attributeSet);
    }

    @TargetApi(21)
    public AspectFrameLayout(Context context, @Nullable AttributeSet attributeSet, int i, int i2) {
        super(context, attributeSet, i, i2);
        init(context, attributeSet);
    }

    private void init(Context context, @Nullable AttributeSet attributeSet) {
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, R.styleable.AspectFrameLayout);
        try {
            this.aspectWidth = typedArrayObtainStyledAttributes.getDimensionPixelSize(R.styleable.AspectFrameLayout_com_accountkit_aspect_width, 0);
            this.aspectHeight = typedArrayObtainStyledAttributes.getDimensionPixelSize(R.styleable.AspectFrameLayout_com_accountkit_aspect_height, 0);
        } finally {
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    public float getAspectHeight() {
        return this.aspectHeight;
    }

    public float getAspectWidth() {
        return this.aspectWidth;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        Point point = new Point();
        ((WindowManager) getContext().getSystemService("window")).getDefaultDisplay().getSize(point);
        this.displaySize = point;
    }

    @Override // android.widget.FrameLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        int i3;
        if (this.aspectWidth == 0 || this.aspectHeight == 0 || this.displaySize == null) {
            super.onMeasure(i, i2);
            return;
        }
        int i4 = (this.displaySize.x * this.aspectHeight) / this.aspectWidth;
        if (i4 > this.displaySize.y) {
            i3 = this.displaySize.x;
        } else {
            i3 = (this.displaySize.y * this.aspectWidth) / this.aspectHeight;
            i4 = this.displaySize.y;
        }
        super.onMeasure(View.MeasureSpec.makeMeasureSpec(i3, CrashUtils.ErrorDialogData.SUPPRESSED), View.MeasureSpec.makeMeasureSpec(i4, CrashUtils.ErrorDialogData.SUPPRESSED));
    }

    public void setAspectHeight(int i) {
        if (this.aspectHeight == i) {
            return;
        }
        this.aspectHeight = i;
        requestLayout();
    }

    public void setAspectWidth(int i) {
        if (this.aspectWidth == i) {
            return;
        }
        this.aspectWidth = i;
        requestLayout();
    }
}
