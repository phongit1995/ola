package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitLoginResult;

/* JADX INFO: loaded from: classes.dex */
class AccountKitLoginResultImpl implements AccountKitLoginResult {
    public static final Parcelable.Creator<AccountKitLoginResultImpl> CREATOR = new Parcelable.Creator<AccountKitLoginResultImpl>() { // from class: com.facebook.accountkit.ui.AccountKitLoginResultImpl.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccountKitLoginResultImpl createFromParcel(Parcel parcel) {
            return new AccountKitLoginResultImpl(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccountKitLoginResultImpl[] newArray(int i) {
            return new AccountKitLoginResultImpl[i];
        }
    };
    private final AccessToken accessToken;
    private final String authorizationCode;
    private final boolean cancelled;
    private final AccountKitError error;
    private final String finalAuthorizationState;
    private final long tokenRefreshIntervalInSeconds;

    private AccountKitLoginResultImpl(Parcel parcel) {
        this.accessToken = (AccessToken) parcel.readParcelable(AccessToken.class.getClassLoader());
        this.authorizationCode = parcel.readString();
        this.finalAuthorizationState = parcel.readString();
        this.tokenRefreshIntervalInSeconds = parcel.readLong();
        this.error = (AccountKitError) parcel.readParcelable(AccountKitError.class.getClassLoader());
        this.cancelled = parcel.readByte() == 1;
    }

    public AccountKitLoginResultImpl(AccessToken accessToken, String str, String str2, long j, AccountKitError accountKitError, boolean z) {
        this.accessToken = accessToken;
        this.authorizationCode = str;
        this.tokenRefreshIntervalInSeconds = j;
        this.cancelled = z;
        this.error = accountKitError;
        this.finalAuthorizationState = str2;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // com.facebook.accountkit.AccountKitLoginResult
    @Nullable
    public AccessToken getAccessToken() {
        return this.accessToken;
    }

    @Override // com.facebook.accountkit.AccountKitLoginResult
    @Nullable
    public String getAuthorizationCode() {
        return this.authorizationCode;
    }

    @Override // com.facebook.accountkit.AccountKitLoginResult
    @Nullable
    public AccountKitError getError() {
        return this.error;
    }

    @Override // com.facebook.accountkit.AccountKitLoginResult
    @Nullable
    public String getFinalAuthorizationState() {
        return this.finalAuthorizationState;
    }

    @Override // com.facebook.accountkit.AccountKitLoginResult
    public long getTokenRefreshIntervalInSeconds() {
        return this.tokenRefreshIntervalInSeconds;
    }

    @Override // com.facebook.accountkit.AccountKitLoginResult
    public boolean wasCancelled() {
        return this.error == null && this.authorizationCode == null && this.accessToken == null;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeParcelable(this.accessToken, i);
        parcel.writeString(this.authorizationCode);
        parcel.writeString(this.finalAuthorizationState);
        parcel.writeLong(this.tokenRefreshIntervalInSeconds);
        parcel.writeParcelable(this.error, i);
        parcel.writeByte(this.cancelled ? (byte) 1 : (byte) 0);
    }
}
