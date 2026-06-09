package chat.ola.vn.i;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Point;
import android.view.Display;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class n extends Dialog {
    private int a;
    private int b;
    private int c;
    private int d;
    protected boolean i;
    protected boolean j;

    public n(Context context) {
        this(context, R.style.Theme_ola_default_dialog);
    }

    public n(Context context, int i) {
        super(context, i);
        this.a = 0;
        this.b = 0;
        this.c = 0;
        this.d = 0;
        this.i = false;
        getWindow().setSoftInputMode(1);
        getWindow().setLayout(-1, -2);
        setCanceledOnTouchOutside(true);
        this.a = getContext().getResources().getDimensionPixelSize(R.dimen.metric_16dp);
        this.b = this.a;
        this.c = getContext().getResources().getDimensionPixelSize(R.dimen.metric_72dp);
        this.d = this.c;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @SuppressLint({"NewApi"})
    protected final void b() {
        int height;
        Display defaultDisplay = ((WindowManager) getContext().getSystemService("window")).getDefaultDisplay();
        if (com.mg.ola.common.d.g.e()) {
            Point point = new Point();
            defaultDisplay.getSize(point);
            chat.ola.vn.e.c = point.x;
            height = point.y;
        } else {
            chat.ola.vn.e.c = defaultDisplay.getWidth();
            height = defaultDisplay.getHeight();
        }
        chat.ola.vn.e.d = height;
    }

    @Override // android.app.Dialog, android.content.DialogInterface
    public void dismiss() {
        try {
            super.dismiss();
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Dialog, android.view.Window.Callback
    public void onContentChanged() {
        super.onContentChanged();
        this.i = false;
    }

    @Override // android.app.Dialog, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 82) {
            return super.onKeyDown(i, keyEvent);
        }
        dismiss();
        return false;
    }

    @Override // android.app.Dialog
    public void show() {
        try {
            if (!this.j) {
                super.show();
                return;
            }
            if (!this.i) {
                getWindow().setLayout(-1, -2);
            }
            super.show();
            if (this.i) {
                return;
            }
            final View decorView = getWindow().getDecorView();
            decorView.post(new Runnable() { // from class: chat.ola.vn.i.n.1
                @Override // java.lang.Runnable
                public void run() {
                    int height = decorView.getHeight();
                    int width = decorView.getWidth();
                    n.this.b();
                    int i = n.this.getWindow().getAttributes().width;
                    int i2 = n.this.getWindow().getAttributes().height;
                    if (width > (chat.ola.vn.e.c - n.this.a) - n.this.b) {
                        i = (chat.ola.vn.e.c - n.this.a) - n.this.b;
                    }
                    if (height >= (chat.ola.vn.e.d - n.this.c) - n.this.d) {
                        i2 = (chat.ola.vn.e.d - n.this.c) - n.this.d;
                    }
                    n.this.getWindow().setLayout(i, i2);
                    n.this.i = true;
                }
            });
        } catch (Throwable unused) {
        }
    }
}
