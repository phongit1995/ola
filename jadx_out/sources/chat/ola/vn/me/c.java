package chat.ola.vn.me;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.app.FragmentActivity;
import android.support.v4.widget.DrawerLayout;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.MarriageRequestComposerActivity;
import chat.ola.vn.activity.OlaAppSettingActivity;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaReleaseAppActivity;
import chat.ola.vn.b.an;
import chat.ola.vn.b.j;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.b.u;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.n;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.r.a.e;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaListView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import com.mg.ola.common.d.g;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class c extends chat.ola.vn.m.a implements DrawerLayout.DrawerListener, View.OnFocusChangeListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, j.a, chat.ola.vn.f.a, chat.ola.vn.r.a.d, OlaQuickTypingSuggestedText.b {
    private static n E;
    public static WeakReference<c> a;
    private q A;
    private TextView B;
    private TextView C;
    private View D;
    private ProgressDialog I;
    private Runnable J;
    private u b;
    private OlaListView c;
    private View d;
    private Animation e;
    private Animation f;
    private Animation g;
    private Animation h;
    private ImageView i;
    private ImageView j;
    private ImageView k;
    private ImageView l;
    private DrawerLayout o;
    private View p;
    private View q;
    private OlaListView u;
    private an v;
    private OlaListView w;
    private b x;
    private OlaQuickTypingSuggestedText y;
    private Parcelable z;
    private boolean r = false;
    private boolean s = true;
    private String t = null;
    private SwipeRefreshLayout F = null;
    private boolean G = false;
    private Runnable H = null;

    private void A() {
        View view;
        switch (h.u.c()) {
            case 0:
                this.c.setVisibility(0);
                this.p.setVisibility(8);
                this.d.setVisibility(0);
                return;
            case 1:
                this.c.setVisibility(8);
                this.p.setVisibility(0);
                if (getView() != null) {
                    getView().findViewById(R.id.btnActive).setOnClickListener(this);
                }
                view = this.d;
                break;
            default:
                this.c.setVisibility(0);
                view = this.p;
                break;
        }
        view.setVisibility(8);
    }

    private void a(long j) {
        if (OlaApplication.b != null) {
            chat.ola.vn.entry.c.b bVar = new chat.ola.vn.entry.c.b(j) { // from class: chat.ola.vn.me.c.14
                @Override // chat.ola.vn.entry.c.b, chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    c.this.r = false;
                    c.this.s = false;
                    if (c.this.getActivity() != null) {
                        c.this.q.setVisibility(8);
                        c.this.d.setVisibility(8);
                    }
                }

                @Override // chat.ola.vn.entry.c.b, chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    super.a(objArr);
                    c.this.r = false;
                    c.this.s = true;
                    try {
                        List list = (List) objArr[2];
                        if (list == null || list.size() == 0) {
                            c.this.s = true;
                        }
                    } catch (Throwable unused) {
                    }
                    if (c.this.getActivity() != null) {
                        c.this.q.setVisibility(8);
                        c.this.d.setVisibility(8);
                    }
                }
            };
            h.u.a(0);
            h.u.a(true);
            OlaApplication.b.c(j, f.a(bVar));
        }
    }

    public static void a(Context context, OlaNetworkService olaNetworkService, String str) {
        try {
            String strJ = m.j(str);
            if (!e(strJ)) {
                if (m.b("my diary", strJ)) {
                    OlaDiaryActivity.a(context);
                    return;
                } else {
                    if (m.b("mariage diary", strJ)) {
                        return;
                    }
                    OlaUserMePageActivity.a(context, strJ);
                    return;
                }
            }
            if (a == null || a.get() == null) {
                e eVar = h.u;
                eVar.a(0);
                eVar.a(true);
                if (olaNetworkService != null) {
                    olaNetworkService.a(strJ, f.a(new chat.ola.vn.entry.c.c(strJ, 0L)));
                }
            } else {
                OlaBottomTabActivity olaBottomTabActivityA = a.get().a();
                if (olaBottomTabActivityA != null) {
                    olaBottomTabActivityA.J();
                }
                OlaBottomTabActivity.a(context, 1);
                a.get().f(strJ);
            }
            OlaBottomTabActivity.a(context, 1);
            E = null;
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, OlaNetworkService olaNetworkService, String str, n nVar) {
        a(context, olaNetworkService, str);
        E = nVar;
    }

    public static void a(Context context, String str) {
        a(context, OlaApplication.b, str);
    }

    private void a(OlaCachedImageView olaCachedImageView, String str) {
        t.a().g(str, olaCachedImageView);
    }

    private void a(String str, long j) {
        if (j == 0) {
            E = null;
        }
        if (m.b("my diary", str)) {
            OlaDiaryActivity.a(getActivity());
            return;
        }
        if (m.b("mariage diary", str)) {
            a(j);
            return;
        }
        String strJ = m.j(str);
        if (!e(strJ)) {
            OlaUserMePageActivity.a(getActivity(), strJ);
            return;
        }
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            chat.ola.vn.entry.c.c cVar = new chat.ola.vn.entry.c.c(strJ, j) { // from class: chat.ola.vn.me.c.15
                @Override // chat.ola.vn.entry.c.c, chat.ola.vn.entry.c.e
                public void a(int i, short s, String str2, chat.ola.vn.entity.d[] dVarArr) {
                    super.a(i, s, str2, dVarArr);
                    try {
                        c.this.r = false;
                        c.this.s = false;
                        if (c.this.getActivity() != null) {
                            c.this.q.setVisibility(8);
                            c.this.d.setVisibility(8);
                        }
                        c.this.b.notifyDataSetChanged();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.entry.c.c, chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    super.a(objArr);
                    try {
                        c.this.r = false;
                        c.this.s = true;
                        try {
                            List list = (List) objArr[2];
                            if (list == null || list.size() == 0) {
                                c.this.s = false;
                            }
                        } catch (Throwable unused) {
                        }
                        if (c.this.getActivity() != null) {
                            c.this.q.setVisibility(8);
                            c.this.d.setVisibility(8);
                        }
                    } catch (Throwable unused2) {
                    }
                }
            };
            if (j == 0) {
                h.u.a(true);
                this.q.setVisibility(0);
            } else {
                h.u.a(false);
                this.q.setVisibility(8);
            }
            this.r = true;
            if (j > 0) {
                olaNetworkService.a(strJ, j, f.a(cVar));
                this.d.setVisibility(0);
            } else {
                olaNetworkService.a(strJ, f.a(cVar));
            }
            h.u.a(0);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        try {
            if (this.J == null) {
                this.J = new Runnable() { // from class: chat.ola.vn.me.c.3
                    @Override // java.lang.Runnable
                    public void run() {
                        c.this.a(false);
                    }
                };
            }
            OlaApplication.c(this.J);
            if (!z) {
                this.I.dismiss();
                return;
            }
            try {
                if (this.I == null) {
                    this.I = i.a((Context) getActivity(), (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_checking_account));
                }
                this.I.show();
            } catch (Throwable unused) {
            }
            OlaApplication.a(this.J, 30000L);
        } catch (Throwable unused2) {
        }
    }

    private void b(OlaCachedImageView olaCachedImageView, String str) {
        t.a().h(str, olaCachedImageView);
    }

    public static c c() {
        try {
            if (a != null) {
                return a.get();
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    private void e(int i) {
        TextView textView;
        if (i <= 0) {
            this.B.setVisibility(8);
            if (this.C.getVisibility() == 0) {
                this.C.clearAnimation();
                this.C.startAnimation(this.h);
            }
        } else {
            if (a() == null) {
                return;
            }
            if (h.u.g() == null) {
                if (this.C.getVisibility() != 0) {
                    this.C.clearAnimation();
                    this.C.startAnimation(this.g);
                }
                this.C.setText(R.string.message_new_me_inform);
                this.C.setVisibility(0);
                textView = this.B;
                textView.setVisibility(8);
            }
            this.B.setText(m.a(i));
            this.B.setVisibility(0);
        }
        textView = this.C;
        textView.setVisibility(8);
    }

    private static boolean e(String str) {
        try {
            if (m.a(str) || m.b(str, "tl") || m.b(str, "md") || m.b(str, "rs") || m.b(str, "me") || m.b(str, "lk")) {
                return true;
            }
            return m.b(str, "av");
        } catch (Throwable unused) {
            return false;
        }
    }

    private void f(String str) {
        a(str, 0L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(String str) {
        String strB;
        boolean z;
        try {
            strB = m.b(str);
            try {
                if (this.I != null) {
                    if (this.I.isShowing()) {
                        return;
                    }
                }
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
            strB = str;
        }
        try {
            z = h.O.x;
        } catch (Throwable unused3) {
            z = false;
        }
        try {
            if (m.a(strB)) {
                return;
            }
            String strJ = m.j(strB);
            a(true);
            if (z && m.t(strJ)) {
                OlaApplication.b.a(strJ, new String[]{"name"}, new chat.ola.vn.p.d() { // from class: chat.ola.vn.me.c.19
                    @Override // chat.ola.vn.p.d
                    public void a(int i) {
                        FragmentActivity activity;
                        int i2;
                        try {
                            c.this.a(false);
                            if (i != 1) {
                                c.this.y.selectAll();
                                activity = c.this.getActivity();
                                i2 = R.string.string_buddy_is_not_exist;
                            } else {
                                c.this.y.selectAll();
                                activity = c.this.getActivity();
                                i2 = R.string.message_fail_phone_number_invalid;
                            }
                            i.a(activity, R.string.dialog_title_inform, i2);
                        } catch (Throwable unused4) {
                        }
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        try {
                            c.this.a(false);
                            c.this.y.setText("");
                            c.a(c.this.getActivity(), OlaApplication.b, agVar.c);
                            c.this.e();
                            c.this.x.notifyDataSetChanged();
                        } catch (Throwable unused4) {
                        }
                    }
                });
            } else {
                OlaApplication.b.a(strJ, new chat.ola.vn.p.i() { // from class: chat.ola.vn.me.c.2
                    @Override // chat.ola.vn.p.i
                    public void a(String str2, boolean z2) {
                        c cVar;
                        try {
                            c.this.a(false);
                            if (z2) {
                                c.this.y.setText("");
                                c.a(c.this.getActivity(), OlaApplication.b, str2);
                                c.this.e();
                                cVar = c.this;
                            } else {
                                c.this.y.selectAll();
                                i.a(c.this.getActivity(), R.string.dialog_title_inform, R.string.string_buddy_is_not_exist);
                                cVar = c.this;
                            }
                            cVar.x.notifyDataSetChanged();
                        } catch (Throwable unused4) {
                        }
                    }
                });
            }
        } catch (Throwable unused4) {
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void i(String str) {
        ImageView imageView;
        ImageView imageView2;
        ImageView imageView3;
        if (str == null) {
            this.i.setImageResource(R.drawable.ic_action_tab_ola_selected);
            this.k.setImageResource(R.drawable.ic_action_tab_media);
            this.l.setImageResource(R.drawable.ic_action_tab_follower);
            this.j.setImageResource(R.drawable.ic_action_tab_tag);
            this.i.setSelected(true);
            imageView = this.l;
        } else {
            if (m.b(str, "tl")) {
                this.j.setImageResource(R.drawable.ic_action_tab_tag_selected);
                this.k.setImageResource(R.drawable.ic_action_tab_media);
                this.l.setImageResource(R.drawable.ic_action_tab_follower);
                this.i.setImageResource(R.drawable.ic_action_tab_ola);
                this.j.setSelected(true);
                this.l.setSelected(false);
                imageView3 = this.i;
                imageView3.setSelected(false);
                imageView2 = this.k;
                imageView2.setSelected(false);
            }
            if (m.b(str, "md")) {
                this.k.setImageResource(R.drawable.ic_action_tab_media_selected);
                this.l.setImageResource(R.drawable.ic_action_tab_follower);
                this.i.setImageResource(R.drawable.ic_action_tab_ola);
                this.j.setImageResource(R.drawable.ic_action_tab_tag);
                this.k.setSelected(true);
                this.l.setSelected(false);
                this.i.setSelected(false);
                imageView2 = this.j;
                imageView2.setSelected(false);
            }
            if (m.b(str, "av")) {
                this.l.setImageResource(R.drawable.ic_action_tab_follower_selected);
                this.k.setImageResource(R.drawable.ic_action_tab_media);
                this.i.setImageResource(R.drawable.ic_action_tab_ola);
                this.j.setImageResource(R.drawable.ic_action_tab_tag);
                this.l.setSelected(true);
            } else {
                this.l.setImageResource(R.drawable.ic_action_tab_follower);
                this.k.setImageResource(R.drawable.ic_action_tab_media);
                this.i.setImageResource(R.drawable.ic_action_tab_ola);
                this.j.setImageResource(R.drawable.ic_action_tab_tag);
                this.l.setSelected(false);
            }
            imageView = this.i;
        }
        imageView.setSelected(false);
        imageView3 = this.j;
        imageView3.setSelected(false);
        imageView2 = this.k;
        imageView2.setSelected(false);
    }

    @SuppressLint({"NewApi"})
    private void j() {
        try {
            if (g.c()) {
                this.c.smoothScrollToPositionFromTop(0, 0, 500);
            } else {
                this.c.smoothScrollToPosition(0);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void v() {
        if (this.G) {
            return;
        }
        if (x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.s);
        }
        this.G = !this.G;
        this.F.setRefreshing(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void x() {
        if (this.H != null) {
            OlaApplication.c(this.H);
        }
        if (this.G) {
            if (x.e()) {
                chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
            }
            this.G = !this.G;
            this.F.setRefreshing(false);
        }
    }

    private void y() {
        View viewInflate = LayoutInflater.from(getActivity()).inflate(R.layout.system_me_menu_user_info_header, (ViewGroup) null);
        OlaCachedImageView olaCachedImageView = (OlaCachedImageView) viewInflate.findViewById(R.id.imgMeOwnerAvatar);
        OlaCachedImageView olaCachedImageView2 = (OlaCachedImageView) viewInflate.findViewById(R.id.imgMenuConver);
        TextView textView = (TextView) viewInflate.findViewById(R.id.txtMeOwnerAlias);
        String strA = h.a();
        a(olaCachedImageView, strA);
        b(olaCachedImageView2, strA);
        String string = x.d;
        if (m.a(string)) {
            string = strA;
        }
        if (m.a(string)) {
            string = getString(R.string.string_personal);
        }
        textView.setText(string);
        this.u.addHeaderView(viewInflate, new af(string, strA), true);
    }

    @SuppressLint({"RtlHardcoded"})
    private boolean z() {
        return this.o.isDrawerOpen(3) || this.o.isDrawerOpen(5);
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        try {
            if (!this.s) {
                this.d.setVisibility(8);
            }
        } catch (Throwable unused) {
        }
        return this.s;
    }

    @Override // chat.ola.vn.r.a.d
    public String C() {
        if (this.t == null) {
            this.t = "chat.ola.vn.fragment.MeViewFragment" + System.currentTimeMillis();
        }
        return this.t;
    }

    @Override // chat.ola.vn.r.a.d
    public void D() {
    }

    @Override // chat.ola.vn.r.a.d
    public void E() {
        this.r = false;
        this.s = true;
        String strG = h.u.g();
        A();
        this.q.setVisibility(h.u.m() ? 0 : 8);
        i(strG);
        this.b.notifyDataSetChanged();
        if (this.z != null) {
            this.c.onRestoreInstanceState(this.z);
            this.z = null;
        }
        this.c.postDelayed(new Runnable() { // from class: chat.ola.vn.me.c.9
            @Override // java.lang.Runnable
            @TargetApi(21)
            public void run() {
                if (h.u.r() >= 0) {
                    c.this.c.setSelectionFromTop(h.u.r(), h.u.s());
                } else {
                    c.this.c.setSelection(0);
                }
            }
        }, 250L);
    }

    @Override // chat.ola.vn.r.a.d
    public void a(int i, int i2) {
        A();
        this.q.setVisibility(h.u.m() ? 0 : 8);
        this.b.notifyDataSetChanged();
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // chat.ola.vn.m.a, chat.ola.vn.m.f
    protected void a(Bundle bundle) {
        super.a(bundle);
        this.z = bundle != null ? bundle.getParcelable("BUNDLE_LIST_VIEW_PARCELABLE") : null;
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(ag agVar, short s) {
        try {
            super.a(agVar, s);
            h();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entity.g gVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entry.a aVar, List<chat.ola.vn.entry.b> list) {
        final int i = aVar.c;
        final int i2 = aVar.d;
        this.r = false;
        this.s = true;
        String strG = h.u.g();
        A();
        i(strG);
        this.b.notifyDataSetChanged();
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.c.11
            @Override // java.lang.Runnable
            public void run() {
                if (c.this.z != null) {
                    c.this.c.onRestoreInstanceState(c.this.z);
                    c.this.z = null;
                }
                c.this.c.postDelayed(new Runnable() { // from class: chat.ola.vn.me.c.11.1
                    @Override // java.lang.Runnable
                    @TargetApi(21)
                    public void run() {
                        if (i >= 0) {
                            c.this.c.setSelectionFromTop(i, i2);
                        } else {
                            c.this.c.setSelection(0);
                        }
                    }
                }, 250L);
                c.this.q.setVisibility(h.u.m() ? 0 : 8);
            }
        }, 250L);
        chat.ola.vn.a.a().a(h.u.g());
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entry.b bVar, List<chat.ola.vn.entry.b> list) {
        this.b.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(Short sh, int i) {
        try {
            super.a(sh, i);
            h();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void a(List<chat.ola.vn.entry.b> list, List<chat.ola.vn.entry.b> list2) {
        this.r = false;
        this.s = true;
        this.d.setVisibility(0);
        this.q.setVisibility(h.u.m() ? 0 : 8);
        this.b.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.r || m.b("my diary", h.u.g())) {
            return;
        }
        if (m.b("mariage diary", h.u.g())) {
            long jL = h.u.l();
            if (jL == 0) {
                return;
            } else {
                a(jL);
            }
        } else {
            long jK = h.u.k();
            if (jK == 0) {
                return;
            } else {
                a(h.u.g(), jK);
            }
        }
        this.d.setVisibility(0);
    }

    @Override // chat.ola.vn.m.f
    public void b(Bundle bundle) {
        super.b(bundle);
        a = new WeakReference<>(this);
        try {
            this.e = AnimationUtils.loadAnimation(getActivity(), R.anim.zoom_icon_animation);
            this.e.setDuration(100L);
            this.f = AnimationUtils.loadAnimation(getActivity(), R.anim.zoom_out_icon_animation);
            this.f.setDuration(100L);
            this.g = AnimationUtils.loadAnimation(getActivity(), R.anim.fade_in);
            this.g.setDuration(500L);
            this.h = AnimationUtils.loadAnimation(getActivity(), R.anim.fade_out);
            this.h.setDuration(500L);
        } catch (Throwable unused) {
        }
        this.b = new u(getActivity());
        this.b.a((j.a) this);
        this.b.a(new View.OnClickListener() { // from class: chat.ola.vn.me.c.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                chat.ola.vn.q.b.a().b(c.this.getActivity(), view);
            }
        });
        this.b.a(new View.OnLongClickListener() { // from class: chat.ola.vn.me.c.5
            @Override // android.view.View.OnLongClickListener
            public boolean onLongClick(View view) {
                return chat.ola.vn.q.b.a().a(c.this.getActivity(), view);
            }
        });
        this.c.setAdapter((ListAdapter) this.b);
        this.v = new an(getActivity());
        this.u.setAdapter((ListAdapter) this.v);
        h();
    }

    @Override // chat.ola.vn.r.a.d
    public void b(chat.ola.vn.entry.b bVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void b(List<chat.ola.vn.entry.b> list, List<chat.ola.vn.entry.b> list2) {
    }

    @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
    public void b_(String str) {
        a(getActivity(), OlaApplication.b, str);
        e();
    }

    public void d() {
        if (h.u.c() == 0) {
            long j = 0;
            if (m.b("mariage diary", h.u.g())) {
                chat.ola.vn.entry.c.b bVar = new chat.ola.vn.entry.c.b(0L);
                f.a(bVar);
                OlaNetworkService olaNetworkService = OlaApplication.b;
                if (olaNetworkService != null) {
                    olaNetworkService.c(0L, bVar.a());
                }
                h.u.a(0);
                h.u.a(true);
                this.q.setVisibility(0);
            }
            if (m.b("my diary", h.u.g())) {
                OlaDiaryActivity.a(getActivity());
                return;
            }
            chat.ola.vn.entry.c.c cVar = new chat.ola.vn.entry.c.c(h.u.g(), j) { // from class: chat.ola.vn.me.c.13
                @Override // chat.ola.vn.entry.c.c, chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    super.a(i, s, str, dVarArr);
                    c.this.x();
                    c.this.b.notifyDataSetChanged();
                }

                @Override // chat.ola.vn.entry.c.c, chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    super.a(objArr);
                    c.this.x();
                }
            };
            f.a(cVar);
            h.u.a(0);
            h.u.a(true);
            OlaNetworkService olaNetworkService2 = OlaApplication.b;
            if (olaNetworkService2 != null) {
                olaNetworkService2.a(h.u.g(), cVar.a());
            }
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void d(int i) {
    }

    @Override // chat.ola.vn.r.a.d
    public void d(List<af> list) {
        this.v.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.m.f
    public void d_() {
        try {
            this.b.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"RtlHardcoded"})
    public void e() {
        try {
            this.o.closeDrawer(3);
            this.o.closeDrawer(5);
        } catch (Throwable unused) {
        }
        try {
            o.a((Context) getActivity(), getActivity().getCurrentFocus(), false);
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void e(List<chat.ola.vn.entry.b> list) {
        String strG = h.u.g();
        e(h.u.u());
        try {
            if (x.e == null && OlaApplication.b != null && (strG == null || m.b(strG, h.a()))) {
                OlaApplication.b.d(f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.me.c.7
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 54;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                    }
                }));
            }
        } catch (Throwable unused) {
        }
        this.r = false;
        this.s = true;
        A();
        i(strG);
        this.b.notifyDataSetChanged();
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.c.8
            @Override // java.lang.Runnable
            public void run() {
                if (c.this.z != null) {
                    c.this.c.onRestoreInstanceState(c.this.z);
                    c.this.z = null;
                }
                c.this.c.setSelection(0);
                c.this.q.setVisibility(h.u.m() ? 0 : 8);
            }
        }, 250L);
        chat.ola.vn.a.a().a(h.u.g());
    }

    @Override // chat.ola.vn.r.a.d
    public void f(List<String> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void g(String str) {
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        chat.ola.vn.entry.a aVarD;
        if (z()) {
            e();
            return true;
        }
        try {
            boolean zA = E.a(getActivity());
            if (zA) {
                E = null;
            }
            return zA;
        } catch (Throwable unused) {
            if (h.u.c() != 0 || (aVarD = h.u.d()) == null) {
                return false;
            }
            if (aVarD.a != null) {
                h.u.a(0);
                h.u.b(aVarD);
                h.u.a(false);
            }
            return true;
        }
    }

    public void h() {
        String strG = h.u.g();
        A();
        this.q.setVisibility(h.u.m() ? 0 : 4);
        i(strG);
        this.b.notifyDataSetChanged();
        this.A.notifyDataSetChanged();
        if (this.z != null) {
            this.c.onRestoreInstanceState(this.z);
            this.z = null;
        }
        this.c.postDelayed(new Runnable() { // from class: chat.ola.vn.me.c.6
            @Override // java.lang.Runnable
            @TargetApi(21)
            public void run() {
                if (h.u.r() >= 0) {
                    c.this.c.setSelectionFromTop(h.u.r(), h.u.s());
                } else {
                    c.this.c.setSelection(0);
                }
            }
        }, 250L);
        chat.ola.vn.a.a().a(h.u.g());
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_help_using_ola));
        arrayList.add(getString(R.string.string_help_bc_commands));
        arrayList.add(getString(R.string.string_help_faq));
        arrayList.add(getString(R.string.string_setup));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.c.12
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                FragmentActivity activity;
                String str;
                try {
                    String str2 = (String) arrayList.get(i);
                    if (m.b(c.this.getString(R.string.string_help_faq), str2)) {
                        activity = c.this.getActivity();
                        str = "rss://faq";
                    } else if (m.b(c.this.getString(R.string.string_help_using_ola), str2)) {
                        activity = c.this.getActivity();
                        str = "rss://ola/help/2010/05/113";
                    } else {
                        if (!m.b(c.this.getString(R.string.string_help_bc_commands), str2)) {
                            if (m.b(c.this.getString(R.string.string_setup), str2)) {
                                OlaAppSettingActivity.a(c.this.getActivity());
                                return;
                            }
                            return;
                        }
                        activity = c.this.getActivity();
                        str = "rss://ola/help/2010/03/bc";
                    }
                    chat.ola.vn.m.j.a(activity, str);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        String strG;
        try {
            switch (view.getId()) {
                case R.id.btnActive /* 2131296420 */:
                    f((String) null);
                    return;
                case R.id.btnHomePage /* 2131296466 */:
                    if (!view.isSelected()) {
                        f((String) null);
                    } else {
                        j();
                    }
                    break;
                case R.id.btnMediaMe /* 2131296508 */:
                    if (!view.isSelected()) {
                        f("md");
                    } else {
                        j();
                    }
                    break;
                case R.id.btnReplyMe /* 2131296534 */:
                    if (!view.isSelected()) {
                        f("tl");
                    } else {
                        j();
                    }
                    break;
                case R.id.buttonFollowerImageView /* 2131296573 */:
                    OlaVisitorListActivity.a(getActivity());
                    break;
                case R.id.clearHistoryTextView /* 2131296629 */:
                    i.a(getActivity(), R.string.dialog_title_confirm, R.string.message_delete_me_history, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.c.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                try {
                                    h.w.c();
                                    c.this.x.notifyDataSetChanged();
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    return;
                case R.id.stickyHeader /* 2131297441 */:
                case R.id.txtActionTitle /* 2131297513 */:
                    j();
                    return;
                case R.id.txtNewUnreadMeInfo /* 2131297638 */:
                    d();
                    return;
                case R.id.writeStatusImageButton /* 2131297810 */:
                    if (m.b(h.u.g(), "my diary")) {
                        x.j = (short) 10;
                    } else {
                        if (!m.b(h.u.g(), "mariage diary")) {
                            if (!h.u.a(h.u.g())) {
                                strG = h.u.g();
                                if (!strG.startsWith("#")) {
                                    strG = "@" + strG;
                                }
                            }
                            OlaMeComposerActivity.a(getActivity(), strG, (String) null);
                            return;
                        }
                        x.j = (short) 11;
                    }
                    strG = null;
                    OlaMeComposerActivity.a(getActivity(), strG, (String) null);
                    return;
                default:
                    return;
            }
            OlaReleaseAppActivity.a(getActivity());
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    @SuppressLint({"NewApi"})
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        boolean z;
        h.u.a(this);
        this.D = layoutInflater.inflate(R.layout.me_view_layout, viewGroup, false);
        this.o = (DrawerLayout) this.D.findViewById(R.id.meDrawerLayout);
        this.o.setDrawerListener(this);
        this.u = (OlaListView) this.o.findViewById(R.id.left_drawer);
        this.u.setOnItemClickListener(this);
        this.w = (OlaListView) this.o.findViewById(R.id.right_drawer);
        this.w.setOnItemClickListener(this);
        this.x = new b(getActivity());
        try {
            View viewInflate = layoutInflater.inflate(R.layout.me_history_search_layout, (ViewGroup) null);
            this.w.addHeaderView(viewInflate);
            this.y = (OlaQuickTypingSuggestedText) viewInflate.findViewById(R.id.searchSuggestedText);
            viewInflate.findViewById(R.id.clearHistoryTextView).setOnClickListener(this);
            try {
                z = h.O.x;
            } catch (Throwable unused) {
                z = false;
            }
            if (z) {
                this.y.setHint(R.string.string_enter_nick_phone_or_clan);
            } else {
                this.y.setHint(R.string.string_enter_nick_name_or_clan);
            }
            this.y.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.me.c.16
                /* JADX WARN: Removed duplicated region for block: B:5:0x000a  */
                @Override // android.widget.TextView.OnEditorActionListener
                /*
                    Code decompiled incorrectly, please refer to instructions dump.
                    To view partially-correct add '--show-bad-code' argument
                */
                public boolean onEditorAction(android.widget.TextView r1, int r2, android.view.KeyEvent r3) {
                    /*
                        r0 = this;
                        if (r3 == 0) goto La
                        int r1 = r3.getKeyCode()     // Catch: java.lang.Throwable -> L59
                        r3 = 66
                        if (r1 == r3) goto Ld
                    La:
                        r1 = 3
                        if (r2 != r1) goto L59
                    Ld:
                        chat.ola.vn.me.c r1 = chat.ola.vn.me.c.this     // Catch: java.lang.Throwable -> L59
                        chat.ola.vn.view.OlaQuickTypingSuggestedText r1 = chat.ola.vn.me.c.f(r1)     // Catch: java.lang.Throwable -> L59
                        android.text.Editable r1 = r1.getText()     // Catch: java.lang.Throwable -> L59
                        java.lang.String r1 = r1.toString()     // Catch: java.lang.Throwable -> L59
                        boolean r2 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> L59
                        if (r2 != 0) goto L57
                        java.lang.String r1 = r1.trim()     // Catch: java.lang.Throwable -> L59
                        java.lang.String r2 = "#"
                        boolean r2 = r1.startsWith(r2)     // Catch: java.lang.Throwable -> L59
                        if (r2 == 0) goto L52
                        chat.ola.vn.me.c r2 = chat.ola.vn.me.c.this     // Catch: java.lang.Throwable -> L59
                        android.support.v4.app.FragmentActivity r2 = r2.getActivity()     // Catch: java.lang.Throwable -> L59
                        chat.ola.vn.network.OlaNetworkService r3 = chat.ola.vn.OlaApplication.b     // Catch: java.lang.Throwable -> L59
                        chat.ola.vn.me.c.a(r2, r3, r1)     // Catch: java.lang.Throwable -> L59
                        chat.ola.vn.me.c r1 = chat.ola.vn.me.c.this     // Catch: java.lang.Throwable -> L57
                        chat.ola.vn.view.OlaQuickTypingSuggestedText r1 = chat.ola.vn.me.c.f(r1)     // Catch: java.lang.Throwable -> L57
                        java.lang.String r2 = ""
                        r1.setText(r2)     // Catch: java.lang.Throwable -> L57
                        chat.ola.vn.me.c r1 = chat.ola.vn.me.c.this     // Catch: java.lang.Throwable -> L57
                        r1.e()     // Catch: java.lang.Throwable -> L57
                        chat.ola.vn.me.c r1 = chat.ola.vn.me.c.this     // Catch: java.lang.Throwable -> L57
                        chat.ola.vn.me.b r1 = chat.ola.vn.me.c.a(r1)     // Catch: java.lang.Throwable -> L57
                        r1.notifyDataSetChanged()     // Catch: java.lang.Throwable -> L57
                        goto L57
                    L52:
                        chat.ola.vn.me.c r2 = chat.ola.vn.me.c.this     // Catch: java.lang.Throwable -> L59
                        chat.ola.vn.me.c.a(r2, r1)     // Catch: java.lang.Throwable -> L59
                    L57:
                        r1 = 1
                        return r1
                    L59:
                        r1 = 0
                        return r1
                    */
                    throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.me.c.AnonymousClass16.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
                }
            });
            this.w.setAdapter((ListAdapter) this.x);
            this.A = new q(getActivity());
            this.A.a(chat.ola.vn.g.a());
            q qVar = this.A;
            q qVar2 = this.A;
            qVar2.getClass();
            qVar.a(qVar2.new a());
            this.y.setAdapter(this.A);
            this.y.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.me.c.17
                @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
                public void b_(String str) {
                    try {
                        if (m.a(str)) {
                            return;
                        }
                        String strTrim = str.trim();
                        if (!strTrim.startsWith("#")) {
                            c.this.h(strTrim);
                            return;
                        }
                        c.a(c.this.getActivity(), OlaApplication.b, strTrim);
                        c.this.y.setText("");
                        c.this.e();
                        c.this.x.notifyDataSetChanged();
                    } catch (Throwable unused2) {
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
        this.D.findViewById(R.id.writeStatusImageButton).setOnClickListener(this);
        this.B = (TextView) this.D.findViewById(R.id.txtNewMeNotify);
        this.C = (TextView) this.D.findViewById(R.id.txtNewUnreadMeInfo);
        this.C.setOnClickListener(this);
        this.q = this.D.findViewById(R.id.meWattingProgress);
        this.p = this.D.findViewById(R.id.stubBlankContent);
        this.i = (ImageView) this.D.findViewById(R.id.btnHomePage);
        this.j = (ImageView) this.D.findViewById(R.id.btnReplyMe);
        this.k = (ImageView) this.D.findViewById(R.id.btnMediaMe);
        this.l = (ImageView) this.D.findViewById(R.id.buttonFollowerImageView);
        this.i.setOnClickListener(this);
        this.j.setOnClickListener(this);
        this.k.setOnClickListener(this);
        this.l.setOnClickListener(this);
        this.D.findViewById(R.id.stickyHeader).setOnClickListener(this);
        this.c = (OlaListView) this.D.findViewById(R.id.listView);
        this.F = (SwipeRefreshLayout) this.D.findViewById(R.id.swipeRefreshLayout);
        this.F.setColorSchemeResources(R.color.colorOlaPrimary);
        this.F.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.me.c.18
            @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
            public void onRefresh() {
                if (c.this.H == null) {
                    c.this.H = new Runnable() { // from class: chat.ola.vn.me.c.18.1
                        @Override // java.lang.Runnable
                        public void run() {
                            if (c.this.G) {
                                c.this.G = !c.this.G;
                                c.this.F.setRefreshing(false);
                            }
                        }
                    };
                }
                c.this.d();
                c.this.v();
                OlaApplication.c(c.this.H);
                OlaApplication.a(c.this.H, 30000L);
            }
        });
        try {
            this.d = layoutInflater.inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
            this.d.setVisibility(8);
            this.c.addFooterView(this.d);
        } catch (Throwable unused2) {
        }
        this.c.setSelector(new ColorDrawable(0));
        this.c.setOnScrollListener(this);
        y();
        return this.D;
    }

    @Override // android.support.v4.app.Fragment
    public void onDestroy() {
        e();
        a = null;
        h.u.b(this);
        super.onDestroy();
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        e();
        a = null;
        super.onDetach();
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerClosed(View view) {
        try {
            o.a((Context) getActivity(), (View) this.y, false);
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerOpened(View view) {
        OlaQuickTypingSuggestedText olaQuickTypingSuggestedText;
        int i;
        try {
            this.x.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
        boolean z = false;
        try {
            z = h.O.x;
        } catch (Throwable unused2) {
        }
        try {
            if (z) {
                olaQuickTypingSuggestedText = this.y;
                i = R.string.string_enter_nick_phone_or_clan;
            } else {
                olaQuickTypingSuggestedText = this.y;
                i = R.string.string_enter_nick_name_or_clan;
            }
            olaQuickTypingSuggestedText.setHint(i);
        } catch (Throwable unused3) {
        }
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerSlide(View view, float f) {
    }

    @Override // android.support.v4.widget.DrawerLayout.DrawerListener
    public void onDrawerStateChanged(int i) {
    }

    @Override // android.view.View.OnFocusChangeListener
    public void onFocusChange(View view, boolean z) {
        if (!z) {
            ((EditText) view).setText(h.u.h());
            return;
        }
        EditText editText = (EditText) view;
        editText.setText(h.u.g());
        editText.selectAll();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            if (adapterView.getAdapter() != null) {
                if (adapterView == this.u) {
                    af afVar = (af) adapterView.getAdapter().getItem(i);
                    if (m.b(afVar.b(), "mariage diary")) {
                        try {
                            if (m.a(h.O.e)) {
                                i.a(getActivity(), R.string.dialog_title_inform, R.string.message_cannot_open_box_because_not_married, R.string.string_get_married, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.c.10
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i2) {
                                        if (i2 == 0) {
                                            try {
                                                MarriageRequestComposerActivity.a(c.this.getActivity());
                                            } catch (Throwable unused) {
                                                return;
                                            }
                                        }
                                        dialogInterface.dismiss();
                                    }
                                });
                                e();
                                return;
                            }
                        } catch (Throwable unused) {
                        }
                    }
                    f(afVar.b());
                } else {
                    if (adapterView != this.w) {
                        return;
                    }
                    a(getActivity(), OlaApplication.b, ((chat.ola.vn.entry.g) adapterView.getAdapter().getItem(i)).a());
                }
                e();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        if (this.b != null) {
            this.b.notifyDataSetChanged();
        }
        e(h.u.u());
        List<String> listV = h.u.v();
        if (listV == null || listV.size() == 0) {
            try {
                OlaApplication.b.e(null, null, (short) 0);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        if (this.c != null) {
            try {
                Parcelable parcelableOnSaveInstanceState = this.c.onSaveInstanceState();
                if (parcelableOnSaveInstanceState != null) {
                    bundle.putParcelable("BUNDLE_LIST_VIEW_PARCELABLE", parcelableOnSaveInstanceState);
                }
            } catch (Throwable unused) {
            }
        }
        super.onSaveInstanceState(bundle);
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        try {
            h.u.b(i);
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
        if (i == 0) {
            try {
                int top = 0;
                View childAt = this.c.getChildAt(0);
                e eVar = h.u;
                if (childAt != null) {
                    top = childAt.getTop();
                }
                eVar.c(top);
            } catch (Throwable unused) {
            }
        }
    }
}
