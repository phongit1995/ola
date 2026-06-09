package chat.ola.vn.checkin;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.Address;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.o;
import chat.ola.vn.entity.y;
import chat.ola.vn.i.i;
import chat.ola.vn.n.b;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInCreateVenueItemActivity extends c implements View.OnClickListener, chat.ola.vn.p.a {
    private static b l;
    private static String m;
    OlaVenueEntity e;
    private EditText f;
    private EditText g;
    private EditText h;
    private View i;
    private View j;
    private Animation k;

    private void C() {
        try {
            this.k = AnimationUtils.loadAnimation(this, R.anim.shake);
            this.f = (EditText) findViewById(R.id.txtVenueName);
            this.g = (EditText) findViewById(R.id.txtVenueAddress);
            this.h = (EditText) findViewById(R.id.txtVenueDescript);
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_create_venue);
            findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
            this.i = findViewById(R.id.btnCreateVenue);
            this.i.setOnClickListener(this);
            this.j = findViewById(R.id.loadingProgressBar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void D() {
        try {
            String string = this.f.getText().toString();
            String string2 = this.g.getText().toString();
            String string3 = this.h.getText().toString();
            if (m.c(string)) {
                this.f.startAnimation(this.k);
                return;
            }
            if (OlaApplication.b != null) {
                c(true);
                if (this.e == null) {
                    OlaApplication.b.a(string, (List<String>) null, string3, string2, this);
                } else {
                    OlaApplication.b.a(this.e.b(), this.e.c(), (List<String>) null, this.e.d(), this.e.e(), this);
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void E() {
        try {
            if (!m.c(m)) {
                this.f.setText(m);
                this.f.setSelection(m.length());
            }
            chat.ola.vn.n.b.a(this, Double.parseDouble(chat.ola.vn.n.c.a().b()), Double.parseDouble(chat.ola.vn.n.c.a().c()), 1, new b.a() { // from class: chat.ola.vn.checkin.OlaCheckInCreateVenueItemActivity.2
                @Override // chat.ola.vn.n.b.a
                public void a() {
                }

                @Override // chat.ola.vn.n.b.a
                public void a(List<Address> list) {
                    try {
                        OlaCheckInCreateVenueItemActivity.this.g.setText(chat.ola.vn.n.b.a(list.get(0)));
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, b bVar) {
        try {
            l = bVar;
            m = str;
            Intent intent = new Intent(context, (Class<?>) OlaCheckInCreateVenueItemActivity.class);
            intent.addFlags(131072);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void c(OlaVenueEntity olaVenueEntity) {
        OlaCheckInChooseActionActivity.a(this, olaVenueEntity, new b() { // from class: chat.ola.vn.checkin.OlaCheckInCreateVenueItemActivity.3
            @Override // chat.ola.vn.checkin.b
            public void a(String str, OlaVenueEntity olaVenueEntity2, OlaCheckInActionEntity olaCheckInActionEntity, OlaCheckInItemEntity olaCheckInItemEntity) {
                OlaCheckInCreateVenueItemActivity.this.c(false);
                if (OlaCheckInCreateVenueItemActivity.l != null) {
                    OlaCheckInCreateVenueItemActivity.l.a(str, olaVenueEntity2, olaCheckInActionEntity, olaCheckInItemEntity);
                }
                OlaCheckInCreateVenueItemActivity.this.finish();
            }

            @Override // chat.ola.vn.checkin.b
            public void m_() {
                OlaCheckInCreateVenueItemActivity.this.c(false);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (!z) {
            this.j.setVisibility(8);
        } else {
            this.j.setVisibility(0);
            this.j.postDelayed(new Runnable() { // from class: chat.ola.vn.checkin.OlaCheckInCreateVenueItemActivity.1
                @Override // java.lang.Runnable
                public void run() {
                    OlaCheckInCreateVenueItemActivity.this.c(false);
                }
            }, 30000L);
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
        try {
            c(false);
            this.e = olaVenueEntity;
            c(olaVenueEntity);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.a
    public void a(o oVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(y yVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(List<g> list, long j) {
    }

    @Override // chat.ola.vn.p.a
    public void a(short s, String str) {
        if (s != 3) {
        }
        c(false);
        if (m.c(str)) {
            return;
        }
        i.b(this, null, str);
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
        try {
            c(false);
            this.e = olaVenueEntity;
            c(olaVenueEntity);
        } catch (Throwable th) {
            th.printStackTrace();
        }
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
    public void f(String str) {
        try {
            c(false);
            finish();
        } catch (Throwable th) {
            th.printStackTrace();
        }
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
        if (id == R.id.btnCreateVenue) {
            D();
        } else {
            if (id != R.id.olaActionBarBackViewLayout) {
                return;
            }
            finish();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.check_in_create_venue_activity);
        C();
        E();
    }
}
