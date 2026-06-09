package com.facebook.accountkit.ui;

import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.EmailLoginModel;
import com.facebook.accountkit.EmailLoginTracker;
import com.facebook.accountkit.LoginResult;
import com.facebook.accountkit.ui.StateStackManager;

/* JADX INFO: loaded from: classes.dex */
final class ActivityEmailHandler extends ActivityHandler {
    public static final Parcelable.Creator<ActivityEmailHandler> CREATOR = new Parcelable.Creator<ActivityEmailHandler>() { // from class: com.facebook.accountkit.ui.ActivityEmailHandler.3
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public ActivityEmailHandler createFromParcel(Parcel parcel) {
            return new ActivityEmailHandler(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public ActivityEmailHandler[] newArray(int i) {
            return new ActivityEmailHandler[i];
        }
    };

    protected ActivityEmailHandler(Parcel parcel) {
        super(parcel);
    }

    public ActivityEmailHandler(@NonNull AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void emailVerifySetRetry(AccountKitActivity accountKitActivity) {
        ContentController contentController = accountKitActivity.getContentController();
        if (contentController instanceof EmailLoginContentController) {
            ((EmailLoginContentController) contentController).setRetry();
        }
    }

    private EmailLoginTracker getEmailTracker() {
        return (EmailLoginTracker) this.tracker;
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler
    public EmailLoginTracker getLoginTracker(final AccountKitActivity accountKitActivity) {
        if (getEmailTracker() == null) {
            this.tracker = new EmailLoginTracker() { // from class: com.facebook.accountkit.ui.ActivityEmailHandler.1
                /* JADX INFO: Access modifiers changed from: private */
                public void finishActivity() {
                    accountKitActivity.sendResult();
                }

                @Override // com.facebook.accountkit.EmailLoginTracker
                protected void onAccountVerified(EmailLoginModel emailLoginModel) {
                    if (accountKitActivity.getContentController() instanceof SendingCodeContentController) {
                        accountKitActivity.pushState(LoginFlowState.ACCOUNT_VERIFIED, null);
                    }
                }

                @Override // com.facebook.accountkit.EmailLoginTracker
                protected void onCancel(EmailLoginModel emailLoginModel) {
                    accountKitActivity.setNewLoginFlowManagerAndHandler(null);
                }

                @Override // com.facebook.accountkit.EmailLoginTracker
                protected void onError(AccountKitException accountKitException) {
                    accountKitActivity.pushError(accountKitException.getError());
                }

                @Override // com.facebook.accountkit.EmailLoginTracker
                protected void onStarted(EmailLoginModel emailLoginModel) {
                    if (accountKitActivity.getContentController() instanceof SendingCodeContentController) {
                        accountKitActivity.pushState(LoginFlowState.SENT_CODE, null);
                    }
                }

                @Override // com.facebook.accountkit.EmailLoginTracker
                protected void onSuccess(EmailLoginModel emailLoginModel) {
                    ContentController contentController = accountKitActivity.getContentController();
                    if ((contentController instanceof EmailVerifyContentController) || (contentController instanceof VerifyingCodeContentController)) {
                        accountKitActivity.pushState(LoginFlowState.VERIFIED, null);
                        accountKitActivity.setFinalAuthState(emailLoginModel.getFinalAuthState());
                        accountKitActivity.setAccessToken(emailLoginModel.getAccessToken());
                        accountKitActivity.setAuthorizationCode(emailLoginModel.getCode());
                        accountKitActivity.setLoginResult(LoginResult.SUCCESS);
                        AccessToken accessToken = emailLoginModel.getAccessToken();
                        if (accessToken != null) {
                            accountKitActivity.setTokenRefreshIntervalInSeconds(accessToken.getTokenRefreshIntervalSeconds());
                        }
                        new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.ActivityEmailHandler.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                finishActivity();
                            }
                        }, 2000L);
                    }
                }
            };
        }
        return getEmailTracker();
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler
    public void onAccountVerifiedComplete(AccountKitActivity accountKitActivity) {
        accountKitActivity.pushState(LoginFlowState.CONFIRM_ACCOUNT_VERIFIED, null);
    }

    public void onEmailLoginComplete(AccountKitActivity accountKitActivity, EmailLoginFlowManager emailLoginFlowManager, String str) {
        accountKitActivity.pushState(LoginFlowState.SENDING_CODE, null);
        emailLoginFlowManager.setEmail(str);
        emailLoginFlowManager.logInWithEmail(this.configuration.getResponseType(), this.configuration.getInitialAuthState());
    }

    public void onEmailVerifyRetry(final AccountKitActivity accountKitActivity) {
        AccountKit.cancelLogin();
        accountKitActivity.popBackStack(LoginFlowState.EMAIL_INPUT, new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityEmailHandler.2
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
            public void onContentPopped() {
                ActivityEmailHandler.this.emailVerifySetRetry(accountKitActivity);
            }
        });
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler
    public void onSentCodeComplete(AccountKitActivity accountKitActivity) {
        if (accountKitActivity.getContentController() instanceof SentCodeContentController) {
            accountKitActivity.pushState(LoginFlowState.EMAIL_VERIFY, null);
        }
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
    }
}
