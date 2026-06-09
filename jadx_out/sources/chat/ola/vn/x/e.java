package chat.ola.vn.x;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.entity.ai;
import chat.ola.vn.p.o;
import chat.ola.vn.util.m;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

/* JADX INFO: loaded from: classes.dex */
public class e {
    public static List<c> a(final String str) throws Throwable {
        DefaultHttpClient defaultHttpClient;
        String strGroup;
        if (m.a(str)) {
            return null;
        }
        try {
            HashMap map = new HashMap();
            Map<String, String> mapB = b.b(str);
            if (mapB != null && mapB.size() > 0) {
                for (String str2 : mapB.keySet()) {
                    String str3 = mapB.get(str2);
                    if (!map.containsKey(str2)) {
                        map.put(str2, str3);
                    }
                }
            }
            if (map.size() <= 0) {
                String strSubstring = "http://m.youtube.com/watch?v=" + str;
                int iIndexOf = strSubstring.indexOf(38);
                if (iIndexOf >= 0) {
                    strSubstring = strSubstring.substring(0, iIndexOf);
                }
                defaultHttpClient = new DefaultHttpClient();
                try {
                    try {
                        defaultHttpClient.getParams().setParameter("http.useragent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.41 Safari/537.36");
                        HttpEntity entity = defaultHttpClient.execute(new HttpGet(strSubstring)).getEntity();
                        InputStream content = entity.getContent();
                        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(content));
                        StringBuilder sb = new StringBuilder();
                        while (true) {
                            String line = bufferedReader.readLine();
                            if (line != null) {
                                sb.append(line.replace("\\u0026", "&"));
                            } else {
                                try {
                                    break;
                                } catch (Throwable unused) {
                                }
                            }
                        }
                        content.close();
                        try {
                            entity.consumeContent();
                        } catch (Throwable unused2) {
                        }
                        String string = sb.toString();
                        if (string.contains("verify-age-thumb")) {
                            try {
                                defaultHttpClient.getConnectionManager().shutdown();
                            } catch (Throwable unused3) {
                            }
                            return null;
                        }
                        if (string.contains("das_captcha")) {
                            try {
                                defaultHttpClient.getConnectionManager().shutdown();
                            } catch (Throwable unused4) {
                            }
                            return null;
                        }
                        Matcher matcher = Pattern.compile("stream_map\": \"(.*?)?\"").matcher(string);
                        ArrayList arrayList = new ArrayList();
                        while (matcher.find()) {
                            arrayList.add(matcher.group());
                        }
                        if (arrayList.size() != 1) {
                            try {
                                defaultHttpClient.getConnectionManager().shutdown();
                            } catch (Throwable unused5) {
                            }
                            return null;
                        }
                        for (String str4 : ((String) arrayList.get(0)).split(",")) {
                            String strDecode = URLDecoder.decode(str4, "UTF-8");
                            Matcher matcher2 = Pattern.compile("url=(.*?)(&|$)").matcher(str4);
                            if (matcher2.find()) {
                                String strGroup2 = matcher2.group(1);
                                Matcher matcher3 = Pattern.compile("itag=([0-9]+?)(&|$)").matcher(strDecode);
                                if (matcher3.find()) {
                                    String strGroup3 = matcher3.group(1);
                                    Matcher matcher4 = Pattern.compile("sig=(.*?)(&|$)").matcher(strDecode);
                                    if (matcher4.find()) {
                                        strGroup = matcher4.group(1);
                                    } else {
                                        Matcher matcher5 = Pattern.compile("s=(.*?)(&|$)").matcher(strDecode);
                                        if (matcher5.find()) {
                                            strGroup = matcher5.group(1);
                                        }
                                    }
                                    if (!m.a(strGroup3) && !m.a(strGroup2)) {
                                        String strDecode2 = URLDecoder.decode(strGroup2, "UTF-8");
                                        if (!m.a(strGroup) || (strDecode2.indexOf("sig=") <= 0 && strDecode2.indexOf("signature=") <= 0)) {
                                            if (!map.containsKey(strGroup3)) {
                                                strDecode2 = strDecode2 + "&signature=" + strGroup;
                                                map.put(strGroup3, strDecode2);
                                            }
                                        } else if (!map.containsKey(strGroup3)) {
                                            map.put(strGroup3, strDecode2);
                                        }
                                    }
                                }
                            }
                        }
                        if (map.size() == 0) {
                            try {
                                defaultHttpClient.getConnectionManager().shutdown();
                            } catch (Throwable unused6) {
                            }
                            return null;
                        }
                    } catch (Throwable th) {
                        th = th;
                        th.printStackTrace();
                        try {
                            defaultHttpClient.getConnectionManager().shutdown();
                        } catch (Throwable unused7) {
                        }
                        return null;
                    }
                } catch (Throwable th2) {
                    th = th2;
                    try {
                        defaultHttpClient.getConnectionManager().shutdown();
                    } catch (Throwable unused8) {
                    }
                    throw th;
                }
            } else {
                defaultHttpClient = null;
            }
            HashMap map2 = new HashMap();
            map2.put("13", new chat.ola.vn.t.a((byte) 0, (byte) 0, (short) 176, (short) 144));
            map2.put("17", new chat.ola.vn.t.a((byte) 0, (byte) 1, (short) 176, (short) 144));
            map2.put("36", new chat.ola.vn.t.a((byte) 0, (byte) 2, (short) 320, (short) 240));
            map2.put("18", new chat.ola.vn.t.a((byte) 3, (byte) 1, (short) 480, (short) 360));
            map2.put("22", new chat.ola.vn.t.a((byte) 3, (byte) 2, (short) 1280, (short) 720));
            ArrayList arrayList2 = new ArrayList();
            for (String str5 : map2.keySet()) {
                chat.ola.vn.t.a aVar = (chat.ola.vn.t.a) map2.get(str5);
                if (map.containsKey(str5)) {
                    final c cVar = new c(aVar.d, aVar.a, aVar.b, aVar.c, (String) map.get(str5));
                    arrayList2.add(cVar);
                    OlaApplication.b.a(str, new o() { // from class: chat.ola.vn.x.e.1
                        @Override // chat.ola.vn.p.o
                        public void a() {
                        }

                        @Override // chat.ola.vn.p.o
                        public void a(ai aiVar) {
                            if (m.b(str, aiVar.c)) {
                                if (!m.a(aiVar.a)) {
                                    cVar.a = aiVar.a;
                                }
                                if (aiVar.e != 0) {
                                    cVar.c = aiVar.e;
                                }
                            }
                        }
                    });
                }
            }
            try {
                defaultHttpClient.getConnectionManager().shutdown();
            } catch (Throwable unused9) {
            }
            return arrayList2;
        } catch (Throwable th3) {
            th = th3;
            defaultHttpClient = null;
            defaultHttpClient.getConnectionManager().shutdown();
            throw th;
        }
    }
}
