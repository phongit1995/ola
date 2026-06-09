package chat.ola.vn.lock;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.r;
import chat.ola.vn.util.m;
import com.facebook.appevents.AppEventsConstants;

/* JADX INFO: loaded from: classes.dex */
public class OlaLockScreenActivity extends Activity implements View.OnClickListener, Animation.AnimationListener {
    protected static a a;
    public static long r;
    private static r w;
    protected Animation b;
    protected View c;
    protected Button d;
    protected Button e;
    protected Button f;
    protected Button g;
    protected Button h;
    protected Button i;
    protected Button j;
    protected Button k;
    protected Button l;
    protected Button m;
    protected Button n;
    protected Button o;
    protected Button p;
    protected Button q;
    private View s;
    private String t = "";
    private boolean u = true;
    private int v = 0;

    interface a {
        void a();
    }

    private void a() {
        int length = this.t.length();
        if (length > 0) {
            this.t = this.t.substring(0, length - 1);
            b();
        }
    }

    public static void a(Context context) {
        a(context, null);
    }

    public static void a(Context context, a aVar) {
        w = r.a(chat.ola.vn.e.a().v());
        r = w.c;
        if (w == null || m.a(w.a)) {
            chat.ola.vn.c.c_ = false;
        } else {
            a = aVar;
            context.startActivity(new Intent(context, (Class<?>) OlaLockScreenActivity.class));
        }
    }

    private void a(String str) {
        if (this.u) {
            try {
                if (this.b != null) {
                    this.b.cancel();
                    this.b.reset();
                }
            } catch (Throwable unused) {
            }
            this.t += str;
            b();
            if (this.t.length() >= 4) {
                b(this.t);
            }
        }
    }

    private void a(boolean z) {
        this.h.setEnabled(z);
        this.i.setEnabled(z);
        this.j.setEnabled(z);
        this.k.setEnabled(z);
        this.l.setEnabled(z);
        this.m.setEnabled(z);
        this.n.setEnabled(z);
        this.o.setEnabled(z);
        this.p.setEnabled(z);
        this.q.setEnabled(z);
        this.s.setEnabled(z);
    }

    private void b() {
        Button button;
        Button button2;
        int length = this.t.length();
        for (int i = 0; i < 4; i++) {
            switch (i) {
                case 0:
                    if (i < length) {
                        button2 = this.d;
                        button2.setSelected(true);
                    } else {
                        button = this.d;
                        button.setSelected(false);
                    }
                    break;
                case 1:
                    if (i < length) {
                        button2 = this.e;
                        button2.setSelected(true);
                    } else {
                        button = this.e;
                        button.setSelected(false);
                    }
                    break;
                case 2:
                    if (i < length) {
                        button2 = this.f;
                        button2.setSelected(true);
                    } else {
                        button = this.f;
                        button.setSelected(false);
                    }
                    break;
                case 3:
                    if (i < length) {
                        button2 = this.g;
                        button2.setSelected(true);
                    } else {
                        button = this.g;
                        button.setSelected(false);
                    }
                    break;
            }
        }
        if (this.v > 10) {
            return;
        }
        int i2 = this.v;
    }

    private boolean b(String str) {
        try {
            try {
                if (m.b(str, w.a)) {
                    chat.ola.vn.c.c_ = false;
                    finish();
                    if (a != null) {
                        a.a();
                    }
                    return true;
                }
                this.v++;
                chat.ola.vn.util.c.b.a((Context) this, 1000L);
                this.t = "";
                b();
                if (this.b != null) {
                    this.c.startAnimation(this.b);
                    this.b.setAnimationListener(this);
                }
                return false;
            } catch (Throwable unused) {
                return true;
            }
        } catch (Throwable unused2) {
            chat.ola.vn.c.c_ = false;
            finish();
            if (a != null) {
                a.a();
            }
            return true;
        }
    }

    @Override // android.view.animation.Animation.AnimationListener
    public void onAnimationEnd(Animation animation) {
        this.u = true;
        a(this.u);
    }

    @Override // android.view.animation.Animation.AnimationListener
    public void onAnimationRepeat(Animation animation) {
    }

    @Override // android.view.animation.Animation.AnimationListener
    public void onAnimationStart(Animation animation) {
        this.u = false;
        a(this.u);
    }

    @Override // android.app.Activity
    public void onBackPressed() {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        String str;
        try {
            int id = view.getId();
            if (id == R.id.deleteButton) {
                a();
                return;
            }
            switch (id) {
                case R.id.number0Button /* 2131297159 */:
                    str = AppEventsConstants.EVENT_PARAM_VALUE_NO;
                    break;
                case R.id.number1Button /* 2131297160 */:
                    str = "1";
                    break;
                case R.id.number2Button /* 2131297161 */:
                    str = "2";
                    break;
                case R.id.number3Button /* 2131297162 */:
                    str = "3";
                    break;
                case R.id.number4Button /* 2131297163 */:
                    str = "4";
                    break;
                case R.id.number5Button /* 2131297164 */:
                    str = "5";
                    break;
                case R.id.number6Button /* 2131297165 */:
                    str = "6";
                    break;
                case R.id.number7Button /* 2131297166 */:
                    str = "7";
                    break;
                case R.id.number8Button /* 2131297167 */:
                    str = "8";
                    break;
                case R.id.number9Button /* 2131297168 */:
                    str = "9";
                    break;
                default:
                    return;
            }
            a(str);
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_locked_screen_layout);
        try {
            this.b = AnimationUtils.loadAnimation(this, R.anim.shake);
            this.b.setDuration(1000L);
        } catch (Throwable unused) {
            this.b = null;
        }
        this.c = findViewById(R.id.passCodeCheckViewLayout);
        this.d = (Button) findViewById(R.id.passCodeCheck1);
        this.e = (Button) findViewById(R.id.passCodeCheck2);
        this.f = (Button) findViewById(R.id.passCodeCheck3);
        this.g = (Button) findViewById(R.id.passCodeCheck4);
        this.h = (Button) findViewById(R.id.number0Button);
        this.h.setOnClickListener(this);
        this.i = (Button) findViewById(R.id.number1Button);
        this.i.setOnClickListener(this);
        this.j = (Button) findViewById(R.id.number2Button);
        this.j.setOnClickListener(this);
        this.k = (Button) findViewById(R.id.number3Button);
        this.k.setOnClickListener(this);
        this.l = (Button) findViewById(R.id.number4Button);
        this.l.setOnClickListener(this);
        this.m = (Button) findViewById(R.id.number5Button);
        this.m.setOnClickListener(this);
        this.n = (Button) findViewById(R.id.number6Button);
        this.n.setOnClickListener(this);
        this.o = (Button) findViewById(R.id.number7Button);
        this.o.setOnClickListener(this);
        this.p = (Button) findViewById(R.id.number8Button);
        this.p.setOnClickListener(this);
        this.q = (Button) findViewById(R.id.number9Button);
        this.q.setOnClickListener(this);
        this.s = findViewById(R.id.deleteButton);
        this.s.setOnClickListener(this);
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        OlaApplication.a((Activity) this);
        try {
            if (w == null || m.a(w.a)) {
                chat.ola.vn.c.c_ = false;
                finish();
            }
        } catch (Throwable unused) {
        }
    }
}
