package chat.ola.vn;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

/* JADX INFO: loaded from: classes.dex */
public class OlaFirebaseMessagingService extends FirebaseMessagingService implements chat.ola.vn.f.a {
    @Override // com.google.firebase.messaging.FirebaseMessagingService
    public void onMessageReceived(RemoteMessage remoteMessage) {
        remoteMessage.getData().size();
        remoteMessage.getNotification();
    }
}
