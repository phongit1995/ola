package com.google.android.gms.flags;

import android.content.Context;
import android.os.RemoteException;
import android.util.Log;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.dynamite.DynamiteModule;
import com.google.android.gms.dynamite.descriptors.com.google.android.gms.flags.ModuleDescriptor;
import com.google.android.gms.flags.IFlagProvider;

/* JADX INFO: loaded from: classes.dex */
public class FlagValueProvider {
    private boolean zzacf = false;
    private IFlagProvider zzacg = null;

    public <T> T getFlagValue(Flag<T> flag) {
        synchronized (this) {
            if (this.zzacf) {
                return flag.get(this.zzacg);
            }
            return flag.getDefault();
        }
    }

    public void initialize(Context context) {
        synchronized (this) {
            if (this.zzacf) {
                return;
            }
            try {
                this.zzacg = IFlagProvider.Stub.asInterface(DynamiteModule.load(context, DynamiteModule.PREFER_HIGHEST_OR_REMOTE_VERSION_NO_FORCE_STAGING, ModuleDescriptor.MODULE_ID).instantiate("com.google.android.gms.flags.impl.FlagProviderImpl"));
                this.zzacg.init(ObjectWrapper.wrap(context));
                this.zzacf = true;
            } catch (RemoteException | DynamiteModule.LoadingException e) {
                Log.w("FlagValueProvider", "Failed to initialize flags module.", e);
            }
        }
    }
}
