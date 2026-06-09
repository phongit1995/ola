package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.i.i;
import chat.ola.vn.util.http.WebAppInterfaceImp;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class OlaWebLoginActivity extends Activity implements View.OnClickListener {
    private WebView a;
    private ProgressBar b;

    private class a extends WebAppInterfaceImp {
        public a(Context context, WebView webView) {
            super(context, webView);
        }

        @Override // chat.ola.vn.util.http.WebAppInterfaceImp, chat.ola.vn.util.http.IWebAppInterface
        @JavascriptInterface
        public void onSignInComplete(String str, String str2, Long l) {
            try {
                super.onSignInComplete(str, str2, l);
                if (!OlaApplication.b.i() && !OlaApplication.b.h()) {
                    long jCurrentTimeMillis = System.currentTimeMillis();
                    if (l != null) {
                        jCurrentTimeMillis = l.longValue();
                    }
                    OlaApplication.b.t().a(str, (String) null, str2, (String) null, jCurrentTimeMillis, (short) 0);
                }
                OlaWebLoginActivity.this.finish();
            } catch (Throwable unused) {
            }
        }
    }

    @Override // android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        if (view.getId() != R.id.btnActionButtonRight) {
            return;
        }
        finish();
    }

    @Override // android.app.Activity
    @SuppressLint({"SetJavaScriptEnabled"})
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_web_login_layout);
        findViewById(R.id.btnActionButtonRight).setOnClickListener(this);
        this.b = (ProgressBar) findViewById(R.id.progressBar);
        this.a = (WebView) findViewById(R.id.wvContent);
        this.a.getSettings().setJavaScriptEnabled(true);
        this.a.getSettings().setNeedInitialFocus(true);
        this.a.setScrollBarStyle(0);
        this.a.requestFocus();
        this.a.setWebViewClient(new WebViewClient() { // from class: chat.ola.vn.activity.OlaWebLoginActivity.1
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView, String str) {
                try {
                    super.onPageFinished(webView, str);
                    OlaWebLoginActivity.this.b.setVisibility(8);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }

            @Override // android.webkit.WebViewClient
            public void onPageStarted(WebView webView, String str, Bitmap bitmap) {
                OlaWebLoginActivity.this.b.setVisibility(0);
                super.onPageStarted(webView, str, bitmap);
            }

            @Override // android.webkit.WebViewClient
            public void onReceivedError(final WebView webView, int i, String str, final String str2) {
                try {
                    i.b(OlaWebLoginActivity.this, R.string.dialog_title_confirm, R.string.message_web_app_can_not_load, R.string.string_reload, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaWebLoginActivity.1.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i2) {
                            if (i2 == 0) {
                                try {
                                    webView.loadUrl(str2);
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    OlaWebLoginActivity.this.b.setVisibility(8);
                } catch (Throwable th) {
                    try {
                        th.printStackTrace();
                    } catch (Throwable th2) {
                        th2.printStackTrace();
                    }
                }
            }

            @Override // android.webkit.WebViewClient
            public boolean shouldOverrideUrlLoading(WebView webView, String str) {
                try {
                    if (str.toLowerCase().startsWith("http") && chat.ola.vn.util.http.a.a(str)) {
                        String strA = chat.ola.vn.util.http.a.a((String) null, str, (String) null, false);
                        if (m.a(strA)) {
                            return false;
                        }
                        webView.loadUrl(strA);
                        return true;
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                return super.shouldOverrideUrlLoading(webView, str);
            }
        });
        this.a.addJavascriptInterface(new a(this, this.a), "OLAPK");
        String strA = chat.ola.vn.util.http.a.a((String) null, "id/signin", (String) null, false);
        if (m.a(strA)) {
            return;
        }
        this.a.loadUrl(strA);
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        try {
            this.a.stopLoading();
        } catch (Throwable unused) {
        }
        super.onDestroy();
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaWebLoginActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        i.a(OlaWebLoginActivity.this, R.string.dialog_title_inform, R.string.message_login_fail_and_please_try_again);
                    } catch (Throwable unused) {
                    }
                }
            }, 2000L);
        } catch (Throwable unused) {
        }
    }
}
