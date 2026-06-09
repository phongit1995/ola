package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "SendVerificationCodeRequestCreator")
public final class zzax extends AbstractSafeParcelable implements com.google.firebase.auth.api.internal.zzdp<zzn> {
    public static final Parcelable.Creator<zzax> CREATOR = new zzay();

    @SafeParcelable.Field(getter = "getPhoneNumber", id = 1)
    private final String zzbd;

    @SafeParcelable.Field(getter = "getTimeoutInSeconds", id = 2)
    private final long zzkb;

    @SafeParcelable.Field(getter = "getForceNewSmsVerificationSession", id = 3)
    private final boolean zzkc;

    @SafeParcelable.Field(getter = "getLanguageHeader", id = 4)
    private final String zzkd;

    @SafeParcelable.Constructor
    public zzax(@SafeParcelable.Param(id = 1) String str, @SafeParcelable.Param(id = 2) long j, @SafeParcelable.Param(id = 3) boolean z, @SafeParcelable.Param(id = 4) String str2) {
        this.zzbd = str;
        this.zzkb = j;
        this.zzkc = z;
        this.zzkd = str2;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzbd, false);
        SafeParcelWriter.writeLong(parcel, 2, this.zzkb);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzkc);
        SafeParcelWriter.writeString(parcel, 4, this.zzkd, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.firebase.auth.api.internal.zzdp
    public final /* synthetic */ zzgt zzao() {
        zzn zznVar = new zzn();
        zznVar.zzbd = this.zzbd;
        return zznVar;
    }
}
