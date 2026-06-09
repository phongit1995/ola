package com.facebook.accountkit.ui;

import android.content.Intent;
import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.PhoneLoginModel;
import com.facebook.accountkit.PhoneLoginTracker;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.Tracker;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.InternalAccountKitError;
import com.facebook.accountkit.internal.LoginStatus;
import com.facebook.accountkit.ui.AccountKitActivity;
import java.util.Date;

/* JADX INFO: loaded from: classes.dex */
final class DemoPhoneLoginFlowManager extends PhoneLoginFlowManager {
    public static final Parcelable.Creator<DemoPhoneLoginFlowManager> CREATOR = new Parcelable.Creator<DemoPhoneLoginFlowManager>() { // from class: com.facebook.accountkit.ui.DemoPhoneLoginFlowManager.3
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public DemoPhoneLoginFlowManager createFromParcel(Parcel parcel) {
            return new DemoPhoneLoginFlowManager(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public DemoPhoneLoginFlowManager[] newArray(int i) {
            return new DemoPhoneLoginFlowManager[i];
        }
    };
    private static final String MOCK_CONFIRMATION_CODE = "123456";
    private static final int MOCK_NETWORK_DELAY_MS = 2000;
    private AccountKitActivity activity;
    private boolean isValid;
    private DemoPhoneLoginModel loginModel;
    private ActivityPhoneHandler phoneListeners;

    private static class DemoPhoneLoginModel implements PhoneLoginModel {
        public static final Parcelable.Creator<DemoPhoneLoginModel> CREATOR = new Parcelable.Creator<DemoPhoneLoginModel>() { // from class: com.facebook.accountkit.ui.DemoPhoneLoginFlowManager.DemoPhoneLoginModel.1
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public DemoPhoneLoginModel createFromParcel(Parcel parcel) {
                return new DemoPhoneLoginModel(parcel);
            }

            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public DemoPhoneLoginModel[] newArray(int i) {
                return new DemoPhoneLoginModel[i];
            }
        };
        private final AccessToken accessToken;
        private final String authState;
        private final String confirmationCode;
        private final PhoneNumber phoneNumber;

        DemoPhoneLoginModel(Parcel parcel) {
            this.accessToken = (AccessToken) parcel.readParcelable(AccessToken.class.getClassLoader());
            this.authState = parcel.readString();
            this.confirmationCode = parcel.readString();
            this.phoneNumber = (PhoneNumber) parcel.readParcelable(PhoneNumber.class.getClassLoader());
        }

        DemoPhoneLoginModel(PhoneNumber phoneNumber, String str, String str2, AccessToken accessToken) {
            this.phoneNumber = phoneNumber;
            this.authState = str;
            this.confirmationCode = str2;
            this.accessToken = accessToken;
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 0;
        }

        @Override // com.facebook.accountkit.LoginModel
        public AccessToken getAccessToken() {
            return this.accessToken;
        }

        @Override // com.facebook.accountkit.LoginModel
        public String getCode() {
            return this.confirmationCode;
        }

        @Override // com.facebook.accountkit.PhoneLoginModel
        public String getConfirmationCode() {
            return this.confirmationCode;
        }

        @Override // com.facebook.accountkit.LoginModel
        public String getFinalAuthState() {
            return this.authState;
        }

        @Override // com.facebook.accountkit.PhoneLoginModel
        public NotificationChannel getNotificationChannel() {
            return NotificationChannel.SMS;
        }

        @Override // com.facebook.accountkit.PhoneLoginModel
        public PhoneNumber getPhoneNumber() {
            return this.phoneNumber;
        }

        @Override // com.facebook.accountkit.LoginModel
        public String getPrivacyPolicy() {
            return null;
        }

        @Override // com.facebook.accountkit.PhoneLoginModel
        public long getResendTime() {
            return System.currentTimeMillis();
        }

        @Override // com.facebook.accountkit.LoginModel
        public String getTermsOfService() {
            return null;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeParcelable(this.accessToken, i);
            parcel.writeString(this.authState);
            parcel.writeString(this.confirmationCode);
            parcel.writeParcelable(this.phoneNumber, i);
        }
    }

    private DemoPhoneLoginFlowManager(Parcel parcel) {
        super(parcel);
        this.isValid = true;
    }

    public DemoPhoneLoginFlowManager(AccountKitConfiguration accountKitConfiguration, AccountKitActivity accountKitActivity, ActivityPhoneHandler activityPhoneHandler) {
        super(accountKitConfiguration);
        this.isValid = true;
        this.activity = accountKitActivity;
        this.phoneListeners = activityPhoneHandler;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void broadcastLoginState(LoginStatus loginStatus, AccountKitError accountKitError) {
        LocalBroadcastManager.getInstance(AccountKitController.getApplicationContext()).sendBroadcast(new Intent(PhoneLoginTracker.ACTION_PHONE_LOGIN_STATE_CHANGED).putExtra(Tracker.EXTRA_LOGIN_MODEL, this.loginModel).putExtra(Tracker.EXTRA_LOGIN_STATUS, loginStatus).putExtra(Tracker.EXTRA_LOGIN_ERROR, accountKitError));
    }

    @Override // com.facebook.accountkit.ui.LoginFlowManager
    public void cancel() {
        this.isValid = false;
        broadcastLoginState(LoginStatus.CANCELLED, null);
    }

    @Override // com.facebook.accountkit.ui.LoginFlowManager
    public AccessToken getAccessToken() {
        if (this.isValid) {
            return new AccessToken("TEST_ACCESS_TOKEN", "TEST_ACCOUNT_ID", AccountKit.getApplicationId(), 300000L, new Date());
        }
        return null;
    }

    @Override // com.facebook.accountkit.ui.LoginFlowManager
    public boolean isValid() {
        return this.isValid;
    }

    @Override // com.facebook.accountkit.ui.PhoneLoginFlowManager
    public void logInWithPhoneNumber(final PhoneNumber phoneNumber, NotificationChannel notificationChannel, AccountKitActivity.ResponseType responseType, String str) {
        if (this.isValid) {
            this.loginModel = new DemoPhoneLoginModel(phoneNumber, str, responseType == AccountKitActivity.ResponseType.CODE ? "DEMOCODE" : null, responseType == AccountKitActivity.ResponseType.TOKEN ? getAccessToken() : null);
            setLastUsedPhoneNumber(phoneNumber);
            new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.DemoPhoneLoginFlowManager.1
                @Override // java.lang.Runnable
                public void run() {
                    if (phoneNumber.getPhoneNumber().length() == 10) {
                        DemoPhoneLoginFlowManager.this.broadcastLoginState(LoginStatus.PENDING, null);
                        new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.DemoPhoneLoginFlowManager.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                DemoPhoneLoginFlowManager.this.phoneListeners.startSmsTrackerIfPossible(DemoPhoneLoginFlowManager.this.activity);
                                DemoPhoneLoginFlowManager.this.phoneListeners.getSmsTracker().confirmationCodeReceived(DemoPhoneLoginFlowManager.MOCK_CONFIRMATION_CODE);
                            }
                        }, 2000L);
                    } else {
                        DemoPhoneLoginFlowManager.this.broadcastLoginState(LoginStatus.ERROR, new AccountKitError(AccountKitError.Type.ARGUMENT_ERROR, new InternalAccountKitError(InternalAccountKitError.INVALID_CREDENTIALS_OR_LOGIN_REQUEST, null, "[Demo] use a 10 digit number")));
                    }
                }
            }, 2000L);
        }
    }

    @Override // com.facebook.accountkit.ui.PhoneLoginFlowManager
    public void setConfirmationCode(final String str) {
        if (this.isValid) {
            new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.DemoPhoneLoginFlowManager.2
                /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
                @Override // java.lang.Runnable
                public void run() {
                    DemoPhoneLoginFlowManager demoPhoneLoginFlowManager;
                    LoginStatus loginStatus;
                    AccountKitError accountKitError = null;
                    if (str.equals(DemoPhoneLoginFlowManager.MOCK_CONFIRMATION_CODE)) {
                        demoPhoneLoginFlowManager = DemoPhoneLoginFlowManager.this;
                        loginStatus = LoginStatus.SUCCESS;
                    } else {
                        accountKitError = new AccountKitError(AccountKitError.Type.ARGUMENT_ERROR, new InternalAccountKitError(InternalAccountKitError.INVALID_CREDENTIALS_OR_LOGIN_REQUEST, null, "[Demo] use confirmation code 123456"));
                        demoPhoneLoginFlowManager = DemoPhoneLoginFlowManager.this;
                        loginStatus = LoginStatus.ERROR;
                    }
                    demoPhoneLoginFlowManager.broadcastLoginState(loginStatus, accountKitError);
                }
            }, 2000L);
        }
    }
}
