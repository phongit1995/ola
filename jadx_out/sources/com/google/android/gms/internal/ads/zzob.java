package com.google.android.gms.internal.ads;

import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzob extends zzek implements zzoa {
    public zzob() {
        super("com.google.android.gms.ads.internal.customrenderedad.client.ICustomRenderedAd");
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        String strZzjn;
        switch (i) {
            case 1:
                strZzjn = zzjn();
                parcel2.writeNoException();
                parcel2.writeString(strZzjn);
                return true;
            case 2:
                strZzjn = getContent();
                parcel2.writeNoException();
                parcel2.writeString(strZzjn);
                return true;
            case 3:
                zzg(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                return true;
            case 4:
                recordClick();
                parcel2.writeNoException();
                return true;
            case 5:
                recordImpression();
                parcel2.writeNoException();
                return true;
            default:
                return false;
        }
    }
}
