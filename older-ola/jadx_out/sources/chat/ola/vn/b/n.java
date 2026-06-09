package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class n extends j<chat.ola.vn.message.f> {
    protected List<chat.ola.vn.message.f> a;
    private LayoutInflater b;

    public n(Context context) {
        super(context);
    }

    private LayoutInflater a() {
        if (this.b == null) {
            this.b = (LayoutInflater) OlaApplication.a().getSystemService("layout_inflater");
        }
        return this.b;
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        chat.ola.vn.g.k kVar;
        chat.ola.vn.message.f item;
        try {
            chat.ola.vn.message.f item2 = getItem(i);
            chat.ola.vn.message.f item3 = null;
            if (view == null) {
                View viewInflate = a().inflate(R.layout.contact_item_layout, (ViewGroup) null);
                try {
                    kVar = new chat.ola.vn.g.k(item2, viewInflate);
                    view = viewInflate;
                } catch (Throwable th) {
                    th = th;
                    view = viewInflate;
                    th.printStackTrace();
                }
            } else {
                kVar = view.getTag() == null ? new chat.ola.vn.g.k(item2, view) : (chat.ola.vn.g.k) view.getTag();
            }
            kVar.a(item2);
            kVar.k = true;
            kVar.l = false;
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
        } catch (Throwable th2) {
            th = th2;
        }
        return view == null ? viewGroup : view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.message.f getItem(int i) {
        try {
            return this.a.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(List<chat.ola.vn.message.f> list) {
        if (list == null) {
            return;
        }
        this.a = new ArrayList(list);
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.a.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 1;
    }
}
