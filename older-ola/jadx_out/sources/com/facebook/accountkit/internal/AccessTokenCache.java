package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.annotation.VisibleForTesting;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import java.util.Date;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class AccessTokenCache {
    private static final String ACCESS_TOKEN_ACCOUNT_ID_KEY = "account_id";
    private static final String ACCESS_TOKEN_APPLICATION_ID_KEY = "application_id";
    private static final String ACCESS_TOKEN_LAST_REFRESH_KEY = "last_refresh";
    private static final String ACCESS_TOKEN_REFRESH_INTERVAL_KEY = "tokenRefreshIntervalInSeconds";
    private static final String ACCESS_TOKEN_TOKEN_KEY = "token";
    private static final String ACCESS_TOKEN_VERSION_KEY = "version";
    private static final int ACCESS_TOKEN_VERSION_VALUE = 1;
    static final String CACHED_ACCESS_TOKEN_KEY = "com.facebook.accountkit.AccessTokenManager.CachedAccessToken";
    private final SharedPreferences sharedPreferences;

    AccessTokenCache(Context context) {
        this(context.getSharedPreferences("com.facebook.accountkit.AccessTokenManager.SharedPreferences", 0));
    }

    @VisibleForTesting
    AccessTokenCache(SharedPreferences sharedPreferences) {
        this.sharedPreferences = sharedPreferences;
    }

    @VisibleForTesting
    static AccessToken deserializeAccessToken(JSONObject jSONObject) {
        if (jSONObject.getInt("version") > 1) {
            throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.INVALID_ACCESS_TOKEN_FORMAT);
        }
        return new AccessToken(jSONObject.getString("token"), jSONObject.getString(ACCESS_TOKEN_ACCOUNT_ID_KEY), jSONObject.getString(ACCESS_TOKEN_APPLICATION_ID_KEY), jSONObject.getLong(ACCESS_TOKEN_REFRESH_INTERVAL_KEY), new Date(jSONObject.getLong(ACCESS_TOKEN_LAST_REFRESH_KEY)));
    }

    @VisibleForTesting
    static JSONObject serializeAccessToken(AccessToken accessToken) throws JSONException {
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("version", 1);
        jSONObject.put(ACCESS_TOKEN_ACCOUNT_ID_KEY, accessToken.getAccountId());
        jSONObject.put(ACCESS_TOKEN_APPLICATION_ID_KEY, accessToken.getApplicationId());
        jSONObject.put(ACCESS_TOKEN_REFRESH_INTERVAL_KEY, accessToken.getTokenRefreshIntervalSeconds());
        jSONObject.put(ACCESS_TOKEN_LAST_REFRESH_KEY, accessToken.getLastRefresh().getTime());
        jSONObject.put("token", accessToken.getToken());
        return jSONObject;
    }

    public void clear() {
        this.sharedPreferences.edit().remove(CACHED_ACCESS_TOKEN_KEY).apply();
    }

    public AccessToken load() {
        String string = this.sharedPreferences.getString(CACHED_ACCESS_TOKEN_KEY, null);
        if (string != null) {
            try {
                return deserializeAccessToken(new JSONObject(string));
            } catch (JSONException unused) {
            }
        }
        return null;
    }

    public void save(@NonNull AccessToken accessToken) {
        try {
            this.sharedPreferences.edit().putString(CACHED_ACCESS_TOKEN_KEY, serializeAccessToken(accessToken).toString()).apply();
        } catch (JSONException unused) {
        }
    }
}
