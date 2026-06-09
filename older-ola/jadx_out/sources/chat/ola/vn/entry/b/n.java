package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class n extends l {
    private View a;
    private View e;
    private View f;
    private View g;
    private chat.ola.vn.entry.d h;

    public n(View view) {
        super(view);
        try {
            this.a = view.findViewById(R.id.relatedArticle1);
            this.e = view.findViewById(R.id.relatedArticle2);
            this.f = view.findViewById(R.id.relatedArticle3);
            this.g = view.findViewById(R.id.viewAllTextView);
        } catch (Throwable unused) {
        }
    }

    private void a(OlaCachedImageView olaCachedImageView, String str, int i) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        try {
            olaCachedImageView.setVisibility(0);
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            chat.ola.vn.c.t.a().b(str, olaCachedImageView, i);
        } catch (Throwable unused) {
        }
    }

    public void a(View view, chat.ola.vn.entity.ad adVar) {
        try {
            TextView textView = (TextView) view.findViewById(R.id.txtNewsTitle);
            TextView textView2 = (TextView) view.findViewById(R.id.txtNewsSubTitle);
            View viewFindViewById = view.findViewById(R.id.subTitleLayout);
            OlaCachedImageView olaCachedImageView = (OlaCachedImageView) view.findViewById(R.id.imgNewsThumbnail);
            int iMax = Math.max(chat.ola.vn.e.c, chat.ola.vn.e.d);
            textView.setText(adVar.p());
            if (chat.ola.vn.util.m.a(adVar.n())) {
                if (viewFindViewById != null) {
                    viewFindViewById.setVisibility(8);
                }
                if (textView2 != null) {
                    textView2.setVisibility(8);
                }
            } else {
                if (viewFindViewById != null) {
                    viewFindViewById.setVisibility(0);
                }
                if (textView2 != null) {
                    textView2.setVisibility(0);
                    textView2.setText(adVar.n());
                }
            }
            String strH = adVar.h();
            if (chat.ola.vn.util.m.a(strH)) {
                olaCachedImageView.setVisibility(8);
            } else {
                olaCachedImageView.setVisibility(0);
                a(olaCachedImageView, strH, iMax);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.l
    public void a(chat.ola.vn.entry.c cVar, int i) {
        View view;
        try {
            this.h = (chat.ola.vn.entry.d) cVar;
            if (this.h != null && this.h.b.size() != 0) {
                switch (this.h.b.size()) {
                    case 1:
                        this.a.setVisibility(0);
                        this.e.setVisibility(8);
                        this.f.setVisibility(8);
                        break;
                    case 2:
                        this.a.setVisibility(0);
                        this.e.setVisibility(0);
                        this.f.setVisibility(8);
                        break;
                    default:
                        this.a.setVisibility(0);
                        this.e.setVisibility(0);
                        this.f.setVisibility(0);
                        break;
                }
                try {
                    this.g.setTag(this.h.c);
                    this.g.setOnClickListener(this.b);
                } catch (Throwable unused) {
                }
                if (chat.ola.vn.util.m.a(this.h.c)) {
                    this.g.setVisibility(8);
                } else {
                    this.g.setVisibility(0);
                }
                int size = this.h.b.size();
                for (int i2 = 0; i2 < size; i2++) {
                    chat.ola.vn.entity.ad adVar = this.h.b.get(i2);
                    switch (i2) {
                        case 0:
                            a(this.a, adVar);
                            this.a.setTag(adVar);
                            view = this.a;
                            view.setOnClickListener(this.b);
                            break;
                        case 1:
                            a(this.e, adVar);
                            this.e.setTag(adVar);
                            view = this.e;
                            view.setOnClickListener(this.b);
                            break;
                        case 2:
                            a(this.f, adVar);
                            try {
                                this.f.setTag(adVar);
                                view = this.f;
                                view.setOnClickListener(this.b);
                            } catch (Throwable unused2) {
                            }
                            break;
                    }
                }
                return;
            }
            this.a.setVisibility(8);
            this.e.setVisibility(8);
            this.f.setVisibility(8);
        } catch (Throwable unused3) {
        }
    }
}
