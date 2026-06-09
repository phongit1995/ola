package chat.ola.vn.view;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.text.Editable;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.Filterable;
import android.widget.PopupWindow;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.entity.x;

/* JADX INFO: loaded from: classes.dex */
public class OlaQuickTypingSuggestedText extends EditText implements TextView.OnEditorActionListener {
    private char a;
    private char b;
    private int c;
    private int d;
    private com.mg.ola.common.widget.b e;
    private BaseAdapter f;
    private b g;
    private a h;
    private boolean i;
    private boolean j;

    public interface a {
        void a(String str);
    }

    public interface b {
        void b_(String str);
    }

    public OlaQuickTypingSuggestedText(Context context) {
        super(context);
        this.a = '@';
        this.b = '#';
        this.c = -1;
        this.d = 0;
        this.i = true;
        this.j = false;
        a(context);
    }

    public OlaQuickTypingSuggestedText(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = '@';
        this.b = '#';
        this.c = -1;
        this.d = 0;
        this.i = true;
        this.j = false;
        a(context);
    }

    public OlaQuickTypingSuggestedText(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = '@';
        this.b = '#';
        this.c = -1;
        this.d = 0;
        this.i = true;
        this.j = false;
        a(context);
    }

    private void a(Context context) {
        super.setOnEditorActionListener(this);
        this.e = new com.mg.ola.common.widget.b(context);
        this.e.i(1);
        this.e.b(0);
        this.e.c(16);
        this.e.a(this);
        this.e.d(true);
        this.e.a(new ColorDrawable(Color.parseColor("#dedcdc")));
        this.e.g(1);
        this.e.b(false);
        this.e.d(R.drawable.abs__menu_dropdown_panel_holo_light);
        this.e.a(false);
        this.e.a(5);
        this.e.a(new PopupWindow.OnDismissListener() { // from class: chat.ola.vn.view.OlaQuickTypingSuggestedText.1
            @Override // android.widget.PopupWindow.OnDismissListener
            public void onDismiss() {
                OlaQuickTypingSuggestedText.this.c = -1;
            }
        });
        this.e.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.view.OlaQuickTypingSuggestedText.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                OlaQuickTypingSuggestedText olaQuickTypingSuggestedText;
                Object item = adapterView.getAdapter().getItem(i);
                if (item instanceof x) {
                    try {
                        String str = ((x) item).c;
                        Editable editableText = OlaQuickTypingSuggestedText.this.getEditableText();
                        if (editableText != null) {
                            int i2 = OlaQuickTypingSuggestedText.this.c;
                            int length = str.length();
                            if (OlaQuickTypingSuggestedText.this.c >= 0) {
                                editableText.replace(OlaQuickTypingSuggestedText.this.c, OlaQuickTypingSuggestedText.this.c + OlaQuickTypingSuggestedText.this.d, str);
                            } else {
                                editableText.append((CharSequence) str);
                            }
                            try {
                                OlaQuickTypingSuggestedText.this.setSelection(i2 + length);
                                OlaQuickTypingSuggestedText.this.clearComposingText();
                            } catch (Throwable unused) {
                            }
                            olaQuickTypingSuggestedText = OlaQuickTypingSuggestedText.this;
                        } else {
                            int i3 = OlaQuickTypingSuggestedText.this.c;
                            int length2 = str.length();
                            OlaQuickTypingSuggestedText.this.setText(str);
                            try {
                                OlaQuickTypingSuggestedText.this.setSelection(i3 + length2);
                                OlaQuickTypingSuggestedText.this.clearComposingText();
                            } catch (Throwable unused2) {
                            }
                            olaQuickTypingSuggestedText = OlaQuickTypingSuggestedText.this;
                        }
                        olaQuickTypingSuggestedText.c();
                        if (OlaQuickTypingSuggestedText.this.g != null) {
                            OlaQuickTypingSuggestedText.this.g.b_(((x) item).c);
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
                OlaQuickTypingSuggestedText.this.e.d();
            }
        });
    }

    private void a(CharSequence charSequence) {
        if (!this.i || this.c < 0) {
            return;
        }
        b(a(this.c));
        a();
        a(charSequence, this.c, this.d);
    }

    private void b(int i) {
        this.e.b(1);
        this.e.e(getLineHeight() - (getHeight() - i));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean c() {
        if (this.i) {
            this.c = -1;
            this.d = 0;
            if (this.j) {
                b();
                return false;
            }
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

    public void a() {
        if (this.i) {
            try {
                if (this.e.f()) {
                    return;
                }
                this.e.b();
            } catch (Throwable unused) {
            }
        }
    }

    public void a(CharSequence charSequence, int i, int i2) {
        if (!this.i || charSequence.length() <= i) {
            return;
        }
        CharSequence charSequenceSubSequence = charSequence.subSequence(i, i2 + i);
        if (this.f instanceof Filterable) {
            ((Filterable) this.f).getFilter().filter(charSequenceSubSequence);
        }
    }

    public void b() {
        if (this.i && (this.f instanceof Filterable)) {
            ((Filterable) this.f).getFilter().filter(null);
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

    public a getOnSuggestTypingListener() {
        return this.h;
    }

    public b getOnSuggestionSelectListener() {
        return this.g;
    }

    @Override // android.widget.TextView.OnEditorActionListener
    public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
        c();
        if (this.h == null) {
            return false;
        }
        if (i != 2 && (keyEvent == null || keyEvent.getKeyCode() != 66)) {
            return false;
        }
        try {
            if (textView.getText().length() <= 0) {
                return true;
            }
            this.h.a(textView.getText().toString());
            return true;
        } catch (Throwable unused) {
            this.h.a("");
            return true;
        }
    }

    @Override // android.widget.TextView, android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (this.i && ((i == 4 || i == 66) && c())) {
            return true;
        }
        return super.onKeyDown(i, keyEvent);
    }

    @Override // android.widget.TextView, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        if (this.i) {
            try {
                if (this.c >= 0) {
                    b(a(this.c));
                }
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
        if (this.i) {
            try {
                if (string.length() == 0) {
                    c();
                    return;
                }
                if (selectionStart >= string.length()) {
                    selectionStart = string.length() - 1;
                }
                char cCharAt2 = string.charAt(selectionStart);
                try {
                    cCharAt = string.charAt(selectionStart - 1);
                } catch (Throwable unused2) {
                    cCharAt = '\r';
                }
                if (this.c < 0) {
                    if ((cCharAt2 == this.a || cCharAt2 == this.b) && (cCharAt == '\n' || cCharAt == '\r' || cCharAt == ' ')) {
                        return;
                    }
                    this.c = selectionStart;
                    this.d = 1;
                    a(string);
                    return;
                }
                if (selectionStart < this.c) {
                    c();
                    return;
                }
                this.d = (selectionStart - this.c) + 1;
                if (this.d <= 1 || !(cCharAt2 == this.a || cCharAt2 == this.b || cCharAt2 == ' ' || cCharAt2 == '\n' || cCharAt2 == '\r')) {
                    a(string);
                } else {
                    c();
                }
            } catch (Throwable unused3) {
            }
        }
    }

    @Override // android.widget.TextView, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        try {
            if (this.i && motionEvent.getAction() == 0) {
                if (this.e.f()) {
                    this.e.d();
                } else if (this.j) {
                    b();
                    if (this.c < 0) {
                        this.c = 0;
                        try {
                            this.d = getText().length();
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                    this.e.b();
                }
            }
        } catch (Throwable unused) {
        }
        return super.onTouchEvent(motionEvent);
    }

    public void setAdapter(BaseAdapter baseAdapter) {
        this.f = baseAdapter;
        this.e.a(baseAdapter);
    }

    public void setAllowedSuggestion(boolean z) {
        this.i = z;
    }

    public void setOnSuggestTypingListener(a aVar) {
        this.h = aVar;
    }

    public void setOnSuggestionSelectListener(b bVar) {
        this.g = bVar;
    }

    public void setPopupMaxHeight(int i) {
        this.e.h(i);
    }

    public void setShowPopupOnFirstTouch(boolean z) {
        this.j = z;
    }

    public void setSuggestionPopupDismissListener(PopupWindow.OnDismissListener onDismissListener) {
        if (this.e != null) {
            this.e.a(onDismissListener);
        }
    }
}
