package chat.ola.vn.badger;

import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public class d extends j {
    public d(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            Intent intent = new Intent("android.intent.action.BADGE_COUNT_UPDATE");
            intent.putExtra("badge_count", i);
            intent.putExtra("badge_count_package_name", b());
            intent.putExtra("badge_count_class_name", a());
            this.a.sendBroadcast(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
