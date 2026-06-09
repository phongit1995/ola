package chat.ola.vn.message;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaChatBlockedListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a {
    private ListView e = null;
    private b f = null;
    private List<f> g = null;
    private String h = null;
    private View i = null;
    private View j = null;

    private void C() {
        this.e = (ListView) findViewById(R.id.blockedListView);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_block_list);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        TextView textView = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        textView.setText(R.string.string_unblock_all);
        textView.setVisibility(0);
        textView.setOnClickListener(this);
        this.j = findViewById(R.id.wattingProgressBar);
        this.i = getLayoutInflater().inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.i.setVisibility(4);
        this.e.addFooterView(this.i);
    }

    private void D() {
        try {
            if (this.f == null) {
                this.f = new b(this);
                this.f.a((View.OnClickListener) this);
                this.f.a((j.a) this);
                this.e.setAdapter((ListAdapter) this.f);
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

    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaChatBlockedListActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !chat.ola.vn.util.m.b(this.h, "null");
    }

    @Override // chat.ola.vn.c
    protected void a() {
        D();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        super.a(i, str, bArr, dVarArr, s);
        if (s == 77) {
            this.j.setVisibility(8);
            this.h = "null";
            this.i.setVisibility(4);
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, String[] strArr, short s) {
        this.h = str;
        this.j.setVisibility(8);
        if (chat.ola.vn.util.m.a(str) || strArr == null || strArr.length == 0) {
            this.h = "null";
            this.i.setVisibility(4);
        }
        if (strArr == null || strArr.length <= 0) {
            return;
        }
        if (this.g == null) {
            this.g = new ArrayList(1000);
            this.f.a(this.g);
        }
        for (String str2 : strArr) {
            f fVarD = chat.ola.vn.h.t.d(str2);
            if (fVarD == null) {
                fVarD = new f(str2, (short) 0);
            }
            this.g.add(fVarD);
        }
        this.f.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            if (i == 0) {
                this.j.setVisibility(0);
                this.i.setVisibility(4);
            } else {
                this.j.setVisibility(8);
                this.i.setVisibility(0);
            }
            OlaApplication.b.c(this.h, (short) 77);
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
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                    finish();
                    break;
                case R.id.olaActionBarButtonTextView /* 2131297182 */:
                    chat.ola.vn.i.i.a(this, R.string.string_unblock_all, R.string.message_do_you_want_to_unblock_all_people, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.message.OlaChatBlockedListActivity.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            dialogInterface.dismiss();
                            if (i != 0) {
                                return;
                            }
                            try {
                                OlaApplication.b.q();
                                OlaChatBlockedListActivity.this.finish();
                            } catch (Throwable unused) {
                            }
                        }
                    });
                    break;
                case R.id.olaActionBarTitleViewLayout /* 2131297188 */:
                    this.e.smoothScrollToPosition(0);
                    break;
                case R.id.unblockedButton /* 2131297720 */:
                    f fVar = (f) view.getTag();
                    OlaApplication.b.n(fVar.j());
                    this.g.remove(fVar);
                    this.f.notifyDataSetChanged();
                    chat.ola.vn.util.j.c(this, getString(R.string.message_unblocked_nick_format, new Object[]{fVar.j()}));
                    break;
                case R.id.visitorContactViewLayout /* 2131297786 */:
                    chat.ola.vn.me.c.a(OlaApplication.a(), OlaApplication.b, ((f) view.getTag()).j(), (chat.ola.vn.entity.n) null);
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_blocked_list_layout);
        C();
    }
}
