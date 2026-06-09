package chat.ola.vn.checkin;

import android.os.Bundle;
import android.view.View;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.b.p;
import chat.ola.vn.c;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.o;
import chat.ola.vn.entity.y;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInNearbyPlacesActivity extends c implements View.OnClickListener, j.a, chat.ola.vn.p.a {
    private ListView e;
    private View f;
    private String g;
    private String h;
    private String i;
    private View j;
    private boolean k = false;
    private View l;
    private p m;
    private int n;
    private List<OlaVenueEntity> o;

    private void C() {
        try {
            setContentView(R.layout.check_in_nearby_vernues_activity_layout);
            this.e = (ListView) findViewById(R.id.lvCheckInItems);
            this.f = findViewById(R.id.progressBar);
            this.j = findViewById(R.id.imgBack);
            this.l = findViewById(R.id.imgIcon);
            findViewById(R.id.btnClose).setOnClickListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void D() {
        try {
            this.g = getIntent().getStringExtra("longitude");
            this.h = getIntent().getStringExtra("latitude");
            this.i = getIntent().getStringExtra("venueId");
            a(this.g, this.h, 0);
            this.m = new p(this);
            this.m.a((j.a) this);
            this.m.a((View.OnClickListener) this);
            this.e.setAdapter((ListAdapter) this.m);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(String str, String str2, int i) {
        try {
            if (!m.c(str) && !m.c(str2)) {
                c(true);
                if (OlaApplication.b != null) {
                    OlaApplication.b.a((String) null, str, str2, i, this);
                    return;
                }
                return;
            }
            c(false);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void c(boolean z) {
        try {
            if (z) {
                this.f.setVisibility(0);
            } else {
                this.f.setVisibility(8);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.n > 0;
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
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        a(this.g, this.h, this.n);
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
        if (list != null) {
            try {
                if (this.n == 0) {
                    int i2 = 0;
                    while (true) {
                        if (i2 >= list.size()) {
                            break;
                        }
                        if (m.b(this.i, list.get(i2).b())) {
                            list.remove(i2);
                            break;
                        }
                        i2++;
                    }
                    this.o = new ArrayList(list);
                } else {
                    if (this.o == null) {
                        this.o = new ArrayList(0);
                    }
                    ArrayList arrayList = new ArrayList(list);
                    int i3 = 0;
                    while (i3 < list.size()) {
                        if (m.b(this.i, ((OlaVenueEntity) arrayList.get(i3)).b())) {
                            i3--;
                            arrayList.remove(i3);
                        } else {
                            this.o.add((OlaVenueEntity) arrayList.get(i3));
                        }
                        i3++;
                    }
                }
                this.m.a(this.o);
                this.m.notifyDataSetChanged();
                this.n = i;
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
        c(false);
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
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
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.btnClose /* 2131296446 */:
                case R.id.imgBack /* 2131296867 */:
                case R.id.imgIcon /* 2131296892 */:
                    finish();
                    break;
                case R.id.btnDetail /* 2131296454 */:
                case R.id.vLinearCheckInInfo /* 2131297738 */:
                    OlaVenueDetailActivity.a(this, ((OlaVenueEntity) view.getTag()).b());
                    overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        C();
        D();
        try {
            this.k = getIntent().getBooleanExtra("showBackButton", false);
            if (this.j != null) {
                if (!this.k) {
                    this.j.setVisibility(8);
                    return;
                }
                this.j.setVisibility(0);
                this.j.setOnClickListener(this);
                this.l.setOnClickListener(this);
            }
        } catch (Throwable unused) {
        }
    }
}
