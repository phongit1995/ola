package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class ai extends f implements View.OnClickListener {
    private View t;
    private OlaCachedImageView u;
    private TextView v;
    private TextView w;
    private View x;

    public ai(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = view.findViewById(R.id.imgMeYoutubeThumbnailPlayIcon);
        this.u = (OlaCachedImageView) view.findViewById(R.id.imgMeYoutubeThumbnail1);
        this.x = view.findViewById(R.id.meYouTubeInfo);
        this.v = (TextView) view.findViewById(R.id.meYouTubeTitle);
        this.w = (TextView) view.findViewById(R.id.meYouTubeDuration);
    }

    @TargetApi(11)
    private void a(final chat.ola.vn.message.ab abVar) {
        String str = "http://img.youtube.com/vi/" + abVar.c() + "/mqdefault.jpg";
        if (this.u.getWidth() > 400) {
            str = "http://img.youtube.com/vi/" + abVar.c() + "/hqdefault.jpg";
        }
        chat.ola.vn.c.t.a().a(str, this.u);
        try {
            this.t.setVisibility(0);
        } catch (Throwable unused) {
        }
        if (abVar.a() != null) {
            this.x.setVisibility(0);
            this.v.setText(abVar.a());
            this.w.setText(abVar.C());
        } else {
            this.x.setVisibility(8);
            this.v.setText("");
            this.w.setText("");
            try {
                OlaApplication.b.a(abVar.c(), new chat.ola.vn.p.o() { // from class: chat.ola.vn.entry.b.ai.1
                    @Override // chat.ola.vn.p.o
                    public void a() {
                        abVar.a("");
                    }

                    @Override // chat.ola.vn.p.o
                    public void a(chat.ola.vn.entity.ai aiVar) {
                        chat.ola.vn.message.ab abVar2;
                        String str2;
                        TextView textView;
                        String strC;
                        try {
                            if (chat.ola.vn.util.m.b(abVar.c(), aiVar.c)) {
                                if (chat.ola.vn.util.m.a(aiVar.a)) {
                                    abVar2 = abVar;
                                    str2 = "";
                                } else {
                                    abVar2 = abVar;
                                    str2 = aiVar.a;
                                }
                                abVar2.a(str2);
                                if (!chat.ola.vn.util.m.a(aiVar.d)) {
                                    abVar.n(aiVar.d);
                                }
                                if (chat.ola.vn.util.m.a(abVar.a())) {
                                    ai.this.x.setVisibility(8);
                                    ai.this.v.setText("");
                                    textView = ai.this.w;
                                    strC = "";
                                } else {
                                    ai.this.x.setVisibility(0);
                                    ai.this.v.setText(abVar.a());
                                    textView = ai.this.w;
                                    strC = abVar.C();
                                }
                                textView.setText(strC);
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                });
            } catch (Throwable unused2) {
            }
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    @TargetApi(11)
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        super.a(dVar, dVar2, dVar3);
        chat.ola.vn.message.ab abVar = (chat.ola.vn.message.ab) dVar;
        this.u.setTag(abVar);
        this.x.setTag(abVar);
        this.u.setOnClickListener(this);
        if (this.b != null) {
            this.u.setOnLongClickListener(this.b);
        }
        this.x.setOnClickListener(this);
        a(abVar);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.imgMeYoutubeThumbnail1 || id == R.id.meYouTubeInfo) {
                chat.ola.vn.message.ab abVar = (chat.ola.vn.message.ab) view.getTag();
                abVar.g();
                if (chat.ola.vn.util.m.a(abVar.c())) {
                    return;
                }
                chat.ola.vn.util.b.a(chat.ola.vn.c.c(), abVar.c(), view);
            }
        } catch (Throwable unused) {
        }
    }
}
