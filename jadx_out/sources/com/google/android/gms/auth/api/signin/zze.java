package com.google.android.gms.auth.api.signin;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zze implements Parcelable.Creator<SignInAccount> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SignInAccount createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = "";
        String strCreateString2 = "";
        GoogleSignInAccount googleSignInAccount = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId != 4) {
                switch (fieldId) {
                    case 7:
                        googleSignInAccount = (GoogleSignInAccount) SafeParcelReader.createParcelable(parcel, header, GoogleSignInAccount.CREATOR);
                        break;
                    case 8:
                        strCreateString2 = SafeParcelReader.createString(parcel, header);
                        break;
                    default:
                        SafeParcelReader.skipUnknownField(parcel, header);
                        break;
                }
            } else {
                strCreateString = SafeParcelReader.createString(parcel, header);
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new SignInAccount(strCreateString, googleSignInAccount, strCreateString2);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SignInAccount[] newArray(int i) {
        return new SignInAccount[i];
    }
}
