package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaRatioImageView;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

/* JADX INFO: loaded from: classes.dex */
public class aj extends j<chat.ola.vn.entity.t> {
    private LayoutInflater a;
    private chat.ola.vn.entity.t b;
    private long c;

    private static class a {
        public OlaRatioImageView a;
        public TextView b;
        public TextView c;
        public View d;
        private chat.ola.vn.entity.t e;

        private a() {
        }

        public static View a(LayoutInflater layoutInflater, ViewGroup viewGroup, chat.ola.vn.entity.t tVar, int i, int i2, short s) {
            int i3 = R.layout.rss_article_default_layout;
            switch (i2) {
                case 0:
                    break;
                case 1:
                    i3 = R.layout.rss_article_pic_and_description_layout;
                    break;
                case 2:
                    i3 = R.layout.rss_article_magazine_layout;
                    break;
                default:
                    if (s == 0 || s == 1) {
                        i3 = R.layout.rss_publisher_layout;
                    }
                    break;
            }
            View viewInflate = layoutInflater.inflate(i3, viewGroup, false);
            a aVar = new a();
            aVar.a = (OlaRatioImageView) viewInflate.findViewById(R.id.imgNewsThumbnail);
            aVar.b = (TextView) viewInflate.findViewById(R.id.txtNewsTitle);
            try {
                aVar.a.setMaxHeight(chat.ola.vn.e.d);
                aVar.c = (TextView) viewInflate.findViewById(R.id.txtNewsSubTitle);
            } catch (Throwable unused) {
            }
            try {
                aVar.d = viewInflate.findViewById(R.id.subTitleLayout);
            } catch (Throwable unused2) {
            }
            viewInflate.setTag(aVar);
            return viewInflate;
        }

        private boolean a(int i) {
            if (chat.ola.vn.util.m.a(this.e.h())) {
                this.a.a(null, null);
                this.a.setVisibility(8);
                return false;
            }
            try {
                this.a.setVisibility(0);
                chat.ola.vn.c.t.a().b(this.e.h(), this.a, i);
                return true;
            } catch (Throwable unused) {
                return true;
            }
        }

        public void a(chat.ola.vn.entity.t tVar, int i) {
            try {
                int iMax = Math.max(chat.ola.vn.e.c, chat.ola.vn.e.d);
                this.e = tVar;
                this.b.setText(this.e.p());
                if (chat.ola.vn.util.m.a(this.e.n())) {
                    if (this.d != null) {
                        this.d.setVisibility(8);
                    }
                    if (this.c != null) {
                        this.c.setVisibility(8);
                    }
                } else {
                    if (this.d != null) {
                        this.d.setVisibility(0);
                    }
                    if (this.c != null) {
                        this.c.setVisibility(0);
                        this.c.setText(tVar.n());
                    }
                }
                a(iMax);
            } catch (Throwable unused) {
            }
        }
    }

    public aj(Context context) {
        super(context);
        this.c = 0L;
        this.a = LayoutInflater.from(context);
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        View viewInflate;
        chat.ola.vn.entity.t item = getItem(i);
        int itemViewType = getItemViewType(i);
        if (itemViewType != 3) {
            if (view == null) {
                view = a.a(this.a, viewGroup, item, i, itemViewType, this.b.m());
            }
            ((a) view.getTag()).a(item, i);
            return view;
        }
        if (view == null) {
            if (this.b.m() == 0 || this.b.m() == 1) {
                viewInflate = this.a.inflate(R.layout.rss_admob_native_small_layout, (ViewGroup) null);
                chat.ola.vn.util.a.a(viewInflate, this.a);
            } else {
                viewInflate = this.a.inflate(R.layout.rss_admob_native_medium_layout, (ViewGroup) null);
                chat.ola.vn.util.a.b(viewInflate, this.a);
            }
            view = viewInflate;
            this.c = 0L;
        }
        if (System.currentTimeMillis() - this.c >= 60000) {
            this.c = System.currentTimeMillis();
            ((AdView) view.getTag()).loadAd(new AdRequest.Builder().build());
        }
        return view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.t getItem(int i) {
        if (this.b == null) {
            return null;
        }
        return this.b.a(i);
    }

    public void a(chat.ola.vn.entity.t tVar) {
        this.b = tVar;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.b.i();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        chat.ola.vn.entity.t item = getItem(i);
        if (chat.ola.vn.util.m.a(item.h()) && chat.ola.vn.util.m.a(item.p()) && chat.ola.vn.util.m.a(item.n())) {
            return 3;
        }
        if (!chat.ola.vn.util.m.a(item.h())) {
            if (chat.ola.vn.util.m.a(item.p()) || chat.ola.vn.util.m.a(item.n())) {
                return 1;
            }
            int[] iArrB = chat.ola.vn.entity.i.b(item.h());
            try {
                if (iArrB[0] / iArrB[1] >= 1.7777778f) {
                    return 2;
                }
            } catch (Throwable unused) {
            }
        }
        return 0;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 4;
    }
}
