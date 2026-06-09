package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public abstract class ContentControllerBase implements ContentController {
    protected final AccountKitConfiguration configuration;

    ContentControllerBase(AccountKitConfiguration accountKitConfiguration) {
        this.configuration = accountKitConfiguration;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public boolean isTransient() {
        return true;
    }

    protected abstract void logImpression();

    @Override // com.facebook.accountkit.ui.ContentController
    public void onActivityResult(int i, int i2, Intent intent) {
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void onPause(Activity activity) {
        ViewUtility.hideKeyboard(activity);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void onResume(Activity activity) {
        logImpression();
    }
}
