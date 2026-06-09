package chat.ola.vn.b;

import android.annotation.SuppressLint;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.Filter;
import android.widget.Filterable;
import chat.ola.vn.R;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class q extends BaseAdapter implements Filterable {
    public ArrayList<chat.ola.vn.entity.x> a;
    private LayoutInflater b;
    private List<chat.ola.vn.entity.x> c;
    private Filter d;
    private final Object e = new Object();
    private boolean f = true;

    public class a extends Filter {
        public a() {
        }

        /* JADX WARN: Removed duplicated region for block: B:20:0x0052 A[Catch: Throwable -> 0x00ea, TryCatch #0 {Throwable -> 0x00ea, blocks: (B:2:0x0000, B:4:0x0006, B:5:0x001d, B:7:0x0023, B:9:0x002d, B:11:0x0031, B:13:0x0039, B:14:0x003d, B:16:0x0041, B:18:0x004c, B:20:0x0052, B:21:0x0056, B:24:0x005d, B:28:0x0066, B:33:0x0071, B:35:0x0075, B:37:0x007d, B:38:0x0081, B:41:0x0088, B:44:0x008f, B:46:0x0093, B:48:0x009b, B:49:0x009f, B:51:0x00a3, B:52:0x00ab, B:55:0x00b2, B:59:0x00bb, B:62:0x00c2, B:64:0x00c6, B:66:0x00ce, B:67:0x00d2, B:70:0x00da, B:73:0x00e2), top: B:76:0x0000 }] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void a(android.widget.Filter.FilterResults r9, java.lang.String r10, java.util.ArrayList<chat.ola.vn.entity.x> r11) {
            /*
                Method dump skipped, instruction units count: 235
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.q.a.a(android.widget.Filter$FilterResults, java.lang.String, java.util.ArrayList):void");
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            ArrayList arrayList;
            ArrayList<chat.ola.vn.entity.x> arrayList2;
            q qVar;
            ArrayList<chat.ola.vn.entity.x> arrayList3;
            Filter.FilterResults filterResults = new Filter.FilterResults();
            if (q.this.a == null) {
                synchronized (q.this.e) {
                    if (q.this.c == null) {
                        qVar = q.this;
                        arrayList3 = new ArrayList<>();
                    } else {
                        qVar = q.this;
                        arrayList3 = new ArrayList<>(q.this.c);
                    }
                    qVar.a = arrayList3;
                }
            }
            if (charSequence == null || charSequence.length() == 0) {
                synchronized (q.this.e) {
                    arrayList = new ArrayList(q.this.a);
                }
                filterResults.values = arrayList;
                filterResults.count = arrayList.size();
                return filterResults;
            }
            String lowerCase = charSequence.toString().toLowerCase();
            synchronized (q.this.e) {
                arrayList2 = new ArrayList<>(q.this.a);
            }
            a(filterResults, lowerCase, arrayList2);
            return filterResults;
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            q.this.c = (List) filterResults.values;
            if (filterResults.count > 0) {
                q.this.notifyDataSetChanged();
            } else {
                q.this.notifyDataSetInvalidated();
            }
        }
    }

    @SuppressLint({"DefaultLocale"})
    public class b extends Filter {
        public b() {
        }

        /* JADX WARN: Removed duplicated region for block: B:20:0x0052 A[Catch: Throwable -> 0x0097, TryCatch #0 {Throwable -> 0x0097, blocks: (B:2:0x0000, B:4:0x0006, B:5:0x001d, B:7:0x0023, B:9:0x002d, B:11:0x0031, B:13:0x0039, B:14:0x003d, B:16:0x0041, B:18:0x004c, B:20:0x0052, B:21:0x0056, B:24:0x005d, B:28:0x0066, B:33:0x0071, B:35:0x0075, B:37:0x007d, B:38:0x0081, B:41:0x0088, B:44:0x008f), top: B:47:0x0000 }] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void a(android.widget.Filter.FilterResults r8, java.lang.String r9, java.util.ArrayList<chat.ola.vn.entity.x> r10) {
            /*
                r7 = this;
                int r0 = r9.length()     // Catch: java.lang.Throwable -> L97
                if (r0 <= 0) goto L97
                r0 = 0
                char r0 = r9.charAt(r0)     // Catch: java.lang.Throwable -> L97
                r1 = 1
                java.lang.String r9 = r9.substring(r1)     // Catch: java.lang.Throwable -> L97
                java.lang.String r9 = chat.ola.vn.util.m.h(r9)     // Catch: java.lang.Throwable -> L97
                java.util.ArrayList r2 = new java.util.ArrayList     // Catch: java.lang.Throwable -> L97
                r2.<init>()     // Catch: java.lang.Throwable -> L97
                java.util.Iterator r10 = r10.iterator()     // Catch: java.lang.Throwable -> L97
            L1d:
                boolean r3 = r10.hasNext()     // Catch: java.lang.Throwable -> L97
                if (r3 == 0) goto L8f
                java.lang.Object r3 = r10.next()     // Catch: java.lang.Throwable -> L97
                chat.ola.vn.entity.x r3 = (chat.ola.vn.entity.x) r3     // Catch: java.lang.Throwable -> L97
                r4 = 64
                if (r0 != r4) goto L6d
                byte r4 = r3.a     // Catch: java.lang.Throwable -> L97
                if (r4 != 0) goto L1d
                java.lang.String r4 = r3.c     // Catch: java.lang.Throwable -> L97
                java.lang.String r4 = r4.substring(r1)     // Catch: java.lang.Throwable -> L97
                if (r4 == 0) goto L3d
                java.lang.String r4 = r4.toLowerCase()     // Catch: java.lang.Throwable -> L97
            L3d:
                java.lang.String r5 = r3.b     // Catch: java.lang.Throwable -> L97
                if (r5 == 0) goto L4a
                java.lang.String r5 = r5.toLowerCase()     // Catch: java.lang.Throwable -> L97
                java.lang.String r5 = chat.ola.vn.util.m.h(r5)     // Catch: java.lang.Throwable -> L97
                goto L4c
            L4a:
                java.lang.String r5 = ""
            L4c:
                boolean r6 = r5.startsWith(r9)     // Catch: java.lang.Throwable -> L97
                if (r6 == 0) goto L56
            L52:
                r2.add(r3)     // Catch: java.lang.Throwable -> L97
                goto L1d
            L56:
                boolean r6 = r4.startsWith(r9)     // Catch: java.lang.Throwable -> L97
                if (r6 == 0) goto L5d
                goto L52
            L5d:
                boolean r4 = r4.contains(r9)     // Catch: java.lang.Throwable -> L97
                if (r4 == 0) goto L64
                goto L52
            L64:
                if (r5 == 0) goto L1d
                boolean r4 = r5.contains(r9)     // Catch: java.lang.Throwable -> L97
                if (r4 == 0) goto L1d
                goto L52
            L6d:
                r4 = 35
                if (r0 != r4) goto L1d
                byte r4 = r3.a     // Catch: java.lang.Throwable -> L97
                if (r4 != r1) goto L1d
                java.lang.String r4 = r3.c     // Catch: java.lang.Throwable -> L97
                java.lang.String r4 = r4.substring(r1)     // Catch: java.lang.Throwable -> L97
                if (r4 == 0) goto L81
                java.lang.String r4 = r4.toLowerCase()     // Catch: java.lang.Throwable -> L97
            L81:
                boolean r5 = r4.startsWith(r9)     // Catch: java.lang.Throwable -> L97
                if (r5 == 0) goto L88
                goto L52
            L88:
                boolean r4 = r4.contains(r9)     // Catch: java.lang.Throwable -> L97
                if (r4 == 0) goto L1d
                goto L52
            L8f:
                r8.values = r2     // Catch: java.lang.Throwable -> L97
                int r9 = r2.size()     // Catch: java.lang.Throwable -> L97
                r8.count = r9     // Catch: java.lang.Throwable -> L97
            L97:
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.q.b.a(android.widget.Filter$FilterResults, java.lang.String, java.util.ArrayList):void");
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            ArrayList arrayList;
            ArrayList<chat.ola.vn.entity.x> arrayList2;
            Filter.FilterResults filterResults = new Filter.FilterResults();
            try {
                if (q.this.a != null) {
                    synchronized (q.this.e) {
                        q.this.c = new ArrayList(q.this.a);
                    }
                }
                if (charSequence == null || charSequence.length() == 0) {
                    synchronized (q.this.e) {
                        arrayList = new ArrayList(q.this.a);
                    }
                    filterResults.values = arrayList;
                    filterResults.count = arrayList.size();
                    return filterResults;
                }
                String lowerCase = charSequence.toString().toLowerCase();
                synchronized (q.this.e) {
                    arrayList2 = new ArrayList<>(q.this.a);
                }
                a(filterResults, lowerCase, arrayList2);
                return filterResults;
            } catch (Throwable th) {
                th.printStackTrace();
                return filterResults;
            }
            th.printStackTrace();
            return filterResults;
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            q.this.c = (List) filterResults.values;
            if (filterResults.count > 0) {
                q.this.notifyDataSetChanged();
            } else {
                q.this.notifyDataSetInvalidated();
            }
        }
    }

    public q(Context context) {
        this.b = LayoutInflater.from(context);
    }

    public void a(Filter filter) {
        this.d = filter;
    }

    public void a(List<chat.ola.vn.entity.x> list) {
        try {
            this.a = new ArrayList<>(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.widget.Adapter
    public int getCount() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Filterable
    public Filter getFilter() {
        if (this.d == null) {
            this.d = new b();
        }
        return this.d;
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        try {
            return this.c.get(i);
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
        try {
            return ((chat.ola.vn.entity.x) getItem(i)).a;
        } catch (Throwable unused) {
            return 0;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0 */
    /* JADX WARN: Type inference failed for: r0v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v8, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v9 */
    /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v4 */
    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        chat.ola.vn.entry.b.aj ajVar;
        try {
            if (view == 0) {
                Inflate = this.b.inflate(R.layout.simple_selectable_contact_item_layout, (ViewGroup) null);
                try {
                    ajVar = new chat.ola.vn.entry.b.aj(Inflate);
                    Inflate.setTag(ajVar);
                    Inflate = Inflate;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                ajVar = (chat.ola.vn.entry.b.aj) view.getTag();
            }
            ajVar.a(this.f);
            ajVar.a((chat.ola.vn.entity.x) getItem(i));
            CheckBox checkBox = ajVar.a;
            view = 8;
            checkBox.setVisibility(8);
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 2;
    }

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        if (this.c != null) {
            Collections.sort(this.c);
        }
        super.notifyDataSetChanged();
    }
}
