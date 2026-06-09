package chat.ola.vn.me;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.activity.OlaUserProfileActivity;
import chat.ola.vn.activity.OlaVipStoreActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.b.u;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.cloud.OlaCloudAlbumListActivity;
import chat.ola.vn.cloud.OlaCloudPhotoListActivity;
import chat.ola.vn.entity.ag;
import chat.ola.vn.f;
import chat.ola.vn.g;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.r.a.e;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class OlaUserMePageActivity extends chat.ola.vn.c implements View.OnClickListener, OlaCropImageActivity.a, j.a {
    protected View A;
    protected TextView B;
    protected TextView[] C;
    protected View D;
    protected TextView E;
    protected OlaCachedImageView F;
    protected ImageView G;
    protected TextView H;
    protected ImageView I;
    protected TextView J;
    private q K;
    private OlaCachedImageView[] L;
    private SwipeRefreshLayout M;
    private View P;
    private OlaCachedImageView Q;
    private TextView R;
    private TextView S;
    private TextView T;
    private TextView U;
    private String X;
    private View Y;
    private View aa;
    private View ab;
    private View ac;
    private View ad;
    private FrameLayout ae;
    protected ag e;
    protected OlaQuickTypingSuggestedText f;
    protected TextView g;
    protected View h;
    protected TextView i;
    protected View j;
    protected TextView k;
    protected ListView l;
    protected u m;
    protected e n;
    protected OlaCachedImageView o;
    protected View p;
    protected OlaCachedImageView q;
    protected View r;
    protected OlaCachedImageView s;
    protected OlaCachedImageView[] t;
    protected View u;
    protected View v;
    protected View w;
    protected View x;
    protected TextView y;
    protected View[] z;
    private boolean N = false;
    private Runnable O = null;
    private boolean V = true;
    private boolean W = false;
    private boolean Z = false;
    private boolean af = false;

    private void C() {
        try {
            this.ae = (FrameLayout) findViewById(R.id.globalViewLayout);
            this.X = getIntent().getStringExtra("contactId");
            findViewById(R.id.olaActionBarBackImageView).setOnClickListener(this);
            this.Y = findViewById(R.id.addConversationImageButton);
            this.Y.setOnClickListener(this);
            this.M = (SwipeRefreshLayout) findViewById(R.id.pullToRefreshLayout);
            this.M.setColorSchemeResources(R.color.colorOlaPrimary);
            this.M.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.1
                @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
                public void onRefresh() {
                    try {
                        if (OlaUserMePageActivity.this.O == null) {
                            OlaUserMePageActivity.this.O = new Runnable() { // from class: chat.ola.vn.me.OlaUserMePageActivity.1.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    if (OlaUserMePageActivity.this.N) {
                                        OlaUserMePageActivity.this.N = !OlaUserMePageActivity.this.N;
                                        OlaUserMePageActivity.this.M.setRefreshing(false);
                                    }
                                }
                            };
                        }
                        OlaUserMePageActivity.this.ab();
                        OlaUserMePageActivity.this.I();
                        OlaApplication.c(OlaUserMePageActivity.this.O);
                        OlaApplication.a(OlaUserMePageActivity.this.O, 30000L);
                    } catch (Throwable unused) {
                    }
                }
            });
            this.f = (OlaQuickTypingSuggestedText) findViewById(R.id.searchEditText);
            this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.7
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
                        chat.ola.vn.me.OlaUserMePageActivity r1 = chat.ola.vn.me.OlaUserMePageActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.view.OlaQuickTypingSuggestedText r1 = r1.f     // Catch: java.lang.Throwable -> L38
                        android.text.Editable r1 = r1.getText()     // Catch: java.lang.Throwable -> L38
                        java.lang.String r1 = r1.toString()     // Catch: java.lang.Throwable -> L38
                        boolean r2 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> L38
                        if (r2 != 0) goto L36
                        java.lang.String r1 = r1.trim()     // Catch: java.lang.Throwable -> L38
                        java.lang.String r2 = "#"
                        boolean r2 = r1.startsWith(r2)     // Catch: java.lang.Throwable -> L38
                        if (r2 == 0) goto L31
                        chat.ola.vn.me.OlaUserMePageActivity r2 = chat.ola.vn.me.OlaUserMePageActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.me.OlaUserMePageActivity.a(r2, r1)     // Catch: java.lang.Throwable -> L38
                        goto L36
                    L31:
                        chat.ola.vn.me.OlaUserMePageActivity r2 = chat.ola.vn.me.OlaUserMePageActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.me.OlaUserMePageActivity.a(r2, r1)     // Catch: java.lang.Throwable -> L38
                    L36:
                        r1 = 1
                        return r1
                    L38:
                        r1 = 0
                        return r1
                    */
                    throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.me.OlaUserMePageActivity.AnonymousClass7.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
                }
            });
            this.K = new q(this);
            this.K.a(g.a());
            q qVar = this.K;
            q qVar2 = this.K;
            qVar2.getClass();
            qVar.a(qVar2.new a());
            this.f.setAdapter(this.K);
            this.f.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.me.OlaUserMePageActivity.8
                @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
                public void b_(String str) {
                    try {
                        if (m.a(str)) {
                            return;
                        }
                        String strTrim = str.trim();
                        if (strTrim.startsWith("#")) {
                            OlaUserMePageActivity.a((Context) OlaUserMePageActivity.this, strTrim);
                        } else {
                            OlaUserMePageActivity.this.g(strTrim);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            this.l = (ListView) findViewById(R.id.pageListView);
            this.u = findViewById(R.id.wattingProgressBar);
            this.n = new e();
            this.m = new u(this, this.n);
            this.m.a((j.a) this);
            this.m.a(new View.OnClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.9
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    chat.ola.vn.q.b.a().b(OlaUserMePageActivity.this, view);
                }
            });
            this.m.a(new View.OnLongClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.10
                @Override // android.view.View.OnLongClickListener
                public boolean onLongClick(View view) {
                    return chat.ola.vn.q.b.a().a(OlaUserMePageActivity.this, view);
                }
            });
            try {
                View viewInflate = LayoutInflater.from(this).inflate(R.layout.ola_user_me_page_header_layout, (ViewGroup) null);
                this.D = viewInflate.findViewById(R.id.linearStatusSpan);
                this.E = (TextView) viewInflate.findViewById(R.id.txtInfoStatusSpan);
                this.F = (OlaCachedImageView) viewInflate.findViewById(R.id.imgStatusIcon);
                this.F.setOnClickListener(this);
                this.P = viewInflate.findViewById(R.id.vipAccountGroup);
                this.P.setOnClickListener(this);
                this.Q = (OlaCachedImageView) viewInflate.findViewById(R.id.imgVipIcon);
                this.R = (TextView) viewInflate.findViewById(R.id.txtJoinOlaDate);
                this.S = (TextView) viewInflate.findViewById(R.id.txtMeUserGender);
                this.T = (TextView) viewInflate.findViewById(R.id.txtMeUserMarriesStatus);
                this.T.setOnClickListener(this);
                this.U = (TextView) viewInflate.findViewById(R.id.txtMeUserBirthday);
                viewInflate.findViewById(R.id.vLinewarFanNumber).setOnClickListener(this);
                this.i = (TextView) viewInflate.findViewById(R.id.fanNumberTextView);
                this.k = (TextView) viewInflate.findViewById(R.id.kissTextView);
                this.j = viewInflate.findViewById(R.id.kissImageView);
                ViewGroup viewGroup = (ViewGroup) viewInflate.findViewById(R.id.kissViewLayout);
                viewGroup.setClipChildren(false);
                viewGroup.setOnClickListener(this);
                this.x = viewInflate.findViewById(R.id.mediaStorageViewLayout);
                this.x.setOnClickListener(this);
                this.y = (TextView) viewInflate.findViewById(R.id.mediaStorageTextView);
                this.v = viewInflate.findViewById(R.id.relationMakerPan);
                this.w = viewInflate.findViewById(R.id.btnUnBlockMe);
                this.w.setOnClickListener(this);
                this.o = (OlaCachedImageView) viewInflate.findViewById(R.id.coverPictureImageView);
                this.o.setOnClickListener(this);
                this.p = viewInflate.findViewById(R.id.editCoverPictureImageView);
                this.p.setOnClickListener(this);
                this.q = (OlaCachedImageView) viewInflate.findViewById(R.id.profilePictureImageView);
                this.q.setOnClickListener(this);
                this.r = viewInflate.findViewById(R.id.editProfilePictureImageView);
                this.r.setOnClickListener(this);
                this.s = (OlaCachedImageView) viewInflate.findViewById(R.id.honeyProfilePictureImageView);
                this.s.setOnClickListener(this);
                this.g = (TextView) viewInflate.findViewById(R.id.contactIdTextView);
                this.h = viewInflate.findViewById(R.id.imgCheckedPhoneNumberVerified);
                this.aa = viewInflate.findViewById(R.id.addFriendViewLayout);
                this.aa.setOnClickListener(this);
                this.G = (ImageView) viewInflate.findViewById(R.id.addFriendIconImageView);
                this.H = (TextView) viewInflate.findViewById(R.id.addFriendTextView);
                this.ab = viewInflate.findViewById(R.id.followViewLayout);
                this.ab.setOnClickListener(this);
                this.I = (ImageView) viewInflate.findViewById(R.id.followIconImageView);
                this.J = (TextView) viewInflate.findViewById(R.id.followTextView);
                viewInflate.findViewById(R.id.postMeViewLayout).setOnClickListener(this);
                this.ac = viewInflate.findViewById(R.id.editProfileViewLayout);
                this.ac.setOnClickListener(this);
                this.ad = viewInflate.findViewById(R.id.editProfileNotificationTextView);
                viewInflate.findViewById(R.id.moreViewLayout).setOnClickListener(this);
                viewInflate.findViewById(R.id.txtMeUserNote).setOnClickListener(this);
                this.t = new OlaCachedImageView[6];
                this.t[0] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView1);
                this.t[1] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView2);
                this.t[2] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView5);
                this.t[3] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView3);
                this.t[4] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView4);
                this.t[5] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView6);
                this.B = (TextView) viewInflate.findViewById(R.id.friendTextView);
                this.A = viewInflate.findViewById(R.id.friendViewLayout);
                this.A.setOnClickListener(this);
                this.z = new View[5];
                this.z[0] = viewInflate.findViewById(R.id.friendViewLayout1);
                this.z[1] = viewInflate.findViewById(R.id.friendViewLayout2);
                this.z[2] = viewInflate.findViewById(R.id.friendViewLayout3);
                this.z[3] = viewInflate.findViewById(R.id.friendViewLayout4);
                this.z[4] = viewInflate.findViewById(R.id.friendViewLayout5);
                this.L = new OlaCachedImageView[5];
                this.L[0] = (OlaCachedImageView) viewInflate.findViewById(R.id.friendImageView1);
                this.L[1] = (OlaCachedImageView) viewInflate.findViewById(R.id.friendImageView2);
                this.L[2] = (OlaCachedImageView) viewInflate.findViewById(R.id.friendImageView3);
                this.L[3] = (OlaCachedImageView) viewInflate.findViewById(R.id.friendImageView4);
                this.L[4] = (OlaCachedImageView) viewInflate.findViewById(R.id.friendImageView5);
                this.C = new TextView[5];
                this.C[0] = (TextView) viewInflate.findViewById(R.id.friendTextView1);
                this.C[1] = (TextView) viewInflate.findViewById(R.id.friendTextView2);
                this.C[2] = (TextView) viewInflate.findViewById(R.id.friendTextView3);
                this.C[3] = (TextView) viewInflate.findViewById(R.id.friendTextView4);
                this.C[4] = (TextView) viewInflate.findViewById(R.id.friendTextView5);
                this.l.addHeaderView(viewInflate);
            } catch (Throwable unused) {
            }
            this.l.setAdapter((ListAdapter) this.m);
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void I() {
        this.n.e();
        this.e = null;
        K();
        this.m.notifyDataSetChanged();
    }

    private static void J() {
        h.u.t();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void K() {
        TextView textView;
        StringBuilder sb;
        try {
            if (this.e != null) {
                this.f.setAdapter(null);
                this.f.setText(this.e.c);
                this.f.setAdapter(this.K);
                if (this.e.a != null) {
                    this.g.setText(this.e.a.toString());
                }
                if (this.e.x) {
                    this.h.setVisibility(0);
                } else {
                    this.h.setVisibility(8);
                }
                L();
                R();
                this.i.setText(m.a(this.e.r));
                if (this.e.t == 0) {
                    this.k.setText(R.string.string_not_yet_been_kissed);
                } else {
                    if (this.e.t > 1) {
                        textView = this.k;
                        sb = new StringBuilder();
                        sb.append(m.a(this.e.t));
                        sb.append(" ");
                        sb.append(getString(R.string.string_kisses));
                    } else {
                        textView = this.k;
                        sb = new StringBuilder();
                        sb.append(m.a(this.e.t));
                        sb.append(" ");
                        sb.append(getString(R.string.string_kiss));
                    }
                    textView.setText(sb.toString());
                }
                U();
                Q();
                P();
                O();
                N();
                M();
                S();
                T();
            } else {
                if (this.af) {
                    return;
                }
                if (!this.N) {
                    c(true);
                }
                OlaApplication.b.a(this.X, new chat.ola.vn.p.d() { // from class: chat.ola.vn.me.OlaUserMePageActivity.13
                    @Override // chat.ola.vn.p.d
                    public void a(int i) {
                        OlaUserMePageActivity.this.c(false);
                        OlaUserMePageActivity.this.af = true;
                        i.a(OlaUserMePageActivity.this, R.string.dialog_title_fail, R.string.message_can_not_load_this_page);
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        try {
                            OlaUserMePageActivity.this.e = agVar;
                            OlaUserMePageActivity.this.K();
                        } catch (Throwable unused) {
                        }
                    }
                });
            }
            if (this.n.j() == 0) {
                a_(0);
            }
            this.K.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    private void L() {
        if (V()) {
            this.p.setVisibility(0);
            this.r.setVisibility(0);
            this.Y.setVisibility(8);
        } else {
            this.p.setVisibility(8);
            this.r.setVisibility(8);
            this.Y.setVisibility(0);
        }
        t.a().a(this.e.c, false, this.q, this.Z);
        if (m.a(this.e.e)) {
            this.s.setVisibility(8);
        } else {
            this.s.setVisibility(0);
            t.a().a(this.e.e, false, this.s, this.Z);
        }
        t.a().c(this.e.c, this.o, this.Z);
        this.Z = false;
    }

    private void M() {
        if (this.e.l == 0) {
            this.U.setText(R.string.string_unknown);
        } else {
            this.U.setText(new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault()).format(new Date(this.e.l)));
        }
    }

    private void N() {
        if (this.e.e == null) {
            this.T.setText(R.string.string_marry_alone);
            return;
        }
        this.T.setText(chat.ola.vn.util.i.c(getString(R.string.string_marry_with) + " @" + this.e.e));
    }

    private void O() {
        TextView textView;
        int i;
        switch (this.e.w) {
            case -1:
                this.S.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_indicate_dynamic_gender, 0, 0, 0);
                textView = this.S;
                i = R.string.string_unknown;
                break;
            case 0:
                this.S.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_indicate_female, 0, 0, 0);
                textView = this.S;
                i = R.string.string_female;
                break;
            case 1:
                this.S.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_indicate_male, 0, 0, 0);
                textView = this.S;
                i = R.string.string_male;
                break;
            case 2:
                this.S.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_indicate_dynamic_gender, 0, 0, 0);
                textView = this.S;
                i = R.string.string_flexible;
                break;
            default:
                return;
        }
        textView.setText(i);
    }

    private void P() {
        if (this.e.m != 0) {
            this.R.setText(getString(R.string.string_join_ola_date, new Object[]{com.mg.ola.common.d.i.a(System.currentTimeMillis() - this.e.m, chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b())}));
        } else {
            this.R.setText(R.string.string_unknown);
        }
    }

    private void Q() {
        if (this.e.u <= 0) {
            this.P.setVisibility(8);
            this.Q.a(null, null);
            return;
        }
        this.P.setVisibility(0);
        if (this.Q.a("" + ((int) this.e.u))) {
            return;
        }
        this.Q.a(chat.ola.vn.j.a().a(this.e.u), "" + ((int) this.e.u));
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void R() {
        TextView textView;
        int i;
        TextView textView2;
        int i2;
        View view;
        if (V()) {
            this.aa.setVisibility(8);
            this.ab.setVisibility(8);
            this.ac.setVisibility(0);
            if ((chat.ola.vn.c.x() && (m.a(h.O.f) || !h.O.x)) || h.O.w == -1) {
                this.ad.setVisibility(0);
                return;
            }
            view = this.ad;
        } else {
            this.ad.setVisibility(8);
            this.aa.setVisibility(0);
            this.ab.setVisibility(0);
            this.ac.setVisibility(8);
            if (!this.e.A) {
                this.w.setVisibility(8);
                this.v.setVisibility(0);
                if (h.t.d(this.e.c) == null) {
                    this.G.setImageResource(R.drawable.ic_add_friend_black_disable);
                    this.H.setText(R.string.string_make_friend);
                    textView = this.H;
                    i = f.A;
                } else {
                    this.G.setImageResource(R.drawable.ic_state_friends);
                    this.H.setText(R.string.string_already_friend);
                    textView = this.H;
                    i = f.H;
                }
                textView.setTextColor(i);
                if (this.e.y) {
                    this.I.setImageResource(R.drawable.ic_state_following);
                    this.J.setText(R.string.string_following);
                    textView2 = this.J;
                    i2 = f.H;
                } else {
                    this.I.setImageResource(R.drawable.ic_follow_black_disable);
                    this.J.setText(R.string.string_follow);
                    textView2 = this.J;
                    i2 = f.A;
                }
                textView2.setTextColor(i2);
                return;
            }
            this.w.setVisibility(0);
            view = this.v;
        }
        view.setVisibility(8);
    }

    private void S() {
        int i;
        if (this.e.o <= 0) {
            this.x.setVisibility(8);
            return;
        }
        this.x.setVisibility(0);
        String string = getString(R.string.string_media_store);
        String str = string + " · " + m.a(this.e.o);
        SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(str);
        spannableStringBuilder.setSpan(new ForegroundColorSpan(f.y), 0, string.length(), 33);
        spannableStringBuilder.setSpan(new ForegroundColorSpan(f.z), string.length(), str.length(), 33);
        this.y.setText(spannableStringBuilder);
        for (int i2 = 0; i2 < this.t.length; i2++) {
            this.t[i2].setVisibility(8);
        }
        if (this.e.j != null) {
            if (this.e.j.length > 3) {
                for (int i3 = 0; i3 < this.t.length; i3++) {
                    this.t[i3].setVisibility(4);
                }
            } else {
                this.t[0].setVisibility(4);
                this.t[1].setVisibility(4);
                this.t[2].setVisibility(4);
            }
            for (int i4 = 0; i4 < this.t.length && i4 < this.e.j.length; i4++) {
                OlaCachedImageView olaCachedImageView = this.t[i4];
                olaCachedImageView.setVisibility(0);
                switch (chat.ola.vn.entity.i.i(this.e.j[i4])) {
                    case 1:
                        olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                        t.a().b(this.e.j[i4], olaCachedImageView, olaCachedImageView.getWidth());
                        continue;
                        break;
                    case 2:
                        olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                        i = R.drawable.ic_media_video;
                        break;
                    case 3:
                        olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                        i = R.drawable.ic_media_sound;
                        break;
                    default:
                        olaCachedImageView.setVisibility(8);
                        continue;
                        break;
                }
                olaCachedImageView.setImageResource(i);
            }
        }
    }

    private void T() {
        if (this.e.i == null || this.e.i.length <= 0) {
            this.A.setVisibility(8);
            return;
        }
        this.A.setVisibility(0);
        String string = getString(R.string.string_following);
        String str = string + " · " + m.a(this.e.p);
        SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(str);
        spannableStringBuilder.setSpan(new ForegroundColorSpan(f.y), 0, string.length(), 33);
        spannableStringBuilder.setSpan(new ForegroundColorSpan(f.z), string.length(), str.length(), 33);
        this.B.setText(spannableStringBuilder);
        for (int i = 0; i < this.z.length; i++) {
            this.z[i].setVisibility(4);
        }
        for (int i2 = 0; i2 < this.z.length && i2 < this.e.i.length; i2++) {
            this.z[i2].setVisibility(0);
            this.C[i2].setText(this.e.i[i2]);
            t.a().b(this.e.i[i2], false, this.L[i2]);
        }
    }

    private void U() {
        OlaCachedImageView olaCachedImageView;
        int i;
        String strD = this.e.d;
        if (!m.a(strD)) {
            ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) strD);
            if (arrayListB == null || arrayListB.isEmpty()) {
                this.F.setVisibility(8);
            } else {
                strD = chat.ola.vn.util.i.d(strD, "");
                String str = arrayListB.get(0);
                switch (o.g(str)) {
                    case 1:
                        this.F.setScaleType(ImageView.ScaleType.CENTER_CROP);
                        t.a().a(str, this.F, R.drawable.ic_media_photo, getResources().getDimensionPixelOffset(R.dimen.me_info_action_thumbnail_size_width) / 2);
                        break;
                    case 2:
                        olaCachedImageView = this.F;
                        i = R.drawable.ic_media_video;
                        olaCachedImageView.setImageResource(i);
                        this.F.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                        break;
                    case 3:
                        olaCachedImageView = this.F;
                        i = R.drawable.ic_media_sound;
                        olaCachedImageView.setImageResource(i);
                        this.F.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                        break;
                }
                this.F.setTag(str);
                this.F.setOnClickListener(this);
                this.F.setVisibility(0);
            }
            if (!m.a(strD)) {
                this.E.setText(Spannable.Factory.getInstance().newSpannable(a(this.E, strD)));
                this.D.setVisibility(0);
                return;
            }
        }
        this.D.setVisibility(8);
    }

    private boolean V() {
        try {
            return m.b(h.a(), this.e.c);
        } catch (Throwable unused) {
            return false;
        }
    }

    private void W() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_change_profile_picture));
        arrayList.add(getString(R.string.string_change_cover_picture));
        arrayList.add(getString(R.string.string_change_me_privacy));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.14
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (str.equals(OlaUserMePageActivity.this.getString(R.string.string_change_profile_picture))) {
                        OlaCropImageActivity.c(OlaUserMePageActivity.this, OlaUserMePageActivity.this);
                    } else if (str.equals(OlaUserMePageActivity.this.getString(R.string.string_change_cover_picture))) {
                        OlaCropImageActivity.b(OlaUserMePageActivity.this, OlaUserMePageActivity.this);
                    } else if (str.equals(OlaUserMePageActivity.this.getString(R.string.string_change_me_privacy))) {
                        OlaUserMePageActivity.this.Y();
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void X() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_block));
        arrayList.add(getString(R.string.string_copy_nick));
        arrayList.add(getString(R.string.string_bad_nick_report));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (str.equals(OlaUserMePageActivity.this.getString(R.string.string_block))) {
                        OlaApplication.b.m(OlaUserMePageActivity.this.e.c);
                        OlaUserMePageActivity.this.e.A = true;
                        OlaUserMePageActivity.this.e.y = false;
                        OlaUserMePageActivity.this.K();
                        return;
                    }
                    if (!str.equals(OlaUserMePageActivity.this.getString(R.string.string_copy_nick))) {
                        if (str.equals(OlaUserMePageActivity.this.getString(R.string.string_bad_nick_report))) {
                            i.a(OlaUserMePageActivity.this, OlaUserMePageActivity.this.e.c);
                        }
                    } else {
                        o.a(OlaUserMePageActivity.this, "@" + OlaUserMePageActivity.this.e.c);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void Y() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_me_privacy_public));
        arrayList.add(getString(R.string.string_me_privacy_friend));
        arrayList.add(getString(R.string.string_me_privacy_private));
        arrayList.add(getString(R.string.string_me_privacy_help));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.3
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                StringBuilder sb;
                String str;
                OlaUserMePageActivity olaUserMePageActivity;
                String string;
                String string2;
                String string3;
                String string4;
                DialogInterface.OnClickListener onClickListener;
                try {
                    String str2 = (String) arrayList.get(i);
                    if (str2.equalsIgnoreCase(OlaUserMePageActivity.this.getString(R.string.string_me_privacy_public))) {
                        olaUserMePageActivity = OlaUserMePageActivity.this;
                        string = OlaUserMePageActivity.this.getString(R.string.dialog_title_confirm);
                        string2 = OlaUserMePageActivity.this.getString(R.string.string_me_privacy_setting_confirm, new Object[]{"\"" + OlaUserMePageActivity.this.getString(R.string.string_me_privacy_public) + "\"?"});
                        string3 = OlaUserMePageActivity.this.getString(R.string.string_yes);
                        string4 = OlaUserMePageActivity.this.getString(R.string.string_no);
                        onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.3.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    OlaApplication.b.g((short) 0);
                                    x.e = (short) 0;
                                    chat.ola.vn.util.j.c(OlaUserMePageActivity.this, OlaUserMePageActivity.this.getString(R.string.string_me_privacy_setting_inform, new Object[]{"\"" + OlaUserMePageActivity.this.getString(R.string.string_me_privacy_public) + "\""}));
                                }
                                dialogInterface.dismiss();
                            }
                        };
                    } else if (str2.equalsIgnoreCase(OlaUserMePageActivity.this.getString(R.string.string_me_privacy_friend))) {
                        olaUserMePageActivity = OlaUserMePageActivity.this;
                        string = OlaUserMePageActivity.this.getString(R.string.dialog_title_confirm);
                        string2 = OlaUserMePageActivity.this.getString(R.string.string_me_privacy_setting_confirm, new Object[]{"\"" + OlaUserMePageActivity.this.getString(R.string.string_me_privacy_friend) + "\"?"});
                        string3 = OlaUserMePageActivity.this.getString(R.string.string_yes);
                        string4 = OlaUserMePageActivity.this.getString(R.string.string_no);
                        onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.3.2
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    OlaApplication.b.f((short) 0);
                                    x.e = (short) 1;
                                    chat.ola.vn.util.j.c(OlaUserMePageActivity.this, OlaUserMePageActivity.this.getString(R.string.string_me_privacy_setting_inform, new Object[]{"\"" + OlaUserMePageActivity.this.getString(R.string.string_me_privacy_friend) + "\""}));
                                }
                                dialogInterface.dismiss();
                            }
                        };
                    } else {
                        if (!str2.equalsIgnoreCase(OlaUserMePageActivity.this.getString(R.string.string_me_privacy_private))) {
                            if (str2.equalsIgnoreCase(OlaUserMePageActivity.this.getString(R.string.string_me_privacy_help))) {
                                if (m.b(x.i(), "vi")) {
                                    sb = new StringBuilder();
                                    sb.append("me_privacy_help");
                                    str = "-vi.html";
                                } else {
                                    sb = new StringBuilder();
                                    sb.append("me_privacy_help");
                                    str = "-en.html";
                                }
                                sb.append(str);
                                chat.ola.vn.i.o.a(OlaUserMePageActivity.this, R.string.string_me_privacy_help, sb.toString());
                                return;
                            }
                            return;
                        }
                        olaUserMePageActivity = OlaUserMePageActivity.this;
                        string = OlaUserMePageActivity.this.getString(R.string.dialog_title_confirm);
                        string2 = OlaUserMePageActivity.this.getString(R.string.string_me_privacy_setting_confirm, new Object[]{"\"" + OlaUserMePageActivity.this.getString(R.string.string_me_privacy_private) + "\"?"});
                        string3 = OlaUserMePageActivity.this.getString(R.string.string_yes);
                        string4 = OlaUserMePageActivity.this.getString(R.string.string_no);
                        onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.3.3
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    OlaApplication.b.e((short) 0);
                                    x.e = (short) 4;
                                    chat.ola.vn.util.j.c(OlaUserMePageActivity.this, OlaUserMePageActivity.this.getString(R.string.string_me_privacy_setting_inform, new Object[]{"\"" + OlaUserMePageActivity.this.getString(R.string.string_me_privacy_private) + "\""}));
                                }
                                dialogInterface.dismiss();
                            }
                        };
                    }
                    i.d(olaUserMePageActivity, string, string2, string3, string4, onClickListener);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void Z() {
        if (this.e == null) {
            return;
        }
        final chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.me.OlaUserMePageActivity.4
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 19;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                ag agVar;
                int i;
                if (!OlaUserMePageActivity.this.e.y) {
                    ag agVar2 = OlaUserMePageActivity.this.e;
                    agVar2.r--;
                    if (OlaUserMePageActivity.this.e.r < 0) {
                        agVar = OlaUserMePageActivity.this.e;
                        i = 0;
                    }
                    OlaUserMePageActivity.this.K();
                }
                agVar = OlaUserMePageActivity.this.e;
                i = agVar.r + 1;
                agVar.r = i;
                OlaUserMePageActivity.this.K();
            }
        };
        if (!this.e.y) {
            OlaApplication.b.a(this.e.c, true, chat.ola.vn.entry.c.f.a(eVar));
            this.e.y = true;
            K();
        } else {
            i.d(this, getString(R.string.dialog_title_confirm), getString(R.string.me_message_notfollow_confirm, new Object[]{"@" + this.e.c}), getString(R.string.string_notfollow), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.5
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    if (i == 0) {
                        try {
                            OlaApplication.b.a(OlaUserMePageActivity.this.e.c, false, chat.ola.vn.entry.c.f.a(eVar));
                            OlaUserMePageActivity.this.e.y = false;
                            OlaUserMePageActivity.this.K();
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                    dialogInterface.dismiss();
                }
            });
        }
    }

    public static void a(Context context, String str) {
        try {
            if (str.startsWith("#")) {
                OlaClanMePageActivity.a(context, str);
            } else {
                b(context, str);
            }
        } catch (Throwable unused) {
        }
    }

    private void aa() {
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(chat.ola.vn.c.c());
        final ArrayList arrayList = new ArrayList(0);
        mVar.a(this.e.a != null ? this.e.a.toString() : this.e.c);
        arrayList.add(OlaApplication.a(this.e.y ? R.string.string_notfollow : R.string.string_follow));
        arrayList.add(OlaApplication.a(R.string.string_unfriend));
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.OlaUserMePageActivity.6
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str = (String) arrayList.get(i);
                if (m.b(str, OlaApplication.a(R.string.string_unfriend))) {
                    chat.ola.vn.message.f fVarD = h.t.d(OlaUserMePageActivity.this.e.c);
                    if (fVarD != null) {
                        OlaApplication.b.e(OlaUserMePageActivity.this.e.c);
                        h.t.d(fVarD);
                    }
                } else if (m.b(str, OlaApplication.a(R.string.string_notfollow))) {
                    OlaApplication.b.a(OlaUserMePageActivity.this.e.c, false, (short) 0);
                    OlaUserMePageActivity.this.e.y = false;
                } else if (m.b(str, OlaApplication.a(R.string.string_follow))) {
                    OlaApplication.b.a(OlaUserMePageActivity.this.e.c, true, (short) 0);
                    OlaUserMePageActivity.this.e.y = true;
                }
                OlaUserMePageActivity.this.K();
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void ab() {
        try {
            if (this.N) {
                return;
            }
            if (x.e()) {
                n.a(this, chat.ola.vn.util.c.a.s);
            }
            this.N = !this.N;
            this.M.setRefreshing(true);
        } catch (Throwable unused) {
        }
    }

    private void ac() {
        try {
            if (this.O != null) {
                OlaApplication.c(this.O);
            }
            if (this.N) {
                if (x.e()) {
                    n.a(this, chat.ola.vn.util.c.a.t);
                }
                this.N = !this.N;
                this.M.setRefreshing(false);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private static void b(Context context, String str) {
        try {
            Intent intent = new Intent(context, (Class<?>) OlaUserMePageActivity.class);
            intent.putExtra("contactId", str);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
            h(str);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        this.u.setVisibility(z ? 0 : 8);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g(String str) {
        String strB;
        boolean z;
        try {
            strB = m.b(str);
            try {
                if (this.u != null) {
                    if (this.u.getVisibility() == 0) {
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
                OlaApplication.b.a(strJ, new String[]{"name"}, new chat.ola.vn.p.d() { // from class: chat.ola.vn.me.OlaUserMePageActivity.11
                    @Override // chat.ola.vn.p.d
                    public void a(int i) {
                        OlaUserMePageActivity olaUserMePageActivity;
                        int i2;
                        try {
                            OlaUserMePageActivity.this.c(false);
                            if (i != 1) {
                                OlaUserMePageActivity.this.f.selectAll();
                                olaUserMePageActivity = OlaUserMePageActivity.this;
                                i2 = R.string.string_buddy_is_not_exist;
                            } else {
                                OlaUserMePageActivity.this.f.selectAll();
                                olaUserMePageActivity = OlaUserMePageActivity.this;
                                i2 = R.string.message_fail_phone_number_invalid;
                            }
                            i.a(olaUserMePageActivity, R.string.dialog_title_inform, i2);
                        } catch (Throwable unused4) {
                        }
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        try {
                            OlaUserMePageActivity.this.c(false);
                            OlaUserMePageActivity.this.f.setText("");
                            OlaUserMePageActivity.a((Context) OlaUserMePageActivity.this, agVar.c);
                        } catch (Throwable unused4) {
                        }
                    }
                });
            } else {
                OlaApplication.b.a(strJ, new chat.ola.vn.p.i() { // from class: chat.ola.vn.me.OlaUserMePageActivity.12
                    @Override // chat.ola.vn.p.i
                    public void a(String str2, boolean z2) {
                        try {
                            OlaUserMePageActivity.this.c(false);
                            if (z2) {
                                OlaUserMePageActivity.this.f.setText("");
                                OlaUserMePageActivity.a((Context) OlaUserMePageActivity.this, str2);
                            } else {
                                OlaUserMePageActivity.this.f.selectAll();
                                i.a(OlaUserMePageActivity.this, R.string.dialog_title_inform, R.string.string_buddy_is_not_exist);
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
        return this.V;
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void D() {
        this.Z = true;
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void E() {
        this.Z = true;
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void F() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void G() {
    }

    public CharSequence a(View view, CharSequence charSequence) {
        return chat.ola.vn.util.i.c(view, chat.ola.vn.util.i.d(view, chat.ola.vn.util.i.b(view, chat.ola.vn.util.i.a(view, chat.ola.vn.util.g.a().a(chat.ola.vn.util.h.a().a(charSequence)), null, f.a, false), null, f.a, false), null, f.a, false), null, f.a, false);
    }

    @Override // chat.ola.vn.c
    protected void a() {
        K();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        super.a(i, str, bArr, dVarArr, s);
        if (s == 79) {
            try {
                ac();
                c(false);
                this.W = false;
                this.V = false;
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, short s, List<chat.ola.vn.entity.g> list, short s2) {
        if (s2 == 79) {
            try {
                ac();
                c(false);
                this.W = false;
                if (this.n.k() == 0) {
                    this.n.b(str, s, list);
                } else {
                    this.n.c(list);
                }
                this.m.notifyDataSetChanged();
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.W || this.e == null) {
            return;
        }
        this.W = true;
        OlaApplication.b.a(this.e.c, this.n.k(), (short) 79);
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
            this.m.notifyDataSetChanged();
            K();
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        OlaMediaEntity[] olaMediaEntityArr;
        OlaCachedImageView olaCachedImageView;
        try {
            switch (view.getId()) {
                case R.id.addConversationImageButton /* 2131296304 */:
                    String strJ = m.j(this.e.c);
                    if (!m.a(strJ)) {
                        OlaChatViewActivity.a(this, strJ);
                    }
                    break;
                case R.id.addFriendViewLayout /* 2131296309 */:
                    if (!m.a(this.e.c)) {
                        if (h.t.d(this.e.c) == null) {
                            OlaApplication.b.d(this.e.c);
                            this.e.y = true;
                            K();
                        } else {
                            aa();
                        }
                    }
                    break;
                case R.id.btnUnBlockMe /* 2131296558 */:
                    String strJ2 = m.j(this.e.c);
                    if (!m.a(strJ2)) {
                        OlaApplication.b.o(strJ2);
                        this.e.A = false;
                        this.e.y = false;
                        K();
                    }
                    break;
                case R.id.coverPictureImageView /* 2131296725 */:
                    if (!m.a(this.e.c)) {
                        olaMediaEntityArr = new OlaMediaEntity[1];
                        for (int i = 0; i < olaMediaEntityArr.length; i++) {
                            olaMediaEntityArr[i] = new OlaMediaEntity(chat.ola.vn.c.f.d(this.e.c).b(), 3, (short) 1);
                        }
                        olaCachedImageView = this.o;
                        OlaImageViewerActivity.a(this, olaCachedImageView, (Bitmap) null, 0, olaMediaEntityArr);
                    }
                    break;
                case R.id.editCoverPictureImageView /* 2131296751 */:
                    if (!m.a(this.e.c)) {
                        OlaCropImageActivity.b(this, this);
                    }
                    break;
                case R.id.editProfilePictureImageView /* 2131296755 */:
                    if (!m.a(this.e.c)) {
                        OlaCropImageActivity.c(this, this);
                    }
                    break;
                case R.id.editProfileViewLayout /* 2131296756 */:
                    OlaUserProfileActivity.a(this);
                    break;
                case R.id.followViewLayout /* 2131296803 */:
                    Z();
                    break;
                case R.id.friendViewLayout /* 2131296822 */:
                    if (!m.a(this.e.c) && this.e.p > 0) {
                        OlaPeopleListActivity.b(this, this.e.c);
                        break;
                    }
                    break;
                case R.id.honeyProfilePictureImageView /* 2131296843 */:
                case R.id.txtMeUserMarriesStatus /* 2131297624 */:
                    if (!m.a(this.e.e)) {
                        a((Context) this, this.e.e);
                    }
                    break;
                case R.id.imgStatusIcon /* 2131296935 */:
                    ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) this.e.d);
                    if (arrayListB != null && !arrayListB.isEmpty()) {
                        Iterator<String> it2 = arrayListB.iterator();
                        while (it2.hasNext()) {
                            if (chat.ola.vn.entity.i.i(it2.next()) != 1) {
                                it2.remove();
                            }
                        }
                        if (arrayListB != null && !arrayListB.isEmpty()) {
                            OlaMediaEntity[] olaMediaEntityArr2 = new OlaMediaEntity[arrayListB.size()];
                            for (int i2 = 0; i2 < olaMediaEntityArr2.length; i2++) {
                                olaMediaEntityArr2[i2] = new OlaMediaEntity(arrayListB.get(i2), 1, (short) 1);
                            }
                            OlaImageViewerActivity.a(this, this.F, (Bitmap) null, 0, olaMediaEntityArr2);
                            break;
                        }
                    }
                    break;
                case R.id.kissViewLayout /* 2131296967 */:
                    if (!V() && !m.a(this.e.c)) {
                        this.e.t++;
                        OlaApplication.b.i(this.e.c);
                        K();
                        Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
                        animationLoadAnimation.setDuration(150L);
                        this.j.startAnimation(animationLoadAnimation);
                        a(view, z());
                        break;
                    }
                    break;
                case R.id.mediaStorageViewLayout /* 2131297105 */:
                    if (m.a(this.e.c) || m.b(h.a(), this.e.c)) {
                        OlaCloudAlbumListActivity.a(this);
                    } else {
                        OlaCloudPhotoListActivity.a(this, this.e.c);
                    }
                    break;
                case R.id.moreViewLayout /* 2131297123 */:
                    if (!m.a(this.e.c)) {
                        if (V()) {
                            W();
                        } else {
                            X();
                        }
                    }
                    break;
                case R.id.olaActionBarBackImageView /* 2131297178 */:
                    finish();
                    break;
                case R.id.postMeViewLayout /* 2131297246 */:
                    if (V()) {
                        OlaMeComposerActivity.a(this);
                    } else {
                        String strJ3 = m.j(this.e.c);
                        if (!m.a(strJ3)) {
                            OlaMeComposerActivity.a(this, "@" + strJ3, (String) null);
                        }
                    }
                    break;
                case R.id.profilePictureImageView /* 2131297255 */:
                    if (!m.a(this.e.c)) {
                        olaMediaEntityArr = new OlaMediaEntity[1];
                        for (int i3 = 0; i3 < olaMediaEntityArr.length; i3++) {
                            olaMediaEntityArr[i3] = new OlaMediaEntity(chat.ola.vn.c.f.c(this.e.c).b(), 3, (short) 1);
                        }
                        olaCachedImageView = this.q;
                        OlaImageViewerActivity.a(this, olaCachedImageView, (Bitmap) null, 0, olaMediaEntityArr);
                    }
                    break;
                case R.id.txtMeUserNote /* 2131297625 */:
                    if (!m.a(this.e.c)) {
                        chat.ola.vn.m.j.a(this, "rss://note/" + this.e.c);
                    }
                    break;
                case R.id.vLinewarFanNumber /* 2131297749 */:
                    if (!m.a(this.e.c) && this.e.r > 0) {
                        OlaPeopleListActivity.a(this, this.e.c);
                        break;
                    }
                    break;
                case R.id.vipAccountGroup /* 2131297772 */:
                    if (!m.a(this.e.c)) {
                        OlaVipStoreActivity.a(this, this.e.c);
                    }
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.af = false;
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

    @Override // chat.ola.vn.c
    public FrameLayout z() {
        return this.ae;
    }
}
