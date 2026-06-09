package chat.ola.vn.i;

import android.content.Context;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.AutoScrollTextView;

/* JADX INFO: loaded from: classes.dex */
public class o extends n implements View.OnClickListener {
    private WebView a;
    private View b;
    private Button c;
    private Button d;
    private Runnable e;
    private Runnable f;

    public o(Context context, int i, String str) {
        super(context);
        this.j = true;
        setContentView(R.layout.change_log_layout);
        ((AutoScrollTextView) findViewById(R.id.txtItemTitle)).setText(i);
        this.b = findViewById(R.id.bottomButtonSpan);
        this.c = (Button) findViewById(R.id.btnLeft);
        this.d = (Button) findViewById(R.id.btnRight);
        this.c.setOnClickListener(this);
        this.d.setOnClickListener(this);
        findViewById(R.id.btnButton1).setOnClickListener(this);
        this.a = (WebView) findViewById(R.id.webView);
        try {
            String strA = com.mg.ola.common.d.e.a(OlaApplication.a().getAssets().open(str), com.mg.ola.common.d.a.f);
            if (chat.ola.vn.util.m.a(strA)) {
                return;
            }
            this.a.loadDataWithBaseURL("file:///android_asset/", strA, "text/html", "UTF-8", null);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static o a(Context context, int i, String str) {
        o oVar = new o(context, i, str);
        oVar.show();
        return oVar;
    }

    public void a(int i, Runnable runnable) {
        this.b.setVisibility(0);
        this.c.setText(i);
        this.c.setVisibility(0);
        this.e = runnable;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        Runnable runnable;
        try {
            int id = view.getId();
            if (id == R.id.btnButton1) {
                dismiss();
                return;
            }
            if (id == R.id.btnLeft) {
                dismiss();
                runnable = this.e;
            } else {
                if (id != R.id.btnRight) {
                    return;
                }
                dismiss();
                runnable = this.f;
            }
            runnable.run();
        } catch (Throwable unused) {
        }
    }
}
