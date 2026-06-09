package chat.ola.vn.mediastore;

import android.app.Activity;
import android.view.View;
import android.widget.ImageView;

/* JADX INFO: loaded from: classes.dex */
public class a {
    public int a;
    public int b;
    public String c;
    public View d;
    public boolean e = true;
    public View.OnClickListener f;

    public void a(Activity activity) {
        if (this.d != null) {
            return;
        }
        try {
            this.d = activity.findViewById(this.a);
            this.d.setTag(this.c);
            this.d.setOnClickListener(this.f);
            a(this.e);
            if (!(this.d instanceof ImageView) || this.b <= 0) {
                return;
            }
            ((ImageView) this.d).setImageResource(this.b);
        } catch (Throwable unused) {
        }
    }

    public void a(View view) {
        if (this.d != null) {
            return;
        }
        try {
            this.d = view.findViewById(this.a);
            this.d.setTag(this.c);
            this.d.setOnClickListener(this.f);
            a(this.e);
            if (!(this.d instanceof ImageView) || this.b <= 0) {
                return;
            }
            ((ImageView) this.d).setImageResource(this.b);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(boolean z) {
        try {
            if (this.d != null) {
                if (z) {
                    this.d.setVisibility(0);
                } else {
                    this.d.setVisibility(8);
                }
            }
            this.e = z;
        } catch (Throwable unused) {
        }
    }
}
