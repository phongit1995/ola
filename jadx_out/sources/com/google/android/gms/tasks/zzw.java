package com.google.android.gms.tasks;

import android.support.annotation.NonNull;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: Add missing generic type declarations: [TResult] */
/* JADX INFO: loaded from: classes2.dex */
final class zzw<TResult> implements Continuation<Void, List<TResult>> {
    private final /* synthetic */ Collection zzagk;

    zzw(Collection collection) {
        this.zzagk = collection;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ Object then(@NonNull Task<Void> task) {
        if (this.zzagk.size() == 0) {
            return Collections.emptyList();
        }
        ArrayList arrayList = new ArrayList();
        Iterator it2 = this.zzagk.iterator();
        while (it2.hasNext()) {
            arrayList.add(((Task) it2.next()).getResult());
        }
        return arrayList;
    }
}
