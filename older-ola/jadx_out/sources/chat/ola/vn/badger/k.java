package chat.ola.vn.badger;

import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public class k extends j {
    public k(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            Intent intent = new Intent("com.sonyericsson.home.action.UPDATE_BADGE");
            intent.putExtra("com.sonyericsson.home.intent.extra.badge.PACKAGE_NAME", b());
            intent.putExtra("com.sonyericsson.home.intent.extra.badge.ACTIVITY_NAME", "chat.ola.vn.activity.OlaLoginActivity");
            intent.putExtra("com.sonyericsson.home.intent.extra.badge.MESSAGE", String.valueOf(i));
            intent.putExtra("com.sonyericsson.home.intent.extra.badge.SHOW_MESSAGE", i > 0);
            this.a.sendBroadcast(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
