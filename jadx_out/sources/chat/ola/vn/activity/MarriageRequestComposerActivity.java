package chat.ola.vn.activity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.ScrollView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.c;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.d;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.g;
import chat.ola.vn.i.i;
import chat.ola.vn.util.h;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import chat.ola.vn.view.OlaTypingSuggestedText;

/* JADX INFO: loaded from: classes.dex */
public class MarriageRequestComposerActivity extends c implements TextWatcher, View.OnClickListener {
    private OlaTypingSuggestedText e;
    private OlaQuickTypingSuggestedText f;
    private ImageView g;
    private short h;
    private ScrollView i;

    private void D() {
        o.a((Context) this, (View) this.e, false);
        String strTrim = this.f.getText().toString().trim();
        if (strTrim.length() == 0) {
            j.b(this, R.string.message_receiver_id_not_null);
            return;
        }
        String strTrim2 = this.e.getText().toString().trim();
        if (strTrim2.length() == 0) {
            j.b(this, R.string.message_marriage_request_message_not_null);
            return;
        }
        x.j = (short) 2;
        if (!m.a(strTrim)) {
            try {
                OlaApplication.b.b(strTrim, strTrim2, this.h, (String) null, f.a(new e() { // from class: chat.ola.vn.activity.MarriageRequestComposerActivity.3
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 66;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i, short s, String str, d[] dVarArr) {
                        if (m.a(str)) {
                            return;
                        }
                        i.b(MarriageRequestComposerActivity.this, MarriageRequestComposerActivity.this.getString(R.string.dialog_title_inform), str);
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                    }
                }));
            } catch (Throwable unused) {
            }
        }
        j.d(this, R.string.message_mariage_request_sent, "@" + strTrim);
        finish();
    }

    private boolean E() {
        try {
            if (this.e.getText().toString().trim().length() == 0) {
                return true;
            }
            i.b(this, R.string.dialog_title_inform, R.string.confirm_discard_draft_content, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.MarriageRequestComposerActivity.5
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    if (i == 0) {
                        try {
                            MarriageRequestComposerActivity.this.finish();
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                    dialogInterface.dismiss();
                }
            });
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public static void a(Context context) {
        a(context, (String) null);
    }

    public static void a(Context context, String str) {
        try {
            Intent intent = new Intent();
            String strJ = m.j(str);
            if (!m.a(strJ)) {
                intent.putExtra("_buddy_id", strJ);
            }
            intent.setClass(context, MarriageRequestComposerActivity.class);
            context.startActivity(intent);
        } catch (Throwable unused) {
        }
    }

    protected void B() {
        if (this.h == 0) {
            this.g.setVisibility(8);
        } else {
            this.g.setVisibility(0);
            this.g.setImageResource(chat.ola.vn.util.c.a(this.h));
        }
    }

    public void C() {
        try {
            setContentView(R.layout.marriage_request_composer_layout);
            try {
                findViewById(R.id.btnActionButtonLeft).setOnClickListener(this);
                findViewById(R.id.btnActionButtonRight).setOnClickListener(this);
                findViewById(R.id.btnQuickAttachCamera).setOnClickListener(this);
                findViewById(R.id.btnQuickAttachSmiley).setOnClickListener(this);
                findViewById(R.id.btnAttachMore).setOnClickListener(this);
            } catch (Throwable unused) {
            }
            this.i = (ScrollView) findViewById(R.id.scrollView1);
            getWindowManager().getDefaultDisplay().getMetrics(new DisplayMetrics());
            this.g = (ImageView) findViewById(R.id.imgKulView);
            this.e = (OlaTypingSuggestedText) findViewById(R.id.txtEditMe);
            this.e.setAllowedSuggestion(x.r);
            this.e.addTextChangedListener(this);
            this.g.setOnClickListener(this);
            this.f = (OlaQuickTypingSuggestedText) findViewById(R.id.receiverId);
            this.f.setAllowedSuggestion(x.r);
            q qVar = new q(this);
            qVar.a(g.a());
            qVar.getClass();
            qVar.a(qVar.new a());
            this.f.setAdapter(qVar);
            this.f.setPopupMaxHeight(getResources().getDimensionPixelSize(R.dimen.general_list_item_height_small) * 5);
            this.f.setGravity(19);
            this.f.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.activity.MarriageRequestComposerActivity.4
                @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
                public void b_(String str) {
                    try {
                        String strJ = m.j(str);
                        MarriageRequestComposerActivity.this.f.setText(strJ);
                        MarriageRequestComposerActivity.this.f.setSelection(strJ.length());
                    } catch (Throwable unused2) {
                    }
                }
            });
            if (getIntent() != null) {
                String stringExtra = getIntent().getStringExtra("_buddy_id");
                if (m.a(stringExtra)) {
                    return;
                }
                this.f.setText(stringExtra);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
        h.a().a(editable);
    }

    @Override // android.text.TextWatcher
    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (E()) {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.imgKulView) {
                this.h = (short) 0;
                this.g.setVisibility(8);
                return;
            }
            switch (id) {
                case R.id.btnActionButtonLeft /* 2131296414 */:
                    o.a((Context) this, (View) this.e, false);
                    finish();
                    break;
                case R.id.btnActionButtonRight /* 2131296415 */:
                    D();
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        getWindow().setBackgroundDrawable(new ColorDrawable(chat.ola.vn.f.b));
        try {
            C();
            q qVar = new q(this);
            qVar.a(g.a());
            this.e.setAdapter(qVar);
            this.e.setPopupMaxHeight(getResources().getDimensionPixelSize(R.dimen.general_list_item_height_small) * 5);
            new Handler().post(new Runnable() { // from class: chat.ola.vn.activity.MarriageRequestComposerActivity.1
                @Override // java.lang.Runnable
                public void run() {
                    MarriageRequestComposerActivity.this.B();
                }
            });
            this.f.postDelayed(new Runnable() { // from class: chat.ola.vn.activity.MarriageRequestComposerActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    MarriageRequestComposerActivity.this.f.requestFocus();
                }
            }, 500L);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
    }

    @Override // chat.ola.vn.c, android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 27) {
            return super.onKeyDown(i, keyEvent);
        }
        return true;
    }

    @Override // android.app.Activity
    protected void onRestoreInstanceState(Bundle bundle) {
        if (bundle != null) {
            this.h = bundle.getShort("extra_edit_kul");
            String string = bundle.getString("extra_edit_content");
            if (!m.a(string)) {
                this.e.setText(string);
            }
            B();
        }
        super.onRestoreInstanceState(bundle);
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        if (bundle != null) {
            bundle.putShort("extra_edit_kul", this.h);
            String string = this.e.getText().toString();
            if (!m.a(string)) {
                bundle.putString("extra_edit_content", string);
            }
        }
        super.onSaveInstanceState(bundle);
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }
}
