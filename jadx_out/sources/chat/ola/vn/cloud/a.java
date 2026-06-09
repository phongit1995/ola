package chat.ola.vn.cloud;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.l;
import chat.ola.vn.view.OlaRatioImageView;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class a extends j<l> {
    protected LayoutInflater a;
    protected d b;
    private byte c;
    private List<l> d;
    private boolean g;

    /* JADX INFO: renamed from: chat.ola.vn.cloud.a$a, reason: collision with other inner class name */
    public class C0026a {
        protected View a;
        protected View b;
        protected OlaRatioImageView c;
        protected TextView d;
        protected TextView e;
        private l g;

        protected C0026a(View view) {
            try {
                this.a = view.findViewById(R.id.cloudAlbumViewLayout);
                this.b = view.findViewById(R.id.cloudAlbumCheckImageView);
                this.c = (OlaRatioImageView) view.findViewById(R.id.cloudAlbumCoverImageView);
                this.d = (TextView) view.findViewById(R.id.cloudAlbumChildCountTextView);
                this.e = (TextView) view.findViewById(R.id.cloudAlbumNameTextView);
            } catch (Throwable unused) {
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        /* JADX WARN: Failed to find 'out' block for switch in B:13:0x006f. Please report as an issue. */
        /* JADX WARN: Removed duplicated region for block: B:31:0x00f3  */
        /* JADX WARN: Removed duplicated region for block: B:37:0x010d  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void a() {
            /*
                Method dump skipped, instruction units count: 312
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.cloud.a.C0026a.a():void");
        }

        protected void a(l lVar) {
            try {
                this.g = lVar;
                a();
            } catch (Throwable unused) {
            }
        }
    }

    public a(Context context) {
        super(context);
        this.c = (byte) 0;
        this.g = true;
        this.a = LayoutInflater.from(context);
    }

    private void g() {
        Collections.sort(this.d, new Comparator<l>() { // from class: chat.ola.vn.cloud.a.1
            @Override // java.util.Comparator
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public int compare(l lVar, l lVar2) {
                if (lVar.a() && !lVar2.a()) {
                    return -1;
                }
                if (lVar.a() || !lVar2.a()) {
                    return lVar.i - lVar2.i;
                }
                return 1;
            }
        });
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v3 */
    /* JADX WARN: Type inference failed for: r5v4, types: [chat.ola.vn.cloud.a$a] */
    /* JADX WARN: Type inference failed for: r5v6 */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v11, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v12 */
    /* JADX WARN: Type inference failed for: r6v2, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v5 */
    /* JADX WARN: Type inference failed for: r6v7 */
    /* JADX WARN: Type inference failed for: r6v8 */
    /* JADX WARN: Type inference failed for: r6v9, types: [android.view.View] */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.ola_cloud_album_layout, (ViewGroup) null);
                try {
                    C0026a c0026a = new C0026a(Inflate);
                    Inflate.setTag(c0026a);
                    view = c0026a;
                    Inflate = Inflate;
                } catch (Throwable th) {
                    th = th;
                    th.printStackTrace();
                    return Inflate;
                }
            } else {
                try {
                    Inflate = view;
                    view = (C0026a) view.getTag();
                } catch (Throwable th2) {
                    C0026a c0026a2 = new C0026a(view);
                    view.setTag(c0026a2);
                    th2.printStackTrace();
                    Inflate = view;
                    view = c0026a2;
                }
            }
            view.a(this.d.get(i));
            return Inflate;
        } catch (Throwable th3) {
            th = th3;
            Inflate = view;
            th.printStackTrace();
            return Inflate;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public l getItem(int i) {
        try {
            return this.d.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public List<l> a() {
        ArrayList arrayList = null;
        try {
            for (l lVar : this.d) {
                if (lVar.k) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(lVar);
                }
            }
        } catch (Throwable unused) {
        }
        return arrayList;
    }

    public void a(d dVar) {
        this.b = dVar;
    }

    public void a(List<l> list) {
        if (this.d == null) {
            this.d = new ArrayList(list);
        } else {
            this.d.addAll(list);
        }
        g();
        notifyDataSetChanged();
    }

    public void a(boolean z) {
        this.g = z;
    }

    public void b(List<l> list) {
        try {
            this.d = new ArrayList(list);
            g();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public boolean c() {
        return this.c == 1;
    }

    public void d() {
        if (this.c != 1) {
            this.c = (byte) 1;
            notifyDataSetChanged();
            if (this.b != null) {
                this.b.C();
            }
        }
    }

    public void e() {
        if (this.c != 0) {
            this.c = (byte) 0;
            try {
                Iterator<l> it2 = this.d.iterator();
                while (it2.hasNext()) {
                    it2.next().k = false;
                }
                if (this.b != null) {
                    this.b.D();
                }
            } catch (Throwable unused) {
            }
            notifyDataSetChanged();
        }
    }

    public List<l> f() {
        try {
            return this.d;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.d.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return 0;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 1;
    }
}
