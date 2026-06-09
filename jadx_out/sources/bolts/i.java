package bolts;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class i {
    private Context a;
    private String b;
    private Bundle c;

    private i(Context context, String str, Bundle bundle) {
        this.a = context.getApplicationContext();
        this.b = str;
        this.c = bundle;
    }

    /* JADX WARN: Removed duplicated region for block: B:43:0x00d5  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static android.os.Bundle a(android.content.Context r6, java.lang.String r7, android.os.Bundle r8, android.content.Intent r9) {
        /*
            Method dump skipped, instruction units count: 279
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: bolts.i.a(android.content.Context, java.lang.String, android.os.Bundle, android.content.Intent):android.os.Bundle");
    }

    private static String a(Object obj) {
        if (obj == null) {
            return null;
        }
        if ((obj instanceof JSONArray) || (obj instanceof JSONObject)) {
            return obj.toString();
        }
        try {
            return obj instanceof Collection ? new JSONArray((Collection) obj).toString() : obj instanceof Map ? new JSONObject((Map) obj).toString() : obj.toString();
        } catch (Exception unused) {
            return null;
        }
    }

    private void a() {
        if (this.b == null) {
            Log.d(getClass().getName(), "Event name is required");
        }
        try {
            Class<?> cls = Class.forName("android.support.v4.content.LocalBroadcastManager");
            Method method = cls.getMethod("getInstance", Context.class);
            Method method2 = cls.getMethod("sendBroadcast", Intent.class);
            Object objInvoke = method.invoke(null, this.a);
            Intent intent = new Intent("com.parse.bolts.measurement_event");
            intent.putExtra("event_name", this.b);
            intent.putExtra("event_args", this.c);
            method2.invoke(objInvoke, intent);
        } catch (Exception unused) {
            Log.d(getClass().getName(), "LocalBroadcastManager in android support library is required to raise bolts event.");
        }
    }

    static void a(Context context, String str, Intent intent, Map<String, String> map) {
        Bundle bundle = new Bundle();
        if (intent != null) {
            Bundle bundleA = c.a(intent);
            if (bundleA != null) {
                bundle = a(context, str, bundleA, intent);
            } else {
                Uri data = intent.getData();
                if (data != null) {
                    bundle.putString("intentData", data.toString());
                }
                Bundle extras = intent.getExtras();
                if (extras != null) {
                    for (String str2 : extras.keySet()) {
                        bundle.putString(str2, a(extras.get(str2)));
                    }
                }
            }
        }
        if (map != null) {
            for (String str3 : map.keySet()) {
                bundle.putString(str3, map.get(str3));
            }
        }
        new i(context, str, bundle).a();
    }
}
