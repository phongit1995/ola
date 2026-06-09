package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.network.a.a.aj;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;

/* JADX INFO: loaded from: classes.dex */
public class r extends f implements View.OnClickListener {
    public TextView A;
    public TextView B;
    protected chat.ola.vn.message.r C;
    protected chat.ola.vn.message.i D;
    private ImageView E;
    private View F;
    private View G;
    private View H;
    private View I;
    protected OlaCachedImageView t;
    protected TextView u;
    protected TextView v;
    protected View w;
    protected View x;
    protected View y;
    protected TextView z;

    public r(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (OlaCachedImageView) view.findViewById(R.id.imgNewsThumbnail);
        this.u = (TextView) view.findViewById(R.id.txtNewsTitle);
        this.v = (TextView) view.findViewById(R.id.txtNewsSubTitle);
        this.w = view.findViewById(R.id.rssCommandViewLayout);
        this.x = view.findViewById(R.id.btnMeActionSpanDivider);
        this.y = view.findViewById(R.id.rssCommentSpanLayout);
        this.z = (TextView) view.findViewById(R.id.rssCommentNumberTextView);
        this.I = view.findViewById(R.id.rssCommentViewLayout);
        this.I.setOnClickListener(this);
        this.H = view.findViewById(R.id.chatRssViewLayout);
        this.H.setOnClickListener(chat.ola.vn.q.a.a());
        this.F = view.findViewById(R.id.rssLikeViewLayout);
        this.F.setOnClickListener(this);
        this.E = (ImageView) view.findViewById(R.id.rssLikeImageView);
        this.B = (TextView) view.findViewById(R.id.rssLikeTextView);
        this.A = (TextView) view.findViewById(R.id.rssLikeNumberTextView);
        this.G = view.findViewById(R.id.rssShareViewLayout);
        this.G.setOnClickListener(this);
        try {
            this.e = this.d.getContext().getResources().getDimensionPixelSize(R.dimen.metric_6dp);
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.message.i iVar) {
        try {
            this.D = iVar;
            this.C = null;
            a(false);
            if (this.D.a() != null) {
                h();
                return;
            }
            this.t.a(null, null);
            this.u.setText("");
            this.v.setText("");
            this.t.setVisibility(0);
            this.u.setVisibility(8);
            this.v.setVisibility(8);
            OlaApplication.b.a(this.D.B(), new aj.a() { // from class: chat.ola.vn.entry.b.r.2
                @Override // chat.ola.vn.network.a.a.aj.a
                public void a(chat.ola.vn.entity.z zVar) {
                    try {
                        r.this.D.a(zVar);
                        r.this.h();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.network.a.a.aj.a
                public void a(String str) {
                    try {
                        chat.ola.vn.entity.z zVar = new chat.ola.vn.entity.z();
                        zVar.b = str;
                        r.this.D.a(zVar);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.message.r rVar) {
        try {
            this.C = rVar;
            this.D = null;
            if (this.C.a() != null) {
                g();
                i();
                return;
            }
            this.t.a(null, null);
            this.u.setText("");
            this.v.setText("");
            this.t.setVisibility(0);
            this.u.setVisibility(8);
            this.v.setVisibility(8);
            a(false);
            OlaApplication.b.a(this.C.y(), new chat.ola.vn.p.l() { // from class: chat.ola.vn.entry.b.r.1
                @Override // chat.ola.vn.p.l
                public void a(chat.ola.vn.entity.u uVar) {
                    try {
                        r.this.C.a(uVar);
                        r.this.g();
                        if (r.this.C.a().a() > 0) {
                            OlaApplication.b.b(r.this.C.a().a(), new chat.ola.vn.p.c() { // from class: chat.ola.vn.entry.b.r.1.1
                                @Override // chat.ola.vn.p.c
                                public void a(long j) {
                                    try {
                                        if (j == r.this.C.a().a()) {
                                            r.this.i();
                                        }
                                    } catch (Throwable th) {
                                        th.printStackTrace();
                                    }
                                }

                                @Override // chat.ola.vn.p.c
                                public void a(long j, chat.ola.vn.entity.f fVar) {
                                    try {
                                        if (j != r.this.C.a().a() || fVar == null) {
                                            return;
                                        }
                                        r.this.C.a().a(fVar);
                                        r.this.i();
                                    } catch (Throwable unused) {
                                    }
                                }
                            });
                        }
                        r.this.i();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.p.l
                public void a(short s, String str) {
                    try {
                        r.this.C.a(new chat.ola.vn.entity.u());
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void a(boolean z) {
        View view;
        int i;
        if (z) {
            view = this.w;
            i = 0;
        } else {
            view = this.w;
            i = 8;
        }
        view.setVisibility(i);
        this.x.setVisibility(i);
        this.y.setVisibility(i);
    }

    private void b(chat.ola.vn.message.r rVar) {
        boolean zA;
        TextView textView;
        int i;
        TextView textView2;
        StringBuilder sb;
        int i2;
        TextView textView3;
        int i3;
        try {
            zA = rVar.a().b().a();
        } catch (Throwable unused) {
            zA = false;
        }
        this.G.setTag(rVar);
        this.F.setTag(rVar);
        int iF = rVar.a().f();
        this.E.setImageResource(R.drawable.ic_like_gray);
        this.B.setTextColor(chat.ola.vn.f.A);
        if (zA) {
            if (this.C.d() == 2) {
                this.E.setImageResource(R.drawable.ic_like_white);
                textView3 = this.B;
                i3 = chat.ola.vn.f.C;
            } else {
                this.E.setImageResource(R.drawable.ic_like_selected);
                textView3 = this.B;
                i3 = chat.ola.vn.f.H;
            }
            textView3.setTextColor(i3);
        }
        if (iF <= 0) {
            this.A.setVisibility(8);
            return;
        }
        if (this.C.d() == 2) {
            textView = this.A;
            i = chat.ola.vn.f.E;
        } else {
            textView = this.A;
            i = chat.ola.vn.f.A;
        }
        textView.setTextColor(i);
        this.A.setVisibility(0);
        if (iF > 1) {
            textView2 = this.A;
            sb = new StringBuilder();
            sb.append(chat.ola.vn.util.m.a(iF));
            sb.append(" ");
            i2 = R.string.string_like_plural;
        } else {
            textView2 = this.A;
            sb = new StringBuilder();
            sb.append(chat.ola.vn.util.m.a(iF));
            sb.append(" ");
            i2 = R.string.string_like_single;
        }
        sb.append(OlaApplication.a(i2));
        textView2.setText(sb.toString());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g() {
        TextView textView;
        int i;
        try {
            this.H.setTag(this.C);
            this.H.setOnLongClickListener(this.b);
            if (this.C.d() == 2) {
                this.u.setTextColor(chat.ola.vn.f.C);
                textView = this.v;
                i = chat.ola.vn.f.D;
            } else {
                this.u.setTextColor(chat.ola.vn.f.y);
                textView = this.v;
                i = chat.ola.vn.f.z;
            }
            textView.setTextColor(i);
            String strC = this.C.a().c();
            if (chat.ola.vn.util.m.a(strC)) {
                this.u.setVisibility(8);
            } else {
                this.u.setVisibility(0);
                this.u.setText(strC);
            }
            String strJ = this.C.a().j();
            if (chat.ola.vn.util.m.a(strJ)) {
                this.v.setVisibility(8);
            } else {
                this.v.setVisibility(0);
                this.v.setText(strJ);
            }
            if (chat.ola.vn.util.m.a(this.C.a().d())) {
                this.t.setVisibility(8);
            } else {
                this.t.setVisibility(0);
                chat.ola.vn.c.t.a().b(this.C.a().d(), this.t, 480);
            }
        } catch (Throwable unused) {
            this.u.setVisibility(8);
            this.t.setVisibility(8);
            this.v.setVisibility(8);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        TextView textView;
        int i;
        try {
            this.H.setTag(this.D);
            this.H.setOnLongClickListener(this.b);
            if (this.D.d() == 2) {
                this.u.setTextColor(chat.ola.vn.f.C);
                textView = this.v;
                i = chat.ola.vn.f.D;
            } else {
                this.u.setTextColor(chat.ola.vn.f.y);
                textView = this.v;
                i = chat.ola.vn.f.z;
            }
            textView.setTextColor(i);
            String str = this.D.a().c;
            if (chat.ola.vn.util.m.a(str)) {
                this.u.setVisibility(8);
            } else {
                this.u.setVisibility(0);
                this.u.setText(str);
            }
            String str2 = this.D.a().e;
            if (chat.ola.vn.util.m.a(str2)) {
                this.v.setVisibility(8);
            } else {
                this.v.setVisibility(0);
                this.v.setText(str2);
            }
            if (chat.ola.vn.util.m.a(this.D.a().f)) {
                this.t.setVisibility(8);
                return;
            }
            this.t.setVisibility(0);
            try {
                ((OlaRatioImageView) this.t).setRatio(1.7777777777777777d);
            } catch (Throwable unused) {
            }
            chat.ola.vn.c.t.a().b(this.D.a().f, this.t);
        } catch (Throwable unused2) {
            this.u.setVisibility(8);
            this.t.setVisibility(8);
            this.v.setVisibility(8);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void i() {
        TextView textView;
        int i;
        TextView textView2;
        StringBuilder sb;
        try {
            if (this.C.d() == 2) {
                textView = this.z;
                i = chat.ola.vn.f.E;
            } else {
                textView = this.z;
                i = chat.ola.vn.f.A;
            }
            textView.setTextColor(i);
            if (this.C.a().b() == null) {
                a(false);
                return;
            }
            a(true);
            this.I.setTag(this.C);
            if (this.C.a().e() > 0) {
                this.z.setVisibility(0);
                if (this.C.a().e() > 1) {
                    textView2 = this.z;
                    sb = new StringBuilder();
                    sb.append(chat.ola.vn.util.m.a(this.C.a().e()));
                    sb.append(" ");
                    sb.append(OlaApplication.a(R.string.string_comment_plural));
                } else {
                    textView2 = this.z;
                    sb = new StringBuilder();
                    sb.append(chat.ola.vn.util.m.a(this.C.a().e()));
                    sb.append(" ");
                    sb.append(OlaApplication.a(R.string.string_comment));
                }
                textView2.setText(sb.toString());
            } else {
                this.z.setVisibility(8);
            }
            b(this.C);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    @TargetApi(11)
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        super.a(dVar, dVar2, dVar3);
        try {
            try {
                a((chat.ola.vn.message.r) dVar);
            } catch (Throwable unused) {
                a((chat.ola.vn.message.i) dVar);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.rssCommentViewLayout) {
                OlaMeComposerActivity.a(chat.ola.vn.c.c(), ((chat.ola.vn.message.r) view.getTag()).a().a());
                return;
            }
            switch (id) {
                case R.id.rssLikeViewLayout /* 2131297346 */:
                    chat.ola.vn.message.r rVar = (chat.ola.vn.message.r) view.getTag();
                    boolean zA = rVar.a().b().a();
                    if (OlaApplication.b.b(rVar.a().a(), !zA)) {
                        boolean zB = rVar.a().b().b();
                        int iF = rVar.a().f();
                        int i = rVar.a().i();
                        int i2 = 0;
                        if (zA) {
                            rVar.a().b().a((short) 0);
                        } else {
                            rVar.a().b().a((short) 1);
                        }
                        if (zB && i - 1 < 0) {
                            i = 0;
                        }
                        if (zA) {
                            int i3 = iF - 1;
                            if (i3 >= 0) {
                                i2 = i3;
                            }
                        } else {
                            i2 = iF + 1;
                        }
                        rVar.a().b(i2);
                        rVar.a().c(i);
                        b(rVar);
                        break;
                    }
                    break;
                case R.id.rssShareViewLayout /* 2131297347 */:
                    String strY = ((chat.ola.vn.message.r) view.getTag()).y();
                    if (!chat.ola.vn.util.m.a(strY)) {
                        OlaApplication.b.a(OlaApplication.a(R.string.string_shared_this) + "\n" + strY, (String) null, (short) 0, (String) null, (short) 0);
                        chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_shared_on_your_timeline);
                    }
                    break;
            }
        } catch (Throwable unused) {
        }
    }
}
