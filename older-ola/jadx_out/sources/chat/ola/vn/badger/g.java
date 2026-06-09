package chat.ola.vn.badger;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public class g extends j {
    public g(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            Intent intent = new Intent("com.htc.launcher.action.SET_NOTIFICATION");
            intent.putExtra("com.htc.launcher.extra.COMPONENT", new ComponentName(b(), a()).flattenToShortString());
            intent.putExtra("com.htc.launcher.extra.COUNT", i);
            this.a.sendBroadcast(intent);
            Intent intent2 = new Intent("com.htc.launcher.action.UPDATE_SHORTCUT");
            intent2.putExtra("packagename", b());
            intent2.putExtra("count", i);
            this.a.sendBroadcast(intent2);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
