package com.google.android.gms.auth.api.credentials;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzm implements Parcelable.Creator<PasswordSpecification> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ PasswordSpecification createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        ArrayList<String> arrayListCreateStringList = null;
        ArrayList<Integer> arrayListCreateIntegerList = null;
        int i = 0;
        int i2 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 2:
                    arrayListCreateStringList = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 3:
                    arrayListCreateIntegerList = SafeParcelReader.createIntegerList(parcel, header);
                    break;
                case 4:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 5:
                    i2 = SafeParcelReader.readInt(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new PasswordSpecification(strCreateString, arrayListCreateStringList, arrayListCreateIntegerList, i, i2);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ PasswordSpecification[] newArray(int i) {
        return new PasswordSpecification[i];
    }
}
