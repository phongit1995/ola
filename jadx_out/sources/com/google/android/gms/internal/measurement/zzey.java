package com.google.android.gms.internal.measurement;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes2.dex */
public final class zzey implements Parcelable.Creator<zzex> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzex createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        zzeu zzeuVar = null;
        String strCreateString2 = null;
        long j = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    zzeuVar = (zzeu) SafeParcelReader.createParcelable(parcel, header, zzeu.CREATOR);
                    break;
                case 4:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 5:
                    j = SafeParcelReader.readLong(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzex(strCreateString, zzeuVar, strCreateString2, j);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzex[] newArray(int i) {
        return new zzex[i];
    }
}
