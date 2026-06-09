package chat.ola.vn.activity;

import android.app.NotificationManager;
import android.content.Intent;
import android.os.Bundle;
import chat.ola.vn.c;
import chat.ola.vn.f.a;
import chat.ola.vn.h;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.util.i;

/* JADX INFO: loaded from: classes.dex */
public class OlaReplyMeOnNotificationActivity extends c implements a {
    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        try {
            Intent intent = getIntent();
            long longExtra = intent.getLongExtra("_me_entry_id", 0L);
            String stringExtra = intent.getStringExtra("me_message");
            String stringExtra2 = intent.getStringExtra("_sender");
            int intExtra = intent.getIntExtra("_index", 0);
            if (longExtra != 0) {
                OlaMeComposerActivity.a(this, stringExtra2, i.b(stringExtra, "@" + h.a()) + " " + i.a((CharSequence) stringExtra), longExtra);
                ((NotificationManager) getSystemService("notification")).cancel(intExtra);
                finish();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        finish();
    }
}
