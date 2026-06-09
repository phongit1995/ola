package it.sephiroth.android.library.widget;

import android.database.DataSetObserver;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ListAdapter;
import android.widget.WrapperListAdapter;
import it.sephiroth.android.library.widget.HListView;
import java.util.ArrayList;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
public class b implements Filterable, WrapperListAdapter {
    static final ArrayList<HListView.b> c = new ArrayList<>();
    ArrayList<HListView.b> a;
    ArrayList<HListView.b> b;
    boolean d;
    private final ListAdapter e;
    private final boolean f;

    public b(ArrayList<HListView.b> arrayList, ArrayList<HListView.b> arrayList2, ListAdapter listAdapter) {
        this.e = listAdapter;
        this.f = listAdapter instanceof Filterable;
        this.a = arrayList == null ? c : arrayList;
        if (arrayList2 == null) {
            this.b = c;
        } else {
            this.b = arrayList2;
        }
        this.d = a(this.a) && a(this.b);
    }

    private boolean a(ArrayList<HListView.b> arrayList) {
        if (arrayList == null) {
            return true;
        }
        Iterator<HListView.b> it2 = arrayList.iterator();
        while (it2.hasNext()) {
            if (!it2.next().c) {
                return false;
            }
        }
        return true;
    }

    public int a() {
        return this.a.size();
    }

    @Override // android.widget.ListAdapter
    public boolean areAllItemsEnabled() {
        if (this.e != null) {
            return this.d && this.e.areAllItemsEnabled();
        }
        return true;
    }

    public int b() {
        return this.b.size();
    }

    @Override // android.widget.Adapter
    public int getCount() {
        int iB;
        int iA;
        if (this.e != null) {
            iB = b() + a();
            iA = this.e.getCount();
        } else {
            iB = b();
            iA = a();
        }
        return iB + iA;
    }

    @Override // android.widget.Filterable
    public Filter getFilter() {
        if (this.f) {
            return ((Filterable) this.e).getFilter();
        }
        return null;
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        int iA = a();
        if (i < iA) {
            return this.a.get(i).b;
        }
        int i2 = i - iA;
        int count = 0;
        return (this.e == null || i2 >= (count = this.e.getCount())) ? this.b.get(i2 - count).b : this.e.getItem(i2);
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        int i2;
        int iA = a();
        if (this.e == null || i < iA || (i2 = i - iA) >= this.e.getCount()) {
            return -1L;
        }
        return this.e.getItemId(i2);
    }

    @Override // android.widget.Adapter
    public int getItemViewType(int i) {
        int i2;
        int iA = a();
        if (this.e == null || i < iA || (i2 = i - iA) >= this.e.getCount()) {
            return -2;
        }
        return this.e.getItemViewType(i2);
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        int iA = a();
        if (i < iA) {
            return this.a.get(i).a;
        }
        int i2 = i - iA;
        int count = 0;
        return (this.e == null || i2 >= (count = this.e.getCount())) ? this.b.get(i2 - count).a : this.e.getView(i2, view, viewGroup);
    }

    @Override // android.widget.Adapter
    public int getViewTypeCount() {
        if (this.e != null) {
            return this.e.getViewTypeCount();
        }
        return 1;
    }

    @Override // android.widget.WrapperListAdapter
    public ListAdapter getWrappedAdapter() {
        return this.e;
    }

    @Override // android.widget.Adapter
    public boolean hasStableIds() {
        if (this.e != null) {
            return this.e.hasStableIds();
        }
        return false;
    }

    @Override // android.widget.Adapter
    public boolean isEmpty() {
        return this.e == null || this.e.isEmpty();
    }

    @Override // android.widget.ListAdapter
    public boolean isEnabled(int i) {
        int iA = a();
        if (i < iA) {
            return this.a.get(i).c;
        }
        int i2 = i - iA;
        int count = 0;
        return (this.e == null || i2 >= (count = this.e.getCount())) ? this.b.get(i2 - count).c : this.e.isEnabled(i2);
    }

    @Override // android.widget.Adapter
    public void registerDataSetObserver(DataSetObserver dataSetObserver) {
        if (this.e != null) {
            this.e.registerDataSetObserver(dataSetObserver);
        }
    }

    @Override // android.widget.Adapter
    public void unregisterDataSetObserver(DataSetObserver dataSetObserver) {
        if (this.e != null) {
            this.e.unregisterDataSetObserver(dataSetObserver);
        }
    }
}
