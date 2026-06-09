package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class q extends l {
    private View a;
    private OlaCachedImageView e;
    private TextView f;
    private TextView g;
    private View h;
    private chat.ola.vn.entry.c i;

    public q(View view) {
        super(view);
        this.a = view.findViewById(R.id.newsYoutubeThumbnailPlayIcon);
        this.e = (OlaCachedImageView) view.findViewById(R.id.imgNewsYoutubeThumbnail);
        this.h = view.findViewById(R.id.newsYoutubeInfo);
        this.f = (TextView) view.findViewById(R.id.newsYoutubeTitle);
        this.g = (TextView) view.findViewById(R.id.newsYoutubeDuration);
    }

    @TargetApi(11)
    private void a() {
        String str = "http://img.youtube.com/vi/" + ((Object) this.i.d()) + "/mqdefault.jpg";
        if (this.e.getWidth() > 400) {
            str = "http://img.youtube.com/vi/" + ((Object) this.i.d()) + "/hqdefault.jpg";
        }
        chat.ola.vn.c.t.a().a(str, this.e);
        this.a.setVisibility(0);
        if (this.i.f() != null) {
            this.h.setVisibility(0);
            this.f.setText(this.i.f());
            this.g.setText(this.i.g());
        } else {
            this.h.setVisibility(8);
            this.f.setText("");
            this.g.setText("");
            try {
                OlaApplication.b.a(this.i.d().toString(), new chat.ola.vn.p.o() { // from class: chat.ola.vn.entry.b.q.1
                    @Override // chat.ola.vn.p.o
                    public void a() {
                        q.this.i.a("");
                    }

                    @Override // chat.ola.vn.p.o
                    public void a(chat.ola.vn.entity.ai aiVar) {
                        chat.ola.vn.entry.c cVar;
                        String str2;
                        TextView textView;
                        String strG;
                        try {
                            if (chat.ola.vn.util.m.b(q.this.i.d().toString(), aiVar.c)) {
                                if (chat.ola.vn.util.m.a(aiVar.a)) {
                                    cVar = q.this.i;
                                    str2 = "";
                                } else {
                                    cVar = q.this.i;
                                    str2 = aiVar.a;
                                }
                                cVar.a(str2);
                                if (chat.ola.vn.util.m.a(aiVar.d)) {
                                    q.this.i.b("");
                                } else {
                                    q.this.i.b(aiVar.d);
                                }
                                if (chat.ola.vn.util.m.a(q.this.i.f())) {
                                    q.this.h.setVisibility(8);
                                    q.this.f.setText("");
                                    textView = q.this.g;
                                    strG = "";
                                } else {
                                    q.this.h.setVisibility(0);
                                    q.this.f.setText(q.this.i.f());
                                    textView = q.this.g;
                                    strG = q.this.i.g();
                                }
                                textView.setText(strG);
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                });
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entry.b.l
    public void a(chat.ola.vn.entry.c cVar, int i) {
        this.i = cVar;
        this.e.setTag(cVar);
        this.e.setOnClickListener(this.b);
        a();
    }
}
