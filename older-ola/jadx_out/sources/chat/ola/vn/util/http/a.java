package chat.ola.vn.util.http;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.util.Base64;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.x;
import chat.ola.vn.e;
import chat.ola.vn.h;
import chat.ola.vn.util.d;
import chat.ola.vn.util.m;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class a extends c {
    private static int a;
    private static int b;
    private static long c;

    private static long a() {
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (jCurrentTimeMillis > c) {
            c = jCurrentTimeMillis;
            return jCurrentTimeMillis;
        }
        long j = c + 1;
        c = j;
        return j;
    }

    public static Intent a(String str, String str2) {
        try {
            String[] strArrSplit = e(a(null, "id/pubkey?un=" + str, false)).replace("[", "").replace("]", "").split(",");
            if (strArrSplit != null) {
                byte[] bArr = new byte[strArrSplit.length];
                for (int i = 0; i < strArrSplit.length; i++) {
                    bArr[i] = Byte.parseByte(strArrSplit[i]);
                }
                JSONObject jSONObjectG = g(a(null, "id/signin?un=" + str + "&pw=" + Base64.encodeToString(chat.ola.vn.j.a.a(bArr, str2), 10), false));
                Intent intent = new Intent();
                int i2 = jSONObjectG.has("code") ? jSONObjectG.getInt("code") : 33;
                if (i2 == 1) {
                    String string = jSONObjectG.getString("loginName");
                    String string2 = jSONObjectG.getString("sessionCode");
                    long j = jSONObjectG.has("lastLoginTime") ? Long.parseLong(jSONObjectG.getString("lastLoginTime")) : 0L;
                    intent.putExtra("authAccount", string);
                    intent.putExtra("accountType", OlaApplication.a(R.string.account_type));
                    intent.putExtra("authtoken", string2);
                    intent.putExtra("_pass", str2);
                    intent.putExtra("_time", j);
                } else if (jSONObjectG.has("meta")) {
                    String string3 = jSONObjectG.getString("meta");
                    if (!m.a(string3)) {
                        intent.putExtra("_byte_data", string3);
                    }
                }
                intent.putExtra("_result", i2);
                return intent;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    private static String a(String str, String str2, String str3, Map<String, String> map, boolean z) {
        boolean zStartsWith;
        URL url;
        String str4;
        if (m.a(str)) {
            str = e.a().j();
        }
        if (m.a(str)) {
            if (z) {
                return null;
            }
            str = "";
        }
        try {
            zStartsWith = str2.startsWith("http://api.ola.vn/html/adme");
        } catch (Throwable unused) {
            zStartsWith = false;
        }
        try {
            try {
                url = new URI(str2).normalize().toURL();
            } catch (Throwable unused2) {
                return str2;
            }
        } catch (Throwable unused3) {
            url = new URL(str2);
        }
        String strReplace = url.getPath().replace("/$", "");
        Map mapA = d.a(url.getQuery());
        int port = url.getPort();
        if (mapA == null) {
            mapA = new HashMap();
        }
        mapA.put("owsc", str);
        if (!m.a(h.a())) {
            mapA.put("owsn", h.a());
        }
        if (str3 != null) {
            str4 = "cid";
        } else {
            str4 = "cid";
            str3 = "77B9A513";
        }
        mapA.put(str4, str3);
        mapA.put("apv", "24");
        try {
            a = zStartsWith ? OlaApplication.b().getDimensionPixelSize(R.dimen.metric_48dp) : OlaApplication.b().getDimensionPixelSize(R.dimen.metric_8dp);
            b = OlaApplication.b().getDimensionPixelSize(R.dimen.metric_8dp);
        } catch (Throwable unused4) {
        }
        mapA.put("acbh", "" + a);
        mapA.put("btbh", "" + b);
        mapA.put("ctms", "" + a());
        mapA.put("olaLocale", x.i());
        mapA.put("googlePlay", "true");
        mapA.put("deviceType", "4");
        mapA.put("olaVersion", "5.10.19");
        if (map != null) {
            try {
                for (String str5 : map.keySet()) {
                    mapA.put(str5, map.get(str5));
                }
            } catch (Throwable unused5) {
            }
        }
        ArrayList<String> arrayList = new ArrayList();
        try {
            arrayList.add(strReplace.startsWith("/") ? strReplace.substring(1, strReplace.length()) : strReplace);
        } catch (Throwable unused6) {
        }
        for (String str6 : mapA.keySet()) {
            arrayList.add(str6 + "=" + ((String) mapA.get(str6)));
        }
        Collections.sort(arrayList);
        StringBuilder sb = new StringBuilder();
        for (String str7 : arrayList) {
            sb.append(" ");
            sb.append(str7);
        }
        mapA.put("sig", chat.ola.vn.j.a.a(sb.toString().trim()));
        String strA = d.a((Map<String, String>) mapA);
        String str8 = m.a(strA) ? "" : "?" + strA;
        StringBuilder sb2 = new StringBuilder();
        sb2.append(url.getProtocol());
        sb2.append("://");
        sb2.append(url.getHost());
        sb2.append((port == -1 || port == 80) ? "" : ":" + port);
        sb2.append(strReplace);
        sb2.append(str8);
        return sb2.toString();
    }

    public static String a(String str, String str2, String str3, boolean z) {
        return a(str, b(str2), str3, null, z);
    }

    public static String a(String str, String str2, Map<String, String> map, boolean z) {
        return a(str, i(str2), "77B9A513", map, z);
    }

    public static String a(String str, String str2, boolean z) {
        return a(str, i(str2), "77B9A513", null, z);
    }

    private static String a(String str, boolean z) {
        try {
            if (str.toLowerCase().startsWith("rss://")) {
                return c("html/rss/view/") + str.substring("rss://".length());
            }
            if (str.toLowerCase().startsWith("http://")) {
                String strD = d(str);
                if (m.a(strD) || !m.b("api.ola.vn", strD)) {
                    return null;
                }
                return str;
            }
            if (str.startsWith("/")) {
                str = str.substring(1);
            }
            if (z) {
                return c("json/" + str);
            }
            return c("html/" + str);
        } catch (Throwable unused) {
            return null;
        }
    }

    public static boolean a(String str) {
        try {
            if (m.a(str)) {
                return false;
            }
            return m.b(new URL(str).getHost().toLowerCase(), "api.ola.vn");
        } catch (Throwable unused) {
            return false;
        }
    }

    public static String b(String str) {
        return a(str, false);
    }

    public static String b(String str, String str2, String str3, boolean z) {
        return a(str, str2, str3, null, z);
    }

    public static String c(String str) {
        StringBuilder sb;
        String str2;
        if (m.a("")) {
            sb = new StringBuilder();
            str2 = "http://api.ola.vn/";
        } else {
            sb = new StringBuilder();
            str2 = "http://api.ola.vn:/";
        }
        sb.append(str2);
        sb.append(str);
        return sb.toString();
    }

    public static String d(String str) {
        try {
            return new URL(str).getHost();
        } catch (Throwable unused) {
            return null;
        }
    }

    private static String i(String str) {
        return a(str, true);
    }
}
