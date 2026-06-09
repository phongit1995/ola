package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.c;
import chat.ola.vn.c.t;
import chat.ola.vn.entity.ag;
import chat.ola.vn.f;
import chat.ola.vn.h;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.p.d;
import chat.ola.vn.p.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;

/* JADX INFO: loaded from: classes.dex */
public class OlaAddContactActivity extends c implements View.OnClickListener, i {
    private OlaQuickTypingSuggestedText e;
    private q f;
    private View g;
    private View h;
    private Button i;
    private TextView j;
    private TextView k;
    private OlaCachedImageView l;

    private void B() {
        this.h = findViewById(R.id.contactSummaryViewLayout);
        this.h.setVisibility(8);
        this.h.setOnClickListener(this);
        findViewById(R.id.listViewBottomDividerView).setVisibility(8);
        findViewById(R.id.ignoreSuggestedFriendButton).setVisibility(8);
        this.i = (Button) findViewById(R.id.addFriendButton);
        this.i.setOnClickListener(this);
        this.j = (TextView) findViewById(R.id.phoneNumberTextView);
        this.k = (TextView) findViewById(R.id.txtNickOla);
        this.l = (OlaCachedImageView) findViewById(R.id.imgContactPhoto);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C() {
        try {
            this.h.setVisibility(8);
            String strJ = m.j(this.e.getText().toString());
            boolean zT = h.O.x ? m.t(strJ) : false;
            if (zT) {
                c(true);
                OlaApplication.b.a(strJ, new String[]{"name"}, new d() { // from class: chat.ola.vn.activity.OlaAddContactActivity.3
                    @Override // chat.ola.vn.p.d
                    public void a(int i) {
                        OlaAddContactActivity olaAddContactActivity;
                        int i2;
                        try {
                            OlaAddContactActivity.this.c(false);
                            if (i != 1) {
                                OlaAddContactActivity.this.e.selectAll();
                                olaAddContactActivity = OlaAddContactActivity.this;
                                i2 = R.string.string_buddy_is_not_exist;
                            } else {
                                OlaAddContactActivity.this.e.selectAll();
                                olaAddContactActivity = OlaAddContactActivity.this;
                                i2 = R.string.message_fail_phone_number_invalid;
                            }
                            chat.ola.vn.i.i.a(olaAddContactActivity, R.string.dialog_title_inform, i2);
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        try {
                            OlaAddContactActivity.this.c(false);
                            OlaAddContactActivity.this.f(agVar.c, agVar.f);
                        } catch (Throwable unused) {
                        }
                    }
                });
            } else {
                c(true);
                OlaApplication.b.a(strJ, this);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaAddContactActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void f(String str) {
        Button button;
        int i;
        try {
            if (m.b(h.a(), str)) {
                this.i.setVisibility(8);
                return;
            }
            this.h.setTag(str);
            this.i.setTag(str);
            this.i.setVisibility(0);
            if (h.t.c(str)) {
                this.i.setBackgroundResource(R.drawable.btn_default_button_selector);
                this.i.setText(R.string.string_already_friend);
                this.i.setTextColor(f.z);
                button = this.i;
                i = R.drawable.ic_checked;
            } else {
                this.i.setBackgroundResource(R.drawable.btn_green_button_selector);
                this.i.setText(R.string.string_make_friend);
                this.i.setTextColor(f.C);
                button = this.i;
                i = R.drawable.ic_action_add_small;
            }
            button.setCompoundDrawablesWithIntrinsicBounds(i, 0, 0, 0);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f(String str, String str2) {
        this.h.setVisibility(0);
        this.k.setText(str);
        if (m.a(str2)) {
            this.j.setVisibility(8);
        } else {
            this.j.setVisibility(0);
            this.j.setText(str2);
        }
        t.a().a(str, false, this.l);
        f(str);
        try {
            o.a((Context) this, (View) this.e, false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.p.i
    public void a(String str, boolean z) {
        try {
            c(false);
            if (z) {
                f(str, (String) null);
            } else {
                this.e.selectAll();
                chat.ola.vn.i.i.a(this, R.string.dialog_title_inform, R.string.string_buddy_is_not_exist);
            }
        } catch (Throwable unused) {
        }
    }

    public void c(boolean z) {
        this.g.setVisibility(z ? 0 : 8);
        this.g.postDelayed(new Runnable() { // from class: chat.ola.vn.activity.OlaAddContactActivity.4
            @Override // java.lang.Runnable
            public void run() {
                if (OlaAddContactActivity.this.g.getVisibility() == 0) {
                    OlaAddContactActivity.this.g.setVisibility(8);
                }
            }
        }, 60000L);
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
                String str = (String) view.getTag();
                if (h.t.d(str) != null) {
                    return;
                } else {
                    OlaApplication.b.d(str);
                }
            } else if (id == R.id.contactSummaryViewLayout) {
                OlaUserMePageActivity.a(this, (String) view.getTag());
                return;
            } else if (id != R.id.olaActionBarBackViewLayout) {
                if (id != R.id.performAddFriendButton) {
                    return;
                }
                C();
                return;
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        OlaQuickTypingSuggestedText olaQuickTypingSuggestedText;
        int i;
        super.onCreate(bundle);
        setContentView(R.layout.ola_add_contact_layout);
        this.g = findViewById(R.id.progressBarViewLayout);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_add_friend);
        TextView textView = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        textView.setText(R.string.string_cancel);
        textView.setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        this.e = (OlaQuickTypingSuggestedText) findViewById(R.id.searchSuggestedText);
        try {
            if (h.O.x) {
                olaQuickTypingSuggestedText = this.e;
                i = R.string.string_enter_nick_name_or_phone_number;
            } else {
                olaQuickTypingSuggestedText = this.e;
                i = R.string.string_enter_nick_name;
            }
            olaQuickTypingSuggestedText.setHint(i);
        } catch (Throwable unused) {
        }
        findViewById(R.id.performAddFriendButton).setOnClickListener(this);
        this.e.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.OlaAddContactActivity.1
            /* JADX WARN: Removed duplicated region for block: B:5:0x000a  */
            @Override // android.widget.TextView.OnEditorActionListener
            /*
                Code decompiled incorrectly, please refer to instructions dump.
                To view partially-correct add '--show-bad-code' argument
            */
            public boolean onEditorAction(android.widget.TextView r1, int r2, android.view.KeyEvent r3) {
                /*
                    r0 = this;
                    if (r3 == 0) goto La
                    int r1 = r3.getKeyCode()     // Catch: java.lang.Throwable -> L12
                    r3 = 66
                    if (r1 == r3) goto Ld
                La:
                    r1 = 6
                    if (r2 != r1) goto L12
                Ld:
                    chat.ola.vn.activity.OlaAddContactActivity r1 = chat.ola.vn.activity.OlaAddContactActivity.this     // Catch: java.lang.Throwable -> L12
                    chat.ola.vn.activity.OlaAddContactActivity.a(r1)     // Catch: java.lang.Throwable -> L12
                L12:
                    r1 = 0
                    return r1
                */
                throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaAddContactActivity.AnonymousClass1.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
            }
        });
        this.e.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.activity.OlaAddContactActivity.2
            @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
            public void b_(String str) {
                try {
                    OlaAddContactActivity.this.C();
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        this.f = new q(this);
        q qVar = this.f;
        q qVar2 = this.f;
        qVar2.getClass();
        qVar.a(qVar2.new a());
        this.e.setAdapter(this.f);
        B();
    }
}
