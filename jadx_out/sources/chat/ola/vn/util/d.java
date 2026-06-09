package chat.ola.vn.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class d {
    public static String a(Map<String, String> map) {
        if (map == null) {
            return "";
        }
        try {
            if (map.isEmpty()) {
                return "";
            }
            StringBuffer stringBuffer = new StringBuffer(350);
            Iterator<Map.Entry<String, String>> it2 = map.entrySet().iterator();
            while (it2.hasNext()) {
                Map.Entry<String, String> next = it2.next();
                stringBuffer.append(b(next.getKey()));
                stringBuffer.append('=');
                stringBuffer.append(b(next.getValue()));
                if (it2.hasNext()) {
                    stringBuffer.append('&');
                }
            }
            return stringBuffer.toString();
        } catch (Throwable unused) {
            return null;
        }
    }

    public static Map<String, String> a(String str) {
        String str2;
        String str3;
        if (m.a(str)) {
            return null;
        }
        try {
            String[] strArrSplit = str.split("&");
            if (strArrSplit != null && strArrSplit.length > 0) {
                HashMap map = new HashMap(strArrSplit.length);
                for (String str4 : strArrSplit) {
                    if (str4.length() >= 1) {
                        String[] strArrSplit2 = str4.split("=", 2);
                        for (int i = 0; i < strArrSplit2.length; i++) {
                            try {
                                strArrSplit2[i] = URLDecoder.decode(strArrSplit2[i], "UTF-8");
                            } catch (Throwable unused) {
                            }
                        }
                        switch (strArrSplit2.length) {
                            case 1:
                                if (str4.charAt(0) == '=') {
                                    str2 = "";
                                    str3 = strArrSplit2[0];
                                } else {
                                    str2 = strArrSplit2[0];
                                    str3 = "";
                                }
                                break;
                            case 2:
                                str2 = strArrSplit2[0];
                                str3 = strArrSplit2[1];
                                break;
                            default:
                                continue;
                        }
                        map.put(str2, str3);
                    }
                }
                return map;
            }
        } catch (Throwable unused2) {
        }
        return null;
    }

    private static String b(String str) {
        try {
            return URLEncoder.encode(str, "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~");
        } catch (Throwable unused) {
            return str;
        }
    }
}
