package com.google.android.gms.internal.ads;

import android.os.IBinder;
import android.os.IInterface;
import android.os.RemoteException;
import android.view.View;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.dynamic.RemoteCreator;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzrw extends RemoteCreator<zzqi> {
    @VisibleForTesting
    public zzrw() {
        super("com.google.android.gms.ads.NativeAdViewHolderDelegateCreatorImpl");
    }

    @Override // com.google.android.gms.dynamic.RemoteCreator
    protected final /* synthetic */ zzqi getRemoteCreator(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.ads.internal.formats.client.INativeAdViewHolderDelegateCreator");
        return iInterfaceQueryLocalInterface instanceof zzqi ? (zzqi) iInterfaceQueryLocalInterface : new zzqj(iBinder);
    }

    public final zzqf zzb(View view, HashMap<String, View> map, HashMap<String, View> map2) {
        try {
            IBinder iBinderZza = getRemoteCreatorInstance(view.getContext()).zza(ObjectWrapper.wrap(view), ObjectWrapper.wrap(map), ObjectWrapper.wrap(map2));
            if (iBinderZza == null) {
                return null;
            }
            IInterface iInterfaceQueryLocalInterface = iBinderZza.queryLocalInterface("com.google.android.gms.ads.internal.formats.client.INativeAdViewHolderDelegate");
            return iInterfaceQueryLocalInterface instanceof zzqf ? (zzqf) iInterfaceQueryLocalInterface : new zzqh(iBinderZza);
        } catch (RemoteException | RemoteCreator.RemoteCreatorException e) {
            zzane.zzc("Could not create remote NativeAdViewHolderDelegate.", e);
            return null;
        }
    }
}
