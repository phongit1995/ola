package chat.ola.vn.m;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.widget.DrawerLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.b.am;
import java.lang.ref.WeakReference;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class g extends a implements View.OnClickListener, AdapterView.OnItemClickListener {
    public static List<chat.ola.vn.entity.e> a = new ArrayList();
    private static List<chat.ola.vn.entity.e> b = null;
    private static boolean c = false;
    private static chat.ola.vn.entity.e d;
    private static WeakReference<g> e;
    private static String f;
    private ListView g;
    private am h;
    private q i;
    private View j;
    private TextView k;
    private DrawerLayout l;
    private View o;
    private View p;
    private View q;
    private ImageView r;
    private ImageView s;
    private ImageView t;

    private void A() {
        try {
            this.r.setImageResource(R.drawable.ic_action_tab_mall_tag);
            this.s.setImageResource(R.drawable.ic_action_tab_mall_new);
            this.t.setImageResource(R.drawable.ic_action_tab_mall_hot);
            if (d == null) {
                return;
            }
            String strT = d.t();
            try {
                strT = (strT.toLowerCase(Locale.getDefault()).startsWith("http") ? new URL(strT) : new URL(chat.ola.vn.util.http.a.a((String) null, strT, (Map<String, String>) null, true))).getPath();
            } catch (Throwable unused) {
            }
            if (strT != null && strT.startsWith("/json")) {
                strT = strT.replaceFirst("/json", "");
            }
            if (g(e(strT), e("/"))) {
                this.r.setImageResource(R.drawable.ic_action_tab_mall_tag_selected);
            } else if (g(e("/mall/new?p=0"), e(strT))) {
                this.s.setImageResource(R.drawable.ic_action_tab_mall_new_selected);
            } else if (g(e("/mall/hot?p=0&t=2&hl=true"), e(strT))) {
                this.t.setImageResource(R.drawable.ic_action_tab_mall_hot_selected);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        if (b == null) {
            OlaApplication.b.b("mall/tags", new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.g.5
                @Override // chat.ola.vn.p.b
                public void a(String str, String str2) {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.g.5.2
                        @Override // java.lang.Runnable
                        public void run() {
                            List unused = g.b = null;
                            g.this.h();
                        }
                    });
                }

                @Override // chat.ola.vn.p.b
                public void a(String str, String str2, final chat.ola.vn.entity.e eVar) {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.g.5.1
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                List unused = g.b = eVar.m();
                                g.this.h();
                            } catch (Throwable unused2) {
                            }
                        }
                    });
                }
            });
        } else {
            h();
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public static void a(Context context, String str) {
        String str2;
        if (str == null) {
            str2 = null;
        } else {
            str2 = "mall/watch?id=" + str;
        }
        b(context, str2);
    }

    private void a(String str, String str2, final chat.ola.vn.entity.e eVar, final chat.ola.vn.p.b bVar) {
        this.o.setVisibility(0);
        if (!chat.ola.vn.util.m.a(str2)) {
            OlaApplication.b.b(str2, (chat.ola.vn.p.b) null);
        }
        OlaApplication.b.b(str, new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.g.7
            @Override // chat.ola.vn.p.b
            public void a(final String str3, final String str4) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.g.7.2
                    @Override // java.lang.Runnable
                    public void run() {
                        if (bVar != null) {
                            bVar.a(str3, str4);
                        }
                        try {
                            if (g.this.o != null) {
                                g.this.o.setVisibility(8);
                            }
                            if (eVar != null) {
                                eVar.e(false);
                                eVar.b(false);
                            }
                            g.this.h();
                        } catch (Throwable unused) {
                        }
                    }
                });
            }

            @Override // chat.ola.vn.p.b
            public void a(final String str3, final String str4, final chat.ola.vn.entity.e eVar2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.g.7.1
                    @Override // java.lang.Runnable
                    public void run() {
                        g gVar;
                        chat.ola.vn.entity.e eVar3;
                        try {
                            if (g.this.o != null) {
                                g.this.o.setVisibility(8);
                            }
                            if (eVar2.v() == null && eVar2.w() == null && eVar2.m() == null) {
                                return;
                            }
                            eVar2.e(true);
                            eVar2.b(false);
                            eVar2.a(System.currentTimeMillis());
                            if (g.d != null) {
                                g.a.add(g.d);
                            }
                            if (eVar == null) {
                                if (bVar != null) {
                                    bVar.a(str3, str4, eVar2);
                                }
                                gVar = g.this;
                                eVar3 = eVar2;
                            } else {
                                eVar.b(eVar2);
                                if (bVar != null) {
                                    bVar.a(str3, str4, eVar);
                                }
                                gVar = g.this;
                                eVar3 = eVar;
                            }
                            gVar.b(eVar3);
                            g.this.h();
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                });
            }
        });
    }

    public static void b(Context context, String str) {
        if (c() != null) {
            c().f(str, (String) null);
        } else {
            f = str;
            OlaBottomTabActivity.a(context, 3);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(chat.ola.vn.entity.e eVar) {
        Fragment fragmentInstantiate;
        if (eVar == null) {
            return;
        }
        if (eVar.p()) {
            this.o.setVisibility(8);
        }
        FragmentActivity activity = getActivity();
        if (activity == null) {
            return;
        }
        int iE = eVar.E();
        String str = "mall_tag_" + iE;
        FragmentManager childFragmentManager = getChildFragmentManager();
        FragmentTransaction fragmentTransactionBeginTransaction = childFragmentManager.beginTransaction();
        try {
            try {
                this.i = x();
                if (this.i != null) {
                    this.i.c();
                    this.i.h();
                    fragmentTransactionBeginTransaction.detach(this.i);
                }
                q qVar = (q) childFragmentManager.findFragmentByTag(str);
                if (qVar != null) {
                    qVar.a(this);
                    qVar.a(eVar);
                    fragmentTransactionBeginTransaction.attach(qVar);
                    try {
                        this.i = (q) childFragmentManager.findFragmentByTag(str);
                        this.i.a(eVar);
                    } catch (Throwable unused) {
                        this.i = qVar;
                    }
                } else {
                    q qVar2 = null;
                    switch (iE) {
                        case -6:
                            fragmentInstantiate = Fragment.instantiate(activity, s.class.getName());
                            qVar2 = (q) fragmentInstantiate;
                            break;
                        case -5:
                            fragmentInstantiate = Fragment.instantiate(activity, w.class.getName());
                            qVar2 = (q) fragmentInstantiate;
                            break;
                        case -4:
                            fragmentInstantiate = Fragment.instantiate(activity, v.class.getName());
                            qVar2 = (q) fragmentInstantiate;
                            break;
                        case -3:
                            fragmentInstantiate = Fragment.instantiate(activity, t.class.getName());
                            qVar2 = (q) fragmentInstantiate;
                            break;
                        case -2:
                        case 0:
                            fragmentInstantiate = Fragment.instantiate(activity, r.class.getName());
                            qVar2 = (q) fragmentInstantiate;
                            break;
                        case -1:
                            fragmentInstantiate = Fragment.instantiate(activity, u.class.getName());
                            qVar2 = (q) fragmentInstantiate;
                            break;
                    }
                    if (qVar2 != null) {
                        qVar2.a(eVar);
                        qVar2.a(this);
                        fragmentTransactionBeginTransaction.add(R.id.mall_content_frame, qVar2, str);
                        this.i = qVar2;
                    }
                }
                this.i.j();
            } catch (Throwable th) {
                th.printStackTrace();
            }
            fragmentTransactionBeginTransaction.commit();
            d = eVar;
            j();
            A();
        } catch (Throwable th2) {
            fragmentTransactionBeginTransaction.commit();
            throw th2;
        }
    }

    public static g c() {
        if (e == null) {
            return null;
        }
        return e.get();
    }

    private chat.ola.vn.entity.e f(String str) {
        if (d != null && g(d.t(), str)) {
            return d;
        }
        if (a == null) {
            return null;
        }
        for (chat.ola.vn.entity.e eVar : a) {
            if (g(eVar.t(), str)) {
                return eVar;
            }
        }
        return null;
    }

    private boolean g(String str, String str2) {
        if (str == null) {
            str = "mall/";
        }
        if (str2 == null) {
            str2 = "mall/";
        }
        try {
            return chat.ola.vn.util.m.c(chat.ola.vn.util.http.a.b(str), chat.ola.vn.util.http.a.b(str2));
        } catch (Exception e2) {
            e2.printStackTrace();
            return false;
        }
    }

    private boolean z() {
        return this.l.isDrawerOpen(3) || this.l.isDrawerOpen(5);
    }

    public void a(final chat.ola.vn.entity.e eVar) {
        eVar.e(false);
        this.o.setVisibility(0);
        OlaApplication.b.b(eVar.t(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.g.6
            @Override // chat.ola.vn.p.b
            public void a(String str, String str2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.g.6.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (g.this.o != null) {
                                g.this.o.setVisibility(8);
                            }
                            if (eVar != null) {
                                eVar.e(false);
                                eVar.b(false);
                            }
                            g.this.h();
                        } catch (Throwable unused) {
                        }
                    }
                });
            }

            @Override // chat.ola.vn.p.b
            public void a(String str, String str2, final chat.ola.vn.entity.e eVar2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.g.6.1
                    @Override // java.lang.Runnable
                    public void run() {
                        if (g.this.o != null) {
                            g.this.o.setVisibility(8);
                        }
                        if (eVar2.v() == null && eVar2.w() == null && eVar2.m() == null) {
                            return;
                        }
                        eVar2.e(true);
                        eVar2.b(false);
                        eVar2.a(System.currentTimeMillis());
                        eVar.b(eVar2);
                        g.this.h();
                    }
                });
            }
        });
    }

    public void a(String str, String str2, chat.ola.vn.p.b bVar) {
        try {
            c = false;
            chat.ola.vn.entity.e eVarF = f(str);
            if (eVarF != null) {
                if (eVarF.k()) {
                    this.o.setVisibility(0);
                    return;
                } else if (eVarF.p()) {
                    this.o.setVisibility(8);
                    b(eVarF);
                    return;
                }
            }
            a(str, str2, eVarF, bVar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.h = new am(getActivity());
        this.g.setAdapter((ListAdapter) this.h);
        this.g.setOnItemClickListener(this);
        if (!chat.ola.vn.util.m.a(f)) {
            f(f, (String) null);
            f = null;
        } else if (d != null) {
            b(d);
        } else {
            f((String) null, (String) null);
        }
    }

    public int d() {
        return 3;
    }

    @Override // chat.ola.vn.m.f
    public void d_() {
        this.i.d_();
    }

    public String e(String str) {
        int iIndexOf;
        return (str == null || (iIndexOf = str.indexOf("?")) < 0) ? str : str.substring(0, iIndexOf);
    }

    public void e() {
        try {
            this.l.closeDrawer(3);
            this.l.closeDrawer(5);
        } catch (Throwable unused) {
        }
    }

    public void f(String str, String str2) {
        a(str, str2, (chat.ola.vn.p.b) null);
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        if (c) {
            c = false;
            return false;
        }
        if (z()) {
            e();
            return true;
        }
        if (a == null || a.isEmpty()) {
            return super.g_();
        }
        b(a.remove(a.size() - 1));
        return true;
    }

    public void h() {
        try {
            this.h.a(b);
            this.h.notifyDataSetChanged();
            x().v();
        } catch (Throwable unused) {
        }
    }

    public void j() {
        try {
            int i = 0;
            this.p.setVisibility(d.E() != -1 ? 0 : 4);
            View view = this.j;
            if (!this.i.i()) {
                i = 8;
            }
            view.setVisibility(i);
        } catch (Throwable unused) {
        }
        try {
            ArrayList<chat.ola.vn.mediastore.a> arrayListA = this.i.a((Context) getActivity());
            if (arrayListA != null) {
                Iterator<chat.ola.vn.mediastore.a> it2 = arrayListA.iterator();
                while (it2.hasNext()) {
                    it2.next().a(this.q);
                }
            }
            this.k.setText(this.i.e_());
        } catch (Throwable unused2) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.actionBarIconSpan) {
                g_();
                return;
            }
            if (id == R.id.actionButtonClose) {
                a().d(d());
            } else if (id == R.id.actionButtonMore && this.i != null) {
                this.i.h_();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.mall_view_layout, viewGroup, false);
        this.l = (DrawerLayout) viewInflate.findViewById(R.id.mallDrawerLayout);
        this.l.setDrawerListener(new DrawerLayout.DrawerListener() { // from class: chat.ola.vn.m.g.1
            @Override // android.support.v4.widget.DrawerLayout.DrawerListener
            public void onDrawerClosed(View view) {
            }

            @Override // android.support.v4.widget.DrawerLayout.DrawerListener
            public void onDrawerOpened(View view) {
                g.this.B();
            }

            @Override // android.support.v4.widget.DrawerLayout.DrawerListener
            public void onDrawerSlide(View view, float f2) {
            }

            @Override // android.support.v4.widget.DrawerLayout.DrawerListener
            public void onDrawerStateChanged(int i) {
            }
        });
        this.g = (ListView) viewInflate.findViewById(R.id.lvSliderList);
        this.q = viewInflate.findViewById(R.id.actionBarSpan);
        this.p = viewInflate.findViewById(R.id.imgActionBackIndicate);
        this.j = viewInflate.findViewById(R.id.actionButtonMore);
        this.k = (TextView) viewInflate.findViewById(R.id.txtMallActionTitle);
        this.r = (ImageView) viewInflate.findViewById(R.id.btnMallActionTag);
        this.s = (ImageView) viewInflate.findViewById(R.id.btnMallActionNew);
        this.t = (ImageView) viewInflate.findViewById(R.id.btnMallActionHot);
        viewInflate.findViewById(R.id.actionButtonClose).setOnClickListener(this);
        this.r.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.g.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                g.this.f("/", (String) null);
            }
        });
        this.s.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.g.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                g.this.f("/mall/new?p=0", (String) null);
            }
        });
        this.t.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.g.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                g.this.f("/mall/hot?p=0&t=2&hl=true", (String) null);
            }
        });
        this.o = viewInflate.findViewById(R.id.mallWatting);
        viewInflate.findViewById(R.id.actionBarIconSpan).setOnClickListener(this);
        this.j.setOnClickListener(this);
        return viewInflate;
    }

    @Override // android.support.v4.app.Fragment
    public void onDestroy() {
        c = false;
        e = null;
        super.onDestroy();
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        c = false;
        super.onDetach();
        if (this.i != null) {
            this.i.c();
        }
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            e();
            chat.ola.vn.entity.e eVar = (chat.ola.vn.entity.e) adapterView.getAdapter().getItem(i);
            f(eVar.t(), eVar.J());
        } catch (Exception unused) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        e = new WeakReference<>(this);
        super.onResume();
    }

    public void v() {
        chat.ola.vn.entity.e eVar = new chat.ola.vn.entity.e();
        eVar.f("mall/search?q=");
        eVar.h(getString(R.string.string_search));
        eVar.f(-5);
        if (d != null) {
            a.add(d);
        }
        b(eVar);
    }

    public q x() {
        if (d == null) {
            return null;
        }
        return (q) getChildFragmentManager().findFragmentByTag("mall_tag_" + d.E());
    }
}
