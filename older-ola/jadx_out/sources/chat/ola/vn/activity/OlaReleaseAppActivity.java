package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.View;
import android.widget.Button;
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.VideoView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.e;
import chat.ola.vn.entity.ai;
import chat.ola.vn.entity.k;
import chat.ola.vn.h;
import chat.ola.vn.p.o;
import chat.ola.vn.util.a;
import chat.ola.vn.util.b;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import chat.ola.vn.x.d;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.InterstitialAd;
import com.mg.ola.common.d.g;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaReleaseAppActivity extends c implements View.OnClickListener {
    private static InterstitialAd A = null;
    private static boolean B = false;
    private static long C;
    public static k e;
    private static long x;
    private static Long y;
    private static int z;
    OlaCachedImageView f;
    TextView g;
    RatingBar h;
    TextView i;
    Button j;
    OlaRatioImageView k;
    View l;
    OlaRatioImageView m;
    VideoView n;
    View o;
    View p;
    TextView q;
    TextView r;
    Button s;
    private CountDownTimer u;
    private TextView w;
    private boolean t = false;
    private String v = null;

    private static void D() {
        if (System.currentTimeMillis() - C >= 180000 || !B) {
            A.loadAd(new AdRequest.Builder().build());
            C = System.currentTimeMillis();
        }
    }

    private void E() {
        try {
            this.f = (OlaCachedImageView) findViewById(R.id.imgGameAvatar);
            this.g = (TextView) findViewById(R.id.txtGameTitle);
            this.h = (RatingBar) findViewById(R.id.ratingBar);
            this.i = (TextView) findViewById(R.id.txtNumberRate);
            this.j = (Button) findViewById(R.id.btnFree);
            this.j.setOnClickListener(this);
            findViewById(R.id.vFrameContent).setOnClickListener(this);
            this.k = (OlaRatioImageView) findViewById(R.id.imgGameScreenShot);
            this.l = findViewById(R.id.linearYoutubeSpan);
            this.m = (OlaRatioImageView) findViewById(R.id.imgMeYoutubeThumbnail1);
            this.n = (VideoView) findViewById(R.id.autoPlayVideoView);
            this.o = findViewById(R.id.autoPlayVideoViewLoading);
            this.p = findViewById(R.id.gameLoadingProgressBar);
            this.q = (TextView) findViewById(R.id.txtGameType);
            this.r = (TextView) findViewById(R.id.txtGameDescript);
            this.s = (Button) findViewById(R.id.btnInstall);
            this.s.setOnClickListener(this);
            this.w = (TextView) findViewById(R.id.btnClose);
            this.w.setClickable(true);
            this.w.setOnClickListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void F() {
        String str;
        String strF;
        try {
            if (e == null) {
                return;
            }
            if (m.a(e.m)) {
                str = e.h;
                strF = m.f(e.h);
                if (m.a(strF)) {
                    startActivity(new Intent("android.intent.action.VIEW", Uri.parse(e.h)));
                } else {
                    b.j(this, strF);
                }
            } else {
                str = "https://play.google.com/store/apps/details?id=" + e.m + "&rdid=" + e.m;
                if (b.k(this, e.m)) {
                    b.i(this, e.m);
                } else {
                    strF = e.m;
                    b.j(this, strF);
                }
            }
            String str2 = e.i;
            if (!m.a(str2)) {
                str = str2;
            }
            if (System.currentTimeMillis() - x >= 3600000) {
                x = System.currentTimeMillis();
                String[] stringArray = getResources().getStringArray(R.array.message_like_this_game);
                String str3 = String.format(stringArray[(int) (System.currentTimeMillis() % ((long) stringArray.length))], e.a);
                OlaApplication.b.a(str3 + "\n" + str, e.k, (short) 0, (short) 16385, (String) null, (String) null, (short) 0);
                if (m.a(e.g)) {
                    return;
                }
                OlaApplication.b.l(e.g, "wap");
            }
        } catch (Throwable unused) {
        }
    }

    private void G() {
        try {
            if (e == null) {
                finish();
                return;
            }
            this.g.setText(e.a);
            this.r.setText(e.f);
            this.h.setRating(e.n.floatValue());
            this.i.setText(e.l);
            this.q.setText(e.e);
            C();
            if (m.a(e.b)) {
                this.k.setVisibility(0);
                this.l.setVisibility(8);
                B();
            } else {
                this.k.setVisibility(8);
                this.l.setVisibility(0);
                H();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void H() {
        this.l.setOnClickListener(this);
        if (this.n != null) {
            this.n.setOnClickListener(this);
        }
        I();
    }

    @TargetApi(11)
    private void I() {
        if (e.b == null) {
            this.m.setVisibility(8);
            return;
        }
        try {
            String str = "http://img.youtube.com/vi/" + e.b + "/mqdefault.jpg";
            if (this.m.getWidth() > 400 || h.I) {
                str = "http://img.youtube.com/vi/" + e.b + "/hqdefault.jpg";
            }
            t.a().b(str, this.m, this.p);
            if (e.c != null) {
                f(e.b);
            } else {
                OlaApplication.b.a(e.b, new o() { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.4
                    @Override // chat.ola.vn.p.o
                    public void a() {
                        OlaReleaseAppActivity.e.c = "";
                    }

                    @Override // chat.ola.vn.p.o
                    public void a(ai aiVar) {
                        try {
                            if (m.b(OlaReleaseAppActivity.e.b, aiVar.c)) {
                                if (m.a(aiVar.a)) {
                                    OlaReleaseAppActivity.e.c = "";
                                } else {
                                    OlaReleaseAppActivity.e.c = aiVar.a;
                                }
                                if (m.a(OlaReleaseAppActivity.e.c)) {
                                    return;
                                }
                                OlaReleaseAppActivity.this.f(OlaReleaseAppActivity.e.b);
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                });
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        try {
            if (h.H > 0) {
                return;
            }
            if (A == null) {
                A = new InterstitialAd(OlaApplication.a());
                A.setAdUnitId(a.a(3));
            }
            A.setAdListener(new AdListener() { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.2
                @Override // com.google.android.gms.ads.AdListener
                public void onAdClosed() {
                    super.onAdClosed();
                    boolean unused = OlaReleaseAppActivity.B = false;
                }

                @Override // com.google.android.gms.ads.AdListener
                public void onAdFailedToLoad(int i) {
                    super.onAdFailedToLoad(i);
                    boolean unused = OlaReleaseAppActivity.B = false;
                }

                @Override // com.google.android.gms.ads.AdListener
                public void onAdLeftApplication() {
                    super.onAdLeftApplication();
                    boolean unused = OlaReleaseAppActivity.B = false;
                }

                @Override // com.google.android.gms.ads.AdListener
                public void onAdLoaded() {
                    super.onAdLoaded();
                    boolean unused = OlaReleaseAppActivity.B = true;
                }

                @Override // com.google.android.gms.ads.AdListener
                public void onAdOpened() {
                    super.onAdOpened();
                }
            });
            if (y == null) {
                y = Long.valueOf(e.a().c());
            }
            z++;
            if (System.currentTimeMillis() - y.longValue() >= 300000) {
                if (z >= 10) {
                    z = 0;
                    y = Long.valueOf(System.currentTimeMillis());
                    e.a().a(y.longValue());
                    A.show();
                }
                D();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @SuppressLint({"NewApi"})
    public void f(String str) {
        try {
            if (this.n == null || m.a(str)) {
                return;
            }
            if (!h.I) {
                this.k.setVisibility(0);
                this.l.setVisibility(8);
                B();
                return;
            }
            if (!m.b(this.v, str)) {
                try {
                    this.n.stopPlayback();
                    this.v = null;
                } catch (Throwable unused) {
                }
                this.n.setVisibility(8);
            }
            if (this.n.getVisibility() != 0 && !m.b(this.v, str)) {
                this.m.setVisibility(0);
                if (this.o != null) {
                    this.o.setVisibility(0);
                }
                try {
                    if (g.g()) {
                        this.n.setBackground(null);
                    } else {
                        this.n.setBackgroundDrawable(null);
                    }
                } catch (Throwable unused2) {
                }
                this.v = str;
                chat.ola.vn.x.a aVar = new chat.ola.vn.x.a();
                aVar.a(new d() { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.3
                    @Override // chat.ola.vn.x.d
                    public void a(String str2) {
                        try {
                            OlaReleaseAppActivity.this.n.setVisibility(8);
                            OlaReleaseAppActivity.this.m.setVisibility(0);
                            if (OlaReleaseAppActivity.this.o != null) {
                                OlaReleaseAppActivity.this.o.setVisibility(8);
                            }
                            OlaReleaseAppActivity.this.k.setVisibility(0);
                            OlaReleaseAppActivity.this.l.setVisibility(8);
                            OlaReleaseAppActivity.this.B();
                        } catch (Throwable unused3) {
                        }
                        OlaReleaseAppActivity.this.v = null;
                    }

                    @Override // chat.ola.vn.x.d
                    public void a(String str2, List<chat.ola.vn.x.c> list) {
                        if (list != null) {
                            try {
                                if (list.size() > 0) {
                                    chat.ola.vn.x.c cVar = null;
                                    Iterator<chat.ola.vn.x.c> it2 = list.iterator();
                                    while (true) {
                                        if (!it2.hasNext()) {
                                            break;
                                        }
                                        chat.ola.vn.x.c next = it2.next();
                                        if (next.d == 1280) {
                                            cVar = next;
                                            break;
                                        }
                                    }
                                    if (cVar == null) {
                                        cVar = list.get(0);
                                    }
                                    OlaReleaseAppActivity.this.n.setVisibility(0);
                                    try {
                                        if (g.g()) {
                                            OlaReleaseAppActivity.this.n.setBackground(OlaReleaseAppActivity.this.m.getDrawable());
                                        } else {
                                            OlaReleaseAppActivity.this.n.setBackgroundDrawable(OlaReleaseAppActivity.this.m.getDrawable());
                                        }
                                    } catch (Throwable unused3) {
                                        OlaReleaseAppActivity.this.n.setBackgroundColor(0);
                                    }
                                    OlaReleaseAppActivity.this.n.setVideoURI(Uri.parse(cVar.b));
                                    OlaReleaseAppActivity.this.n.setOnErrorListener(new MediaPlayer.OnErrorListener() { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.3.1
                                        @Override // android.media.MediaPlayer.OnErrorListener
                                        public boolean onError(MediaPlayer mediaPlayer, int i, int i2) {
                                            try {
                                                OlaReleaseAppActivity.this.n.setVisibility(8);
                                                OlaReleaseAppActivity.this.m.setVisibility(0);
                                                if (OlaReleaseAppActivity.this.o != null) {
                                                    OlaReleaseAppActivity.this.o.setVisibility(8);
                                                }
                                                OlaReleaseAppActivity.this.k.setVisibility(0);
                                                OlaReleaseAppActivity.this.l.setVisibility(8);
                                                OlaReleaseAppActivity.this.B();
                                            } catch (Throwable unused4) {
                                            }
                                            OlaReleaseAppActivity.this.v = null;
                                            return false;
                                        }
                                    });
                                    OlaReleaseAppActivity.this.n.setOnPreparedListener(new MediaPlayer.OnPreparedListener() { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.3.2
                                        @Override // android.media.MediaPlayer.OnPreparedListener
                                        public void onPrepared(MediaPlayer mediaPlayer) {
                                            try {
                                                float f = x.e() ? 1.0f : 0.0f;
                                                mediaPlayer.setVolume(f, f);
                                            } catch (Throwable unused4) {
                                            }
                                            try {
                                                if (OlaReleaseAppActivity.this.o != null) {
                                                    OlaReleaseAppActivity.this.o.setVisibility(8);
                                                }
                                                OlaReleaseAppActivity.this.n.setBackgroundColor(0);
                                                OlaReleaseAppActivity.this.n.setVisibility(0);
                                                OlaReleaseAppActivity.this.m.setVisibility(4);
                                            } catch (Throwable th) {
                                                th.printStackTrace();
                                            }
                                        }
                                    });
                                    OlaReleaseAppActivity.this.n.setOnCompletionListener(new MediaPlayer.OnCompletionListener() { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.3.3
                                        @Override // android.media.MediaPlayer.OnCompletionListener
                                        public void onCompletion(MediaPlayer mediaPlayer) {
                                            try {
                                                if (OlaReleaseAppActivity.this.o != null) {
                                                    OlaReleaseAppActivity.this.o.setVisibility(8);
                                                }
                                                OlaReleaseAppActivity.this.n.setVisibility(8);
                                                OlaReleaseAppActivity.this.m.setVisibility(0);
                                                OlaReleaseAppActivity.this.k.setVisibility(0);
                                                OlaReleaseAppActivity.this.l.setVisibility(8);
                                                OlaReleaseAppActivity.this.B();
                                            } catch (Throwable th) {
                                                th.printStackTrace();
                                            }
                                        }
                                    });
                                    OlaReleaseAppActivity.this.n.start();
                                }
                            } catch (Throwable unused4) {
                            }
                        }
                    }
                });
                aVar.execute(str);
                return;
            }
            this.n.setVisibility(0);
            if (this.n.isPlaying()) {
                return;
            }
            if (this.o != null) {
                this.o.setVisibility(0);
            }
            try {
                if (g.g()) {
                    this.n.setBackground(this.m.getDrawable());
                } else {
                    this.n.setBackgroundDrawable(this.m.getDrawable());
                }
            } catch (Throwable unused3) {
                this.n.setBackgroundColor(0);
            }
            this.n.seekTo(0);
            this.n.start();
        } catch (Throwable unused4) {
        }
    }

    public void B() {
        if (m.a(e.k)) {
            this.k.setVisibility(8);
        } else {
            this.k.setVisibility(0);
            t.a().b(e.k, this.k, this.p, e.c);
        }
    }

    public void C() {
        if (m.a(e.j)) {
            this.f.setVisibility(8);
        } else {
            this.f.setVisibility(0);
            t.a().a(e.j, this.f);
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            this.t = false;
            this.u.start();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.t) {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnClose) {
                if (this.t) {
                    finish();
                }
            } else if (id == R.id.btnFree || id == R.id.btnInstall || id == R.id.vFrameContent) {
                F();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.game_intro_layout);
        this.t = false;
        E();
        G();
        this.u = new CountDownTimer(5000L, 1000L) { // from class: chat.ola.vn.activity.OlaReleaseAppActivity.1
            @Override // android.os.CountDownTimer
            public void onFinish() {
                OlaReleaseAppActivity.this.t = true;
                OlaReleaseAppActivity.this.w.setText("X");
            }

            @Override // android.os.CountDownTimer
            public void onTick(long j) {
                OlaReleaseAppActivity.this.w.setText(((int) Math.ceil(j / 1000)) + "");
            }
        };
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        try {
            this.u.cancel();
            this.u = null;
        } catch (Throwable unused) {
        }
    }
}
