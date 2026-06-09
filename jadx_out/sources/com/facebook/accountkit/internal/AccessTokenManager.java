package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccessTokenTracker;

/* JADX INFO: loaded from: classes.dex */
final class AccessTokenManager {
    static final String SHARED_PREFERENCES_NAME = "com.facebook.accountkit.AccessTokenManager.SharedPreferences";
    private final AccessTokenCache accessTokenCache;
    private AccessToken currentAccessToken;
    private final LocalBroadcastManager localBroadcastManager;

    AccessTokenManager(Context context, LocalBroadcastManager localBroadcastManager) {
        this(new AccessTokenCache(context), localBroadcastManager);
    }

    AccessTokenManager(@NonNull AccessTokenCache accessTokenCache, @NonNull LocalBroadcastManager localBroadcastManager) {
        this.accessTokenCache = accessTokenCache;
        this.localBroadcastManager = localBroadcastManager;
    }

    private void sendCurrentAccessTokenChangedBroadcast(AccessToken accessToken, AccessToken accessToken2) {
        Intent intent = new Intent(AccessTokenTracker.ACTION_CURRENT_ACCESS_TOKEN_CHANGED);
        intent.putExtra(AccessTokenTracker.EXTRA_OLD_ACCESS_TOKEN, accessToken);
        intent.putExtra(AccessTokenTracker.EXTRA_NEW_ACCESS_TOKEN, accessToken2);
        this.localBroadcastManager.sendBroadcast(intent);
    }

    private void setCurrentAccessToken(AccessToken accessToken, boolean z) {
        AccessToken accessToken2 = this.currentAccessToken;
        this.currentAccessToken = accessToken;
        if (z) {
            if (accessToken != null) {
                this.accessTokenCache.save(accessToken);
            } else {
                this.accessTokenCache.clear();
            }
        }
        if (Utility.areObjectsEqual(accessToken2, accessToken)) {
            return;
        }
        sendCurrentAccessTokenChangedBroadcast(accessToken2, accessToken);
    }

    AccessToken getCurrentAccessToken() {
        return this.currentAccessToken;
    }

    boolean loadCurrentAccessToken() {
        AccessToken accessTokenLoad = this.accessTokenCache.load();
        if (accessTokenLoad == null) {
            return false;
        }
        setCurrentAccessToken(accessTokenLoad, false);
        return true;
    }

    void refreshCurrentAccessToken(AccessToken accessToken) {
        setCurrentAccessToken(new AccessToken(accessToken.getToken(), accessToken.getAccountId(), accessToken.getApplicationId(), accessToken.getTokenRefreshIntervalSeconds(), null));
    }

    void setCurrentAccessToken(AccessToken accessToken) {
        setCurrentAccessToken(accessToken, true);
    }
}
