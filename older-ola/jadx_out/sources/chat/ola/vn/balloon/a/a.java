package chat.ola.vn.balloon.a;

import android.os.Handler;
import android.view.WindowManager;
import android.view.animation.Interpolator;
import android.view.animation.OvershootInterpolator;

/* JADX INFO: loaded from: classes.dex */
public abstract class a {
    protected chat.ola.vn.balloon.a b;
    protected Handler c;
    protected WindowManager.LayoutParams f;
    protected short a = 0;
    protected Interpolator d = new OvershootInterpolator(0.45f);
    protected long e = 500;

    public a(chat.ola.vn.balloon.a aVar, Handler handler) {
        this.b = aVar;
        this.c = handler;
        if (this.c == null) {
            new Handler();
        }
        this.f = aVar.getBalloonLayoutParameter();
    }

    public void a(long j) {
        this.e = j;
    }

    protected void a(short s) {
        this.a = s;
        if (this.a != 3 || this.b == null) {
            return;
        }
        this.b.b();
    }
}
