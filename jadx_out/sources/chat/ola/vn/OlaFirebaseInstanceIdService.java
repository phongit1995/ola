package chat.ola.vn;

import chat.ola.vn.util.n;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;

/* JADX INFO: loaded from: classes.dex */
public class OlaFirebaseInstanceIdService extends FirebaseInstanceIdService {
    private void a(String str) {
        h.f = str;
        try {
            if (h.g == null) {
                h.g = n.f(this);
            }
        } catch (Throwable unused) {
        }
        try {
            OlaApplication.b.d(h.g, h.f);
            e.a().g(h.f);
        } catch (Throwable unused2) {
        }
    }

    @Override // com.google.firebase.iid.FirebaseInstanceIdService
    public void onTokenRefresh() {
        a(FirebaseInstanceId.getInstance().getToken());
    }
}
