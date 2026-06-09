package com.google.android.gms.dynamic;

import android.os.Bundle;
import com.google.android.gms.dynamic.DeferredLifecycleHelper;
import java.util.Iterator;

/* JADX INFO: Add missing generic type declarations: [T] */
/* JADX INFO: loaded from: classes.dex */
final class zza<T> implements OnDelegateCreatedListener<T> {
    private final /* synthetic */ DeferredLifecycleHelper zzabg;

    zza(DeferredLifecycleHelper deferredLifecycleHelper) {
        this.zzabg = deferredLifecycleHelper;
    }

    /* JADX WARN: Incorrect types in method signature: (TT;)V */
    @Override // com.google.android.gms.dynamic.OnDelegateCreatedListener
    public final void onDelegateCreated(LifecycleDelegate lifecycleDelegate) {
        this.zzabg.zzabc = lifecycleDelegate;
        Iterator it2 = this.zzabg.zzabe.iterator();
        while (it2.hasNext()) {
            ((DeferredLifecycleHelper.zza) it2.next()).zza(this.zzabg.zzabc);
        }
        this.zzabg.zzabe.clear();
        DeferredLifecycleHelper.zza(this.zzabg, (Bundle) null);
    }
}
