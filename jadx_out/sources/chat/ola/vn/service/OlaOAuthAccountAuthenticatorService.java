package chat.ola.vn.service;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import chat.ola.vn.a.a;

/* JADX INFO: loaded from: classes.dex */
public class OlaOAuthAccountAuthenticatorService extends Service {
    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return new a(this).getIBinder();
    }
}
