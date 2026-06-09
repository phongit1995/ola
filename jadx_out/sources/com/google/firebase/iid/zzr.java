package com.google.firebase.iid;

import android.os.Bundle;
import android.support.annotation.NonNull;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;
import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
final class zzr implements Continuation<Bundle, String> {
    private final /* synthetic */ zzo zzbj;

    zzr(zzo zzoVar) {
        this.zzbj = zzoVar;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ String then(@NonNull Task<Bundle> task) {
        Bundle result = task.getResult(IOException.class);
        zzo zzoVar = this.zzbj;
        return zzo.zza(result);
    }
}
