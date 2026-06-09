package chat.ola.vn.entry.b.a;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import chat.ola.vn.entity.d;
import chat.ola.vn.entity.u;
import chat.ola.vn.entity.z;
import chat.ola.vn.entry.b.ab;
import chat.ola.vn.f;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.network.a.a.aj;
import chat.ola.vn.p.l;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;

/* JADX INFO: loaded from: classes.dex */
public class c extends b {
    private OlaRatioImageView e;
    private View f;
    private View g;
    private OlaCachedImageView[] h;
    private ImageView i;
    private TextView j;
    private ImageView k;
    private TextView l;
    private View m;
    private View n;
    private View o;
    private View p;
    private TextView q;
    private TextView r;
    private TextView s;
    private ProgressBar t;

    public c(Context context, ViewGroup viewGroup, View.OnClickListener onClickListener) {
        super(context, viewGroup, onClickListener);
        try {
            View viewInflate = View.inflate(context, R.layout.attached_me_rss_holder_layout, viewGroup);
            this.e = (OlaRatioImageView) viewInflate.findViewById(R.id.attachedMeRssImageView);
            this.q = (TextView) viewInflate.findViewById(R.id.attachedMeRssTitle);
            this.t = (ProgressBar) viewInflate.findViewById(R.id.attachedMeRssLoading);
            this.f = viewInflate.findViewById(R.id.rssBottomButtonViewLayout);
            this.g = viewInflate.findViewById(R.id.btnMeActionSpanDivider);
            this.i = (ImageView) viewInflate.findViewById(R.id.txtMeItemLikeIcon);
            this.j = (TextView) viewInflate.findViewById(R.id.txtMeItemLikeTextView);
            this.k = (ImageView) viewInflate.findViewById(R.id.txtMeItemDislikeIcon);
            this.l = (TextView) viewInflate.findViewById(R.id.txtMeItemDislikeTextView);
            this.m = viewInflate.findViewById(R.id.txtMeItemLikeWrapper);
            this.n = viewInflate.findViewById(R.id.btnMeItemLikeSpan);
            this.o = viewInflate.findViewById(R.id.btnMeItemFooterReply);
            this.p = viewInflate.findViewById(R.id.txtMeItemDislikeWrapper);
            this.r = (TextView) viewInflate.findViewById(R.id.attachedMeCommentNumberOfLike);
            this.s = (TextView) viewInflate.findViewById(R.id.attachedMeCommentNumberOfComments);
            this.s.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.entry.b.a.c.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    try {
                        OlaMeCommentActivity.a(chat.ola.vn.c.c(), c.this.b.b.v());
                    } catch (Throwable unused) {
                    }
                }
            });
            this.h = new OlaCachedImageView[3];
            this.h[0] = (OlaCachedImageView) viewInflate.findViewById(R.id.imgMeItemLikeBuddy1);
            this.h[1] = (OlaCachedImageView) viewInflate.findViewById(R.id.imgMeItemLikeBuddy2);
            this.h[2] = (OlaCachedImageView) viewInflate.findViewById(R.id.imgMeItemLikeBuddy3);
        } catch (Throwable unused) {
        }
    }

    public static byte a() {
        return (byte) 1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c() {
        try {
            if (!m.a(this.b.b.C())) {
                if (m.a(this.b.a.e)) {
                    if (this.e.getVisibility() != 8) {
                        this.e.setVisibility(8);
                        return;
                    }
                    return;
                } else {
                    if (this.e.getVisibility() != 0) {
                        this.e.setVisibility(0);
                    }
                    t.a().b(this.b.a.e, this.e, this.e.getWidth());
                    return;
                }
            }
            if (m.a(this.b.b.F())) {
                return;
            }
            if (m.a(this.b.a.e)) {
                if (this.e.getVisibility() != 8) {
                    this.e.setVisibility(8);
                }
            } else {
                if (this.e.getVisibility() != 0) {
                    this.e.setVisibility(0);
                }
                t.a().b(this.b.a.e, this.e);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        OlaCachedImageView olaCachedImageView;
        TextView textView;
        int i;
        TextView textView2;
        StringBuilder sb;
        int i2;
        int iF = this.b.b.f();
        this.r.setTextColor(f.z);
        if (iF > 0) {
            if (this.b.b.i() == 1) {
                this.i.setImageResource(R.drawable.ic_like_selected);
                textView = this.j;
                i = f.H;
            } else {
                this.i.setImageResource(R.drawable.ic_like_gray);
                textView = this.j;
                i = f.A;
            }
            textView.setTextColor(i);
            if (iF > 1) {
                textView2 = this.r;
                sb = new StringBuilder();
                sb.append(m.a(iF));
                sb.append(" ");
                i2 = R.string.string_like_plural;
            } else {
                textView2 = this.r;
                sb = new StringBuilder();
                sb.append(m.a(iF));
                sb.append(" ");
                i2 = R.string.string_like_single;
            }
            sb.append(OlaApplication.a(i2));
            textView2.setText(sb.toString());
        } else {
            this.i.setImageResource(R.drawable.ic_like_gray);
            this.r.setText("");
            this.j.setTextColor(f.A);
        }
        if (this.b.b.E() == null) {
            this.n.setVisibility(4);
            return;
        }
        try {
            switch (this.b.b.E().length) {
                case 0:
                    return;
                case 1:
                    if (this.h[0] != null) {
                        this.h[0].setVisibility(0);
                    }
                    f();
                    this.h[1].a(null, null);
                    this.h[1].setVisibility(8);
                    this.h[2].a(null, null);
                    olaCachedImageView = this.h[2];
                    break;
                case 2:
                    this.h[0].setVisibility(0);
                    this.h[1].setVisibility(0);
                    f();
                    this.h[2].a(null, null);
                    olaCachedImageView = this.h[2];
                    break;
                default:
                    this.h[0].setVisibility(0);
                    this.h[1].setVisibility(0);
                    this.h[2].setVisibility(0);
                    f();
                    return;
            }
            olaCachedImageView.setVisibility(8);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e() {
        TextView textView;
        int i;
        int iD = this.b.b.D();
        if (iD <= 0) {
            this.k.setImageResource(R.drawable.ic_dislike_gray);
            this.l.setText(R.string.string_dislike);
            this.l.setTextColor(f.A);
            return;
        }
        if (this.b.b.i() == 2) {
            this.k.setImageResource(R.drawable.ic_dislike_black);
            textView = this.l;
            i = f.y;
        } else {
            this.k.setImageResource(R.drawable.ic_dislike_gray);
            textView = this.l;
            i = f.A;
        }
        textView.setTextColor(i);
        this.l.setText(OlaApplication.a(R.string.string_dislike) + " (" + m.a(iD) + ")");
    }

    private void f() {
        try {
            if (this.h != null) {
                for (int i = 0; i < this.h.length && i < this.b.b.E().length; i++) {
                    if (this.h[i] != null) {
                        this.h[i].setVisibility(0);
                        t.a().f(this.b.b.E()[i], this.h[i]);
                    }
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g() {
        try {
            if (this.d != null) {
                this.o.setTag(this.b);
                this.p.setTag(this.b);
                this.r.setTag(this.b.a);
                this.n.setTag(this.b);
                this.m.setTag(this.b);
                this.n.setOnClickListener(this.d);
                this.m.setOnClickListener(this.d);
                this.o.setOnClickListener(this.d);
                this.p.setOnClickListener(this.d);
                this.r.setOnClickListener(this.d);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.a.b
    public void a(final ab abVar) {
        TextView textView;
        StringBuilder sb;
        int i;
        TextView textView2;
        StringBuilder sb2;
        int i2;
        TextView textView3;
        int i3;
        if (this.b.b.k() == 11) {
            this.f.setVisibility(0);
            this.g.setVisibility(0);
        } else {
            this.f.setVisibility(8);
            this.g.setVisibility(4);
        }
        if (this.b.a == null) {
            this.t.setVisibility(0);
            this.e.a(null, null);
            this.q.setText("");
            this.c.setTag(null);
            if (this.b.b.v() > 0) {
                this.n.setVisibility(0);
                OlaApplication.b.c(this.b.b.v(), new chat.ola.vn.p.c() { // from class: chat.ola.vn.entry.b.a.c.2
                    @Override // chat.ola.vn.p.c
                    public void a(long j) {
                        try {
                            c.this.b.a = new chat.ola.vn.entity.f();
                            c.this.b.a.a = true;
                            abVar.g();
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.p.c
                    public void a(long j, chat.ola.vn.entity.f fVar) {
                        TextView textView4;
                        StringBuilder sb3;
                        TextView textView5;
                        StringBuilder sb4;
                        TextView textView6;
                        int i4;
                        try {
                            if (j == c.this.b.b.v()) {
                                c.this.n.setVisibility(0);
                                c.this.t.setVisibility(8);
                                c.this.b.a = fVar;
                                c.this.c.setVisibility(0);
                                c.this.q.setText(fVar.l);
                                if (c.this.b.a.r > 0) {
                                    if (c.this.b.a.r > 1) {
                                        textView5 = c.this.r;
                                        sb4 = new StringBuilder();
                                        sb4.append(m.a(c.this.b.a.r));
                                        sb4.append(" ");
                                        sb4.append(OlaApplication.a(R.string.string_like_plural));
                                    } else {
                                        textView5 = c.this.r;
                                        sb4 = new StringBuilder();
                                        sb4.append(m.a(c.this.b.a.r));
                                        sb4.append(" ");
                                        sb4.append(OlaApplication.a(R.string.string_like_single));
                                    }
                                    textView5.setText(sb4.toString());
                                    if (c.this.b.a.a()) {
                                        textView6 = c.this.r;
                                        i4 = f.H;
                                    } else {
                                        textView6 = c.this.r;
                                        i4 = f.z;
                                    }
                                    textView6.setTextColor(i4);
                                } else {
                                    c.this.r.setTextColor(f.z);
                                    c.this.r.setText(R.string.string_like);
                                }
                                if (c.this.b.a.t > 0) {
                                    c.this.s.setVisibility(0);
                                    if (c.this.b.a.t > 1) {
                                        textView4 = c.this.s;
                                        sb3 = new StringBuilder();
                                        sb3.append(m.a(c.this.b.a.t));
                                        sb3.append(" ");
                                        sb3.append(OlaApplication.a(R.string.string_comment_plural));
                                    } else {
                                        textView4 = c.this.s;
                                        sb3 = new StringBuilder();
                                        sb3.append(m.a(c.this.b.a.t));
                                        sb3.append(" ");
                                        sb3.append(OlaApplication.a(R.string.string_comment));
                                    }
                                    textView4.setText(sb3.toString());
                                } else {
                                    c.this.s.setVisibility(8);
                                }
                                try {
                                    c.this.h[0].setVisibility(8);
                                    c.this.h[1].setVisibility(8);
                                    c.this.h[2].setVisibility(8);
                                } catch (Throwable unused) {
                                }
                                if (c.this.b.b.k() == 11) {
                                    if (c.this.b.a.t == 0) {
                                        c.this.s.setVisibility(0);
                                        c.this.s.setText(R.string.string_be_the_first_comment);
                                    }
                                    c.this.b.b.c(fVar.c());
                                    c.this.b.b.a(fVar.r);
                                    c.this.b.b.c(fVar.s);
                                    c.this.b.b.a(fVar.i);
                                    c.this.b.b.b(fVar.t);
                                    c.this.d();
                                    c.this.e();
                                }
                                c.this.g();
                                c.this.c.setTag(c.this.b.a);
                                c.this.c.setOnClickListener(c.this.d);
                                c.this.c();
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                });
                return;
            }
            if (!m.a(this.b.b.C())) {
                this.n.setVisibility(0);
                OlaApplication.b.a(this.b.b.C(), new l() { // from class: chat.ola.vn.entry.b.a.c.3
                    @Override // chat.ola.vn.p.l
                    public void a(u uVar) {
                        boolean zH;
                        try {
                            if (m.b(c.this.b.b.C(), "rss://" + uVar.g())) {
                                if (m.a(uVar.g())) {
                                    c.this.b.a = new chat.ola.vn.entity.f();
                                    c.this.b.a.a = true;
                                    abVar.g();
                                    return;
                                }
                                c.this.n.setVisibility(0);
                                try {
                                    zH = c.this.b.a.a();
                                } catch (Throwable unused) {
                                    zH = false;
                                }
                                c.this.b.a = new chat.ola.vn.entity.f();
                                c.this.b.a.b = new d("rss");
                                c.this.b.a.b.b(uVar.g());
                                c.this.b.a.e = uVar.d();
                                c.this.b.a.c = uVar.a();
                                c.this.b.a.l = uVar.c();
                                c.this.b.a.r = uVar.f();
                                if (!zH) {
                                    zH = uVar.h();
                                }
                                c.this.b.a.a(zH ? (short) 1 : (short) 0);
                                c.this.b.a.t = uVar.e();
                                c.this.t.setVisibility(8);
                                c.this.c.setVisibility(0);
                                c.this.q.setText(c.this.b.a.l);
                                c.this.c.setTag(c.this.b.a);
                                c.this.c.setOnClickListener(c.this.d);
                                try {
                                    c.this.h[0].setVisibility(8);
                                    c.this.h[1].setVisibility(8);
                                    c.this.h[2].setVisibility(8);
                                } catch (Throwable unused2) {
                                }
                                c.this.c();
                                c.this.g();
                            }
                        } catch (Throwable unused3) {
                        }
                    }

                    @Override // chat.ola.vn.p.l
                    public void a(short s, String str) {
                        try {
                            c.this.b.a = new chat.ola.vn.entity.f();
                            c.this.b.a.a = true;
                            abVar.g();
                        } catch (Throwable unused) {
                        }
                    }
                });
                return;
            } else {
                if (m.a(this.b.b.F())) {
                    return;
                }
                try {
                    this.n.setVisibility(8);
                    this.h[0].setVisibility(8);
                    this.h[1].setVisibility(8);
                    this.h[2].setVisibility(8);
                } catch (Throwable unused) {
                }
                OlaApplication.b.a(this.b.b.F(), new aj.a() { // from class: chat.ola.vn.entry.b.a.c.4
                    @Override // chat.ola.vn.network.a.a.aj.a
                    public void a(z zVar) {
                        try {
                            c.this.b.a = new chat.ola.vn.entity.f();
                            c.this.b.a.b = new d("wap");
                            c.this.b.a.b.b(zVar.b);
                            c.this.b.a.e = zVar.f;
                            c.this.b.a.l = zVar.c;
                            c.this.t.setVisibility(8);
                            c.this.c.setVisibility(0);
                            c.this.q.setText(c.this.b.a.l);
                            c.this.c.setTag(c.this.b.a);
                            c.this.c.setOnClickListener(c.this.d);
                            c.this.c();
                            c.this.g();
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.network.a.a.aj.a
                    public void a(String str) {
                        try {
                            c.this.b.a = new chat.ola.vn.entity.f();
                            c.this.b.a.a = true;
                            abVar.g();
                        } catch (Throwable unused2) {
                        }
                    }
                });
                return;
            }
        }
        if (this.b.a.a) {
            abVar.g();
            return;
        }
        if (m.a(this.b.b.F())) {
            this.n.setVisibility(0);
        } else {
            this.n.setVisibility(8);
        }
        this.t.setVisibility(8);
        this.c.setTag(this.b.a);
        this.c.setOnClickListener(this.d);
        this.c.setVisibility(0);
        this.q.setText(this.b.a.l);
        c();
        if (this.b.a.r > 0) {
            if (this.b.a.r > 1) {
                textView2 = this.r;
                sb2 = new StringBuilder();
                sb2.append(m.a(this.b.a.r));
                sb2.append(" ");
                i2 = R.string.string_like_plural;
            } else {
                textView2 = this.r;
                sb2 = new StringBuilder();
                sb2.append(m.a(this.b.a.r));
                sb2.append(" ");
                i2 = R.string.string_like_single;
            }
            sb2.append(OlaApplication.a(i2));
            textView2.setText(sb2.toString());
            if (this.b.a.a()) {
                textView3 = this.r;
                i3 = f.H;
            } else {
                textView3 = this.r;
                i3 = f.z;
            }
            textView3.setTextColor(i3);
        } else {
            this.r.setTextColor(f.z);
            this.r.setText(R.string.string_like);
        }
        if (this.b.a.t > 0) {
            this.s.setVisibility(0);
            if (this.b.a.t > 1) {
                textView = this.s;
                sb = new StringBuilder();
                sb.append(m.a(this.b.a.t));
                sb.append(" ");
                i = R.string.string_comment_plural;
            } else {
                textView = this.s;
                sb = new StringBuilder();
                sb.append(m.a(this.b.a.t));
                sb.append(" ");
                i = R.string.string_comment;
            }
            sb.append(OlaApplication.a(i));
            textView.setText(sb.toString());
        } else {
            this.s.setVisibility(8);
        }
        try {
            this.h[0].setVisibility(8);
            this.h[1].setVisibility(8);
            this.h[2].setVisibility(8);
        } catch (Throwable unused2) {
        }
        if (this.b.b.k() == 11) {
            if (this.b.a.t == 0) {
                this.s.setVisibility(0);
                this.s.setText(R.string.string_be_the_first_comment);
            }
            d();
            e();
        }
        g();
    }

    @Override // chat.ola.vn.entry.b.a.b
    public boolean a(byte b) {
        return 1 == b;
    }

    @Override // chat.ola.vn.entry.b.a.b
    void b(ab abVar) {
        abVar.g();
    }
}
