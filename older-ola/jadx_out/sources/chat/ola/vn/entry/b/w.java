package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import com.mg.ola.common.widget.CommpressTextView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class w extends j {
    private LinearLayout A;
    private OlaCachedImageView B;
    private OlaCachedImageView C;
    private OlaCachedImageView D;
    private OlaCachedImageView i;
    private View j;
    private TextView k;
    private TextView l;
    private TextView m;
    private TextView n;
    private CommpressTextView o;
    private View p;
    private View q;
    private View r;
    private TextView s;
    private ImageView t;
    private View u;
    private TextView v;
    private ImageView w;
    private View x;
    private TextView y;
    private ImageView z;

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void a(View view, ImageView imageView, TextView textView, chat.ola.vn.entity.d dVar) {
        int i;
        TextView textView2;
        StringBuilder sb;
        int i2;
        if (!chat.ola.vn.util.m.b(dVar.a(), "like") && !chat.ola.vn.util.m.b(dVar.a(), "likeadme")) {
            textView.setVisibility(0);
            textView.setTextColor(chat.ola.vn.f.A);
            textView.setText(dVar.d());
            view.setTag(dVar);
            view.setVisibility(0);
            imageView.setVisibility(8);
            view.setSelected(false);
            return;
        }
        view.setTag(dVar);
        view.setVisibility(0);
        imageView.setVisibility(0);
        textView.setText(R.string.string_like);
        if (this.b.b.f() > 0) {
            this.n.setVisibility(0);
            if (this.b.b.f() > 1) {
                textView2 = this.n;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(this.b.b.f()));
                sb.append(" ");
                i2 = R.string.string_like_plural;
            } else {
                textView2 = this.n;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(this.b.b.f()));
                sb.append(" ");
                i2 = R.string.string_like_single;
            }
            sb.append(OlaApplication.a(i2));
            textView2.setText(sb.toString());
        } else {
            this.n.setVisibility(8);
        }
        if (this.b.b.i() == 1) {
            imageView.setImageResource(R.drawable.ic_like_selected);
            i = chat.ola.vn.f.H;
        } else {
            imageView.setImageResource(R.drawable.ic_like_gray);
            i = chat.ola.vn.f.A;
        }
        textView.setTextColor(i);
    }

    private void e() {
        try {
            chat.ola.vn.c.t.a().b(this.b.i.get(0), this.i, this.h);
        } catch (Throwable unused) {
            this.i.setVisibility(8);
        }
    }

    private void f() {
        View view;
        View view2;
        ImageView imageView;
        TextView textView;
        List<chat.ola.vn.entity.d> listR = this.b.b.r();
        if (listR == null || listR.size() == 0) {
            this.q.setVisibility(8);
            return;
        }
        this.q.setVisibility(0);
        for (int i = 0; i < 3; i++) {
            try {
                chat.ola.vn.entity.d dVar = listR.get(i);
                try {
                    dVar.a = this.b.b;
                    dVar.i(this.b.b.u());
                } catch (Throwable unused) {
                }
                switch (i) {
                    case 0:
                        view2 = this.r;
                        imageView = this.t;
                        textView = this.s;
                        a(view2, imageView, textView, dVar);
                        break;
                    case 1:
                        view2 = this.u;
                        imageView = this.w;
                        textView = this.v;
                        a(view2, imageView, textView, dVar);
                        break;
                    case 2:
                        view2 = this.x;
                        imageView = this.z;
                        textView = this.y;
                        a(view2, imageView, textView, dVar);
                        break;
                }
            } catch (Throwable unused2) {
                switch (i) {
                    case 0:
                        view = this.r;
                        view.setVisibility(8);
                        break;
                    case 1:
                        view = this.u;
                        view.setVisibility(8);
                        break;
                    case 2:
                        view = this.x;
                        view.setVisibility(8);
                        break;
                }
            }
        }
    }

    private void g() {
        try {
            String strT = this.b.b.t();
            if (chat.ola.vn.util.m.a(strT)) {
                this.k.setText(OlaApplication.a(R.string.string_sponsor));
            } else {
                this.k.setText(strT);
            }
        } catch (Throwable unused) {
        }
    }

    private void h() {
        try {
            long jA = this.b.b.A();
            if (jA > 1000) {
                String str = "" + chat.ola.vn.util.m.a(jA);
                if (jA >= 1000000000) {
                    str = chat.ola.vn.util.m.a(jA / 1000000) + "M";
                } else if (jA >= 1000000) {
                    str = chat.ola.vn.util.m.a(jA / 1000) + "K";
                }
                this.m.setVisibility(0);
                this.m.setText(str + " " + OlaApplication.a(R.string.string_view_count));
            } else {
                this.m.setVisibility(8);
            }
        } catch (Throwable unused) {
            this.m.setVisibility(8);
        }
        try {
            chat.ola.vn.entity.d dVarS = this.b.b.s();
            String string = this.b.b().toString();
            if (dVarS != null && !chat.ola.vn.util.m.a(dVarS.d())) {
                string = dVarS.d();
            }
            this.l.setVisibility(0);
            this.l.setText(string);
        } catch (Throwable unused2) {
            this.l.setVisibility(8);
        }
    }

    private void i() {
        this.o.setFullText(this.b.c);
        this.o.setOnEclipesizeListener(null);
        if (this.b.e()) {
            this.o.a();
        } else {
            this.o.b();
        }
        this.o.setOnEclipesizeListener(new CommpressTextView.a() { // from class: chat.ola.vn.entry.b.w.2
            @Override // com.mg.ola.common.widget.CommpressTextView.a
            public void a(boolean z) {
                w.this.b.a(z);
            }
        });
    }

    private void j() {
        LinearLayout linearLayout;
        String[] strArrE = this.b.b.E();
        int i = 8;
        if (strArrE != null && strArrE.length > 0) {
            this.A.setVisibility(0);
            switch (strArrE.length) {
                case 0:
                    linearLayout = this.A;
                    i = 4;
                    break;
                case 1:
                    this.A.setVisibility(0);
                    this.B.setVisibility(0);
                    chat.ola.vn.c.t.a().f(strArrE[0], this.B);
                    this.C.setVisibility(8);
                    this.D.setVisibility(8);
                    break;
                case 2:
                    this.A.setVisibility(0);
                    this.B.setVisibility(0);
                    chat.ola.vn.c.t.a().f(strArrE[0], this.B);
                    this.C.setVisibility(0);
                    chat.ola.vn.c.t.a().f(strArrE[1], this.C);
                    this.D.setVisibility(8);
                    break;
                default:
                    this.A.setVisibility(0);
                    this.B.setVisibility(0);
                    chat.ola.vn.c.t.a().f(strArrE[0], this.B);
                    this.C.setVisibility(0);
                    chat.ola.vn.c.t.a().f(strArrE[1], this.C);
                    this.D.setVisibility(0);
                    chat.ola.vn.c.t.a().f(strArrE[2], this.D);
                    break;
            }
            return;
        }
        linearLayout = this.A;
        linearLayout.setVisibility(i);
    }

    @Override // chat.ola.vn.entry.b.j
    @TargetApi(11)
    public void a() {
        try {
            if (this.b == null) {
                return;
            }
            if (this.a != null) {
                this.j.setTag(this.b);
                this.j.setOnClickListener(this.a);
                this.l.setTag(this.b);
                this.l.setOnClickListener(this.a);
                this.m.setTag(this.b);
                this.m.setOnClickListener(this.a);
                this.q.setTag(this.b);
                this.q.setOnClickListener(this.a);
                this.r.setTag(this.b);
                this.r.setOnClickListener(this.a);
                this.u.setTag(this.b);
                this.u.setOnClickListener(this.a);
                this.x.setTag(this.b);
                this.x.setOnClickListener(this.a);
                this.A.setTag(this.b);
                this.A.setOnClickListener(this.a);
                View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.entry.b.w.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(w.this.b);
                        w.this.a.onClick(view);
                    }
                };
                this.i.setOnClickListener(onClickListener);
                this.p.setOnClickListener(onClickListener);
                if (chat.ola.vn.h.H > 0) {
                    this.p.setVisibility(8);
                } else {
                    this.p.setVisibility(0);
                }
            }
            if (this.b.i == null || this.b.i.size() == 0) {
                this.i.setVisibility(8);
            } else {
                e();
            }
            g();
            h();
            i();
            f();
            j();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(View view) {
        super.a(view);
        view.setClickable(true);
        try {
            this.j = view.findViewById(R.id.txtAdMeTitleContainer);
            this.k = (TextView) view.findViewById(R.id.txtAdMeTitle);
            this.i = (OlaCachedImageView) view.findViewById(R.id.advImage);
            this.l = (TextView) view.findViewById(R.id.advProductTitle);
            this.m = (TextView) view.findViewById(R.id.advViewCount);
            this.n = (TextView) view.findViewById(R.id.advItemLikeNumber);
            this.o = (CommpressTextView) view.findViewById(R.id.advTextContent);
            this.o.setMoreText(OlaApplication.a(R.string.string_view_more));
            this.o.setEclipesizeMaxLine(16);
            this.p = view.findViewById(R.id.btnAdMeClose);
            this.q = view.findViewById(R.id.advButtonSpan);
            this.r = view.findViewById(R.id.advButton1);
            this.s = (TextView) view.findViewById(R.id.advButtonText1);
            this.t = (ImageView) view.findViewById(R.id.advButtonIcon1);
            this.u = view.findViewById(R.id.advButton2);
            this.v = (TextView) view.findViewById(R.id.advButtonText2);
            this.w = (ImageView) view.findViewById(R.id.advButtonIcon2);
            this.x = view.findViewById(R.id.advButton3);
            this.y = (TextView) view.findViewById(R.id.advButtonText3);
            this.z = (ImageView) view.findViewById(R.id.advButtonIcon3);
            this.i.a(null, null);
            this.A = (LinearLayout) view.findViewById(R.id.btnAdMeItemLikeSpan);
            this.B = (OlaCachedImageView) view.findViewById(R.id.imgMeItemLikeBuddy1);
            this.C = (OlaCachedImageView) view.findViewById(R.id.imgMeItemLikeBuddy2);
            this.D = (OlaCachedImageView) view.findViewById(R.id.imgMeItemLikeBuddy3);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(boolean z) {
        super.a(z);
    }
}
