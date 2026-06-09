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
import android.view.View;
import android.widget.TextView;

/* JADX INFO: loaded from: classes2.dex */
public class OlaTextView extends TextView {
    protected b a;
    private GestureDetector b;

    private class a extends GestureDetector.SimpleOnGestureListener {
        private a() {
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onDown(MotionEvent motionEvent) {
            ClickableSpan[] clickableSpanArrA;
            if (OlaTextView.this.a == null || (clickableSpanArrA = OlaTextView.this.a(OlaTextView.this, OlaTextView.this.getText(), motionEvent)) == null || clickableSpanArrA.length == 0) {
                return super.onDown(motionEvent);
            }
            return true;
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public void onLongPress(MotionEvent motionEvent) {
            ClickableSpan[] clickableSpanArrA;
            if (!OlaTextView.this.getLinksClickable() || (clickableSpanArrA = OlaTextView.this.a(OlaTextView.this, OlaTextView.this.getText(), motionEvent)) == null || clickableSpanArrA.length == 0) {
                super.onLongPress(motionEvent);
            } else {
                OlaTextView.this.b(clickableSpanArrA[0]);
            }
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onSingleTapUp(MotionEvent motionEvent) {
            ClickableSpan[] clickableSpanArrA;
            if (!OlaTextView.this.getLinksClickable() || (clickableSpanArrA = OlaTextView.this.a(OlaTextView.this, OlaTextView.this.getText(), motionEvent)) == null || clickableSpanArrA.length == 0) {
                return super.onSingleTapUp(motionEvent);
            }
            OlaTextView.this.a(clickableSpanArrA[0]);
            return true;
        }
    }

    public interface b {
        void a(View view, ClickableSpan clickableSpan, CharSequence charSequence);

        void b(View view, ClickableSpan clickableSpan, CharSequence charSequence);
    }

    public OlaTextView(Context context) {
        super(context);
        a();
    }

    public OlaTextView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a();
    }

    public OlaTextView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        a();
    }

    private void a() {
        try {
            this.b = new GestureDetector(getContext(), new a(), getHandler());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
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

    /* JADX INFO: Access modifiers changed from: private */
    public void b(ClickableSpan clickableSpan) {
        if (this.a != null) {
            try {
                CharSequence text = getText();
                int spanStart = 0;
                int length = text.length() - 1;
                if (text instanceof Spanned) {
                    spanStart = ((Spanned) text).getSpanStart(clickableSpan);
                    length = ((Spanned) text).getSpanEnd(clickableSpan);
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
                this.a.b(this, clickableSpan, text.subSequence(spanStart, length));
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    protected void a(ClickableSpan clickableSpan) {
        if (this.a == null) {
            clickableSpan.onClick(this);
            return;
        }
        try {
            CharSequence text = getText();
            int spanStart = 0;
            int length = text.length() - 1;
            if (text instanceof Spanned) {
                spanStart = ((Spanned) text).getSpanStart(clickableSpan);
                length = ((Spanned) text).getSpanEnd(clickableSpan);
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
            this.a.a(this, clickableSpan, text.subSequence(spanStart, length));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.widget.TextView, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (this.b.onTouchEvent(motionEvent)) {
            return true;
        }
        return super.onTouchEvent(motionEvent);
    }

    public void setOlaSpanClickListener(b bVar) {
        this.a = bVar;
    }
}
