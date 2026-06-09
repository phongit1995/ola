package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ac;
import chat.ola.vn.b.j;
import chat.ola.vn.c;
import chat.ola.vn.entity.d;
import chat.ola.vn.entity.n;
import chat.ola.vn.h;
import chat.ola.vn.message.f;
import chat.ola.vn.r.a.e;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaSuggestedFriendListActivity extends c implements View.OnClickListener, j.a {
    private ListView e = null;
    private ac f = null;
    private List<f> g = null;
    private String h = null;
    private boolean i = true;
    private boolean j = false;

    private class a extends n {
        private a() {
        }

        @Override // chat.ola.vn.entity.n
        public boolean a(Context context) {
            OlaSuggestedFriendListActivity.c(context);
            return true;
        }
    }

    private void C() {
        this.e = (ListView) findViewById(R.id.suggestedFriendListView);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_may_be_you_want_to_make_friend);
        ((ImageView) findViewById(R.id.olaActionBarBackImageView)).setImageResource(R.drawable.ic_action_back);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
    }

    private void D() {
        try {
            if (this.f == null) {
                this.f = new ac(this);
                this.f.a(true);
                this.f.a((View.OnClickListener) this);
                this.f.a((j.a) this);
                this.e.setAdapter((ListAdapter) this.f);
            }
            this.g = this.j ? h.t.y() : h.t.x();
            this.h = e.a;
            if (m.a(this.h)) {
                this.i = false;
            } else {
                this.i = true;
            }
            this.f.a(this.g);
            this.f.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        a(context, false);
    }

    public static void a(Context context, boolean z) {
        Intent intent = new Intent(context, (Class<?>) OlaSuggestedFriendListActivity.class);
        intent.addFlags(131072);
        intent.putExtra("ignorePhoneFriend", z);
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
            OlaApplication.b.d(this.h, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaSuggestedFriendListActivity.1
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 69;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i2, short s, String str, d[] dVarArr) {
                    OlaSuggestedFriendListActivity.this.i = false;
                    if (i2 == 34) {
                        OlaSuggestedFriendListActivity.this.h = null;
                    }
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        String[] strArr = (String[]) objArr[0];
                        OlaSuggestedFriendListActivity.this.h = (String) objArr[1];
                        if (m.a(OlaSuggestedFriendListActivity.this.h)) {
                            OlaSuggestedFriendListActivity.this.i = false;
                        } else {
                            OlaSuggestedFriendListActivity.this.i = true;
                        }
                        for (String str : strArr) {
                            try {
                                if (!str.startsWith("#")) {
                                    String strJ = m.j(str);
                                    if (h.t.e(strJ, (short) 0) == null) {
                                        OlaSuggestedFriendListActivity.this.g.add(new f(strJ, (short) 0));
                                    }
                                }
                            } catch (Throwable unused) {
                            }
                        }
                        OlaSuggestedFriendListActivity.this.f.a(OlaSuggestedFriendListActivity.this.g);
                        OlaSuggestedFriendListActivity.this.f.notifyDataSetChanged();
                    } catch (Throwable unused2) {
                    }
                }
            }));
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
            switch (view.getId()) {
                case R.id.addFriendButton /* 2131296305 */:
                    f fVar = (f) view.getTag();
                    if (h.t.d(fVar.j()) != null) {
                        OlaApplication.b.e(fVar.j());
                        h.t.d(fVar);
                    } else {
                        OlaApplication.b.a(fVar);
                    }
                    break;
                case R.id.ignoreSuggestedFriendButton /* 2131296852 */:
                    f fVar2 = (f) view.getTag();
                    this.g.remove(fVar2);
                    if (m.a(fVar2.p())) {
                        h.t.a(fVar2.j());
                    } else {
                        h.t.a(fVar2.j(), fVar2.p());
                    }
                    OlaApplication.b.w(fVar2.j());
                    this.f.a(this.g);
                    break;
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                    finish();
                    return;
                case R.id.olaActionBarTitleViewLayout /* 2131297188 */:
                    this.e.smoothScrollToPosition(0);
                    return;
                case R.id.suggestedContactViewLayout /* 2131297446 */:
                    chat.ola.vn.me.c.a(this, OlaApplication.b, ((f) view.getTag()).j(), new a());
                    return;
                default:
                    return;
            }
            this.f.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_suggested_friend_list_layout);
        C();
        this.j = getIntent().getBooleanExtra("ignorePhoneFriend", false);
    }
}
