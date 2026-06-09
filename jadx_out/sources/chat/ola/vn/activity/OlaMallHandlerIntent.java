package chat.ola.vn.activity;

import android.os.Bundle;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.c;
import chat.ola.vn.util.b;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaMallHandlerIntent extends c {
    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        if (getIntent() == null || !m.a("android.intent.action.VIEW", getIntent().getAction())) {
            return;
        }
        try {
            try {
                String strG = m.g(getIntent().getData().toString());
                try {
                    if (m.a(strG)) {
                        b.a(this, (String) null);
                    } else {
                        b.a(OlaApplication.a(), strG);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                    if (m.a(strG)) {
                        b.a(this, (String) null);
                    } else {
                        b.a(this, strG);
                    }
                }
            } catch (Throwable unused) {
            }
        } finally {
            finish();
        }
    }
}
