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
import chat.ola.vn.c;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.y;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInChooseActionActivity extends c implements View.OnClickListener, chat.ola.vn.p.a {
    private static OlaVenueEntity k;
    private static b l;
    private ListView e;
    private chat.ola.vn.b.c f;
    private List<OlaCheckInActionEntity> g;
    private View h;
    private EditText i;
    private OlaCheckInActionEntity j;

    private void D() {
        try {
            this.e = (ListView) findViewById(R.id.lvCheckInActions);
            this.h = findViewById(R.id.loadingProgressBar);
            this.i = (EditText) findViewById(R.id.searchEditText);
            this.i.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.1
                @Override // android.view.View.OnFocusChangeListener
                public void onFocusChange(View view, boolean z) {
                    OlaCheckInChooseActionActivity olaCheckInChooseActionActivity;
                    try {
                        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) OlaCheckInChooseActionActivity.this.i.getLayoutParams();
                        if (z) {
                            layoutParams.width = 0;
                            layoutParams.weight = 1.0f;
                            olaCheckInChooseActionActivity = OlaCheckInChooseActionActivity.this;
                        } else {
                            layoutParams.width = -2;
                            layoutParams.weight = 0.0f;
                            olaCheckInChooseActionActivity = OlaCheckInChooseActionActivity.this;
                        }
                        olaCheckInChooseActionActivity.i.setLayoutParams(layoutParams);
                    } catch (Throwable unused) {
                    }
                }
            });
            findViewById(R.id.searchViewLayout).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    try {
                        OlaCheckInChooseActionActivity.this.i.requestFocus();
                        o.a((Context) OlaCheckInChooseActionActivity.this, (View) OlaCheckInChooseActionActivity.this.i, true);
                    } catch (Throwable unused) {
                    }
                }
            });
            this.i.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.3
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        OlaCheckInChooseActionActivity.this.f.getFilter().filter(editable);
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
            this.i.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.4
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (i == 3) {
                        try {
                            OlaCheckInChooseActionActivity.this.E();
                            o.a((Context) OlaCheckInChooseActionActivity.this, (View) OlaCheckInChooseActionActivity.this.i, false);
                            return true;
                        } catch (Throwable unused) {
                        }
                    }
                    return false;
                }
            });
            findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_what_are_you_doing);
            TextView textView = (TextView) findViewById(R.id.olaActionBarButtonTextView);
            textView.setText(R.string.string_finish);
            textView.setOnClickListener(this);
            this.e.setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.5
                @Override // android.view.View.OnTouchListener
                @SuppressLint({"ClickableViewAccessibility"})
                public boolean onTouch(View view, MotionEvent motionEvent) {
                    o.a((Context) OlaCheckInChooseActionActivity.this, (View) OlaCheckInChooseActionActivity.this.i, false);
                    return false;
                }
            });
            this.e.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.6
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        OlaCheckInChooseActionActivity.this.j = OlaCheckInChooseActionActivity.this.f.getItem(i);
                        OlaCheckInChooseActionActivity.this.a(OlaCheckInChooseActionActivity.this.j);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void E() {
        try {
            String string = this.i.getText().toString();
            int count = this.f.getCount();
            for (int i = 0; i < count; i++) {
                OlaCheckInActionEntity item = this.f.getItem(i);
                if (m.b(item.b(), string)) {
                    a(item);
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    private void F() {
        try {
            this.f = new chat.ola.vn.b.c(this);
            c(true);
            g("");
            this.e.setAdapter((ListAdapter) this.f);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, OlaVenueEntity olaVenueEntity, b bVar) {
        try {
            k = olaVenueEntity;
            l = bVar;
            Intent intent = new Intent(context, (Class<?>) OlaCheckInChooseActionActivity.class);
            intent.addFlags(131072);
            context.startActivity(intent);
            try {
                ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
            } catch (Throwable unused) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(OlaCheckInActionEntity olaCheckInActionEntity) {
        if (olaCheckInActionEntity.e() || !(olaCheckInActionEntity.f() == null || olaCheckInActionEntity.f().size() == 0)) {
            OlaCheckInSelectOrCreateItemActivity.a(this, k, olaCheckInActionEntity, new b() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.7
                @Override // chat.ola.vn.checkin.b
                public void a(String str, OlaVenueEntity olaVenueEntity, OlaCheckInActionEntity olaCheckInActionEntity2, OlaCheckInItemEntity olaCheckInItemEntity) {
                    OlaCheckInChooseActionActivity.this.c(false);
                    if (OlaCheckInChooseActionActivity.l != null) {
                        OlaCheckInChooseActionActivity.l.a(str, OlaCheckInChooseActionActivity.k, olaCheckInActionEntity2, olaCheckInItemEntity);
                    }
                    OlaCheckInChooseActionActivity.this.finish();
                }

                @Override // chat.ola.vn.checkin.b
                public void m_() {
                }
            });
        } else {
            a(k.b(), olaCheckInActionEntity, (OlaCheckInItemEntity) null);
            finish();
        }
    }

    private void a(String str, final OlaCheckInActionEntity olaCheckInActionEntity, final OlaCheckInItemEntity olaCheckInItemEntity) {
        c(true);
        OlaApplication.b.a(olaCheckInActionEntity.a(), str, (String) null, new chat.ola.vn.p.a() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.8
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
                if (OlaCheckInChooseActionActivity.l != null) {
                    OlaCheckInChooseActionActivity.l.m_();
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
                OlaCheckInChooseActionActivity.this.c(false);
                if (OlaCheckInChooseActionActivity.l != null) {
                    OlaCheckInChooseActionActivity.l.a(str2, OlaCheckInChooseActionActivity.k, olaCheckInActionEntity, olaCheckInItemEntity);
                }
                OlaCheckInChooseActionActivity.this.finish();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (!z) {
            this.h.setVisibility(8);
        } else {
            this.h.setVisibility(0);
            this.h.postDelayed(new Runnable() { // from class: chat.ola.vn.checkin.OlaCheckInChooseActionActivity.9
                @Override // java.lang.Runnable
                public void run() {
                    OlaCheckInChooseActionActivity.this.c(false);
                }
            }, 30000L);
        }
    }

    private void g(String str) {
        if (OlaApplication.b != null) {
            OlaApplication.b.a(str, this);
        }
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

    @Override // chat.ola.vn.p.a
    public void a(List<g> list, long j) {
    }

    @Override // chat.ola.vn.p.a
    public void a(short s, String str) {
        c(false);
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
        try {
            this.g = list;
            this.f.a(this.g);
            this.f.notifyDataSetChanged();
            c(false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInItemEntity> list, int i) {
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

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i2 != -1 || intent == null) {
            return;
        }
        try {
            if (!intent.getBooleanExtra("extra_back_action", false)) {
                setResult(-1, intent);
                finish();
            } else {
                this.j = (OlaCheckInActionEntity) intent.getSerializableExtra("extra_check_in_action");
                this.f.getFilter().filter(this.j.b());
                this.i.setText(this.j.b());
                this.i.setSelection(this.j.b().length());
            }
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
            a(k.b(), (OlaCheckInActionEntity) null, (OlaCheckInItemEntity) null);
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.check_in_select_action_activity);
        D();
        F();
    }
}
