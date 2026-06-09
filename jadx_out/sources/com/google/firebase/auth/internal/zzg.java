package com.google.firebase.auth.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes2.dex */
public final class zzg implements Parcelable.Creator<zzf> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzf createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        zzl zzlVar = null;
        zzd zzdVar = null;
        com.google.firebase.auth.zzd zzdVar2 = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    zzlVar = (zzl) SafeParcelReader.createParcelable(parcel, header, zzl.CREATOR);
                    break;
                case 2:
                    zzdVar = (zzd) SafeParcelReader.createParcelable(parcel, header, zzd.CREATOR);
                    break;
                case 3:
                    zzdVar2 = (com.google.firebase.auth.zzd) SafeParcelReader.createParcelable(parcel, header, com.google.firebase.auth.zzd.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzf(zzlVar, zzdVar, zzdVar2);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzf[] newArray(int i) {
        return new zzf[i];
    }
}
