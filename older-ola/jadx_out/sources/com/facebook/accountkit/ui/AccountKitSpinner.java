package com.facebook.accountkit.ui;

import android.content.Context;
import android.support.annotation.Nullable;
import android.support.v7.widget.AppCompatSpinner;
import android.util.AttributeSet;

/* JADX INFO: loaded from: classes.dex */
public class AccountKitSpinner extends AppCompatSpinner {

    @Nullable
    private OnSpinnerEventsListener listener;
    private boolean openStarted;

    public interface OnSpinnerEventsListener {
        void onSpinnerClosed();

        void onSpinnerOpened();
    }

    public AccountKitSpinner(Context context) {
        super(context);
        this.openStarted = false;
    }

    public AccountKitSpinner(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.openStarted = false;
    }

    public AccountKitSpinner(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.openStarted = false;
    }

    private void performClosedEvent() {
        this.openStarted = false;
        if (this.listener != null) {
            this.listener.onSpinnerClosed();
        }
    }

    @Override // android.view.View
    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        if (this.openStarted && z) {
            performClosedEvent();
        }
    }

    @Override // android.support.v7.widget.AppCompatSpinner, android.widget.Spinner, android.view.View
    public boolean performClick() {
        this.openStarted = true;
        if (this.listener != null) {
            this.listener.onSpinnerOpened();
        }
        return super.performClick();
    }

    void setOnSpinnerEventsListener(OnSpinnerEventsListener onSpinnerEventsListener) {
        this.listener = onSpinnerEventsListener;
    }
}
