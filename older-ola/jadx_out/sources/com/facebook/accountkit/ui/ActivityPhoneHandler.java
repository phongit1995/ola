package com.facebook.accountkit.ui;

import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.LoginResult;
import com.facebook.accountkit.PhoneLoginModel;
import com.facebook.accountkit.PhoneLoginTracker;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.StateStackManager;

/* JADX INFO: loaded from: classes.dex */
final class ActivityPhoneHandler extends ActivityHandler {
    public static final Parcelable.Creator<ActivityPhoneHandler> CREATOR = new Parcelable.Creator<ActivityPhoneHandler>() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.9
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public ActivityPhoneHandler createFromParcel(Parcel parcel) {
            return new ActivityPhoneHandler(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public ActivityPhoneHandler[] newArray(int i) {
            return new ActivityPhoneHandler[i];
        }
    };
    private SmsTracker smsTracker;

    private ActivityPhoneHandler(Parcel parcel) {
        super(parcel);
    }

    ActivityPhoneHandler(@NonNull AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public PhoneLoginTracker getPhoneTracker() {
        return (PhoneLoginTracker) this.tracker;
    }

    private StateStackManager.OnPushListener getResendOnPushListener() {
        final PhoneLoginModel currentPhoneNumberLogInModel = AccountKit.getCurrentPhoneNumberLogInModel();
        final String string = currentPhoneNumberLogInModel != null ? currentPhoneNumberLogInModel.getPhoneNumber().toString() : null;
        if (string == null) {
            return null;
        }
        return new StateStackManager.OnPushListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.2
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPushListener
            public void onContentControllerReady(ContentController contentController) {
                if (contentController instanceof ResendContentController) {
                    ResendContentController resendContentController = (ResendContentController) contentController;
                    resendContentController.setPhoneNumber(string);
                    resendContentController.setNotificationChannels(ActivityPhoneHandler.this.configuration.getNotificationChannels());
                    resendContentController.setResendTime(currentPhoneNumberLogInModel.getResendTime());
                }
            }

            @Override // com.facebook.accountkit.ui.StateStackManager.OnPushListener
            public void onContentPushed() {
            }
        };
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void popToPhoneNumberInput(final AccountKitActivity accountKitActivity) {
        ContentController contentController = accountKitActivity.getContentController();
        if (contentController instanceof ResendContentController) {
            accountKitActivity.multiPopBackStack(new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.3
                @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
                public void onContentPopped() {
                    ActivityPhoneHandler.this.popToPhoneNumberInput(accountKitActivity);
                }
            });
        } else if (contentController instanceof LoginConfirmationCodeContentController) {
            accountKitActivity.popBackStack(LoginFlowState.PHONE_NUMBER_INPUT, new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.4
                @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
                public void onContentPopped() {
                    ActivityPhoneHandler.this.resendSetRetry(accountKitActivity);
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void resendSetRetry(AccountKitActivity accountKitActivity) {
        ContentController contentController = accountKitActivity.getContentController();
        if (contentController instanceof PhoneLoginContentController) {
            ((PhoneLoginContentController) contentController).setRetry();
            contentController.onResume(accountKitActivity);
        }
    }

    StateStackManager.OnPushListener getConfirmationCodePushListener(final AccountKitActivity accountKitActivity) {
        return new StateStackManager.OnPushListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.7
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPushListener
            public void onContentControllerReady(ContentController contentController) {
                PhoneLoginModel currentPhoneNumberLogInModel;
                if ((contentController instanceof LoginConfirmationCodeContentController) && (currentPhoneNumberLogInModel = AccountKit.getCurrentPhoneNumberLogInModel()) != null) {
                    LoginConfirmationCodeContentController loginConfirmationCodeContentController = (LoginConfirmationCodeContentController) contentController;
                    loginConfirmationCodeContentController.setPhoneNumber(currentPhoneNumberLogInModel.getPhoneNumber());
                    loginConfirmationCodeContentController.setNotificationChannel(currentPhoneNumberLogInModel.getNotificationChannel());
                    loginConfirmationCodeContentController.setDetectedConfirmationCode(ActivityPhoneHandler.this.getLoginTracker(accountKitActivity).getCode());
                }
            }

            @Override // com.facebook.accountkit.ui.StateStackManager.OnPushListener
            public void onContentPushed() {
            }
        };
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler
    public PhoneLoginTracker getLoginTracker(final AccountKitActivity accountKitActivity) {
        if (getPhoneTracker() == null) {
            this.tracker = new PhoneLoginTracker() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.1
                /* JADX INFO: Access modifiers changed from: private */
                public void finishActivity() {
                    accountKitActivity.sendResult();
                }

                @Override // com.facebook.accountkit.PhoneLoginTracker
                protected void onAccountVerified(PhoneLoginModel phoneLoginModel) {
                    if (accountKitActivity.getContentController() instanceof SendingCodeContentController) {
                        accountKitActivity.pushState(LoginFlowState.ACCOUNT_VERIFIED, null);
                    }
                }

                @Override // com.facebook.accountkit.PhoneLoginTracker
                protected void onCancel(PhoneLoginModel phoneLoginModel) {
                    accountKitActivity.setNewLoginFlowManagerAndHandler(null);
                }

                @Override // com.facebook.accountkit.PhoneLoginTracker
                protected void onError(AccountKitException accountKitException) {
                    accountKitActivity.pushError(accountKitException.getError());
                }

                @Override // com.facebook.accountkit.PhoneLoginTracker
                protected void onStarted(PhoneLoginModel phoneLoginModel) {
                    ContentController contentController = accountKitActivity.getContentController();
                    boolean z = contentController instanceof SendingCodeContentController;
                    if (z || (contentController instanceof VerifyingCodeContentController)) {
                        if (phoneLoginModel.getNotificationChannel() == NotificationChannel.SMS) {
                            ActivityPhoneHandler.this.startSmsTrackerIfPossible(accountKitActivity);
                        }
                        if (z) {
                            accountKitActivity.pushState(LoginFlowState.SENT_CODE, null);
                        } else {
                            accountKitActivity.popBackStack(LoginFlowState.CODE_INPUT, new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.1.1
                                @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
                                public void onContentPopped() {
                                    ContentController contentController2 = accountKitActivity.getContentController();
                                    if (contentController2 instanceof LoginConfirmationCodeContentController) {
                                        ((LoginConfirmationCodeContentController) contentController2).setRetry(true);
                                    }
                                }
                            });
                        }
                    }
                }

                @Override // com.facebook.accountkit.PhoneLoginTracker
                protected void onSuccess(PhoneLoginModel phoneLoginModel) {
                    ContentController contentController = accountKitActivity.getContentController();
                    if ((contentController instanceof LoginConfirmationCodeContentController) || (contentController instanceof VerifyingCodeContentController)) {
                        accountKitActivity.pushState(LoginFlowState.VERIFIED, null);
                        accountKitActivity.setAuthorizationCode(phoneLoginModel.getCode());
                        accountKitActivity.setAccessToken(phoneLoginModel.getAccessToken());
                        accountKitActivity.setLoginResult(LoginResult.SUCCESS);
                        accountKitActivity.setFinalAuthState(phoneLoginModel.getFinalAuthState());
                        AccessToken accessToken = phoneLoginModel.getAccessToken();
                        if (accessToken != null) {
                            accountKitActivity.setTokenRefreshIntervalInSeconds(accessToken.getTokenRefreshIntervalSeconds());
                        }
                        new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.1.2
                            @Override // java.lang.Runnable
                            public void run() {
                                finishActivity();
                            }
                        }, 2000L);
                    }
                }
            };
        }
        return getPhoneTracker();
    }

    SmsTracker getSmsTracker() {
        return this.smsTracker;
    }

    boolean isSmsTracking() {
        return this.smsTracker != null && this.smsTracker.isTracking();
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler
    public void onAccountVerifiedComplete(AccountKitActivity accountKitActivity) {
        accountKitActivity.pushState(LoginFlowState.CONFIRM_ACCOUNT_VERIFIED, null);
    }

    void onConfirmationCodeComplete(AccountKitActivity accountKitActivity, PhoneLoginFlowManager phoneLoginFlowManager, String str) {
        accountKitActivity.pushState(LoginFlowState.VERIFYING_CODE, null);
        phoneLoginFlowManager.setConfirmationCode(str);
    }

    void onConfirmationCodeRetry(AccountKitActivity accountKitActivity) {
        accountKitActivity.pushState(LoginFlowState.RESEND, getResendOnPushListener());
    }

    void onPhoneLoginComplete(AccountKitActivity accountKitActivity, PhoneLoginFlowManager phoneLoginFlowManager, PhoneNumber phoneNumber) {
        phoneLoginFlowManager.setNotificationChannel(NotificationChannel.SMS);
        accountKitActivity.pushState(LoginFlowState.SENDING_CODE, null);
        phoneLoginFlowManager.logInWithPhoneNumber(phoneNumber, NotificationChannel.SMS, this.configuration.getResponseType(), this.configuration.getInitialAuthState());
    }

    void onResend(AccountKitActivity accountKitActivity) {
        AccountKit.cancelLogin();
        popToPhoneNumberInput(accountKitActivity);
    }

    void onResendFacebookNotification(final AccountKitActivity accountKitActivity, final PhoneLoginFlowManager phoneLoginFlowManager) {
        PhoneLoginModel currentPhoneNumberLogInModel = AccountKit.getCurrentPhoneNumberLogInModel();
        if (currentPhoneNumberLogInModel == null) {
            return;
        }
        phoneLoginFlowManager.setNotificationChannel(NotificationChannel.FACEBOOK);
        final PhoneNumber phoneNumber = currentPhoneNumberLogInModel.getPhoneNumber();
        accountKitActivity.multiPopBackStack(new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.5
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
            public void onContentPopped() {
                accountKitActivity.popBackStack(LoginFlowState.SENT_CODE, new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.5.1
                    @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
                    public void onContentPopped() {
                        accountKitActivity.pushState(LoginFlowState.SENDING_CODE, null);
                        phoneLoginFlowManager.logInWithPhoneNumber(phoneNumber, NotificationChannel.FACEBOOK, ActivityPhoneHandler.this.configuration.getResponseType(), ActivityPhoneHandler.this.configuration.getInitialAuthState());
                    }
                });
            }
        });
    }

    void onResendVoiceCallNotification(final AccountKitActivity accountKitActivity, final PhoneLoginFlowManager phoneLoginFlowManager) {
        PhoneLoginModel currentPhoneNumberLogInModel = AccountKit.getCurrentPhoneNumberLogInModel();
        if (currentPhoneNumberLogInModel == null) {
            return;
        }
        phoneLoginFlowManager.setNotificationChannel(NotificationChannel.VOICE_CALLBACK);
        final PhoneNumber phoneNumber = currentPhoneNumberLogInModel.getPhoneNumber();
        accountKitActivity.multiPopBackStack(new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.6
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
            public void onContentPopped() {
                accountKitActivity.popBackStack(LoginFlowState.SENT_CODE, new StateStackManager.OnPopListener() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.6.1
                    @Override // com.facebook.accountkit.ui.StateStackManager.OnPopListener
                    public void onContentPopped() {
                        accountKitActivity.pushState(LoginFlowState.SENDING_CODE, null);
                        phoneLoginFlowManager.logInWithPhoneNumber(phoneNumber, NotificationChannel.VOICE_CALLBACK, ActivityPhoneHandler.this.configuration.getResponseType(), ActivityPhoneHandler.this.configuration.getInitialAuthState());
                    }
                });
            }
        });
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler
    public void onSentCodeComplete(AccountKitActivity accountKitActivity) {
        accountKitActivity.pushState(LoginFlowState.CODE_INPUT, null);
    }

    void pauseSmsTracker() {
        if (this.smsTracker != null) {
            this.smsTracker.pauseTracking();
        }
    }

    void startSmsTrackerIfPossible(final AccountKitActivity accountKitActivity) {
        if (SmsTracker.canTrackSms(AccountKitController.getApplicationContext(), this.configuration)) {
            if (this.smsTracker == null) {
                this.smsTracker = new SmsTracker() { // from class: com.facebook.accountkit.ui.ActivityPhoneHandler.8
                    @Override // com.facebook.accountkit.ui.SmsTracker
                    protected void confirmationCodeReceived(String str) {
                        ContentController contentController = accountKitActivity.getContentController();
                        if ((contentController instanceof SendingCodeContentController) || (contentController instanceof SentCodeContentController)) {
                            ActivityPhoneHandler.this.getPhoneTracker().setCode(str);
                        } else if (contentController instanceof LoginConfirmationCodeContentController) {
                            ((LoginConfirmationCodeContentController) contentController).setDetectedConfirmationCode(str);
                        }
                        ActivityPhoneHandler.this.smsTracker.stopTracking();
                    }
                };
            }
            this.smsTracker.startTracking();
        }
    }

    void stopSmsTracker() {
        if (this.smsTracker != null) {
            this.smsTracker.stopTracking();
        }
    }

    @Override // com.facebook.accountkit.ui.ActivityHandler, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
    }
}
