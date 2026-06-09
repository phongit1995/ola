package com.facebook.accountkit;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.facebook.accountkit.internal.Utility;

/* JADX INFO: loaded from: classes.dex */
public final class PhoneNumber implements Parcelable {
    public static final Parcelable.Creator<PhoneNumber> CREATOR = new Parcelable.Creator<PhoneNumber>() { // from class: com.facebook.accountkit.PhoneNumber.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneNumber createFromParcel(Parcel parcel) {
            return new PhoneNumber(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public PhoneNumber[] newArray(int i) {
            return new PhoneNumber[i];
        }
    };
    private final String countryCode;
    private final String countryCodeIso;
    private final String phoneNumber;

    private PhoneNumber(Parcel parcel) {
        this.countryCode = parcel.readString();
        this.phoneNumber = parcel.readString();
        this.countryCodeIso = parcel.readString();
    }

    @Deprecated
    public PhoneNumber(String str, String str2) {
        this(str, str2, null);
    }

    public PhoneNumber(@NonNull String str, @NonNull String str2, @Nullable String str3) {
        this.phoneNumber = Utility.cleanPhoneNumberString(str2);
        this.countryCode = Utility.cleanPhoneNumberString(str);
        this.countryCodeIso = str3;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public boolean equals(Object obj) {
        return (obj instanceof PhoneNumber) && hashCode() == obj.hashCode();
    }

    public String getCountryCode() {
        return this.countryCode;
    }

    public String getCountryCodeIso() {
        return this.countryCodeIso;
    }

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public String getRawPhoneNumber() {
        return this.countryCode + this.phoneNumber;
    }

    public int hashCode() {
        return toString().hashCode();
    }

    public String toString() {
        return "+" + this.countryCode + this.phoneNumber;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.countryCode);
        parcel.writeString(this.phoneNumber);
        parcel.writeString(this.countryCodeIso);
    }
}
