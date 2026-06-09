package com.facebook.accountkit.internal;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.util.Pair;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.PhoneLoginTracker;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import com.facebook.accountkit.internal.LoginController;
import com.facebook.internal.ServerProtocol;
import com.google.android.gms.auth.api.phone.SmsRetriever;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class PhoneLoginController extends LoginController<PhoneLoginModelImpl> {
    private static final String PARAMETER_CONFIRMATION_CODE = "confirmation_code";
    private static final String PARAMETER_PHONE = "phone_number";
    private static final String PARAMETER_USER_TOKEN = "fb_user_token";
    private static final String TAG = "com.facebook.accountkit.internal.PhoneLoginController";

    PhoneLoginController(AccessTokenManager accessTokenManager, LoginManager loginManager, PhoneLoginModelImpl phoneLoginModelImpl) {
        super(accessTokenManager, loginManager, phoneLoginModelImpl);
    }

    @Nullable
    private static String createSmsToken(Context context) {
        if (!Utility.hasGooglePlayServices(context)) {
            return null;
        }
        String strSubstring = PackageUtils.computePackageHash(context, context.getPackageName()).substring(0, 11);
        SmsRetriever.getClient(context).startSmsRetriever();
        return strSubstring;
    }

    @Override // com.facebook.accountkit.internal.LoginController
    protected String getCredentialsType() {
        return PARAMETER_PHONE;
    }

    @Override // com.facebook.accountkit.internal.LoginController
    protected String getLoginStateChangedIntentName() {
        return PhoneLoginTracker.ACTION_PHONE_LOGIN_STATE_CHANGED;
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x005e  */
    /* JADX WARN: Removed duplicated region for block: B:13:0x0069  */
    @Override // com.facebook.accountkit.internal.LoginController
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void logIn(@android.support.annotation.Nullable java.lang.String r6) {
        /*
            r5 = this;
            com.facebook.accountkit.internal.PhoneLoginController$1 r0 = new com.facebook.accountkit.internal.PhoneLoginController$1
            r0.<init>()
            E extends com.facebook.accountkit.internal.LoginModelImpl r1 = r5.loginModel
            com.facebook.accountkit.internal.PhoneLoginModelImpl r1 = (com.facebook.accountkit.internal.PhoneLoginModelImpl) r1
            com.facebook.accountkit.PhoneNumber r1 = r1.getPhoneNumber()
            java.lang.String r1 = r1.toString()
            android.os.Bundle r2 = new android.os.Bundle
            r2.<init>()
            java.lang.String r3 = "phone_number"
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r3, r1)
            java.lang.String r1 = "state"
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r1, r6)
            java.lang.String r1 = "response_type"
            E extends com.facebook.accountkit.internal.LoginModelImpl r3 = r5.loginModel
            com.facebook.accountkit.internal.PhoneLoginModelImpl r3 = (com.facebook.accountkit.internal.PhoneLoginModelImpl) r3
            java.lang.String r3 = r3.getResponseType()
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r1, r3)
            java.lang.String r1 = "fields"
            java.lang.String r3 = "terms_of_service,privacy_policy"
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r1, r3)
            int[] r1 = com.facebook.accountkit.internal.PhoneLoginController.AnonymousClass3.$SwitchMap$com$facebook$accountkit$ui$NotificationChannel
            E extends com.facebook.accountkit.internal.LoginModelImpl r3 = r5.loginModel
            com.facebook.accountkit.internal.PhoneLoginModelImpl r3 = (com.facebook.accountkit.internal.PhoneLoginModelImpl) r3
            com.facebook.accountkit.ui.NotificationChannel r3 = r3.getNotificationChannel()
            int r3 = r3.ordinal()
            r1 = r1[r3]
            switch(r1) {
                case 1: goto L4d;
                case 2: goto L48;
                default: goto L47;
            }
        L47:
            goto L54
        L48:
            java.lang.String r1 = "notif_medium"
            java.lang.String r3 = "voice"
            goto L51
        L4d:
            java.lang.String r1 = "notif_medium"
            java.lang.String r3 = "facebook"
        L51:
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r1, r3)
        L54:
            android.content.Context r1 = com.facebook.accountkit.internal.AccountKitController.getApplicationContext()
            java.lang.String r1 = createSmsToken(r1)
            if (r1 == 0) goto L63
            java.lang.String r3 = "sms_token"
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r3, r1)
        L63:
            com.facebook.accountkit.internal.LoginManager r1 = r5.getLoginManager()
            if (r1 == 0) goto L84
            boolean r3 = r1.isSeamlessLoginRunning()
            if (r3 == 0) goto L7b
            com.facebook.accountkit.internal.InternalLogger r1 = r1.getLogger()
            java.lang.String r3 = "ak_fetch_seamless_login_token"
            java.lang.String r4 = "not_completed"
            r1.logFetchEvent(r3, r4)
            goto L84
        L7b:
            java.lang.String r3 = "fb_user_token"
            java.lang.String r1 = r1.getSeamlessLoginToken()
            com.facebook.accountkit.internal.Utility.putNonNullString(r2, r3, r1)
        L84:
            E extends com.facebook.accountkit.internal.LoginModelImpl r1 = r5.loginModel
            com.facebook.accountkit.internal.PhoneLoginModelImpl r1 = (com.facebook.accountkit.internal.PhoneLoginModelImpl) r1
            r1.setInitialAuthState(r6)
            java.lang.String r6 = "start_login"
            com.facebook.accountkit.internal.AccountKitGraphRequest r6 = r5.buildGraphRequest(r6, r2)
            com.facebook.accountkit.internal.AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask()
            com.facebook.accountkit.internal.AccountKitGraphRequestAsyncTask r6 = com.facebook.accountkit.internal.AccountKitGraphRequest.executeAsync(r6, r0)
            com.facebook.accountkit.internal.AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(r6)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.accountkit.internal.PhoneLoginController.logIn(java.lang.String):void");
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
        Utility.putNonNullString(bundle, PARAMETER_USER_TOKEN, loginManager.getSeamlessLoginTokenRegardlessTimeOut());
        Utility.putNonNullString(bundle, PARAMETER_PHONE, ((PhoneLoginModelImpl) this.loginModel).getPhoneNumber().toString());
        Utility.putNonNullString(bundle, ServerProtocol.DIALOG_PARAM_RESPONSE_TYPE, ((PhoneLoginModelImpl) this.loginModel).getResponseType());
        Utility.putNonNullString(bundle, "state", ((PhoneLoginModelImpl) this.loginModel).getInitialAuthState());
        AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = buildGraphRequest("instant_verification_login", bundle);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, accountVerifedCallback));
    }

    @Override // com.facebook.accountkit.internal.LoginController
    public void onCancel() {
        ((PhoneLoginModelImpl) this.loginModel).setStatus(LoginStatus.CANCELLED);
        broadcastLoginStateChange();
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
    }

    @Override // com.facebook.accountkit.internal.LoginController
    public void onPending() {
        if (Utility.isNullOrEmpty(((PhoneLoginModelImpl) this.loginModel).getConfirmationCode())) {
            return;
        }
        Validate.loginModelInProgress(this.loginModel);
        final LoginManager loginManager = getLoginManager();
        if (loginManager == null) {
            return;
        }
        loginManager.onLoginVerify(this.loginModel);
        AccountKitGraphRequest.Callback callback = new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.PhoneLoginController.2
            @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
            public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) throws Throwable {
                Pair<AccountKitError, InternalAccountKitError> pairCreateErrorFromServerError;
                if (!loginManager.isActivityAvailable()) {
                    Log.w(PhoneLoginController.TAG, "Warning: Callback issues while activity not available.");
                    return;
                }
                if (accountKitGraphResponse == null) {
                    return;
                }
                try {
                    if (accountKitGraphResponse.getError() == null) {
                        JSONObject responseObject = accountKitGraphResponse.getResponseObject();
                        if (responseObject == null) {
                            PhoneLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.NO_RESULT_FOUND);
                            ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus();
                            LoginStatus loginStatus = LoginStatus.ERROR;
                            PhoneLoginController.this.broadcastLoginStateChange();
                            loginManager.onLoginComplete(PhoneLoginController.this.loginModel);
                            if (((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.SUCCESS || ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.ERROR) {
                                loginManager.clearLogIn();
                                return;
                            }
                            return;
                        }
                        try {
                            PhoneLoginController.this.extractAccessTokenOrCodeIntoModel(responseObject);
                        } catch (NumberFormatException | JSONException unused) {
                            PhoneLoginController.this.onError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.INVALID_GRAPH_RESULTS_FORMAT);
                        }
                        ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus();
                        LoginStatus loginStatus2 = LoginStatus.ERROR;
                        PhoneLoginController.this.broadcastLoginStateChange();
                        loginManager.onLoginComplete(PhoneLoginController.this.loginModel);
                        if (((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.SUCCESS || ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.ERROR) {
                            loginManager.clearLogIn();
                            return;
                        }
                        return;
                    }
                    pairCreateErrorFromServerError = Utility.createErrorFromServerError(accountKitGraphResponse.getError());
                    try {
                        if (!Utility.isConfirmationCodeRetryable((InternalAccountKitError) pairCreateErrorFromServerError.second)) {
                            PhoneLoginController.this.onError((AccountKitError) pairCreateErrorFromServerError.first);
                        }
                        if (((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.ERROR && pairCreateErrorFromServerError != null && Utility.isConfirmationCodeRetryable((InternalAccountKitError) pairCreateErrorFromServerError.second)) {
                            ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).setStatus(LoginStatus.PENDING);
                            ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).setError(null);
                        }
                        PhoneLoginController.this.broadcastLoginStateChange();
                        loginManager.onLoginComplete(PhoneLoginController.this.loginModel);
                        if (((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.SUCCESS || ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.ERROR) {
                            loginManager.clearLogIn();
                            return;
                        }
                        return;
                    } catch (Throwable th) {
                        th = th;
                    }
                } catch (Throwable th2) {
                    th = th2;
                    pairCreateErrorFromServerError = null;
                }
                if (((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.ERROR && pairCreateErrorFromServerError != null && Utility.isConfirmationCodeRetryable((InternalAccountKitError) pairCreateErrorFromServerError.second)) {
                    ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).setStatus(LoginStatus.PENDING);
                    ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).setError(null);
                }
                PhoneLoginController.this.broadcastLoginStateChange();
                loginManager.onLoginComplete(PhoneLoginController.this.loginModel);
                if (((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.SUCCESS || ((PhoneLoginModelImpl) PhoneLoginController.this.loginModel).getStatus() == LoginStatus.ERROR) {
                    loginManager.clearLogIn();
                }
                throw th;
            }
        };
        Bundle bundle = new Bundle();
        Utility.putNonNullString(bundle, "confirmation_code", ((PhoneLoginModelImpl) this.loginModel).getConfirmationCode());
        Utility.putNonNullString(bundle, PARAMETER_PHONE, ((PhoneLoginModelImpl) this.loginModel).getPhoneNumber().toString());
        AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = buildGraphRequest("confirm_login", bundle);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, callback));
    }
}
