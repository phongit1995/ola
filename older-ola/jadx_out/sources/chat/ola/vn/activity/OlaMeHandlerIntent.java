package chat.ola.vn.activity;

import android.os.Bundle;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.c;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaMeHandlerIntent extends c {
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
                List<String> pathSegments = getIntent().getData().getPathSegments();
                String str = null;
                if (pathSegments != null && pathSegments.size() == 1) {
                    String strTrim = pathSegments.get(0).trim();
                    if (!m.b(strTrim, "signup.html") && !m.b(strTrim, "signin.html") && !m.b(strTrim, "setting.html")) {
                        str = strTrim;
                    }
                }
                try {
                    chat.ola.vn.me.c.a(OlaApplication.a(), OlaApplication.b, str);
                } catch (Throwable th) {
                    th.printStackTrace();
                    chat.ola.vn.me.c.a(this, OlaApplication.b, str);
                }
            } catch (Throwable unused) {
            }
        } finally {
            finish();
        }
    }
}
