package com.facebook.accountkit.internal;

import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.util.Log;
import com.facebook.GraphRequest;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.EmailLoginTracker;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import com.facebook.accountkit.internal.LoginController;
import com.facebook.internal.ServerProtocol;
import java.util.Date;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class EmailLoginController extends LoginController<EmailLoginModelImpl> {
    private static final String PARAMETER_EMAIL = "email";
    private static final int SECONDS_TO_MILLIS = 1000;
    private static final String TAG = "com.facebook.accountkit.internal.EmailLoginController";

    private class LoginModelCodeCallback implements AccountKitGraphRequest.Callback {
        final EmailLoginModelImpl loginModel;

        LoginModelCodeCallback(EmailLoginModelImpl emailLoginModelImpl) {
            this.loginModel = emailLoginModelImpl;
        }

        /* JADX WARN: Finally extract failed */
        @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
        public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
            EmailLoginModelImpl emailLoginModelImpl;
            LoginStatus loginStatus;
            Utility.assertUIThread();
            LoginManager loginManager = EmailLoginController.this.getLoginManager();
            if (loginManager == null) {
                return;
            }
            if (!loginManager.isActivityAvailable() || !loginManager.isLoginInProgress()) {
                Log.w(EmailLoginController.TAG, "Warning: Callback issues while activity not available.");
                return;
            }
            try {
                if (accountKitGraphResponse.getError() != null) {
                    EmailLoginController.this.onError((AccountKitError) Utility.createErrorFromServerError(accountKitGraphResponse.getError()).first);
                    if (this.loginModel != null) {
                        switch (this.loginModel.getStatus()) {
                            case SUCCESS:
                            case ERROR:
                                loginManager.onLoginComplete(this.loginModel);
                                EmailLoginController.this.broadcastLoginStateChange();
                                loginManager.clearLogIn();
                                return;
                            default:
                                return;
                        }
                    }
                    return;
                }
                JSONObject responseObject = accountKitGraphResponse.getResponseObject();
                if (responseObject == null) {
                    EmailLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.NO_RESULT_FOUND);
                    if (this.loginModel != null) {
                        switch (this.loginModel.getStatus()) {
                            case SUCCESS:
                            case ERROR:
                                loginManager.onLoginComplete(this.loginModel);
                                EmailLoginController.this.broadcastLoginStateChange();
                                loginManager.clearLogIn();
                                return;
                            default:
                                return;
                        }
                    }
                    return;
                }
                try {
                    if (responseObject.getString("status").equals(AccountKitGraphConstants.STATUS_PENDING)) {
                        Runnable runnableCreatePolling = EmailLoginController.this.createPolling(this.loginModel, EmailLoginController.this.new LoginModelCodeCallback(this.loginModel));
                        if (runnableCreatePolling == null) {
                            if (this.loginModel != null) {
                                switch (this.loginModel.getStatus()) {
                                    case SUCCESS:
                                    case ERROR:
                                        loginManager.onLoginComplete(this.loginModel);
                                        EmailLoginController.this.broadcastLoginStateChange();
                                        loginManager.clearLogIn();
                                        return;
                                    default:
                                        return;
                                }
                            }
                            return;
                        }
                        this.loginModel.setInterval(Integer.parseInt(responseObject.getString(AccountKitGraphConstants.INTERVAL_SEC)));
                        long j = Long.parseLong(responseObject.getString(AccountKitGraphConstants.EXPIRES_IN_SEC_KEY));
                        this.loginModel.setExpiresInSeconds(j);
                        if (j < this.loginModel.getInterval()) {
                            EmailLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.EXPIRED_EMAIL_REQUEST);
                            if (this.loginModel != null) {
                                switch (this.loginModel.getStatus()) {
                                    case SUCCESS:
                                    case ERROR:
                                        loginManager.onLoginComplete(this.loginModel);
                                        EmailLoginController.this.broadcastLoginStateChange();
                                        loginManager.clearLogIn();
                                        return;
                                    default:
                                        return;
                                }
                            }
                            return;
                        }
                        if (loginManager.isActivityAvailable() || loginManager.isLoginInProgress()) {
                            new Handler().postDelayed(runnableCreatePolling, this.loginModel.getInterval() * 1000);
                        }
                    } else {
                        if (Utility.areObjectsEqual(this.loginModel.getResponseType(), AccountKitGraphConstants.TOKEN_RESPONSE_TYPE)) {
                            AccessToken accessToken = new AccessToken(responseObject.getString("access_token"), responseObject.getString("id"), AccountKit.getApplicationId(), Long.parseLong(responseObject.getString(AccountKitGraphConstants.TOKEN_REFRESH_INTERVAL_SEC)), new Date());
                            EmailLoginController.this.accessTokenManager.setCurrentAccessToken(accessToken);
                            this.loginModel.setFinalAuthState(responseObject.optString("state"));
                            this.loginModel.setAccessToken(accessToken);
                            emailLoginModelImpl = this.loginModel;
                            loginStatus = LoginStatus.SUCCESS;
                        } else {
                            this.loginModel.setCode(responseObject.getString("code"));
                            this.loginModel.setFinalAuthState(responseObject.optString("state"));
                            emailLoginModelImpl = this.loginModel;
                            loginStatus = LoginStatus.SUCCESS;
                        }
                        emailLoginModelImpl.setStatus(loginStatus);
                    }
                } catch (NumberFormatException | JSONException unused) {
                    EmailLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.INVALID_GRAPH_RESULTS_FORMAT);
                }
                if (this.loginModel != null) {
                    switch (this.loginModel.getStatus()) {
                        case SUCCESS:
                        case ERROR:
                            loginManager.onLoginComplete(this.loginModel);
                            EmailLoginController.this.broadcastLoginStateChange();
                            loginManager.clearLogIn();
                            return;
                        default:
                            return;
                    }
                }
            } catch (Throwable th) {
                if (this.loginModel != null) {
                    switch (this.loginModel.getStatus()) {
                        case SUCCESS:
                        case ERROR:
                            loginManager.onLoginComplete(this.loginModel);
                            EmailLoginController.this.broadcastLoginStateChange();
                            loginManager.clearLogIn();
                        default:
                            throw th;
                    }
                }
                throw th;
            }
        }
    }

    EmailLoginController(AccessTokenManager accessTokenManager, LoginManager loginManager, EmailLoginModelImpl emailLoginModelImpl) {
        super(accessTokenManager, loginManager, emailLoginModelImpl);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Nullable
    public Runnable createPolling(final EmailLoginModelImpl emailLoginModelImpl, final AccountKitGraphRequest.Callback callback) {
        LoginManager loginManager = getLoginManager();
        if (loginManager == null) {
            return null;
        }
        final String requestInstanceToken = loginManager.getRequestInstanceToken();
        return new Runnable() { // from class: com.facebook.accountkit.internal.EmailLoginController.2
            private boolean checkLoginManager() {
                LoginManager loginManager2 = EmailLoginController.this.getLoginManager();
                return loginManager2 != null && requestInstanceToken.equals(loginManager2.getRequestInstanceToken()) && loginManager2.isLoginInProgress();
            }

            @Override // java.lang.Runnable
            public void run() {
                Utility.assertUIThread();
                if (checkLoginManager()) {
                    Bundle bundle = new Bundle();
                    Utility.putNonNullString(bundle, "email", emailLoginModelImpl.getEmail());
                    AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = EmailLoginController.this.buildGraphRequest("poll_login", bundle);
                    AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
                    AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.EmailLoginController.2.1
                        @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
                        public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                            callback.onCompleted(accountKitGraphResponse);
                        }
                    }));
                }
            }
        };
    }

    @Override // com.facebook.accountkit.internal.LoginController
    protected String getCredentialsType() {
        return "email";
    }

    @Override // com.facebook.accountkit.internal.LoginController
    protected String getLoginStateChangedIntentName() {
        return EmailLoginTracker.ACTION_EMAIL_LOGIN_STATE_CHANGED;
    }

    @Override // com.facebook.accountkit.internal.LoginController
    public void logIn(@Nullable String str) {
        AccountKitGraphRequest.Callback callback = new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.EmailLoginController.1
            @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
            public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                LoginManager loginManager = EmailLoginController.this.getLoginManager();
                if (loginManager == null) {
                    return;
                }
                try {
                    if (accountKitGraphResponse.getError() != null) {
                        EmailLoginController.this.onError((AccountKitError) Utility.createErrorFromServerError(accountKitGraphResponse.getError()).first);
                    } else {
                        JSONObject responseObject = accountKitGraphResponse.getResponseObject();
                        if (responseObject != null) {
                            String strOptString = responseObject.optString(AccountKitGraphConstants.PRIVACY_POLICY);
                            if (!Utility.isNullOrEmpty(strOptString)) {
                                ((EmailLoginModelImpl) EmailLoginController.this.loginModel).putField(AccountKitGraphConstants.PRIVACY_POLICY, strOptString);
                            }
                            String strOptString2 = responseObject.optString(AccountKitGraphConstants.TERMS_OF_SERVICE);
                            if (!Utility.isNullOrEmpty(strOptString2)) {
                                ((EmailLoginModelImpl) EmailLoginController.this.loginModel).putField(AccountKitGraphConstants.TERMS_OF_SERVICE, strOptString2);
                            }
                            try {
                                boolean z = responseObject.getBoolean(AccountKitGraphConstants.CAN_ATTEMPT_SEAMLESS_LOGIN_KEY);
                                long j = Long.parseLong(responseObject.getString(AccountKitGraphConstants.SEAMLESS_LOGIN_EXPIRES_AT_KEY)) * 1000;
                                if (z && j > System.currentTimeMillis()) {
                                    ((EmailLoginModelImpl) EmailLoginController.this.loginModel).setStatus(LoginStatus.ACCOUNT_VERIFIED);
                                }
                            } catch (JSONException unused) {
                            }
                            try {
                                ((EmailLoginModelImpl) EmailLoginController.this.loginModel).setLoginCode(responseObject.getString(AccountKitGraphConstants.LOGIN_REQUEST_CODE_KEY));
                                ((EmailLoginModelImpl) EmailLoginController.this.loginModel).setExpiresInSeconds(Long.parseLong(responseObject.getString(AccountKitGraphConstants.EXPIRES_IN_SEC_KEY)));
                                ((EmailLoginModelImpl) EmailLoginController.this.loginModel).setInterval(Integer.parseInt(responseObject.getString(AccountKitGraphConstants.INTERVAL_SEC)));
                                ((EmailLoginModelImpl) EmailLoginController.this.loginModel).setStatus(LoginStatus.PENDING);
                                loginManager.handle(EmailLoginController.this.loginModel);
                            } catch (NumberFormatException | JSONException unused2) {
                                EmailLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.INVALID_GRAPH_RESULTS_FORMAT);
                            }
                            return;
                        }
                        EmailLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.NO_RESULT_FOUND);
                    }
                } finally {
                    EmailLoginController.this.broadcastLoginStateChange();
                }
            }
        };
        Bundle bundle = new Bundle();
        Utility.putNonNullString(bundle, "email", ((EmailLoginModelImpl) this.loginModel).getEmail());
        Utility.putNonNullString(bundle, ServerProtocol.DIALOG_PARAM_REDIRECT_URI, Utility.getRedirectURL());
        Utility.putNonNullString(bundle, "state", str);
        Utility.putNonNullString(bundle, ServerProtocol.DIALOG_PARAM_RESPONSE_TYPE, ((EmailLoginModelImpl) this.loginModel).getResponseType());
        Utility.putNonNullString(bundle, GraphRequest.FIELDS_PARAM, AccountKitGraphConstants.TERMS_OF_SERVICE_AND_PRIVACY_POLICY);
        LoginManager loginManager = getLoginManager();
        if (loginManager != null) {
            if (loginManager.isSeamlessLoginRunning()) {
                loginManager.getLogger().logFetchEvent(InternalLogger.EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN, InternalLogger.EVENT_PARAM_EXTRAS_NOT_COMPLETED);
            } else {
                Utility.putNonNullString(bundle, "fb_user_token", loginManager.getSeamlessLoginToken());
            }
        }
        ((EmailLoginModelImpl) this.loginModel).setInitialAuthState(str);
        AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = buildGraphRequest("start_login", bundle);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, callback));
    }

    @Override // com.facebook.accountkit.internal.LoginController
    public void onAccountVerified() {
        Validate.loginModelInProgress(this.loginModel);
        LoginManager loginManager = getLoginManager();
        if (loginManager == null) {
            return;
        }
        loginManager.onSeamlessLoginPending(this.loginModel);
        LoginController.AccountVerifedCallback accountVerifedCallback = new LoginController.AccountVerifedCallback(loginManager);
        Bundle bundle = new Bundle();
        Utility.putNonNullString(bundle, "fb_user_token", loginManager.getSeamlessLoginTokenRegardlessTimeOut());
        Utility.putNonNullString(bundle, "email", ((EmailLoginModelImpl) this.loginModel).getEmail());
        Utility.putNonNullString(bundle, ServerProtocol.DIALOG_PARAM_RESPONSE_TYPE, ((EmailLoginModelImpl) this.loginModel).getResponseType());
        Utility.putNonNullString(bundle, "state", ((EmailLoginModelImpl) this.loginModel).getInitialAuthState());
        AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = buildGraphRequest("instant_verification_login", bundle);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, accountVerifedCallback));
    }

    @Override // com.facebook.accountkit.internal.LoginController
    public void onCancel() {
        ((EmailLoginModelImpl) this.loginModel).setStatus(LoginStatus.CANCELLED);
        broadcastLoginStateChange();
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
    }

    @Override // com.facebook.accountkit.internal.LoginController
    public void onPending() {
        LoginManager loginManager = getLoginManager();
        if (loginManager != null && loginManager.isActivityAvailable()) {
            Runnable runnableCreatePolling = createPolling((EmailLoginModelImpl) this.loginModel, new LoginModelCodeCallback((EmailLoginModelImpl) this.loginModel));
            if (runnableCreatePolling == null) {
                return;
            }
            new Handler().postDelayed(runnableCreatePolling, ((EmailLoginModelImpl) this.loginModel).getInterval() * 1000);
        }
    }
}
