package chat.ola.vn.pickercontacts;

import android.content.Context;
import android.util.SparseBooleanArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.Filter;
import android.widget.SectionIndexer;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class h extends j<c> implements CompoundButton.OnCheckedChangeListener, SectionIndexer {
    private String a;
    private List<c> b;
    private View.OnClickListener c;
    private View.OnLongClickListener d;
    private List<c> g;
    private a h;
    private SparseBooleanArray i;
    private boolean j;

    private class a extends Filter {
        private a() {
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            Filter.FilterResults filterResults = new Filter.FilterResults();
            try {
                ArrayList arrayList = new ArrayList(0);
                if (charSequence == null || charSequence.length() <= 0) {
                    synchronized (this) {
                        h.this.j = false;
                        List listC = h.this.c((List<c>) h.this.b);
                        filterResults.count = listC.size();
                        filterResults.values = listC;
                    }
                    return filterResults;
                }
                h.this.j = true;
                String lowerCase = m.h(charSequence.toString()).toLowerCase();
                int size = h.this.b.size();
                for (int i = 0; i < size; i++) {
                    if (m.h(((c) h.this.b.get(i)).a()).toLowerCase().contains(lowerCase)) {
                        arrayList.add(h.this.b.get(i));
                    }
                }
                if (arrayList.size() == 0) {
                    int size2 = h.this.b.size();
                    for (int i2 = 0; i2 < size2; i2++) {
                        int size3 = ((c) h.this.b.get(i2)).b().size();
                        int i3 = 0;
                        while (true) {
                            if (i3 >= size3) {
                                break;
                            }
                            if (m.h(((c) h.this.b.get(i2)).b().get(i3)).toLowerCase().replaceAll(" ", "").replaceAll("-", "").contains(lowerCase)) {
                                arrayList.add(h.this.b.get(i2));
                                break;
                            }
                            i3++;
                        }
                    }
                }
                filterResults.count = arrayList.size();
                filterResults.values = arrayList;
                return filterResults;
            } catch (Throwable th) {
                th.printStackTrace();
                return filterResults;
            }
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            try {
                h.this.g = (List) filterResults.values;
                h.this.notifyDataSetChanged();
            } catch (Exception unused) {
            }
        }
    }

    public h(Context context) {
        super(context);
        this.a = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        this.j = false;
        this.b = new ArrayList(0);
    }

    private void b(List<c> list) {
        try {
            Collections.sort(list, new Comparator<c>() { // from class: chat.ola.vn.pickercontacts.h.1
                @Override // java.util.Comparator
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public int compare(c cVar, c cVar2) {
                    return cVar.a().compareTo(cVar2.a());
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public List<c> c(List<c> list) {
        if (list == null) {
            return list;
        }
        ArrayList arrayList = new ArrayList(list);
        b(arrayList);
        ArrayList arrayList2 = new ArrayList(0);
        int size = list.size();
        String upperCase = null;
        for (int i = 0; i < size; i++) {
            c cVar = new c();
            cVar.a(arrayList.get(i));
            if (upperCase != null && m.b(upperCase, String.valueOf(cVar.a().charAt(0)))) {
                arrayList2.add(cVar);
            } else {
                upperCase = String.valueOf(cVar.a().charAt(0)).toUpperCase();
                c cVar2 = new c();
                cVar2.a(c.a);
                cVar2.a(upperCase);
                arrayList2.add(cVar2);
                arrayList2.add(cVar);
            }
        }
        return arrayList2;
    }

    public int a() {
        int i = 0;
        for (int i2 = 0; i2 < getCount(); i2++) {
            try {
                if (this.i.get(i2, false)) {
                    i++;
                }
            } catch (Throwable unused) {
                return 0;
            }
        }
        return i;
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        e dVar;
        try {
            c cVar = this.g.get(i);
            if (view != null) {
                try {
                    e dVar2 = (e) view.getTag();
                    if (dVar2.a() != cVar.d()) {
                        if (cVar.d() == c.b) {
                            view = LayoutInflater.from(b()).inflate(R.layout.osms_contact_item, viewGroup, false);
                            dVar2 = new e(view);
                        } else {
                            view = LayoutInflater.from(b()).inflate(R.layout.osms_contact_header_item, viewGroup, false);
                            dVar2 = new d(view);
                        }
                    }
                    dVar = dVar2;
                } catch (Throwable unused) {
                    if (cVar.d() == c.b) {
                        view = LayoutInflater.from(b()).inflate(R.layout.osms_contact_item, viewGroup, false);
                        dVar = new e(view);
                    } else {
                        view = LayoutInflater.from(b()).inflate(R.layout.osms_contact_header_item, viewGroup, false);
                        dVar = new d(view);
                    }
                }
            } else if (cVar.d() == c.b) {
                view = LayoutInflater.from(b()).inflate(R.layout.osms_contact_item, viewGroup, false);
                dVar = new e(view);
            } else {
                view = LayoutInflater.from(b()).inflate(R.layout.osms_contact_header_item, viewGroup, false);
                dVar = new d(view);
            }
            dVar.a(this.c);
            dVar.a(this.d);
            dVar.a(cVar);
            if (getItem(i).d() == c.b) {
                dVar.a(this.i.get(i, false));
            }
            return view;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public c getItem(int i) {
        try {
            if (this.g != null) {
                return this.g.get(i);
            }
            return null;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(int i, boolean z) {
        try {
            if (getItem(i).d() == c.b) {
                this.i.put(i, z);
                notifyDataSetChanged();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(List<c> list) {
        try {
            this.b = new ArrayList(list);
            b(this.b);
            this.g = c(list);
            this.i = new SparseBooleanArray(this.g.size());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public boolean b(int i) {
        return this.i.get(i, false);
    }

    public SparseBooleanArray c() {
        return this.i;
    }

    public void c(int i) {
        a(i, !b(i));
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            if (this.g != null) {
                return this.g.size();
            }
            return 0;
        } catch (Throwable unused) {
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

    @Override // android.widget.SectionIndexer
    public int getPositionForSection(int i) {
        while (i >= 0) {
            try {
                int size = this.g.size();
                for (int i2 = 0; i2 < size; i2++) {
                    if (m.b(this.g.get(i2).a().charAt(0) + "", this.a.charAt(i) + "")) {
                        return i2;
                    }
                }
                i--;
            } catch (Throwable unused) {
            }
        }
        return 0;
    }

    @Override // android.widget.SectionIndexer
    public int getSectionForPosition(int i) {
        return 0;
    }

    @Override // android.widget.SectionIndexer
    public Object[] getSections() {
        String[] strArr = new String[this.a.length()];
        for (int i = 0; i < this.a.length(); i++) {
            strArr[i] = String.valueOf(this.a.charAt(i));
        }
        return strArr;
    }

    @Override // android.widget.CompoundButton.OnCheckedChangeListener
    public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
        this.i.put(((Integer) compoundButton.getTag()).intValue(), z);
    }
}
