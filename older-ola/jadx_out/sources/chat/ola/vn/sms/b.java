package chat.ola.vn.sms;

import android.annotation.SuppressLint;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.telephony.SmsManager;
import chat.ola.vn.c;
import chat.ola.vn.util.m;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public static void a(Context context, String str, String str2) {
        try {
            if (m.a(str) || m.a(str2)) {
                return;
            }
            String strS = m.s(str2);
            Intent intent = new Intent("SMS_SENT");
            intent.putExtra("SMS_SERVICE_CENTER", str);
            if (!m.a(strS)) {
                intent.putExtra("SMS_TEXT_CONTENT", strS);
            }
            SmsManager.getDefault().sendTextMessage(str, null, strS, PendingIntent.getBroadcast(context, 0, intent, CrashUtils.ErrorDialogData.SUPPRESSED), null);
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"NewApi"})
    public static boolean a(c cVar) {
        if (Build.VERSION.SDK_INT >= 23) {
            return cVar.checkSelfPermission("android.permission.SEND_SMS") == 0 && cVar.checkSelfPermission("android.permission.RECEIVE_SMS") == 0;
        }
        return true;
    }

    public static boolean a(String str) {
        if (str.length() < 8) {
            return str.endsWith("8055") || str.endsWith("8155") || str.endsWith("8255") || str.endsWith("8455") || str.endsWith("8555") || str.endsWith("8655") || str.endsWith("8755");
        }
        return false;
    }
}
