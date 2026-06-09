package com.google.android.gms.internal.measurement;

import android.os.Binder;
import android.support.annotation.BinderThread;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.GooglePlayServicesUtilLight;
import com.google.android.gms.common.GoogleSignatureVerifier;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.UidVerifier;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ExecutionException;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgp extends zzfb {
    private final zzjt zzalo;
    private Boolean zzapb;

    @Nullable
    private String zzapc;

    public zzgp(zzjt zzjtVar) {
        this(zzjtVar, null);
    }

    private zzgp(zzjt zzjtVar, @Nullable String str) {
        Preconditions.checkNotNull(zzjtVar);
        this.zzalo = zzjtVar;
        this.zzapc = null;
    }

    @BinderThread
    private final void zzb(zzeb zzebVar, boolean z) {
        Preconditions.checkNotNull(zzebVar);
        zzc(zzebVar.packageName, false);
        this.zzalo.zzgg().zzck(zzebVar.zzafa);
    }

    @BinderThread
    private final void zzc(String str, boolean z) {
        if (TextUtils.isEmpty(str)) {
            this.zzalo.zzgi().zziv().log("Measurement Service called without app package");
            throw new SecurityException("Measurement Service called without app package");
        }
        if (z) {
            try {
                if (this.zzapb == null) {
                    this.zzapb = Boolean.valueOf("com.google.android.gms".equals(this.zzapc) || UidVerifier.isGooglePlayServicesUid(this.zzalo.getContext(), Binder.getCallingUid()) || GoogleSignatureVerifier.getInstance(this.zzalo.getContext()).isUidGoogleSigned(Binder.getCallingUid()));
                }
                if (this.zzapb.booleanValue()) {
                    return;
                }
            } catch (SecurityException e) {
                this.zzalo.zzgi().zziv().zzg("Measurement Service called with invalid calling package. appId", zzfi.zzbp(str));
                throw e;
            }
        }
        if (this.zzapc == null && GooglePlayServicesUtilLight.uidHasPackageName(this.zzalo.getContext(), Binder.getCallingUid(), str)) {
            this.zzapc = str;
        }
        if (str.equals(this.zzapc)) {
        } else {
            throw new SecurityException(String.format("Unknown calling package name '%s'.", str));
        }
    }

    @VisibleForTesting
    private final void zze(Runnable runnable) {
        Preconditions.checkNotNull(runnable);
        if (zzez.zzajw.get().booleanValue() && this.zzalo.zzgh().zzju()) {
            runnable.run();
        } else {
            this.zzalo.zzgh().zzc(runnable);
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final List<zzka> zza(zzeb zzebVar, boolean z) {
        zzb(zzebVar, false);
        try {
            List<zzkc> list = (List) this.zzalo.zzgh().zzb(new zzhf(this, zzebVar)).get();
            ArrayList arrayList = new ArrayList(list.size());
            for (zzkc zzkcVar : list) {
                if (z || !zzkd.zzcm(zzkcVar.name)) {
                    arrayList.add(new zzka(zzkcVar));
                }
            }
            return arrayList;
        } catch (InterruptedException | ExecutionException e) {
            this.zzalo.zzgi().zziv().zze("Failed to get user attributes. appId", zzfi.zzbp(zzebVar.packageName), e);
            return null;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final List<zzef> zza(String str, String str2, zzeb zzebVar) {
        zzb(zzebVar, false);
        try {
            return (List) this.zzalo.zzgh().zzb(new zzgx(this, zzebVar, str, str2)).get();
        } catch (InterruptedException | ExecutionException e) {
            this.zzalo.zzgi().zziv().zzg("Failed to get conditional user properties", e);
            return Collections.emptyList();
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final List<zzka> zza(String str, String str2, String str3, boolean z) {
        zzc(str, true);
        try {
            List<zzkc> list = (List) this.zzalo.zzgh().zzb(new zzgw(this, str, str2, str3)).get();
            ArrayList arrayList = new ArrayList(list.size());
            for (zzkc zzkcVar : list) {
                if (z || !zzkd.zzcm(zzkcVar.name)) {
                    arrayList.add(new zzka(zzkcVar));
                }
            }
            return arrayList;
        } catch (InterruptedException | ExecutionException e) {
            this.zzalo.zzgi().zziv().zze("Failed to get user attributes. appId", zzfi.zzbp(str), e);
            return Collections.emptyList();
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final List<zzka> zza(String str, String str2, boolean z, zzeb zzebVar) {
        zzb(zzebVar, false);
        try {
            List<zzkc> list = (List) this.zzalo.zzgh().zzb(new zzgv(this, zzebVar, str, str2)).get();
            ArrayList arrayList = new ArrayList(list.size());
            for (zzkc zzkcVar : list) {
                if (z || !zzkd.zzcm(zzkcVar.name)) {
                    arrayList.add(new zzka(zzkcVar));
                }
            }
            return arrayList;
        } catch (InterruptedException | ExecutionException e) {
            this.zzalo.zzgi().zziv().zze("Failed to get user attributes. appId", zzfi.zzbp(zzebVar.packageName), e);
            return Collections.emptyList();
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zza(long j, String str, String str2, String str3) {
        zze(new zzhh(this, str2, str3, str, j));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zza(zzeb zzebVar) {
        zzb(zzebVar, false);
        zze(new zzhg(this, zzebVar));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zza(zzef zzefVar, zzeb zzebVar) {
        Preconditions.checkNotNull(zzefVar);
        Preconditions.checkNotNull(zzefVar.zzage);
        zzb(zzebVar, false);
        zzef zzefVar2 = new zzef(zzefVar);
        zzefVar2.packageName = zzebVar.packageName;
        zze(zzefVar.zzage.getValue() == null ? new zzgr(this, zzefVar2, zzebVar) : new zzgs(this, zzefVar2, zzebVar));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zza(zzex zzexVar, zzeb zzebVar) {
        Preconditions.checkNotNull(zzexVar);
        zzb(zzebVar, false);
        zze(new zzha(this, zzexVar, zzebVar));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zza(zzex zzexVar, String str, String str2) {
        Preconditions.checkNotNull(zzexVar);
        Preconditions.checkNotEmpty(str);
        zzc(str, true);
        zze(new zzhb(this, zzexVar, str));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zza(zzka zzkaVar, zzeb zzebVar) {
        Preconditions.checkNotNull(zzkaVar);
        zzb(zzebVar, false);
        zze(zzkaVar.getValue() == null ? new zzhd(this, zzkaVar, zzebVar) : new zzhe(this, zzkaVar, zzebVar));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final byte[] zza(zzex zzexVar, String str) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzexVar);
        zzc(str, true);
        this.zzalo.zzgi().zzjb().zzg("Log and bundle. event", this.zzalo.zzgf().zzbm(zzexVar.name));
        long jNanoTime = this.zzalo.zzbt().nanoTime() / 1000000;
        try {
            byte[] bArr = (byte[]) this.zzalo.zzgh().zzc(new zzhc(this, zzexVar, str)).get();
            if (bArr == null) {
                this.zzalo.zzgi().zziv().zzg("Log and bundle returned null. appId", zzfi.zzbp(str));
                bArr = new byte[0];
            }
            this.zzalo.zzgi().zzjb().zzd("Log and bundle processed. event, size, time_ms", this.zzalo.zzgf().zzbm(zzexVar.name), Integer.valueOf(bArr.length), Long.valueOf((this.zzalo.zzbt().nanoTime() / 1000000) - jNanoTime));
            return bArr;
        } catch (InterruptedException | ExecutionException e) {
            this.zzalo.zzgi().zziv().zzd("Failed to log and bundle. appId, event, error", zzfi.zzbp(str), this.zzalo.zzgf().zzbm(zzexVar.name), e);
            return null;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zzb(zzeb zzebVar) {
        zzb(zzebVar, false);
        zze(new zzgq(this, zzebVar));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zzb(zzef zzefVar) {
        Preconditions.checkNotNull(zzefVar);
        Preconditions.checkNotNull(zzefVar.zzage);
        zzc(zzefVar.packageName, true);
        zzef zzefVar2 = new zzef(zzefVar);
        zze(zzefVar.zzage.getValue() == null ? new zzgt(this, zzefVar2) : new zzgu(this, zzefVar2));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final String zzc(zzeb zzebVar) {
        zzb(zzebVar, false);
        return this.zzalo.zzh(zzebVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final void zzd(zzeb zzebVar) {
        zzc(zzebVar.packageName, false);
        zze(new zzgz(this, zzebVar));
    }

    @Override // com.google.android.gms.internal.measurement.zzfa
    @BinderThread
    public final List<zzef> zze(String str, String str2, String str3) {
        zzc(str, true);
        try {
            return (List) this.zzalo.zzgh().zzb(new zzgy(this, str, str2, str3)).get();
        } catch (InterruptedException | ExecutionException e) {
            this.zzalo.zzgi().zziv().zzg("Failed to get conditional user properties", e);
            return Collections.emptyList();
        }
    }
}
