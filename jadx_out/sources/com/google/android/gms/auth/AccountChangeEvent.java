package com.google.android.gms.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AccountChangeEventCreator")
public class AccountChangeEvent extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AccountChangeEvent> CREATOR = new zzd();

    @SafeParcelable.VersionField(id = 1)
    private final int zzh;

    @SafeParcelable.Field(id = 2)
    private final long zzi;

    @SafeParcelable.Field(id = 3)
    private final String zzj;

    @SafeParcelable.Field(id = 4)
    private final int zzk;

    @SafeParcelable.Field(id = 5)
    private final int zzl;

    @SafeParcelable.Field(id = 6)
    private final String zzm;

    @SafeParcelable.Constructor
    AccountChangeEvent(@SafeParcelable.Param(id = 1) int i, @SafeParcelable.Param(id = 2) long j, @SafeParcelable.Param(id = 3) String str, @SafeParcelable.Param(id = 4) int i2, @SafeParcelable.Param(id = 5) int i3, @SafeParcelable.Param(id = 6) String str2) {
        this.zzh = i;
        this.zzi = j;
        this.zzj = (String) Preconditions.checkNotNull(str);
        this.zzk = i2;
        this.zzl = i3;
        this.zzm = str2;
    }

    public AccountChangeEvent(long j, String str, int i, int i2, String str2) {
        this.zzh = 1;
        this.zzi = j;
        this.zzj = (String) Preconditions.checkNotNull(str);
        this.zzk = i;
        this.zzl = i2;
        this.zzm = str2;
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof AccountChangeEvent) {
            AccountChangeEvent accountChangeEvent = (AccountChangeEvent) obj;
            if (this.zzh == accountChangeEvent.zzh && this.zzi == accountChangeEvent.zzi && Objects.equal(this.zzj, accountChangeEvent.zzj) && this.zzk == accountChangeEvent.zzk && this.zzl == accountChangeEvent.zzl && Objects.equal(this.zzm, accountChangeEvent.zzm)) {
                return true;
            }
        }
        return false;
    }

    public String getAccountName() {
        return this.zzj;
    }

    public String getChangeData() {
        return this.zzm;
    }

    public int getChangeType() {
        return this.zzk;
    }

    public int getEventIndex() {
        return this.zzl;
    }

    public int hashCode() {
        return Objects.hashCode(Integer.valueOf(this.zzh), Long.valueOf(this.zzi), this.zzj, Integer.valueOf(this.zzk), Integer.valueOf(this.zzl), this.zzm);
    }

    public String toString() {
        String str = "UNKNOWN";
        switch (this.zzk) {
            case 1:
                str = "ADDED";
                break;
            case 2:
                str = "REMOVED";
                break;
            case 3:
                str = "RENAMED_FROM";
                break;
            case 4:
                str = "RENAMED_TO";
                break;
        }
        String str2 = this.zzj;
        String str3 = this.zzm;
        int i = this.zzl;
        StringBuilder sb = new StringBuilder(String.valueOf(str2).length() + 91 + String.valueOf(str).length() + String.valueOf(str3).length());
        sb.append("AccountChangeEvent {accountName = ");
        sb.append(str2);
        sb.append(", changeType = ");
        sb.append(str);
        sb.append(", changeData = ");
        sb.append(str3);
        sb.append(", eventIndex = ");
        sb.append(i);
        sb.append("}");
        return sb.toString();
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzh);
        SafeParcelWriter.writeLong(parcel, 2, this.zzi);
        SafeParcelWriter.writeString(parcel, 3, this.zzj, false);
        SafeParcelWriter.writeInt(parcel, 4, this.zzk);
        SafeParcelWriter.writeInt(parcel, 5, this.zzl);
        SafeParcelWriter.writeString(parcel, 6, this.zzm, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
