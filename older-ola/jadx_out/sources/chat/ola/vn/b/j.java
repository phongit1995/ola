package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;

/* JADX INFO: loaded from: classes.dex */
public abstract class j<T> extends BaseAdapter implements Filterable {
    private Context a;
    protected LayoutInflater e;
    protected a f;

    public interface a {
        boolean B();

        void a_(int i);
    }

    public j(Context context) {
        this.a = context;
        this.e = LayoutInflater.from(context);
    }

    private void a(int i) {
        try {
            int count = getCount();
            if (count == 0 || i == 0) {
                return;
            }
            int i2 = count - 1;
            int i3 = i2 - 5;
            if (i3 < 0) {
                i3 = i2;
            }
            if (i == i3 && this.f != null && this.f.B()) {
                this.f.a_(i2);
            }
        } catch (Throwable unused) {
        }
    }

    public abstract View a(int i, View view, ViewGroup viewGroup);

    public void a(a aVar) {
        this.f = aVar;
    }

    public Context b() {
        return this.a;
    }

    @Override // android.widget.Adapter
    public abstract int getCount();

    public Filter getFilter() {
        return null;
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.Adapter
    public final View getView(int i, View view, ViewGroup viewGroup) {
        View viewA = a(i, view, viewGroup);
        a(i);
        return viewA;
    }
}
