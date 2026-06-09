package com.google.android.gms.internal.measurement;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "EventParcelCreator")
@SafeParcelable.Reserved({1})
public final class zzex extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzex> CREATOR = new zzey();

    @SafeParcelable.Field(id = 2)
    public final String name;

    @SafeParcelable.Field(id = 4)
    public final String origin;

    @SafeParcelable.Field(id = 3)
    public final zzeu zzahg;

    @SafeParcelable.Field(id = 5)
    public final long zzahr;

    zzex(zzex zzexVar, long j) {
        Preconditions.checkNotNull(zzexVar);
        this.name = zzexVar.name;
        this.zzahg = zzexVar.zzahg;
        this.origin = zzexVar.origin;
        this.zzahr = j;
    }

    @SafeParcelable.Constructor
    public zzex(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) zzeu zzeuVar, @SafeParcelable.Param(id = 4) String str2, @SafeParcelable.Param(id = 5) long j) {
        this.name = str;
        this.zzahg = zzeuVar;
        this.origin = str2;
        this.zzahr = j;
    }

    public final String toString() {
        String str = this.origin;
        String str2 = this.name;
        String strValueOf = String.valueOf(this.zzahg);
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 21 + String.valueOf(str2).length() + String.valueOf(strValueOf).length());
        sb.append("origin=");
        sb.append(str);
        sb.append(",name=");
        sb.append(str2);
        sb.append(",params=");
        sb.append(strValueOf);
        return sb.toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.name, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzahg, i, false);
        SafeParcelWriter.writeString(parcel, 4, this.origin, false);
        SafeParcelWriter.writeLong(parcel, 5, this.zzahr);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
