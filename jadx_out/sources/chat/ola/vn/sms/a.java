package chat.ola.vn.sms;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.telephony.SmsMessage;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class a extends BroadcastReceiver {
    private InterfaceC0049a a;

    /* JADX INFO: renamed from: chat.ola.vn.sms.a$a, reason: collision with other inner class name */
    public interface InterfaceC0049a {
        void f(String str, String str2);
    }

    public void a(InterfaceC0049a interfaceC0049a) {
        this.a = interfaceC0049a;
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        try {
            Object[] objArr = (Object[]) intent.getExtras().get("pdus");
            String originatingAddress = null;
            StringBuffer stringBuffer = new StringBuffer();
            for (Object obj : objArr) {
                SmsMessage smsMessageCreateFromPdu = SmsMessage.createFromPdu((byte[]) obj);
                if (m.a(originatingAddress)) {
                    originatingAddress = smsMessageCreateFromPdu.getOriginatingAddress();
                }
                String displayMessageBody = smsMessageCreateFromPdu.getDisplayMessageBody();
                if (m.a(displayMessageBody)) {
                    displayMessageBody = smsMessageCreateFromPdu.getMessageBody();
                }
                stringBuffer.append(displayMessageBody);
            }
            if (!b.a(originatingAddress) || this.a == null) {
                return;
            }
            this.a.f(originatingAddress, stringBuffer.toString());
        } catch (Throwable unused) {
        }
    }
}
