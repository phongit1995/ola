package chat.ola.vn.entry.b;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.view.MotionEvent;
import android.view.View;
import android.widget.RatingBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import com.mg.ola.common.widget.CommpressTextView;

/* JADX INFO: loaded from: classes.dex */
public class x extends j {
    private View i;
    private OlaCachedImageView j;
    private OlaRatioImageView k;
    private TextView l;
    private TextView m;
    private CommpressTextView n;
    private TextView o;
    private RatingBar p;
    private chat.ola.vn.entity.k q;
    private View r;
    private View s;
    private TextView t;
    private TextView u;
    private int v = 0;
    private View.OnTouchListener w;

    @SuppressLint({"NewApi"})
    private void e() {
        try {
            String str = "http://img.youtube.com/vi/" + this.b.m + "/mqdefault.jpg";
            if (this.k.getWidth() > 400 || chat.ola.vn.h.I) {
                str = "http://img.youtube.com/vi/" + this.b.m + "/hqdefault.jpg";
            }
            chat.ola.vn.c.t.a().a(str, this.k);
            if (this.q.c != null) {
                this.s.setVisibility(0);
                this.t.setText(this.q.c);
                this.u.setText(this.q.d);
            } else {
                this.s.setVisibility(8);
                this.t.setText("");
                this.u.setText("");
                OlaApplication.b.a(this.b.m, new chat.ola.vn.p.o() { // from class: chat.ola.vn.entry.b.x.3
                    @Override // chat.ola.vn.p.o
                    public void a() {
                        x.this.q.c = "";
                    }

                    @Override // chat.ola.vn.p.o
                    public void a(chat.ola.vn.entity.ai aiVar) {
                        chat.ola.vn.entity.k kVar;
                        String str2;
                        TextView textView;
                        String str3;
                        try {
                            if (chat.ola.vn.util.m.b(x.this.b.m, aiVar.c)) {
                                if (chat.ola.vn.util.m.a(aiVar.a)) {
                                    kVar = x.this.q;
                                    str2 = "";
                                } else {
                                    kVar = x.this.q;
                                    str2 = aiVar.a;
                                }
                                kVar.c = str2;
                                if (!chat.ola.vn.util.m.a(aiVar.d)) {
                                    x.this.q.d = aiVar.d;
                                }
                                if (chat.ola.vn.util.m.a(x.this.q.c)) {
                                    x.this.s.setVisibility(8);
                                    x.this.t.setText("");
                                    textView = x.this.u;
                                    str3 = "";
                                } else {
                                    x.this.s.setVisibility(0);
                                    x.this.t.setText(x.this.q.c);
                                    textView = x.this.u;
                                    str3 = x.this.q.d;
                                }
                                textView.setText(str3);
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

    private void f() {
        try {
            chat.ola.vn.c.t.a().b(this.q.k, this.k, this.h);
        } catch (Throwable unused) {
            this.k.setVisibility(8);
        }
    }

    private void g() {
        try {
            this.l.setText(this.q.a);
            this.m.setText(this.q.e);
            this.o.setText(this.q.l);
            if (this.q.n == null) {
                this.p.setVisibility(8);
            } else {
                this.p.setVisibility(0);
                this.p.setRating(this.q.n.floatValue());
            }
        } catch (Throwable unused) {
        }
    }

    private void h() {
        try {
            if (chat.ola.vn.util.m.a(this.q.j)) {
                this.j.setVisibility(8);
            } else {
                this.j.setVisibility(0);
                chat.ola.vn.c.t.a().c(this.q.j, this.j);
            }
        } catch (Throwable unused) {
            this.j.setVisibility(8);
        }
    }

    private void i() {
        this.n.setFullText(this.b.c);
        this.n.setOnEclipesizeListener(null);
        this.n.a();
    }

    @Override // chat.ola.vn.entry.b.j
    @TargetApi(11)
    public void a() {
        if (this.b == null) {
            return;
        }
        this.q = this.b.b.a;
        if (this.q == null) {
            return;
        }
        try {
            if (this.a != null) {
                View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.entry.b.x.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(x.this.q);
                        x.this.a.onClick(view);
                    }
                };
                this.i.setOnClickListener(onClickListener);
                if (this.w == null) {
                    this.w = new View.OnTouchListener() { // from class: chat.ola.vn.entry.b.x.2
                        @Override // android.view.View.OnTouchListener
                        public boolean onTouch(View view, MotionEvent motionEvent) {
                            int actionMasked = motionEvent.getActionMasked();
                            if (actionMasked != 1 && actionMasked != 6) {
                                return true;
                            }
                            view.setTag(x.this.q);
                            x.this.a.onClick(view);
                            return true;
                        }
                    };
                }
                this.p.setOnTouchListener(this.w);
                this.r.setOnClickListener(onClickListener);
            }
        } catch (Throwable unused) {
        }
        g();
        h();
        i();
        if (!chat.ola.vn.util.m.a(this.q.b)) {
            this.b.m = this.q.b;
            this.r.setVisibility(0);
            this.s.setVisibility(0);
            e();
            return;
        }
        if (chat.ola.vn.util.m.a(this.q.k)) {
            this.r.setVisibility(8);
            return;
        }
        this.r.setVisibility(0);
        this.s.setVisibility(8);
        f();
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(View view) {
        super.a(view);
        try {
            this.i = view.findViewById(R.id.advSoftwareFrameLayout);
            this.r = view.findViewById(R.id.advSoftwareVideoLayout);
            this.s = view.findViewById(R.id.advSoftwareVideoInfoLayout);
            this.j = (OlaCachedImageView) view.findViewById(R.id.advSoftwareIconImageView);
            this.k = (OlaRatioImageView) view.findViewById(R.id.advSoftwareImageView);
            this.l = (TextView) view.findViewById(R.id.advSoftwareTitleTextView);
            this.n = (CommpressTextView) view.findViewById(R.id.advSoftwareIntroTextView);
            this.m = (TextView) view.findViewById(R.id.advSoftwareSloganTextView);
            this.o = (TextView) view.findViewById(R.id.advSoftwareInstallDetailTextView);
            this.p = (RatingBar) view.findViewById(R.id.advSoftwareRatingBar);
            this.t = (TextView) view.findViewById(R.id.advSoftwareVideoTitleTextView);
            this.u = (TextView) view.findViewById(R.id.advSoftwareVideoDurationTextView);
            this.v = view.getContext().getResources().getDimensionPixelSize(R.dimen.metric_8dp);
        } catch (Throwable unused) {
        }
    }
}
