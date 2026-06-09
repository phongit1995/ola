package chat.ola.vn.m;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.entity.ag;
import com.mg.ola.common.widget.OlaViewPager;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class e extends a {
    private static WeakReference<e> l = null;
    private static boolean o = false;
    private static CountDownTimer p;
    public View a;
    private p b;
    private short c = -1;
    private TextView d;
    private TextView e;
    private TextView f;
    private View g;
    private View h;
    private OlaViewPager i;
    private FragmentPagerAdapter j;
    private List<f> k;

    static {
        long j = 300000;
        p = new CountDownTimer(j, j) { // from class: chat.ola.vn.m.e.1
            @Override // android.os.CountDownTimer
            public void onFinish() {
                boolean unused = e.o = true;
            }

            @Override // android.os.CountDownTimer
            public void onTick(long j2) {
            }
        };
    }

    public static void a(Context context) {
        if (l == null || l.get() == null) {
            return;
        }
        e eVar = l.get();
        if (l.get().c == 1) {
            eVar.a((short) 0, eVar.getArguments());
        } else {
            eVar.a((short) 1, eVar.getArguments());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(short s, Bundle bundle) {
        try {
            this.i.setCurrentItem(s);
            try {
                this.b.onPause();
            } catch (Throwable unused) {
            }
            this.b = c(s);
            try {
                Bundle arguments = this.b.getArguments();
                if (arguments != null) {
                    arguments.putAll(bundle);
                } else {
                    this.b.setArguments(bundle);
                }
            } catch (Throwable unused2) {
            }
            this.c = s;
        } catch (Throwable unused3) {
        }
    }

    public static final void b(Context context) {
        if (l != null && l.get() != null) {
            e eVar = l.get();
            eVar.a((short) 0, eVar.getArguments());
        } else {
            Bundle bundle = new Bundle();
            bundle.putShort("EXTRA_REQUEST_SUBTAB_ID", (short) 0);
            OlaBottomTabActivity.a(context, 0, bundle);
        }
    }

    public static e c() {
        if (l != null) {
            return l.get();
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public p c(int i) {
        try {
            return (p) getChildFragmentManager().findFragmentByTag("android:switcher:" + this.i.getId() + ":" + i);
        } catch (Throwable unused) {
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void j() {
        switch (this.i.getCurrentItem()) {
            case 0:
                this.d.setSelected(false);
                this.d.setTextColor(chat.ola.vn.f.D);
                this.e.setSelected(true);
                this.e.setTextColor(chat.ola.vn.f.C);
                try {
                    chat.ola.vn.util.c.b.a(OlaApplication.a());
                } catch (Throwable unused) {
                    return;
                }
                break;
            case 1:
                this.d.setSelected(true);
                this.d.setTextColor(chat.ola.vn.f.C);
                this.e.setSelected(false);
                this.e.setTextColor(chat.ola.vn.f.D);
                break;
        }
    }

    @Override // chat.ola.vn.m.a, chat.ola.vn.m.f
    protected void a(final Bundle bundle) {
        final short s;
        if (bundle != null) {
            try {
                if (bundle.containsKey("viewpagerState")) {
                    this.i.onRestoreInstanceState(bundle.getParcelable("viewpagerState"));
                    bundle.remove("viewpagerState");
                    try {
                        if (getActivity().getIntent() != null) {
                            getActivity().getIntent().removeExtra("viewpagerState");
                        }
                    } catch (Throwable unused) {
                    }
                }
                if (bundle.containsKey("EXTRA_REQUEST_SUBTAB_ID")) {
                    s = bundle.getShort("EXTRA_REQUEST_SUBTAB_ID", (short) 0);
                    bundle.remove("EXTRA_REQUEST_SUBTAB_ID");
                    try {
                        if (getActivity().getIntent() != null) {
                            getActivity().getIntent().removeExtra("EXTRA_REQUEST_SUBTAB_ID");
                        }
                    } catch (Throwable unused2) {
                    }
                } else {
                    s = bundle.getShort("EXTRA_REQUEST_SUBTAB_ID", (short) 0);
                }
                try {
                    p.cancel();
                    if (o) {
                        o = false;
                        if (chat.ola.vn.h.t.q() > 0) {
                            s = 0;
                        }
                    }
                } catch (Throwable unused3) {
                }
                this.i.post(new Runnable() { // from class: chat.ola.vn.m.e.2
                    @Override // java.lang.Runnable
                    public void run() {
                        e.this.a(s, bundle);
                        e.this.j();
                        try {
                            e.this.c(s).h();
                            e.this.e();
                        } catch (Throwable unused4) {
                        }
                    }
                });
            } catch (Throwable unused4) {
            }
            e();
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(ag agVar, short s) {
        try {
            super.a(agVar, s);
            this.b.a(agVar, s);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(Short sh, int i) {
        try {
            super.a(sh, i);
            this.b.a(sh, i);
        } catch (Throwable unused) {
        }
    }

    public void a(boolean z) {
        this.h.setVisibility(z ? 0 : 8);
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        try {
            l = new WeakReference<>(this);
            this.k = new ArrayList();
            for (int i = 0; i < 2; i++) {
                this.k.add(null);
            }
            this.j = new FragmentPagerAdapter(getChildFragmentManager()) { // from class: chat.ola.vn.m.e.5
                @Override // android.support.v4.app.FragmentPagerAdapter, android.support.v4.view.PagerAdapter
                public void destroyItem(ViewGroup viewGroup, int i2, Object obj) {
                    e.this.k.set(i2, null);
                    super.destroyItem(viewGroup, i2, obj);
                }

                @Override // android.support.v4.view.PagerAdapter
                public int getCount() {
                    return 2;
                }

                @Override // android.support.v4.app.FragmentPagerAdapter
                public Fragment getItem(int i2) {
                    p pVar;
                    List list;
                    try {
                        Bundle arguments = e.this.getArguments();
                        switch (i2) {
                            case 0:
                                if (e.this.k.get(i2) == null) {
                                    pVar = (o) Fragment.instantiate(e.this.getActivity(), o.class.getName(), arguments);
                                } else {
                                    list = e.this.k;
                                    pVar = (p) list.get(i2);
                                }
                                break;
                            case 1:
                                if (e.this.k.get(i2) == null) {
                                    pVar = (n) Fragment.instantiate(e.this.getActivity(), n.class.getName(), arguments);
                                } else {
                                    list = e.this.k;
                                    pVar = (p) list.get(i2);
                                }
                                break;
                            default:
                                pVar = null;
                                break;
                        }
                        pVar.a(e.this);
                        pVar.setArguments(arguments);
                        return pVar;
                    } catch (Throwable unused) {
                        return null;
                    }
                }

                @Override // android.support.v4.app.FragmentPagerAdapter
                public long getItemId(int i2) {
                    return i2;
                }

                @Override // android.support.v4.app.FragmentPagerAdapter, android.support.v4.view.PagerAdapter
                public Object instantiateItem(ViewGroup viewGroup, int i2) {
                    try {
                        p pVarC = e.this.c(i2);
                        pVarC.a(e.this);
                        try {
                            pVarC.setArguments(e.this.getArguments());
                        } catch (Exception unused) {
                        }
                        e.this.k.set(i2, pVarC);
                    } catch (Throwable unused2) {
                    }
                    return super.instantiateItem(viewGroup, i2);
                }
            };
            this.i.setAdapter(this.j);
        } catch (Throwable unused) {
        }
    }

    public short d() {
        return this.c;
    }

    /* JADX WARN: Removed duplicated region for block: B:35:0x00a2 A[Catch: Throwable -> 0x00b8, TryCatch #1 {Throwable -> 0x00b8, blocks: (B:33:0x009a, B:35:0x00a2, B:37:0x00aa), top: B:42:0x009a }] */
    /* JADX WARN: Removed duplicated region for block: B:37:0x00aa A[Catch: Throwable -> 0x00b8, TRY_LEAVE, TryCatch #1 {Throwable -> 0x00b8, blocks: (B:33:0x009a, B:35:0x00a2, B:37:0x00aa), top: B:42:0x009a }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void e() {
        /*
            r6 = this;
            r0 = 0
            chat.ola.vn.m.p r1 = r6.b     // Catch: java.lang.Throwable -> L9a
            r2 = 4
            if (r1 == 0) goto L1b
            chat.ola.vn.m.p r1 = r6.b     // Catch: java.lang.Throwable -> L9a
            r1.h()     // Catch: java.lang.Throwable -> L9a
            android.view.View r1 = r6.a     // Catch: java.lang.Throwable -> L9a
            chat.ola.vn.m.p r3 = r6.b     // Catch: java.lang.Throwable -> L9a
            boolean r3 = r3.i()     // Catch: java.lang.Throwable -> L9a
            if (r3 == 0) goto L17
            r3 = 0
            goto L18
        L17:
            r3 = 4
        L18:
            r1.setVisibility(r3)     // Catch: java.lang.Throwable -> L9a
        L1b:
            android.view.View r1 = r6.g     // Catch: java.lang.Throwable -> L9a
            r3 = 2131296714(0x7f0901ca, float:1.8211352E38)
            android.view.View r1 = r1.findViewById(r3)     // Catch: java.lang.Throwable -> L9a
            android.widget.ImageView r1 = (android.widget.ImageView) r1     // Catch: java.lang.Throwable -> L9a
            android.view.View r3 = r6.g     // Catch: java.lang.Throwable -> L9a
            r4 = 2131296715(0x7f0901cb, float:1.8211355E38)
            android.view.View r3 = r3.findViewById(r4)     // Catch: java.lang.Throwable -> L9a
            android.widget.ImageView r3 = (android.widget.ImageView) r3     // Catch: java.lang.Throwable -> L9a
            chat.ola.vn.m.p r4 = r6.b     // Catch: java.lang.Throwable -> L9a
            android.support.v4.app.FragmentActivity r5 = r6.getActivity()     // Catch: java.lang.Throwable -> L9a
            chat.ola.vn.mediastore.a r4 = r4.b(r5)     // Catch: java.lang.Throwable -> L9a
            if (r4 == 0) goto L5c
            boolean r5 = r4.e     // Catch: java.lang.Throwable -> L9a
            if (r5 == 0) goto L5c
            r1.setVisibility(r0)     // Catch: java.lang.Throwable -> L9a
            java.lang.String r5 = r4.c     // Catch: java.lang.Throwable -> L9a
            r1.setTag(r5)     // Catch: java.lang.Throwable -> L9a
            android.view.View$OnClickListener r5 = r4.f     // Catch: java.lang.Throwable -> L9a
            r1.setTag(r5)     // Catch: java.lang.Throwable -> L9a
            int r5 = r4.b     // Catch: java.lang.Throwable -> L9a
            if (r5 <= 0) goto L58
            int r4 = r4.b     // Catch: java.lang.Throwable -> L9a
            r1.setImageResource(r4)     // Catch: java.lang.Throwable -> L9a
            goto L5f
        L58:
            r1.setImageResource(r0)     // Catch: java.lang.Throwable -> L9a
            goto L5f
        L5c:
            r1.setVisibility(r2)     // Catch: java.lang.Throwable -> L9a
        L5f:
            chat.ola.vn.m.p r1 = r6.b     // Catch: java.lang.Throwable -> L9a
            boolean r1 = r1.i()     // Catch: java.lang.Throwable -> L9a
            if (r1 != 0) goto L96
            chat.ola.vn.m.p r1 = r6.b     // Catch: java.lang.Throwable -> L9a
            android.support.v4.app.FragmentActivity r4 = r6.getActivity()     // Catch: java.lang.Throwable -> L9a
            chat.ola.vn.mediastore.a r1 = r1.c(r4)     // Catch: java.lang.Throwable -> L9a
            if (r1 == 0) goto L92
            boolean r4 = r1.e     // Catch: java.lang.Throwable -> L9a
            if (r4 == 0) goto L92
            r3.setVisibility(r0)     // Catch: java.lang.Throwable -> L9a
            java.lang.String r2 = r1.c     // Catch: java.lang.Throwable -> L9a
            r3.setTag(r2)     // Catch: java.lang.Throwable -> L9a
            android.view.View$OnClickListener r2 = r1.f     // Catch: java.lang.Throwable -> L9a
            r3.setTag(r2)     // Catch: java.lang.Throwable -> L9a
            int r2 = r1.b     // Catch: java.lang.Throwable -> L9a
            if (r2 <= 0) goto L8e
            int r1 = r1.b     // Catch: java.lang.Throwable -> L9a
        L8a:
            r3.setImageResource(r1)     // Catch: java.lang.Throwable -> L9a
            goto L9a
        L8e:
            r3.setImageResource(r0)     // Catch: java.lang.Throwable -> L9a
            goto L9a
        L92:
            r3.setVisibility(r2)     // Catch: java.lang.Throwable -> L9a
            goto L9a
        L96:
            r1 = 2131232556(0x7f08072c, float:1.8081225E38)
            goto L8a
        L9a:
            chat.ola.vn.message.g r1 = chat.ola.vn.h.t     // Catch: java.lang.Throwable -> Lb8
            int r1 = r1.q()     // Catch: java.lang.Throwable -> Lb8
            if (r1 != 0) goto Laa
            android.widget.TextView r0 = r6.f     // Catch: java.lang.Throwable -> Lb8
            r1 = 8
            r0.setVisibility(r1)     // Catch: java.lang.Throwable -> Lb8
            return
        Laa:
            android.widget.TextView r2 = r6.f     // Catch: java.lang.Throwable -> Lb8
            java.lang.String r1 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> Lb8
            r2.setText(r1)     // Catch: java.lang.Throwable -> Lb8
            android.widget.TextView r1 = r6.f     // Catch: java.lang.Throwable -> Lb8
            r1.setVisibility(r0)     // Catch: java.lang.Throwable -> Lb8
        Lb8:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.m.e.e():void");
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        try {
            if (this.b.g_()) {
                return true;
            }
        } catch (Throwable unused) {
        }
        return super.g_();
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        try {
            if (this.b != null) {
                return this.b.h_();
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.conversationTabLeftButton /* 2131296714 */:
                    if (this.b != null && (this.b instanceof View.OnClickListener)) {
                        ((View.OnClickListener) this.b).onClick(view);
                        break;
                    }
                    break;
                case R.id.conversationTabRightButton /* 2131296715 */:
                    h_();
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        try {
            this.g = layoutInflater.inflate(R.layout.contact_view_layout, viewGroup, false);
            this.i = (OlaViewPager) this.g.findViewById(R.id.contactFragmentHolder);
            this.i.setOffscreenPageLimit(10);
            this.i.setOnPageChangeListener(new ViewPager.OnPageChangeListener() { // from class: chat.ola.vn.m.e.3
                @Override // android.support.v4.view.ViewPager.OnPageChangeListener
                public void onPageScrollStateChanged(int i) {
                }

                @Override // android.support.v4.view.ViewPager.OnPageChangeListener
                public void onPageScrolled(int i, float f, int i2) {
                }

                @Override // android.support.v4.view.ViewPager.OnPageChangeListener
                public void onPageSelected(int i) {
                    e.this.b = e.this.c(i);
                    e.this.c = (short) i;
                    e.this.e();
                    e.this.j();
                }
            });
            this.h = this.g.findViewById(R.id.loadingProgressBar);
            this.h.setVisibility(8);
            this.d = (TextView) this.g.findViewById(R.id.btnTabContactList);
            this.e = (TextView) this.g.findViewById(R.id.btnTabConversation);
            this.f = (TextView) this.g.findViewById(R.id.txtTabConversationInfo);
            View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.m.e.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    short s;
                    e eVar;
                    e eVar2;
                    e eVar3;
                    try {
                        switch (view.getId()) {
                            case R.id.btnTabContactList /* 2131296546 */:
                                s = 1;
                                if (((e) e.l.get()).c != 1) {
                                    eVar = e.this;
                                    eVar2 = e.this;
                                    eVar.a(s, eVar2.getArguments());
                                } else {
                                    eVar3 = e.this;
                                    eVar3.b.f_();
                                }
                                break;
                            case R.id.btnTabConversation /* 2131296547 */:
                                if (((e) e.l.get()).c != 0) {
                                    eVar = e.this;
                                    s = 0;
                                    eVar2 = e.this;
                                    eVar.a(s, eVar2.getArguments());
                                } else {
                                    eVar3 = e.this;
                                    eVar3.b.f_();
                                }
                                break;
                        }
                    }
                }
            };
            this.d.setOnClickListener(onClickListener);
            this.e.setOnClickListener(onClickListener);
            this.g.findViewById(R.id.conversationTabLeftButton).setOnClickListener(this);
            this.a = this.g.findViewById(R.id.conversationTabRightButton);
            this.a.setOnClickListener(this);
            return this.g;
        } catch (Throwable th) {
            th.printStackTrace();
            return new View(getActivity());
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onDestroy() {
        if (l != null) {
            l.clear();
        }
        l = null;
        super.onDestroy();
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        super.onDetach();
        if (l != null) {
            l.clear();
        }
        l = null;
        p.start();
    }

    @Override // android.support.v4.app.Fragment
    public void onPause() {
        super.onPause();
        try {
            this.b.onPause();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        try {
            p.cancel();
            if (o) {
                o = false;
                if (chat.ola.vn.h.t.q() > 0) {
                    this.i.setCurrentItem(0);
                }
            }
            j();
        } catch (Throwable th) {
            th.printStackTrace();
        }
        l = new WeakReference<>(this);
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        if (bundle != null) {
            try {
                bundle.putShort("EXTRA_REQUEST_SUBTAB_ID", (short) Math.max((int) this.c, 0));
                bundle.putParcelable("viewpagerState", this.i.onSaveInstanceState());
            } catch (Throwable unused) {
            }
        }
        try {
            bundle.putAll(getArguments());
        } catch (Exception unused2) {
        }
        for (f fVar : this.k) {
            if (fVar != null) {
                fVar.onSaveInstanceState(bundle);
            }
        }
        super.onSaveInstanceState(bundle);
    }
}
