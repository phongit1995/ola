package chat.ola.vn.badger;

import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public class c extends j {
    public c(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            Intent intent = new Intent("com.anddoes.launcher.COUNTER_CHANGED");
            intent.putExtra("package", b());
            intent.putExtra("count", i);
            intent.putExtra("class", a());
            this.a.sendBroadcast(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
