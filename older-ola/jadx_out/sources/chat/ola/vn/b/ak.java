package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.SectionIndexer;
import chat.ola.vn.R;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ak extends j<chat.ola.vn.message.f> implements Filterable, SectionIndexer {
    private String a;
    private final Object b;
    private LayoutInflater c;
    private List<chat.ola.vn.message.f> d;
    private boolean g;
    private ArrayList<String> h;
    private ArrayList<chat.ola.vn.message.f> i;
    private b j;
    private Filter k;

    private class a extends Filter {
        private a() {
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            Filter.FilterResults filterResults = new Filter.FilterResults();
            try {
                if (ak.this.d == null) {
                    synchronized (ak.this.b) {
                        ak.this.d = new ArrayList(ak.this.i);
                    }
                }
                if (charSequence != null && charSequence.length() != 0) {
                    String strH = chat.ola.vn.util.m.h(charSequence.toString().toLowerCase().trim());
                    ArrayList arrayList = (ArrayList) ak.this.d;
                    int size = arrayList.size();
                    ArrayList arrayList2 = new ArrayList(size);
                    for (int i = 0; i < size; i++) {
                        chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) arrayList.get(i);
                        boolean z = true;
                        if (fVar.k() == 2) {
                            String strH2 = chat.ola.vn.util.m.h(fVar.b().toLowerCase().replace('-', ' ').replace('.', ' '));
                            if (strH2.startsWith(strH)) {
                                arrayList2.add(fVar);
                                z = false;
                                if (!z && strH2.contains(strH)) {
                                    arrayList2.add(fVar);
                                }
                            } else {
                                for (String str : strH2.split(" ")) {
                                    if (str.startsWith(strH)) {
                                        arrayList2.add(fVar);
                                        z = false;
                                        break;
                                    }
                                }
                                if (!z) {
                                }
                            }
                        } else if (fVar.k() == 0) {
                            String lowerCase = fVar.j().toLowerCase();
                            String lowerCase2 = fVar.b().toLowerCase();
                            if (lowerCase.startsWith(strH)) {
                                arrayList2.add(fVar);
                                z = false;
                                if (!z && (lowerCase.contains(strH) || lowerCase2.contains(strH))) {
                                    arrayList2.add(fVar);
                                }
                            } else {
                                lowerCase2 = chat.ola.vn.util.m.h(lowerCase2.replace('-', ' ').replace('.', ' '));
                                for (String str2 : lowerCase2.split(" ")) {
                                    if (str2.startsWith(strH)) {
                                        arrayList2.add(fVar);
                                        z = false;
                                        break;
                                    }
                                }
                                if (!z) {
                                }
                            }
                        }
                    }
                    filterResults.values = arrayList2;
                    filterResults.count = arrayList2.size();
                    return filterResults;
                }
                synchronized (ak.this.b) {
                    ArrayList arrayList3 = new ArrayList(ak.this.d);
                    filterResults.values = arrayList3;
                    filterResults.count = arrayList3.size();
                }
                return filterResults;
            } catch (Throwable unused) {
                return filterResults;
            }
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            try {
                ak.this.i = (ArrayList) filterResults.values;
                if (filterResults.count > 0) {
                    ak.this.notifyDataSetChanged();
                } else {
                    ak.this.notifyDataSetInvalidated();
                }
            } catch (Throwable unused) {
            }
        }
    }

    public interface b {
        void a(boolean z, chat.ola.vn.message.f fVar);
    }

    public ak(Context context) {
        super(context);
        this.a = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        this.b = new Object();
        this.c = (LayoutInflater) context.getSystemService("layout_inflater");
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r1v0 */
    /* JADX WARN: Type inference failed for: r1v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r1v4 */
    /* JADX WARN: Type inference failed for: r1v5 */
    /* JADX WARN: Type inference failed for: r1v7, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r1v8 */
    /* JADX WARN: Type inference failed for: r7v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r7v1 */
    /* JADX WARN: Type inference failed for: r7v2 */
    /* JADX WARN: Type inference failed for: r7v3, types: [chat.ola.vn.entry.b.aj] */
    /* JADX WARN: Type inference failed for: r7v7 */
    @Override // chat.ola.vn.b.j
    public View a(final int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.c.inflate(R.layout.simple_selectable_contact_item_layout, (ViewGroup) null);
                try {
                    chat.ola.vn.entry.b.aj ajVar = new chat.ola.vn.entry.b.aj(Inflate);
                    Inflate.setTag(ajVar);
                    Inflate = Inflate;
                    view = ajVar;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                view = (chat.ola.vn.entry.b.aj) view.getTag();
            }
            final chat.ola.vn.message.f item = getItem(i);
            view.a(item);
            view.a.setOnCheckedChangeListener(null);
            if (this.g) {
                view.a.setVisibility(0);
                view.a.setChecked(b(i));
                view.a.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() { // from class: chat.ola.vn.b.ak.1
                    @Override // android.widget.CompoundButton.OnCheckedChangeListener
                    public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
                        ak.this.a(i, z);
                        if (ak.this.j != null) {
                            ak.this.j.a(z, item);
                        }
                    }
                });
            } else {
                view.a.setVisibility(8);
            }
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.message.f getItem(int i) {
        try {
            return this.i.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(int i, boolean z) {
        String strJ = getItem(i).j();
        this.h.remove(strJ);
        if (z) {
            this.h.add(strJ);
        }
        notifyDataSetChanged();
    }

    public void a(b bVar) {
        this.j = bVar;
    }

    public boolean b(int i) {
        return this.h.contains(getItem(i).j());
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        if (this.i == null) {
            return 0;
        }
        try {
            return this.i.size();
        } catch (Throwable th) {
            th.printStackTrace();
            return 0;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Filterable
    public Filter getFilter() {
        if (this.k == null) {
            this.k = new a();
        }
        return this.k;
    }

    @Override // android.widget.SectionIndexer
    public int getPositionForSection(int i) {
        while (i >= 0) {
            for (int i2 = 0; i2 < getCount(); i2++) {
                try {
                    if (i == 0) {
                        for (int i3 = 0; i3 <= 9; i3++) {
                            if (com.mg.ola.common.d.h.a(String.valueOf(getItem(i2).b().charAt(0)), String.valueOf(i3))) {
                                return i2;
                            }
                        }
                    } else if (com.mg.ola.common.d.h.a(String.valueOf(getItem(i2).b().charAt(0)), String.valueOf(this.a.charAt(i)))) {
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
        String[] strArr = new String[this.a.length()];
        for (int i = 0; i < this.a.length(); i++) {
            strArr[i] = String.valueOf(this.a.charAt(i));
        }
        return strArr;
    }
}
