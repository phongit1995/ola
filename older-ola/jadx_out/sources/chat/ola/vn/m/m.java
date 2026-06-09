package chat.ola.vn.m;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.AdapterView;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.note.OlaNoteComposerActivity;
import chat.ola.vn.util.http.WebAppInterfaceImp;
import chat.ola.vn.view.OlaCachedImageView;
import java.net.URL;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class m extends chat.ola.vn.m.a implements View.OnClickListener {
    private static String a = null;
    private static String b = "";
    private static m o;
    private WebView d;
    private TextView e;
    private View f;
    private ImageView g;
    private View h;
    private View i;
    private OlaCachedImageView j;
    private View k;
    private String c = null;
    private boolean l = false;

    private class a extends WebAppInterfaceImp {
        public a(Context context, WebView webView) {
            super(context, webView);
        }

        @Override // chat.ola.vn.util.http.WebAppInterfaceImp, chat.ola.vn.util.http.IWebAppInterface
        public int getTopActionBarHeight(final String str) {
            try {
                if (m.this.i.getVisibility() != 8) {
                    return super.getTopActionBarHeight(str);
                }
                this.b = OlaApplication.b().getDimensionPixelSize(R.dimen.metric_48dp);
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.m.a.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            m.this.d.loadUrl("javascript:OLAPI.resultForCallback(" + str + "," + a.this.b + ")");
                        } catch (Throwable unused) {
                        }
                    }
                });
                return this.b;
            } catch (Throwable th) {
                th.printStackTrace();
                return 0;
            }
        }

        @Override // chat.ola.vn.util.http.WebAppInterfaceImp, chat.ola.vn.util.http.IWebAppInterface
        @JavascriptInterface
        public void onCloseApp() {
            super.onCloseApp();
            try {
                m.this.getActivity().runOnUiThread(new Runnable() { // from class: chat.ola.vn.m.m.a.3
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            m.this.d();
                        } catch (Exception e) {
                            chat.ola.vn.util.j.a(m.this.getActivity(), "onCloseApp #" + e.getMessage());
                        }
                    }
                });
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.util.http.WebAppInterfaceImp, chat.ola.vn.util.http.IWebAppInterface
        @JavascriptInterface
        public void onVisibleActionBar(final String str) {
            try {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.m.a.1
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (chat.ola.vn.util.m.a("1", str)) {
                                m.this.a(true);
                            } else {
                                m.this.a(false);
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                });
            } catch (Throwable unused) {
            }
        }
    }

    public static void a(Context context, String str, String str2) {
        if (o != null) {
            o.f(str, str2);
        } else {
            b = str2;
            if (str2 == null) {
                b = "";
            }
            a = str;
        }
        OlaBottomTabActivity.a(context, 8);
    }

    private void a(OlaCachedImageView olaCachedImageView, String str) {
        chat.ola.vn.c.t.a().a(str, olaCachedImageView, ((olaCachedImageView.getWidth() - olaCachedImageView.getPaddingLeft()) - olaCachedImageView.getPaddingRight()) - 20);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        if (z) {
            if (this.i.getVisibility() != 0) {
                FrameLayout.LayoutParams layoutParams = (FrameLayout.LayoutParams) this.d.getLayoutParams();
                layoutParams.topMargin = getResources().getDimensionPixelSize(R.dimen.metric_topbar_noshadow_42dp);
                this.d.setLayoutParams(layoutParams);
                this.i.setVisibility(0);
                return;
            }
            return;
        }
        if (this.i.getVisibility() != 8) {
            FrameLayout.LayoutParams layoutParams2 = (FrameLayout.LayoutParams) this.d.getLayoutParams();
            layoutParams2.topMargin = 0;
            this.d.setLayoutParams(layoutParams2);
            this.i.setVisibility(8);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        try {
            this.d.stopLoading();
            e();
            this.d.clearHistory();
            OlaBottomTabActivity olaBottomTabActivityA = a();
            if (olaBottomTabActivityA != null) {
                olaBottomTabActivityA.i();
            }
            a().d(c());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @TargetApi(18)
    private void e() {
        try {
            this.d.clearView();
            this.d.clearHistory();
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean f(String str) {
        try {
            return chat.ola.vn.util.m.b(str, "http://mobile.ola.vn/");
        } catch (Throwable unused) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean g(String str) {
        try {
            if (str.toLowerCase().startsWith("https://play.google.com/store/apps")) {
                return true;
            }
            return str.toLowerCase().startsWith("play.google.com/store/apps");
        } catch (Throwable unused) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(String str) {
        try {
            String strI = chat.ola.vn.util.m.i(str);
            if (this.d.canGoBack()) {
                this.k.setVisibility(0);
            } else {
                this.k.setVisibility(8);
            }
            if (chat.ola.vn.util.m.a(strI)) {
                this.j.setVisibility(8);
                this.g.setVisibility(0);
                this.g.setImageResource(R.drawable.ic_action_tab_album_selected);
                this.k.setVisibility(8);
                this.l = false;
                return;
            }
            this.l = true;
            this.h.setVisibility(8);
            if (chat.ola.vn.util.m.b(strI, "note")) {
                this.g.setImageResource(R.drawable.ic_action_edit);
                this.g.setTag(strI);
                this.g.setVisibility(8);
                this.h.setVisibility(0);
                this.j.setImageResource(R.drawable.ic_tab_note);
                this.j.setTag(strI);
                this.j.setVisibility(0);
                return;
            }
            if (chat.ola.vn.util.m.b(strI, "osimi")) {
                this.j.setImageResource(R.drawable.ic_tab_osimi);
                this.j.setTag(strI);
                this.j.setVisibility(0);
            } else if (chat.ola.vn.util.m.b(strI, "hrsc")) {
                this.j.setImageResource(R.drawable.app_icon_horoscope);
                this.j.setTag(strI);
                this.j.setVisibility(0);
            } else if (chat.ola.vn.util.m.b(strI, "adme")) {
                this.j.setImageResource(R.drawable.app_icon_adme);
                this.j.setTag(strI);
                this.j.setVisibility(0);
            } else {
                try {
                    chat.ola.vn.entry.e eVarA = chat.ola.vn.h.v.a(strI);
                    if (!chat.ola.vn.util.m.a(eVarA.b())) {
                        a(this.j, eVarA.b());
                    }
                } catch (Throwable unused) {
                    this.j.setImageResource(R.drawable.ola_logo_trans);
                }
                this.j.setTag(strI);
                this.j.setVisibility(0);
            }
            this.g.setVisibility(8);
        } catch (Throwable unused2) {
        }
    }

    private boolean i(String str) {
        try {
            if (chat.ola.vn.util.m.b(str, "mall")) {
                return false;
            }
            return !chat.ola.vn.util.m.b(str, "adme");
        } catch (Throwable unused) {
            return true;
        }
    }

    private void j(String str) {
    }

    @Override // chat.ola.vn.m.f
    public void b(Bundle bundle) {
        super.b(bundle);
        o = this;
        f(a, b);
        setHasOptionsMenu(true);
    }

    public int c() {
        return 8;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void e(String str) {
        TextView textView;
        int i;
        if (chat.ola.vn.util.m.c(str)) {
            textView = this.e;
            i = 8;
        } else {
            this.e.setText(str);
            textView = this.e;
            i = 0;
        }
        textView.setVisibility(i);
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return super.e_();
    }

    public void f(String str, String str2) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        e();
        a = str;
        String strA = chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), a, (String) null, true);
        if (chat.ola.vn.util.m.a(strA)) {
            strA = chat.ola.vn.util.http.a.b(chat.ola.vn.h.f(), a, null, true);
        }
        if (i(str)) {
            a(true);
        } else {
            a(false);
        }
        this.d.clearHistory();
        this.d.loadUrl(strA);
        e(str2);
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        try {
            if (this.d == null || !this.d.canGoBack()) {
                d();
                return false;
            }
            this.d.goBack();
            return true;
        } catch (Throwable th) {
            th.printStackTrace();
            return false;
        }
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_exit));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.m.2
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        if (chat.ola.vn.util.m.b(m.this.getString(R.string.string_exit), (String) arrayList.get(i))) {
                            m.this.d();
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
            return mVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.editImageButton) {
                OlaNoteComposerActivity.a(getActivity());
                return;
            }
            if (id == R.id.olaActionBarBackImageView) {
                g_();
                return;
            }
            if (id != R.id.olaActionBarButtonImageView) {
                if (id != R.id.olaActionBarCloseButtonImageView) {
                    return;
                }
            } else if (this.l) {
                j((String) view.getTag());
                return;
            } else if (chat.ola.vn.util.m.a(this.c)) {
                return;
            } else {
                startActivity(new Intent("android.intent.action.VIEW", Uri.parse(chat.ola.vn.util.http.c.h(this.c))));
            }
            d();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    @SuppressLint({"SetJavaScriptEnabled"})
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        try {
            if (chat.ola.vn.util.m.a(chat.ola.vn.h.f())) {
                d();
                return viewGroup;
            }
        } catch (Throwable unused) {
        }
        View viewInflate = layoutInflater.inflate(R.layout.web_app_view_layout, (ViewGroup) null);
        ImageView imageView = (ImageView) viewInflate.findViewById(R.id.olaActionBarCloseButtonImageView);
        imageView.setImageResource(R.drawable.ic_action_quit);
        imageView.setVisibility(0);
        imageView.setOnClickListener(this);
        this.i = viewInflate.findViewById(R.id.linearWrap);
        this.e = (TextView) viewInflate.findViewById(R.id.olaActionBarTitleTextView);
        this.j = (OlaCachedImageView) viewInflate.findViewById(R.id.olaActionBarIconImageView);
        this.k = viewInflate.findViewById(R.id.olaActionBarBackImageView);
        this.k.setOnClickListener(this);
        this.f = viewInflate.findViewById(R.id.progressBar);
        this.f.setVisibility(0);
        this.d = (WebView) viewInflate.findViewById(R.id.wvContent);
        this.d.getSettings().setJavaScriptEnabled(true);
        this.d.getSettings().setNeedInitialFocus(true);
        this.h = viewInflate.findViewById(R.id.editImageButton);
        this.h.setOnClickListener(this);
        this.g = (ImageView) viewInflate.findViewById(R.id.olaActionBarButtonImageView);
        this.g.setOnClickListener(this);
        this.d.requestFocus();
        this.d.getSettings().setJavaScriptEnabled(true);
        this.d.setWebViewClient(new WebViewClient() { // from class: chat.ola.vn.m.m.1
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView, String str) {
                try {
                    m.this.c = str;
                    super.onPageFinished(webView, str);
                    m.this.f.setVisibility(8);
                    m.this.h(str);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }

            @Override // android.webkit.WebViewClient
            public void onPageStarted(WebView webView, String str, Bitmap bitmap) {
                try {
                    String host = new URL(str).getHost();
                    if (!chat.ola.vn.util.m.b(host, "ola.vn")) {
                        if (!host.toLowerCase().endsWith(".ola.vn")) {
                            try {
                                m.this.e(new URL(str).getHost().toLowerCase());
                            } catch (Throwable unused2) {
                            }
                        }
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                m.this.f.setVisibility(0);
                if (m.this.g(str)) {
                    chat.ola.vn.util.b.m(m.this.getActivity(), str);
                    m.this.d();
                } else if (m.this.f(str)) {
                    m.this.d();
                } else {
                    super.onPageStarted(webView, str, bitmap);
                    m.this.h(str);
                }
            }

            @Override // android.webkit.WebViewClient
            public void onReceivedError(WebView webView, int i, String str, String str2) {
                try {
                    chat.ola.vn.i.i.b(m.this.getActivity(), R.string.dialog_title_confirm, R.string.message_web_app_can_not_load, R.string.string_reload, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.m.1.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i2) {
                            try {
                                dialogInterface.dismiss();
                            } catch (Throwable unused2) {
                            }
                        }
                    });
                    m.this.f.setVisibility(8);
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
                    if (str.toLowerCase().startsWith("http")) {
                        if (chat.ola.vn.util.http.a.a(str)) {
                            String strA = chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), str, (String) null, true);
                            if (chat.ola.vn.util.m.a(strA)) {
                                return false;
                            }
                            webView.loadUrl(strA);
                            return true;
                        }
                        String strG = chat.ola.vn.util.m.g(str);
                        if (!chat.ola.vn.util.m.a(strG)) {
                            chat.ola.vn.util.b.a(m.this.getActivity(), strG);
                            return true;
                        }
                        String strE = chat.ola.vn.util.m.e(str);
                        if (!chat.ola.vn.util.m.a(strE)) {
                            try {
                                chat.ola.vn.util.b.a(m.this.getActivity(), strE, 0, 0);
                            } catch (Throwable unused2) {
                            }
                            return true;
                        }
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                return super.shouldOverrideUrlLoading(webView, str);
            }
        });
        OlaBottomTabActivity olaBottomTabActivityA = a();
        if (olaBottomTabActivityA != null) {
            this.d.addJavascriptInterface(new a(olaBottomTabActivityA, this.d), "OLAPK");
        }
        return viewInflate;
    }

    @Override // android.support.v4.app.Fragment
    public void onDestroy() {
        o = null;
        super.onDestroy();
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        OlaBottomTabActivity olaBottomTabActivityA = a();
        if (olaBottomTabActivityA != null) {
            olaBottomTabActivityA.i();
        }
        super.onDetach();
        o = null;
        try {
            e();
            this.d.clearHistory();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
