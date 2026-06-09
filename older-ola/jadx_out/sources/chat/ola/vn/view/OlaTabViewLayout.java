package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import chat.ola.vn.R;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaTabViewLayout extends LinearLayout implements View.OnClickListener, View.OnLongClickListener {
    private FrameLayout a;
    private LinearLayout b;
    private List<c> c;
    private FragmentManager d;
    private c e;
    private a f;
    private String g;
    private int h;

    public interface a {
        boolean a(c cVar, int i);

        boolean b(c cVar, int i);
    }

    public interface b {
        void a(boolean z);
    }

    public class c {
        private Class<?> b;
        private String c;
        private boolean d;
        private String e;
        private c f;
        private View g;
        private Fragment h;
        private Bundle i = new Bundle();
        private Fragment.SavedState j;
        private b k;

        public c() {
        }

        public String a() {
            return this.c;
        }

        public void a(b bVar) {
            this.k = bVar;
        }

        public void a(c cVar) {
            this.f = cVar;
        }

        public void a(boolean z) {
            if (this.g != null) {
                this.g.setSelected(z);
                if (this.k != null) {
                    this.k.a(z);
                }
            }
        }
    }

    public OlaTabViewLayout(Context context) {
        super(context);
        this.g = null;
        this.h = -2;
        a();
    }

    public OlaTabViewLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.g = null;
        this.h = -2;
        a();
    }

    @SuppressLint({"NewApi"})
    public OlaTabViewLayout(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.g = null;
        this.h = -2;
        a();
    }

    private FragmentTransaction a(c cVar, FragmentTransaction fragmentTransaction, Bundle bundle) {
        try {
            if (this.e != cVar && cVar != null) {
                if (fragmentTransaction == null) {
                    fragmentTransaction = this.d.beginTransaction();
                }
                a(this.e, fragmentTransaction);
                b(cVar, fragmentTransaction, bundle);
                this.e = cVar;
                this.g = this.e.c;
                if (cVar.h != null) {
                    cVar.h.setMenuVisibility(true);
                    cVar.h.setUserVisibleHint(true);
                }
            }
            return fragmentTransaction;
        } catch (Throwable unused) {
            return null;
        }
    }

    private void a() {
        this.a = new FrameLayout(getContext());
        this.a.setId(R.id.tab_host_content);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-1, 0, 1.0f);
        setOrientation(1);
        addView(this.a, layoutParams);
        this.b = new LinearLayout(getContext());
        this.b.setId(R.id.tab_host_widget);
        addView(this.b, new LinearLayout.LayoutParams(-1, this.h));
        this.c = new ArrayList();
    }

    private void a(c cVar) {
        if (this.d == null) {
            throw new RuntimeException("this tab host not yet setup by setUpTabHost(FragmentManager fm);");
        }
        if (cVar == null || m.a(cVar.c) || cVar.b == null) {
            throw new RuntimeException("if (StringUtils.isBlank(tag) || fragment == null )");
        }
        if (d(cVar.c) == null) {
            this.c.add(cVar);
            setUpTab(cVar);
        }
        if (this.g == null) {
            this.g = cVar.c;
        }
    }

    private void a(c cVar, FragmentTransaction fragmentTransaction) {
        if (cVar != null) {
            Fragment fragmentFindFragmentByTag = cVar.c != null ? this.d.findFragmentByTag(cVar.c) : null;
            if (cVar.h == null) {
                cVar.h = fragmentFindFragmentByTag;
            }
            if (cVar.h != null) {
                if (cVar.d) {
                    fragmentTransaction.hide(cVar.h);
                } else {
                    if (fragmentFindFragmentByTag != null) {
                        try {
                            cVar.j = this.d.saveFragmentInstanceState(cVar.h);
                        } catch (Throwable unused) {
                        }
                    }
                    fragmentTransaction.remove(cVar.h);
                }
                try {
                    cVar.h.onSaveInstanceState(cVar.i);
                } catch (Throwable unused2) {
                }
                cVar.h.setMenuVisibility(false);
                cVar.h.setUserVisibleHint(false);
            }
        }
    }

    private void b(c cVar, FragmentTransaction fragmentTransaction, Bundle bundle) {
        Fragment fragmentFindFragmentByTag = cVar.c != null ? this.d.findFragmentByTag(cVar.c) : null;
        if (cVar.h == null) {
            cVar.h = fragmentFindFragmentByTag;
        }
        if (cVar.h != null && cVar.d && fragmentFindFragmentByTag != null) {
            fragmentTransaction.show(cVar.h);
            return;
        }
        if (fragmentFindFragmentByTag != null) {
            fragmentTransaction.remove(fragmentFindFragmentByTag);
        }
        if (cVar.i == null) {
            cVar.i = new Bundle();
        }
        if (bundle != null) {
            cVar.i.putAll(bundle);
        }
        cVar.h = Fragment.instantiate(getContext(), cVar.b.getName(), cVar.i);
        try {
            cVar.h.setArguments(cVar.i);
        } catch (Throwable unused) {
        }
        if (cVar.j != null) {
            try {
                cVar.h.setInitialSavedState(cVar.j);
            } catch (Throwable unused2) {
            }
        }
        fragmentTransaction.add(R.id.tab_host_content, cVar.h, cVar.c);
    }

    private void setUpTab(c cVar) {
        if (cVar.g != null) {
            cVar.g.setOnClickListener(this);
            cVar.g.setOnLongClickListener(this);
            this.b.addView(cVar.g, new LinearLayout.LayoutParams(0, -1, 1.0f));
        }
        if (this.c.size() == 1) {
            e(cVar.c);
        }
    }

    private void setUpWidgetSelected(c cVar) {
        c cVar2;
        if (this.e != null) {
            if (this.e.g != null) {
                cVar2 = this.e;
            } else if (this.e.f != null && this.e.f.g != null) {
                cVar2 = this.e.f;
            }
            cVar2.a(false);
        } else {
            for (c cVar3 : this.c) {
                if (cVar3.g != null) {
                    cVar3.a(false);
                }
            }
        }
        if (cVar != null) {
            if (cVar.g == null) {
                if (cVar.f == null || cVar.f.g == null) {
                    return;
                } else {
                    cVar = cVar.f;
                }
            }
            cVar.a(true);
        }
    }

    @SuppressLint({"CommitTransaction"})
    public Fragment a(String str, Bundle bundle) {
        if (this.e != null && m.a(str, this.e.c)) {
            if (bundle != null) {
                try {
                    this.e.h.getArguments().putAll(bundle);
                } catch (Throwable unused) {
                }
            }
            return this.e.h;
        }
        for (c cVar : this.c) {
            if (m.a(str, cVar.c)) {
                setUpWidgetSelected(cVar);
                cVar.e = null;
                if (cVar.f != null) {
                    cVar.f.e = cVar.c;
                }
                FragmentTransaction fragmentTransactionA = a(cVar, this.d.beginTransaction(), bundle);
                if (fragmentTransactionA != null) {
                    try {
                        fragmentTransactionA.commit();
                    } catch (Throwable unused2) {
                    }
                }
                return cVar.h;
            }
        }
        throw new RuntimeException("this tag #" + str + " not yet added");
    }

    public c a(String str, Class<?> cls, View view, boolean z) {
        return a(str, cls, view, z, null);
    }

    public c a(String str, Class<?> cls, View view, boolean z, b bVar) {
        if (m.a(str) || cls == null) {
            throw new RuntimeException("if (StringUtils.isBlank(tag) || fragment == null ");
        }
        c cVarD = d(str);
        if (cVarD != null) {
            return cVarD;
        }
        c cVar = new c();
        cVar.a(bVar);
        cVar.b = cls;
        cVar.d = z;
        cVar.c = str;
        cVar.g = view;
        a(cVar);
        return cVar;
    }

    public void a(String str) {
        Fragment fragmentFindFragmentByTag;
        if (m.a(str) || (fragmentFindFragmentByTag = this.d.findFragmentByTag(str)) == null) {
            return;
        }
        FragmentTransaction fragmentTransactionBeginTransaction = this.d.beginTransaction();
        fragmentTransactionBeginTransaction.remove(fragmentFindFragmentByTag);
        try {
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable unused) {
        }
    }

    public View b(String str) {
        if (m.a(str)) {
            return null;
        }
        for (c cVar : this.c) {
            if (m.a(str, cVar.c)) {
                return cVar.g;
            }
        }
        return null;
    }

    public Fragment c(String str) {
        if (m.a(str)) {
            return null;
        }
        for (c cVar : this.c) {
            if (m.a(str, cVar.c)) {
                return cVar.h;
            }
        }
        return null;
    }

    public c d(String str) {
        if (m.a(str)) {
            return null;
        }
        for (c cVar : this.c) {
            if (m.a(str, cVar.c)) {
                return cVar;
            }
        }
        return null;
    }

    public Fragment e(String str) {
        return a(str, (Bundle) null);
    }

    public Fragment getCurrentFragmentTab() {
        if (this.e != null) {
            return this.e.h;
        }
        return null;
    }

    public String getTabTag() {
        if (this.e != null) {
            return this.e.c;
        }
        return null;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (this.c != null) {
            FragmentTransaction fragmentTransactionBeginTransaction = this.d.beginTransaction();
            for (c cVar : this.c) {
                if (!m.a(cVar.c, this.g)) {
                    a(cVar, fragmentTransactionBeginTransaction);
                }
            }
            try {
                fragmentTransactionBeginTransaction.commit();
                this.d.executePendingTransactions();
            } catch (Throwable unused) {
            }
            e(this.g);
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        String str;
        for (c cVar : this.c) {
            if (cVar.g == view) {
                if (cVar.e != null) {
                    try {
                        if (this.f != null) {
                            c cVarD = d(cVar.e);
                            if (this.f.b(cVarD, this.c.indexOf(cVarD))) {
                                return;
                            }
                        }
                    } catch (Throwable unused) {
                    }
                    str = cVar.e;
                } else {
                    try {
                        if (this.f != null && this.f.b(cVar, this.c.indexOf(cVar))) {
                            return;
                        }
                    } catch (Throwable unused2) {
                    }
                    str = cVar.c;
                }
                e(str);
            }
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        for (c cVar : this.c) {
            if (cVar.g == view) {
                if (cVar.e != null) {
                    try {
                        if (this.f != null) {
                            c cVarD = d(cVar.e);
                            return this.f.a(cVarD, this.c.indexOf(cVarD));
                        }
                    } catch (Throwable unused) {
                        continue;
                    }
                } else if (this.f != null) {
                    return this.f.a(cVar, this.c.indexOf(cVar));
                }
            }
        }
        return false;
    }

    public void setOnTabChangeListener(a aVar) {
        this.f = aVar;
    }

    public void setTabHostHeight(int i) {
        if (this.h != i) {
            this.h = i;
            this.b.setLayoutParams(new LinearLayout.LayoutParams(-1, this.h));
        }
    }

    public void setUpTabHost(FragmentManager fragmentManager) {
        this.d = fragmentManager;
    }
}
