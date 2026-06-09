package chat.ola.vn.entry.b;

import android.graphics.Color;
import android.view.View;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.service.OlaVoiceChatService;

/* JADX INFO: loaded from: classes.dex */
public class ah extends f implements View.OnClickListener {
    protected ProgressBar t;
    protected ProgressBar u;
    protected View v;
    protected TextView w;
    protected ImageView x;
    protected View y;
    private chat.ola.vn.message.aa z;

    public ah(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (ProgressBar) view.findViewById(R.id.voiceDurationProgressBar);
        this.u = (ProgressBar) view.findViewById(R.id.soundLoadingProgressBar);
        this.t.setProgress(0);
        this.w = (TextView) view.findViewById(R.id.voiceDurationTextView);
        this.x = (ImageView) view.findViewById(R.id.voicePlayIconImageView);
        this.y = view.findViewById(R.id.voiceLineView);
        this.v = view.findViewById(R.id.voiceChatViewLayout);
        this.v.setOnClickListener(this);
        try {
            this.i.setVisibility(8);
            this.e = 0;
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.message.aa aaVar) {
        OlaVoiceChatService.a(chat.ola.vn.c.c(), aaVar);
    }

    private void b(chat.ola.vn.message.aa aaVar) {
        OlaVoiceChatService.a(aaVar);
    }

    private void g() {
        ImageView imageView;
        int i;
        TextView textView;
        int i2;
        long jLongValue;
        long jLongValue2;
        TextView textView2;
        String strA;
        ImageView imageView2;
        int i3;
        this.z.C = this;
        this.v.setTag(this.z);
        if (this.z.d() == 1) {
            this.t.setProgressDrawable(this.d.getResources().getDrawable(R.drawable.incomming_voice_playback_progress));
            if (this.z.D()) {
                imageView2 = this.x;
                i3 = R.drawable.ic_pause_media_gray;
            } else {
                imageView2 = this.x;
                i3 = R.drawable.ic_play_media_gray;
            }
            imageView2.setImageResource(i3);
            this.y.setBackgroundColor(Color.parseColor("#8f8f8f"));
            this.w.setTextColor(chat.ola.vn.f.g);
            textView = this.w;
            i2 = R.drawable.incomming_voice_duration_bg;
        } else {
            this.t.setProgressDrawable(this.d.getResources().getDrawable(R.drawable.outgoing_voice_playback_progress));
            if (this.z.D()) {
                imageView = this.x;
                i = R.drawable.ic_pause_media;
            } else {
                imageView = this.x;
                i = R.drawable.ic_play_media;
            }
            imageView.setImageResource(i);
            this.y.setBackgroundColor(chat.ola.vn.f.g);
            this.w.setTextColor(chat.ola.vn.f.h);
            textView = this.w;
            i2 = R.drawable.outgoing_voice_duration_bg;
        }
        textView.setBackgroundResource(i2);
        if (this.z.A != null) {
            jLongValue = this.z.A.longValue();
            this.t.setMax((int) jLongValue);
        } else {
            jLongValue = 0;
        }
        if (this.z.B != null) {
            jLongValue2 = this.z.B.longValue();
            this.t.setProgress((int) jLongValue2);
        } else {
            jLongValue2 = 0;
        }
        long j = (jLongValue - jLongValue2) / 1000;
        if (jLongValue > 0) {
            textView2 = this.w;
            strA = com.mg.ola.common.d.i.a((int) j, ":", ":");
        } else {
            textView2 = this.w;
            strA = "-:--";
        }
        textView2.setText(strA);
        if (this.z.E()) {
            this.u.setVisibility(0);
            this.w.setVisibility(8);
        } else {
            this.u.setVisibility(8);
            this.w.setVisibility(0);
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        super.a(dVar, dVar2, dVar3);
        if (this.z != null) {
            this.z.C = null;
        }
        this.z = (chat.ola.vn.message.aa) dVar;
        g();
    }

    public void a(String str) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String str, int i, int i2) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String str, String str2) {
        try {
            if (chat.ola.vn.util.m.b(this.z.C(), str)) {
                g();
                a(this.z);
            }
        } catch (Throwable unused) {
        }
    }

    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void b(String str, int i, int i2) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void b(String str, String str2) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                this.u.setVisibility(8);
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void c(String str) {
        try {
            if (chat.ola.vn.util.m.b(this.z.C(), str)) {
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void c(String str, int i, int i2) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void d(String str) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                this.u.setVisibility(8);
                g();
            }
        } catch (Throwable unused) {
        }
    }

    public void d(String str, int i, int i2) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                this.u.setVisibility(8);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f
    protected void e() {
        super.e();
        this.k.setBackgroundResource(0);
        this.k.setPadding(this.e, this.e, this.e, this.e);
    }

    public void e(String str) {
        try {
            if (chat.ola.vn.util.m.b(this.z.a(), str)) {
                this.u.setVisibility(8);
                g();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.voiceChatViewLayout) {
                return;
            }
            chat.ola.vn.message.aa aaVar = (chat.ola.vn.message.aa) view.getTag();
            aaVar.g();
            if (aaVar.D()) {
                b(aaVar);
            } else if (!chat.ola.vn.util.m.a(aaVar.a()) || chat.ola.vn.util.m.a(aaVar.C())) {
                a(aaVar);
            } else {
                aaVar.F();
            }
        } catch (Throwable unused) {
        }
    }
}
