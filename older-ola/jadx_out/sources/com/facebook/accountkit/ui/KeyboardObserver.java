package com.facebook.accountkit.ui;

import android.graphics.Rect;
import android.os.Build;
import android.support.annotation.Nullable;
import android.view.View;
import android.view.ViewTreeObserver;

/* JADX INFO: loaded from: classes.dex */
final class KeyboardObserver {
    private static final int MINIMUM_KEYBOARD_HEIGHT_DP;
    private OnVisibleFrameChangedListener onVisibleFrameChangedListener;
    private boolean didCalculateVisibleFrame = false;
    private final Rect lastViewVisibleFrame = new Rect();
    private final Rect lastRootViewVisibleFrame = new Rect();
    private final Rect rootViewVisibleFrame = new Rect();

    public interface OnVisibleFrameChangedListener {
        void onVisibleFrameChanged(Rect rect);
    }

    static {
        MINIMUM_KEYBOARD_HEIGHT_DP = (Build.VERSION.SDK_INT >= 21 ? 48 : 0) + 100;
    }

    public KeyboardObserver(View view) {
        configureGlobalObserver(view);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void checkVisibleFrame(View view, View view2) {
        int dimensionPixelSize = ViewUtility.getDimensionPixelSize(view2.getContext(), MINIMUM_KEYBOARD_HEIGHT_DP);
        view2.getWindowVisibleDisplayFrame(this.rootViewVisibleFrame);
        if (!(view2.getHeight() - (this.rootViewVisibleFrame.bottom - this.rootViewVisibleFrame.top) >= dimensionPixelSize) || this.rootViewVisibleFrame.equals(this.lastRootViewVisibleFrame)) {
            return;
        }
        this.lastRootViewVisibleFrame.set(this.rootViewVisibleFrame);
        view.getGlobalVisibleRect(this.lastViewVisibleFrame);
        this.didCalculateVisibleFrame = true;
        if (this.onVisibleFrameChangedListener != null) {
            this.onVisibleFrameChangedListener.onVisibleFrameChanged(this.lastViewVisibleFrame);
        }
    }

    private void configureGlobalObserver(final View view) {
        final View rootView;
        if (view == null || (rootView = view.getRootView()) == null) {
            return;
        }
        rootView.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() { // from class: com.facebook.accountkit.ui.KeyboardObserver.1
            @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
            public void onGlobalLayout() {
                KeyboardObserver.this.checkVisibleFrame(view, rootView);
            }
        });
        checkVisibleFrame(view, rootView);
    }

    public void setOnVisibleFrameChangedListener(@Nullable OnVisibleFrameChangedListener onVisibleFrameChangedListener) {
        this.onVisibleFrameChangedListener = onVisibleFrameChangedListener;
        if (!this.didCalculateVisibleFrame || onVisibleFrameChangedListener == null) {
            return;
        }
        onVisibleFrameChangedListener.onVisibleFrameChanged(this.lastViewVisibleFrame);
    }
}
