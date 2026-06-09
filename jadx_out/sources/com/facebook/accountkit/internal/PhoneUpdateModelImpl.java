package com.facebook.accountkit.internal;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.PhoneUpdateModel;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class PhoneUpdateModelImpl implements PhoneUpdateModel {
    public static final Parcelable.Creator<PhoneUpdateModelImpl> CREATOR = new Parcelable.Creator<PhoneUpdateModelImpl>() { // from class: com.facebook.accountkit.internal.PhoneUpdateModelImpl.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneUpdateModelImpl createFromParcel(Parcel parcel) {
            return new PhoneUpdateModelImpl(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneUpdateModelImpl[] newArray(int i) {
            return new PhoneUpdateModelImpl[i];
        }
    };
    private String confirmationCode;
    private AccountKitError error;
    private long expiresInSeconds;
    private Map<String, String> fields;
    private String finalUpdateState;
    private String initialUpdateState;
    private PhoneNumber phoneNumber;
    private long resendTime;
    private UpdateStatus status;
    private String updateRequestCode;

    private PhoneUpdateModelImpl(Parcel parcel) {
        this.status = UpdateStatus.EMPTY;
        this.fields = new HashMap();
        this.phoneNumber = (PhoneNumber) parcel.readParcelable(PhoneNumber.class.getClassLoader());
        this.resendTime = parcel.readLong();
        this.expiresInSeconds = parcel.readLong();
        this.confirmationCode = parcel.readString();
        this.updateRequestCode = parcel.readString();
        this.finalUpdateState = parcel.readString();
        this.error = (AccountKitError) parcel.readParcelable(AccountKitError.class.getClassLoader());
        this.status = UpdateStatus.valueOf(parcel.readString());
        this.fields = new HashMap();
        int i = parcel.readInt();
        for (int i2 = 0; i2 < i; i2++) {
            this.fields.put(parcel.readString(), parcel.readString());
        }
    }

    PhoneUpdateModelImpl(PhoneNumber phoneNumber) {
        this.status = UpdateStatus.EMPTY;
        this.fields = new HashMap();
        this.phoneNumber = phoneNumber;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof PhoneUpdateModelImpl)) {
            return false;
        }
        PhoneUpdateModelImpl phoneUpdateModelImpl = (PhoneUpdateModelImpl) obj;
        return this.expiresInSeconds == phoneUpdateModelImpl.expiresInSeconds && this.resendTime == phoneUpdateModelImpl.resendTime && Utility.areObjectsEqual(this.error, phoneUpdateModelImpl.error) && Utility.areObjectsEqual(this.status, phoneUpdateModelImpl.status) && Utility.areObjectsEqual(this.phoneNumber, phoneUpdateModelImpl.phoneNumber) && Utility.areObjectsEqual(this.updateRequestCode, phoneUpdateModelImpl.updateRequestCode) && Utility.areObjectsEqual(this.finalUpdateState, phoneUpdateModelImpl.finalUpdateState) && Utility.areObjectsEqual(this.confirmationCode, phoneUpdateModelImpl.confirmationCode);
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public String getConfirmationCode() {
        return this.confirmationCode;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public AccountKitError getError() {
        return this.error;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public String getFinalUpdateState() {
        return this.finalUpdateState;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public String getInitialUpdateState() {
        return this.initialUpdateState;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public PhoneNumber getPhoneNumber() {
        return this.phoneNumber;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    @Nullable
    public String getPrivacyPolicy() {
        return this.fields.get(AccountKitGraphConstants.PRIVACY_POLICY);
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public long getResendTime() {
        return this.resendTime;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public UpdateStatus getStatus() {
        return this.status;
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    @Nullable
    public String getTermsOfService() {
        return this.fields.get(AccountKitGraphConstants.TERMS_OF_SERVICE);
    }

    @Override // com.facebook.accountkit.PhoneUpdateModel
    public String getUpdateRequestCode() {
        return this.updateRequestCode;
    }

    public int hashCode() {
        return ((((((((((((((527 + this.phoneNumber.hashCode()) * 31) + Long.valueOf(this.resendTime).hashCode()) * 31) + Long.valueOf(this.expiresInSeconds).hashCode()) * 31) + this.error.hashCode()) * 31) + this.status.hashCode()) * 31) + this.updateRequestCode.hashCode()) * 31) + this.finalUpdateState.hashCode()) * 31) + this.confirmationCode.hashCode();
    }

    void putField(String str, String str2) {
        this.fields.put(str, str2);
    }

    void setConfirmationCode(String str) {
        Validate.isEquals(getStatus(), UpdateStatus.PENDING, "Phone status");
        Validate.sdkInitialized();
        this.confirmationCode = str;
    }

    void setError(AccountKitError accountKitError) {
        this.error = accountKitError;
    }

    void setExpiresInSeconds(long j) {
        this.expiresInSeconds = j;
    }

    void setFinalUpdateState(String str) {
        this.finalUpdateState = str;
    }

    void setInitialUpdateState(String str) {
        this.initialUpdateState = str;
    }

    void setPhoneNumber(PhoneNumber phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    void setResendTime(long j) {
        this.resendTime = j;
    }

    void setStatus(UpdateStatus updateStatus) {
        this.status = updateStatus;
    }

    void setUpdateRequestCode(String str) {
        this.updateRequestCode = str;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeParcelable(this.phoneNumber, i);
        parcel.writeLong(this.resendTime);
        parcel.writeLong(this.expiresInSeconds);
        parcel.writeString(this.confirmationCode);
        parcel.writeString(this.updateRequestCode);
        parcel.writeString(this.finalUpdateState);
        parcel.writeParcelable(this.error, i);
        parcel.writeString(this.status.name());
        parcel.writeInt(this.fields.size());
        for (String str : this.fields.keySet()) {
            parcel.writeString(str);
            parcel.writeString(this.fields.get(str));
        }
    }
}
