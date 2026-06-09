package chat.ola.vn.util.http;

import android.webkit.JavascriptInterface;

/* JADX INFO: loaded from: classes.dex */
public interface IWebAppInterface {
    @JavascriptInterface
    void copyToClipboard(String str);

    @JavascriptInterface
    void createOlaMallShortcut();

    @JavascriptInterface
    void fetchHttpUrl(String str, String str2, String str3, String str4, String str5);

    @JavascriptInterface
    void fetchUrl(String str, String str2);

    @JavascriptInterface
    void fetchUrl(String str, String str2, String str3);

    @JavascriptInterface
    String getClientPhone(String str);

    @JavascriptInterface
    void getHtmlFromPage(String str);

    @JavascriptInterface
    int getTopActionBarHeight(String str);

    @JavascriptInterface
    void hi(String str);

    @JavascriptInterface
    void onCloseApp();

    @JavascriptInterface
    void onSignInComplete(String str, String str2, Long l);

    @JavascriptInterface
    void onSignUpComplete(String str, String str2);

    @JavascriptInterface
    void onVisibleActionBar(String str);

    @JavascriptInterface
    void openApp(String str, String str2);

    @JavascriptInterface
    void openHttp(String str);

    @JavascriptInterface
    void openHttpTrust(String str);

    @JavascriptInterface
    void openMeByClan(String str);

    @JavascriptInterface
    void openMeByNick(String str);

    @JavascriptInterface
    void openMedia(String str);

    @JavascriptInterface
    void openMedias(String[] strArr, int i);

    @JavascriptInterface
    void openRss(String str);

    @JavascriptInterface
    void playSoundUrl(String str);

    @JavascriptInterface
    void playSoundUrls(String str, int i, int i2);

    @JavascriptInterface
    void playVideoUrl(String str, int i);

    @JavascriptInterface
    void playYoutubes(String[] strArr, int i, int i2);

    @JavascriptInterface
    void requestShowPostMeRssForm(String str, String str2, String str3);

    @JavascriptInterface
    void sendSms(String str, String str2);

    @JavascriptInterface
    void showPostMeForm(long j, String str, String str2, String str3, String[] strArr);

    @JavascriptInterface
    void showReplyMeForm(long j, String str);

    @JavascriptInterface
    void showToast(String str);

    @JavascriptInterface
    void startChatGroup(String str);

    @JavascriptInterface
    void startChatOla(String str);
}
