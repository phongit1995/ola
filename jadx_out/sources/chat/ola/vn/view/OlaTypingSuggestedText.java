package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.text.Editable;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Filterable;
import android.widget.ListAdapter;
import android.widget.PopupWindow;
import chat.ola.vn.R;
import chat.ola.vn.entity.x;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;

/* JADX INFO: loaded from: classes.dex */
public class OlaTypingSuggestedText extends com.mg.ola.common.widget.d {
    private char a;
    private char b;
    private int c;
    private int d;
    private com.mg.ola.common.widget.b e;
    private BaseAdapter f;
    private boolean g;
    private OlaQuickTypingSuggestedText.b h;

    public OlaTypingSuggestedText(Context context) {
        super(context);
        this.a = '@';
        this.b = '#';
        this.c = -1;
        this.d = 0;
        this.g = true;
        a(context);
    }

    public OlaTypingSuggestedText(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = '@';
        this.b = '#';
        this.c = -1;
        this.d = 0;
        this.g = true;
        a(context);
    }

    public OlaTypingSuggestedText(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = '@';
        this.b = '#';
        this.c = -1;
        this.d = 0;
        this.g = true;
        a(context);
    }

    private void a() {
        if (this.g) {
            try {
                if (this.e.f() || this.e.a() == null) {
                    return;
                }
                this.e.b();
            } catch (Throwable unused) {
            }
        }
    }

    private void a(Context context) {
        this.e = new com.mg.ola.common.widget.b(context);
        this.e.i(1);
        this.e.b(0);
        this.e.c(16);
        this.e.a(this);
        this.e.d(true);
        this.e.a(new ColorDrawable(chat.ola.vn.f.w));
        this.e.g(1);
        this.e.b(false);
        this.e.d(R.drawable.abs__menu_dropdown_panel_holo_light);
        this.e.a(false);
        this.e.a(5);
        this.e.a(new PopupWindow.OnDismissListener() { // from class: chat.ola.vn.view.OlaTypingSuggestedText.1
            @Override // android.widget.PopupWindow.OnDismissListener
            public void onDismiss() {
                OlaTypingSuggestedText.this.c = -1;
            }
        });
        this.e.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.view.OlaTypingSuggestedText.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                Object item = adapterView.getAdapter().getItem(i);
                if (item instanceof x) {
                    try {
                        String str = ((x) item).c + " ";
                        Editable editableText = OlaTypingSuggestedText.this.getEditableText();
                        if (editableText != null) {
                            int i2 = OlaTypingSuggestedText.this.c;
                            int length = str.length();
                            editableText.replace(OlaTypingSuggestedText.this.c, OlaTypingSuggestedText.this.c + OlaTypingSuggestedText.this.d, str);
                            try {
                                OlaTypingSuggestedText.this.setSelection(i2 + length);
                                OlaTypingSuggestedText.this.clearComposingText();
                            } catch (Throwable unused) {
                            }
                            OlaTypingSuggestedText.this.b();
                            if (OlaTypingSuggestedText.this.h != null) {
                                OlaTypingSuggestedText.this.h.b_(((x) item).c);
                            }
                        }
                    } catch (Throwable unused2) {
                    }
                }
                OlaTypingSuggestedText.this.e.d();
            }
        });
    }

    private void a(CharSequence charSequence) {
        b(a(this.c));
        a();
        a(charSequence, this.c, this.d);
    }

    private void b(int i) {
        this.e.b(1);
        this.e.e(getLineHeight() - (getHeight() - i));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean b() {
        if (this.g) {
            this.c = -1;
            this.d = 0;
            if (this.e.f()) {
                this.e.d();
                return true;
            }
        }
        return false;
    }

    public int a(int i) {
        int lineForOffset = getLayout().getLineForOffset(i);
        return getTop() + getPaddingTop() + (getLineHeight() * lineForOffset);
    }

    public void a(CharSequence charSequence, int i, int i2) {
        if (!this.g || charSequence.length() <= i) {
            return;
        }
        CharSequence charSequenceSubSequence = charSequence.subSequence(i, i2 + i);
        if (this.f instanceof Filterable) {
            ((Filterable) this.f).getFilter().filter(charSequenceSubSequence);
        }
    }

    public float getCursorX() {
        try {
            return getLayout().getPrimaryHorizontal(getSelectionStart());
        } catch (Throwable unused) {
            return 0.0f;
        }
    }

    public float getCursorY() {
        try {
            int selectionStart = getSelectionStart();
            int lineForOffset = getLayout().getLineForOffset(selectionStart);
            return r1.getLineBaseline(lineForOffset) + r1.getLineAscent(lineForOffset);
        } catch (Throwable unused) {
            return 0.0f;
        }
    }

    public OlaQuickTypingSuggestedText.b getOnSuggestionSelectListener() {
        return this.h;
    }

    @Override // android.widget.TextView, android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (this.g && ((i == 4 || i == 66) && b())) {
            return true;
        }
        return super.onKeyDown(i, keyEvent);
    }

    @Override // android.widget.TextView, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        if (this.g) {
            try {
                b(a(this.c));
            } catch (Throwable unused) {
            }
        }
    }

    @Override // android.widget.TextView
    protected void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        String string;
        char cCharAt;
        super.onTextChanged(charSequence, i, i2, i3);
        try {
            string = charSequence.toString();
        } catch (Throwable unused) {
            string = "";
        }
        int selectionStart = getSelectionStart();
        try {
            if (selectionStart < string.length()) {
                selectionStart--;
            }
        } catch (Throwable unused2) {
        }
        if (this.g) {
            try {
                if (string.length() == 0) {
                    b();
                    return;
                }
                if (selectionStart >= string.length()) {
                    selectionStart = string.length() - 1;
                }
                char cCharAt2 = string.charAt(selectionStart);
                try {
                    cCharAt = string.charAt(selectionStart - 1);
                } catch (Throwable unused3) {
                    cCharAt = '\r';
                }
                if (this.c < 0) {
                    if (cCharAt2 == this.a || cCharAt2 == this.b) {
                        if (cCharAt == '\n' || cCharAt == '\r' || cCharAt == ' ') {
                            this.c = selectionStart;
                            this.d = 1;
                            a(string);
                            return;
                        }
                        return;
                    }
                    return;
                }
                if (selectionStart < this.c) {
                    b();
                    return;
                }
                this.d = (selectionStart - this.c) + 1;
                if (this.d <= 1 || !(cCharAt2 == this.a || cCharAt2 == this.b || cCharAt2 == ' ' || cCharAt2 == '\n' || cCharAt2 == '\r')) {
                    a(string);
                } else {
                    b();
                }
            } catch (Throwable unused4) {
            }
        }
    }

    @Override // com.mg.ola.common.widget.d, android.widget.TextView, android.view.View
    @SuppressLint({"ClickableViewAccessibility"})
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (this.g && motionEvent.getAction() == 0 && this.e.f()) {
            this.e.d();
        }
        return super.onTouchEvent(motionEvent);
    }

    public void setAdapter(BaseAdapter baseAdapter) {
        this.f = baseAdapter;
        this.e.a(baseAdapter);
    }

    public void setAllowedSuggestion(boolean z) {
        this.g = z;
    }

    public void setContentFilterAdapter(BaseAdapter baseAdapter) {
        this.f = baseAdapter;
        this.e.a((ListAdapter) null);
    }

    public void setOnSuggestionSelectListener(OlaQuickTypingSuggestedText.b bVar) {
        this.h = bVar;
    }

    public void setPopupMaxHeight(int i) {
        this.e.h(i);
    }
}
