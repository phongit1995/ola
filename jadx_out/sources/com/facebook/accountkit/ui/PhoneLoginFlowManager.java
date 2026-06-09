package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.AccountKitActivity;

/* JADX INFO: loaded from: classes.dex */
class PhoneLoginFlowManager extends LoginFlowManager {
    public static final Parcelable.Creator<PhoneLoginFlowManager> CREATOR = new Parcelable.Creator<PhoneLoginFlowManager>() { // from class: com.facebook.accountkit.ui.PhoneLoginFlowManager.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneLoginFlowManager createFromParcel(Parcel parcel) {
            return new PhoneLoginFlowManager(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneLoginFlowManager[] newArray(int i) {
            return new PhoneLoginFlowManager[i];
        }
    };
    private PhoneNumber lastUsedPhoneNumber;
    private NotificationChannel notificationChannel;

    PhoneLoginFlowManager(Parcel parcel) {
        super(parcel);
        this.notificationChannel = NotificationChannel.SMS;
        this.activityHandler = (ActivityHandler) parcel.readParcelable(ActivityPhoneHandler.class.getClassLoader());
        setLastUsedPhoneNumber((PhoneNumber) parcel.readParcelable(PhoneNumber.class.getClassLoader()));
    }

    PhoneLoginFlowManager(AccountKitConfiguration accountKitConfiguration) {
        super(LoginType.PHONE);
        this.notificationChannel = NotificationChannel.SMS;
        this.activityHandler = new ActivityPhoneHandler(accountKitConfiguration);
    }

    private PhoneNumber getLastUsedPhoneNumber() {
        return this.lastUsedPhoneNumber;
    }

    @Override // com.facebook.accountkit.ui.LoginFlowManager
    void confirmSeamlessLogin() {
        if (isValid()) {
            AccountKitController.continueSeamlessLogin();
        }
    }

    public NotificationChannel getNotificationChannel() {
        return this.notificationChannel;
    }

    public void logInWithPhoneNumber(PhoneNumber phoneNumber, NotificationChannel notificationChannel, AccountKitActivity.ResponseType responseType, @Nullable String str) {
        if (isValid()) {
            setLastUsedPhoneNumber(phoneNumber);
            AccountKitController.logInWithPhoneNumber(phoneNumber, notificationChannel, responseType.getValue(), str);
        }
    }

    public void setConfirmationCode(String str) {
        if (isValid()) {
            AccountKitController.continueLoginWithCode(str);
        }
    }

    void setLastUsedPhoneNumber(PhoneNumber phoneNumber) {
        this.lastUsedPhoneNumber = phoneNumber;
    }

    public void setNotificationChannel(NotificationChannel notificationChannel) {
        this.notificationChannel = notificationChannel;
    }

    @Override // com.facebook.accountkit.ui.LoginFlowManager, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeParcelable(this.activityHandler, i);
        parcel.writeParcelable(getLastUsedPhoneNumber(), i);
    }
}
