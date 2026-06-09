package com.facebook.accountkit;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.facebook.accountkit.internal.Utility;

/* JADX INFO: loaded from: classes.dex */
public final class Account implements Parcelable {
    public static final Parcelable.Creator<Account> CREATOR = new Parcelable.Creator<Account>() { // from class: com.facebook.accountkit.Account.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public Account createFromParcel(Parcel parcel) {
            return new Account(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public Account[] newArray(int i) {
            return new Account[i];
        }
    };
    private final String email;
    private final String id;
    private final PhoneNumber phoneNumber;

    private Account(Parcel parcel) {
        this.id = parcel.readString();
        this.phoneNumber = (PhoneNumber) parcel.readParcelable(PhoneNumber.class.getClassLoader());
        this.email = parcel.readString();
    }

    public Account(@NonNull String str, @Nullable PhoneNumber phoneNumber, @Nullable String str2) {
        this.id = str;
        this.phoneNumber = phoneNumber;
        this.email = str2;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof Account)) {
            return false;
        }
        Account account = (Account) obj;
        return Utility.areObjectsEqual(this.email, account.email) && Utility.areObjectsEqual(this.id, account.id) && Utility.areObjectsEqual(this.phoneNumber, account.phoneNumber);
    }

    public String getEmail() {
        return this.email;
    }

    public String getId() {
        return this.id;
    }

    public PhoneNumber getPhoneNumber() {
        return this.phoneNumber;
    }

    public int hashCode() {
        return ((((527 + Utility.getHashCode(this.email)) * 31) + Utility.getHashCode(this.id)) * 31) + Utility.getHashCode(this.phoneNumber);
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.id);
        parcel.writeParcelable(this.phoneNumber, i);
        parcel.writeString(this.email);
    }
}
