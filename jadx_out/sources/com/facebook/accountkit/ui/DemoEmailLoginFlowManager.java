package com.facebook.accountkit.ui;

import android.content.Intent;
import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.EmailLoginModel;
import com.facebook.accountkit.EmailLoginTracker;
import com.facebook.accountkit.Tracker;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.InternalAccountKitError;
import com.facebook.accountkit.internal.LoginStatus;
import com.facebook.accountkit.ui.AccountKitActivity;
import com.facebook.login.widget.ToolTipPopup;
import java.util.Date;

/* JADX INFO: loaded from: classes.dex */
final class DemoEmailLoginFlowManager extends EmailLoginFlowManager {
    public static final Parcelable.Creator<DemoEmailLoginFlowManager> CREATOR = new Parcelable.Creator<DemoEmailLoginFlowManager>() { // from class: com.facebook.accountkit.ui.DemoEmailLoginFlowManager.2
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public DemoEmailLoginFlowManager createFromParcel(Parcel parcel) {
            return new DemoEmailLoginFlowManager(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public DemoEmailLoginFlowManager[] newArray(int i) {
            return new DemoEmailLoginFlowManager[i];
        }
    };
    private static final int MOCK_EMAIL_DELAY_MS = 6000;
    private static final int MOCK_NETWORK_DELAY_MS = 2000;
    private boolean isValid;
    private DemoEmailLoginModel loginModel;

    private static class DemoEmailLoginModel implements EmailLoginModel {
        public static final Parcelable.Creator<DemoEmailLoginModel> CREATOR = new Parcelable.Creator<DemoEmailLoginModel>() { // from class: com.facebook.accountkit.ui.DemoEmailLoginFlowManager.DemoEmailLoginModel.1
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public DemoEmailLoginModel createFromParcel(Parcel parcel) {
                return new DemoEmailLoginModel(parcel);
            }

            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public DemoEmailLoginModel[] newArray(int i) {
                return new DemoEmailLoginModel[i];
            }
        };
        private final AccessToken accessToken;
        private final String authState;
        private final String confirmationCode;
        private final String email;

        DemoEmailLoginModel(Parcel parcel) {
            this.accessToken = (AccessToken) parcel.readParcelable(AccessToken.class.getClassLoader());
            this.authState = parcel.readString();
            this.confirmationCode = parcel.readString();
            this.email = parcel.readString();
        }

        public DemoEmailLoginModel(String str, String str2, String str3, AccessToken accessToken) {
            this.email = str;
            this.authState = str2;
            this.confirmationCode = str3;
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
            return null;
        }

        @Override // com.facebook.accountkit.EmailLoginModel
        public String getEmail() {
            return this.email;
        }

        @Override // com.facebook.accountkit.LoginModel
        public String getFinalAuthState() {
            return this.authState;
        }

        @Override // com.facebook.accountkit.LoginModel
        @Nullable
        public String getPrivacyPolicy() {
            return null;
        }

        @Override // com.facebook.accountkit.LoginModel
        @Nullable
        public String getTermsOfService() {
            return null;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeParcelable(this.accessToken, i);
            parcel.writeString(this.authState);
            parcel.writeString(this.confirmationCode);
            parcel.writeString(this.email);
        }
    }

    protected DemoEmailLoginFlowManager(Parcel parcel) {
        super(parcel);
        this.isValid = true;
    }

    public DemoEmailLoginFlowManager(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        this.isValid = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void broadcastLoginState(LoginStatus loginStatus, AccountKitError accountKitError) {
        LocalBroadcastManager.getInstance(AccountKitController.getApplicationContext()).sendBroadcast(new Intent(EmailLoginTracker.ACTION_EMAIL_LOGIN_STATE_CHANGED).putExtra(Tracker.EXTRA_LOGIN_MODEL, this.loginModel).putExtra(Tracker.EXTRA_LOGIN_STATUS, loginStatus).putExtra(Tracker.EXTRA_LOGIN_ERROR, accountKitError));
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

    @Override // com.facebook.accountkit.ui.EmailLoginFlowManager
    public void logInWithEmail(AccountKitActivity.ResponseType responseType, String str) {
        if (this.isValid) {
            final String email = getEmail();
            this.loginModel = new DemoEmailLoginModel(email, str, responseType == AccountKitActivity.ResponseType.CODE ? "DEMOCODE" : null, responseType == AccountKitActivity.ResponseType.TOKEN ? getAccessToken() : null);
            new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.DemoEmailLoginFlowManager.1
                @Override // java.lang.Runnable
                public void run() {
                    if (email.endsWith("@example.com")) {
                        DemoEmailLoginFlowManager.this.broadcastLoginState(LoginStatus.PENDING, null);
                        new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.DemoEmailLoginFlowManager.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                DemoEmailLoginFlowManager.this.broadcastLoginState(LoginStatus.SUCCESS, null);
                            }
                        }, ToolTipPopup.DEFAULT_POPUP_DISPLAY_TIME);
                    } else {
                        DemoEmailLoginFlowManager.this.broadcastLoginState(LoginStatus.ERROR, new AccountKitError(AccountKitError.Type.ARGUMENT_ERROR, new InternalAccountKitError(InternalAccountKitError.INVALID_CONFIRMATION_CODE, null, "[Demo] use *@example.com")));
                    }
                }
            }, 2000L);
        }
    }
}
