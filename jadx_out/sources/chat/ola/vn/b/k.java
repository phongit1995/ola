package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.SectionIndexer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public abstract class k<T> extends j<T> implements Filterable, SectionIndexer, Comparator<T> {
    protected LayoutInflater a;
    private String b;
    private final Object c;
    private List<T> d;
    private ArrayList<T> g;
    private Filter h;

    private class a extends Filter {
        private a() {
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            ArrayList arrayList;
            int size;
            ArrayList arrayList2;
            k kVar;
            ArrayList arrayList3;
            Filter.FilterResults filterResults = new Filter.FilterResults();
            if (k.this.d == null) {
                synchronized (k.this.c) {
                    if (k.this.g != null) {
                        kVar = k.this;
                        arrayList3 = new ArrayList(k.this.g);
                    } else {
                        kVar = k.this;
                        arrayList3 = new ArrayList();
                    }
                    kVar.d = arrayList3;
                }
            }
            if (charSequence == null || charSequence.length() == 0) {
                synchronized (k.this.c) {
                    arrayList = new ArrayList(k.this.d);
                }
                filterResults.values = arrayList;
                size = arrayList.size();
            } else {
                String lowerCase = charSequence.toString().toLowerCase(Locale.getDefault());
                synchronized (k.this.c) {
                    arrayList2 = new ArrayList(k.this.d);
                }
                int size2 = arrayList2.size();
                ArrayList arrayList4 = new ArrayList();
                for (int i = 0; i < size2; i++) {
                    Object obj = arrayList2.get(i);
                    String lowerCase2 = k.this.a(obj).toLowerCase(Locale.getDefault());
                    if (lowerCase2.startsWith(lowerCase)) {
                        arrayList4.add(obj);
                        break;
                    }
                    for (String str : lowerCase2.split(" ")) {
                        if (str.startsWith(lowerCase)) {
                            arrayList4.add(obj);
                            break;
                            break;
                        }
                    }
                }
                filterResults.values = arrayList4;
                size = arrayList4.size();
            }
            filterResults.count = size;
            return filterResults;
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            k.this.g = (ArrayList) filterResults.values;
            if (filterResults.count > 0) {
                k.this.notifyDataSetChanged();
            } else {
                k.this.notifyDataSetInvalidated();
            }
        }
    }

    public k(Context context) {
        super(context);
        this.b = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        this.c = new Object();
        this.a = LayoutInflater.from(context);
    }

    protected abstract String a(T t);

    public void a(List<T> list) {
        if (list == null) {
            return;
        }
        if (this.d != null) {
            this.d.clear();
            this.d.addAll(list);
        } else {
            this.d = new ArrayList(list);
        }
        Collections.sort(this.d, this);
        if (this.g == null) {
            this.g = new ArrayList<>(this.d);
        } else {
            this.g.clear();
            this.g.addAll(this.d);
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        if (this.g == null) {
            return 0;
        }
        try {
            return this.g.size();
        } catch (Throwable th) {
            th.printStackTrace();
            return 0;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Filterable
    public Filter getFilter() {
        if (this.h == null) {
            this.h = new a();
        }
        return this.h;
    }

    @Override // android.widget.Adapter
    public T getItem(int i) {
        try {
            return this.g.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // android.widget.SectionIndexer
    public int getPositionForSection(int i) {
        while (i >= 0) {
            for (int i2 = 0; i2 < getCount(); i2++) {
                try {
                    char cCharAt = a(getItem(i2)).charAt(0);
                    if (i == 0) {
                        for (int i3 = 0; i3 <= 9; i3++) {
                            if (com.mg.ola.common.d.h.a(String.valueOf(cCharAt), String.valueOf(i3))) {
                                return i2;
                            }
                        }
                    } else if (com.mg.ola.common.d.h.a(String.valueOf(cCharAt), String.valueOf(this.b.charAt(i)))) {
                        return i2;
                    }
                } catch (Throwable unused) {
                }
            }
            i--;
        }
        return 0;
    }

    @Override // android.widget.SectionIndexer
    public int getSectionForPosition(int i) {
        return 0;
    }

    @Override // android.widget.SectionIndexer
    public Object[] getSections() {
        String[] strArr = new String[this.b.length()];
        for (int i = 0; i < this.b.length(); i++) {
            strArr[i] = String.valueOf(this.b.charAt(i));
        }
        return strArr;
    }
}
