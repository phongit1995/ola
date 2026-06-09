package com.facebook.accountkit.ui;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import android.widget.LinearLayout;
import com.facebook.accountkit.R;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public final class ConstrainedLinearLayout extends LinearLayout {
    private int maxHeight;
    private int maxWidth;
    private int minHeight;

    public ConstrainedLinearLayout(Context context) {
        super(context);
        this.maxHeight = -1;
        this.maxWidth = -1;
        this.minHeight = -1;
    }

    public ConstrainedLinearLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.maxHeight = -1;
        this.maxWidth = -1;
        this.minHeight = -1;
        init(context, attributeSet);
    }

    public ConstrainedLinearLayout(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.maxHeight = -1;
        this.maxWidth = -1;
        this.minHeight = -1;
        init(context, attributeSet);
    }

    @TargetApi(21)
    public ConstrainedLinearLayout(Context context, AttributeSet attributeSet, int i, int i2) {
        super(context, attributeSet, i, i2);
        this.maxHeight = -1;
        this.maxWidth = -1;
        this.minHeight = -1;
        init(context, attributeSet);
    }

    private void init(Context context, AttributeSet attributeSet) {
        if (attributeSet == null || isInEditMode()) {
            return;
        }
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, R.styleable.ConstrainedLinearLayout);
        try {
            this.maxHeight = typedArrayObtainStyledAttributes.getDimensionPixelSize(R.styleable.ConstrainedLinearLayout_com_accountkit_max_height, this.maxHeight);
            this.maxWidth = typedArrayObtainStyledAttributes.getDimensionPixelSize(R.styleable.ConstrainedLinearLayout_com_accountkit_max_width, this.maxWidth);
            this.minHeight = typedArrayObtainStyledAttributes.getDimensionPixelSize(R.styleable.ConstrainedLinearLayout_com_accountkit_min_height, this.minHeight);
        } finally {
            typedArrayObtainStyledAttributes.recycle();
        }
    }

    public int getMinHeight() {
        return this.minHeight;
    }

    @Override // android.widget.LinearLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        boolean z;
        super.onMeasure(i, i2);
        int measuredWidth = getMeasuredWidth();
        int measuredHeight = getMeasuredHeight();
        if (this.maxWidth < 0 || measuredWidth <= this.maxWidth) {
            z = false;
        } else {
            i = View.MeasureSpec.makeMeasureSpec(this.maxWidth, CrashUtils.ErrorDialogData.SUPPRESSED);
            z = true;
        }
        if (this.maxHeight >= 0 && measuredHeight > this.maxHeight) {
            i2 = View.MeasureSpec.makeMeasureSpec(this.maxHeight, CrashUtils.ErrorDialogData.SUPPRESSED);
            z = true;
        }
        if (this.minHeight >= 0 && measuredHeight < this.minHeight) {
            i2 = View.MeasureSpec.makeMeasureSpec(this.minHeight, CrashUtils.ErrorDialogData.SUPPRESSED);
            z = true;
        }
        if (z) {
            super.onMeasure(i, i2);
        }
    }

    public void setMinHeight(int i) {
        this.minHeight = i;
        requestLayout();
    }
}
