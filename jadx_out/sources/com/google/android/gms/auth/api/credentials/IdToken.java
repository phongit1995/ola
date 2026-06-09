package com.google.android.gms.auth.api.credentials;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "IdTokenCreator")
@SafeParcelable.Reserved({1000})
public final class IdToken extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<IdToken> CREATOR = new zzl();

    @NonNull
    @SafeParcelable.Field(getter = "getAccountType", id = 1)
    private final String zzbx;

    @NonNull
    @SafeParcelable.Field(getter = "getIdToken", id = 2)
    private final String zzdf;

    @SafeParcelable.Constructor
    public IdToken(@SafeParcelable.Param(id = 1) @NonNull String str, @SafeParcelable.Param(id = 2) @NonNull String str2) {
        Preconditions.checkArgument(!TextUtils.isEmpty(str), "account type string cannot be null or empty");
        Preconditions.checkArgument(!TextUtils.isEmpty(str2), "id token string cannot be null or empty");
        this.zzbx = str;
        this.zzdf = str2;
    }

    @NonNull
    public final String getAccountType() {
        return this.zzbx;
    }

    @NonNull
    public final String getIdToken() {
        return this.zzdf;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getAccountType(), false);
        SafeParcelWriter.writeString(parcel, 2, getIdToken(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
