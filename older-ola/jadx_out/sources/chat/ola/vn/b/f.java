package chat.ola.vn.b;

import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

/* JADX INFO: loaded from: classes.dex */
public class f extends BaseAdapter {
    private BaseAdapter a;
    private e b;
    private g c;
    private int d;
    private int e;

    public f(e eVar, g gVar) {
        this.b = eVar;
        this.c = gVar;
        this.c.b(eVar.getViewTypeCount());
        this.d = eVar.getViewTypeCount();
        this.e = gVar.getViewTypeCount();
        this.a = eVar;
    }

    public void a(BaseAdapter baseAdapter) {
        this.a = baseAdapter;
    }

    @Override // android.widget.Adapter
    public int getCount() {
        return this.a.getCount();
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        return this.a.getItem(i);
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return this.a == this.b ? this.b.getItemViewType(i) : this.c.getItemViewType(i);
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        return this.a.getView(i, view, viewGroup);
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return this.b.getViewTypeCount() + this.c.getViewTypeCount();
    }
}
