package com.facebook.accountkit.internal;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.util.Log;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.Tracker;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import com.facebook.accountkit.internal.LoginModelImpl;
import java.lang.ref.WeakReference;
import java.util.Date;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
abstract class LoginController<E extends LoginModelImpl> {
    static final String GRAPH_PATH_LOGIN_REQUEST_CONFIRM = "confirm_login";
    static final String GRAPH_PATH_LOGIN_REQUEST_STATUS = "poll_login";
    static final String GRAPH_PATH_LOGIN_START = "start_login";
    static final String GRAPH_PATH_SEAMLESS_REQUEST_CONFIRM = "instant_verification_login";
    static final String PARAMETER_ARGUMENT_FACEBOOK = "facebook";
    static final String PARAMETER_ARGUMENT_VOICE = "voice";
    private static final String PARAMETER_CREDENTIALS_TYPE = "credentials_type";
    static final String PARAMETER_FB_USER_TOKEN = "fb_user_token";
    static final String PARAMETER_FIELDS_TYPE = "fields";
    private static final String PARAMETER_LOGGING_REF = "logging_ref";
    private static final String PARAMETER_LOGIN_REQUEST_CODE = "login_request_code";
    static final String PARAMETER_REDIRECT_URI = "redirect_uri";
    static final String PARAMETER_RESPONSE_TYPE = "response_type";
    static final String PARAMETER_STATE = "state";
    private static final String TAG = "com.facebook.accountkit.internal.LoginController";
    final AccessTokenManager accessTokenManager;
    private final WeakReference<LoginManager> loginManagerRef;
    protected final E loginModel;

    class AccountVerifedCallback implements AccountKitGraphRequest.Callback {
        final LoginManager loginManager;

        AccountVerifedCallback(LoginManager loginManager) {
            this.loginManager = loginManager;
        }

        @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
        public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
            LoginStatus status;
            LoginStatus loginStatus;
            LoginStatus status2;
            LoginStatus loginStatus2;
            if (!this.loginManager.isActivityAvailable()) {
                Log.w(LoginController.TAG, "Warning: Callback issues while activity not available.");
                return;
            }
            try {
                if (accountKitGraphResponse.getError() != null) {
                    LoginController.this.onError((AccountKitError) Utility.createErrorFromServerError(accountKitGraphResponse.getError()).first);
                    if (status != loginStatus) {
                        if (status2 != loginStatus2) {
                            return;
                        }
                    }
                    return;
                }
                try {
                    LoginController.this.extractAccessTokenOrCodeIntoModel(accountKitGraphResponse.getResponseObject());
                } catch (JSONException unused) {
                    LoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.INVALID_GRAPH_RESULTS_FORMAT);
                }
                LoginController.this.broadcastLoginStateChange();
                this.loginManager.onLoginComplete(LoginController.this.loginModel);
                if (LoginController.this.loginModel.getStatus() == LoginStatus.SUCCESS || LoginController.this.loginModel.getStatus() == LoginStatus.ERROR) {
                    this.loginManager.clearLogIn();
                }
            } finally {
                LoginController.this.broadcastLoginStateChange();
                this.loginManager.onLoginComplete(LoginController.this.loginModel);
                if (LoginController.this.loginModel.getStatus() == LoginStatus.SUCCESS || LoginController.this.loginModel.getStatus() == LoginStatus.ERROR) {
                    this.loginManager.clearLogIn();
                }
            }
        }
    }

    LoginController(@NonNull AccessTokenManager accessTokenManager, @NonNull LoginManager loginManager, @NonNull E e) {
        this.accessTokenManager = accessTokenManager;
        this.loginManagerRef = new WeakReference<>(loginManager);
        this.loginModel = e;
    }

    private boolean isLoginRequestPath(String str) {
        return Utility.areObjectsEqual(str, GRAPH_PATH_LOGIN_START) || Utility.areObjectsEqual(str, GRAPH_PATH_LOGIN_REQUEST_STATUS) || Utility.areObjectsEqual(str, GRAPH_PATH_LOGIN_REQUEST_CONFIRM);
    }

    void broadcastLoginStateChange() {
        LoginManager loginManager = getLoginManager();
        if (loginManager == null) {
            return;
        }
        loginManager.getLocalBroadcastManager().sendBroadcast(new Intent(getLoginStateChangedIntentName()).putExtra(Tracker.EXTRA_LOGIN_MODEL, this.loginModel).putExtra(Tracker.EXTRA_LOGIN_STATUS, this.loginModel.getStatus()).putExtra(Tracker.EXTRA_LOGIN_ERROR, this.loginModel.getError()));
    }

    AccountKitGraphRequest buildGraphRequest(String str, Bundle bundle) {
        Bundle bundle2 = new Bundle();
        Utility.putNonNullString(bundle2, PARAMETER_CREDENTIALS_TYPE, getCredentialsType());
        Utility.putNonNullString(bundle2, "login_request_code", this.loginModel.getLoginRequestCode());
        Utility.putNonNullString(bundle2, PARAMETER_LOGGING_REF, getLoginManager() != null ? getLoginManager().getLogger().getLoggingRef() : null);
        bundle2.putAll(bundle);
        return new AccountKitGraphRequest(null, str, bundle2, isLoginRequestPath(str), HttpMethod.POST);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    void extractAccessTokenOrCodeIntoModel(JSONObject jSONObject) throws JSONException {
        if (Utility.areObjectsEqual(this.loginModel.getResponseType(), AccountKitGraphConstants.TOKEN_RESPONSE_TYPE)) {
            AccessToken accessToken = new AccessToken(jSONObject.getString("access_token"), jSONObject.getString("id"), AccountKit.getApplicationId(), Long.parseLong(jSONObject.getString(AccountKitGraphConstants.TOKEN_REFRESH_INTERVAL_SEC)), new Date());
            this.accessTokenManager.setCurrentAccessToken(accessToken);
            this.loginModel.setFinalAuthState(jSONObject.optString("state"));
            this.loginModel.setAccessToken(accessToken);
        } else {
            this.loginModel.setCode(jSONObject.getString("code"));
            this.loginModel.setFinalAuthState(jSONObject.optString("state"));
        }
        this.loginModel.setStatus(LoginStatus.SUCCESS);
    }

    protected abstract String getCredentialsType();

    LoginManager getLoginManager() {
        LoginManager loginManager = this.loginManagerRef.get();
        if (loginManager == null) {
            return null;
        }
        if (loginManager.isActivityAvailable()) {
            return loginManager;
        }
        Log.w(TAG, "Warning: Callback issues while activity not available.");
        return null;
    }

    public E getLoginModel() {
        return this.loginModel;
    }

    protected abstract String getLoginStateChangedIntentName();

    public abstract void logIn(String str);

    public abstract void onAccountVerified();

    public abstract void onCancel();

    protected void onError(AccountKitError.Type type, InternalAccountKitError internalAccountKitError) {
        onError(new AccountKitError(type, internalAccountKitError));
    }

    public void onError(AccountKitError accountKitError) {
        this.loginModel.setError(accountKitError);
        this.loginModel.setStatus(LoginStatus.ERROR);
        LoginManager loginManager = getLoginManager();
        if (loginManager == null) {
            return;
        }
        loginManager.cancel(this.loginModel);
    }

    public abstract void onPending();
}
