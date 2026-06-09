package com.google.android.gms.internal.ads;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzsh implements Parcelable.Creator<zzsg> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzsg createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        String[] strArrCreateStringArray = null;
        String[] strArrCreateStringArray2 = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 2:
                    strArrCreateStringArray = SafeParcelReader.createStringArray(parcel, header);
                    break;
                case 3:
                    strArrCreateStringArray2 = SafeParcelReader.createStringArray(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzsg(strCreateString, strArrCreateStringArray, strArrCreateStringArray2);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzsg[] newArray(int i) {
        return new zzsg[i];
    }
}
