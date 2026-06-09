package chat.ola.vn.game.caro;

import android.content.DialogInterface;
import android.graphics.Point;
import android.os.Bundle;
import android.view.View;
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.e;
import chat.ola.vn.game.caro.d;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.message.f;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class CaroActivity extends chat.ola.vn.c implements View.OnClickListener, c, d.a {
    private static String q;
    private static TextView r;
    int e;
    int f;
    int g;
    int h;
    int[] i = {0, -1, -1, -1};
    int[] j = {-1, -1, 0, 1};
    int k;
    private ScrollView l;
    private HorizontalScrollView m;
    private LinearLayout n;
    private d o;
    private b p;

    private void D() {
        try {
            setContentView(R.layout.caro_activity_layout);
            this.n = (LinearLayout) findViewById(R.id.vContentViewCaro);
            this.l = (ScrollView) findViewById(R.id.scrollViewCaro);
            this.m = (HorizontalScrollView) findViewById(R.id.horizontalScrollViewCaro);
            this.o = new d(this);
            r = (TextView) findViewById(R.id.txtActionTitle);
            findViewById(R.id.imgBack).setOnClickListener(this);
            findViewById(R.id.imgIcon).setOnClickListener(this);
            findViewById(R.id.btnClose).setOnClickListener(this);
            findViewById(R.id.btnReplay).setOnClickListener(this);
            try {
                this.o.c(getIntent().getIntExtra("row", 0), getIntent().getIntExtra("col", 0));
            } catch (Throwable th) {
                th.printStackTrace();
            }
            this.n.addView(this.o);
            this.o.setCaroViewListener(this);
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    private void E() {
        f fVarD;
        try {
            if (m.c(q) || (fVarD = h.t.d(q, (short) 0)) == null) {
                return;
            }
            r.setText(m.c(fVarD.b()) ? fVarD.j() : fVarD.b());
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        try {
            if (this.p != null) {
                this.o.setXList(this.p.c());
                this.o.setOList(this.p.d());
                try {
                    if (this.p.e() != null) {
                        Point point = new Point(this.p.e().d * d.a, this.p.e().c * d.a);
                        this.o.a(point);
                        c(point.x, point.y);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                this.o.invalidate();
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void G() {
        try {
            if (OlaApplication.b != null) {
                OlaApplication.b.t(q, (short) 2);
                i.a(this, R.string.message_inform, R.string.string_sending_a_caro_game_invitation);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void c(int i, int i2) {
        try {
            final int i3 = i - (e.c / 2);
            if (i3 < 0) {
                i3 = 0;
            }
            final int i4 = i2 - (e.d / 2);
            if (i4 < 0) {
                i4 = 0;
            }
            this.l.post(new Runnable() { // from class: chat.ola.vn.game.caro.CaroActivity.1
                @Override // java.lang.Runnable
                public void run() {
                    CaroActivity.this.l.scrollTo(i3, i4);
                }
            });
            this.m.post(new Runnable() { // from class: chat.ola.vn.game.caro.CaroActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    CaroActivity.this.m.scrollTo(i3, i4);
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.game.caro.c
    public void B() {
        finish();
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            this.p = h.t.d(q, (short) 0).Q();
            if (this.p != null) {
                this.p.a(this);
                F();
            }
            E();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.game.caro.d.a
    public void a(int i, int i2) {
        try {
            if (this.p.g()) {
                return;
            }
            this.p.a(i, i2, this.p.f() ? a.b : a.a);
            if (OlaApplication.b != null) {
                OlaApplication.b.a(q, (short) 2, (int[]) null, new int[]{i, i2});
                this.p.b(true);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.game.caro.c
    public void a(a aVar) {
        int i;
        int i2;
        try {
            this.o.a(aVar);
            if (this.p.e() != null) {
                Point point = new Point(this.p.e().d * d.a, this.p.e().c * d.a);
                if (!this.o.b(point.x, point.y)) {
                    c(point.x, point.y);
                }
                if (b(aVar.d, aVar.c)) {
                    this.o.a(this.e, this.f, this.g, this.h);
                    DialogInterface.OnClickListener onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.game.caro.CaroActivity.3
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i3) {
                            try {
                                switch (i3) {
                                    case 0:
                                        CaroActivity.this.G();
                                        break;
                                    case 1:
                                        h.t.d(CaroActivity.q, (short) 0).R();
                                        if (OlaApplication.b != null) {
                                            OlaApplication.b.s(CaroActivity.q, (short) 2);
                                        }
                                        break;
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                            dialogInterface.dismiss();
                        }
                    };
                    if (this.p.l() == this.k) {
                        i = R.string.message_inform;
                        i2 = R.string.message_you_win_and_play_again;
                    } else {
                        i = R.string.message_inform;
                        i2 = R.string.message_you_lose_and_play_again;
                    }
                    i.a(this, i, i2, R.string.string_play, R.string.string_quit, onClickListener);
                }
            }
        } catch (Throwable unused) {
        }
    }

    int[] a(int i, int i2, int i3) {
        int[] iArr = new int[10];
        int i4 = i;
        int i5 = i2;
        for (int i6 = 4; i6 >= 0; i6--) {
            i4 += this.i[i3];
            i5 += this.j[i3];
            if (i4 < 0 || i5 < 0 || i4 >= this.p.b() || i5 >= this.p.a()) {
                iArr[i6] = -1;
            } else {
                iArr[i6] = this.p.k()[i5][i4];
            }
        }
        for (int i7 = 5; i7 <= 9; i7++) {
            i -= this.i[i3];
            i2 -= this.j[i3];
            if (i < 0 || i2 < 0 || i >= this.p.b() || i2 >= this.p.a()) {
                iArr[i7] = -1;
            } else {
                iArr[i7] = this.p.k()[i2][i];
            }
        }
        return iArr;
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void b(String str, int i) {
        super.b(str, i);
        if (m.b(q, str)) {
            i.a(this, R.string.message_inform, R.string.message_play_again, R.string.string_ok, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.game.caro.CaroActivity.5
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    try {
                        switch (i2) {
                            case 0:
                                h.t.d(CaroActivity.q, (short) 0).Q().j();
                                CaroActivity.this.p = h.t.d(CaroActivity.q, (short) 0).Q();
                                CaroActivity.this.F();
                                if (OlaApplication.b != null) {
                                    OlaApplication.b.u(CaroActivity.q, (short) 2);
                                }
                                CaroActivity.this.o.a();
                                break;
                            case 1:
                                if (OlaApplication.b != null) {
                                    OlaApplication.b.v(CaroActivity.q, (short) 2);
                                }
                                h.t.d(CaroActivity.q, (short) 0).Q().h();
                                break;
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                    dialogInterface.dismiss();
                }
            });
        }
    }

    boolean b(int i, int i2) {
        int i3;
        int i4 = this.p.k()[i2][i];
        int i5 = 0;
        do {
            int[] iArrA = a(i, i2, i5);
            this.f = i;
            this.e = i2;
            this.h = i;
            this.g = i2;
            int i6 = 1;
            for (int i7 = 4; i7 >= 0 && iArrA[i7] == i4 && i4 != 0; i7--) {
                this.h += this.i[i5];
                this.g += this.j[i5];
                i6++;
            }
            i3 = i6;
            for (int i8 = 5; i8 <= 9 && iArrA[i8] == i4 && i4 != 0; i8++) {
                this.f -= this.i[i5];
                this.e -= this.j[i5];
                i3++;
            }
            i5++;
            if (i5 >= 4) {
                break;
            }
        } while (i3 < 5);
        if (i3 < 5) {
            return false;
        }
        this.k = i4;
        return true;
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void c(String str, int i) {
        super.c(str, i);
        if (m.b(q, str)) {
            i.a(this, R.string.message_inform, R.string.message_accept_play_game_again);
            h.t.d(q, (short) 0).Q().j();
            this.o.a();
            this.p = h.t.d(q, (short) 0).Q();
            this.p.b(false);
            F();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void d(String str, int i) {
        super.d(str, i);
        if (m.b(q, str)) {
            i.a(this, R.string.message_inform, R.string.message_reject_play_game_again);
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnClose) {
                i.a(this, R.string.message_inform, R.string.message_do_you_want_to_quit_game, R.string.string_ok, R.string.string_cancel, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.game.caro.CaroActivity.4
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                h.t.d(CaroActivity.q, (short) 0).R();
                                if (OlaApplication.b != null) {
                                    OlaApplication.b.s(CaroActivity.q, (short) 2);
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
                return;
            }
            if (id == R.id.btnReplay) {
                G();
            } else if (id == R.id.imgBack || id == R.id.imgIcon) {
                finish();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        D();
        E();
        if (OlaApplication.b != null) {
            OlaApplication.b.a(this);
        }
    }
}
