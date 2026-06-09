package chat.ola.vn.m;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaAppSettingActivity;
import chat.ola.vn.activity.OlaReleaseAppActivity;
import chat.ola.vn.b.aj;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.ad;
import chat.ola.vn.view.OlaListView;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class x extends c implements SwipeRefreshLayout.OnRefreshListener, AdapterView.OnItemClickListener, j.a {
    private OlaListView d;
    private aj e;
    private View f;
    private SwipeRefreshLayout g;
    private boolean h = false;
    private boolean i;

    private void a(chat.ola.vn.entity.t tVar, String str) {
        try {
            if (g().e(str)) {
                return;
            }
        } catch (Throwable unused) {
        }
        try {
            this.f.setVisibility(0);
            OlaApplication.b.r(str, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.d(tVar, null) { // from class: chat.ola.vn.m.x.6
                @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
                public void a(int i, short s, String str2, chat.ola.vn.entity.d[] dVarArr) {
                    super.a(i, s, str2, dVarArr);
                    try {
                        x.this.f.setVisibility(8);
                    } catch (Throwable unused2) {
                    }
                }

                @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    super.a(objArr);
                    try {
                        x.this.f.setVisibility(8);
                        x.this.d.setAdapter((ListAdapter) x.this.e);
                        x.this.d();
                        x.this.h();
                        x.this.g().d();
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            }));
        } catch (Throwable unused2) {
        }
    }

    private void j() {
        if (this.h) {
            return;
        }
        if (chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.s);
        }
        this.h = !this.h;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void v() {
        if (this.h) {
            if (chat.ola.vn.c.x.e()) {
                chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
            }
            this.h = !this.h;
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return (this.i || this.b == null || this.b.j() == null) ? false : true;
    }

    @Override // chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        if (this.b == null || chat.ola.vn.util.m.a(this.b.o())) {
            return null;
        }
        try {
            this.c = new ArrayList<>();
            chat.ola.vn.mediastore.a aVar = new chat.ola.vn.mediastore.a();
            aVar.b = R.drawable.ic_action_home;
            aVar.a = R.id.olaActionBarButtonImageView;
            aVar.f = new View.OnClickListener() { // from class: chat.ola.vn.m.x.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    x.this.g().a(new chat.ola.vn.entity.t((String) null));
                }
            };
            aVar.e = true;
            aVar.c = context.getString(R.string.string_homepage);
            this.c.add(aVar);
            chat.ola.vn.mediastore.a aVar2 = new chat.ola.vn.mediastore.a();
            aVar2.b = R.drawable.ic_action_share;
            aVar2.a = R.id.olaActionBarButtonImageView;
            aVar2.f = new View.OnClickListener() { // from class: chat.ola.vn.m.x.5
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    x.this.g().c(x.this.b);
                }
            };
            aVar2.e = true;
            aVar2.c = context.getString(R.string.string_share);
            this.c.add(aVar2);
            return this.c;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.c
    public void a(chat.ola.vn.entity.t tVar) {
        super.a(tVar);
        if (this.e != null) {
            this.e.a(tVar);
            this.e.notifyDataSetChanged();
            d();
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        this.i = true;
        OlaApplication.b.k(this.b.o(), this.b.j(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.d(this.b, this.b.j()) { // from class: chat.ola.vn.m.x.2
            @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
            public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                x.this.i = false;
                super.a(i2, s, str, dVarArr);
            }

            @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                try {
                    if (((ad) objArr[0]).m() == -1) {
                        return;
                    }
                    x.this.i = false;
                    super.a(objArr);
                    x.this.e.notifyDataSetChanged();
                } catch (Throwable unused) {
                }
            }
        }));
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        this.e = new aj(getActivity());
        this.e.a(this);
        this.e.a(this.b);
        this.d.setAdapter((ListAdapter) this.e);
        this.d.setOnItemClickListener(this);
        d();
    }

    @Override // chat.ola.vn.m.c
    public void c() {
        try {
            this.b.a(this.d);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.c
    public void d() {
        try {
            this.e.notifyDataSetChanged();
            if (this.b != null) {
                this.b.b(this.d);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        if (this.b == null) {
            return false;
        }
        String strW = this.b.w();
        if (chat.ola.vn.util.m.a(strW)) {
            return false;
        }
        a(this.b, strW);
        return true;
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        if (this.b == null || chat.ola.vn.util.m.a(this.b.o())) {
            return null;
        }
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_copy));
        arrayList.add(getString(R.string.string_add_bookmark));
        arrayList.add(getString(R.string.string_setup));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.x.3
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(x.this.getString(R.string.string_add_bookmark), str)) {
                        x.this.g().b(x.this.b);
                        return;
                    }
                    if (!chat.ola.vn.util.m.b(x.this.getString(R.string.string_copy), str)) {
                        if (chat.ola.vn.util.m.b(x.this.getString(R.string.string_setup), str)) {
                            OlaAppSettingActivity.b(x.this.getActivity());
                            return;
                        }
                        return;
                    }
                    String strO = x.this.b.o();
                    if (chat.ola.vn.util.m.a(strO) || chat.ola.vn.util.m.a(strO, "null")) {
                        return;
                    }
                    chat.ola.vn.util.o.a(x.this.getActivity(), "rss://" + strO);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @Override // chat.ola.vn.m.f
    public boolean i() {
        return (this.b == null || chat.ola.vn.util.m.a(this.b.o())) ? false : true;
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.news_page_list_layout, viewGroup, false);
        this.d = (OlaListView) viewInflate.findViewById(R.id.lvCategoryList);
        this.g = (SwipeRefreshLayout) viewInflate.findViewById(R.id.swipeRefreshLayout);
        this.g.setColorSchemeResources(R.color.colorOlaPrimary);
        this.g.setOnRefreshListener(this);
        this.f = viewInflate.findViewById(R.id.progressCategoryWatting);
        this.d.setOnScrollListener(new AbsListView.OnScrollListener() { // from class: chat.ola.vn.m.x.1
            @Override // android.widget.AbsListView.OnScrollListener
            public void onScroll(AbsListView absListView, int i, int i2, int i3) {
            }

            @Override // android.widget.AbsListView.OnScrollListener
            public void onScrollStateChanged(AbsListView absListView, int i) {
                switch (i) {
                    case 0:
                        if (x.this.b != null) {
                            x.this.b.a(x.this.d);
                        }
                        break;
                }
            }
        });
        this.d.setSelectionFromTop(0, 0);
        this.d.addHeaderView(a(layoutInflater));
        return viewInflate;
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            g().a(new chat.ola.vn.entity.t(((chat.ola.vn.entity.t) adapterView.getAdapter().getItem(i)).o()));
            OlaReleaseAppActivity.a(getActivity());
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
    public void onRefresh() {
        try {
            this.g.setRefreshing(true);
            j();
            g().a(this.b, new Runnable() { // from class: chat.ola.vn.m.x.7
                @Override // java.lang.Runnable
                public void run() {
                    x.this.d();
                    x.this.v();
                    x.this.g.setRefreshing(false);
                }
            });
        } catch (Throwable unused) {
        }
    }
}
