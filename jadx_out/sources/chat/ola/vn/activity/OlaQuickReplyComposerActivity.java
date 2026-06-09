package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.e;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaQuickReplyComposerActivity extends c implements View.OnClickListener {
    private static List<String> e;
    private EditText f;
    private EditText g;
    private EditText h;

    public static List<String> B() {
        try {
            if (e == null) {
                e = e.a().w();
            }
            return new ArrayList(e);
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaQuickReplyComposerActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        EditText editText;
        try {
            this.f.setText("");
            this.g.setText("");
            this.h.setText("");
            int size = e.size();
            for (int i = 0; i < size; i++) {
                String str = e.get(i);
                if (!m.a(str)) {
                    switch (i) {
                        case 0:
                            editText = this.f;
                            break;
                        case 1:
                            editText = this.g;
                            break;
                        case 2:
                            editText = this.h;
                            break;
                        default:
                            continue;
                    }
                    editText.setText(str);
                }
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            e.clear();
            String string = this.f.getText().toString();
            if (!m.a(string)) {
                e.add(string);
            }
            String string2 = this.g.getText().toString();
            if (!m.a(string2)) {
                e.add(string2);
            }
            String string3 = this.h.getText().toString();
            if (!m.a(string3)) {
                e.add(string3);
            }
            e.a().b(e);
        } catch (Throwable unused) {
        }
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused2) {
        }
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
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_quick_reply_composer_layout);
        this.f = (EditText) findViewById(R.id.quickReplyEditText1);
        this.g = (EditText) findViewById(R.id.quickReplyEditText2);
        this.h = (EditText) findViewById(R.id.quickReplyEditText3);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_quick_reply);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        e = e.a().w();
    }
}
