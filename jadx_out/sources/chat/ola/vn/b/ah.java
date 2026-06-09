package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ah extends j<Object> {
    private List<chat.ola.vn.entry.c> a;
    private List<chat.ola.vn.entry.b> b;
    private LayoutInflater c;
    private View.OnClickListener d;
    private View.OnLongClickListener g;
    private float h;
    private chat.ola.vn.entity.t i;
    private int j;
    private int k;
    private View l;
    private long m;

    public ah(Context context) {
        super(context);
        this.l = null;
        this.m = 0L;
        this.c = LayoutInflater.from(context);
        this.j = context.getResources().getDimensionPixelSize(R.dimen.metric_8dp);
        this.k = context.getResources().getDimensionPixelSize(R.dimen.metric_16dp);
    }

    private View a(int i, View view, ViewGroup viewGroup, int i2) {
        try {
            chat.ola.vn.entry.c cVar = (chat.ola.vn.entry.c) getItem(i);
            if (view == null) {
                if (i2 == 5 && cVar.a == null) {
                    this.m = 0L;
                }
                view = chat.ola.vn.entry.b.l.a(b(), this.c, cVar, i2);
            }
            if (i2 == 5 && cVar.a == null && System.currentTimeMillis() - this.m >= 60000) {
                this.m = System.currentTimeMillis();
                ((AdView) view.getTag()).loadAd(new AdRequest.Builder().build());
            }
            chat.ola.vn.entry.b.l lVar = (chat.ola.vn.entry.b.l) view.getTag();
            if (lVar != null) {
                lVar.a(this.d);
                lVar.a(this.g);
                lVar.a(this.h);
                lVar.a(cVar, i);
            }
        } catch (Throwable unused) {
        }
        return view;
    }

    private void a(OlaCachedImageView olaCachedImageView) {
        if (olaCachedImageView != null) {
            chat.ola.vn.c.t.a().g(chat.ola.vn.h.a(), olaCachedImageView);
        }
    }

    private int c() {
        if (this.a == null) {
            return 0;
        }
        return this.a.size();
    }

    public int a() {
        int size;
        try {
            size = this.b.size();
        } catch (Throwable unused) {
            size = 0;
        }
        return this.i.r() != 0 ? size + 1 : size;
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        View viewC;
        chat.ola.vn.entry.b.j jVarA;
        int itemViewType = getItemViewType(i);
        if (itemViewType < 7) {
            return a(i, view, viewGroup, itemViewType);
        }
        if (itemViewType == 16) {
            if (view == null) {
                this.l = this.c.inflate(R.layout.rss_comment_input_span, viewGroup, false);
                a((OlaCachedImageView) this.l.findViewById(R.id.imgRssItemAvatar));
                if (this.d != null) {
                    this.l.findViewById(R.id.txtRssCommentInput).setOnClickListener(this.d);
                }
                return this.l;
            }
            try {
                View viewFindViewById = this.l.findViewById(R.id.linearRssCommentSpan);
                if (a() == 1) {
                    viewFindViewById.setBackgroundResource(R.drawable.bg_shadow_2_edges);
                } else {
                    viewFindViewById.setBackgroundResource(R.drawable.bg_me_comment_top_item);
                }
                viewFindViewById.setPadding(this.k, this.k, this.k, this.k);
                return view;
            } catch (Throwable unused) {
                return view;
            }
        }
        int i2 = itemViewType - 7;
        if (view == null) {
            jVarA = chat.ola.vn.entry.b.i.a(i2, view, this.c);
            viewC = jVarA.c();
        } else {
            try {
                viewC = view;
                jVarA = (chat.ola.vn.entry.b.j) view.getTag();
            } catch (Throwable unused2) {
                jVarA = chat.ola.vn.entry.b.i.a(i2, view, this.c);
                viewC = jVarA.c();
            }
        }
        chat.ola.vn.entry.b bVar = (chat.ola.vn.entry.b) getItem(i);
        jVarA.a(this.d);
        jVarA.a(this.g);
        jVarA.a(bVar);
        jVarA.b();
        jVarA.a();
        jVarA.a(false);
        a(i, jVarA, bVar);
        return viewC;
    }

    public void a(float f) {
        if (this.h != f) {
            this.h = f;
            notifyDataSetChanged();
        }
    }

    protected void a(int i, chat.ola.vn.entry.b.j jVar, chat.ola.vn.entry.b bVar) {
        jVar.a(i == getCount() - 1 ? R.drawable.bg_me_comment_item_footer : R.drawable.bg_me_comment_item);
        jVar.a(this.j, 1, this.j, 0);
    }

    public void a(View.OnClickListener onClickListener) {
        this.d = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.g = onLongClickListener;
    }

    public void a(chat.ola.vn.entity.t tVar) {
        if (tVar == null) {
            this.a = null;
            this.b = null;
        } else {
            this.a = tVar.e();
            this.b = tVar.d();
            this.i = tVar;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return c() + a();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        try {
            int iC = c();
            return i < iC ? this.a.get(i) : (i != iC || this.i.r() == 0) ? this.i.r() != 0 ? this.b.get((i - 1) - iC) : this.b.get(i - iC) : new Object();
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        int iC = c();
        if (i < iC) {
            return this.a.get(i).c();
        }
        if (i != iC || this.i.r() == 0) {
            return this.i.r() != 0 ? this.b.get((i - 1) - iC).d() + 7 : this.b.get(i - iC).d() + 7;
        }
        return 16;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 17;
    }

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        if (this.i != null) {
            this.a = this.i.e();
            this.b = this.i.d();
        }
        super.notifyDataSetChanged();
    }
}
