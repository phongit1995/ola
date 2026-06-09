package chat.ola.vn.me;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ac;
import chat.ola.vn.entity.n;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.h;
import chat.ola.vn.message.f;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaAdMeLikeListActivity extends chat.ola.vn.c implements View.OnClickListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, chat.ola.vn.f.a {
    protected String e;
    protected String f;
    private ListView g;
    private ac h;
    private View i;
    private View j;
    private TextView k;
    private List<f> l;
    private int o;
    private String p;
    private boolean q;

    private void B() {
        TextView textView;
        Object[] objArr;
        this.i.setVisibility(0);
        this.p = getIntent().getStringExtra("_adme_id");
        this.o = getIntent().getIntExtra("me_like_count", 0);
        if (this.o > 0) {
            textView = this.k;
            objArr = new Object[]{m.a(this.o)};
        } else {
            textView = this.k;
            objArr = new Object[]{""};
        }
        textView.setText(getString(R.string.string_like_friend_list, objArr));
        if (m.a(this.p)) {
            return;
        }
        f(this.p, (String) null);
    }

    public static void a(Context context, String str, int i) {
        Intent intent = new Intent(context, (Class<?>) OlaAdMeLikeListActivity.class);
        intent.putExtra("_adme_id", str);
        intent.putExtra("me_like_count", i);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void f(String str, String str2) {
        if (!(str2 == null && this.f == null) && m.b(str2, this.f)) {
            return;
        }
        this.f = str2;
        this.q = true;
        if (str2 == null) {
            this.l.clear();
            this.j.setVisibility(8);
            this.i.setVisibility(0);
            this.h.notifyDataSetChanged();
        } else {
            this.j.setVisibility(0);
            this.i.setVisibility(8);
        }
        OlaApplication.b.l(str, str2, chat.ola.vn.entry.c.f.a(new e() { // from class: chat.ola.vn.me.OlaAdMeLikeListActivity.1
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 67;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str3, chat.ola.vn.entity.d[] dVarArr) {
                if (i == 34) {
                    try {
                        OlaAdMeLikeListActivity.this.e = null;
                        OlaAdMeLikeListActivity.this.f = null;
                    } catch (Throwable unused) {
                        return;
                    }
                }
                OlaAdMeLikeListActivity.this.i.setVisibility(8);
                OlaAdMeLikeListActivity.this.j.setVisibility(8);
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                try {
                    String str3 = (String) objArr[1];
                    String[] strArr = (String[]) objArr[2];
                    if (strArr != null && strArr.length > 0) {
                        OlaAdMeLikeListActivity.this.a(str3, strArr);
                        return;
                    }
                    OlaAdMeLikeListActivity.this.e = null;
                    OlaAdMeLikeListActivity.this.f = null;
                    OlaAdMeLikeListActivity.this.i.setVisibility(8);
                    OlaAdMeLikeListActivity.this.j.setVisibility(8);
                } catch (Throwable unused) {
                    OlaAdMeLikeListActivity.this.e = null;
                    OlaAdMeLikeListActivity.this.f = null;
                    OlaAdMeLikeListActivity.this.i.setVisibility(8);
                    OlaAdMeLikeListActivity.this.j.setVisibility(8);
                }
            }
        }));
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    public void a(String str, String[] strArr) {
        this.q = false;
        if (strArr != null && strArr.length > 0) {
            for (String str2 : strArr) {
                f fVarE = h.t.e(str2, (short) 0);
                if (fVarE == null) {
                    fVarE = new f(str2, (short) 0);
                }
                this.l.add(fVarE);
            }
        }
        this.h.a(this.l);
        this.h.notifyDataSetChanged();
        this.e = str;
        this.i.setVisibility(8);
        this.j.setVisibility(8);
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
            if (id == R.id.addFriendButton) {
                f fVar = (f) view.getTag();
                if (h.t.d(fVar.j()) == null) {
                    OlaApplication.b.a(fVar);
                } else {
                    OlaApplication.b.e(fVar.j());
                    h.t.d(fVar);
                }
                this.h.notifyDataSetChanged();
                return;
            }
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
                return;
            }
            if (id == R.id.olaActionBarTitleViewLayout) {
                this.g.smoothScrollToPosition(0);
            } else {
                if (id != R.id.suggestedContactViewLayout) {
                    return;
                }
                c.a(this, OlaApplication.b, ((f) view.getTag()).j(), (n) null);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.friend_list_dialog);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        this.i = findViewById(R.id.progressBar);
        this.k = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.j = LayoutInflater.from(this).inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.j.setVisibility(8);
        this.g = (ListView) findViewById(R.id.lvFriendList);
        this.g.setVerticalScrollBarEnabled(false);
        this.g.addFooterView(this.j);
        this.g.setOnItemClickListener(this);
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            c.a(this, OlaApplication.b, this.h.getItem(i).j());
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        if (i + i2 < i3 - 5 || i2 == i3) {
            return;
        }
        try {
            if (this.q || this.h.getCount() <= 0 || m.a(this.e)) {
                return;
            }
            f(this.p, this.e);
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        this.g.setOnScrollListener(this);
        this.h = new ac(this);
        this.h.a(this);
        this.l = new ArrayList();
        this.h.a(this.l);
        this.g.setAdapter((ListAdapter) this.h);
        B();
    }
}
