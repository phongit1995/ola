package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes2.dex */
public final class zzak implements Parcelable.Creator<zzaj> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzaj createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        long j = 0;
        long j2 = 0;
        String strCreateString = null;
        String strCreateString2 = null;
        String strCreateString3 = null;
        String strCreateString4 = null;
        zzas zzasVar = null;
        String strCreateString5 = null;
        String strCreateString6 = null;
        com.google.firebase.auth.zzd zzdVar = null;
        boolean z = false;
        boolean z2 = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 4:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 5:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 6:
                    strCreateString4 = SafeParcelReader.createString(parcel, header);
                    break;
                case 7:
                    zzasVar = (zzas) SafeParcelReader.createParcelable(parcel, header, zzas.CREATOR);
                    break;
                case 8:
                    strCreateString5 = SafeParcelReader.createString(parcel, header);
                    break;
                case 9:
                    strCreateString6 = SafeParcelReader.createString(parcel, header);
                    break;
                case 10:
                    j = SafeParcelReader.readLong(parcel, header);
                    break;
                case 11:
                    j2 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 12:
                    z2 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 13:
                    zzdVar = (com.google.firebase.auth.zzd) SafeParcelReader.createParcelable(parcel, header, com.google.firebase.auth.zzd.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzaj(strCreateString, strCreateString2, z, strCreateString3, strCreateString4, zzasVar, strCreateString5, strCreateString6, j, j2, z2, zzdVar);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzaj[] newArray(int i) {
        return new zzaj[i];
    }
}
