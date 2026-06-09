package com.google.android.gms.auth.api.proxy;

import android.app.PendingIntent;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zze implements Parcelable.Creator<ProxyResponse> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ ProxyResponse createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        PendingIntent pendingIntent = null;
        Bundle bundleCreateBundle = null;
        byte[] bArrCreateByteArray = null;
        int i = 0;
        int i2 = 0;
        int i3 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId != 1000) {
                switch (fieldId) {
                    case 1:
                        i2 = SafeParcelReader.readInt(parcel, header);
                        break;
                    case 2:
                        pendingIntent = (PendingIntent) SafeParcelReader.createParcelable(parcel, header, PendingIntent.CREATOR);
                        break;
                    case 3:
                        i3 = SafeParcelReader.readInt(parcel, header);
                        break;
                    case 4:
                        bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                        break;
                    case 5:
                        bArrCreateByteArray = SafeParcelReader.createByteArray(parcel, header);
                        break;
                    default:
                        SafeParcelReader.skipUnknownField(parcel, header);
                        break;
                }
            } else {
                i = SafeParcelReader.readInt(parcel, header);
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new ProxyResponse(i, i2, pendingIntent, i3, bundleCreateBundle, bArrCreateByteArray);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ ProxyResponse[] newArray(int i) {
        return new ProxyResponse[i];
    }
}
