package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes2.dex */
public final class zzb implements Parcelable.Creator<ActionCodeSettings> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ ActionCodeSettings createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        String strCreateString2 = null;
        String strCreateString3 = null;
        String strCreateString4 = null;
        String strCreateString5 = null;
        String strCreateString6 = null;
        boolean z = false;
        boolean z2 = false;
        int i = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 2:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 4:
                    strCreateString4 = SafeParcelReader.createString(parcel, header);
                    break;
                case 5:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 6:
                    strCreateString5 = SafeParcelReader.createString(parcel, header);
                    break;
                case 7:
                    z2 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 8:
                    strCreateString6 = SafeParcelReader.createString(parcel, header);
                    break;
                case 9:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new ActionCodeSettings(strCreateString, strCreateString2, strCreateString3, strCreateString4, z, strCreateString5, z2, strCreateString6, i);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ ActionCodeSettings[] newArray(int i) {
        return new ActionCodeSettings[i];
    }
}
