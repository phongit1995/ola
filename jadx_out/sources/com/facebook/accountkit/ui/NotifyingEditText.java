package com.facebook.accountkit.ui;

import android.content.Context;
import android.support.annotation.Nullable;
import android.support.v7.widget.AppCompatEditText;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputConnectionWrapper;

/* JADX INFO: loaded from: classes.dex */
public final class NotifyingEditText extends AppCompatEditText {
    private View.OnKeyListener onSoftKeyListener;
    private PasteListener pasteListener;

    private class NotifyingInputConnection extends InputConnectionWrapper {
        public NotifyingInputConnection(InputConnection inputConnection, boolean z) {
            super(inputConnection, z);
        }

        @Override // android.view.inputmethod.InputConnectionWrapper, android.view.inputmethod.InputConnection
        public boolean deleteSurroundingText(int i, int i2) {
            if (NotifyingEditText.this.onSoftKeyListener != null) {
                if (NotifyingEditText.this.onSoftKeyListener.onKey(NotifyingEditText.this, 67, new KeyEvent(1, 67)) || NotifyingEditText.this.onSoftKeyListener.onKey(NotifyingEditText.this, 67, new KeyEvent(0, 67))) {
                    return true;
                }
            }
            return super.deleteSurroundingText(i, i2);
        }

        @Override // android.view.inputmethod.InputConnectionWrapper, android.view.inputmethod.InputConnection
        public boolean sendKeyEvent(KeyEvent keyEvent) {
            return (NotifyingEditText.this.onSoftKeyListener != null && NotifyingEditText.this.onSoftKeyListener.onKey(NotifyingEditText.this, keyEvent.getKeyCode(), keyEvent)) || super.sendKeyEvent(keyEvent);
        }
    }

    public interface PasteListener {
        void onTextPaste();
    }

    public NotifyingEditText(Context context) {
        super(context);
    }

    public NotifyingEditText(Context context, @Nullable AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    public NotifyingEditText(Context context, @Nullable AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }

    @Override // android.support.v7.widget.AppCompatEditText, android.widget.TextView, android.view.View
    public InputConnection onCreateInputConnection(EditorInfo editorInfo) {
        return new NotifyingInputConnection(super.onCreateInputConnection(editorInfo), true);
    }

    @Override // android.widget.EditText, android.widget.TextView
    public boolean onTextContextMenuItem(int i) {
        boolean zOnTextContextMenuItem = super.onTextContextMenuItem(i);
        if (i == 16908322 && this.pasteListener != null) {
            this.pasteListener.onTextPaste();
        }
        return zOnTextContextMenuItem;
    }

    public void setOnSoftKeyListener(View.OnKeyListener onKeyListener) {
        this.onSoftKeyListener = onKeyListener;
    }

    public void setPasteListener(PasteListener pasteListener) {
        this.pasteListener = pasteListener;
    }
}
