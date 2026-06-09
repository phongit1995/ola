package com.google.android.gms.internal.ads;

import javax.annotation.Nullable;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class zzwt implements com.google.android.gms.ads.internal.gmsg.zzag {
    private final /* synthetic */ zzwq zzbro;
    private final zzvs zzbrp;
    private final zzaoj zzbrq;

    public zzwt(zzwq zzwqVar, zzvs zzvsVar, zzaoj zzaojVar) {
        this.zzbro = zzwqVar;
        this.zzbrp = zzvsVar;
        this.zzbrq = zzaojVar;
    }

    @Override // com.google.android.gms.ads.internal.gmsg.zzag
    public final void zzau(@Nullable String str) {
        try {
            if (str == null) {
                this.zzbrq.setException(new zzwe());
            } else {
                this.zzbrq.setException(new zzwe(str));
            }
        } catch (IllegalStateException unused) {
        } catch (Throwable th) {
            this.zzbrp.release();
            throw th;
        }
        this.zzbrp.release();
    }

    @Override // com.google.android.gms.ads.internal.gmsg.zzag
    public final void zzd(JSONObject jSONObject) {
        try {
            try {
                this.zzbrq.set(this.zzbro.zzbri.zze(jSONObject));
            } catch (IllegalStateException unused) {
            } catch (JSONException e) {
                this.zzbrq.set(e);
            }
        } finally {
            this.zzbrp.release();
        }
    }
}
