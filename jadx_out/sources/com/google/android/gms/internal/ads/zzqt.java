package com.google.android.gms.internal.ads;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzqt extends zzek implements zzqs {
    public zzqt() {
        super("com.google.android.gms.ads.internal.formats.client.INativeCustomTemplateAd");
    }

    public static zzqs zzk(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.ads.internal.formats.client.INativeCustomTemplateAd");
        return iInterfaceQueryLocalInterface instanceof zzqs ? (zzqs) iInterfaceQueryLocalInterface : new zzqu(iBinder);
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        String strZzao;
        IInterface iInterfaceZzap;
        switch (i) {
            case 1:
                strZzao = zzao(parcel.readString());
                parcel2.writeNoException();
                parcel2.writeString(strZzao);
                return true;
            case 2:
                iInterfaceZzap = zzap(parcel.readString());
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzap);
                return true;
            case 3:
                List<String> availableAssetNames = getAvailableAssetNames();
                parcel2.writeNoException();
                parcel2.writeStringList(availableAssetNames);
                return true;
            case 4:
                strZzao = getCustomTemplateId();
                parcel2.writeNoException();
                parcel2.writeString(strZzao);
                return true;
            case 5:
                performClick(parcel.readString());
                parcel2.writeNoException();
                return true;
            case 6:
                recordImpression();
                parcel2.writeNoException();
                return true;
            case 7:
                iInterfaceZzap = getVideoController();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzap);
                return true;
            case 8:
                destroy();
                parcel2.writeNoException();
                return true;
            case 9:
                iInterfaceZzap = zzkh();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzap);
                return true;
            case 10:
                boolean zZzh = zzh(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                parcel2.writeNoException();
                zzel.zza(parcel2, zZzh);
                return true;
            case 11:
                iInterfaceZzap = zzka();
                parcel2.writeNoException();
                zzel.zza(parcel2, iInterfaceZzap);
                return true;
            default:
                return false;
        }
    }
}
