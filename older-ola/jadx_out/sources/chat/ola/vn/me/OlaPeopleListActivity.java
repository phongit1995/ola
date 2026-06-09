package chat.ola.vn.me;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
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
public class OlaPeopleListActivity extends chat.ola.vn.c implements View.OnClickListener, AbsListView.OnScrollListener, chat.ola.vn.f.a {
    protected String e;
    private ListView f;
    private ac g;
    private List<f> h;
    private String i;
    private View j;
    private View k;
    private boolean l;
    private TextView o;
    private boolean p;
    private String q;

    private void B() {
        Intent intent = getIntent();
        String stringExtra = intent.getStringExtra("_title");
        this.i = intent.getStringExtra("_buddy_id");
        if (stringExtra != null) {
            this.o.setText(stringExtra);
        }
        this.q = intent.getStringExtra("_action");
        if (this.q != null && !"android.intent.action.VIEW".equals(this.q)) {
            f(this.i, (String) null);
            return;
        }
        String[] stringArrayExtra = intent.getStringArrayExtra("_buddy_ids");
        if (stringArrayExtra != null) {
            this.h = new ArrayList();
            for (String str : stringArrayExtra) {
                f fVarE = h.t.e(str, (short) 0);
                if (fVarE == null) {
                    fVarE = new f(str, (short) 0);
                }
                this.h.add(fVarE);
            }
            this.g.a(this.h);
            this.g.notifyDataSetChanged();
        }
        if (this.j != null) {
            this.j.setVisibility(8);
        }
    }

    public static void a(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) OlaPeopleListActivity.class);
        intent.putExtra("_action", "ACTION_VIEW_FAN_LIST");
        intent.putExtra("_title", context.getString(R.string.string_fan));
        intent.putExtra("_buddy_id", str);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) OlaPeopleListActivity.class);
        intent.putExtra("_action", "ACTION_VIEW_FRIEND_LIST");
        intent.putExtra("_title", context.getString(R.string.string_following));
        intent.putExtra("_buddy_id", str);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void f(String str, String str2) {
        this.l = true;
        if (this.h == null) {
            this.h = new ArrayList();
        }
        if (str2 == null) {
            this.h.clear();
            if (this.j != null) {
                this.j.setVisibility(0);
            }
            this.k.setVisibility(8);
        } else {
            if (this.j != null) {
                this.j.setVisibility(8);
            }
            this.k.setVisibility(0);
        }
        e eVar = new e() { // from class: chat.ola.vn.me.OlaPeopleListActivity.1
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 41;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str3, chat.ola.vn.entity.d[] dVarArr) {
                if (i == 34) {
                    OlaPeopleListActivity.this.j.setVisibility(8);
                    OlaPeopleListActivity.this.k.setVisibility(8);
                    OlaPeopleListActivity.this.e = null;
                }
                if (OlaPeopleListActivity.this.j != null) {
                    OlaPeopleListActivity.this.j.setVisibility(8);
                }
                OlaPeopleListActivity.this.k.setVisibility(8);
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                OlaPeopleListActivity.this.a((String) objArr[1], (String[]) objArr[2]);
            }
        };
        e eVar2 = new e() { // from class: chat.ola.vn.me.OlaPeopleListActivity.2
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 69;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str3, chat.ola.vn.entity.d[] dVarArr) {
                if (i == 34) {
                    OlaPeopleListActivity.this.j.setVisibility(8);
                    OlaPeopleListActivity.this.k.setVisibility(8);
                    OlaPeopleListActivity.this.e = null;
                }
                if (OlaPeopleListActivity.this.j != null) {
                    OlaPeopleListActivity.this.j.setVisibility(8);
                }
                OlaPeopleListActivity.this.k.setVisibility(8);
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                String[] strArr = (String[]) objArr[0];
                OlaPeopleListActivity.this.a((String) objArr[1], strArr);
            }
        };
        if (m.a(this.q, "ACTION_VIEW_FAN_LIST")) {
            OlaApplication.b.c(str, str2, chat.ola.vn.entry.c.f.a(eVar));
        } else if (m.a(this.q, "ACTION_VIEW_FRIEND_LIST")) {
            OlaApplication.b.b(str, str2, chat.ola.vn.entry.c.f.a(eVar));
        } else if (m.a(this.q, "ACTION_VIEW_SUGGESTED_FRIEND_LIST")) {
            OlaApplication.b.d(str2, chat.ola.vn.entry.c.f.a(eVar2));
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    public void a(String str, String[] strArr) {
        this.l = false;
        if (strArr != null) {
            this.e = str;
            if (this.h == null) {
                this.h = new ArrayList();
            }
            for (String str2 : strArr) {
                f fVarE = h.t.e(str2, (short) 0);
                if (fVarE == null) {
                    fVarE = new f(str2, (short) 0);
                }
                this.h.add(fVarE);
            }
            this.g.a(this.h);
            this.g.notifyDataSetChanged();
            this.j.setVisibility(8);
            this.k.setVisibility(8);
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
            if (id == R.id.addFriendButton) {
                f fVar = (f) view.getTag();
                if (h.t.d(fVar.j()) == null) {
                    OlaApplication.b.a(fVar);
                } else {
                    OlaApplication.b.e(fVar.j());
                    h.t.d(fVar);
                }
                this.g.notifyDataSetChanged();
                return;
            }
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
                return;
            }
            if (id == R.id.olaActionBarTitleViewLayout) {
                this.f.smoothScrollToPosition(0);
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
        this.j = findViewById(R.id.progressBar);
        this.o = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        this.k = LayoutInflater.from(this).inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.k.setVisibility(8);
        this.f = (ListView) findViewById(R.id.lvFriendList);
        this.f.addFooterView(this.k);
        this.f.setOnScrollListener(this);
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        if (i + i2 < i3 - 5 || i2 == i3 || this.l) {
            return;
        }
        this.p = true;
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
        if (i == 0 && this.p) {
            if (!m.a(this.e)) {
                f(this.i, this.e);
            }
            this.p = false;
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        this.g = new ac(this);
        this.g.a(this);
        this.f.setAdapter((ListAdapter) this.g);
        B();
    }
}
