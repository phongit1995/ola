package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

/* JADX INFO: loaded from: classes.dex */
public class AccountKitEmailRedirectActivity extends Activity {
    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Intent intent = new Intent(this, (Class<?>) AccountKitActivity.class);
        intent.putExtra("url", getIntent().getDataString());
        intent.addFlags(335544320);
        startActivity(intent);
    }
}
