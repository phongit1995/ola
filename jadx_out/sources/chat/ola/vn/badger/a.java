package chat.ola.vn.badger;

import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public class a extends j {
    public a(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            Intent intent = new Intent("org.adw.launcher.counter.SEND");
            intent.putExtra("PNAME", b());
            intent.putExtra("COUNT", i);
            this.a.sendBroadcast(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
