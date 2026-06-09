package chat.ola.vn.me;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.n;
import chat.ola.vn.h;
import chat.ola.vn.message.f;
import chat.ola.vn.p.k;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaVisitorListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a {
    private SwipeRefreshLayout l;
    private k o;
    private ListView e = null;
    private d f = null;
    private List<f> g = null;
    private String h = null;
    private boolean i = true;
    private View j = null;
    private View k = null;
    private boolean m = false;
    private boolean n = false;

    private class a extends n {
        private a() {
        }

        @Override // chat.ola.vn.entity.n
        public boolean a(Context context) {
            OlaVisitorListActivity.c(context);
            return true;
        }
    }

    private void C() {
        this.e = (ListView) findViewById(R.id.visitorListView);
        findViewById(R.id.backView).setOnClickListener(this);
        findViewById(R.id.actionBarView).setOnClickListener(this);
        this.k = findViewById(R.id.wattingProgressBar);
        this.j = getLayoutInflater().inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.j.setVisibility(4);
        this.e.addFooterView(this.j);
        this.l = (SwipeRefreshLayout) findViewById(R.id.visitorPullToRefreshLayout);
        this.l.setColorSchemeResources(R.color.colorOlaPrimary);
        this.l.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.me.OlaVisitorListActivity.1
            @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
            public void onRefresh() {
                OlaVisitorListActivity.this.h = null;
                if (m.a(OlaVisitorListActivity.this.h)) {
                    OlaVisitorListActivity.this.i = false;
                } else {
                    OlaVisitorListActivity.this.i = true;
                }
                try {
                    OlaVisitorListActivity.this.g.clear();
                } catch (Throwable unused) {
                }
                OlaVisitorListActivity.this.f.a(OlaVisitorListActivity.this.g);
                OlaVisitorListActivity.this.f.notifyDataSetChanged();
                OlaVisitorListActivity.this.n = false;
                OlaVisitorListActivity.this.a_(0);
                OlaVisitorListActivity.this.k.setVisibility(8);
                OlaVisitorListActivity.this.E();
            }
        });
    }

    private void D() {
        try {
            if (this.f == null) {
                this.f = new d(this);
                this.f.a((View.OnClickListener) this);
                this.f.a((j.a) this);
                this.e.setAdapter((ListAdapter) this.f);
            }
            if (m.a(this.h)) {
                this.i = false;
            } else {
                this.i = true;
            }
            if (this.o == null) {
                this.o = new k() { // from class: chat.ola.vn.me.OlaVisitorListActivity.2
                    @Override // chat.ola.vn.p.k
                    public void a() {
                        OlaVisitorListActivity.this.k.setVisibility(8);
                        OlaVisitorListActivity.this.j.setVisibility(4);
                        OlaVisitorListActivity.this.h = null;
                        OlaVisitorListActivity.this.i = false;
                        OlaVisitorListActivity.this.n = false;
                        OlaVisitorListActivity.this.G();
                    }

                    @Override // chat.ola.vn.p.k
                    public void a(List<f> list, String str) {
                        OlaVisitorListActivity.this.k.setVisibility(8);
                        OlaVisitorListActivity.this.j.setVisibility(4);
                        if (m.a(str) || m.b(str, OlaVisitorListActivity.this.h)) {
                            OlaVisitorListActivity.this.i = false;
                        } else {
                            OlaVisitorListActivity.this.i = true;
                            OlaVisitorListActivity.this.h = str;
                        }
                        if (OlaVisitorListActivity.this.g == null) {
                            OlaVisitorListActivity.this.g = new ArrayList();
                        }
                        if (list != null && list.size() > 0) {
                            OlaVisitorListActivity.this.g.addAll(list);
                        }
                        OlaVisitorListActivity.this.F();
                        OlaVisitorListActivity.this.f.a(OlaVisitorListActivity.this.g);
                        OlaVisitorListActivity.this.f.notifyDataSetChanged();
                        OlaVisitorListActivity.this.n = false;
                    }
                };
            }
            if (this.g == null) {
                a_(0);
            } else {
                this.f.a(this.g);
                this.f.notifyDataSetChanged();
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void E() {
        this.m = true;
        if (x.e()) {
            chat.ola.vn.util.n.a(this, chat.ola.vn.util.c.a.s);
        }
        this.l.setRefreshing(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        if (this.m && x.e()) {
            chat.ola.vn.util.n.a(this, chat.ola.vn.util.c.a.t);
        }
        this.l.setRefreshing(false);
        this.m = false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void G() {
        if (this.m && x.e()) {
            chat.ola.vn.util.n.a(this, chat.ola.vn.util.c.a.t);
        }
        this.l.setRefreshing(false);
        this.m = false;
    }

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) OlaVisitorListActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void c(Context context) {
        try {
            a(context);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.i;
    }

    @Override // chat.ola.vn.c
    protected void a() {
        D();
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            if (this.n) {
                return;
            }
            if (i == 0) {
                this.k.setVisibility(0);
                this.j.setVisibility(4);
            } else {
                this.k.setVisibility(8);
                this.j.setVisibility(0);
            }
            this.n = true;
            OlaApplication.b.a(this.h, 40, this.o);
        } catch (Throwable unused) {
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
        try {
            int id = view.getId();
            if (id == R.id.actionBarView) {
                this.e.smoothScrollToPosition(0);
                return;
            }
            if (id == R.id.addFriendButton) {
                f fVar = (f) view.getTag();
                if (h.t.d(fVar.j()) == null) {
                    OlaApplication.b.a(fVar);
                } else {
                    OlaApplication.b.e(fVar.j());
                    h.t.d(fVar);
                }
                this.f.notifyDataSetChanged();
                return;
            }
            if (id == R.id.backView) {
                finish();
            } else {
                if (id != R.id.visitorContactViewLayout) {
                    return;
                }
                c.a(this, OlaApplication.b, ((f) view.getTag()).j(), new a());
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_visitor_list_layout);
        C();
    }
}
