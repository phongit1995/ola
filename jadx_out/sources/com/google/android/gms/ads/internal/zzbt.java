package com.google.android.gms.ads.internal;

import android.os.AsyncTask;
import com.google.android.gms.internal.ads.zzane;
import com.google.android.gms.internal.ads.zzci;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zznk;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/* JADX INFO: loaded from: classes.dex */
final class zzbt extends AsyncTask<Void, Void, String> {
    private final /* synthetic */ zzbp zzaba;

    private zzbt(zzbp zzbpVar) {
        this.zzaba = zzbpVar;
    }

    /* synthetic */ zzbt(zzbp zzbpVar, zzbq zzbqVar) {
        this(zzbpVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: zza, reason: merged with bridge method [inline-methods] */
    public final String doInBackground(Void... voidArr) {
        try {
            this.zzaba.zzaay = (zzci) this.zzaba.zzaav.get(((Long) zzkb.zzik().zzd(zznk.zzbdb)).longValue(), TimeUnit.MILLISECONDS);
        } catch (InterruptedException | ExecutionException | TimeoutException e) {
            zzane.zzc("", e);
        }
        return this.zzaba.zzea();
    }

    @Override // android.os.AsyncTask
    protected final /* synthetic */ void onPostExecute(String str) {
        String str2 = str;
        if (this.zzaba.zzaax == null || str2 == null) {
            return;
        }
        this.zzaba.zzaax.loadUrl(str2);
    }
}
