package chat.ola.vn.cloud;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.i;
import chat.ola.vn.view.OlaRatioImageView;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b extends j<i> {
    protected LayoutInflater a;
    protected d b;
    private byte c;
    private List<i> d;
    private List<i> g;

    public class a {
        protected View a;
        protected TextView b;
        protected OlaRatioImageView c;
        private i e;

        protected a(View view) {
            try {
                this.a = view.findViewById(R.id.cloudAlbumViewLayout);
                this.b = (TextView) view.findViewById(R.id.cloudAlbumCheckImageView);
                this.c = (OlaRatioImageView) view.findViewById(R.id.cloudAlbumCoverImageView);
            } catch (Throwable unused) {
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        /* JADX WARN: Removed duplicated region for block: B:11:0x006c  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void a() {
            /*
                Method dump skipped, instruction units count: 228
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.cloud.b.a.a():void");
        }

        protected void a(i iVar) {
            try {
                this.e = iVar;
                a();
            } catch (Throwable unused) {
            }
        }
    }

    public b(Context context) {
        super(context);
        this.c = (byte) 0;
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v3 */
    /* JADX WARN: Type inference failed for: r5v4, types: [chat.ola.vn.cloud.b$a] */
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
                Inflate = this.a.inflate(R.layout.ola_cloud_media_layout, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate.setTag(aVar);
                    view = aVar;
                    Inflate = Inflate;
                } catch (Throwable th) {
                    th = th;
                    th.printStackTrace();
                    return Inflate;
                }
            } else {
                try {
                    Inflate = view;
                    view = (a) view.getTag();
                } catch (Throwable th2) {
                    a aVar2 = new a(view);
                    view.setTag(aVar2);
                    th2.printStackTrace();
                    Inflate = view;
                    view = aVar2;
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
    public i getItem(int i) {
        try {
            return this.d.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a() {
        this.g = null;
        this.d = null;
    }

    public void a(d dVar) {
        this.b = dVar;
    }

    public void a(List<i> list) {
        if (this.d == null) {
            this.d = new ArrayList(list);
        } else {
            this.d.addAll(list);
        }
        notifyDataSetChanged();
    }

    public void b(List<i> list) {
        try {
            this.d = new ArrayList(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public List<i> c() {
        try {
            if (this.g != null) {
                return new ArrayList(this.g);
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean d() {
        return this.c == 1;
    }

    public void e() {
        if (this.c != 1) {
            this.c = (byte) 1;
            notifyDataSetChanged();
            if (this.b != null) {
                this.b.C();
            }
        }
    }

    public void f() {
        if (this.c != 0) {
            this.c = (byte) 0;
            try {
                if (this.g != null) {
                    Iterator<i> it2 = this.g.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(-1);
                    }
                    this.g.clear();
                    this.g = null;
                }
                if (this.b != null) {
                    this.b.D();
                }
            } catch (Throwable unused) {
            }
            notifyDataSetChanged();
        }
    }

    public List<i> g() {
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
