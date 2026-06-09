package chat.ola.vn.b;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import chat.ola.vn.OlaApplication;

/* JADX INFO: loaded from: classes.dex */
public class m extends BaseAdapter {
    private LayoutInflater a;

    private LayoutInflater a() {
        if (this.a == null) {
            this.a = (LayoutInflater) OlaApplication.a().getSystemService("layout_inflater");
        }
        return this.a;
    }

    @Override // android.widget.Adapter
    public int getCount() {
        try {
            return chat.ola.vn.h.t.E();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        try {
            chat.ola.vn.h.t.d(i);
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return 0;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        if (view == null) {
            try {
                view = new chat.ola.vn.g.d(null).a(a());
            } catch (Throwable th) {
                th.printStackTrace();
                return view;
            }
        }
        chat.ola.vn.g.k kVar = (chat.ola.vn.g.k) view.getTag();
        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(i);
        if (kVar == null) {
            kVar = new chat.ola.vn.g.k(fVarD, view);
        }
        kVar.a(fVarD);
        if (i >= getCount() - 1) {
            kVar.a(true);
        } else {
            kVar.a(false);
        }
        view.setTag(kVar);
        kVar.a(i);
        return view;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 1;
    }
}
