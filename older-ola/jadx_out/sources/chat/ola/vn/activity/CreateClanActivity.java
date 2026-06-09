package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.internal.view.SupportMenu;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.entity.b;
import chat.ola.vn.i.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;

/* JADX INFO: loaded from: classes.dex */
public class CreateClanActivity extends c implements View.OnClickListener {
    protected chat.ola.vn.i.c e;
    private EditText f;
    private Animation g;
    private a h;
    private String i = null;
    private String j;
    private View k;
    private TextView l;

    private class a {
        TextView a;
        TextView b;
        TextView c;
        TextView d;
        TextView e;
        TextView f;
        private View h;

        public a(View view) {
            this.h = view;
            this.f = (TextView) view.findViewById(R.id.txtClanName);
            this.a = (TextView) view.findViewById(R.id.txtClanAdmin);
            this.b = (TextView) view.findViewById(R.id.txtClanSupporter);
            this.c = (TextView) view.findViewById(R.id.txtClanMessenger);
            this.d = (TextView) view.findViewById(R.id.txtClanNumOfMem);
            this.e = (TextView) view.findViewById(R.id.txtClanVisitCount);
            this.a.setOnClickListener(CreateClanActivity.this);
            this.b.setOnClickListener(CreateClanActivity.this);
            this.c.setOnClickListener(CreateClanActivity.this);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void a() {
            this.h.setVisibility(8);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void a(String str, String str2, String str3, String str4, int i, int i2) {
            this.f.setText("#" + str);
            this.a.setText(str2);
            this.b.setText(str3);
            this.c.setText(str4);
            this.d.setText(m.a(i) + " " + CreateClanActivity.this.getString(R.string.string_members));
            this.e.setText(m.a((long) i2) + " " + CreateClanActivity.this.getString(R.string.string_visit_count));
            b();
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void b() {
            this.h.setVisibility(0);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        if (C()) {
            if (this.e == null || !this.e.isShowing()) {
                this.e = new chat.ola.vn.i.c(this);
            } else {
                this.e.a();
            }
            this.e.a(getString(R.string.message_clan_validate));
            this.e.a(15000L, null);
            if (OlaApplication.b != null) {
                OlaApplication.b.f(this.f.getText().toString(), (short) 46);
            }
        }
    }

    private boolean C() {
        if (!m.a(this.f.getText().toString())) {
            return true;
        }
        this.f.startAnimation(this.g);
        j.b(this, R.string.message_input_clan_name);
        return false;
    }

    public static void a(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) CreateClanActivity.class);
        if (str != null) {
            intent.putExtra("clanId", str);
        }
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void f(final String str) {
        i.b(this, getString(R.string.string_create_clan), getString(R.string.message_create_clan_confirm_format, new Object[]{this.j}), getString(R.string.string_create), getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.CreateClanActivity.3
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i != 0 || OlaApplication.b == null) {
                    dialogInterface.dismiss();
                    return;
                }
                OlaApplication.b.o(str.replaceFirst("#", ""), (short) 47);
                j.b(CreateClanActivity.this, R.string.message_create_clan_request_sent_format, "\"" + str + "\"");
                OlaApplication.b.r();
                dialogInterface.dismiss();
                CreateClanActivity.this.finish();
            }
        });
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(b bVar, short s) {
        try {
            if (this.e != null) {
                this.e.a();
            }
            this.i = bVar.a;
            o.a((Context) this, (View) this.f, true);
            this.f.selectAll();
            if (46 == s) {
                this.k.setVisibility(8);
                this.l.setVisibility(0);
                this.l.setTextColor(SupportMenu.CATEGORY_MASK);
                this.l.setText(getString(R.string.message_clan_exist_format, new Object[]{"#" + bVar.a}));
                this.h.a(bVar.a, bVar.b, bVar.c, bVar.d, bVar.f, bVar.h);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, short s) {
        if (46 == s) {
            try {
                if (this.e != null) {
                    this.e.a();
                }
                this.j = str;
                this.k.setVisibility(0);
                this.h.a();
                this.l.setVisibility(0);
                this.l.setTextColor(-16776961);
                this.l.setText(getString(R.string.message_clan_available_format));
            } catch (Throwable unused) {
            }
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
                case R.id.btnActionButtonLeft /* 2131296414 */:
                    break;
                case R.id.btnClanValidate /* 2131296440 */:
                    B();
                    return;
                case R.id.btnCreateClan /* 2131296451 */:
                    if (C()) {
                        f(this.f.getText().toString());
                        return;
                    }
                    return;
                case R.id.txtClanAdmin /* 2131297542 */:
                case R.id.txtClanMessenger /* 2131297543 */:
                case R.id.txtClanSupporter /* 2131297547 */:
                    chat.ola.vn.me.c.a(this, OlaApplication.b, ((TextView) view).getText().toString());
                    break;
                default:
                    return;
            }
            finish();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.create_clan_input_layout);
        this.g = AnimationUtils.loadAnimation(this, R.anim.shake);
        this.f = (EditText) findViewById(R.id.txtClanNameInput);
        try {
            String stringExtra = getIntent().getStringExtra("clanId");
            if (!m.a(stringExtra)) {
                this.f.setText("#" + stringExtra);
            }
        } catch (Throwable unused) {
        }
        this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.CreateClanActivity.1
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i != 6 && (keyEvent == null || keyEvent.getKeyCode() != 66)) {
                    return false;
                }
                CreateClanActivity.this.B();
                return false;
            }
        });
        this.f.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.activity.CreateClanActivity.2
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                if (!m.b(CreateClanActivity.this.i, charSequence.toString())) {
                    CreateClanActivity.this.h.a();
                    CreateClanActivity.this.k.setVisibility(8);
                    CreateClanActivity.this.l.setVisibility(8);
                } else if (CreateClanActivity.this.i != null) {
                    CreateClanActivity.this.k.setVisibility(8);
                    CreateClanActivity.this.h.b();
                    CreateClanActivity.this.l.setVisibility(0);
                    CreateClanActivity.this.l.setText(CreateClanActivity.this.getString(R.string.message_clan_exist_format, new Object[]{"#" + CreateClanActivity.this.i}));
                }
            }
        });
        this.k = findViewById(R.id.btnCreateClan);
        this.l = (TextView) findViewById(R.id.txtClanValidateMessage);
        this.l.setVisibility(8);
        this.k.setOnClickListener(this);
        findViewById(R.id.btnActionButtonLeft).setOnClickListener(this);
        findViewById(R.id.btnClanValidate).setOnClickListener(this);
        this.h = new a(findViewById(R.id.linearClanWrapper));
        this.h.a();
    }
}
