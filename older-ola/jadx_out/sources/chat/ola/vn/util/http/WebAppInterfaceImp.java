package chat.ola.vn.util.http;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.h;
import chat.ola.vn.m.j;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.sms.OlaSmsSendingActivity;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import chat.ola.vn.v.c;
import com.mg.ola.common.d.g;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class WebAppInterfaceImp implements IWebAppInterface {
    private Context a;
    protected int b = 0;
    private WebView c;

    public WebAppInterfaceImp(Context context, WebView webView) {
        this.a = context;
        this.c = webView;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public String jsTrim(String str) {
        if (str == null) {
            return null;
        }
        String strTrim = str.trim();
        if (strTrim.length() == 0 || "null".equals(strTrim) || "undefined".equals(strTrim) || "".equals(strTrim)) {
            return null;
        }
        return strTrim;
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void copyToClipboard(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.3
            @Override // java.lang.Runnable
            public void run() {
                if (m.a(str)) {
                    return;
                }
                o.a(OlaApplication.a(), str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void createOlaMallShortcut() {
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void fetchHttpUrl(String str, String str2, String str3, String str4, String str5) {
        try {
            c.b bVar = new c.b();
            bVar.a = str;
            bVar.b = str5;
            bVar.c = str3;
            bVar.d = str4;
            bVar.e = str2.split("\\|");
            bVar.g = new c.a() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.9
                @Override // chat.ola.vn.v.c.a
                public void a(String str6) {
                    WebAppInterfaceImp.this.c.loadUrl(str6);
                }
            };
            if (g.c()) {
                new chat.ola.vn.v.c().executeOnExecutor(h.R, bVar);
            } else {
                new chat.ola.vn.v.c().execute(bVar);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void fetchUrl(String str, String str2) {
        fetchHttpUrl(str, null, null, null, str2);
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void fetchUrl(String str, String str2, String str3) {
        fetchHttpUrl(str, str2, null, null, str3);
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public String getClientPhone(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.10
            @Override // java.lang.Runnable
            public void run() {
                try {
                    String str2 = h.S;
                    if (m.a(str2)) {
                        str2 = "";
                    }
                    WebAppInterfaceImp.this.c.loadUrl("javascript:OLAPI.resultForCallback(" + str + ",'" + str2 + "')");
                } catch (Throwable unused) {
                }
            }
        });
        return "";
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void getHtmlFromPage(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.7
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.util.b.o(WebAppInterfaceImp.this.a, str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public int getTopActionBarHeight(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.20
            @Override // java.lang.Runnable
            public void run() {
                if (WebAppInterfaceImp.this.b == 0) {
                    WebAppInterfaceImp.this.b = 8;
                    try {
                        WebAppInterfaceImp.this.b = OlaApplication.b().getDimensionPixelSize(R.dimen.metric_8dp);
                    } catch (Throwable unused) {
                    }
                }
                WebAppInterfaceImp.this.c.loadUrl("javascript:OLAPI.resultForCallback(" + str + "," + WebAppInterfaceImp.this.b + ")");
            }
        });
        return 0;
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void hi(String str) {
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void onCloseApp() {
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void onSignInComplete(String str, String str2, Long l) {
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void onSignUpComplete(String str, String str2) {
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void onVisibleActionBar(String str) {
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openApp(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.11
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.m.m.a(WebAppInterfaceImp.this.a, str, str2);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openHttp(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.1
            @Override // java.lang.Runnable
            public void run() {
                if (m.a(str)) {
                    return;
                }
                chat.ola.vn.util.b.o(WebAppInterfaceImp.this.a, str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openHttpTrust(String str) {
        try {
            chat.ola.vn.util.b.n(this.a, str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openMeByClan(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.17
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.me.c.a(WebAppInterfaceImp.this.a, OlaApplication.b, "#" + str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openMeByNick(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.16
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.me.c.a(WebAppInterfaceImp.this.a, OlaApplication.b, str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openMedia(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.18
            @Override // java.lang.Runnable
            public void run() {
                switch (o.g(str)) {
                    case 1:
                        OlaImageViewerActivity.a(WebAppInterfaceImp.this.a, (View) null, (Bitmap) null, 0, OlaMediaEntity.a(str));
                        break;
                    case 2:
                        chat.ola.vn.util.b.h(WebAppInterfaceImp.this.a, str);
                        break;
                    case 3:
                        chat.ola.vn.util.b.f(WebAppInterfaceImp.this.a, str);
                        break;
                }
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openMedias(final String[] strArr, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.19
            @Override // java.lang.Runnable
            public void run() {
                OlaImageViewerActivity.a(WebAppInterfaceImp.this.a, (View) null, (Bitmap) null, i, OlaMediaEntity.a(strArr));
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void openRss(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.12
            @Override // java.lang.Runnable
            public void run() {
                j.a(WebAppInterfaceImp.this.a, "rss://" + str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void playSoundUrl(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.21
            @Override // java.lang.Runnable
            public void run() {
                if (m.a(str)) {
                    return;
                }
                chat.ola.vn.util.b.e(WebAppInterfaceImp.this.a, str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void playSoundUrls(final String str, int i, int i2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.15
            @Override // java.lang.Runnable
            public void run() {
                try {
                    ArrayList arrayList = new ArrayList();
                    try {
                        JSONArray jSONArray = new JSONArray(str);
                        int length = jSONArray.length();
                        for (int i3 = 0; i3 < length; i3++) {
                            JSONObject jSONObject = jSONArray.getJSONObject(i3);
                            String string = jSONObject.has("url") ? jSONObject.getString("url") : null;
                            if (!m.a(string)) {
                                String string2 = jSONObject.has("thumb") ? jSONObject.getString("thumb") : null;
                                String string3 = jSONObject.has("title") ? jSONObject.getString("title") : null;
                                String string4 = jSONObject.has("sub") ? jSONObject.getString("sub") : null;
                                OlaMediaEntity olaMediaEntity = new OlaMediaEntity(string, 3, (short) 3);
                                olaMediaEntity.a(string2);
                                olaMediaEntity.b(string3);
                                olaMediaEntity.c(string4);
                                arrayList.add(olaMediaEntity);
                            }
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                    if (arrayList == null || arrayList.isEmpty()) {
                        return;
                    }
                    chat.ola.vn.util.b.e(WebAppInterfaceImp.this.a, ((OlaMediaEntity) arrayList.get(0)).c());
                } catch (Throwable th2) {
                    th2.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void playVideoUrl(String str, int i) {
        try {
            chat.ola.vn.util.b.d(this.a, str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void playYoutubes(final String[] strArr, final int i, int i2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.14
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.util.b.a(WebAppInterfaceImp.this.a, (List<String>) Arrays.asList(strArr), i);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void requestShowPostMeRssForm(final String str, final String str2, final String str3) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.4
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        String strJsTrim = WebAppInterfaceImp.this.jsTrim(str3);
                        if (strJsTrim != null) {
                            OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, WebAppInterfaceImp.this.jsTrim(str), WebAppInterfaceImp.this.jsTrim(str2), strJsTrim);
                        } else {
                            OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, WebAppInterfaceImp.this.jsTrim(str), WebAppInterfaceImp.this.jsTrim(str2), (String) null);
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void sendSms(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.13
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (chat.ola.vn.c.x() && n.b(WebAppInterfaceImp.this.a)) {
                        OlaSmsSendingActivity.a(WebAppInterfaceImp.this.a, str, str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void showPostMeForm(final long j, final String str, final String str2, final String str3, final String[] strArr) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.5
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        ArrayList arrayList = null;
                        int i = 0;
                        if (j <= 0) {
                            if (strArr != null) {
                                arrayList = new ArrayList(strArr.length);
                                while (i < strArr.length) {
                                    arrayList.add(strArr[i]);
                                    i++;
                                }
                            }
                            OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, str, str2, arrayList);
                            return;
                        }
                        if (m.a(str3)) {
                            if (strArr != null) {
                                arrayList = new ArrayList(strArr.length);
                                while (i < strArr.length) {
                                    arrayList.add(strArr[i]);
                                    i++;
                                }
                            }
                            OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, str, str2, arrayList, j);
                            return;
                        }
                        if (m.b(str3, "1")) {
                            if (strArr == null || strArr.length <= 0) {
                                OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, str2, (String) null, (String) null, j);
                            } else {
                                OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, str2, (String) null, strArr[0], j);
                            }
                        }
                    } catch (Throwable th) {
                        try {
                            th.printStackTrace();
                        } catch (Throwable th2) {
                            th2.printStackTrace();
                        }
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void showReplyMeForm(final long j, final String str) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.6
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        OlaMeComposerActivity.a(WebAppInterfaceImp.this.a, str, (String) null, j);
                    } catch (Throwable th) {
                        try {
                            th.printStackTrace();
                        } catch (Throwable th2) {
                            th2.printStackTrace();
                        }
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void showToast(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.8
            @Override // java.lang.Runnable
            public void run() {
                if (m.a(str)) {
                    return;
                }
                chat.ola.vn.util.j.a(WebAppInterfaceImp.this.a, str);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void startChatGroup(final String str) {
        if (m.a(str)) {
            return;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.2
            @Override // java.lang.Runnable
            public void run() {
                OlaChatViewActivity.a(WebAppInterfaceImp.this.a, OlaApplication.b, str, (short) 2);
            }
        });
    }

    @Override // chat.ola.vn.util.http.IWebAppInterface
    @JavascriptInterface
    public void startChatOla(final String str) {
        if (m.a(str)) {
            return;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.http.WebAppInterfaceImp.22
            @Override // java.lang.Runnable
            public void run() {
                OlaChatViewActivity.a(WebAppInterfaceImp.this.a, OlaApplication.b, str, (short) 0);
            }
        });
    }
}
