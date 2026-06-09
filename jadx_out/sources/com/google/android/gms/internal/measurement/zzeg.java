package com.google.android.gms.internal.measurement;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes2.dex */
public final class zzeg implements Parcelable.Creator<zzef> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzef createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        long j = 0;
        long j2 = 0;
        long j3 = 0;
        String strCreateString = null;
        String strCreateString2 = null;
        zzka zzkaVar = null;
        String strCreateString3 = null;
        zzex zzexVar = null;
        zzex zzexVar2 = null;
        zzex zzexVar3 = null;
        boolean z = false;
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
                    zzkaVar = (zzka) SafeParcelReader.createParcelable(parcel, header, zzka.CREATOR);
                    break;
                case 5:
                    j = SafeParcelReader.readLong(parcel, header);
                    break;
                case 6:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 7:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 8:
                    zzexVar = (zzex) SafeParcelReader.createParcelable(parcel, header, zzex.CREATOR);
                    break;
                case 9:
                    j2 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 10:
                    zzexVar2 = (zzex) SafeParcelReader.createParcelable(parcel, header, zzex.CREATOR);
                    break;
                case 11:
                    j3 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 12:
                    zzexVar3 = (zzex) SafeParcelReader.createParcelable(parcel, header, zzex.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzef(strCreateString, strCreateString2, zzkaVar, j, z, strCreateString3, zzexVar, j2, zzexVar2, j3, zzexVar3);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzef[] newArray(int i) {
        return new zzef[i];
    }
}
