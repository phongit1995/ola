package com.mg.ola.common.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Canvas;
import android.support.v4.view.ViewCompat;
import android.text.Layout;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.SpannedString;
import android.text.StaticLayout;
import android.text.TextUtils;
import android.text.style.ClickableSpan;
import android.text.style.ForegroundColorSpan;
import android.util.AttributeSet;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
@SuppressLint({"DrawAllocation"})
public class CommpressTextView extends OlaTextView {
    private int b;
    private float c;
    private float d;
    private StaticLayout e;
    private CharSequence f;
    private CharSequence g;
    private boolean h;
    private SpannableStringBuilder i;
    private a j;

    public interface a {
        void a(boolean z);
    }

    public CommpressTextView(Context context) {
        super(context);
        this.b = -1;
        this.c = 1.0f;
        this.d = 0.0f;
        this.h = false;
        c();
    }

    public CommpressTextView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.b = -1;
        this.c = 1.0f;
        this.d = 0.0f;
        this.h = false;
        c();
    }

    public CommpressTextView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.b = -1;
        this.c = 1.0f;
        this.d = 0.0f;
        this.h = false;
        c();
    }

    private void c() {
        try {
            this.i = new SpannableStringBuilder("\nXem thêm...");
            this.i.setSpan(new ClickableSpan() { // from class: com.mg.ola.common.widget.CommpressTextView.1
                @Override // android.text.style.ClickableSpan
                public void onClick(View view) {
                    CommpressTextView.this.a();
                }
            }, 0, this.i.length(), 33);
        } catch (Throwable unused) {
        }
    }

    public void a() {
        if (this.h) {
            this.h = false;
            if (this.j != null) {
                this.j.a(true);
            }
            requestLayout();
        }
    }

    @Override // com.mg.ola.common.widget.OlaTextView
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
            CharSequence charSequenceSubSequence = text.subSequence(spanStart, length);
            if (charSequenceSubSequence.toString().trim().compareToIgnoreCase(this.i.toString().trim()) == 0) {
                clickableSpan.onClick(this);
            } else {
                this.a.a(this, clickableSpan, charSequenceSubSequence);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void b() {
        if (this.h) {
            return;
        }
        this.h = true;
        if (this.j != null) {
            this.j.a(false);
        }
        requestLayout();
    }

    @Override // android.widget.TextView, android.view.View
    protected void onDraw(Canvas canvas) {
        try {
            super.onDraw(canvas);
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.TextView, android.view.View
    protected void onMeasure(int i, int i2) {
        try {
            int iMax = Math.max((View.MeasureSpec.getSize(i) - getTotalPaddingLeft()) - getTotalPaddingRight(), 0);
            if (!this.h || iMax <= 0) {
                setText(this.f);
                setMaxLines(Integer.MAX_VALUE);
                requestLayout();
            } else if (this.f != null && this.b > 0) {
                if (this.e == null || iMax != this.e.getWidth()) {
                    StaticLayout staticLayout = new StaticLayout(this.f, getPaint(), iMax, Layout.Alignment.ALIGN_NORMAL, this.c, this.d, false);
                    this.e = staticLayout;
                }
                if (this.e.getLineCount() > this.b) {
                    int lineStart = this.e.getLineStart(this.b);
                    if (lineStart < this.f.length()) {
                        int i3 = lineStart;
                        while (true) {
                            if (i3 <= lineStart - 10 || i3 < 0) {
                                break;
                            }
                            if (this.f.charAt(i3) == ' ') {
                                lineStart = i3;
                                break;
                            }
                            i3--;
                        }
                        this.g = this.f.subSequence(0, lineStart);
                        setText(this.g);
                        append(this.i);
                        setMaxLines(this.b + 2);
                    }
                } else {
                    setText(this.f);
                    setMaxLines(Integer.MAX_VALUE);
                }
            }
        } catch (Throwable unused) {
        }
        super.onMeasure(i, i2);
    }

    public void setEclipesizeMaxLine(int i) {
        if (this.b != i) {
            this.b = i;
            requestLayout();
        }
    }

    @Override // android.widget.TextView
    public void setEllipsize(TextUtils.TruncateAt truncateAt) {
    }

    public void setFullText(CharSequence charSequence) {
        this.f = charSequence;
        this.g = null;
        this.e = null;
        setText(charSequence);
    }

    @Override // android.widget.TextView
    public void setLineSpacing(float f, float f2) {
        this.d = f;
        this.c = f2;
        this.e = null;
        super.setLineSpacing(f, f2);
    }

    public void setMoreText(int i) {
        try {
            setMoreText(getResources().getString(i));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void setMoreText(CharSequence charSequence) {
        if (charSequence != null) {
            this.i = new SpannableStringBuilder("\n");
            this.i.append(charSequence);
            this.i.setSpan(new com.mg.ola.common.d.a.a(ViewCompat.MEASURED_STATE_MASK, false) { // from class: com.mg.ola.common.widget.CommpressTextView.2
                @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                public void onClick(View view) {
                    CommpressTextView.this.a();
                }
            }, 0, this.i.length(), 33);
        }
    }

    public void setMoreTextColor(int i) {
        if (this.i != null) {
            this.i.setSpan(new ForegroundColorSpan(i), 0, this.i.length(), 33);
        }
    }

    public void setOnEclipesizeListener(a aVar) {
        this.j = aVar;
    }
}
