package com.facebook.accountkit;

import android.content.Intent;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class AccessTokenTracker extends Tracker {
    public static final String ACTION_CURRENT_ACCESS_TOKEN_CHANGED = "com.facebook.accountkit.sdk.ACTION_CURRENT_ACCESS_TOKEN_CHANGED";
    public static final String EXTRA_NEW_ACCESS_TOKEN = "com.facebook.accountkit.sdk.EXTRA_NEW_ACCESS_TOKEN";
    public static final String EXTRA_OLD_ACCESS_TOKEN = "com.facebook.accountkit.sdk.EXTRA_OLD_ACCESS_TOKEN";

    public AccessTokenTracker() {
        startTracking();
    }

    @Override // com.facebook.accountkit.Tracker
    protected List<String> getActionsStateChanged() {
        return Collections.singletonList(ACTION_CURRENT_ACCESS_TOKEN_CHANGED);
    }

    protected abstract void onCurrentAccessTokenChanged(AccessToken accessToken, AccessToken accessToken2);

    @Override // com.facebook.accountkit.Tracker
    protected void onReceive(Intent intent) {
        onCurrentAccessTokenChanged((AccessToken) intent.getParcelableExtra(EXTRA_OLD_ACCESS_TOKEN), (AccessToken) intent.getParcelableExtra(EXTRA_NEW_ACCESS_TOKEN));
    }
}
