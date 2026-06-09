package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.widget.ProgressBar;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.message.t;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.Timer;
import java.util.TimerTask;

/* JADX INFO: loaded from: classes.dex */
public class OlaSnapPicViewerActivity extends c {
    static t e;
    protected OlaCachedImageView f;
    protected ProgressBar g;
    private Timer h;
    private long i = 0;

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        if (e.d() != 1) {
            this.g.setVisibility(8);
            return;
        }
        if (this.g.getVisibility() != 0) {
            this.g.setVisibility(0);
        }
        this.h = new Timer();
        this.g.setMax(e.D());
        this.g.setProgress(e.C());
        this.g.setVisibility(0);
        this.i = System.currentTimeMillis();
        this.h.scheduleAtFixedRate(new TimerTask() { // from class: chat.ola.vn.activity.OlaSnapPicViewerActivity.2
            @Override // java.util.TimerTask, java.lang.Runnable
            public void run() {
                int iCurrentTimeMillis = (int) ((System.currentTimeMillis() - OlaSnapPicViewerActivity.this.i) / 1000);
                if (iCurrentTimeMillis > 0) {
                    long jC = OlaSnapPicViewerActivity.e.C() - iCurrentTimeMillis;
                    if (jC <= 0) {
                        OlaSnapPicViewerActivity.e.d((short) 0);
                        OlaSnapPicViewerActivity.this.finish();
                        return;
                    }
                    OlaSnapPicViewerActivity.this.i = System.currentTimeMillis();
                    int i = (int) jC;
                    OlaSnapPicViewerActivity.this.g.setProgress(i);
                    OlaSnapPicViewerActivity.e.d((short) i);
                }
            }
        }, 0L, 500L);
    }

    public static void a(Context context, t tVar) {
        e = tVar;
        Intent intent = new Intent(context, (Class<?>) OlaSnapPicViewerActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaSnapPicViewerActivity.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    String strA = OlaSnapPicViewerActivity.e.a();
                    OlaSnapPicViewerActivity.this.f.a(null, null);
                    OlaSnapPicViewerActivity.this.f.setLoadingUrl(strA);
                    chat.ola.vn.c.t.a().e(strA, OlaSnapPicViewerActivity.this.f);
                    OlaSnapPicViewerActivity.this.B();
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        try {
            this.h.cancel();
            this.h = null;
        } catch (Throwable unused) {
        }
        super.finish();
        try {
            overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.snap_pic_viewer_layout);
        this.f = (OlaCachedImageView) findViewById(R.id.olaSnapImageView);
        this.g = (ProgressBar) findViewById(R.id.timeRemainProgress);
    }
}
