package chat.ola.vn.checkin;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.b.p;
import chat.ola.vn.c;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.y;
import chat.ola.vn.i.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInActivity extends c implements View.OnClickListener, j.a, p.a<OlaVenueEntity>, chat.ola.vn.p.a {
    private static b p;
    private EditText e;
    private ListView f;
    private View g;
    private View h;
    private TextView i;
    private p j;
    private List<OlaVenueEntity> k;
    private OlaCheckInItemEntity n;
    private int l = 0;
    private OlaVenueEntity m = null;
    private boolean o = false;

    private void D() {
        try {
            this.e = (EditText) findViewById(R.id.searchEditText);
            this.e.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.1
                @Override // android.view.View.OnFocusChangeListener
                public void onFocusChange(View view, boolean z) {
                    OlaCheckInActivity olaCheckInActivity;
                    try {
                        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) OlaCheckInActivity.this.e.getLayoutParams();
                        if (z) {
                            layoutParams.width = 0;
                            layoutParams.weight = 1.0f;
                            olaCheckInActivity = OlaCheckInActivity.this;
                        } else {
                            layoutParams.width = -2;
                            layoutParams.weight = 0.0f;
                            olaCheckInActivity = OlaCheckInActivity.this;
                        }
                        olaCheckInActivity.e.setLayoutParams(layoutParams);
                    } catch (Throwable unused) {
                    }
                }
            });
            findViewById(R.id.searchViewLayout).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    try {
                        OlaCheckInActivity.this.e.requestFocus();
                        o.a((Context) OlaCheckInActivity.this, (View) OlaCheckInActivity.this.e, true);
                    } catch (Throwable unused) {
                    }
                }
            });
            this.e.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.3
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        String string = editable.toString();
                        OlaCheckInActivity.this.i.setText(string);
                        OlaCheckInActivity.this.o = false;
                        if (m.c(string)) {
                            OlaCheckInActivity.this.i.setVisibility(8);
                        } else {
                            OlaCheckInActivity.this.i.setVisibility(0);
                        }
                        OlaCheckInActivity.this.j.getFilter().filter(string);
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.text.TextWatcher
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }

                @Override // android.text.TextWatcher
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }
            });
            this.e.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.4
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (i == 6 || i == 3) {
                        try {
                            OlaCheckInActivity.this.F();
                            o.a((Context) OlaCheckInActivity.this, (View) OlaCheckInActivity.this.e, false);
                            return true;
                        } catch (Throwable unused) {
                        }
                    }
                    return false;
                }
            });
            this.g = findViewById(R.id.progressBar);
            this.f = (ListView) findViewById(R.id.lvCheckInItems);
            this.f.setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.5
                @Override // android.view.View.OnTouchListener
                @SuppressLint({"ClickableViewAccessibility"})
                public boolean onTouch(View view, MotionEvent motionEvent) {
                    o.a((Context) OlaCheckInActivity.this, (View) OlaCheckInActivity.this.e, false);
                    return false;
                }
            });
            try {
                View viewInflate = LayoutInflater.from(this).inflate(R.layout.create_check_in_layout, (ViewGroup) null);
                this.f.addHeaderView(viewInflate);
                this.h = viewInflate.findViewById(R.id.vLinearCreateCheckIn);
                this.h.setOnClickListener(this);
                this.i = (TextView) viewInflate.findViewById(R.id.txtTempPlaceName);
            } catch (Throwable unused) {
            }
            ((ImageView) findViewById(R.id.olaActionBarMoreButtonImageView)).setVisibility(8);
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_check_in);
            findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
            findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void E() {
        try {
            this.j = new p(this);
            this.j.a((j.a) this);
            this.j.a((p.a<OlaVenueEntity>) this);
            this.j.a((View.OnClickListener) this);
            this.f.setAdapter((ListAdapter) this.j);
            this.j.notifyDataSetChanged();
            c(true);
            e((String) null, 0);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        try {
            String string = this.e.getText().toString();
            try {
                int count = this.j.getCount();
                for (int i = 0; i < count; i++) {
                    OlaVenueEntity item = this.j.getItem(i);
                    if (m.b(item.c(), string)) {
                        c(item);
                        return;
                    }
                }
                OlaCheckInCreateVenueItemActivity.a(this, string, new b() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.7
                    @Override // chat.ola.vn.checkin.b
                    public void a(String str, OlaVenueEntity olaVenueEntity, OlaCheckInActionEntity olaCheckInActionEntity, OlaCheckInItemEntity olaCheckInItemEntity) {
                        if (OlaCheckInActivity.p != null) {
                            OlaCheckInActivity.p.a(str, olaVenueEntity, olaCheckInActionEntity, olaCheckInItemEntity);
                        }
                        OlaCheckInActivity.this.finish();
                    }

                    @Override // chat.ola.vn.checkin.b
                    public void m_() {
                    }
                });
            } catch (Throwable unused) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void G() {
        String strA;
        try {
            strA = this.n.a();
        } catch (Throwable unused) {
            strA = null;
        }
        try {
            if (OlaApplication.b != null) {
                OlaApplication.b.a((String) null, this.m.b(), strA, this);
            }
        } catch (Throwable unused2) {
        }
    }

    private OlaVenueEntity a(List<OlaVenueEntity> list, String str) {
        try {
            if (m.a(str)) {
                return null;
            }
            for (OlaVenueEntity olaVenueEntity : list) {
                if (m.b(str, olaVenueEntity.c())) {
                    return olaVenueEntity;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void a(Context context, b bVar) {
        try {
            p = bVar;
            Intent intent = new Intent(context, (Class<?>) OlaCheckInActivity.class);
            intent.addFlags(131072);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void c(OlaVenueEntity olaVenueEntity) {
        OlaCheckInChooseActionActivity.a(this, olaVenueEntity, new b() { // from class: chat.ola.vn.checkin.OlaCheckInActivity.6
            @Override // chat.ola.vn.checkin.b
            public void a(String str, OlaVenueEntity olaVenueEntity2, OlaCheckInActionEntity olaCheckInActionEntity, OlaCheckInItemEntity olaCheckInItemEntity) {
                if (OlaCheckInActivity.p != null) {
                    OlaCheckInActivity.p.a(str, olaVenueEntity2, olaCheckInActionEntity, olaCheckInItemEntity);
                }
                OlaCheckInActivity.this.finish();
            }

            @Override // chat.ola.vn.checkin.b
            public void m_() {
            }
        });
    }

    private void e(String str, int i) {
        try {
            if (!m.c(chat.ola.vn.n.c.a().b()) && !m.c(chat.ola.vn.n.c.a().c())) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.a(str, i, (chat.ola.vn.p.a) this);
                    return;
                }
                return;
            }
            if (chat.ola.vn.n.b.c(this)) {
                i.a(this, R.string.dialog_title_inform, R.string.message_location_provider_unavailable);
            } else {
                i.e(this);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.l > 0;
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(chat.ola.vn.entity.o oVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(y yVar) {
    }

    @Override // chat.ola.vn.b.p.a
    public void a(List<OlaVenueEntity> list) {
        OlaVenueEntity olaVenueEntityA;
        if (list == null || list.size() == 0) {
            this.l = 0;
            e(this.e.getText().toString(), this.l);
            return;
        }
        try {
            if (!this.o || (olaVenueEntityA = a(list, this.e.getText().toString())) == null) {
                return;
            }
            try {
                c(true);
                this.m = olaVenueEntityA;
                G();
            } catch (Throwable th) {
                th.printStackTrace();
            }
        } catch (Exception unused) {
        }
    }

    @Override // chat.ola.vn.p.a
    public void a(List<g> list, long j) {
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:16:0x001f A[Catch: Exception -> 0x0015, TryCatch #0 {Exception -> 0x0015, blocks: (B:7:0x0009, B:9:0x0011, B:15:0x001b, B:14:0x0018, B:16:0x001f, B:18:0x0028), top: B:23:0x0002, inners: #1 }] */
    @Override // chat.ola.vn.p.a
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(short r3, java.lang.String r4) {
        /*
            r2 = this;
            r0 = 7
            r1 = 0
            if (r3 == r0) goto L1f
            switch(r3) {
                case 0: goto L30;
                case 1: goto L9;
                case 2: goto L8;
                case 3: goto L1f;
                case 4: goto L1f;
                default: goto L7;
            }
        L7:
            goto L30
        L8:
            return
        L9:
            java.util.List<chat.ola.vn.entity.OlaVenueEntity> r3 = r2.k     // Catch: java.lang.Exception -> L15 java.lang.Throwable -> L17
            r2.l = r1     // Catch: java.lang.Exception -> L15 java.lang.Throwable -> L17
            boolean r3 = r2.o     // Catch: java.lang.Exception -> L15 java.lang.Throwable -> L17
            if (r3 == 0) goto L1b
            r2.F()     // Catch: java.lang.Exception -> L15 java.lang.Throwable -> L17
            goto L1b
        L15:
            r3 = move-exception
            goto L2d
        L17:
            r3 = move-exception
            r3.printStackTrace()     // Catch: java.lang.Exception -> L15
        L1b:
            r2.c(r1)     // Catch: java.lang.Exception -> L15
            goto L30
        L1f:
            r2.c(r1)     // Catch: java.lang.Exception -> L15
            boolean r3 = chat.ola.vn.util.m.c(r4)     // Catch: java.lang.Exception -> L15
            if (r3 != 0) goto L30
            r3 = 0
            chat.ola.vn.i.i.b(r2, r3, r4)     // Catch: java.lang.Exception -> L15
            goto L30
        L2d:
            r3.printStackTrace()
        L30:
            r2.c(r1)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.checkin.OlaCheckInActivity.a(short, java.lang.String):void");
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        e(this.e.getText().toString(), this.l);
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
        if (list != null) {
            try {
                if (this.l == 0) {
                    this.k = new ArrayList(list);
                } else {
                    if (this.k == null) {
                        this.k = new ArrayList(0);
                    }
                    ArrayList arrayList = new ArrayList(list);
                    for (int i2 = 0; i2 < list.size(); i2++) {
                        this.k.add((OlaVenueEntity) arrayList.get(i2));
                    }
                }
                this.j.a(this.k);
                this.j.notifyDataSetChanged();
                try {
                    if (this.o) {
                        OlaVenueEntity olaVenueEntityA = a(this.k, this.e.getText().toString());
                        if (olaVenueEntityA != null) {
                            try {
                                c(true);
                                this.m = olaVenueEntityA;
                                G();
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        } else {
                            F();
                        }
                    }
                } catch (Throwable unused) {
                }
            } catch (Throwable th2) {
                th2.printStackTrace();
            }
        }
        this.l = i;
        c(false);
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInItemEntity> list, int i) {
    }

    public void c(boolean z) {
        View view;
        int i;
        if (this.g != null) {
            if (z) {
                view = this.g;
                i = 0;
            } else {
                view = this.g;
                i = 8;
            }
            view.setVisibility(i);
        }
    }

    @Override // chat.ola.vn.p.a
    public void f(String str) {
        try {
            Intent intent = new Intent();
            intent.putExtra("extra_check_in_id", str);
            intent.putExtra("_byte_data", this.m.h());
            setResult(-1, intent);
            finish();
        } catch (Throwable th) {
            th.printStackTrace();
        }
        c(false);
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.btnDetail /* 2131296454 */:
                    OlaVenueDetailActivity.a(this, ((OlaVenueEntity) view.getTag()).b());
                    break;
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                case R.id.olaActionBarMoreButtonImageView /* 2131297185 */:
                    finish();
                    break;
                case R.id.olaActionBarTitleViewLayout /* 2131297188 */:
                    this.f.smoothScrollToPosition(0);
                    break;
                case R.id.vLinearCheckInInfo /* 2131297738 */:
                    c(true);
                    this.m = (OlaVenueEntity) view.getTag();
                    c(this.m);
                    break;
                case R.id.vLinearCreateCheckIn /* 2131297742 */:
                    F();
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.check_in_activity_layout);
        D();
        E();
    }
}
