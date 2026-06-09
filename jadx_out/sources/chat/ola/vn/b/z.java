package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

/* JADX INFO: loaded from: classes.dex */
public class z extends j<chat.ola.vn.message.f> {
    private LayoutInflater a;

    public z(Context context) {
        super(context);
    }

    private LayoutInflater a() {
        if (this.a == null) {
            this.a = (LayoutInflater) OlaApplication.a().getSystemService("layout_inflater");
        }
        return this.a;
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        chat.ola.vn.g.k kVar;
        chat.ola.vn.message.f item;
        try {
            chat.ola.vn.message.f item2 = getItem(i);
            chat.ola.vn.message.f item3 = null;
            if (item2.k() == 6) {
                if (view == null) {
                    View viewInflate = this.a.inflate(R.layout.conversation_admob_native_item_layout, (ViewGroup) null);
                    try {
                        chat.ola.vn.util.a.a(viewInflate, this.a);
                        ((chat.ola.vn.message.a) item2).a = 0L;
                        view = viewInflate;
                    } catch (Throwable th) {
                        view = viewInflate;
                        th = th;
                        th.printStackTrace();
                    }
                }
                if (System.currentTimeMillis() - ((chat.ola.vn.message.a) item2).a >= 180000) {
                    ((chat.ola.vn.message.a) item2).a = System.currentTimeMillis();
                    ((AdView) view.getTag()).loadAd(new AdRequest.Builder().build());
                }
            } else {
                if (view == null) {
                    View viewInflate2 = a().inflate(R.layout.contact_item_layout, (ViewGroup) null);
                    try {
                        kVar = new chat.ola.vn.g.k(item2, viewInflate2);
                        view = viewInflate2;
                    } catch (Throwable th2) {
                        th = th2;
                        view = viewInflate2;
                        th.printStackTrace();
                    }
                } else {
                    kVar = view.getTag() == null ? new chat.ola.vn.g.k(item2, view) : (chat.ola.vn.g.k) view.getTag();
                }
                kVar.a(item2);
                kVar.k = true;
                kVar.l = true;
                view.setTag(kVar);
                try {
                    item = getItem(i - 1);
                } catch (Throwable unused) {
                    item = null;
                }
                try {
                    item3 = getItem(i + 1);
                } catch (Throwable unused2) {
                }
                if (item != null) {
                    kVar.b(false);
                } else {
                    kVar.b(true);
                }
                if (item3 != null) {
                    kVar.a(false);
                } else {
                    kVar.a(true);
                }
                kVar.a(i);
            }
        } catch (Throwable th3) {
            th = th3;
        }
        return view == null ? viewGroup : view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.message.f getItem(int i) {
        try {
            return chat.ola.vn.h.x.c(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return chat.ola.vn.h.x.g();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        try {
            return getItem(i).k() == 6 ? 1 : 0;
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 2;
    }
}
