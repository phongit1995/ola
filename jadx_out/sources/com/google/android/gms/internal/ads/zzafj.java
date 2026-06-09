package com.google.android.gms.internal.ads;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "StringParcelCreator")
@SafeParcelable.Reserved({1})
@zzadh
public final class zzafj extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzafj> CREATOR = new zzafk();

    @SafeParcelable.Field(id = 2)
    String zzbgu;

    @SafeParcelable.Constructor
    public zzafj(@SafeParcelable.Param(id = 2) String str) {
        this.zzbgu = str;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzbgu, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
