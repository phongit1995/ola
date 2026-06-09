package chat.ola.vn.m;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.DrawerLayout;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.b.ag;
import chat.ola.vn.b.ai;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import com.mg.ola.common.widget.OlaViewPager;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class j extends chat.ola.vn.m.a implements DrawerLayout.DrawerListener, AdapterView.OnItemClickListener {
    public static chat.ola.vn.entity.t a = null;
    public static chat.ola.vn.entity.t b = null;
    public static List<chat.ola.vn.entity.t> c = new ArrayList();
    public static boolean d = false;
    private static boolean e = false;
    private static WeakReference<j> f;
    private View A;
    private View B;
    private View g;
    private View h;
    private EditText i;
    private OlaViewPager j;
    private a k;
    private DrawerLayout l;
    private ListView o;
    private ListView p;
    private ag q;
    private ai r;
    private View s;
    private View t;
    private OlaQuickTypingSuggestedText u;
    private OlaQuickTypingSuggestedText v;
    private Animation w;
    private Animation x;
    private c y;
    private String z;

    private class a extends chat.ola.vn.view.b {
        private List<c> b;

        public a(FragmentManager fragmentManager) {
            super(fragmentManager);
            this.b = new ArrayList();
        }

        @Override // chat.ola.vn.view.b
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public c b(int i) {
            try {
                chat.ola.vn.entity.t tVar = j.c.get(i);
                if (chat.ola.vn.util.m.a(tVar.o()) || chat.ola.vn.util.m.b(tVar.o(), "null")) {
                    tVar.a((short) 0);
                }
                switch (tVar.m()) {
                    case 0:
                    case 1:
                    case 2:
                        c cVar = (c) Fragment.instantiate(j.this.getActivity(), x.class.getName());
                        cVar.a(j.this);
                        cVar.a(tVar);
                        return cVar;
                    default:
                        c cVar2 = (c) Fragment.instantiate(j.this.getActivity(), y.class.getName());
                        cVar2.a(j.this);
                        cVar2.a(tVar);
                        return cVar2;
                }
            } catch (Throwable th) {
                th.printStackTrace();
                return null;
            }
        }

        @Override // chat.ola.vn.view.b, android.support.v4.view.PagerAdapter
        public void destroyItem(ViewGroup viewGroup, int i, Object obj) {
            super.destroyItem(viewGroup, i, obj);
        }

        @Override // android.support.v4.view.PagerAdapter
        public int getCount() {
            if (j.c == null) {
                this.b.clear();
                return 0;
            }
            int size = j.c.size();
            int size2 = this.b.size();
            while (size2 > size) {
                size2--;
                this.b.set(size2, null);
            }
            while (this.b.size() < size) {
                this.b.add(null);
            }
            return size;
        }

        @Override // android.support.v4.view.PagerAdapter
        public int getItemPosition(Object obj) {
            if (this.b.indexOf(obj) == -1) {
                return -2;
            }
            return super.getItemPosition(obj);
        }

        @Override // chat.ola.vn.view.b, android.support.v4.view.PagerAdapter
        public Object instantiateItem(ViewGroup viewGroup, int i) {
            try {
                c cVar = (c) super.instantiateItem(viewGroup, i);
                cVar.a(j.c.get(i));
                cVar.a(j.this);
                this.b.set(i, cVar);
                return cVar;
            } catch (Throwable th) {
                th.printStackTrace();
                return super.instantiateItem(viewGroup, i);
            }
        }
    }

    private class b implements Runnable {
        public chat.ola.vn.entity.t a;
        public long b;

        public b(chat.ola.vn.entity.t tVar, long j) {
            this.a = tVar;
            this.b = j;
        }

        @Override // java.lang.Runnable
        public void run() {
            j.c.add(this.a);
            j.this.k.notifyDataSetChanged();
            this.a.e(this.b + 1);
            if (chat.ola.vn.h.s.a()) {
                chat.ola.vn.h.s.b(this.a);
                chat.ola.vn.h.s.i();
            }
            if (j.this.y != null) {
                j.this.y.h();
            }
            j.this.e();
            j.this.e(this.a);
        }
    }

    public static void a(Context context, String str) {
        if (str != null && str.toLowerCase().startsWith("rss://")) {
            str = str.substring("rss://".length());
        }
        e = true;
        if (f != null && f.get() != null) {
            f.get().b(new chat.ola.vn.entity.t(str), true);
        } else {
            a = new chat.ola.vn.entity.t(str);
            OlaBottomTabActivity.a(context, 2, (Bundle) null);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final chat.ola.vn.entity.t tVar, boolean z, final Runnable runnable) {
        try {
            e = false;
            if (tVar == null) {
                return;
            }
            if (e(tVar.o())) {
                try {
                    if (chat.ola.vn.util.m.b(tVar.o(), ((b) runnable).a.w())) {
                        runnable.run();
                        return;
                    }
                    return;
                } catch (Throwable unused) {
                    return;
                }
            }
            if (runnable == null && tVar.b()) {
                tVar.f(0);
                tVar.g(0);
                e(tVar);
            } else {
                this.g.setVisibility(0);
                if (z) {
                    h();
                }
                OlaApplication.b.r(tVar.o(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.d(tVar, null) { // from class: chat.ola.vn.m.j.2
                    @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
                    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        super.a(i, s, str, dVarArr);
                        try {
                            j.this.g.setVisibility(8);
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        super.a(objArr);
                        try {
                            j.this.g.setVisibility(8);
                        } catch (Throwable unused2) {
                        }
                        try {
                            long jCurrentTimeMillis = System.currentTimeMillis();
                            b bVar = j.this.new b(tVar, jCurrentTimeMillis);
                            String strW = tVar.w();
                            if (!chat.ola.vn.util.m.a(strW)) {
                                j.this.a(new chat.ola.vn.entity.t(strW), false, (Runnable) bVar);
                                return;
                            }
                            if (runnable == null) {
                                bVar.run();
                                return;
                            }
                            j.c.add(tVar);
                            j.this.k.notifyDataSetChanged();
                            tVar.e(jCurrentTimeMillis);
                            if (chat.ola.vn.h.s.a()) {
                                chat.ola.vn.h.s.b(tVar);
                            }
                            runnable.run();
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                }));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static j c() {
        if (f != null) {
            return f.get();
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e(chat.ola.vn.entity.t tVar) {
        final int iLastIndexOf = c.lastIndexOf(tVar);
        if (iLastIndexOf == -1) {
            if (!tVar.b()) {
                return;
            }
            c.add(tVar);
            this.k.notifyDataSetChanged();
            iLastIndexOf = c.size() - 1;
        }
        b = tVar;
        this.j.post(new Runnable() { // from class: chat.ola.vn.m.j.3
            @Override // java.lang.Runnable
            public void run() {
                j.this.j.setCurrentItem(iLastIndexOf, false);
                try {
                    j.this.y = (c) j.this.k.a(j.this.j, iLastIndexOf);
                    j.this.y.d();
                    j.this.d();
                } catch (Exception unused) {
                }
            }
        });
    }

    private chat.ola.vn.entity.t f(String str) {
        if (c == null || c.isEmpty()) {
            return null;
        }
        try {
            for (int size = c.size() - 1; size >= 0; size--) {
                chat.ola.vn.entity.t tVar = c.get(size);
                if (chat.ola.vn.util.m.c(tVar.o(), str)) {
                    return tVar;
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public String f(String str, String str2) {
        try {
            return "search/" + str + "/" + chat.ola.vn.util.m.q(str2);
        } catch (Throwable unused) {
            return null;
        }
    }

    private void h() {
        try {
            if (c.isEmpty()) {
                return;
            }
            c = c.subList(0, this.j.getCurrentItem() + 1);
            try {
                if (this.k.b.size() > c.size()) {
                    this.k.b = this.k.b.subList(0, c.size());
                }
            } catch (Throwable unused) {
            }
            this.k.notifyDataSetChanged();
        } catch (Throwable unused2) {
        }
    }

    public Dialog a(final chat.ola.vn.entity.t tVar, final boolean z) {
        final ArrayList arrayList = new ArrayList();
        if (z) {
            arrayList.add(getString(R.string.string_edit_bookmark));
        }
        arrayList.add(getString(R.string.string_copy));
        arrayList.add(getString(R.string.string_delete));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.j.12
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                FragmentActivity activity;
                String string;
                String string2;
                String string3;
                String string4;
                DialogInterface.OnClickListener onClickListener;
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(j.this.getString(R.string.string_edit_bookmark), str)) {
                        new chat.ola.vn.i.a(j.this.getActivity(), tVar).show();
                        return;
                    }
                    if (chat.ola.vn.util.m.b(j.this.getString(R.string.string_delete), str)) {
                        if (z) {
                            activity = j.this.getActivity();
                            string = j.this.getString(R.string.dialog_title_inform);
                            string2 = j.this.getString(R.string.message_clear_rss_bookmark);
                            string3 = j.this.getString(R.string.string_delete);
                            string4 = j.this.getString(R.string.string_close);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.j.12.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i2) {
                                    if (i2 == 0) {
                                        chat.ola.vn.h.s.d(tVar);
                                        chat.ola.vn.h.s.h();
                                        j.this.e();
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        } else {
                            activity = j.this.getActivity();
                            string = j.this.getString(R.string.dialog_title_inform);
                            string2 = j.this.getString(R.string.message_clear_rss_history);
                            string3 = j.this.getString(R.string.string_delete);
                            string4 = j.this.getString(R.string.string_close);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.j.12.2
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i2) {
                                    if (i2 == 0) {
                                        chat.ola.vn.h.s.c(tVar);
                                        chat.ola.vn.h.s.i();
                                        j.this.e();
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        }
                        chat.ola.vn.i.i.d(activity, string, string2, string3, string4, onClickListener);
                        return;
                    }
                    if (chat.ola.vn.util.m.b(j.this.getString(R.string.string_copy), str)) {
                        String strO = tVar.o();
                        if (chat.ola.vn.util.m.a(strO)) {
                            return;
                        }
                        if (chat.ola.vn.util.m.a(strO + "", "null")) {
                            return;
                        }
                        chat.ola.vn.util.o.a(j.this.getActivity(), "rss://" + strO);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    public void a(chat.ola.vn.entity.t tVar) {
        b(tVar, true);
    }

    public void a(chat.ola.vn.entity.t tVar, final Runnable runnable) {
        if (tVar == null) {
            return;
        }
        try {
            OlaApplication.b.r(tVar.o(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.d(tVar, null) { // from class: chat.ola.vn.m.j.14
                @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    super.a(i, s, str, dVarArr);
                    if (runnable != null) {
                        runnable.run();
                    }
                }

                @Override // chat.ola.vn.entry.c.d, chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    super.a(objArr);
                    if (runnable != null) {
                        runnable.run();
                    }
                }
            }));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        f = new WeakReference<>(this);
        this.k = new a(getChildFragmentManager());
        this.j.setAdapter(this.k);
        if (a != null) {
            b(a, false);
            a = null;
        } else if (b != null) {
            e(b);
        } else {
            a(new chat.ola.vn.entity.t((String) null));
        }
        this.j.post(new Runnable() { // from class: chat.ola.vn.m.j.13
            @Override // java.lang.Runnable
            public void run() {
                j.this.y = (c) j.this.k.a(j.this.j, j.this.j.getCurrentItem());
                j.this.d();
            }
        });
        this.q = new ag(getActivity());
        this.o.setAdapter((ListAdapter) this.q);
        this.r = new ai(getActivity());
        this.p.setAdapter((ListAdapter) this.r);
    }

    public void b(final chat.ola.vn.entity.t tVar) {
        chat.ola.vn.i.i.a(getActivity(), R.drawable.ic_tab_news, R.string.string_add_bookmark, R.string.string_bookmark_title, R.string.string_add, R.string.string_close, 540672, (List<String>) null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.j.6
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0 && chat.ola.vn.h.s.b()) {
                    String strA = ((chat.ola.vn.i.p) dialogInterface).a();
                    if (!chat.ola.vn.util.m.a(strA)) {
                        chat.ola.vn.r.b bVar = chat.ola.vn.h.s;
                        chat.ola.vn.entity.t tVarA = bVar.a(tVar.o());
                        long jCurrentTimeMillis = System.currentTimeMillis();
                        if (tVarA != null) {
                            tVarA.b(strA);
                            tVarA.e(jCurrentTimeMillis);
                            tVarA.d(jCurrentTimeMillis);
                        } else {
                            tVar.b(strA);
                            tVar.e(jCurrentTimeMillis);
                            bVar.a(tVar);
                            bVar.h();
                        }
                        chat.ola.vn.h.s.h();
                        j.this.e();
                    }
                }
                dialogInterface.dismiss();
            }
        }).e(tVar.p());
    }

    public void b(chat.ola.vn.entity.t tVar, boolean z) {
        a(tVar, z, (Runnable) null);
    }

    public void c(chat.ola.vn.entity.t tVar) {
        OlaMeComposerActivity.a(getActivity(), (String) null, tVar.p() + "\nrss://" + tVar.o(), d(tVar));
    }

    public String d(chat.ola.vn.entity.t tVar) {
        try {
            return tVar.h();
        } catch (Throwable unused) {
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:41:0x00d9 A[Catch: Throwable -> 0x017b, TryCatch #0 {Throwable -> 0x017b, blocks: (B:2:0x0000, B:4:0x0007, B:8:0x0015, B:10:0x0029, B:11:0x002d, B:13:0x0033, B:14:0x0041, B:16:0x0049, B:18:0x005e, B:20:0x0062, B:22:0x006e, B:25:0x007d, B:27:0x0085, B:28:0x0091, B:30:0x0099, B:31:0x00a2, B:39:0x00d2, B:41:0x00d9, B:43:0x00ed, B:44:0x0110, B:45:0x0114, B:47:0x0118, B:49:0x012c, B:50:0x0150, B:51:0x0174, B:32:0x00a6, B:34:0x00ae, B:35:0x00ba, B:37:0x00c2, B:38:0x00cf, B:17:0x0054), top: B:54:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:51:0x0174 A[Catch: Throwable -> 0x017b, TRY_LEAVE, TryCatch #0 {Throwable -> 0x017b, blocks: (B:2:0x0000, B:4:0x0007, B:8:0x0015, B:10:0x0029, B:11:0x002d, B:13:0x0033, B:14:0x0041, B:16:0x0049, B:18:0x005e, B:20:0x0062, B:22:0x006e, B:25:0x007d, B:27:0x0085, B:28:0x0091, B:30:0x0099, B:31:0x00a2, B:39:0x00d2, B:41:0x00d9, B:43:0x00ed, B:44:0x0110, B:45:0x0114, B:47:0x0118, B:49:0x012c, B:50:0x0150, B:51:0x0174, B:32:0x00a6, B:34:0x00ae, B:35:0x00ba, B:37:0x00c2, B:38:0x00cf, B:17:0x0054), top: B:54:0x0000 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void d() {
        /*
            Method dump skipped, instruction units count: 380
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.m.j.d():void");
    }

    @Override // chat.ola.vn.m.f
    public void d_() {
        try {
            this.y.d_();
        } catch (Throwable unused) {
        }
    }

    public void e() {
        chat.ola.vn.r.b bVar = chat.ola.vn.h.s;
        this.r.a((List) bVar.d());
        this.r.notifyDataSetChanged();
        this.q.a((List) bVar.c());
        this.q.notifyDataSetChanged();
        if (bVar.a()) {
            this.t.setVisibility(8);
        } else {
            this.t.setVisibility(0);
        }
        if (bVar.b()) {
            this.s.setVisibility(8);
        } else {
            this.s.setVisibility(0);
        }
    }

    public boolean e(String str) {
        try {
            chat.ola.vn.entity.t tVarF = f(str);
            if (tVarF == null || c.indexOf(tVarF) != c.size() - 1) {
                return false;
            }
            e(tVarF);
            return true;
        } catch (Throwable th) {
            th.printStackTrace();
            return false;
        }
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        if (e) {
            e = false;
            return false;
        }
        if (this.y != null && this.y.g_()) {
            return true;
        }
        int currentItem = this.j.getCurrentItem();
        if (currentItem != 0) {
            this.j.setCurrentItem(currentItem - 1, true);
            return true;
        }
        b = null;
        this.y = null;
        return false;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.btnLeftButtonClear /* 2131296475 */:
                    chat.ola.vn.i.i.d(getActivity(), getString(R.string.dialog_title_inform), getString(R.string.message_clear_all_rss_bookmark), getString(R.string.string_clear), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.j.4
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                chat.ola.vn.h.s.e();
                                chat.ola.vn.h.s.h();
                                j.this.e();
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    break;
                case R.id.btnRightButtonClear /* 2131296536 */:
                    chat.ola.vn.i.i.d(getActivity(), getString(R.string.dialog_title_inform), getString(R.string.message_clear_all_rss_history), getString(R.string.string_clear), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.j.5
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                chat.ola.vn.h.s.f();
                                chat.ola.vn.h.s.i();
                                j.this.e();
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    break;
                case R.id.newsActionBarHomeImageView /* 2131297128 */:
                    a(new chat.ola.vn.entity.t((String) null));
                    break;
                case R.id.olaActionBarBackImageView /* 2131297178 */:
                    int currentItem = this.j.getCurrentItem();
                    if (currentItem != 0) {
                        this.j.setCurrentItem(currentItem - 1, true);
                        break;
                    }
                    break;
                case R.id.olaActionBarMoreButtonImageView /* 2131297185 */:
                    if (this.y != null) {
                        this.y.h_();
                    }
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.news_content_view_layout, viewGroup, false);
        this.l = (DrawerLayout) viewInflate.findViewById(R.id.newsDrawerLayout);
        this.l.setDrawerListener(this);
        View viewFindViewById = this.l.findViewById(R.id.left_drawer);
        this.o = (ListView) viewFindViewById.findViewById(R.id.left_List);
        this.o.setOnItemClickListener(this);
        this.o.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() { // from class: chat.ola.vn.m.j.1
            @Override // android.widget.AdapterView.OnItemLongClickListener
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    j.this.a((chat.ola.vn.entity.t) adapterView.getAdapter().getItem(i), true);
                    return true;
                } catch (Throwable unused) {
                    return false;
                }
            }
        });
        this.s = viewFindViewById.findViewById(R.id.progressBookmarkWatting);
        this.u = (OlaQuickTypingSuggestedText) viewFindViewById.findViewById(R.id.txtLeftMenuInput);
        this.u.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.m.j.7
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                try {
                    j.this.q.getFilter().filter(chat.ola.vn.util.m.h(charSequence.toString()));
                } catch (Throwable unused) {
                    j.this.q.getFilter().filter(charSequence);
                }
            }
        });
        viewFindViewById.findViewById(R.id.btnLeftButtonClear).setOnClickListener(this);
        View viewFindViewById2 = this.l.findViewById(R.id.right_drawer);
        this.p = (ListView) viewFindViewById2.findViewById(R.id.right_List);
        this.p.setOnItemClickListener(this);
        this.p.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() { // from class: chat.ola.vn.m.j.8
            @Override // android.widget.AdapterView.OnItemLongClickListener
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    j.this.a((chat.ola.vn.entity.t) adapterView.getAdapter().getItem(i), false);
                    return true;
                } catch (Throwable unused) {
                    return false;
                }
            }
        });
        this.t = viewFindViewById2.findViewById(R.id.progressHistoryWatting);
        this.v = (OlaQuickTypingSuggestedText) viewFindViewById2.findViewById(R.id.txtRightMenuInput);
        this.v.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.m.j.9
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                try {
                    j.this.r.getFilter().filter(chat.ola.vn.util.m.h(charSequence.toString()));
                } catch (Throwable unused) {
                    j.this.r.getFilter().filter(charSequence);
                }
            }
        });
        viewFindViewById2.findViewById(R.id.btnRightButtonClear).setOnClickListener(this);
        this.g = viewInflate.findViewById(R.id.progressNewsWatting);
        this.g.setVisibility(8);
        this.h = viewInflate.findViewById(R.id.olaActionBarMoreButtonImageView);
        this.j = (OlaViewPager) viewInflate.findViewById(R.id.newsContentPager);
        this.j.setOffscreenPageLimit(3);
        this.j.setOnPageChangeListener(new ViewPager.OnPageChangeListener() { // from class: chat.ola.vn.m.j.10
            @Override // android.support.v4.view.ViewPager.OnPageChangeListener
            public void onPageScrollStateChanged(int i) {
                if (i == 0) {
                    try {
                        if (j.this.y != null) {
                            j.this.y.h();
                            j.this.y.c();
                        }
                        int currentItem = j.this.j.getCurrentItem();
                        j.this.y = (c) j.this.k.a(j.this.j, currentItem);
                        j.b = j.c.get(currentItem);
                        j.this.y.a(j.b);
                        j.this.d();
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            }

            @Override // android.support.v4.view.ViewPager.OnPageChangeListener
            public void onPageScrolled(int i, float f2, int i2) {
            }

            @Override // android.support.v4.view.ViewPager.OnPageChangeListener
            public void onPageSelected(int i) {
            }
        });
        this.h.setOnClickListener(this);
        this.z = chat.ola.vn.e.a().r();
        this.A = viewInflate.findViewById(R.id.olaActionBarBackImageView);
        this.A.setOnClickListener(this);
        this.B = viewInflate.findViewById(R.id.newsActionBarHomeImageView);
        this.B.setOnClickListener(this);
        this.B.setVisibility(8);
        this.i = (EditText) viewInflate.findViewById(R.id.searchNewsEditText);
        this.i.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.m.j.11
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                j jVar;
                String str;
                try {
                    if (keyEvent.getKeyCode() != 66 && i != 3) {
                        return false;
                    }
                    try {
                        if (j.b != null) {
                            if (j.b.o().toLowerCase(Locale.US).startsWith("note/")) {
                                jVar = j.this;
                                str = "note";
                            } else if (j.b.o().toLowerCase(Locale.US).startsWith("fic/")) {
                                jVar = j.this;
                                str = "fic";
                            } else {
                                jVar = j.this;
                                str = "news";
                            }
                            jVar.z = str;
                        }
                    } catch (Throwable unused) {
                    }
                    String strF = j.this.f(j.this.z, j.this.i.getText().toString());
                    if (chat.ola.vn.util.m.a(strF)) {
                        return false;
                    }
                    chat.ola.vn.util.o.a((Context) j.this.getActivity(), (View) j.this.i, false);
                    j.this.a(new chat.ola.vn.entity.t(strF));
                    return true;
                } catch (Throwable unused2) {
                    return false;
                }
            }
        });
        this.w = AnimationUtils.loadAnimation(getActivity(), R.anim.fade_out);
        this.w.setDuration(300L);
        this.x = AnimationUtils.loadAnimation(getActivity(), R.anim.fade_in);
        this.x.setDuration(300L);
        return viewInflate;
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        e = false;
        f = null;
        super.onDetach();
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerClosed(View view) {
        try {
            chat.ola.vn.util.o.a((Context) getActivity(), (View) this.u, false);
            chat.ola.vn.util.o.a((Context) getActivity(), (View) this.v, false);
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    @SuppressLint({"RtlHardcoded"})
    public void onDrawerOpened(View view) {
        View view2;
        View view3;
        if (this.l.isDrawerVisible(3)) {
            if (chat.ola.vn.h.s.b()) {
                view2 = this.s;
                view2.setVisibility(8);
            } else {
                view3 = this.s;
                view3.setVisibility(0);
            }
        }
        if (chat.ola.vn.h.s.a()) {
            view2 = this.t;
            view2.setVisibility(8);
        } else {
            view3 = this.t;
            view3.setVisibility(0);
        }
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerSlide(View view, float f2) {
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerStateChanged(int i) {
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    @SuppressLint({"RtlHardcoded"})
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            this.v.setText("");
            this.u.setText("");
            a((chat.ola.vn.entity.t) adapterView.getAdapter().getItem(i));
            this.l.closeDrawer(3);
            this.l.closeDrawer(5);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        try {
            this.y.onResume();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        if (bundle != null) {
            bundle.putParcelable("news_pager_state", this.j.onSaveInstanceState());
        }
        super.onSaveInstanceState(bundle);
    }
}
