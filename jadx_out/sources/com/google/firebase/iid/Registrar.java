package com.google.firebase.iid;

import android.support.annotation.Keep;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.firebase.FirebaseApp;
import com.google.firebase.components.Component;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.components.Dependency;
import com.google.firebase.iid.internal.FirebaseInstanceIdInternal;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@Keep
@KeepForSdk
public final class Registrar implements ComponentRegistrar {

    /* JADX INFO: Access modifiers changed from: private */
    static class zza implements FirebaseInstanceIdInternal {
        private final FirebaseInstanceId zzcg;

        public zza(FirebaseInstanceId firebaseInstanceId) {
            this.zzcg = firebaseInstanceId;
        }

        @Override // com.google.firebase.iid.internal.FirebaseInstanceIdInternal
        public final String getId() {
            return this.zzcg.getId();
        }

        @Override // com.google.firebase.iid.internal.FirebaseInstanceIdInternal
        public final String getToken() {
            return this.zzcg.getToken();
        }
    }

    @Override // com.google.firebase.components.ComponentRegistrar
    @Keep
    public final List<Component<?>> getComponents() {
        return Arrays.asList(Component.builder(FirebaseInstanceId.class).add(Dependency.required(FirebaseApp.class)).factory(zzai.zzcf).alwaysEager().build(), Component.builder(FirebaseInstanceIdInternal.class).add(Dependency.required(FirebaseInstanceId.class)).factory(zzaj.zzcf).build());
    }
}
