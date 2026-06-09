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
public class OlaMeLikerListActivity extends chat.ola.vn.c implements View.OnClickListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, chat.ola.vn.f.a {
    protected String e;
    protected String f;
    private ListView g;
    private ac h;
    private View i;
    private View j;
    private TextView k;
    private List<f> l;
    private long o;
    private int p;
    private boolean q;

    private void B() {
        TextView textView;
        Object[] objArr;
        this.i.setVisibility(0);
        if (OlaApplication.b == null) {
            return;
        }
        this.o = getIntent().getLongExtra("_me_id", 0L);
        this.p = getIntent().getIntExtra("me_like_count", 0);
        if (this.p > 0) {
            textView = this.k;
            objArr = new Object[]{m.a(this.p)};
        } else {
            textView = this.k;
            objArr = new Object[]{""};
        }
        textView.setText(getString(R.string.string_like_friend_list, objArr));
        if (this.o != 0) {
            b(this.o, (String) null);
        }
    }

    public static void a(Context context, int i, long j) {
        Intent intent = new Intent(context, (Class<?>) OlaMeLikerListActivity.class);
        intent.putExtra("_me_id", j);
        intent.putExtra("me_like_count", i);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void b(long j, String str) {
        if (!(str == null && this.f == null) && m.b(str, this.f)) {
            return;
        }
        this.f = str;
        this.q = true;
        if (this.l == null) {
            this.l = new ArrayList();
            this.h.a(this.l);
        }
        if (str == null) {
            this.l.clear();
            this.j.setVisibility(8);
            this.i.setVisibility(0);
        } else {
            this.j.setVisibility(0);
            this.i.setVisibility(8);
        }
        OlaApplication.b.b(j, str, chat.ola.vn.entry.c.f.a(new e() { // from class: chat.ola.vn.me.OlaMeLikerListActivity.1
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 40;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str2, chat.ola.vn.entity.d[] dVarArr) {
                if (i == 34) {
                    OlaMeLikerListActivity.this.e = null;
                    OlaMeLikerListActivity.this.f = null;
                }
                OlaMeLikerListActivity.this.i.setVisibility(8);
                OlaMeLikerListActivity.this.j.setVisibility(8);
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                OlaMeLikerListActivity.this.a(((Long) objArr[0]).longValue(), (String) objArr[1], (String[]) objArr[2]);
            }
        }));
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    public void a(long j, String str, String[] strArr) {
        this.q = false;
        if (this.l == null) {
            this.l = new ArrayList();
            this.h.a(this.l);
        }
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
            b(this.o, this.e);
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
