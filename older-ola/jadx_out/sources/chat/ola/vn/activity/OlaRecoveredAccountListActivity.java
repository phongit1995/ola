package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c;
import chat.ola.vn.c.t;
import chat.ola.vn.i.i;
import chat.ola.vn.network.a.a.ai;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.f;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.view.OlaCachedImageView;
import com.mg.ola.common.d.g;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaRecoveredAccountListActivity extends c implements View.OnClickListener, AdapterView.OnItemClickListener, ai.a {
    private static String g;
    private static List<String> h;
    private static int k;
    private ListView e;
    private a f;
    private View i;
    private Runnable j;

    private class a extends j<String> {
        private List<String> b;
        private LayoutInflater c;

        public a(Context context) {
            super(context);
            this.c = LayoutInflater.from(context);
        }

        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r6v1 */
        /* JADX WARN: Type inference failed for: r6v2 */
        /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.activity.OlaRecoveredAccountListActivity$b] */
        /* JADX WARN: Type inference failed for: r6v4, types: [chat.ola.vn.activity.OlaRecoveredAccountListActivity$b] */
        /* JADX WARN: Type inference failed for: r6v5 */
        /* JADX WARN: Type inference failed for: r7v1 */
        /* JADX WARN: Type inference failed for: r7v2, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r7v5 */
        /* JADX WARN: Type inference failed for: r7v6 */
        /* JADX WARN: Type inference failed for: r7v7, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r7v8, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r7v9 */
        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            ?? Inflate;
            try {
                if (view == 0) {
                    Inflate = this.c.inflate(R.layout.link_facebook_account_item, viewGroup, false);
                    try {
                        ?? bVar = new b();
                        bVar.a(Inflate);
                        view = bVar;
                        Inflate = Inflate;
                    } catch (Throwable th) {
                        th = th;
                        th.printStackTrace();
                        return Inflate;
                    }
                } else {
                    Inflate = view;
                    view = (b) view.getTag();
                }
                view.a(this.b.get(i));
                return Inflate;
            } catch (Throwable th2) {
                th = th2;
                Inflate = view;
            }
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public String getItem(int i) {
            try {
                if (this.b != null) {
                    return this.b.get(i);
                }
                return null;
            } catch (Throwable unused) {
                return null;
            }
        }

        public void a(List<String> list) {
            this.b = list;
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                if (this.b != null) {
                    return this.b.size();
                }
                return 0;
            } catch (Throwable unused) {
                return 0;
            }
        }
    }

    private class b {
        private View b;
        private String c;
        private OlaCachedImageView d;
        private TextView e;

        private b() {
        }

        private void a() {
            try {
                if (this.d != null) {
                    t.a().a(this.c, false, this.d);
                }
            } catch (Throwable unused) {
            }
        }

        public void a(View view) {
            try {
                this.b = view;
                this.d = (OlaCachedImageView) view.findViewById(R.id.imgContactPhoto);
                this.e = (TextView) view.findViewById(R.id.txtNickOla);
                this.b.setTag(this);
            } catch (Throwable unused) {
            }
        }

        public void a(String str) {
            try {
                this.c = str;
                a();
                this.e.setText(str);
            } catch (Throwable unused) {
            }
        }
    }

    private void B() {
        this.e = (ListView) findViewById(R.id.accountListView);
        this.i = findViewById(R.id.wattingProgressBar);
        findViewById(R.id.backView).setOnClickListener(this);
        findViewById(R.id.actionBarView).setOnClickListener(this);
        if (k > 0) {
            ((TextView) findViewById(R.id.txtActionTitle)).setText(k);
        }
        this.f = new a(this);
        this.f.a(h);
        this.e.setAdapter((ListAdapter) this.f);
        this.e.setOnItemClickListener(this);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C() {
        if (g.a(this) && n.b(this)) {
            chat.ola.vn.util.b.c(this, "1900588883");
        } else {
            i.b(this, getString(R.string.dialog_title_inform), getString(R.string.message_tip_to_call_cse, new Object[]{"1900588883"}));
        }
    }

    public static void a(Activity activity, String str, List<String> list) {
        a(activity, str, list, 0);
    }

    public static void a(Activity activity, String str, List<String> list, int i) {
        g = str;
        h = list;
        k = i;
        Intent intent = new Intent(activity, (Class<?>) OlaRecoveredAccountListActivity.class);
        intent.addFlags(131072);
        activity.startActivityForResult(intent, 7);
        try {
            activity.overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void c(boolean z) {
        try {
            if (this.j == null) {
                this.j = new Runnable() { // from class: chat.ola.vn.activity.OlaRecoveredAccountListActivity.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            i.a(OlaRecoveredAccountListActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout, R.string.button_support, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaRecoveredAccountListActivity.2.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    if (i == 0) {
                                        try {
                                            OlaRecoveredAccountListActivity.this.C();
                                        } catch (Throwable unused) {
                                            return;
                                        }
                                    }
                                    dialogInterface.dismiss();
                                }
                            });
                            OlaRecoveredAccountListActivity.this.i.setVisibility(8);
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.j);
            if (!z) {
                this.i.setVisibility(8);
            } else {
                this.i.setVisibility(0);
                OlaApplication.a(this.j, 60000L);
            }
        } catch (Throwable unused) {
        }
    }

    private void f(String str, String str2) {
        try {
            OlaTutorialActivity.e = true;
            OlaTutorialActivity.f = true;
            OlaBottomTabActivity.g = false;
            Intent intent = new Intent();
            intent.putExtra("_username", str);
            intent.putExtra("_pass", str2);
            setResult(-1, intent);
            finish();
        } catch (Throwable unused) {
        }
        try {
            f.a().c("Reset Pass OK");
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.network.a.a.ai.a
    public void a_(String str, String str2) {
        c(false);
        f(str, str2);
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // chat.ola.vn.network.a.a.ai.a
    public void c_() {
        c(false);
        i.a(this, R.string.dialog_title_fail, R.string.message_fail_recover_password, R.string.button_support, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaRecoveredAccountListActivity.1
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                try {
                    dialogInterface.dismiss();
                    if (i != 0) {
                        OlaRecoveredAccountListActivity.this.finish();
                    } else {
                        OlaRecoveredAccountListActivity.this.C();
                    }
                } catch (Throwable unused) {
                }
            }
        });
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
            if (view.getId() != R.id.backView) {
                return;
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_recovered_account_list_layout);
        B();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            c(true);
            String str = h.get(i);
            if (m.a(str)) {
                return;
            }
            OlaApplication.b.a(str, g, this);
        } catch (Throwable unused) {
        }
    }
}
