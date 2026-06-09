package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class m extends l {
    private TextView a;
    private ImageView e;
    private TextView f;
    private View g;
    private TextView h;
    private View i;
    private View j;
    private chat.ola.vn.entity.t k;
    private View l;
    private OlaCachedImageView m;
    private OlaCachedImageView n;
    private OlaCachedImageView o;

    public m(View view) {
        super(view);
        this.a = (TextView) view.findViewById(R.id.txtNewsItemLikeNumber);
        this.e = (ImageView) view.findViewById(R.id.txtNewsItemLikeIcon);
        this.f = (TextView) view.findViewById(R.id.txtNewsItemLikeTextView);
        this.g = view.findViewById(R.id.txtNewsItemLikeWrapper);
        this.h = (TextView) view.findViewById(R.id.txtNewsCommentCount);
        this.i = view.findViewById(R.id.btnNewsViewComment);
        this.j = view.findViewById(R.id.shareWrapper);
        this.l = view.findViewById(R.id.btnNewsItemLikeSpan);
        this.m = (OlaCachedImageView) view.findViewById(R.id.imgNewsItemLikeBuddy1);
        this.n = (OlaCachedImageView) view.findViewById(R.id.imgNewsItemLikeBuddy2);
        this.o = (OlaCachedImageView) view.findViewById(R.id.imgNewsItemLikeBuddy3);
    }

    private void a() {
        if (this.k.s() == 0) {
            this.l.setVisibility(4);
            return;
        }
        this.l.setTag(this.k);
        this.l.setOnClickListener(this.b);
        this.l.setVisibility(0);
        if (this.k.s() >= 3) {
            this.m.setVisibility(0);
            a(this.m, this.k.d(0));
            this.n.setVisibility(0);
            a(this.n, this.k.d(1));
            this.o.setVisibility(0);
            a(this.o, this.k.d(2));
        } else {
            this.o.setVisibility(8);
        }
        if (this.k.s() >= 2) {
            this.m.setVisibility(0);
            a(this.m, this.k.d(0));
            this.n.setVisibility(0);
            a(this.n, this.k.d(1));
        } else {
            this.n.setVisibility(8);
        }
        if (this.k.s() < 1) {
            this.m.setVisibility(8);
        } else {
            this.m.setVisibility(0);
            a(this.m, this.k.d(0));
        }
    }

    private void a(OlaCachedImageView olaCachedImageView, String str) {
        try {
            chat.ola.vn.c.t.a().f(str, olaCachedImageView);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.l
    public void a(chat.ola.vn.entry.c cVar, int i) {
        TextView textView;
        StringBuilder sb;
        int i2;
        TextView textView2;
        int i3;
        TextView textView3;
        StringBuilder sb2;
        int i4;
        this.k = cVar.b();
        this.g.setTag(this.k);
        this.i.setTag(this.k);
        this.j.setTag(this.k);
        this.g.setOnClickListener(this.b);
        this.i.setOnClickListener(this.b);
        this.j.setOnClickListener(this.b);
        if (this.k.r() == 0) {
            this.i.setVisibility(8);
            this.j.setVisibility(8);
            this.g.setVisibility(8);
            return;
        }
        this.g.setVisibility(0);
        this.j.setVisibility(0);
        if (cVar.a() == 0) {
            this.h.setText("");
        } else {
            if (cVar.a() > 1) {
                textView = this.h;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(cVar.a()));
                sb.append(" ");
                i2 = R.string.string_comment_plural;
            } else {
                textView = this.h;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(cVar.a()));
                sb.append(" ");
                i2 = R.string.string_comment;
            }
            sb.append(OlaApplication.a(i2));
            textView.setText(sb.toString());
        }
        int iS = this.k.s();
        if (iS > 0) {
            if (this.k.v() == 1) {
                this.e.setImageResource(R.drawable.ic_like_selected);
                textView2 = this.f;
                i3 = chat.ola.vn.f.H;
            } else {
                this.e.setImageResource(R.drawable.ic_like_gray);
                textView2 = this.f;
                i3 = chat.ola.vn.f.z;
            }
            textView2.setTextColor(i3);
            if (iS > 1) {
                textView3 = this.a;
                sb2 = new StringBuilder();
                sb2.append(chat.ola.vn.util.m.a(iS));
                sb2.append(" ");
                i4 = R.string.string_like_plural;
            } else {
                textView3 = this.a;
                sb2 = new StringBuilder();
                sb2.append(chat.ola.vn.util.m.a(iS));
                sb2.append(" ");
                i4 = R.string.string_like_single;
            }
            sb2.append(OlaApplication.a(i4));
            textView3.setText(sb2.toString());
        } else {
            this.e.setImageResource(R.drawable.ic_like_gray);
            this.a.setText("");
        }
        a();
    }
}
