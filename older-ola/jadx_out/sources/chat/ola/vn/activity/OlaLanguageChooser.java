package chat.ola.vn.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.c.x;

/* JADX INFO: loaded from: classes.dex */
public class OlaLanguageChooser extends c implements View.OnClickListener {
    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaLanguageChooser.class));
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        String str = "default";
        switch (view.getId()) {
            case R.id.btnLanguageEnglish /* 2131296472 */:
                str = "en";
                break;
            case R.id.btnLanguageVietnamese /* 2131296473 */:
                str = "vi";
                break;
        }
        x.b(str);
        h();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.language_chooser_layout);
        findViewById(R.id.btnLanguageVietnamese).setOnClickListener(this);
        findViewById(R.id.btnLanguageEnglish).setOnClickListener(this);
        findViewById(R.id.btnLanguageDefault).setOnClickListener(this);
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
    }
}
