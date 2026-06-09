package chat.ola.vn.me;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.FrameLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.v;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.g;
import chat.ola.vn.h;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class OlaMeCommentActivity extends chat.ola.vn.c implements View.OnClickListener, AbsListView.OnScrollListener, chat.ola.vn.f.a, chat.ola.vn.r.a.d {
    private ListView e;
    private v f;
    private View g;
    private View h;
    private TextView o;
    private long p;
    private SwipeRefreshLayout q;
    private FrameLayout s;
    private String i = null;
    private boolean j = true;
    private boolean k = false;
    private boolean l = false;
    private boolean r = false;

    private void F() {
        try {
            if (this.r) {
                return;
            }
            if (x.e()) {
                n.a(this, chat.ola.vn.util.c.a.s);
            }
            this.r = !this.r;
            this.q.setRefreshing(false);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void G() {
        try {
            if (this.r) {
                if (x.e()) {
                    n.a(this, chat.ola.vn.util.c.a.t);
                }
                this.r = !this.r;
                this.q.setRefreshing(false);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(long j, long j2) {
        if (OlaApplication.b != null) {
            if (j2 == 0) {
                h.u.n();
            }
            this.g.setVisibility(0);
            this.h.setVisibility(0);
            OlaApplication.b.a(j, j2, (short) 6);
            this.l = true;
        }
    }

    public static void a(Context context, long j) {
        try {
            Intent intent = new Intent(context, (Class<?>) OlaMeCommentActivity.class);
            intent.putExtra("_me_id", j);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(long j, long j2) {
        if (OlaApplication.b != null) {
            if (j2 == 0) {
                h.u.n();
            }
            this.h.setVisibility(0);
            F();
            OlaApplication.b.a(j, j2, (short) 6);
            this.l = true;
        }
    }

    public void B() {
        this.s = (FrameLayout) findViewById(R.id.wrapMeComment);
        this.e = (ListView) findViewById(R.id.listView);
        this.e.setSelector(new ColorDrawable(0));
        this.q = (SwipeRefreshLayout) findViewById(R.id.swipeRefreshLayout);
        this.q.setColorSchemeResources(R.color.colorOlaPrimary);
        this.q.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.me.OlaMeCommentActivity.1
            @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
            public void onRefresh() {
                OlaMeCommentActivity.this.b(OlaMeCommentActivity.this.p, 0L);
            }
        });
        this.o = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        View viewInflate = LayoutInflater.from(this).inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.h = viewInflate.findViewById(R.id.wattingProgressBar);
        this.g = findViewById(R.id.progressBar);
        viewInflate.setVisibility(8);
        this.e.addFooterView(viewInflate);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
    }

    @Override // chat.ola.vn.r.a.d
    public String C() {
        if (this.i == null) {
            this.i = "chat.ola.vn.activity.MeCommentActivity" + System.currentTimeMillis();
        }
        return this.i;
    }

    @Override // chat.ola.vn.r.a.d
    public void D() {
        this.l = false;
        this.f.notifyDataSetChanged();
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

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        if (6 == s) {
            if (i != 34) {
                this.h.setVisibility(8);
                j.a(this, R.string.message_can_not_load_comment);
            } else {
                j.a(this, R.string.message_can_not_load_more);
                this.j = false;
            }
            this.g.setVisibility(8);
            this.h.setVisibility(8);
        }
    }

    public void a(Bundle bundle) {
        this.f = new v(this);
        this.f.a(new View.OnClickListener() { // from class: chat.ola.vn.me.OlaMeCommentActivity.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                chat.ola.vn.q.b.a().b(OlaMeCommentActivity.this, view);
            }
        });
        this.f.a(new View.OnLongClickListener() { // from class: chat.ola.vn.me.OlaMeCommentActivity.3
            @Override // android.view.View.OnLongClickListener
            public boolean onLongClick(View view) {
                return chat.ola.vn.q.b.a().a(OlaMeCommentActivity.this, view);
            }
        });
        this.e.setAdapter((ListAdapter) this.f);
        this.e.setOnScrollListener(this);
        if (getIntent() != null) {
            this.p = getIntent().getLongExtra("_me_id", 0L);
            if (this.p != 0) {
                this.g.setVisibility(0);
                this.h.setVisibility(8);
                h.u.n();
                a(this.p, 0L);
                return;
            }
        }
        finish();
    }

    @Override // chat.ola.vn.r.a.d
    public void a(g gVar, List<chat.ola.vn.entry.b> list) {
        if (gVar == null || gVar.g() <= 0) {
            if (this.o != null) {
                this.o.setText(R.string.string_comment_title);
            }
        } else if (this.o != null) {
            if (gVar.g() > 1) {
                this.o.setText(R.string.string_comment_plural_title);
            } else {
                this.o.setText(R.string.string_comment_title);
            }
            this.o.append(" (" + m.a(gVar.g()) + ")");
        }
        this.l = false;
        this.f.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(g gVar, List<g> list, short s) {
        if (list == null || list.isEmpty()) {
            this.j = false;
        }
        this.g.setVisibility(8);
        this.h.setVisibility(8);
        h.u.a(gVar, list);
        this.l = false;
        G();
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entry.a aVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void a(chat.ola.vn.entry.b bVar, List<chat.ola.vn.entry.b> list) {
    }

    @Override // chat.ola.vn.r.a.d
    public void a(List<chat.ola.vn.entry.b> list, List<chat.ola.vn.entry.b> list2) {
    }

    @Override // chat.ola.vn.r.a.d
    public void b(chat.ola.vn.entry.b bVar, List<chat.ola.vn.entry.b> list) {
        this.f.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.r.a.d
    public void b(List<chat.ola.vn.entry.b> list, List<chat.ola.vn.entry.b> list2) {
        this.l = false;
        this.f.notifyDataSetChanged();
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

    @Override // chat.ola.vn.r.a.d
    public void f(List<String> list) {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.r.a.d
    public void g(String str) {
    }

    @Override // chat.ola.vn.c
    public void j() {
        this.f.notifyDataSetChanged();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.olaActionBarBackViewLayout) {
                return;
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.me_comment_page_layout);
        B();
        a(bundle);
        h.u.a(this);
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        h.u.n();
        h.u.b(this);
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        if (i3 < 10) {
            this.h.setVisibility(8);
            return;
        }
        int i4 = i + i2;
        if (i3 <= 0 || i4 < i3 - 5 || i2 == i3 || !this.j) {
            return;
        }
        this.k = true;
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
        if (i == 0 && this.k) {
            if (!this.l) {
                long jP = h.u.p();
                long jO = h.u.o();
                if (jO != 0 && jP != 0) {
                    a(jO, jP);
                }
            }
            this.k = false;
        }
    }

    @Override // chat.ola.vn.c
    public FrameLayout z() {
        return this.s;
    }
}
