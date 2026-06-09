package chat.ola.vn.entry.b.a;

import android.annotation.TargetApi;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import chat.ola.vn.entity.ai;
import chat.ola.vn.entity.e;
import chat.ola.vn.entity.f;
import chat.ola.vn.entry.b.ab;
import chat.ola.vn.h;
import chat.ola.vn.p.o;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import com.mg.ola.common.d.i;

/* JADX INFO: loaded from: classes.dex */
public class a extends b {
    private OlaRatioImageView e;
    private OlaCachedImageView f;
    private TextView g;
    private TextView h;
    private TextView i;
    private TextView j;
    private View k;
    private View l;
    private TextView m;
    private TextView n;
    private ProgressBar o;

    public a(Context context, ViewGroup viewGroup, View.OnClickListener onClickListener) {
        super(context, viewGroup, onClickListener);
        try {
            View viewInflate = View.inflate(context, R.layout.attached_me_comment_holder_layout, viewGroup);
            this.e = (OlaRatioImageView) viewInflate.findViewById(R.id.attachedMeCommentImageView);
            this.f = (OlaCachedImageView) viewInflate.findViewById(R.id.attachedMeCommentOvatar);
            this.g = (TextView) viewInflate.findViewById(R.id.attachedMeCommentNick);
            this.h = (TextView) viewInflate.findViewById(R.id.attachedMeCommentContent);
            this.i = (TextView) viewInflate.findViewById(R.id.attachedMeCommentNumberOfLike);
            this.j = (TextView) viewInflate.findViewById(R.id.attachedMeCommentNumberOfComments);
            this.o = (ProgressBar) viewInflate.findViewById(R.id.attachedMeCommentLoading);
            this.l = viewInflate.findViewById(R.id.attachedMeVideoInfo);
            this.k = viewInflate.findViewById(R.id.attachedMeCommentMediaPan);
            this.m = (TextView) viewInflate.findViewById(R.id.attachedMeVideoDuration);
            this.n = (TextView) viewInflate.findViewById(R.id.meYouTubeTitle);
        } catch (Throwable unused) {
        }
    }

    public static byte a() {
        return (byte) 2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c() {
        try {
            if (m.a(this.b.a.f)) {
                return;
            }
            t.a().f(this.b.a.f, this.f);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @TargetApi(11)
    public void d() {
        try {
            this.k.setVisibility(0);
            this.l.setVisibility(0);
        } catch (Throwable unused) {
        }
        try {
            this.e.setVisibility(0);
            this.e.setRatio(1.7777777777777777d);
            this.e.setBackgroundColor(0);
            t.a().a(this.b.a.p, this.e);
            if (!m.c(this.b.a.l)) {
                this.m.setText(this.b.a.m);
                this.n.setText(this.b.a.l);
            } else {
                this.m.setText("--:--");
                this.n.setText("");
                OlaApplication.b.a(this.b.a.o, new chat.ola.vn.p.b() { // from class: chat.ola.vn.entry.b.a.a.2
                    @Override // chat.ola.vn.p.b
                    public void a(String str, String str2) {
                        try {
                            a.this.b.a.d = "";
                            a.this.b.a.m = "";
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.p.b
                    public void a(String str, String str2, e eVar) {
                        f fVar;
                        String strQ;
                        f fVar2;
                        String strZ;
                        f fVar3;
                        String strA;
                        TextView textView;
                        String str3;
                        try {
                            if (m.a(a.this.b.a.o, str)) {
                                if (a.this.e.getWidth() > 400) {
                                    a.this.b.a.p = eVar.q();
                                    if (m.a(a.this.b.a.p)) {
                                        a.this.b.a.p = eVar.r();
                                    }
                                    if (m.a(a.this.b.a.p)) {
                                        fVar = a.this.b.a;
                                        strQ = eVar.s();
                                        fVar.p = strQ;
                                    }
                                } else {
                                    a.this.b.a.p = eVar.r();
                                    if (m.a(a.this.b.a.p)) {
                                        a.this.b.a.p = eVar.s();
                                    }
                                    if (m.a(a.this.b.a.p)) {
                                        fVar = a.this.b.a;
                                        strQ = eVar.q();
                                        fVar.p = strQ;
                                    }
                                }
                                if (m.a(eVar.z())) {
                                    fVar2 = a.this.b.a;
                                    strZ = "";
                                } else {
                                    fVar2 = a.this.b.a;
                                    strZ = eVar.z();
                                }
                                fVar2.l = strZ;
                                if (eVar.C() >= 0) {
                                    fVar3 = a.this.b.a;
                                    strA = i.a(eVar.C(), ":", ":");
                                } else {
                                    fVar3 = a.this.b.a;
                                    strA = "";
                                }
                                fVar3.m = strA;
                                if (m.a(a.this.b.a.l)) {
                                    a.this.m.setText("--:--");
                                    textView = a.this.n;
                                    str3 = "--:--";
                                } else {
                                    a.this.n.setText(a.this.b.a.l);
                                    textView = a.this.m;
                                    str3 = a.this.b.a.m;
                                }
                                textView.setText(str3);
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                });
            }
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @TargetApi(11)
    public void e() {
        try {
            this.k.setVisibility(0);
            this.l.setVisibility(0);
        } catch (Throwable unused) {
        }
        try {
            this.e.setVisibility(0);
            this.e.setRatio(1.7777777777777777d);
            this.e.setBackgroundColor(0);
            String str = "http://img.youtube.com/vi/" + this.b.a.n + "/mqdefault.jpg";
            if (this.e.getWidth() > 400) {
                str = "http://img.youtube.com/vi/" + this.b.a.n + "/hqdefault.jpg";
            }
            t.a().a(str, this.e);
            if (!m.c(this.b.a.l)) {
                this.n.setText(this.b.a.l);
                this.m.setText(this.b.a.m);
            } else {
                this.n.setText("");
                this.m.setText("--:--");
                OlaApplication.b.a(this.b.a.n, new o() { // from class: chat.ola.vn.entry.b.a.a.3
                    @Override // chat.ola.vn.p.o
                    public void a() {
                        try {
                            a.this.b.a.d = "   ";
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.p.o
                    public void a(ai aiVar) {
                        f fVar;
                        String str2;
                        TextView textView;
                        String str3;
                        try {
                            if (m.b(a.this.b.a.n, aiVar.c)) {
                                if (m.a(aiVar.a)) {
                                    fVar = a.this.b.a;
                                    str2 = "   ";
                                } else {
                                    fVar = a.this.b.a;
                                    str2 = aiVar.a;
                                }
                                fVar.l = str2;
                                a.this.b.a.m = aiVar.d;
                                if (m.a(a.this.b.a.l)) {
                                    a.this.n.setText("");
                                    textView = a.this.m;
                                    str3 = "--:--";
                                } else {
                                    a.this.n.setText(a.this.b.a.l);
                                    textView = a.this.m;
                                    str3 = a.this.b.a.m;
                                }
                                textView.setText(str3);
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                });
            }
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f() {
        OlaRatioImageView olaRatioImageView;
        int i;
        try {
            this.k.setVisibility(0);
            this.l.setVisibility(8);
        } catch (Throwable unused) {
        }
        try {
            if (this.e.getVisibility() != 0) {
                this.e.setVisibility(0);
            }
            switch (chat.ola.vn.entity.i.i(this.b.a.e)) {
                case 1:
                    t.a().b(this.b.a.e, this.e, this.e.getWidth());
                    return;
                case 2:
                    try {
                        this.k.setVisibility(0);
                        this.l.setVisibility(0);
                        break;
                    } catch (Throwable unused2) {
                    }
                    this.e.setVisibility(0);
                    this.e.setRatio(1.7777777777777777d);
                    this.e.setBackgroundColor(chat.ola.vn.f.h);
                    this.e.a(null, null);
                    this.n.setText(R.string.string_touch_to_view_video);
                    this.m.setText("--:--");
                    return;
                case 3:
                    this.e.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    this.e.setRatio(1.0d);
                    this.e.setRatio(5.333333333333333d);
                    this.e.setBackgroundColor(0);
                    olaRatioImageView = this.e;
                    i = R.drawable.ic_media_sound;
                    break;
                default:
                    this.e.setScaleType(ImageView.ScaleType.CENTER_CROP);
                    this.e.setRatio(5.333333333333333d);
                    this.e.setBackgroundColor(0);
                    olaRatioImageView = this.e;
                    i = R.drawable.ic_sdcard;
                    break;
            }
            olaRatioImageView.setImageResource(i);
        } catch (Throwable unused3) {
        }
    }

    @Override // chat.ola.vn.entry.b.a.b
    public void a(final ab abVar) {
        TextView textView;
        StringBuilder sb;
        int i;
        TextView textView2;
        int i2;
        TextView textView3;
        StringBuilder sb2;
        int i3;
        if (this.b.a == null) {
            this.o.setVisibility(0);
            this.k.setVisibility(8);
            this.f.a(null, null);
            this.g.setText("");
            this.h.setText("");
            this.c.setTag(null);
            this.k.setTag(null);
            this.k.setOnClickListener(null);
            OlaApplication.b.a(this.b.b.x().a(), new chat.ola.vn.p.c() { // from class: chat.ola.vn.entry.b.a.a.1
                @Override // chat.ola.vn.p.c
                public void a(long j) {
                    a.this.b.a = new f();
                    a.this.b.a.a = true;
                    abVar.g();
                }

                @Override // chat.ola.vn.p.c
                public void a(long j, f fVar) {
                    TextView textView4;
                    StringBuilder sb3;
                    TextView textView5;
                    int i4;
                    TextView textView6;
                    StringBuilder sb4;
                    try {
                        if (j == a.this.b.b.x().a()) {
                            a.this.o.setVisibility(8);
                            a.this.b.a = fVar;
                            CharSequence charSequenceL = fVar.f;
                            if (m.b(fVar.f, "rss")) {
                                charSequenceL = OlaApplication.a(R.string.general_tab_rss);
                            } else if (m.b(fVar.f, "kho")) {
                                charSequenceL = OlaApplication.a(R.string.general_tab_ola_mall);
                            } else {
                                chat.ola.vn.message.f fVarE = h.t.e(fVar.f, (short) 0);
                                if (fVarE != null) {
                                    charSequenceL = fVarE.L();
                                }
                            }
                            a.this.g.setText(charSequenceL);
                            a.this.h.setText(fVar.d);
                            a.this.c.setTag(a.this.b.a);
                            a.this.c.setOnClickListener(a.this.d);
                            a.this.k.setTag(a.this.b.a);
                            a.this.k.setOnClickListener(a.this.d);
                            a.this.i.setTag(a.this.b.a);
                            a.this.i.setOnClickListener(a.this.d);
                            a.this.c();
                            if (!m.a(a.this.b.a.e)) {
                                a.this.f();
                            } else if (!m.a(a.this.b.a.o)) {
                                a.this.d();
                            } else if (m.a(a.this.b.a.n)) {
                                a.this.k.setVisibility(8);
                            } else {
                                a.this.e();
                            }
                            a.this.i.setVisibility(0);
                            if (a.this.b.a.r > 0) {
                                if (a.this.b.a.a()) {
                                    textView5 = a.this.i;
                                    i4 = chat.ola.vn.f.H;
                                } else {
                                    textView5 = a.this.i;
                                    i4 = chat.ola.vn.f.z;
                                }
                                textView5.setTextColor(i4);
                                if (a.this.b.a.r > 1) {
                                    textView6 = a.this.i;
                                    sb4 = new StringBuilder();
                                    sb4.append(m.a(a.this.b.a.r));
                                    sb4.append(" ");
                                    sb4.append(OlaApplication.a(R.string.string_like_plural));
                                } else {
                                    textView6 = a.this.i;
                                    sb4 = new StringBuilder();
                                    sb4.append(m.a(a.this.b.a.r));
                                    sb4.append(" ");
                                    sb4.append(OlaApplication.a(R.string.string_like_single));
                                }
                                textView6.setText(sb4.toString());
                            } else {
                                a.this.i.setTextColor(chat.ola.vn.f.z);
                                a.this.i.setText(R.string.string_like);
                            }
                            if (a.this.b.a.t <= 0) {
                                a.this.j.setVisibility(8);
                                return;
                            }
                            a.this.j.setVisibility(0);
                            if (a.this.b.a.t > 1) {
                                textView4 = a.this.j;
                                sb3 = new StringBuilder();
                                sb3.append(m.a(a.this.b.a.t));
                                sb3.append(" ");
                                sb3.append(OlaApplication.a(R.string.string_comment_plural));
                            } else {
                                textView4 = a.this.j;
                                sb3 = new StringBuilder();
                                sb3.append(m.a(a.this.b.a.t));
                                sb3.append(" ");
                                sb3.append(OlaApplication.a(R.string.string_comment));
                            }
                            textView4.setText(sb3.toString());
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            return;
        }
        if (this.b.a.a) {
            abVar.g();
            return;
        }
        this.o.setVisibility(8);
        this.c.setTag(this.b.a);
        this.c.setOnClickListener(this.d);
        this.k.setTag(this.b.a);
        this.k.setOnClickListener(this.d);
        this.i.setTag(this.b.a);
        this.i.setOnClickListener(this.d);
        this.g.setText(this.b.a.q);
        this.h.setText(this.b.a.d);
        c();
        if (!m.a(this.b.a.e)) {
            f();
        } else if (!m.a(this.b.a.o)) {
            d();
        } else if (m.a(this.b.a.n)) {
            this.k.setVisibility(8);
        } else {
            e();
        }
        this.i.setVisibility(0);
        if (this.b.a.r > 0) {
            if (this.b.a.a()) {
                textView2 = this.i;
                i2 = chat.ola.vn.f.H;
            } else {
                textView2 = this.i;
                i2 = chat.ola.vn.f.z;
            }
            textView2.setTextColor(i2);
            if (this.b.a.r > 1) {
                textView3 = this.i;
                sb2 = new StringBuilder();
                sb2.append(m.a(this.b.a.r));
                sb2.append(" ");
                i3 = R.string.string_like_plural;
            } else {
                textView3 = this.i;
                sb2 = new StringBuilder();
                sb2.append(m.a(this.b.a.r));
                sb2.append(" ");
                i3 = R.string.string_like_single;
            }
            sb2.append(OlaApplication.a(i3));
            textView3.setText(sb2.toString());
        } else {
            this.i.setTextColor(chat.ola.vn.f.z);
            this.i.setText(R.string.string_like);
        }
        if (this.b.a.t <= 0) {
            this.j.setVisibility(8);
            return;
        }
        this.j.setVisibility(0);
        if (this.b.a.t > 1) {
            textView = this.j;
            sb = new StringBuilder();
            sb.append(m.a(this.b.a.t));
            sb.append(" ");
            i = R.string.string_comment_plural;
        } else {
            textView = this.j;
            sb = new StringBuilder();
            sb.append(m.a(this.b.a.t));
            sb.append(" ");
            i = R.string.string_comment;
        }
        sb.append(OlaApplication.a(i));
        textView.setText(sb.toString());
    }

    @Override // chat.ola.vn.entry.b.a.b
    public boolean a(byte b) {
        return 2 == b;
    }

    @Override // chat.ola.vn.entry.b.a.b
    void b(ab abVar) {
        abVar.g();
    }
}
