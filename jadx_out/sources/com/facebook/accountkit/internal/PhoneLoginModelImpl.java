package com.facebook.accountkit.internal;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.PhoneLoginModel;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.ui.NotificationChannel;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public final class PhoneLoginModelImpl extends LoginModelImpl implements PhoneLoginModel {
    public static final Parcelable.Creator<PhoneLoginModelImpl> CREATOR = new Parcelable.Creator<PhoneLoginModelImpl>() { // from class: com.facebook.accountkit.internal.PhoneLoginModelImpl.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneLoginModelImpl createFromParcel(Parcel parcel) {
            return new PhoneLoginModelImpl(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneLoginModelImpl[] newArray(int i) {
            return new PhoneLoginModelImpl[i];
        }
    };
    private String confirmationCode;

    @NonNull
    private final NotificationChannel notificationChannel;
    private PhoneNumber phoneNumber;
    private long resendTime;

    private PhoneLoginModelImpl(Parcel parcel) {
        super(parcel);
        this.phoneNumber = (PhoneNumber) parcel.readParcelable(PhoneNumber.class.getClassLoader());
        this.confirmationCode = parcel.readString();
        this.notificationChannel = NotificationChannel.values()[parcel.readInt()];
        this.fields = new HashMap();
        int i = parcel.readInt();
        for (int i2 = 0; i2 < i; i2++) {
            this.fields.put(parcel.readString(), parcel.readString());
        }
        this.resendTime = parcel.readLong();
    }

    PhoneLoginModelImpl(PhoneNumber phoneNumber, @NonNull NotificationChannel notificationChannel, String str) {
        super(str);
        this.notificationChannel = notificationChannel;
        this.phoneNumber = phoneNumber;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof PhoneLoginModelImpl)) {
            return false;
        }
        PhoneLoginModelImpl phoneLoginModelImpl = (PhoneLoginModelImpl) obj;
        return super.equals(phoneLoginModelImpl) && Utility.areObjectsEqual(this.confirmationCode, phoneLoginModelImpl.confirmationCode) && Utility.areObjectsEqual(this.phoneNumber, phoneLoginModelImpl.phoneNumber) && this.notificationChannel == phoneLoginModelImpl.notificationChannel && this.resendTime == phoneLoginModelImpl.resendTime;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    @Nullable
    public /* bridge */ /* synthetic */ AccessToken getAccessToken() {
        return super.getAccessToken();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    public /* bridge */ /* synthetic */ String getCode() {
        return super.getCode();
    }

    @Override // com.facebook.accountkit.PhoneLoginModel
    public String getConfirmationCode() {
        return this.confirmationCode;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ AccountKitError getError() {
        return super.getError();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    public /* bridge */ /* synthetic */ String getFinalAuthState() {
        return super.getFinalAuthState();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ String getInitialAuthState() {
        return super.getInitialAuthState();
    }

    @Override // com.facebook.accountkit.PhoneLoginModel
    @NonNull
    public NotificationChannel getNotificationChannel() {
        return this.notificationChannel;
    }

    @Override // com.facebook.accountkit.PhoneLoginModel
    public PhoneNumber getPhoneNumber() {
        return this.phoneNumber;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    @Nullable
    public /* bridge */ /* synthetic */ String getPrivacyPolicy() {
        return super.getPrivacyPolicy();
    }

    @Override // com.facebook.accountkit.PhoneLoginModel
    public long getResendTime() {
        return this.resendTime;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ String getResponseType() {
        return super.getResponseType();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ LoginStatus getStatus() {
        return super.getStatus();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    @Nullable
    public /* bridge */ /* synthetic */ String getTermsOfService() {
        return super.getTermsOfService();
    }

    void setConfirmationCode(@NonNull String str) {
        Validate.isEquals(getStatus(), LoginStatus.PENDING, "Phone status");
        Validate.sdkInitialized();
        this.confirmationCode = str;
    }

    void setPhoneNumber(PhoneNumber phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    void setResendTime(long j) {
        this.resendTime = j;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeParcelable(this.phoneNumber, i);
        parcel.writeString(this.confirmationCode);
        parcel.writeInt(this.notificationChannel.ordinal());
        parcel.writeInt(this.fields.size());
        for (String str : this.fields.keySet()) {
            parcel.writeString(str);
            parcel.writeString(this.fields.get(str));
        }
        parcel.writeLong(this.resendTime);
    }
}
