package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class v extends f implements View.OnClickListener {
    private View t;
    private OlaCachedImageView u;
    private TextView v;
    private TextView w;
    private View x;

    public v(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = view.findViewById(R.id.imgMeYoutubeThumbnailPlayIcon);
        this.u = (OlaCachedImageView) view.findViewById(R.id.imgMeYoutubeThumbnail1);
        this.x = view.findViewById(R.id.meYouTubeInfo);
        this.v = (TextView) view.findViewById(R.id.meYouTubeTitle);
        this.w = (TextView) view.findViewById(R.id.meYouTubeDuration);
        this.u.setOnClickListener(this);
        this.x.setOnClickListener(this);
    }

    private void a(final chat.ola.vn.message.l lVar) {
        if (lVar.v() == null) {
            this.u.setVisibility(8);
            this.x.setVisibility(8);
            this.t.setVisibility(8);
            this.v.setText("");
            this.w.setText("");
            return;
        }
        if (lVar.a() != null) {
            this.x.setVisibility(0);
            this.v.setText(lVar.C());
            this.w.setText(lVar.D());
            chat.ola.vn.c.t.a().a(lVar.a(), this.u);
            this.t.setVisibility(0);
            return;
        }
        try {
            this.x.setVisibility(8);
            this.v.setText("");
            this.w.setText("");
            OlaApplication.b.a(lVar.v(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.entry.b.v.1
                @Override // chat.ola.vn.p.b
                public void a(String str, String str2) {
                    try {
                        lVar.o(null);
                        lVar.n(null);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.p.b
                public void a(String str, String str2, chat.ola.vn.entity.e eVar) {
                    chat.ola.vn.message.l lVar2;
                    String strS;
                    chat.ola.vn.message.l lVar3;
                    String strZ;
                    chat.ola.vn.message.l lVar4;
                    String strA;
                    TextView textView;
                    String strD;
                    try {
                        if (v.this.u.getWidth() > 400 || chat.ola.vn.h.I) {
                            lVar.a(eVar.q());
                            if (chat.ola.vn.util.m.a(lVar.a())) {
                                lVar.a(eVar.r());
                            }
                            if (chat.ola.vn.util.m.a(lVar.a())) {
                                lVar2 = lVar;
                                strS = eVar.s();
                                lVar2.a(strS);
                            }
                        } else {
                            lVar.a(eVar.r());
                            if (chat.ola.vn.util.m.a(lVar.a())) {
                                lVar.a(eVar.s());
                            }
                            if (chat.ola.vn.util.m.a(lVar.a())) {
                                lVar2 = lVar;
                                strS = eVar.q();
                                lVar2.a(strS);
                            }
                        }
                        lVar.b(eVar.A());
                        if (chat.ola.vn.util.m.a(eVar.z())) {
                            lVar3 = lVar;
                            strZ = "";
                        } else {
                            lVar3 = lVar;
                            strZ = eVar.z();
                        }
                        lVar3.n(strZ);
                        if (eVar.C() >= 0) {
                            lVar4 = lVar;
                            strA = com.mg.ola.common.d.i.a(eVar.C(), ":", ":");
                        } else {
                            lVar4 = lVar;
                            strA = "";
                        }
                        lVar4.o(strA);
                        if (chat.ola.vn.util.m.a(lVar.C())) {
                            v.this.x.setVisibility(8);
                            v.this.v.setText("");
                            textView = v.this.w;
                            strD = "";
                        } else {
                            v.this.x.setVisibility(0);
                            v.this.v.setText(lVar.C());
                            textView = v.this.w;
                            strD = lVar.D();
                        }
                        textView.setText(strD);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    @TargetApi(11)
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        super.a(dVar, dVar2, dVar3);
        chat.ola.vn.message.l lVar = (chat.ola.vn.message.l) dVar;
        this.u.setTag(lVar);
        this.x.setTag(lVar);
        a(lVar);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.imgMeYoutubeThumbnail1 || id == R.id.meYouTubeInfo) {
                chat.ola.vn.message.l lVar = (chat.ola.vn.message.l) view.getTag();
                lVar.g();
                if (chat.ola.vn.util.m.a(lVar.v())) {
                    return;
                }
                chat.ola.vn.util.b.a(chat.ola.vn.c.c(), lVar.c());
            }
        } catch (Throwable unused) {
        }
    }
}
