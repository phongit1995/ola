package com.google.android.gms.internal.ads;

import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzaaq extends zzek implements zzaap {
    public zzaaq() {
        super("com.google.android.gms.ads.internal.overlay.client.IAdOverlay");
    }

    public static zzaap zzu(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.ads.internal.overlay.client.IAdOverlay");
        return iInterfaceQueryLocalInterface instanceof zzaap ? (zzaap) iInterfaceQueryLocalInterface : new zzaar(iBinder);
    }

    @Override // com.google.android.gms.internal.ads.zzek
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) {
        switch (i) {
            case 1:
                onCreate((Bundle) zzel.zza(parcel, Bundle.CREATOR));
                break;
            case 2:
                onRestart();
                break;
            case 3:
                onStart();
                break;
            case 4:
                onResume();
                break;
            case 5:
                onPause();
                break;
            case 6:
                Bundle bundle = (Bundle) zzel.zza(parcel, Bundle.CREATOR);
                onSaveInstanceState(bundle);
                parcel2.writeNoException();
                zzel.zzb(parcel2, bundle);
                return true;
            case 7:
                onStop();
                break;
            case 8:
                onDestroy();
                break;
            case 9:
                zzax();
                break;
            case 10:
                onBackPressed();
                break;
            case 11:
                boolean zZznj = zznj();
                parcel2.writeNoException();
                zzel.zza(parcel2, zZznj);
                return true;
            case 12:
                onActivityResult(parcel.readInt(), parcel.readInt(), (Intent) zzel.zza(parcel, Intent.CREATOR));
                break;
            case 13:
                zzo(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}
