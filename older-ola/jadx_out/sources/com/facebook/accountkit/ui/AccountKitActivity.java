package com.facebook.accountkit.ui;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.AccountKitLoginResult;
import com.facebook.accountkit.LoginResult;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.Tracker;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.accountkit.internal.InternalAccountKitError;
import com.facebook.accountkit.internal.Utility;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.StateStackManager;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
public final class AccountKitActivity extends AccountKitActivityBase {
    private AccessToken accessToken;
    private String authorizationCode;
    private AccountKitError error;
    private String finalAuthState;
    private boolean isActive;

    @Nullable
    private LoginFlowManager loginFlowManager;
    private Tracker loginTracker;
    private GoogleApiClient mCredentialsApiClient;
    private StateStackManager stateStackManager;
    private long tokenRefreshIntervalInSeconds;
    private static final String TAG = "AccountKitActivity";
    private static final String LOGIN_FLOW_MANAGER_KEY = TAG + ".loginFlowManager";
    private static final String PENDING_LOGIN_FLOW_STATE_KEY = TAG + ".pendingLoginFlowState";
    private static final String TRACKING_SMS_KEY = TAG + ".trackingSms";
    private static final IntentFilter LOGIN_FLOW_BROADCAST_RECEIVER_FILTER = LoginFlowBroadcastReceiver.getIntentFilter();
    private LoginResult result = LoginResult.CANCELLED;
    private final Bundle viewState = new Bundle();
    private final BroadcastReceiver loginFlowBroadcastReceiver = new LoginFlowBroadcastReceiver() { // from class: com.facebook.accountkit.ui.AccountKitActivity.1
        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            if (LoginFlowBroadcastReceiver.ACTION_UPDATE.contentEquals(intent.getAction())) {
                LoginFlowBroadcastReceiver.Event event = (LoginFlowBroadcastReceiver.Event) intent.getSerializableExtra(EXTRA_EVENT);
                ContentController contentController = AccountKitActivity.this.stateStackManager.getContentController();
                switch (AnonymousClass3.$SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[event.ordinal()]) {
                    case 1:
                        AccountKitActivity.this.loginFlowManager.getActivityHandler().onSentCodeComplete(AccountKitActivity.this);
                        break;
                    case 2:
                        AccountKitActivity.this.loginFlowManager.getActivityHandler().onAccountVerifiedComplete(AccountKitActivity.this);
                        break;
                    case 3:
                        AccountKitActivity.this.loginFlowManager.getActivityHandler().onConfirmSeamlessLogin(AccountKitActivity.this, AccountKitActivity.this.loginFlowManager);
                        break;
                    case 4:
                        if (contentController instanceof EmailLoginContentController) {
                            String stringExtra = intent.getStringExtra(EXTRA_EMAIL);
                            EmailLoginFlowManager emailLoginFlowManager = (EmailLoginFlowManager) AccountKitActivity.this.loginFlowManager;
                            ((ActivityEmailHandler) emailLoginFlowManager.getActivityHandler()).onEmailLoginComplete(AccountKitActivity.this, emailLoginFlowManager, stringExtra);
                        }
                        break;
                    case 5:
                        if (contentController instanceof EmailVerifyContentController) {
                            ((ActivityEmailHandler) AccountKitActivity.this.loginFlowManager.getActivityHandler()).onEmailVerifyRetry(AccountKitActivity.this);
                        }
                        break;
                    case 6:
                        if (contentController instanceof LoginErrorContentController) {
                            ActivityErrorHandler.onErrorRestart(AccountKitActivity.this, LoginFlowState.values()[intent.getIntExtra(EXTRA_RETURN_LOGIN_FLOW_STATE, 0)]);
                        }
                        break;
                    case 7:
                        if (contentController instanceof PhoneLoginContentController) {
                            PhoneNumber phoneNumber = (PhoneNumber) intent.getParcelableExtra(EXTRA_PHONE_NUMBER);
                            PhoneLoginFlowManager phoneLoginFlowManager = (PhoneLoginFlowManager) AccountKitActivity.this.loginFlowManager;
                            ((ActivityPhoneHandler) phoneLoginFlowManager.getActivityHandler()).onPhoneLoginComplete(AccountKitActivity.this, phoneLoginFlowManager, phoneNumber);
                        }
                        break;
                    case 8:
                        if (contentController instanceof LoginConfirmationCodeContentController) {
                            String stringExtra2 = intent.getStringExtra(EXTRA_CONFIRMATION_CODE);
                            PhoneLoginFlowManager phoneLoginFlowManager2 = (PhoneLoginFlowManager) AccountKitActivity.this.loginFlowManager;
                            ((ActivityPhoneHandler) phoneLoginFlowManager2.getActivityHandler()).onConfirmationCodeComplete(AccountKitActivity.this, phoneLoginFlowManager2, stringExtra2);
                        }
                        break;
                    case 9:
                        if (contentController instanceof LoginConfirmationCodeContentController) {
                            ((ActivityPhoneHandler) AccountKitActivity.this.loginFlowManager.getActivityHandler()).onConfirmationCodeRetry(AccountKitActivity.this);
                        }
                        break;
                    case 10:
                        if ((contentController instanceof ResendContentController) || (contentController instanceof LoginConfirmationCodeContentController)) {
                            ((ActivityPhoneHandler) AccountKitActivity.this.loginFlowManager.getActivityHandler()).onResend(AccountKitActivity.this);
                        }
                        break;
                    case 11:
                        if (contentController instanceof ResendContentController) {
                            PhoneLoginFlowManager phoneLoginFlowManager3 = (PhoneLoginFlowManager) AccountKitActivity.this.loginFlowManager;
                            ((ActivityPhoneHandler) phoneLoginFlowManager3.getActivityHandler()).onResendFacebookNotification(AccountKitActivity.this, phoneLoginFlowManager3);
                        }
                        break;
                    case 12:
                        if (contentController instanceof ResendContentController) {
                            PhoneLoginFlowManager phoneLoginFlowManager4 = (PhoneLoginFlowManager) AccountKitActivity.this.loginFlowManager;
                            ((ActivityPhoneHandler) phoneLoginFlowManager4.getActivityHandler()).onResendVoiceCallNotification(AccountKitActivity.this, phoneLoginFlowManager4);
                        }
                        break;
                }
            }
        }
    };

    /* JADX INFO: renamed from: com.facebook.accountkit.ui.AccountKitActivity$3, reason: invalid class name */
    static /* synthetic */ class AnonymousClass3 {
        static final /* synthetic */ int[] $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event;

        static {
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.NONE.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.PHONE_NUMBER_INPUT.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.EMAIL_INPUT.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.SENDING_CODE.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.SENT_CODE.ordinal()] = 5;
            } catch (NoSuchFieldError unused5) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.CODE_INPUT.ordinal()] = 6;
            } catch (NoSuchFieldError unused6) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.ACCOUNT_VERIFIED.ordinal()] = 7;
            } catch (NoSuchFieldError unused7) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.CONFIRM_ACCOUNT_VERIFIED.ordinal()] = 8;
            } catch (NoSuchFieldError unused8) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.CONFIRM_INSTANT_VERIFICATION_LOGIN.ordinal()] = 9;
            } catch (NoSuchFieldError unused9) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.EMAIL_VERIFY.ordinal()] = 10;
            } catch (NoSuchFieldError unused10) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.VERIFYING_CODE.ordinal()] = 11;
            } catch (NoSuchFieldError unused11) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.RESEND.ordinal()] = 12;
            } catch (NoSuchFieldError unused12) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.ERROR.ordinal()] = 13;
            } catch (NoSuchFieldError unused13) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowState[LoginFlowState.VERIFIED.ordinal()] = 14;
            } catch (NoSuchFieldError unused14) {
            }
            $SwitchMap$com$facebook$accountkit$ui$LoginType = new int[LoginType.values().length];
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginType[LoginType.PHONE.ordinal()] = 1;
            } catch (NoSuchFieldError unused15) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginType[LoginType.EMAIL.ordinal()] = 2;
            } catch (NoSuchFieldError unused16) {
            }
            $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event = new int[LoginFlowBroadcastReceiver.Event.values().length];
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.SENT_CODE_COMPLETE.ordinal()] = 1;
            } catch (NoSuchFieldError unused17) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.ACCOUNT_VERIFIED_COMPLETE.ordinal()] = 2;
            } catch (NoSuchFieldError unused18) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.CONFIRM_SEAMLESS_LOGIN.ordinal()] = 3;
            } catch (NoSuchFieldError unused19) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.EMAIL_LOGIN_COMPLETE.ordinal()] = 4;
            } catch (NoSuchFieldError unused20) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.EMAIL_VERIFY_RETRY.ordinal()] = 5;
            } catch (NoSuchFieldError unused21) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.ERROR_RESTART.ordinal()] = 6;
            } catch (NoSuchFieldError unused22) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.PHONE_LOGIN_COMPLETE.ordinal()] = 7;
            } catch (NoSuchFieldError unused23) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.PHONE_CONFIRMATION_CODE_COMPLETE.ordinal()] = 8;
            } catch (NoSuchFieldError unused24) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.PHONE_CONFIRMATION_CODE_RETRY.ordinal()] = 9;
            } catch (NoSuchFieldError unused25) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.PHONE_RESEND.ordinal()] = 10;
            } catch (NoSuchFieldError unused26) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.PHONE_RESEND_FACEBOOK_NOTIFICATION.ordinal()] = 11;
            } catch (NoSuchFieldError unused27) {
            }
            try {
                $SwitchMap$com$facebook$accountkit$ui$LoginFlowBroadcastReceiver$Event[LoginFlowBroadcastReceiver.Event.PHONE_RESEND_VOICE_CALL_NOTIFICATION.ordinal()] = 12;
            } catch (NoSuchFieldError unused28) {
            }
        }
    }

    public enum ResponseType {
        CODE("code"),
        TOKEN(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE);

        private final String value;

        ResponseType(String str) {
            this.value = str;
        }

        public String getValue() {
            return this.value;
        }
    }

    @Deprecated
    public enum TitleType {
        APP_NAME,
        LOGIN
    }

    private void backPressed() {
        LoginFlowState returnState;
        ContentController contentController = this.stateStackManager.getContentController();
        if (contentController == null) {
            return;
        }
        if (contentController instanceof LoginConfirmationCodeContentController) {
            ((LoginConfirmationCodeContentController) contentController).setRetry(false);
        }
        onContentControllerDismissed(contentController);
        LoginFlowState loginFlowState = contentController.getLoginFlowState();
        LoginFlowState backState = LoginFlowState.getBackState(loginFlowState);
        switch (loginFlowState) {
            case NONE:
            case PHONE_NUMBER_INPUT:
            case EMAIL_INPUT:
                sendCancelResult();
                return;
            case SENDING_CODE:
            case SENT_CODE:
            case CODE_INPUT:
            case ACCOUNT_VERIFIED:
            case CONFIRM_ACCOUNT_VERIFIED:
            case CONFIRM_INSTANT_VERIFICATION_LOGIN:
            case EMAIL_VERIFY:
            case VERIFYING_CODE:
            case RESEND:
                resetFlowTo(loginFlowState, backState);
                return;
            case ERROR:
                returnState = ((LoginErrorContentController) contentController).getReturnState();
                break;
            case VERIFIED:
                sendResult();
                return;
            default:
                returnState = LoginFlowState.NONE;
                break;
        }
        resetFlowTo(loginFlowState, returnState);
    }

    private void logContentControllerDismissed(ContentController contentController) {
        if (this.configuration == null) {
            return;
        }
        if (contentController instanceof PhoneLoginContentController) {
            AccountKitController.Logger.logUIPhoneLogin();
            return;
        }
        if (contentController instanceof SendingCodeContentController) {
            AccountKitController.Logger.logUISendingCode(false, this.configuration.getLoginType());
            return;
        }
        if (contentController instanceof SentCodeContentController) {
            AccountKitController.Logger.logUISentCode(false, this.configuration.getLoginType());
            return;
        }
        if (contentController instanceof LoginConfirmationCodeContentController) {
            AccountKitController.Logger.logUIConfirmationCode();
            return;
        }
        if (contentController instanceof VerifyingCodeContentController) {
            AccountKitController.Logger.logUIVerifyingCode(false, this.configuration.getLoginType());
            return;
        }
        if (contentController instanceof VerifiedCodeContentController) {
            AccountKitController.Logger.logUIVerifiedCode(false, this.configuration.getLoginType());
            return;
        }
        if (contentController instanceof LoginErrorContentController) {
            AccountKitController.Logger.logUIError(false, this.configuration.getLoginType());
            return;
        }
        if (contentController instanceof EmailLoginContentController) {
            AccountKitController.Logger.logUIEmailLogin();
            return;
        }
        if (contentController instanceof EmailVerifyContentController) {
            AccountKitController.Logger.logUIEmailVerify(false);
            return;
        }
        if (contentController instanceof ResendContentController) {
            AccountKitController.Logger.logUIResend(false);
        } else if (contentController instanceof ConfirmAccountVerifiedContentController) {
            AccountKitController.Logger.logUIConfirmAccountVerified(false);
        } else {
            if (!(contentController instanceof AccountVerifiedContentController)) {
                throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.UNEXPECTED_FRAGMENT, contentController.getClass().getName());
            }
            AccountKitController.Logger.logUIAccountVerified(false);
        }
    }

    private void onViewReadyWithState(Bundle bundle, boolean z) {
        LoginFlowState loginFlowState;
        setNewLoginFlowManagerAndHandler((LoginFlowManager) bundle.getParcelable(LOGIN_FLOW_MANAGER_KEY));
        if (z) {
            this.stateStackManager.updateContentController(this);
            return;
        }
        if (this.configuration == null) {
            return;
        }
        switch (this.configuration.getLoginType()) {
            case PHONE:
                loginFlowState = LoginFlowState.PHONE_NUMBER_INPUT;
                break;
            case EMAIL:
                loginFlowState = LoginFlowState.EMAIL_INPUT;
                break;
            default:
                this.error = new AccountKitError(AccountKitError.Type.INITIALIZATION_ERROR, InternalAccountKitError.INVALID_LOGIN_TYPE);
                sendResult();
                return;
        }
        pushState(loginFlowState, null);
    }

    private void resetFlowTo(LoginFlowState loginFlowState, LoginFlowState loginFlowState2) {
        this.loginFlowManager.setFlowState(loginFlowState2);
        StateStackManager.OnPopListener onPopListener = new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.AccountKitActivity.2
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
            public void onContentPopped() {
                AccountKitActivity.this.getContentController().onResume(AccountKitActivity.this);
            }
        };
        if (loginFlowState != LoginFlowState.RESEND) {
            setNewLoginFlowManagerAndHandler(null);
        }
        popBackStack(loginFlowState2, onPopListener);
    }

    private void sendResult(int i, AccountKitLoginResult accountKitLoginResult) {
        if (getCallingActivity() == null) {
            startActivity(getPackageManager().getLaunchIntentForPackage(getPackageName()));
        } else {
            Intent intent = new Intent();
            intent.putExtra(AccountKitLoginResult.RESULT_KEY, accountKitLoginResult);
            setResult(i, intent);
        }
        finish();
    }

    private static boolean urlIsRedirectUrl(@NonNull String str) {
        return str.startsWith(Utility.getRedirectURL());
    }

    ContentController getContentController() {
        return this.stateStackManager.getContentController();
    }

    @Nullable
    public LoginFlowState getCurrentState() {
        if (this.loginFlowManager != null) {
            return this.loginFlowManager.getFlowState();
        }
        return null;
    }

    public GoogleApiClient getGoogleApiClient() {
        return this.mCredentialsApiClient;
    }

    void multiPopBackStack(@Nullable StateStackManager.OnPopListener onPopListener) {
        this.stateStackManager.multiPopBackStack(onPopListener);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        ContentController contentController = getContentController();
        if (contentController != null) {
            contentController.onActivityResult(i, i2, intent);
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.stateStackManager.getContentController() == null) {
            super.onBackPressed();
        } else {
            backPressed();
        }
    }

    public void onBackPressed(View view) {
        onBackPressed();
    }

    public void onCancelPressed(View view) {
        sendCancelResult();
    }

    void onContentControllerDismissed(ContentController contentController) {
        if (contentController != null) {
            contentController.onPause(this);
            logContentControllerDismissed(contentController);
        }
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase, android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        String dataString = getIntent().getDataString();
        if (dataString != null && !urlIsRedirectUrl(dataString)) {
            sendResult();
            return;
        }
        if (this.configuration == null || this.configuration.getLoginType() == null) {
            this.error = new AccountKitError(AccountKitError.Type.INITIALIZATION_ERROR, InternalAccountKitError.INVALID_INTENT_EXTRAS_LOGIN_TYPE);
            sendResult();
        } else {
            if (this.configuration.getResponseType() == null) {
                this.error = new AccountKitError(AccountKitError.Type.INITIALIZATION_ERROR, InternalAccountKitError.INVALID_INTENT_EXTRAS_RESPONSE_TYPE);
                sendResult();
                return;
            }
            this.stateStackManager = new StateStackManager(this, this.configuration);
            AccountKit.onActivityCreate(this, bundle);
            onViewReadyWithState(this.viewState, bundle != null);
            LocalBroadcastManager.getInstance(this).registerReceiver(this.loginFlowBroadcastReceiver, LOGIN_FLOW_BROADCAST_RECEIVER_FILTER);
            this.mCredentialsApiClient = new GoogleApiClient.Builder(this).addApi(Auth.CREDENTIALS_API).build();
        }
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase, android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(this.loginFlowBroadcastReceiver);
        super.onDestroy();
        if (this.loginTracker != null) {
            this.loginTracker.stopTracking();
            this.loginTracker = null;
        }
        if (this.loginFlowManager != null && this.loginFlowManager.getLoginType() == LoginType.PHONE) {
            ((ActivityPhoneHandler) this.loginFlowManager.getActivityHandler()).stopSmsTracker();
        }
        AccountKit.onActivityDestroy(this);
    }

    @Override // android.support.v7.app.AppCompatActivity, android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 4) {
            return super.onKeyDown(i, keyEvent);
        }
        backPressed();
        return true;
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        String dataString = intent.getDataString();
        if (dataString == null) {
            return;
        }
        if (!urlIsRedirectUrl(dataString)) {
            sendResult();
        } else if (getContentController() instanceof EmailVerifyContentController) {
            pushState(LoginFlowState.VERIFYING_CODE, null);
        }
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        if (menuItem.getItemId() != 16908332) {
            return super.onOptionsItemSelected(menuItem);
        }
        onBackPressed();
        return true;
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    public void onPause() {
        super.onPause();
        ContentController contentController = getContentController();
        if (contentController != null) {
            contentController.onPause(this);
        }
        this.isActive = false;
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onResume() {
        super.onResume();
        ContentController contentController = getContentController();
        if (contentController != null) {
            contentController.onResume(this);
        }
        this.isActive = true;
        if (this.configuration == null) {
            return;
        }
        switch (this.configuration.getLoginType()) {
            case PHONE:
            case EMAIL:
                this.loginTracker = this.loginFlowManager.getActivityHandler().getLoginTracker(this);
                this.loginTracker.startTracking();
                break;
        }
        if (this.loginFlowManager.getLoginType() == LoginType.PHONE && (this.loginFlowManager.getFlowState() == LoginFlowState.SENDING_CODE || this.viewState.getBoolean(TRACKING_SMS_KEY, false))) {
            ((ActivityPhoneHandler) this.loginFlowManager.getActivityHandler()).startSmsTrackerIfPossible(this);
        }
        String string = this.viewState.getString(PENDING_LOGIN_FLOW_STATE_KEY);
        if (Utility.isNullOrEmpty(string)) {
            return;
        }
        this.viewState.putString(PENDING_LOGIN_FLOW_STATE_KEY, null);
        pushState(LoginFlowState.valueOf(string), null);
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase, android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    public void onSaveInstanceState(Bundle bundle) {
        AccountKit.onActivitySaveInstanceState(this, bundle);
        if (this.loginFlowManager.getLoginType() == LoginType.PHONE) {
            ActivityPhoneHandler activityPhoneHandler = (ActivityPhoneHandler) this.loginFlowManager.getActivityHandler();
            this.viewState.putBoolean(TRACKING_SMS_KEY, activityPhoneHandler.isSmsTracking());
            activityPhoneHandler.pauseSmsTracker();
            this.viewState.putParcelable(LOGIN_FLOW_MANAGER_KEY, this.loginFlowManager);
        }
        if (this.loginTracker != null) {
            this.loginTracker.pauseTracking();
        }
        super.onSaveInstanceState(bundle);
    }

    @Override // android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        this.mCredentialsApiClient.connect();
    }

    @Override // android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStop() {
        super.onStop();
        this.mCredentialsApiClient.disconnect();
    }

    void popBackStack(@NonNull LoginFlowState loginFlowState, @Nullable StateStackManager.OnPopListener onPopListener) {
        this.stateStackManager.popBackStack(loginFlowState, onPopListener);
    }

    void pushError(@Nullable AccountKitError accountKitError) {
        String userFacingMessage = accountKitError == null ? null : accountKitError.getUserFacingMessage();
        this.error = accountKitError;
        LoginFlowState backState = LoginFlowState.getBackState(this.loginFlowManager.getFlowState());
        this.loginFlowManager.setFlowState(LoginFlowState.ERROR);
        this.stateStackManager.pushError(this, this.loginFlowManager, backState, accountKitError, this.stateStackManager.getErrorOnPushListener(userFacingMessage));
    }

    void pushState(LoginFlowState loginFlowState, @Nullable StateStackManager.OnPushListener onPushListener) {
        if (this.isActive) {
            this.loginFlowManager.setFlowState(loginFlowState);
            if (onPushListener == null) {
                int i = AnonymousClass3.$SwitchMap$com$facebook$accountkit$ui$LoginFlowState[loginFlowState.ordinal()];
                if (i == 6) {
                    onPushListener = ((ActivityPhoneHandler) this.loginFlowManager.getActivityHandler()).getConfirmationCodePushListener(this);
                } else if (i == 13) {
                    pushError(null);
                    return;
                }
            }
            this.stateStackManager.pushState(this, this.loginFlowManager, onPushListener);
        } else {
            this.viewState.putString(PENDING_LOGIN_FLOW_STATE_KEY, loginFlowState.name());
        }
        if (loginFlowState.equals(LoginFlowState.ERROR)) {
            return;
        }
        this.error = null;
    }

    void sendCancelResult() {
        sendResult(0, new AccountKitLoginResultImpl(null, null, null, 0L, null, true));
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase
    void sendResult() {
        sendResult(this.result == LoginResult.SUCCESS ? -1 : 0, new AccountKitLoginResultImpl(this.accessToken, this.authorizationCode, this.finalAuthState, this.tokenRefreshIntervalInSeconds, this.error, false));
    }

    void setAccessToken(AccessToken accessToken) {
        this.accessToken = accessToken;
    }

    void setAuthorizationCode(String str) {
        this.authorizationCode = str;
    }

    void setFinalAuthState(String str) {
        this.finalAuthState = str;
    }

    void setLoginResult(LoginResult loginResult) {
        this.result = loginResult;
    }

    void setNewLoginFlowManagerAndHandler(LoginFlowManager loginFlowManager) {
        LoginFlowManager phoneLoginFlowManager;
        LoginFlowState flowState = this.loginFlowManager == null ? LoginFlowState.NONE : this.loginFlowManager.getFlowState();
        if (loginFlowManager == null && this.loginFlowManager != null) {
            this.loginFlowManager.cancel();
        }
        switch (this.configuration.getLoginType()) {
            case PHONE:
                phoneLoginFlowManager = new PhoneLoginFlowManager(this.configuration);
                break;
            case EMAIL:
                phoneLoginFlowManager = new EmailLoginFlowManager(this.configuration);
                break;
            default:
                return;
        }
        this.loginFlowManager = phoneLoginFlowManager;
        this.loginFlowManager.setFlowState(flowState);
    }

    void setTokenRefreshIntervalInSeconds(long j) {
        this.tokenRefreshIntervalInSeconds = j;
    }
}
