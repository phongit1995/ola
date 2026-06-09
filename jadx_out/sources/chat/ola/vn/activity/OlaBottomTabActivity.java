package chat.ola.vn.activity;

import android.annotation.TargetApi;
import android.app.Dialog;
import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.ComponentCallbacks;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.s;
import chat.ola.vn.m.b;
import chat.ola.vn.m.d;
import chat.ola.vn.m.e;
import chat.ola.vn.m.g;
import chat.ola.vn.m.h;
import chat.ola.vn.m.i;
import chat.ola.vn.m.j;
import chat.ola.vn.m.k;
import chat.ola.vn.m.l;
import chat.ola.vn.m.z;
import chat.ola.vn.me.OlaDiaryActivity;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.p.f;
import chat.ola.vn.p.p;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaTabViewLayout;
import com.google.android.gms.common.util.CrashUtils;
import java.util.List;
import java.util.Stack;

/* JADX INFO: loaded from: classes.dex */
public class OlaBottomTabActivity extends c implements chat.ola.vn.f.a, f, OlaTabViewLayout.a {
    public static Drawable e = null;
    public static boolean f = false;
    public static boolean g = false;
    private static boolean s = false;
    Dialog h;
    protected FrameLayout i;
    private OlaTabViewLayout j;
    private LayoutInflater k;
    private Stack<Integer> l;
    private int o;
    private BroadcastReceiver p;
    private String q = null;
    private long r = 0;

    private static class a {
        ImageView a;
        TextView b;
        TextView c;

        a(View view) {
            this.a = (ImageView) view.findViewById(R.id.imgTabIcon);
            this.b = (TextView) view.findViewById(R.id.txtTabNotify);
            this.c = (TextView) view.findViewById(R.id.tabTitleTextView);
            view.setTag(this);
        }

        public void a(int i, int i2) {
            if (i2 != 0) {
                this.a.setImageResource(i2);
            }
            this.c.setText(i);
        }

        public void a(String str) {
            a(str, true);
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        public void a(String str, boolean z) {
            TextView textView;
            int i;
            if (m.a(str)) {
                this.b.setText("");
                textView = this.b;
                i = 8;
            } else {
                this.b.setText(str + "");
                textView = this.b;
                i = 0;
            }
            textView.setVisibility(i);
        }
    }

    public static void E() {
        e = null;
        f = false;
    }

    private void M() {
        a(0, R.string.general_tab_chat, R.drawable.ic_bottom_tab_message, R.drawable.ic_bottom_tab_message_selected, e.class, false);
        a(14, R.string.general_tab_publicroom, R.drawable.ic_bottom_tab_public_room, R.drawable.ic_bottom_tab_public_room_selected, l.class, false);
        a(1, R.string.general_tab_me, R.drawable.ic_bottom_tab_me, R.drawable.ic_bottom_tab_me_selected, chat.ola.vn.me.c.class, false);
        a(2, R.string.general_tab_rss, R.drawable.ic_bottom_tab_rss, R.drawable.ic_bottom_tab_rss_selected, j.class, false);
        OlaTabViewLayout.c cVarA = a(4, R.string.general_tab_app, R.drawable.ic_bottom_tab_more, R.drawable.ic_bottom_tab_more_selected, d.class, false);
        a(5, cVarA, z.class, true);
        a(8, cVarA, chat.ola.vn.m.m.class, true);
        a(9, cVarA, k.class, false);
        a(10, cVarA, b.class, false);
        a(11, cVarA, h.class, false);
        a(3, cVarA, g.class, false);
        a(13, cVarA, i.class, false);
    }

    private void N() {
        try {
            if (Long.MAX_VALUE != x.a) {
                if (x.a == 0) {
                    x.a = System.currentTimeMillis();
                    chat.ola.vn.e.a().b(x.a);
                } else if (System.currentTimeMillis() - x.a >= 259200000) {
                    x.a = System.currentTimeMillis();
                    chat.ola.vn.e.a().b(x.a);
                }
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, int i) {
        a(context, i, (Bundle) null);
    }

    public static void a(Context context, int i, Bundle bundle) {
        try {
            chat.ola.vn.h.q = i;
            OlaBottomTabActivity olaBottomTabActivity = (OlaBottomTabActivity) b_;
            olaBottomTabActivity.a(bundle);
            olaBottomTabActivity.J();
        } catch (Throwable unused) {
            if (context == null) {
                return;
            }
            try {
                try {
                    ((c) context).a(OlaBottomTabActivity.class, bundle);
                } catch (Throwable unused2) {
                    Intent intent = new Intent(context, (Class<?>) OlaBottomTabActivity.class);
                    if (bundle != null) {
                        intent.putExtras(bundle);
                    }
                    intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
                    context.startActivity(intent);
                }
            } catch (Throwable unused3) {
                Intent intent2 = new Intent(context, (Class<?>) OlaBottomTabActivity.class);
                if (bundle != null) {
                    intent2.putExtras(bundle);
                }
                context.startActivity(intent2);
            }
        }
    }

    private void a(Intent intent) {
        try {
            String action = intent.getAction();
            if (m.b(action, "chat.ola.vn.ACTION_REFRESH_ME")) {
                if (chat.ola.vn.me.c.c() != null) {
                    chat.ola.vn.me.c.c().d();
                    return;
                } else {
                    chat.ola.vn.me.c.a(this, OlaApplication.b, (String) null);
                    return;
                }
            }
            if (m.b(action, "chat.ola.vn.ACTION_REFRESH_BIN")) {
                OlaDiaryActivity.a(this);
                return;
            }
            if (m.b(action, "chat.ola.vn.ACTION_VIEW_ME")) {
                String stringExtra = intent.getStringExtra("_me_page_id");
                int intExtra = intent.getIntExtra("_index", -1);
                if (m.a(stringExtra)) {
                    long longExtra = intent.getLongExtra("_me_entry_id", 0L);
                    if (longExtra != 0) {
                        OlaMeCommentActivity.a(this, longExtra);
                    } else {
                        chat.ola.vn.me.c.a(this, OlaApplication.b, (String) null);
                    }
                } else {
                    chat.ola.vn.me.c.a(this, OlaApplication.b, stringExtra);
                }
                if (intExtra != -1) {
                    ((NotificationManager) getSystemService("notification")).cancel(intExtra);
                    return;
                }
                return;
            }
            if (m.b(action, "chat.ola.vn.ACTION_VIEW_LIKED_ME")) {
                int intExtra2 = intent.getIntExtra("_index", -1);
                long longExtra2 = intent.getLongExtra("_me_entry_id", 0L);
                if (longExtra2 != 0) {
                    OlaMeCommentActivity.a(this, longExtra2);
                } else {
                    chat.ola.vn.me.c.a(this, OlaApplication.b, (String) null);
                }
                if (intExtra2 != -1) {
                    ((NotificationManager) getSystemService("notification")).cancel(intExtra2);
                    return;
                }
                return;
            }
            if (m.b(action, "chat.ola.vn.ACTION_VIEW_FOLLOW_ME")) {
                String stringExtra2 = intent.getStringExtra("_me_page_id");
                int intExtra3 = intent.getIntExtra("_index", -1);
                try {
                    chat.ola.vn.me.c.a(this, OlaApplication.b, stringExtra2);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                if (intExtra3 != -1) {
                    ((NotificationManager) getSystemService("notification")).cancel(intExtra3);
                    return;
                }
                return;
            }
            if (m.b(action, "chat.ola.vn.ACTION_SHOW_CONVERSATION")) {
                e.b(this);
                chat.ola.vn.util.c.b.a(this);
            } else if (m.b(action, "chat.ola.vn.ACTION_VIEW_NOTE")) {
                j.a(this, "note/" + chat.ola.vn.h.a());
            }
        } catch (Throwable unused) {
        }
    }

    private void a(Bundle bundle) {
        try {
            if (chat.ola.vn.h.q < 0) {
                chat.ola.vn.h.q = 0;
            }
            String str = "fragment_" + chat.ola.vn.h.q;
            try {
                if (m.a(this.j.getTabTag(), str)) {
                    chat.ola.vn.m.f fVar = (chat.ola.vn.m.f) this.j.getCurrentFragmentTab();
                    if (bundle != null) {
                        try {
                            if (fVar.getArguments() == null) {
                                fVar.setArguments(bundle);
                            } else {
                                fVar.getArguments().putAll(bundle);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                    fVar.d(bundle);
                } else {
                    this.j.a(str, bundle);
                }
            } catch (Exception unused2) {
            }
            chat.ola.vn.a.a().a(chat.ola.vn.h.q);
            this.o = chat.ola.vn.h.q;
        } catch (Throwable unused3) {
        }
    }

    private boolean a(chat.ola.vn.entry.e eVar) {
        if (eVar.d() != R.string.general_tab_notify) {
            return eVar.a(this);
        }
        k.a(this);
        a(0);
        return true;
    }

    public static void h(int i) {
        try {
            c cVarC = c();
            if (cVarC == null || !(cVarC instanceof OlaBottomTabActivity)) {
                return;
            }
            ((OlaBottomTabActivity) cVarC).l.remove(Integer.valueOf(i));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.f
    public void C() {
    }

    @TargetApi(11)
    protected void F() {
        if (e == null && !f) {
            getWindow().setBackgroundDrawable(new ColorDrawable(f()));
            try {
                AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.activity.OlaBottomTabActivity.1
                    /* JADX INFO: Access modifiers changed from: protected */
                    @Override // android.os.AsyncTask
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public Void doInBackground(Void... voidArr) {
                        try {
                            OlaBottomTabActivity.f = true;
                            byte[] bArrC = chat.ola.vn.h.b.c(chat.ola.vn.h.a());
                            Bitmap bitmapDecodeByteArray = BitmapFactory.decodeByteArray(bArrC, 0, bArrC.length);
                            if (bitmapDecodeByteArray == null) {
                                return null;
                            }
                            OlaBottomTabActivity.e = new BitmapDrawable(OlaBottomTabActivity.this.getResources(), bitmapDecodeByteArray);
                            return null;
                        } catch (Throwable unused) {
                            return null;
                        }
                    }

                    /* JADX INFO: Access modifiers changed from: protected */
                    @Override // android.os.AsyncTask
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public void onPostExecute(Void r2) {
                        try {
                            if (OlaBottomTabActivity.e != null) {
                                OlaBottomTabActivity.this.getWindow().setBackgroundDrawable(OlaBottomTabActivity.e);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                };
                if (com.mg.ola.common.d.g.c()) {
                    asyncTask.executeOnExecutor(chat.ola.vn.h.R, new Void[0]);
                } else {
                    asyncTask.execute(new Void[0]);
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
        if (e != null) {
            getWindow().setBackgroundDrawable(e);
        } else {
            try {
                getWindow().setBackgroundDrawable(new ColorDrawable(f()));
            } catch (Throwable unused) {
            }
        }
    }

    public void G() {
        chat.ola.vn.message.f fVarA;
        int iZ;
        try {
            View viewB = this.j.b("fragment_14");
            if (viewB != null) {
                a aVar = (a) viewB.getTag();
                if (chat.ola.vn.h.x.p() == null || (fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.p().c())) == null || (iZ = fVarA.z()) <= 0) {
                    aVar.a((String) null, false);
                } else {
                    aVar.a(m.a(iZ));
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.f
    public boolean H() {
        return false;
    }

    public void I() {
        e(chat.ola.vn.h.t.q());
        f(chat.ola.vn.h.u.u());
        f(chat.ola.vn.h.v.f());
    }

    public void J() {
        g(this.o);
    }

    public boolean K() {
        if (this.l == null) {
            return false;
        }
        this.l.remove(Integer.valueOf(this.o));
        if (this.l.isEmpty()) {
            return false;
        }
        chat.ola.vn.h.q = this.l.pop().intValue();
        a((Bundle) null);
        return true;
    }

    public int L() {
        return this.o;
    }

    public OlaTabViewLayout.c a(int i, int i2, final int i3, final int i4, Class<?> cls, boolean z) {
        View viewInflate = this.k.inflate(R.layout.tab_bottom_item, (ViewGroup) null);
        final a aVar = new a(viewInflate);
        aVar.a(i2, i3);
        return this.j.a("fragment_" + i, cls, viewInflate, z, new OlaTabViewLayout.b() { // from class: chat.ola.vn.activity.OlaBottomTabActivity.2
            /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
            @Override // chat.ola.vn.view.OlaTabViewLayout.b
            public void a(boolean z2) {
                TextView textView;
                int i5;
                if (z2) {
                    aVar.a.setImageResource(i4);
                    textView = aVar.c;
                    i5 = chat.ola.vn.f.H;
                } else {
                    aVar.a.setImageResource(i3);
                    textView = aVar.c;
                    i5 = chat.ola.vn.f.z;
                }
                textView.setTextColor(i5);
            }
        });
    }

    @Override // chat.ola.vn.c
    protected void a() {
        F();
        if (chat.ola.vn.h.t != null) {
            chat.ola.vn.h.t.a(this);
        }
        try {
            if (chat.ola.vn.h.q >= 0) {
                J();
                a(getIntent().getExtras());
            }
            I();
        } catch (Throwable unused) {
        }
        try {
            this.p = new BroadcastReceiver() { // from class: chat.ola.vn.activity.OlaBottomTabActivity.3
                @Override // android.content.BroadcastReceiver
                public void onReceive(Context context, Intent intent) {
                    if (intent != null) {
                        try {
                            String action = intent.getAction();
                            if (m.a(action) || !"chat.ola.vn.ACTION_CHANGE_BALANCE".equals(action)) {
                                return;
                            }
                            chat.ola.vn.util.j.a(OlaBottomTabActivity.this, OlaBottomTabActivity.this.getString(R.string.message_balance_current_format, new Object[]{o.a(chat.ola.vn.h.o)}));
                            ComponentCallbacks currentFragmentTab = OlaBottomTabActivity.this.j.getCurrentFragmentTab();
                            if (currentFragmentTab == null || !(currentFragmentTab instanceof chat.ola.vn.d.a)) {
                                return;
                            }
                            ((chat.ola.vn.d.a) currentFragmentTab).a(chat.ola.vn.h.o);
                        } catch (Throwable unused2) {
                        }
                    }
                }
            };
            registerReceiver(this.p, new IntentFilter("chat.ola.vn.ACTION_CHANGE_BALANCE"));
        } catch (Throwable unused2) {
        }
        N();
        try {
            G();
            if (System.currentTimeMillis() - this.r <= 600000) {
                this.r = 0L;
            } else if (chat.ola.vn.h.t.q() > 0) {
                e.b(this);
            }
        } catch (Throwable unused3) {
        }
        if (g) {
            g = false;
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaBottomTabActivity.4
                @Override // java.lang.Runnable
                public void run() {
                    OlaTutorialActivity.a(OlaBottomTabActivity.this);
                }
            });
            return;
        }
        if (OlaTutorialActivity.e) {
            OlaChangePasswordActivity.a(this, chat.ola.vn.h.b());
            OlaTutorialActivity.e = false;
            return;
        }
        try {
            if (Build.VERSION.SDK_INT < 23 || checkSelfPermission("android.permission.READ_CONTACTS") == 0) {
                new chat.ola.vn.v.d().execute(this);
            } else {
                if (s) {
                    return;
                }
                s = true;
                requestPermissions(new String[]{"android.permission.READ_CONTACTS"}, 100);
            }
        } catch (Throwable unused4) {
        }
    }

    public void a(int i, OlaTabViewLayout.c cVar, Class<?> cls, boolean z) {
        OlaTabViewLayout.c cVarA = this.j.a("fragment_" + i, cls, null, z);
        if (cVarA != null) {
            cVarA.a(cVar);
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s2) {
        super.a(i, str, bArr, dVarArr, s2);
        try {
            ((chat.ola.vn.m.f) this.j.getCurrentFragmentTab()).a(i, str, bArr, dVarArr, s2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(long j, String str, String str2, List<chat.ola.vn.message.f> list, List<chat.ola.vn.message.f> list2, short s2) {
        try {
            ((chat.ola.vn.m.f) this.j.getCurrentFragmentTab()).a(j, str, str2, list, list2, s2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(ag agVar, short s2) {
        try {
            super.a(agVar, s2);
            ((chat.ola.vn.m.f) this.j.getCurrentFragmentTab()).a(agVar, s2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.d dVar, byte b, byte b2) {
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, int i, String str, List<chat.ola.vn.message.d> list) {
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        try {
            ((l) this.j.getCurrentFragmentTab()).a(fVar, dVar);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, List<chat.ola.vn.message.d> list) {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(Short sh, int i) {
        try {
            super.a(sh, i);
            ((chat.ola.vn.m.f) this.j.getCurrentFragmentTab()).a(sh, i);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(List<s> list, short s2) {
        try {
            ((chat.ola.vn.m.f) this.j.getCurrentFragmentTab()).a(list, s2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.OlaTabViewLayout.a
    public boolean a(OlaTabViewLayout.c cVar, int i) {
        int iIntValue;
        if (cVar == null) {
            return false;
        }
        try {
            String strA = cVar.a();
            if (strA != null && chat.ola.vn.h.q == (iIntValue = Integer.valueOf(strA.substring("fragment_".length(), strA.length())).intValue()) && iIntValue == 1) {
                final chat.ola.vn.i.c cVarA = chat.ola.vn.i.i.a(this, R.string.string_please_wait, 5000L, (Runnable) null);
                OlaApplication.b.a(new p() { // from class: chat.ola.vn.activity.OlaBottomTabActivity.5
                    @Override // chat.ola.vn.p.p
                    public void a() {
                        try {
                            cVarA.a();
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.p.p
                    public void a(String str) {
                        chat.ola.vn.util.b.n(OlaBottomTabActivity.this, str);
                    }
                });
                return true;
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.p.f
    public void a_() {
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
    }

    @Override // chat.ola.vn.p.f
    public void b(Short sh, int i) {
    }

    @Override // chat.ola.vn.view.OlaTabViewLayout.a
    public boolean b(OlaTabViewLayout.c cVar, int i) {
        try {
            I();
        } catch (Throwable unused) {
        }
        if (cVar != null) {
            try {
                String strA = cVar.a();
                if (strA != null) {
                    int iIntValue = Integer.valueOf(strA.substring("fragment_".length(), strA.length())).intValue();
                    if (chat.ola.vn.h.q == iIntValue && iIntValue == 0) {
                        e.a(this);
                    } else if (iIntValue == 14) {
                        OlaReleaseAppActivity.a(this);
                    } else if (iIntValue == 2) {
                        OlaReleaseAppActivity.a(this);
                        j.d = false;
                        if (chat.ola.vn.h.q == iIntValue) {
                            j.a(this, (String) null);
                            return true;
                        }
                    } else if (iIntValue == 1) {
                        OlaReleaseAppActivity.a(this);
                        if (chat.ola.vn.h.q == iIntValue) {
                            chat.ola.vn.me.c.a(this, OlaApplication.b, (String) null);
                            return true;
                        }
                    } else if (iIntValue == 4) {
                        OlaReleaseAppActivity.a(this);
                        try {
                            chat.ola.vn.entry.e eVarD = chat.ola.vn.h.v.d();
                            if (eVarD != null) {
                                if (a(eVarD)) {
                                    return true;
                                }
                            }
                        } catch (Throwable unused2) {
                        }
                    } else if (chat.ola.vn.h.q == iIntValue) {
                        switch (iIntValue) {
                            case 5:
                            case 6:
                            case 7:
                            case 8:
                            case 9:
                            case 10:
                            case 11:
                            case 13:
                                d(iIntValue);
                                return true;
                        }
                    }
                    J();
                    this.o = iIntValue;
                    chat.ola.vn.h.q = this.o;
                    chat.ola.vn.a.a().a(this.o);
                }
            } catch (Throwable unused3) {
            }
        }
        return false;
    }

    @Override // chat.ola.vn.p.f
    public void c(int i) {
        e(chat.ola.vn.h.t.q());
    }

    @Override // chat.ola.vn.p.f
    public void c(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void c(List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.p.f
    public void c(boolean z) {
    }

    public void d(int i) {
        this.j.a("fragment_" + i);
        a(this, 4);
        h(i);
    }

    @Override // chat.ola.vn.p.f
    public void d(chat.ola.vn.message.f fVar) {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /*  JADX ERROR: JadxRuntimeException in pass: RegionMakerVisitor
        jadx.core.utils.exceptions.JadxRuntimeException: Can't find top splitter block for handler:B:16:0x0020
        	at jadx.core.utils.BlockUtils.getTopSplitterForHandler(BlockUtils.java:1182)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.collectHandlerRegions(ExcHandlersRegionMaker.java:53)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.process(ExcHandlersRegionMaker.java:38)
        	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:27)
        */
    public void e(int r4) {
        /*
            r3 = this;
            r0 = 0
            java.lang.String r1 = "fragment_0"
            chat.ola.vn.view.OlaTabViewLayout r2 = r3.j     // Catch: java.lang.Throwable -> L20
            android.view.View r2 = r2.b(r1)     // Catch: java.lang.Throwable -> L20
            if (r2 == 0) goto L20
            java.lang.Object r2 = r2.getTag()     // Catch: java.lang.Throwable -> L20
            chat.ola.vn.activity.OlaBottomTabActivity$a r2 = (chat.ola.vn.activity.OlaBottomTabActivity.a) r2     // Catch: java.lang.Throwable -> L20
            if (r4 <= 0) goto L1b
            java.lang.String r4 = chat.ola.vn.util.m.a(r4)     // Catch: java.lang.Throwable -> L20
            r2.a(r4)     // Catch: java.lang.Throwable -> L20
            goto L20
        L1b:
            r2.a(r0)     // Catch: java.lang.Throwable -> L20
            goto L20
        L1f:
            r1 = r0
        L20:
            int r4 = r3.o     // Catch: java.lang.Throwable -> L2f
            if (r4 != 0) goto L2f
            chat.ola.vn.view.OlaTabViewLayout r4 = r3.j     // Catch: java.lang.Throwable -> L2f
            android.support.v4.app.Fragment r4 = r4.c(r1)     // Catch: java.lang.Throwable -> L2f
            chat.ola.vn.m.e r4 = (chat.ola.vn.m.e) r4     // Catch: java.lang.Throwable -> L2f
            r4.e()     // Catch: java.lang.Throwable -> L2f
        L2f:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaBottomTabActivity.e(int):void");
    }

    @Override // chat.ola.vn.p.f
    public void e(chat.ola.vn.message.f fVar) {
    }

    public void f(int i) {
        View viewB = this.j.b("fragment_1");
        if (viewB != null) {
            a aVar = (a) viewB.getTag();
            if (i > 0) {
                aVar.a(m.a(i));
            } else {
                aVar.a((String) null, false);
            }
        }
    }

    @Override // chat.ola.vn.p.f
    public void f(chat.ola.vn.message.f fVar) {
    }

    public void f(String str) {
        try {
            View viewB = this.j.b("fragment_4");
            if (viewB != null) {
                ((a) viewB.getTag()).a(str, false);
            }
        } catch (Throwable unused) {
        }
    }

    public void g(int i) {
        if (this.l == null) {
            this.l = new Stack<>();
        }
        Integer numValueOf = Integer.valueOf(i);
        this.l.remove(numValueOf);
        this.l.push(numValueOf);
    }

    @Override // chat.ola.vn.p.f
    public boolean g(chat.ola.vn.message.f fVar) {
        return false;
    }

    @Override // chat.ola.vn.p.f
    public String i_() {
        if (this.q == null) {
            this.q = "chat.ola.vn.activity.BottomTabActivity" + System.currentTimeMillis();
        }
        return this.q;
    }

    @Override // chat.ola.vn.c
    public void j() {
        try {
            ((chat.ola.vn.m.f) this.j.getCurrentFragmentTab()).d_();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        try {
            Fragment currentFragmentTab = this.j.getCurrentFragmentTab();
            if ((currentFragmentTab != null && (currentFragmentTab instanceof chat.ola.vn.m.f) && ((chat.ola.vn.m.f) currentFragmentTab).g_()) || K()) {
                return;
            }
            super.onBackPressed();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.tab_content_view_layout);
        this.i = (FrameLayout) findViewById(R.id.bottomTabContentFrame);
        this.j = (OlaTabViewLayout) findViewById(R.id.mainView);
        this.j.setUpTabHost(getSupportFragmentManager());
        this.j.setOnTabChangeListener(this);
        this.j.setTabHostHeight(getResources().getDimensionPixelSize(R.dimen.metric_56dp));
        this.k = LayoutInflater.from(this);
        M();
        if (chat.ola.vn.h.q < 0) {
            chat.ola.vn.h.q = chat.ola.vn.e.a().h();
        }
        a(getIntent());
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        try {
            super.onDestroy();
        } catch (Throwable unused) {
        }
        try {
            chat.ola.vn.a.a().a(0);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i == 82) {
            try {
                Fragment currentFragmentTab = this.j.getCurrentFragmentTab();
                if (currentFragmentTab != null && (currentFragmentTab instanceof chat.ola.vn.m.f)) {
                    if (this.h != null && this.h.isShowing()) {
                        this.h.dismiss();
                        this.h = null;
                        return true;
                    }
                    this.h = ((chat.ola.vn.m.f) currentFragmentTab).h_();
                }
                return true;
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
        return super.onKeyDown(i, keyEvent);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        a(intent);
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        chat.ola.vn.h.t.b(this);
        try {
            unregisterReceiver(this.p);
        } catch (Throwable unused) {
        }
        super.onPause();
        chat.ola.vn.e.a().e(chat.ola.vn.h.q);
        this.r = System.currentTimeMillis();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        try {
            super.onRequestPermissionsResult(i, strArr, iArr);
            if (i == 100 && iArr[0] == 0) {
                new chat.ola.vn.v.d().execute(this);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    public FrameLayout z() {
        return this.i;
    }
}
