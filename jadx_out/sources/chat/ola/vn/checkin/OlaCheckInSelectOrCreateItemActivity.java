package chat.ola.vn.checkin;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.y;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInSelectOrCreateItemActivity extends c implements View.OnClickListener, j.a, chat.ola.vn.p.a {
    private static b m;
    private static OlaVenueEntity n;
    private static OlaCheckInActionEntity o;
    private ListView e;
    private EditText f;
    private View g;
    private TextView h;
    private View i;
    private List<OlaCheckInItemEntity> j;
    private a k;
    private int l = 0;
    private Runnable p;

    private void F() {
        try {
            this.e = (ListView) findViewById(R.id.lvCheckInItems);
            this.e.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.1
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    OlaCheckInSelectOrCreateItemActivity.this.a(OlaCheckInSelectOrCreateItemActivity.n.b(), OlaCheckInSelectOrCreateItemActivity.o, OlaCheckInSelectOrCreateItemActivity.this.k.getItem(i));
                }
            });
            this.e.setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.2
                @Override // android.view.View.OnTouchListener
                @SuppressLint({"ClickableViewAccessibility"})
                public boolean onTouch(View view, MotionEvent motionEvent) {
                    o.a((Context) OlaCheckInSelectOrCreateItemActivity.this, (View) OlaCheckInSelectOrCreateItemActivity.this.f, false);
                    return false;
                }
            });
            this.f = (EditText) findViewById(R.id.searchEditText);
            this.f.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.3
                @Override // android.view.View.OnFocusChangeListener
                public void onFocusChange(View view, boolean z) {
                    OlaCheckInSelectOrCreateItemActivity olaCheckInSelectOrCreateItemActivity;
                    try {
                        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) OlaCheckInSelectOrCreateItemActivity.this.f.getLayoutParams();
                        if (z) {
                            layoutParams.width = 0;
                            layoutParams.weight = 1.0f;
                            olaCheckInSelectOrCreateItemActivity = OlaCheckInSelectOrCreateItemActivity.this;
                        } else {
                            layoutParams.width = -2;
                            layoutParams.weight = 0.0f;
                            olaCheckInSelectOrCreateItemActivity = OlaCheckInSelectOrCreateItemActivity.this;
                        }
                        olaCheckInSelectOrCreateItemActivity.f.setLayoutParams(layoutParams);
                    } catch (Throwable unused) {
                    }
                }
            });
            findViewById(R.id.searchViewLayout).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.4
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    try {
                        OlaCheckInSelectOrCreateItemActivity.this.f.requestFocus();
                        o.a((Context) OlaCheckInSelectOrCreateItemActivity.this, (View) OlaCheckInSelectOrCreateItemActivity.this.f, true);
                    } catch (Throwable unused) {
                    }
                }
            });
            this.f.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.5
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        OlaCheckInSelectOrCreateItemActivity.this.k.getFilter().filter(editable);
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
            this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.6
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (i != 6 && i != 3) {
                        return false;
                    }
                    try {
                        OlaCheckInSelectOrCreateItemActivity.this.h(OlaCheckInSelectOrCreateItemActivity.this.f.getText().toString());
                        return true;
                    } catch (Throwable unused) {
                        return false;
                    }
                }
            });
            this.g = findViewById(R.id.vRelativeSearchItem);
            findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
            this.h = (TextView) findViewById(R.id.olaActionBarTitleTextView);
            TextView textView = (TextView) findViewById(R.id.olaActionBarButtonTextView);
            textView.setText(R.string.string_finish);
            textView.setVisibility(0);
            textView.setOnClickListener(this);
            this.i = findViewById(R.id.loadingProgressBar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void G() {
        try {
            this.k = new a(this);
            this.e.setAdapter((ListAdapter) this.k);
            this.k.a(this);
            g("");
            if (this.j != null) {
                this.k.a(this.j);
                this.k.notifyDataSetChanged();
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, OlaVenueEntity olaVenueEntity, OlaCheckInActionEntity olaCheckInActionEntity, b bVar) {
        o = olaCheckInActionEntity;
        n = olaVenueEntity;
        m = bVar;
        Intent intent = new Intent(context, (Class<?>) OlaCheckInSelectOrCreateItemActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(String str, final OlaCheckInActionEntity olaCheckInActionEntity, final OlaCheckInItemEntity olaCheckInItemEntity) {
        c(true);
        OlaApplication.b.a(olaCheckInActionEntity.a(), str, olaCheckInItemEntity.a(), new chat.ola.vn.p.a() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.8
            @Override // chat.ola.vn.p.a
            public void a(OlaCheckInItemEntity olaCheckInItemEntity2) {
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

            @Override // chat.ola.vn.p.a
            public void a(List<g> list, long j) {
            }

            @Override // chat.ola.vn.p.a
            public void a(short s, String str2) {
                if (OlaCheckInSelectOrCreateItemActivity.m != null) {
                    OlaCheckInSelectOrCreateItemActivity.m.m_();
                }
            }

            @Override // chat.ola.vn.p.a
            public void b(OlaVenueEntity olaVenueEntity) {
            }

            @Override // chat.ola.vn.p.a
            public void b(List<OlaVenueEntity> list, int i) {
            }

            @Override // chat.ola.vn.p.a
            public void c(List<OlaCheckInActionEntity> list) {
            }

            @Override // chat.ola.vn.p.a
            public void c(List<OlaCheckInItemEntity> list, int i) {
            }

            @Override // chat.ola.vn.p.a
            public void f(String str2) {
                OlaCheckInSelectOrCreateItemActivity.this.c(false);
                if (OlaCheckInSelectOrCreateItemActivity.m != null) {
                    OlaCheckInSelectOrCreateItemActivity.m.a(str2, OlaCheckInSelectOrCreateItemActivity.n, olaCheckInActionEntity, olaCheckInItemEntity);
                }
                OlaCheckInSelectOrCreateItemActivity.this.finish();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (this.p == null) {
            this.p = new Runnable() { // from class: chat.ola.vn.checkin.OlaCheckInSelectOrCreateItemActivity.7
                @Override // java.lang.Runnable
                public void run() {
                    OlaCheckInSelectOrCreateItemActivity.this.c(false);
                }
            };
        }
        OlaApplication.c(this.p);
        if (!z) {
            this.i.setVisibility(8);
        } else {
            this.i.setVisibility(0);
            OlaApplication.a(this.p, 30000L);
        }
    }

    private void g(String str) {
        try {
            c(true);
            if (OlaApplication.b != null) {
                OlaApplication.b.a(str, o.a(), this.l, this);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(String str) {
        OlaCheckInItemEntity olaCheckInItemEntityI = i(str);
        if (olaCheckInItemEntityI != null) {
            a(n.b(), o, olaCheckInItemEntityI);
        } else {
            c(true);
            OlaApplication.b.b(str, (String) null, o.a(), this);
        }
    }

    private OlaCheckInItemEntity i(String str) {
        if (str == null) {
            return null;
        }
        for (int i = 0; i < this.k.getCount(); i++) {
            try {
                OlaCheckInItemEntity item = this.k.getItem(i);
                if (m.b(item.b(), str)) {
                    return item;
                }
            } catch (Throwable unused) {
            }
        }
        return null;
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
        a(n.b(), o, olaCheckInItemEntity);
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(chat.ola.vn.entity.o oVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(y yVar) {
        c(false);
    }

    @Override // chat.ola.vn.p.a
    public void a(List<g> list, long j) {
    }

    @Override // chat.ola.vn.p.a
    public void a(short s, String str) {
        if (s == 2) {
            this.l = 0;
        }
        c(false);
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        g(this.f.getText().toString());
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInItemEntity> list, int i) {
        try {
            c(false);
            if (this.j == null) {
                this.j = new ArrayList(0);
            }
            Iterator<OlaCheckInItemEntity> it2 = list.iterator();
            while (it2.hasNext()) {
                this.j.add(it2.next());
            }
            this.k.a(this.j);
            this.k.notifyDataSetChanged();
            this.l = i;
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.a
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

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == R.id.olaActionBarBackViewLayout) {
            finish();
        } else {
            if (id != R.id.olaActionBarButtonTextView) {
                return;
            }
            h(this.f.getText().toString());
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.check_in_select_or_create_item_activity);
        F();
        try {
            if (o != null) {
                if (!m.a(o.d())) {
                    this.f.setHint(o.d());
                    this.h.setText(o.d());
                }
                try {
                    if (o.e()) {
                        this.g.setVisibility(0);
                    } else {
                        this.g.setVisibility(8);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                this.j = new ArrayList(o.f());
            }
        } catch (Throwable unused) {
        }
        G();
    }
}
