package com.google.android.gms.internal.measurement;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "ConditionalUserPropertyParcelCreator")
public final class zzef extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzef> CREATOR = new zzeg();

    @SafeParcelable.Field(id = 6)
    public boolean active;

    @SafeParcelable.Field(id = 5)
    public long creationTimestamp;

    @SafeParcelable.Field(id = 3)
    public String origin;

    @SafeParcelable.Field(id = 2)
    public String packageName;

    @SafeParcelable.Field(id = 11)
    public long timeToLive;

    @SafeParcelable.Field(id = 7)
    public String triggerEventName;

    @SafeParcelable.Field(id = 9)
    public long triggerTimeout;

    @SafeParcelable.Field(id = 4)
    public zzka zzage;

    @SafeParcelable.Field(id = 8)
    public zzex zzagf;

    @SafeParcelable.Field(id = 10)
    public zzex zzagg;

    @SafeParcelable.Field(id = 12)
    public zzex zzagh;

    zzef(zzef zzefVar) {
        Preconditions.checkNotNull(zzefVar);
        this.packageName = zzefVar.packageName;
        this.origin = zzefVar.origin;
        this.zzage = zzefVar.zzage;
        this.creationTimestamp = zzefVar.creationTimestamp;
        this.active = zzefVar.active;
        this.triggerEventName = zzefVar.triggerEventName;
        this.zzagf = zzefVar.zzagf;
        this.triggerTimeout = zzefVar.triggerTimeout;
        this.zzagg = zzefVar.zzagg;
        this.timeToLive = zzefVar.timeToLive;
        this.zzagh = zzefVar.zzagh;
    }

    @SafeParcelable.Constructor
    zzef(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) zzka zzkaVar, @SafeParcelable.Param(id = 5) long j, @SafeParcelable.Param(id = 6) boolean z, @SafeParcelable.Param(id = 7) String str3, @SafeParcelable.Param(id = 8) zzex zzexVar, @SafeParcelable.Param(id = 9) long j2, @SafeParcelable.Param(id = 10) zzex zzexVar2, @SafeParcelable.Param(id = 11) long j3, @SafeParcelable.Param(id = 12) zzex zzexVar3) {
        this.packageName = str;
        this.origin = str2;
        this.zzage = zzkaVar;
        this.creationTimestamp = j;
        this.active = z;
        this.triggerEventName = str3;
        this.zzagf = zzexVar;
        this.triggerTimeout = j2;
        this.zzagg = zzexVar2;
        this.timeToLive = j3;
        this.zzagh = zzexVar3;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.packageName, false);
        SafeParcelWriter.writeString(parcel, 3, this.origin, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzage, i, false);
        SafeParcelWriter.writeLong(parcel, 5, this.creationTimestamp);
        SafeParcelWriter.writeBoolean(parcel, 6, this.active);
        SafeParcelWriter.writeString(parcel, 7, this.triggerEventName, false);
        SafeParcelWriter.writeParcelable(parcel, 8, this.zzagf, i, false);
        SafeParcelWriter.writeLong(parcel, 9, this.triggerTimeout);
        SafeParcelWriter.writeParcelable(parcel, 10, this.zzagg, i, false);
        SafeParcelWriter.writeLong(parcel, 11, this.timeToLive);
        SafeParcelWriter.writeParcelable(parcel, 12, this.zzagh, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
