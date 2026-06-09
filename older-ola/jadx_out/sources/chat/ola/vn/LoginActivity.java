package chat.ola.vn;

import android.content.Intent;
import android.os.Bundle;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class LoginActivity extends c {
    private void f(String str, String str2) {
        Intent intent = new Intent();
        intent.putExtra("com.ola.username", str);
        intent.putExtra("com.ola.token", str2);
        setResult(-1, intent);
        finish();
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        try {
            if (getIntent().getBooleanExtra("com.ola.relogin", false)) {
                return;
            }
            String strI = e.a().i();
            String strJ = e.a().j();
            if (!m.a(strI) && !m.a(strJ)) {
                f(strI, strJ);
            } else {
                setResult(0, new Intent());
                finish();
            }
        } catch (Throwable unused) {
        }
    }
}
