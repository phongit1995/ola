package chat.ola.vn.me;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.ClanManagementActivity;
import chat.ola.vn.activity.CreateClanActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.b.u;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.ag;
import chat.ola.vn.f;
import chat.ola.vn.g;
import chat.ola.vn.h;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.r.a.e;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class OlaClanMePageActivity extends chat.ola.vn.c implements View.OnClickListener, OlaCropImageActivity.a, j.a {
    private TextView A;
    private TextView B;
    private TextView C;
    private TextView D;
    private String G;
    private View H;
    private View J;
    private View K;
    private View L;
    private TextView M;
    protected chat.ola.vn.entity.b e;
    protected OlaQuickTypingSuggestedText f;
    protected TextView g;
    protected TextView h;
    protected ListView i;
    protected u j;
    protected e k;
    protected OlaCachedImageView l;
    protected View m;
    protected OlaCachedImageView n;
    protected View o;
    protected View p;
    protected View q;
    protected View r;
    protected ImageView s;
    protected TextView t;
    protected ImageView u;
    protected TextView v;
    private q w;
    private SwipeRefreshLayout x;
    private boolean y = false;
    private Runnable z = null;
    private boolean E = true;
    private boolean F = false;
    private boolean I = false;

    private void C() {
        try {
            this.G = getIntent().getStringExtra("contactId");
            findViewById(R.id.olaActionBarBackImageView).setOnClickListener(this);
            this.H = findViewById(R.id.addConversationImageButton);
            this.H.setOnClickListener(this);
            this.x = (SwipeRefreshLayout) findViewById(R.id.pullToRefreshLayout);
            this.x.setColorSchemeResources(R.color.colorOlaPrimary);
            this.x.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.me.OlaClanMePageActivity.1
                @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
                public void onRefresh() {
                    try {
                        if (OlaClanMePageActivity.this.z == null) {
                            OlaClanMePageActivity.this.z = new Runnable() { // from class: chat.ola.vn.me.OlaClanMePageActivity.1.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    if (OlaClanMePageActivity.this.y) {
                                        OlaClanMePageActivity.this.y = !OlaClanMePageActivity.this.y;
                                        OlaClanMePageActivity.this.x.setRefreshing(false);
                                    }
                                }
                            };
                        }
                        OlaClanMePageActivity.this.S();
                        OlaClanMePageActivity.this.I();
                        OlaApplication.c(OlaClanMePageActivity.this.z);
                        OlaApplication.a(OlaClanMePageActivity.this.z, 30000L);
                    } catch (Throwable unused) {
                    }
                }
            });
            this.f = (OlaQuickTypingSuggestedText) findViewById(R.id.searchEditText);
            this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.me.OlaClanMePageActivity.2
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
                        int r1 = r3.getKeyCode()     // Catch: java.lang.Throwable -> L38
                        r3 = 66
                        if (r1 == r3) goto Ld
                    La:
                        r1 = 3
                        if (r2 != r1) goto L38
                    Ld:
                        chat.ola.vn.me.OlaClanMePageActivity r1 = chat.ola.vn.me.OlaClanMePageActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.view.OlaQuickTypingSuggestedText r1 = r1.f     // Catch: java.lang.Throwable -> L38
                        android.text.Editable r1 = r1.getText()     // Catch: java.lang.Throwable -> L38
                        java.lang.String r1 = r1.toString()     // Catch: java.lang.Throwable -> L38
                        boolean r2 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> L38
                        if (r2 != 0) goto L36
                        java.lang.String r1 = r1.trim()     // Catch: java.lang.Throwable -> L38
                        java.lang.String r2 = "#"
                        boolean r2 = r1.startsWith(r2)     // Catch: java.lang.Throwable -> L38
                        if (r2 == 0) goto L31
                        chat.ola.vn.me.OlaClanMePageActivity r2 = chat.ola.vn.me.OlaClanMePageActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.me.OlaClanMePageActivity.a(r2, r1)     // Catch: java.lang.Throwable -> L38
                        goto L36
                    L31:
                        chat.ola.vn.me.OlaClanMePageActivity r2 = chat.ola.vn.me.OlaClanMePageActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.me.OlaClanMePageActivity.a(r2, r1)     // Catch: java.lang.Throwable -> L38
                    L36:
                        r1 = 1
                        return r1
                    L38:
                        r1 = 0
                        return r1
                    */
                    throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.me.OlaClanMePageActivity.AnonymousClass2.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
                }
            });
            this.w = new q(this);
            this.w.a(g.a());
            q qVar = this.w;
            q qVar2 = this.w;
            qVar2.getClass();
            qVar.a(qVar2.new a());
            this.f.setAdapter(this.w);
            this.f.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.me.OlaClanMePageActivity.3
                @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
                public void b_(String str) {
                    try {
                        if (m.a(str)) {
                            return;
                        }
                        String strTrim = str.trim();
                        if (strTrim.startsWith("#")) {
                            OlaClanMePageActivity.a((Context) OlaClanMePageActivity.this, strTrim);
                        } else {
                            OlaClanMePageActivity.this.g(strTrim);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            this.i = (ListView) findViewById(R.id.pageListView);
            this.p = findViewById(R.id.wattingProgressBar);
            this.k = new e();
            this.j = new u(this, this.k);
            this.j.a((j.a) this);
            this.j.a(new View.OnClickListener() { // from class: chat.ola.vn.me.OlaClanMePageActivity.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    chat.ola.vn.q.b.a().b(OlaClanMePageActivity.this, view);
                }
            });
            this.j.a(new View.OnLongClickListener() { // from class: chat.ola.vn.me.OlaClanMePageActivity.5
                @Override // android.view.View.OnLongClickListener
                public boolean onLongClick(View view) {
                    return chat.ola.vn.q.b.a().a(OlaClanMePageActivity.this, view);
                }
            });
            try {
                View viewInflate = LayoutInflater.from(this).inflate(R.layout.ola_clan_page_header_layout, (ViewGroup) null);
                this.A = (TextView) viewInflate.findViewById(R.id.txtJoinOlaDate);
                this.B = (TextView) viewInflate.findViewById(R.id.clanManagerTextView1);
                this.C = (TextView) viewInflate.findViewById(R.id.clanManagerTextView2);
                this.C.setOnClickListener(this);
                this.D = (TextView) viewInflate.findViewById(R.id.clanManagerTextView3);
                viewInflate.findViewById(R.id.vLinewarFanNumber).setOnClickListener(this);
                this.h = (TextView) viewInflate.findViewById(R.id.fanNumberTextView);
                this.q = viewInflate.findViewById(R.id.relationMakerPan);
                this.r = viewInflate.findViewById(R.id.createClanButton);
                this.r.setOnClickListener(this);
                this.l = (OlaCachedImageView) viewInflate.findViewById(R.id.coverPictureImageView);
                this.l.setOnClickListener(this);
                this.m = viewInflate.findViewById(R.id.editCoverPictureImageView);
                this.m.setOnClickListener(this);
                this.n = (OlaCachedImageView) viewInflate.findViewById(R.id.profilePictureImageView);
                this.n.setOnClickListener(this);
                this.o = viewInflate.findViewById(R.id.editProfilePictureImageView);
                this.o.setOnClickListener(this);
                this.g = (TextView) viewInflate.findViewById(R.id.contactIdTextView);
                this.J = viewInflate.findViewById(R.id.addFriendViewLayout);
                this.J.setOnClickListener(this);
                this.J.setVisibility(8);
                this.s = (ImageView) viewInflate.findViewById(R.id.addFriendIconImageView);
                this.t = (TextView) viewInflate.findViewById(R.id.addFriendTextView);
                this.K = viewInflate.findViewById(R.id.followViewLayout);
                this.K.setOnClickListener(this);
                this.u = (ImageView) viewInflate.findViewById(R.id.followIconImageView);
                this.v = (TextView) viewInflate.findViewById(R.id.followTextView);
                viewInflate.findViewById(R.id.postMeViewLayout).setOnClickListener(this);
                this.L = viewInflate.findViewById(R.id.editProfileViewLayout);
                this.L.setOnClickListener(this);
                viewInflate.findViewById(R.id.moreViewLayout).setVisibility(8);
                this.M = (TextView) viewInflate.findViewById(R.id.clanPolicyTextView);
                this.i.addHeaderView(viewInflate);
            } catch (Throwable unused) {
            }
            this.i.setAdapter((ListAdapter) this.j);
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void I() {
        this.k.e();
        this.e = null;
        K();
        this.j.notifyDataSetChanged();
    }

    private static void J() {
        h.u.t();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void K() {
        try {
            if (this.e == null) {
                if (!this.y) {
                    c(true);
                }
                OlaApplication.b.f(this.G, (short) 68);
            } else {
                this.f.setAdapter(null);
                this.f.setText("#" + this.e.a);
                this.f.setAdapter(this.w);
                this.g.setText("#" + this.e.a);
                N();
                Q();
                this.h.setText(m.a((long) this.e.f));
                P();
                O();
                this.M.setText(m.a(this, this.e.j));
            }
            if (this.k.j() == 0) {
                a_(0);
            }
            this.w.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    private boolean L() {
        try {
            return m.b(h.a(), this.e.b);
        } catch (Throwable unused) {
            return false;
        }
    }

    private boolean M() {
        try {
            return m.a(this.e.e);
        } catch (Throwable unused) {
            return false;
        }
    }

    private void N() {
        if (M()) {
            if (L()) {
                this.m.setVisibility(0);
                this.o.setVisibility(0);
            } else {
                this.m.setVisibility(8);
                this.o.setVisibility(8);
            }
            this.H.setVisibility(8);
        } else {
            this.m.setVisibility(8);
            this.o.setVisibility(8);
            this.H.setVisibility(0);
        }
        t.a().e(this.e.a, this.n, this.I);
        t.a().d(this.e.a, this.l, this.I);
        this.I = false;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void O() {
        TextView textView;
        CharSequence charSequenceC;
        TextView textView2;
        CharSequence charSequenceC2;
        TextView textView3;
        CharSequence charSequenceC3;
        if (m.a(this.e.b)) {
            textView = this.B;
            charSequenceC = "";
        } else {
            textView = this.B;
            charSequenceC = i.c("@" + this.e.b);
        }
        textView.setText(charSequenceC);
        if (m.a(this.e.c)) {
            textView2 = this.C;
            charSequenceC2 = "";
        } else {
            textView2 = this.C;
            charSequenceC2 = i.c("@" + this.e.c);
        }
        textView2.setText(charSequenceC2);
        if (m.a(this.e.d)) {
            textView3 = this.D;
            charSequenceC3 = "";
        } else {
            textView3 = this.D;
            charSequenceC3 = i.c("@" + this.e.d);
        }
        textView3.setText(charSequenceC3);
    }

    private void P() {
        if (this.e.i == 0) {
            this.A.setText(R.string.string_unknown);
        } else {
            this.A.setText(getString(R.string.string_clan_foundation_date, new Object[]{new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault()).format(new Date(this.e.i))}));
        }
    }

    private void Q() {
        View view;
        TextView textView;
        int i;
        if (M()) {
            this.q.setVisibility(0);
            this.r.setVisibility(8);
            if (!L()) {
                this.K.setVisibility(0);
                this.L.setVisibility(8);
                this.q.setVisibility(0);
                if (this.e.k) {
                    this.u.setImageResource(R.drawable.ic_state_following);
                    this.v.setText(R.string.string_following);
                    textView = this.v;
                    i = f.H;
                } else {
                    this.u.setImageResource(R.drawable.ic_follow_black_disable);
                    this.v.setText(R.string.string_follow);
                    textView = this.v;
                    i = f.A;
                }
                textView.setTextColor(i);
                return;
            }
            this.K.setVisibility(8);
            view = this.L;
        } else {
            this.q.setVisibility(8);
            view = this.r;
        }
        view.setVisibility(0);
    }

    private void R() {
        if (this.e == null) {
            return;
        }
        final chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.me.OlaClanMePageActivity.8
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 19;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                OlaClanMePageActivity.this.K();
            }
        };
        if (this.e.k) {
            chat.ola.vn.i.i.d(this, getString(R.string.dialog_title_confirm), getString(R.string.me_message_notfollow_confirm, new Object[]{"Clan #" + this.e.a}), getString(R.string.string_notfollow), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaClanMePageActivity.9
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    if (i == 0) {
                        try {
                            OlaApplication.b.a("#" + OlaClanMePageActivity.this.e.a, false, chat.ola.vn.entry.c.f.a(eVar));
                            OlaClanMePageActivity.this.e.k = false;
                            OlaClanMePageActivity.this.K();
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                    dialogInterface.dismiss();
                }
            });
            return;
        }
        OlaApplication.b.a("#" + this.e.a, true, chat.ola.vn.entry.c.f.a(eVar));
        this.e.k = true;
        K();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void S() {
        if (this.y) {
            return;
        }
        if (x.e()) {
            n.a(this, chat.ola.vn.util.c.a.s);
        }
        this.y = !this.y;
        this.x.setRefreshing(true);
    }

    private void T() {
        if (this.z != null) {
            OlaApplication.c(this.z);
        }
        if (this.y) {
            if (x.e()) {
                n.a(this, chat.ola.vn.util.c.a.t);
            }
            this.y = !this.y;
            this.x.setRefreshing(false);
        }
    }

    public static void a(Context context, String str) {
        try {
            b(context, str);
        } catch (Throwable unused) {
        }
    }

    private static void b(Context context, String str) {
        try {
            String strK = m.k(str);
            Intent intent = new Intent(context, (Class<?>) OlaClanMePageActivity.class);
            intent.putExtra("contactId", strK);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
            h("#" + strK);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        this.p.setVisibility(z ? 0 : 8);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g(String str) {
        String strB;
        boolean z;
        try {
            strB = m.b(str);
            try {
                if (this.p != null) {
                    if (this.p.getVisibility() == 0) {
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
            c(true);
            if (z && m.t(strJ)) {
                OlaApplication.b.a(strJ, new String[]{"name"}, new chat.ola.vn.p.d() { // from class: chat.ola.vn.me.OlaClanMePageActivity.6
                    @Override // chat.ola.vn.p.d
                    public void a(int i) {
                        OlaClanMePageActivity olaClanMePageActivity;
                        int i2;
                        try {
                            OlaClanMePageActivity.this.c(false);
                            if (i != 1) {
                                OlaClanMePageActivity.this.f.selectAll();
                                olaClanMePageActivity = OlaClanMePageActivity.this;
                                i2 = R.string.string_buddy_is_not_exist;
                            } else {
                                OlaClanMePageActivity.this.f.selectAll();
                                olaClanMePageActivity = OlaClanMePageActivity.this;
                                i2 = R.string.message_fail_phone_number_invalid;
                            }
                            chat.ola.vn.i.i.a(olaClanMePageActivity, R.string.dialog_title_inform, i2);
                        } catch (Throwable unused4) {
                        }
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        try {
                            OlaClanMePageActivity.this.c(false);
                            OlaClanMePageActivity.this.f.setText("");
                            OlaUserMePageActivity.a(OlaClanMePageActivity.this, agVar.c);
                        } catch (Throwable unused4) {
                        }
                    }
                });
            } else {
                OlaApplication.b.a(strJ, new chat.ola.vn.p.i() { // from class: chat.ola.vn.me.OlaClanMePageActivity.7
                    @Override // chat.ola.vn.p.i
                    public void a(String str2, boolean z2) {
                        try {
                            OlaClanMePageActivity.this.c(false);
                            if (z2) {
                                OlaClanMePageActivity.this.f.setText("");
                                OlaUserMePageActivity.a(OlaClanMePageActivity.this, str2);
                            } else {
                                OlaClanMePageActivity.this.f.selectAll();
                                chat.ola.vn.i.i.a(OlaClanMePageActivity.this, R.string.dialog_title_inform, R.string.string_buddy_is_not_exist);
                            }
                        } catch (Throwable unused4) {
                        }
                    }
                });
            }
        } catch (Throwable unused4) {
        }
    }

    private static void h(String str) {
        if (h.u.a(str) || m.b(str, "my diary") || m.b(str, "mariage diary")) {
            return;
        }
        chat.ola.vn.message.f fVarB = str.startsWith("#") ? null : h.t.b(str);
        chat.ola.vn.entry.g gVarA = h.w.a(str);
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (gVarA == null) {
            gVarA = new chat.ola.vn.entry.g(str, str);
            gVarA.c(jCurrentTimeMillis);
        }
        gVarA.a(jCurrentTimeMillis);
        gVarA.b(gVarA.d() + 1);
        h.w.a(gVarA);
        J();
        if (fVarB != null) {
            gVarA.a(fVarB.b());
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.E;
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void D() {
        this.I = true;
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void E() {
        this.I = true;
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void F() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void G() {
    }

    @Override // chat.ola.vn.c
    protected void a() {
        K();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        super.a(i, str, bArr, dVarArr, s);
        if (s == 80) {
            T();
            c(false);
            this.F = false;
            this.E = false;
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(chat.ola.vn.entity.b bVar, short s) {
        if (s == 68) {
            this.e = bVar;
            if (bVar != null) {
                bVar.k = this.k.a() == 1;
            }
            K();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, short s) {
        if (s == 68) {
            this.e = new chat.ola.vn.entity.b();
            this.e.a = this.G;
            this.e.e = str;
            c(false);
            K();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, short s, List<chat.ola.vn.entity.g> list, short s2) {
        if (s2 == 80) {
            if (this.e != null) {
                this.e.k = s == 1;
                K();
            }
            T();
            c(false);
            this.F = false;
            if (this.k.k() == 0) {
                this.k.b(str, s, list);
            } else {
                this.k.c(list);
            }
            this.j.notifyDataSetChanged();
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.F || this.e == null) {
            return;
        }
        this.F = true;
        OlaApplication.b.a("#" + this.e.a, this.k.k(), (short) 80);
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void b_() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void f(String str) {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    public void j() {
        try {
            this.j.notifyDataSetChanged();
            K();
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        chat.ola.vn.entity.b bVar;
        OlaMediaEntity[] olaMediaEntityArr;
        OlaCachedImageView olaCachedImageView;
        try {
            switch (view.getId()) {
                case R.id.addConversationImageButton /* 2131296304 */:
                    String strJ = m.j(this.e.a);
                    if (!m.a(strJ)) {
                        OlaChatViewActivity.a(this, strJ);
                    }
                    break;
                case R.id.addFriendViewLayout /* 2131296309 */:
                    bVar = this.e;
                    m.a(bVar.a);
                    break;
                case R.id.clanManagerTextView2 /* 2131296622 */:
                    break;
                case R.id.coverPictureImageView /* 2131296725 */:
                    if (!m.a(this.e.a)) {
                        olaMediaEntityArr = new OlaMediaEntity[1];
                        for (int i = 0; i < olaMediaEntityArr.length; i++) {
                            olaMediaEntityArr[i] = new OlaMediaEntity(chat.ola.vn.c.f.f(this.e.a).b(), 3, (short) 1);
                        }
                        olaCachedImageView = this.l;
                        OlaImageViewerActivity.a(this, olaCachedImageView, (Bitmap) null, 0, olaMediaEntityArr);
                    }
                    break;
                case R.id.createClanButton /* 2131296726 */:
                    if (!m.a(this.e.a)) {
                        CreateClanActivity.a(this, this.e.a);
                    }
                    break;
                case R.id.editCoverPictureImageView /* 2131296751 */:
                    if (!m.a(this.e.a)) {
                        OlaCropImageActivity.a(this, this.e.a, this);
                    }
                    break;
                case R.id.editProfilePictureImageView /* 2131296755 */:
                    if (!m.a(this.e.a)) {
                        OlaCropImageActivity.b(this, this.e.a, this);
                    }
                    break;
                case R.id.editProfileViewLayout /* 2131296756 */:
                    ClanManagementActivity.a(this, this.e);
                    break;
                case R.id.followViewLayout /* 2131296803 */:
                    R();
                    break;
                case R.id.olaActionBarBackImageView /* 2131297178 */:
                    finish();
                    break;
                case R.id.postMeViewLayout /* 2131297246 */:
                    String strK = m.k(this.e.a);
                    if (!m.a(strK)) {
                        OlaMeComposerActivity.a(this, "#" + strK, (String) null);
                    }
                    break;
                case R.id.profilePictureImageView /* 2131297255 */:
                    if (!m.a(this.e.a)) {
                        olaMediaEntityArr = new OlaMediaEntity[1];
                        for (int i2 = 0; i2 < olaMediaEntityArr.length; i2++) {
                            olaMediaEntityArr[i2] = new OlaMediaEntity(chat.ola.vn.c.f.e(this.e.a).b(), 3, (short) 1);
                        }
                        olaCachedImageView = this.n;
                        OlaImageViewerActivity.a(this, olaCachedImageView, (Bitmap) null, 0, olaMediaEntityArr);
                    }
                    break;
                case R.id.vLinewarFanNumber /* 2131297749 */:
                    bVar = this.e;
                    m.a(bVar.a);
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_user_me_page_layout);
        C();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        this.e = null;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
    }
}
