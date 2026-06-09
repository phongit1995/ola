package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzbn;
import com.google.android.gms.internal.firebase_auth.zzbo;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzbo<MessageType extends zzbn<MessageType, BuilderType>, BuilderType extends zzbo<MessageType, BuilderType>> implements zzei {
    protected abstract BuilderType zza(MessageType messagetype);

    @Override // com.google.android.gms.internal.firebase_auth.zzei
    public final /* synthetic */ zzei zza(zzeh zzehVar) {
        if (zzeb().getClass().isInstance(zzehVar)) {
            return zza((zzbn) zzehVar);
        }
        throw new IllegalArgumentException("mergeFrom(MessageLite) can only merge messages of the same type.");
    }

    @Override // 
    /* JADX INFO: renamed from: zzbq, reason: merged with bridge method [inline-methods] */
    public abstract BuilderType clone();
}
