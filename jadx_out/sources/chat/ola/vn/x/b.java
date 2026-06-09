package chat.ola.vn.x;

import chat.ola.vn.util.m;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public static Map<String, List<String>> a(String str) {
        try {
            HashMap map = new HashMap();
            for (String str2 : str.split("&")) {
                String[] strArrSplit = str2.split("=");
                if (strArrSplit != null && strArrSplit.length >= 2) {
                    String strDecode = URLDecoder.decode(strArrSplit[0], "UTF-8");
                    String strDecode2 = URLDecoder.decode(strArrSplit[1], "UTF-8");
                    List arrayList = (List) map.get(strDecode);
                    if (arrayList == null) {
                        arrayList = new ArrayList(1);
                        map.put(strDecode, arrayList);
                    }
                    arrayList.add(strDecode2);
                }
            }
            return map;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static Map<String, String> b(String str) {
        try {
            if (!m.a(str)) {
                DefaultHttpClient defaultHttpClient = new DefaultHttpClient();
                defaultHttpClient.getParams().setParameter("http.useragent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.41 Safari/537.36");
                HttpEntity entity = defaultHttpClient.execute(new HttpGet("http://www.youtube.com/get_video_info?video_id=" + str)).getEntity();
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
                Map<String, List<String>> mapA = a(sb.toString());
                if (mapA != null) {
                    String str2 = mapA.get("url_encoded_fmt_stream_map").get(0);
                    if (!m.a(str2)) {
                        String[] strArrSplit = str2.split(",");
                        HashMap map = new HashMap();
                        for (String str3 : strArrSplit) {
                            Map<String, List<String>> mapA2 = a(str3);
                            String strDecode = URLDecoder.decode(mapA2.get("type").get(0), "UTF-8");
                            if (mapA2.get("stereo3d") == null) {
                                String str4 = mapA2.get("sig") != null ? mapA2.get("sig").get(0) : null;
                                if (strDecode.indexOf("mp4") > 0) {
                                    String strDecode2 = URLDecoder.decode(mapA2.get("url").get(0), "UTF-8");
                                    if (!m.a(str4)) {
                                        strDecode2 = strDecode2 + "&signature=" + str4;
                                    } else if (strDecode2.indexOf("sig") > 0 || strDecode2.indexOf("signature") > 0) {
                                    }
                                    String strDecode3 = URLDecoder.decode(mapA2.get("itag").get(0), "UTF-8");
                                    if (map.get(strDecode3) == null) {
                                        map.put(strDecode3, strDecode2);
                                    }
                                }
                            }
                        }
                        return map;
                    }
                    if (mapA.get("live_playback") != null && mapA.get("hlsvp") != null) {
                        HashMap map2 = new HashMap();
                        map2.put("live", mapA.get("hlsvp").get(0));
                        return map2;
                    }
                }
            }
        } catch (Throwable unused3) {
        }
        return null;
    }
}
