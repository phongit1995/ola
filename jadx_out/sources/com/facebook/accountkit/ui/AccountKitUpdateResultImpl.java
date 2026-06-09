package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitUpdateResult;

/* JADX INFO: loaded from: classes.dex */
class AccountKitUpdateResultImpl implements AccountKitUpdateResult {
    public static final Parcelable.Creator<AccountKitUpdateResultImpl> CREATOR = new Parcelable.Creator<AccountKitUpdateResultImpl>() { // from class: com.facebook.accountkit.ui.AccountKitUpdateResultImpl.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccountKitUpdateResultImpl createFromParcel(Parcel parcel) {
            return new AccountKitUpdateResultImpl(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccountKitUpdateResultImpl[] newArray(int i) {
            return new AccountKitUpdateResultImpl[i];
        }
    };
    private final boolean cancelled;

    @Nullable
    private final AccountKitError error;
    private final String finalAuthorizationState;

    private AccountKitUpdateResultImpl(Parcel parcel) {
        this.finalAuthorizationState = parcel.readString();
        this.error = (AccountKitError) parcel.readParcelable(AccountKitError.class.getClassLoader());
        this.cancelled = parcel.readByte() == 1;
    }

    public AccountKitUpdateResultImpl(String str, AccountKitError accountKitError, boolean z) {
        this.cancelled = z;
        this.error = accountKitError;
        this.finalAuthorizationState = str;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // com.facebook.accountkit.AccountKitUpdateResult
    @Nullable
    public AccountKitError getError() {
        return this.error;
    }

    @Override // com.facebook.accountkit.AccountKitUpdateResult
    @Nullable
    public String getFinalAuthorizationState() {
        return this.finalAuthorizationState;
    }

    @Override // com.facebook.accountkit.AccountKitUpdateResult
    public boolean wasCancelled() {
        return this.error == null;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.finalAuthorizationState);
        parcel.writeParcelable(this.error, i);
        parcel.writeByte(this.cancelled ? (byte) 1 : (byte) 0);
    }
}
