package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.content.Context;
import android.media.MediaRecorder;
import android.os.Handler;
import android.util.AttributeSet;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaAttachmentVoiceButton;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class j extends d implements View.OnClickListener, OlaAttachmentVoiceButton.a {
    MediaRecorder a;
    OlaAttachmentVoiceButton b;
    TextView c;
    TextView d;
    TextView e;
    public TextView f;
    protected a g;
    private Animation h;
    private Animation i;
    private Handler j;
    private String k;
    private long l;
    private Runnable m;
    private File n;

    public interface a {
        void l(String str);
    }

    public j(Context context) {
        super(context);
        this.a = null;
        this.k = "0:00";
        this.f = null;
        this.l = 0L;
        this.m = new Runnable() { // from class: chat.ola.vn.view.j.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (j.this.l > 0) {
                        long jCurrentTimeMillis = (System.currentTimeMillis() - j.this.l) / 1000;
                        j.this.k = com.mg.ola.common.d.i.a(jCurrentTimeMillis, ":", ":");
                        if (j.this.f != null) {
                            j.this.f.setText(j.this.k);
                        }
                        j.this.j.postDelayed(j.this.m, 500L);
                    }
                } catch (Throwable unused) {
                }
            }
        };
        a(context);
    }

    public j(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = null;
        this.k = "0:00";
        this.f = null;
        this.l = 0L;
        this.m = new Runnable() { // from class: chat.ola.vn.view.j.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (j.this.l > 0) {
                        long jCurrentTimeMillis = (System.currentTimeMillis() - j.this.l) / 1000;
                        j.this.k = com.mg.ola.common.d.i.a(jCurrentTimeMillis, ":", ":");
                        if (j.this.f != null) {
                            j.this.f.setText(j.this.k);
                        }
                        j.this.j.postDelayed(j.this.m, 500L);
                    }
                } catch (Throwable unused) {
                }
            }
        };
        a(context);
    }

    public j(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = null;
        this.k = "0:00";
        this.f = null;
        this.l = 0L;
        this.m = new Runnable() { // from class: chat.ola.vn.view.j.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (j.this.l > 0) {
                        long jCurrentTimeMillis = (System.currentTimeMillis() - j.this.l) / 1000;
                        j.this.k = com.mg.ola.common.d.i.a(jCurrentTimeMillis, ":", ":");
                        if (j.this.f != null) {
                            j.this.f.setText(j.this.k);
                        }
                        j.this.j.postDelayed(j.this.m, 500L);
                    }
                } catch (Throwable unused) {
                }
            }
        };
        a(context);
    }

    private void a(Context context) {
        inflate(context, R.layout.ola_attachment_voice_tab_layout, this);
        try {
            this.h = AnimationUtils.loadAnimation(context, R.anim.fade_out);
            this.h.setDuration(300L);
            this.i = AnimationUtils.loadAnimation(context, R.anim.fade_in);
            this.i.setDuration(300L);
            this.b = (OlaAttachmentVoiceButton) findViewById(R.id.recordButton);
            this.d = (TextView) findViewById(R.id.recordButtonTextView);
            this.c = (TextView) findViewById(R.id.recordingDurationTextView);
            this.e = (TextView) findViewById(R.id.recordingTipTextView);
            this.e.setVisibility(8);
            this.b.a = this;
            this.j = new Handler();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @SuppressLint({"InlinedApi"})
    private void h() {
        MediaRecorder mediaRecorder;
        this.j.removeCallbacks(this.m);
        this.a = new MediaRecorder();
        int i = 1;
        this.a.setAudioSource(1);
        this.a.setOutputFormat(2);
        if (com.mg.ola.common.d.g.b()) {
            mediaRecorder = this.a;
            i = 3;
        } else {
            mediaRecorder = this.a;
        }
        mediaRecorder.setAudioEncoder(i);
        this.n = new File(chat.ola.vn.d.a(), ".record." + System.currentTimeMillis() + ".tmp");
        this.a.setOutputFile(this.n.getAbsolutePath());
        try {
            this.a.prepare();
            this.a.start();
            this.l = System.currentTimeMillis();
            this.j.post(this.m);
        } catch (Throwable th) {
            i();
            th.printStackTrace();
            this.a.reset();
            this.a.release();
            this.a = null;
        }
    }

    private void i() {
        this.c.setText(R.string.message_voice_recording_fail);
    }

    @Override // chat.ola.vn.view.OlaAttachmentVoiceButton.a
    public void b() {
        f();
        this.f = null;
        this.k = "0:00";
        this.c.setText(this.k);
        this.d.setText(R.string.string_record);
        if (this.e.getVisibility() != 8) {
            this.h.cancel();
            this.e.startAnimation(this.h);
            this.e.setVisibility(8);
        }
    }

    @Override // chat.ola.vn.view.OlaAttachmentVoiceButton.a
    public void c() {
        this.f = this.c;
        this.d.setText(R.string.string_record);
        if (this.e.getVisibility() != 0) {
            this.i.cancel();
            this.e.startAnimation(this.i);
            this.e.setVisibility(0);
        }
    }

    @Override // chat.ola.vn.view.OlaAttachmentVoiceButton.a
    public void d() {
        this.f = this.d;
        this.c.setText(R.string.message_voice_recording_release_cancel);
        if (this.e.getVisibility() != 8) {
            this.h.cancel();
            this.e.startAnimation(this.h);
            this.e.setVisibility(8);
        }
    }

    @Override // chat.ola.vn.view.OlaAttachmentVoiceButton.a
    public void e() {
        g();
        this.f = null;
        this.k = "0:00";
        this.c.setText(this.k);
        this.d.setText(R.string.string_record);
        if (this.e.getVisibility() != 8) {
            this.h.cancel();
            this.e.startAnimation(this.h);
            this.e.setVisibility(8);
        }
    }

    public void f() {
        this.j.removeCallbacks(this.m);
        try {
            this.a.stop();
        } catch (Throwable unused) {
        }
        if (this.l > 0) {
            try {
                if (System.currentTimeMillis() - this.l <= 1000) {
                    return;
                }
                if (this.g != null) {
                    this.g.l(this.n.getAbsolutePath());
                }
            } catch (Throwable unused2) {
            }
        }
        this.n = null;
    }

    public void g() {
        this.j.removeCallbacks(this.m);
        try {
            this.l = 0L;
            this.a.stop();
            this.a.reset();
            this.a.release();
            this.a = null;
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public a getOnVoiceRecordListener() {
        return this.g;
    }

    @Override // chat.ola.vn.view.OlaAttachmentVoiceButton.a
    public void n_() {
        h();
        this.k = "0:00";
        this.f = this.c;
        this.c.setText(this.k);
        this.d.setText(R.string.string_record);
        if (this.e.getVisibility() != 0) {
            this.i.cancel();
            this.e.startAnimation(this.i);
            this.e.setVisibility(0);
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.expandStorageImageView) {
            }
        } catch (Throwable unused) {
        }
    }

    public void setOnVoiceRecordListener(a aVar) {
        this.g = aVar;
    }
}
