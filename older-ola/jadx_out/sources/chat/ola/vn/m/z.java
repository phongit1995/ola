package chat.ola.vn.m;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.util.http.WebAppInterfaceImp;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class z extends a implements View.OnClickListener {
    private static z a;
    private static String b;
    private final String c = chat.ola.vn.util.http.a.c("html/translate/view/");
    private WebView d;

    public static void a(Context context, String str) {
        if (a == null) {
            b = str;
        } else {
            a.f(str);
        }
        OlaBottomTabActivity.a(context, 5);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        this.d.loadUrl("javascript:OLAPI.translate('" + str.replace("'", "\\'").replace("\n", " ") + "')");
    }

    @Override // chat.ola.vn.m.f
    public void b(Bundle bundle) {
        super.b(bundle);
        a = this;
    }

    public int c() {
        return 5;
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_exit));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.z.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    if (chat.ola.vn.util.m.b(z.this.getString(R.string.string_exit), (String) arrayList.get(i))) {
                        OlaBottomTabActivity.a(z.this.getActivity(), 4);
                        OlaBottomTabActivity.h(z.this.c());
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.olaActionBarCloseButtonImageView) {
                return;
            }
            a().d(c());
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    @SuppressLint({"SetJavaScriptEnabled"})
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.web_app_view_layout, (ViewGroup) null);
        viewInflate.findViewById(R.id.olaActionBarCloseButtonImageView).setOnClickListener(this);
        this.d = (WebView) viewInflate.findViewById(R.id.wvContent);
        this.d.getSettings().setJavaScriptEnabled(true);
        this.d.getSettings().setNeedInitialFocus(true);
        try {
            ((ImageView) viewInflate.findViewById(R.id.olaActionBarIconImageView)).setImageResource(R.drawable.ic_tab_translater);
            viewInflate.findViewById(R.id.olaActionBarBackImageView).setVisibility(8);
            ((TextView) viewInflate.findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_translater);
        } catch (Throwable unused) {
        }
        OlaBottomTabActivity olaBottomTabActivityA = a();
        if (olaBottomTabActivityA != null) {
            this.d.addJavascriptInterface(new WebAppInterfaceImp(olaBottomTabActivityA, this.d), "OLAPK");
        }
        String strA = chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), this.c, (String) null, true);
        if (!chat.ola.vn.util.m.a(strA)) {
            this.d.loadUrl(strA);
        }
        this.d.requestFocus();
        this.d.setWebViewClient(new WebViewClient() { // from class: chat.ola.vn.m.z.1
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView, String str) {
                super.onPageFinished(webView, str);
                if (chat.ola.vn.util.m.a(z.b)) {
                    return;
                }
                z.this.f(z.b);
                String unused2 = z.b = null;
            }

            @Override // android.webkit.WebViewClient
            public void onReceivedError(WebView webView, int i, String str, String str2) {
                webView.loadDataWithBaseURL("", "", null, null, null);
            }
        });
        return viewInflate;
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        a = null;
        super.onDetach();
    }

    @Override // android.support.v4.app.Fragment
    public void onPause() {
        super.onPause();
    }
}
