package com.facebook.accountkit.internal;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;
import android.util.Pair;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.Account;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitCallback;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.LoginModel;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import com.facebook.accountkit.internal.SeamlessLoginClient;
import com.facebook.accountkit.ui.NotificationChannel;
import java.util.UUID;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class LoginManager {
    private static final String LOGOUT_PATH = "logout/";
    private static final String SAVED_LOGIN_MODEL = "accountkitLoginModel";
    private static final String TAG = "com.facebook.accountkit.internal.LoginManager";
    private final AccessTokenManager accessTokenManager;
    private volatile Activity currentActivity;

    @Nullable
    private volatile LoginController currentLoginController;
    private volatile boolean isActivityAvailable = false;
    private final LocalBroadcastManager localBroadcastManager;
    private final InternalLogger logger;
    private String requestInstanceToken;
    private SeamlessLoginClient seamlessLoginClient;
    private long seamlessLoginExpirationMillis;
    private String seamlessLoginToken;

    LoginManager(InternalLogger internalLogger, AccessTokenManager accessTokenManager, @NonNull LocalBroadcastManager localBroadcastManager) {
        this.accessTokenManager = accessTokenManager;
        this.localBroadcastManager = localBroadcastManager;
        this.logger = internalLogger;
        resetRequestInstanceToken();
    }

    private void cancelCurrentRequest() {
        this.currentLoginController = null;
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(null);
    }

    private void cancelExisting() {
        if (this.currentLoginController == null) {
            return;
        }
        this.currentLoginController.getLoginModel().setStatus(LoginStatus.CANCELLED);
        this.currentLoginController.onCancel();
    }

    @Nullable
    private LoginModelImpl getCurrentLogInModel() {
        if (this.currentLoginController == null) {
            return null;
        }
        return this.currentLoginController.getLoginModel();
    }

    private void onLoginStart(LoginModelImpl loginModelImpl) {
        this.logger.logLoginModel(InternalLogger.EVENT_NAME_LOGIN_START, loginModelImpl);
    }

    private void resetRequestInstanceToken() {
        this.requestInstanceToken = UUID.randomUUID().toString();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void seamlessLoginCompleted(Bundle bundle) {
        if (bundle != null) {
            this.seamlessLoginExpirationMillis = bundle.getLong(com.facebook.internal.NativeProtocol.EXTRA_EXPIRES_SECONDS_SINCE_EPOCH) * 1000;
            this.seamlessLoginToken = bundle.getString("com.facebook.platform.extra.SEAMLESS_LOGIN_TOKEN");
            this.logger.logFetchEvent(InternalLogger.EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN, InternalLogger.EVENT_PARAM_EXTRAS_COMPLETED);
        }
    }

    private void startWith(@NonNull LoginModelImpl loginModelImpl) {
        LoginController phoneLoginController;
        Utility.assertUIThread();
        if (loginModelImpl instanceof EmailLoginModelImpl) {
            phoneLoginController = new EmailLoginController(this.accessTokenManager, this, (EmailLoginModelImpl) loginModelImpl);
        } else {
            if (!(loginModelImpl instanceof PhoneLoginModelImpl)) {
                throw new AccountKitException(AccountKitError.Type.ARGUMENT_ERROR, InternalAccountKitError.INVALID_LOGIN_TYPE, loginModelImpl.getClass().getName());
            }
            phoneLoginController = new PhoneLoginController(this.accessTokenManager, this, (PhoneLoginModelImpl) loginModelImpl);
        }
        this.currentLoginController = phoneLoginController;
        handle(loginModelImpl);
    }

    void cancel(LoginModel loginModel) {
        this.seamlessLoginToken = null;
        if (this.currentLoginController != null && Utility.areObjectsEqual(loginModel, this.currentLoginController.getLoginModel())) {
            cancelCurrentRequest();
        }
    }

    void cancelLogin() {
        Utility.assertUIThread();
        resetRequestInstanceToken();
        if (this.currentLoginController != null) {
            this.currentLoginController.onCancel();
            AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(null);
            this.currentLoginController = null;
        }
        AccountKitGraphRequestAsyncTask currentAsyncTask = AccountKitGraphRequestAsyncTask.getCurrentAsyncTask();
        if (currentAsyncTask != null) {
            currentAsyncTask.cancel(true);
            AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(null);
        }
    }

    void clearLogIn() {
        this.currentLoginController = null;
    }

    void continueSeamlessLogin() {
        LoginModelImpl currentLogInModel = getCurrentLogInModel();
        if (currentLogInModel == null) {
            return;
        }
        try {
            handle(currentLogInModel);
        } catch (AccountKitException e) {
            if (Utility.isDebuggable(AccountKitController.getApplicationContext())) {
                throw e;
            }
            this.logger.logLoginModel(InternalLogger.EVENT_NAME_CONFIRM_SEAMLESS_PENDING, currentLogInModel);
        }
    }

    void continueWithCode(String str) {
        PhoneLoginModelImpl currentPhoneNumberLogInModel = getCurrentPhoneNumberLogInModel();
        if (currentPhoneNumberLogInModel == null) {
            return;
        }
        try {
            currentPhoneNumberLogInModel.setConfirmationCode(str);
            handle(currentPhoneNumberLogInModel);
        } catch (AccountKitException e) {
            if (Utility.isDebuggable(AccountKitController.getApplicationContext())) {
                throw e;
            }
            this.logger.logLoginModel(InternalLogger.EVENT_NAME_SET_CONFIRMATION_CODE, currentPhoneNumberLogInModel);
        }
    }

    void getCurrentAccount(final AccountKitCallback<Account> accountKitCallback) {
        final AccessToken currentAccessToken = AccountKit.getCurrentAccessToken();
        if (currentAccessToken == null) {
            Log.w(TAG, "No access token: cannot retrieve account");
            accountKitCallback.onError(new AccountKitError(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.CANNOT_RETRIEVE_ACCESS_TOKEN_NO_ACCOUNT));
        } else {
            AccountKitGraphRequest.executeAsync(new AccountKitGraphRequest(currentAccessToken, currentAccessToken.getAccountId(), null, false, HttpMethod.GET), new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.LoginManager.3
                @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
                public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                    String string;
                    String string2;
                    if (accountKitGraphResponse.getError() != null) {
                        accountKitCallback.onError((AccountKitError) Utility.createErrorFromServerError(accountKitGraphResponse.getError()).first);
                        return;
                    }
                    JSONObject responseObject = accountKitGraphResponse.getResponseObject();
                    if (responseObject == null) {
                        accountKitCallback.onError(new AccountKitError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.NO_RESULT_FOUND));
                        return;
                    }
                    try {
                        String string3 = responseObject.getString("id");
                        JSONObject jSONObjectOptJSONObject = responseObject.optJSONObject("email");
                        String string4 = jSONObjectOptJSONObject != null ? jSONObjectOptJSONObject.getString(AccountKitGraphConstants.EMAIL_ADDRESS_KEY) : null;
                        JSONObject jSONObjectOptJSONObject2 = responseObject.optJSONObject("phone");
                        if (jSONObjectOptJSONObject2 != null) {
                            string2 = jSONObjectOptJSONObject2.getString(AccountKitGraphConstants.PHONE_NATIONAL_NUMBER);
                            string = jSONObjectOptJSONObject2.getString(AccountKitGraphConstants.PHONE_COUNTRY_PREFIX);
                        } else {
                            string = null;
                            string2 = null;
                        }
                        if (string == null && string2 == null && string4 == null) {
                            accountKitCallback.onError(new AccountKitError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.NO_ACCOUNT_FOUND));
                            return;
                        }
                        if ((string == null && string2 != null) || (string != null && string2 == null)) {
                            accountKitCallback.onError(new AccountKitError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.NO_ACCOUNT_FOUND));
                            return;
                        }
                        PhoneNumber phoneNumber = string != null ? new PhoneNumber(string, string2, null) : null;
                        AccessToken currentAccessToken2 = AccountKit.getCurrentAccessToken();
                        if (currentAccessToken2 != null && currentAccessToken.equals(currentAccessToken2)) {
                            LoginManager.this.accessTokenManager.refreshCurrentAccessToken(currentAccessToken2);
                        }
                        accountKitCallback.onSuccess(new Account(string3, phoneNumber, string4));
                    } catch (JSONException unused) {
                        accountKitCallback.onError(new AccountKitError(AccountKitError.Type.LOGIN_INVALIDATED, InternalAccountKitError.INVALID_GRAPH_RESULTS_FORMAT));
                    }
                }
            });
        }
    }

    EmailLoginModelImpl getCurrentEmailLogInModel() {
        if (this.currentLoginController == null) {
            return null;
        }
        LoginModelImpl loginModel = this.currentLoginController.getLoginModel();
        if (loginModel instanceof EmailLoginModelImpl) {
            return (EmailLoginModelImpl) loginModel;
        }
        return null;
    }

    PhoneLoginModelImpl getCurrentPhoneNumberLogInModel() {
        if (this.currentLoginController == null) {
            return null;
        }
        LoginModelImpl loginModel = this.currentLoginController.getLoginModel();
        if (loginModel instanceof PhoneLoginModelImpl) {
            return (PhoneLoginModelImpl) loginModel;
        }
        return null;
    }

    LocalBroadcastManager getLocalBroadcastManager() {
        return this.localBroadcastManager;
    }

    InternalLogger getLogger() {
        return this.logger;
    }

    String getRequestInstanceToken() {
        return this.requestInstanceToken;
    }

    String getSeamlessLoginToken() {
        if (this.seamlessLoginExpirationMillis < System.currentTimeMillis()) {
            this.seamlessLoginToken = null;
        }
        return this.seamlessLoginToken;
    }

    String getSeamlessLoginTokenRegardlessTimeOut() {
        return this.seamlessLoginToken;
    }

    void handle(LoginModelImpl loginModelImpl) {
        if (this.currentLoginController == null) {
        }
        Validate.loginModelsEqual(loginModelImpl, this.currentLoginController.getLoginModel());
        Utility.assertUIThread();
        switch (loginModelImpl.getStatus()) {
            case PENDING:
                this.currentLoginController.onPending();
                break;
            case ACCOUNT_VERIFIED:
                this.currentLoginController.onAccountVerified();
                break;
            case ERROR:
                this.currentLoginController.onError(loginModelImpl.getError());
                break;
            case CANCELLED:
                this.currentLoginController.onCancel();
                break;
        }
    }

    void initializeLogin() {
        this.seamlessLoginToken = null;
        this.logger.logFetchEvent(InternalLogger.EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN, InternalLogger.EVENT_PARAM_EXTRAS_STARTED);
        this.seamlessLoginClient = new SeamlessLoginClient(AccountKitController.getApplicationContext(), AccountKit.getApplicationId(), this.logger);
        if (this.seamlessLoginClient.start()) {
            this.seamlessLoginClient.setCompletedListener(new SeamlessLoginClient.CompletedListener() { // from class: com.facebook.accountkit.internal.LoginManager.1
                @Override // com.facebook.accountkit.internal.SeamlessLoginClient.CompletedListener
                public void completed(Bundle bundle) {
                    LoginManager.this.seamlessLoginCompleted(bundle);
                }
            });
        }
    }

    boolean isActivityAvailable() {
        return this.isActivityAvailable;
    }

    boolean isLoginInProgress() {
        return this.currentLoginController != null;
    }

    boolean isSeamlessLoginRunning() {
        return this.seamlessLoginToken == null && this.seamlessLoginClient != null && this.seamlessLoginClient.isRunning();
    }

    EmailLoginModelImpl logInWithEmail(@NonNull String str, @NonNull String str2, @Nullable String str3) {
        Utility.assertUIThread();
        cancelExisting();
        EmailLoginModelImpl emailLoginModelImpl = new EmailLoginModelImpl(str, str2);
        EmailLoginController emailLoginController = new EmailLoginController(this.accessTokenManager, this, emailLoginModelImpl);
        emailLoginController.logIn(str3);
        onLoginStart(emailLoginModelImpl);
        this.currentLoginController = emailLoginController;
        return emailLoginModelImpl;
    }

    PhoneLoginModelImpl logInWithPhoneNumber(@NonNull PhoneNumber phoneNumber, @NonNull NotificationChannel notificationChannel, @NonNull String str, @Nullable String str2) {
        Utility.assertUIThread();
        if (notificationChannel == NotificationChannel.SMS) {
            cancelExisting();
        }
        PhoneLoginModelImpl phoneLoginModelImpl = new PhoneLoginModelImpl(phoneNumber, notificationChannel, str);
        PhoneLoginController phoneLoginController = new PhoneLoginController(this.accessTokenManager, this, phoneLoginModelImpl);
        phoneLoginController.logIn(str2);
        onLoginStart(phoneLoginModelImpl);
        this.currentLoginController = phoneLoginController;
        return phoneLoginModelImpl;
    }

    void logOut() {
        logOut(null);
        this.accessTokenManager.setCurrentAccessToken(null);
    }

    void logOut(@Nullable final AccountKitCallback<Void> accountKitCallback) {
        AccessToken currentAccessToken = AccountKit.getCurrentAccessToken();
        if (currentAccessToken != null) {
            AccountKitGraphRequest.executeAsync(new AccountKitGraphRequest(currentAccessToken, LOGOUT_PATH, null, false, HttpMethod.POST), new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.LoginManager.2
                @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
                public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                    if (accountKitGraphResponse.getError() != null) {
                        Pair<AccountKitError, InternalAccountKitError> pairCreateErrorFromServerError = Utility.createErrorFromServerError(accountKitGraphResponse.getError());
                        LoginManager.this.logger.logEvent(InternalLogger.EVENT_NAME_LOG_OUT_ERROR);
                        if (accountKitCallback != null) {
                            accountKitCallback.onError((AccountKitError) pairCreateErrorFromServerError.first);
                            return;
                        }
                        return;
                    }
                    LoginManager.this.accessTokenManager.setCurrentAccessToken(null);
                    LoginManager.this.logger.logEvent(InternalLogger.EVENT_NAME_LOG_OUT);
                    if (accountKitCallback != null) {
                        accountKitCallback.onSuccess(null);
                    }
                }
            });
        } else {
            Log.w(TAG, "No access token: cannot log out");
            if (accountKitCallback != null) {
                accountKitCallback.onSuccess(null);
            }
        }
    }

    void onActivityCreate(Activity activity, Bundle bundle) {
        LoginModelImpl loginModelImpl;
        this.isActivityAvailable = true;
        this.currentActivity = activity;
        this.logger.onActivityCreate(bundle);
        if (bundle == null || (loginModelImpl = (LoginModelImpl) bundle.getParcelable(SAVED_LOGIN_MODEL)) == null) {
            return;
        }
        startWith(loginModelImpl);
    }

    void onActivityDestroy(Activity activity) {
        if (this.currentActivity != activity) {
            return;
        }
        this.isActivityAvailable = false;
        this.currentLoginController = null;
        this.currentActivity = null;
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(null);
    }

    void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
        if (this.currentActivity != activity) {
            return;
        }
        this.logger.saveInstanceState(bundle);
        if (this.currentLoginController != null) {
            bundle.putParcelable(SAVED_LOGIN_MODEL, this.currentLoginController.getLoginModel());
        }
    }

    void onLoginComplete(LoginModelImpl loginModelImpl) {
        this.logger.logLoginModel(InternalLogger.EVENT_NAME_LOGIN_COMPLETE, loginModelImpl);
    }

    void onLoginVerify(LoginModelImpl loginModelImpl) {
        this.logger.logLoginModel(InternalLogger.EVENT_NAME_LOGIN_VERIFY, loginModelImpl);
    }

    void onSeamlessLoginPending(LoginModelImpl loginModelImpl) {
        this.logger.logLoginModel(InternalLogger.EVENT_NAME_CONFIRM_SEAMLESS_PENDING, loginModelImpl);
    }
}
