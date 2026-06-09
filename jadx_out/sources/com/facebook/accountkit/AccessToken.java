package com.facebook.accountkit;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.facebook.accountkit.internal.Utility;
import java.util.Date;

/* JADX INFO: loaded from: classes.dex */
public final class AccessToken implements Parcelable {
    public static final Parcelable.Creator<AccessToken> CREATOR = new Parcelable.Creator<AccessToken>() { // from class: com.facebook.accountkit.AccessToken.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccessToken createFromParcel(Parcel parcel) {
            return new AccessToken(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccessToken[] newArray(int i) {
            return new AccessToken[i];
        }
    };
    private static final long DEFAULT_TOKEN_REFRESH_INTERVAL = 604800;
    private static final int PARCEL_VERSION = 2;
    private final String accountId;
    private final String applicationId;
    private final Date lastRefresh;
    private final String token;
    private final long tokenRefreshIntervalInSeconds;

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private AccessToken(Parcel parcel) {
        int i;
        String string;
        try {
            i = parcel.readInt();
        } catch (ClassCastException unused) {
            i = 1;
        }
        try {
            string = parcel.readString();
        } catch (ClassCastException unused2) {
            parcel.readLong();
            string = parcel.readString();
        }
        this.token = string;
        this.accountId = parcel.readString();
        this.lastRefresh = new Date(parcel.readLong());
        this.applicationId = parcel.readString();
        this.tokenRefreshIntervalInSeconds = i == 2 ? parcel.readLong() : DEFAULT_TOKEN_REFRESH_INTERVAL;
    }

    public AccessToken(@NonNull String str, @NonNull String str2, @NonNull String str3, long j, @Nullable Date date) {
        this.token = str;
        this.accountId = str2;
        this.applicationId = str3;
        this.tokenRefreshIntervalInSeconds = j;
        this.lastRefresh = date == null ? new Date() : date;
    }

    private String tokenToString() {
        return this.token == null ? "null" : AccountKit.getLoggingBehaviors().isEnabled(LoggingBehavior.INCLUDE_ACCESS_TOKENS) ? this.token : "ACCESS_TOKEN_REMOVED";
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof AccessToken)) {
            return false;
        }
        AccessToken accessToken = (AccessToken) obj;
        return this.tokenRefreshIntervalInSeconds == accessToken.tokenRefreshIntervalInSeconds && Utility.areObjectsEqual(this.accountId, accessToken.accountId) && Utility.areObjectsEqual(this.applicationId, accessToken.applicationId) && Utility.areObjectsEqual(this.lastRefresh, accessToken.lastRefresh) && Utility.areObjectsEqual(this.token, accessToken.token);
    }

    public String getAccountId() {
        return this.accountId;
    }

    public String getApplicationId() {
        return this.applicationId;
    }

    public Date getLastRefresh() {
        return this.lastRefresh;
    }

    public String getToken() {
        return this.token;
    }

    public long getTokenRefreshIntervalSeconds() {
        return this.tokenRefreshIntervalInSeconds;
    }

    public int hashCode() {
        return ((((((((527 + Utility.getHashCode(this.accountId)) * 31) + Utility.getHashCode(this.applicationId)) * 31) + Utility.getHashCode(this.lastRefresh)) * 31) + Utility.getHashCode(this.token)) * 31) + Utility.getHashCode(Long.valueOf(this.tokenRefreshIntervalInSeconds));
    }

    public String toString() {
        return "{AccessToken token:" + tokenToString() + " accountId:" + this.accountId + "}";
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeInt(2);
        parcel.writeString(this.token);
        parcel.writeString(this.accountId);
        parcel.writeLong(this.lastRefresh.getTime());
        parcel.writeString(this.applicationId);
        parcel.writeLong(this.tokenRefreshIntervalInSeconds);
    }
}
