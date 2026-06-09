package com.mg.ola.common.widget;

import android.content.Context;
import android.text.Layout;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.SpannedString;
import android.text.style.ClickableSpan;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.widget.EditText;
import android.widget.TextView;
import com.mg.ola.common.widget.OlaTextView;

/* JADX INFO: loaded from: classes2.dex */
public class d extends EditText {
    private GestureDetector a;
    private OlaTextView.b b;
    private b c;

    private class a extends GestureDetector.SimpleOnGestureListener {
        private a() {
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onDown(MotionEvent motionEvent) {
            ClickableSpan[] clickableSpanArrA;
            if (d.this.b == null || (clickableSpanArrA = d.this.a(d.this, d.this.getText(), motionEvent)) == null || clickableSpanArrA.length == 0) {
                return super.onDown(motionEvent);
            }
            return true;
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public void onLongPress(MotionEvent motionEvent) {
            ClickableSpan[] clickableSpanArrA;
            if (!d.this.getLinksClickable() || (clickableSpanArrA = d.this.a(d.this, d.this.getText(), motionEvent)) == null || clickableSpanArrA.length == 0) {
                super.onLongPress(motionEvent);
            } else {
                d.this.b(clickableSpanArrA[0]);
            }
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onSingleTapUp(MotionEvent motionEvent) {
            ClickableSpan[] clickableSpanArrA;
            if (!d.this.getLinksClickable() || (clickableSpanArrA = d.this.a(d.this, d.this.getText(), motionEvent)) == null || clickableSpanArrA.length == 0) {
                return super.onSingleTapUp(motionEvent);
            }
            d.this.a(clickableSpanArrA[0]);
            return true;
        }
    }

    public interface b {
        boolean a(int i, int i2);
    }

    public d(Context context) {
        super(context);
        a();
    }

    public d(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a();
    }

    public d(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        a();
    }

    private void a() {
        try {
            this.a = new GestureDetector(getContext(), new a(), getHandler());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(ClickableSpan clickableSpan) {
        if (this.b != null) {
            try {
                Spanned text = getText();
                int spanStart = 0;
                int length = text.length() - 1;
                if (text instanceof Spanned) {
                    spanStart = text.getSpanStart(clickableSpan);
                    length = text.getSpanEnd(clickableSpan);
                } else if (text instanceof Spannable) {
                    spanStart = ((Spannable) text).getSpanStart(clickableSpan);
                    length = ((Spannable) text).getSpanEnd(clickableSpan);
                } else if ((text instanceof SpannedString) || (text instanceof SpannableString)) {
                    spanStart = ((SpannedString) text).getSpanStart(clickableSpan);
                    SpannedString spannedString = (SpannedString) text;
                    length = spannedString.getSpanEnd(clickableSpan);
                } else if (text instanceof SpannableStringBuilder) {
                    spanStart = ((SpannableStringBuilder) text).getSpanStart(clickableSpan);
                    length = ((SpannableStringBuilder) text).getSpanEnd(clickableSpan);
                }
                this.b.b(this, clickableSpan, text.subSequence(spanStart, length));
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    protected void a(ClickableSpan clickableSpan) {
        if (this.b == null) {
            clickableSpan.onClick(this);
            return;
        }
        try {
            Spanned text = getText();
            int spanStart = 0;
            int length = text.length() - 1;
            if (text instanceof Spanned) {
                spanStart = text.getSpanStart(clickableSpan);
                length = text.getSpanEnd(clickableSpan);
            } else if (text instanceof Spannable) {
                spanStart = ((Spannable) text).getSpanStart(clickableSpan);
                length = ((Spannable) text).getSpanEnd(clickableSpan);
            } else if ((text instanceof SpannedString) || (text instanceof SpannableString)) {
                spanStart = ((SpannedString) text).getSpanStart(clickableSpan);
                SpannedString spannedString = (SpannedString) text;
                length = spannedString.getSpanEnd(clickableSpan);
            } else if (text instanceof SpannableStringBuilder) {
                spanStart = ((SpannableStringBuilder) text).getSpanStart(clickableSpan);
                length = ((SpannableStringBuilder) text).getSpanEnd(clickableSpan);
            }
            this.b.a(this, clickableSpan, text.subSequence(spanStart, length));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public ClickableSpan[] a(TextView textView, CharSequence charSequence, MotionEvent motionEvent) {
        int action = motionEvent.getAction();
        if (action != 1 && action != 0) {
            return null;
        }
        int x = (int) motionEvent.getX();
        int y = (int) motionEvent.getY();
        int totalPaddingLeft = x - textView.getTotalPaddingLeft();
        int totalPaddingTop = y - textView.getTotalPaddingTop();
        int scrollX = totalPaddingLeft + textView.getScrollX();
        int scrollY = totalPaddingTop + textView.getScrollY();
        Layout layout = textView.getLayout();
        int offsetForHorizontal = layout.getOffsetForHorizontal(layout.getLineForVertical(scrollY), scrollX);
        return (ClickableSpan[]) new SpannableString(charSequence).getSpans(offsetForHorizontal, offsetForHorizontal, ClickableSpan.class);
    }

    @Override // android.widget.TextView
    protected void onSelectionChanged(int i, int i2) {
        if (this.c != null) {
            this.c.a(i, i2);
            super.onSelectionChanged(i, i2);
        }
    }

    @Override // android.widget.TextView, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (this.a.onTouchEvent(motionEvent)) {
            return true;
        }
        return super.onTouchEvent(motionEvent);
    }

    public void setOnSelectionChangeListener(b bVar) {
        this.c = bVar;
    }

    public void setOnSpanClickListener(OlaTextView.b bVar) {
        this.b = bVar;
    }
}
