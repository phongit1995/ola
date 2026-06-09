package com.google.android.gms.internal.p000authapiphone;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import com.google.android.gms.auth.api.phone.SmsRetrieverClient;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public final class zzj extends SmsRetrieverClient {
    public zzj(@NonNull Activity activity) {
        super(activity);
    }

    public zzj(@NonNull Context context) {
        super(context);
    }

    @Override // com.google.android.gms.auth.api.phone.SmsRetrieverClient, com.google.android.gms.auth.api.phone.SmsRetrieverApi
    public final Task<Void> startSmsRetriever() {
        return doWrite(new zzk(this));
    }
}
