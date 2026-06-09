package chat.ola.vn.checkin;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.location.Location;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.b.u;
import chat.ola.vn.c;
import chat.ola.vn.c.f;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.o;
import chat.ola.vn.entity.y;
import chat.ola.vn.g;
import chat.ola.vn.h;
import chat.ola.vn.me.OlaClanMePageActivity;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.r.a.d;
import chat.ola.vn.r.a.e;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import chat.ola.vn.view.OlaRatioImageView;
import com.google.android.gms.common.util.CrashUtils;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaVenueDetailActivity extends c implements View.OnClickListener, j.a, chat.ola.vn.p.a, d {
    private View B;
    private String F;
    protected y e;
    protected OlaQuickTypingSuggestedText f;
    protected TextView g;
    protected TextView h;
    protected TextView i;
    protected TextView j;
    protected View k;
    protected TextView l;
    protected ListView m;
    protected u n;
    protected e o;
    protected OlaRatioImageView p;
    protected OlaRatioImageView q;
    protected OlaCachedImageView r;
    protected View s;
    protected View t;
    protected View u;
    protected TextView v;
    protected OlaCachedImageView[] w;
    private q x;
    private SwipeRefreshLayout y;
    private boolean z = false;
    private Runnable A = null;
    private long C = 0;
    private boolean D = true;
    private boolean E = false;
    private chat.ola.vn.e.c G = null;

    private void F() {
        try {
            findViewById(R.id.olaActionBarBackImageView).setOnClickListener(this);
            findViewById(R.id.addConversationImageButton).setOnClickListener(this);
            this.y = (SwipeRefreshLayout) findViewById(R.id.pullToRefreshLayout);
            this.y.setColorSchemeResources(R.color.colorOlaPrimary);
            this.y.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.1
                @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
                public void onRefresh() {
                    try {
                        if (OlaVenueDetailActivity.this.A == null) {
                            OlaVenueDetailActivity.this.A = new Runnable() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.1.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    if (OlaVenueDetailActivity.this.z) {
                                        OlaVenueDetailActivity.this.z = !OlaVenueDetailActivity.this.z;
                                        OlaVenueDetailActivity.this.y.setRefreshing(false);
                                    }
                                }
                            };
                        }
                        OlaVenueDetailActivity.this.L();
                        OlaVenueDetailActivity.this.G();
                        OlaApplication.c(OlaVenueDetailActivity.this.A);
                        OlaApplication.a(OlaVenueDetailActivity.this.A, 30000L);
                    } catch (Throwable unused) {
                    }
                }
            });
            this.f = (OlaQuickTypingSuggestedText) findViewById(R.id.searchEditText);
            this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.2
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
                        chat.ola.vn.checkin.OlaVenueDetailActivity r1 = chat.ola.vn.checkin.OlaVenueDetailActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.view.OlaQuickTypingSuggestedText r1 = r1.f     // Catch: java.lang.Throwable -> L38
                        android.text.Editable r1 = r1.getText()     // Catch: java.lang.Throwable -> L38
                        java.lang.String r1 = r1.toString()     // Catch: java.lang.Throwable -> L38
                        boolean r2 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> L38
                        if (r2 != 0) goto L36
                        java.lang.String r1 = r1.trim()     // Catch: java.lang.Throwable -> L38
                        java.lang.String r2 = "#"
                        boolean r2 = r1.startsWith(r2)     // Catch: java.lang.Throwable -> L38
                        if (r2 == 0) goto L31
                        chat.ola.vn.checkin.OlaVenueDetailActivity r2 = chat.ola.vn.checkin.OlaVenueDetailActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.checkin.OlaVenueDetailActivity.b(r2, r1)     // Catch: java.lang.Throwable -> L38
                        goto L36
                    L31:
                        chat.ola.vn.checkin.OlaVenueDetailActivity r2 = chat.ola.vn.checkin.OlaVenueDetailActivity.this     // Catch: java.lang.Throwable -> L38
                        chat.ola.vn.checkin.OlaVenueDetailActivity.a(r2, r1)     // Catch: java.lang.Throwable -> L38
                    L36:
                        r1 = 1
                        return r1
                    L38:
                        r1 = 0
                        return r1
                    */
                    throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.checkin.OlaVenueDetailActivity.AnonymousClass2.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
                }
            });
            this.x = new q(this);
            this.x.a(g.a());
            q qVar = this.x;
            q qVar2 = this.x;
            qVar2.getClass();
            qVar.a(qVar2.new a());
            this.f.setAdapter(this.x);
            this.f.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.3
                @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
                public void b_(String str) {
                    try {
                        if (m.a(str)) {
                            return;
                        }
                        String strTrim = str.trim();
                        if (strTrim.startsWith("#")) {
                            OlaVenueDetailActivity.c(OlaVenueDetailActivity.this, strTrim);
                        } else {
                            OlaVenueDetailActivity.this.h(strTrim);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            this.m = (ListView) findViewById(R.id.pageListView);
            this.t = findViewById(R.id.wattingProgressBar);
            this.o = new e();
            this.n = new u(this, this.o);
            this.n.a((j.a) this);
            this.n.a(new View.OnClickListener() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    chat.ola.vn.q.b.a().b(OlaVenueDetailActivity.this, view);
                }
            });
            this.n.a(new View.OnLongClickListener() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.5
                @Override // android.view.View.OnLongClickListener
                public boolean onLongClick(View view) {
                    return chat.ola.vn.q.b.a().a(OlaVenueDetailActivity.this, view);
                }
            });
            try {
                View viewInflate = LayoutInflater.from(this).inflate(R.layout.ola_venue_page_header_layout, (ViewGroup) null);
                this.h = (TextView) viewInflate.findViewById(R.id.fanNumberTextView);
                this.p = (OlaRatioImageView) viewInflate.findViewById(R.id.coverPictureImageView);
                this.p.setOnClickListener(this);
                this.r = (OlaCachedImageView) viewInflate.findViewById(R.id.profilePictureImageView);
                this.r.setOnClickListener(this);
                this.g = (TextView) viewInflate.findViewById(R.id.contactIdTextView);
                this.i = (TextView) viewInflate.findViewById(R.id.descriptionTextView);
                this.j = (TextView) viewInflate.findViewById(R.id.bossTextView);
                this.s = viewInflate.findViewById(R.id.mapViewLayout);
                this.k = viewInflate.findViewById(R.id.directionViewLayout);
                this.k.setOnClickListener(this);
                this.l = (TextView) viewInflate.findViewById(R.id.addressTextView);
                this.q = (OlaRatioImageView) viewInflate.findViewById(R.id.mapImageView);
                this.q.setOnClickListener(this);
                this.q.setRatio(3.5555555555555554d);
                this.u = viewInflate.findViewById(R.id.mediaStorageViewLayout);
                this.u.setOnClickListener(this);
                this.v = (TextView) viewInflate.findViewById(R.id.mediaStorageTextView);
                this.w = new OlaCachedImageView[6];
                this.w[0] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView1);
                this.w[0].setOnClickListener(this);
                this.w[1] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView2);
                this.w[1].setOnClickListener(this);
                this.w[2] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView5);
                this.w[2].setOnClickListener(this);
                this.w[3] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView3);
                this.w[3].setOnClickListener(this);
                this.w[4] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView4);
                this.w[4].setOnClickListener(this);
                this.w[5] = (OlaCachedImageView) viewInflate.findViewById(R.id.mediaImageView6);
                this.w[5].setOnClickListener(this);
                this.m.addHeaderView(viewInflate);
            } catch (Throwable unused) {
            }
            try {
                this.B = LayoutInflater.from(this).inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
                this.m.addFooterView(this.B);
                this.B.setVisibility(8);
            } catch (Throwable unused2) {
            }
            this.m.setAdapter((ListAdapter) this.n);
        } catch (Throwable unused3) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void G() {
        this.o.e();
        this.e = null;
        H();
        this.n.notifyDataSetChanged();
    }

    private void H() {
        try {
            if (this.e == null) {
                if (!this.z) {
                    c(true);
                }
                i(this.F);
            } else {
                J();
                this.f.setAdapter(null);
                this.f.setText(this.e.b());
                this.f.setAdapter(this.x);
                this.g.setText(this.e.b());
                if (m.a(this.e.c())) {
                    this.i.setVisibility(8);
                } else {
                    this.i.setVisibility(0);
                    this.i.setText(this.e.c());
                }
                if (m.a(this.e.k())) {
                    this.j.setVisibility(8);
                } else {
                    this.j.setVisibility(0);
                    this.j.setText(i.c("@" + this.e.k()));
                }
                if (m.a(this.e.g()) || m.a(this.e.f())) {
                    this.s.setVisibility(8);
                } else {
                    this.s.setVisibility(0);
                    if (m.a(this.e.d())) {
                        this.l.setVisibility(8);
                    } else {
                        this.l.setVisibility(0);
                        this.l.setText(this.e.d());
                    }
                    final f fVarA = f.a(this.e.g(), this.e.f(), this.q.getWidth(), this.q.getHeight(), 17);
                    final String strE = fVarA.e();
                    if (!this.q.a(strE)) {
                        t.a().a(strE, new chat.ola.vn.c.i() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.6
                            @Override // chat.ola.vn.c.w
                            public void c(String str) {
                                try {
                                    if (m.b(str, strE)) {
                                        fVarA.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.6.1
                                            @Override // chat.ola.vn.c.g
                                            public void a(f fVar) {
                                                try {
                                                    if (m.b(strE, fVar.e())) {
                                                        OlaVenueDetailActivity.this.q.a(fVar.c(), strE);
                                                    }
                                                } catch (Throwable unused) {
                                                }
                                            }

                                            @Override // chat.ola.vn.c.g
                                            public void b(f fVar) {
                                            }
                                        });
                                        new chat.ola.vn.c.e().a(fVarA);
                                    }
                                } catch (Throwable unused) {
                                }
                            }

                            @Override // chat.ola.vn.c.w
                            public void c(String str, Bitmap bitmap) {
                            }
                        });
                    }
                }
                if (chat.ola.vn.n.c.a().e() == null || m.a(this.e.g()) || m.a(this.e.f())) {
                    this.h.setVisibility(8);
                } else {
                    Location locationE = chat.ola.vn.n.c.a().e();
                    Location location = new Location("");
                    location.setLatitude(Double.parseDouble(this.e.g()));
                    location.setLongitude(Double.parseDouble(this.e.f()));
                    this.h.setVisibility(0);
                    float fDistanceTo = locationE.distanceTo(location);
                    if (fDistanceTo < 10.0f) {
                        this.h.setText(R.string.string_nearby);
                    } else if (fDistanceTo < 1000.0f) {
                        this.h.setText(((int) fDistanceTo) + "m");
                    } else {
                        this.h.setText(String.format("%.1f", Float.valueOf(fDistanceTo / 1000.0f)) + "Km");
                    }
                }
                I();
            }
            if (this.o.j() == 0) {
                a_(0);
            }
            this.x.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    private void I() {
        int i;
        List<String> listJ = this.e.j();
        if (listJ == null) {
            this.u.setVisibility(8);
            return;
        }
        int size = listJ.size();
        if (size <= 0) {
            this.u.setVisibility(8);
            return;
        }
        this.u.setVisibility(0);
        String string = getString(R.string.string_media_store);
        String str = string + " · " + m.a(size);
        SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(str);
        spannableStringBuilder.setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, string.length(), 33);
        spannableStringBuilder.setSpan(new ForegroundColorSpan(chat.ola.vn.f.z), string.length(), str.length(), 33);
        this.v.setText(spannableStringBuilder);
        for (int i2 = 0; i2 < this.w.length; i2++) {
            this.w[i2].setVisibility(8);
        }
        if (size > 3) {
            for (int i3 = 0; i3 < this.w.length; i3++) {
                this.w[i3].setVisibility(4);
            }
        } else {
            this.w[0].setVisibility(4);
            this.w[1].setVisibility(4);
            this.w[2].setVisibility(4);
        }
        for (int i4 = 0; i4 < this.w.length && i4 < size; i4++) {
            OlaCachedImageView olaCachedImageView = this.w[i4];
            olaCachedImageView.setVisibility(0);
            String str2 = listJ.get(i4);
            switch (chat.ola.vn.entity.i.i(str2)) {
                case 1:
                    olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                    t.a().b(str2, olaCachedImageView, olaCachedImageView.getWidth());
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

    private void J() {
        if (this.e != null) {
            if (m.a(this.e.k())) {
                this.r.setVisibility(8);
            } else {
                this.r.setVisibility(0);
                t.a().g(this.e.k(), this.r);
            }
            if (m.a(this.e.i())) {
                this.p.a(null, null);
                return;
            }
            if (f.o(this.e.i())) {
                t.a().a(this.e.i(), this.p);
            } else {
                t.a().d(this.e.i(), this.p);
            }
            this.p.setRatio(1.7777777777777777d);
        }
    }

    private static void K() {
        h.u.t();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void L() {
        if (this.z) {
            return;
        }
        if (x.e()) {
            n.a(this, chat.ola.vn.util.c.a.s);
        }
        this.z = !this.z;
        this.y.setRefreshing(true);
    }

    private void M() {
        if (this.A != null) {
            OlaApplication.c(this.A);
        }
        if (this.z) {
            if (x.e()) {
                n.a(this, chat.ola.vn.util.c.a.t);
            }
            this.z = !this.z;
            this.y.setRefreshing(false);
        }
    }

    public static void a(Context context, String str) {
        try {
            Bundle bundle = new Bundle();
            bundle.putString("_byte_data", str);
            Intent intent = new Intent(context, (Class<?>) OlaVenueDetailActivity.class);
            intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            intent.putExtras(bundle);
            context.startActivity(intent);
            try {
                ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
            } catch (Throwable unused) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(View view, int i) {
        List<String> listJ = this.e.j();
        if (listJ == null || listJ.size() == 0) {
            return;
        }
        if (i >= listJ.size()) {
            i = listJ.size() - 1;
        }
        ArrayList arrayList = new ArrayList(listJ.size());
        int size = listJ.size();
        for (int i2 = 0; i2 < size; i2++) {
            String str = listJ.get(i2);
            if (chat.ola.vn.entity.i.i(str) == 1) {
                arrayList.add(new OlaMediaEntity(str, 1, (short) 1));
            }
        }
        OlaImageViewerActivity.a(this, view, (Bitmap) null, i, (ArrayList<OlaMediaEntity>) arrayList);
    }

    private void a(String str, long j) {
        if (this.E) {
            return;
        }
        OlaApplication.b.a(str, j, this);
        this.E = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void c(Context context, String str) {
        try {
            d(context, str);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        this.t.setVisibility(z ? 0 : 8);
    }

    private static void d(Context context, String str) {
        try {
            String strK = m.k(str);
            Intent intent = new Intent(context, (Class<?>) OlaClanMePageActivity.class);
            intent.putExtra("contactId", strK);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
            j("#" + strK);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(String str) {
        String strB;
        boolean z;
        try {
            strB = m.b(str);
            try {
                if (this.t != null) {
                    if (this.t.getVisibility() == 0) {
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
                OlaApplication.b.a(strJ, new String[]{"name"}, new chat.ola.vn.p.d() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.7
                    @Override // chat.ola.vn.p.d
                    public void a(int i) {
                        OlaVenueDetailActivity olaVenueDetailActivity;
                        int i2;
                        try {
                            OlaVenueDetailActivity.this.c(false);
                            if (i != 1) {
                                OlaVenueDetailActivity.this.f.selectAll();
                                olaVenueDetailActivity = OlaVenueDetailActivity.this;
                                i2 = R.string.string_buddy_is_not_exist;
                            } else {
                                OlaVenueDetailActivity.this.f.selectAll();
                                olaVenueDetailActivity = OlaVenueDetailActivity.this;
                                i2 = R.string.message_fail_phone_number_invalid;
                            }
                            chat.ola.vn.i.i.a(olaVenueDetailActivity, R.string.dialog_title_inform, i2);
                        } catch (Throwable unused4) {
                        }
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        try {
                            OlaVenueDetailActivity.this.c(false);
                            OlaVenueDetailActivity.this.f.setText("");
                            OlaUserMePageActivity.a(OlaVenueDetailActivity.this, agVar.c);
                        } catch (Throwable unused4) {
                        }
                    }
                });
            } else {
                OlaApplication.b.a(strJ, new chat.ola.vn.p.i() { // from class: chat.ola.vn.checkin.OlaVenueDetailActivity.8
                    @Override // chat.ola.vn.p.i
                    public void a(String str2, boolean z2) {
                        try {
                            OlaVenueDetailActivity.this.c(false);
                            if (z2) {
                                OlaVenueDetailActivity.this.f.setText("");
                                OlaUserMePageActivity.a(OlaVenueDetailActivity.this, str2);
                            } else {
                                OlaVenueDetailActivity.this.f.selectAll();
                                chat.ola.vn.i.i.a(OlaVenueDetailActivity.this, R.string.dialog_title_inform, R.string.string_buddy_is_not_exist);
                            }
                        } catch (Throwable unused4) {
                        }
                    }
                });
            }
        } catch (Throwable unused4) {
        }
    }

    private void i(String str) {
        if (OlaApplication.b != null) {
            OlaApplication.b.c(str, this);
        }
    }

    private static void j(String str) {
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
        K();
        if (fVarB != null) {
            gVarA.a(fVarB.b());
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.D;
    }

    @Override // chat.ola.vn.r.a.d
    public String C() {
        return null;
    }

    @Override // chat.ola.vn.r.a.d
    public void D() {
    }

    @Override // chat.ola.vn.r.a.d
    public void E() {
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.r.a.d
    public void a(int i, int i2) {
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entity.g gVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.p.a
    public void a(o oVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(y yVar) {
        if (yVar != null) {
            this.e = yVar;
            c(false);
            a(this.F, 0L);
            H();
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entry.a aVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entry.b bVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.p.a
    public void a(List<chat.ola.vn.entity.g> list, long j) {
        if (this.G == null) {
            this.G = new chat.ola.vn.e.c(false);
        }
        if (list == null || list.size() <= 0) {
            this.D = false;
        } else {
            Collections.sort(list, this.G);
            this.D = true;
            if (this.o.k() == 0) {
                this.o.b("", (short) 0, list);
            } else {
                this.o.c(list);
            }
            this.n.notifyDataSetChanged();
        }
        if (j != 0) {
            this.C = j;
        } else {
            this.D = false;
        }
        this.B.setVisibility(8);
        M();
        c(false);
        this.E = false;
    }

    @Override // chat.ola.vn.r.a.d
    public void a(List<chat.ola.vn.entry.b> list, List<chat.ola.vn.entry.b> list2) {
    }

    @Override // chat.ola.vn.p.a
    public void a(short s, String str) {
        this.D = false;
        switch (s) {
            case 5:
                this.B.setVisibility(8);
                c(false);
                break;
            case 6:
                if (this.C != 0 && !m.c(str)) {
                    chat.ola.vn.i.i.b(this, null, str);
                }
                break;
        }
        H();
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            if (this.e != null) {
                this.B.setVisibility(0);
                a(this.e.a(), this.C);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.r.a.d
    public void b(chat.ola.vn.entry.b bVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
    }

    @Override // chat.ola.vn.r.a.d
    public void b(List<chat.ola.vn.entry.b> list, List<chat.ola.vn.entry.b> list2) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInItemEntity> list, int i) {
    }

    @Override // chat.ola.vn.r.a.d
    public void d(int i) {
    }

    @Override // chat.ola.vn.r.a.d
    public void d(List<af> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void e(List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.p.a
    public void f(String str) {
        try {
            c(false);
            if (m.c(str)) {
                return;
            }
            this.e.e().h(null);
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void f(List<String> list) {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void g(String str) {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        OlaCachedImageView olaCachedImageView;
        int i;
        OlaCachedImageView olaCachedImageView2;
        try {
            int id = view.getId();
            if (id == R.id.addConversationImageButton) {
                new OlaVenueEntity();
                OlaVenueEntity olaVenueEntity = new OlaVenueEntity();
                olaVenueEntity.d(this.e.d());
                olaVenueEntity.c(this.e.c());
                olaVenueEntity.e(this.e.i());
                olaVenueEntity.b(this.e.b());
                olaVenueEntity.a(this.e.a());
                olaVenueEntity.f(this.e.f());
                olaVenueEntity.g(this.e.g());
                olaVenueEntity.h(this.e.l());
                olaVenueEntity.a(this.e.h());
                OlaMeComposerActivity.a(this, olaVenueEntity);
                return;
            }
            if (id == R.id.coverPictureImageView) {
                OlaMediaEntity olaMediaEntity = f.o(this.e.i()) ? new OlaMediaEntity(this.e.i(), 3, (short) 1) : new OlaMediaEntity(this.e.i(), 1, (short) 1);
                ArrayList arrayList = new ArrayList(0);
                arrayList.add(olaMediaEntity);
                OlaImageViewerActivity.a(this, view, (Bitmap) null, 0, (ArrayList<OlaMediaEntity>) arrayList);
                return;
            }
            if (id == R.id.directionViewLayout) {
                if (chat.ola.vn.n.c.a().e() == null || m.a(this.e.g()) || m.a(this.e.f())) {
                    return;
                }
                chat.ola.vn.util.b.a(this, chat.ola.vn.n.c.a().c(), chat.ola.vn.n.c.a().b(), this.e.g(), this.e.f());
                return;
            }
            if (id == R.id.mapImageView) {
                if (m.a(this.e.g()) || m.a(this.e.f())) {
                    return;
                }
                chat.ola.vn.util.b.a(this, this.e.g(), this.e.f(), this.e.b());
                return;
            }
            if (id != R.id.mediaStorageViewLayout) {
                if (id == R.id.olaActionBarBackImageView) {
                    finish();
                    return;
                }
                switch (id) {
                    case R.id.mediaImageView1 /* 2131297096 */:
                        olaCachedImageView = this.w[0];
                        break;
                    case R.id.mediaImageView2 /* 2131297097 */:
                        a(this.w[1], 1);
                        break;
                    case R.id.mediaImageView3 /* 2131297098 */:
                        a(this.w[3], 3);
                        break;
                    case R.id.mediaImageView4 /* 2131297099 */:
                        i = 4;
                        olaCachedImageView2 = this.w[4];
                        a(olaCachedImageView2, i);
                        break;
                    case R.id.mediaImageView5 /* 2131297100 */:
                        i = 2;
                        olaCachedImageView2 = this.w[2];
                        a(olaCachedImageView2, i);
                        break;
                    case R.id.mediaImageView6 /* 2131297101 */:
                        i = 5;
                        olaCachedImageView2 = this.w[5];
                        a(olaCachedImageView2, i);
                        break;
                }
                return;
            }
            olaCachedImageView = this.w[0];
            a(olaCachedImageView, 0);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_user_me_page_layout);
        this.F = getIntent().getStringExtra("_byte_data");
        F();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        try {
            this.e = null;
            this.o = null;
            this.D = true;
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        H();
    }
}
