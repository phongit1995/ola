package chat.ola.vn.util.http;

import android.annotation.SuppressLint;
import android.net.http.AndroidHttpClient;
import chat.ola.vn.util.m;
import com.facebook.appevents.AppEventsConstants;
import com.mg.ola.common.d.e;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class c {
    public static JSONObject a(byte[] bArr) {
        try {
            return new JSONObject(m.a(bArr));
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String e(String str) throws Throwable {
        AndroidHttpClient androidHttpClientNewInstance;
        AndroidHttpClient androidHttpClient = null;
        try {
            try {
                androidHttpClientNewInstance = AndroidHttpClient.newInstance("JSON Fetcher: 24");
                try {
                    HttpParams params = androidHttpClientNewInstance.getParams();
                    HttpConnectionParams.setConnectionTimeout(params, 15000);
                    HttpConnectionParams.setSoTimeout(params, 15000);
                    HttpGet httpGet = new HttpGet();
                    httpGet.addHeader("user-agent", "JSON Fetcher: 24");
                    httpGet.setURI(new URI(str));
                    HttpEntity entity = androidHttpClientNewInstance.execute(httpGet).getEntity();
                    InputStream content = entity.getContent();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(content, com.mg.ola.common.d.a.f), 8);
                    StringBuilder sb = new StringBuilder();
                    while (true) {
                        String line = bufferedReader.readLine();
                        if (line != null) {
                            sb.append(line);
                        } else {
                            try {
                                break;
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        }
                    }
                    content.close();
                    try {
                        entity.consumeContent();
                    } catch (Throwable unused) {
                    }
                    String string = sb.toString();
                    try {
                        androidHttpClientNewInstance.close();
                        return string;
                    } catch (Throwable th2) {
                        th2.printStackTrace();
                        return string;
                    }
                } catch (Throwable th3) {
                    th = th3;
                    th.printStackTrace();
                    try {
                        androidHttpClientNewInstance.close();
                        return null;
                    } catch (Throwable th4) {
                        th4.printStackTrace();
                        return null;
                    }
                }
            } catch (Throwable th5) {
                th = th5;
                try {
                    androidHttpClient.close();
                } catch (Throwable th6) {
                    th6.printStackTrace();
                }
                throw th;
            }
        } catch (Throwable th7) {
            th = th7;
            androidHttpClient.close();
            throw th;
        }
    }

    public static byte[] f(String str) throws Throwable {
        AndroidHttpClient androidHttpClientNewInstance;
        try {
            androidHttpClientNewInstance = AndroidHttpClient.newInstance("JSON Fetcher: 24");
            try {
                try {
                    HttpParams params = androidHttpClientNewInstance.getParams();
                    HttpConnectionParams.setConnectionTimeout(params, 3000);
                    HttpConnectionParams.setSoTimeout(params, 3000);
                    HttpGet httpGet = new HttpGet();
                    httpGet.addHeader("user-agent", "JSON Fetcher: 24");
                    httpGet.setURI(new URI(str));
                    byte[] bArrB = e.b(androidHttpClientNewInstance.execute(httpGet).getEntity().getContent());
                    try {
                        androidHttpClientNewInstance.close();
                    } catch (Throwable unused) {
                    }
                    return bArrB;
                } catch (Throwable th) {
                    th = th;
                    th.printStackTrace();
                    try {
                        androidHttpClientNewInstance.close();
                    } catch (Throwable unused2) {
                    }
                    return null;
                }
            } catch (Throwable th2) {
                th = th2;
                try {
                    androidHttpClientNewInstance.close();
                } catch (Throwable unused3) {
                }
                throw th;
            }
        } catch (Throwable th3) {
            th = th3;
            androidHttpClientNewInstance = null;
            androidHttpClientNewInstance.close();
            throw th;
        }
    }

    public static JSONObject g(String str) throws Throwable {
        String strE = e(str);
        try {
            try {
                return new JSONObject(strE);
            } catch (Throwable unused) {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("code", AppEventsConstants.EVENT_PARAM_VALUE_NO);
                jSONObject.put("meta", strE);
                return jSONObject;
            }
        } catch (Throwable unused2) {
            return null;
        }
    }

    public static String h(String str) {
        try {
            String protocol = new URL(str).getProtocol();
            if (!m.a(protocol)) {
                String lowerCase = protocol.toLowerCase();
                if (str.toLowerCase().startsWith(lowerCase)) {
                    return lowerCase + str.substring(lowerCase.length());
                }
            }
        } catch (Throwable unused) {
        }
        return str;
    }
}
