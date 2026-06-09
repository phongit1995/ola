package com.facebook.accountkit.ui;

import android.content.Context;
import android.support.design.widget.TextInputLayout;
import android.util.AttributeSet;

/* JADX INFO: loaded from: classes.dex */
public class ClearBackgroundTextInputLayout extends TextInputLayout {
    public ClearBackgroundTextInputLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    private void clearBackground() {
        if (getEditText() != null) {
            getEditText().getBackground().clearColorFilter();
        }
    }

    @Override // android.support.design.widget.TextInputLayout, android.view.ViewGroup, android.view.View
    public void drawableStateChanged() {
        super.drawableStateChanged();
        clearBackground();
    }

    @Override // android.support.design.widget.TextInputLayout
    public void setError(CharSequence charSequence) {
        super.setError(charSequence);
        clearBackground();
    }
}
