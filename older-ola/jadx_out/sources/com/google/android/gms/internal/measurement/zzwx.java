package com.google.android.gms.internal.measurement;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Binder;
import android.os.Build;
import android.support.v4.content.PermissionChecker;
import android.util.Log;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzwx<T> {
    private static final Object zzbpg = new Object();
    private static boolean zzbph = false;
    private static volatile Boolean zzbpi;

    @SuppressLint({"StaticFieldLeak"})
    private static Context zzqx;
    private final zzxh zzbpj;
    final String zzbpk;
    private final String zzbpl;
    private final T zzbpm;
    private T zzbpn;
    private volatile zzwu zzbpo;
    private volatile SharedPreferences zzbpp;

    private zzwx(zzxh zzxhVar, String str, T t) {
        this.zzbpn = null;
        this.zzbpo = null;
        this.zzbpp = null;
        if (zzxhVar.zzbpv == null) {
            throw new IllegalArgumentException("Must pass a valid SharedPreferences file name or ContentProvider URI");
        }
        this.zzbpj = zzxhVar;
        String strValueOf = String.valueOf(zzxhVar.zzbpw);
        String strValueOf2 = String.valueOf(str);
        this.zzbpl = strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf);
        String strValueOf3 = String.valueOf(zzxhVar.zzbpx);
        String strValueOf4 = String.valueOf(str);
        this.zzbpk = strValueOf4.length() != 0 ? strValueOf3.concat(strValueOf4) : new String(strValueOf3);
        this.zzbpm = t;
    }

    /* synthetic */ zzwx(zzxh zzxhVar, String str, Object obj, zzxb zzxbVar) {
        this(zzxhVar, str, obj);
    }

    public static void init(Context context) {
        Context applicationContext;
        synchronized (zzbpg) {
            if ((Build.VERSION.SDK_INT < 24 || !context.isDeviceProtectedStorage()) && (applicationContext = context.getApplicationContext()) != null) {
                context = applicationContext;
            }
            if (zzqx != context) {
                zzbpi = null;
            }
            zzqx = context;
        }
        zzbph = false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static zzwx<Double> zza(zzxh zzxhVar, String str, double d) {
        return new zzxe(zzxhVar, str, Double.valueOf(d));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static zzwx<Integer> zza(zzxh zzxhVar, String str, int i) {
        return new zzxc(zzxhVar, str, Integer.valueOf(i));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static zzwx<Long> zza(zzxh zzxhVar, String str, long j) {
        return new zzxb(zzxhVar, str, Long.valueOf(j));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static zzwx<String> zza(zzxh zzxhVar, String str, String str2) {
        return new zzxf(zzxhVar, str, str2);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static zzwx<Boolean> zza(zzxh zzxhVar, String str, boolean z) {
        return new zzxd(zzxhVar, str, Boolean.valueOf(z));
    }

    private static <V> V zza(zzxg<V> zzxgVar) {
        try {
            return zzxgVar.zzsq();
        } catch (SecurityException unused) {
            long jClearCallingIdentity = Binder.clearCallingIdentity();
            try {
                return zzxgVar.zzsq();
            } finally {
                Binder.restoreCallingIdentity(jClearCallingIdentity);
            }
        }
    }

    static boolean zzd(final String str, boolean z) {
        final boolean z2 = false;
        try {
            if (zzso()) {
                return ((Boolean) zza(new zzxg(str, z2) { // from class: com.google.android.gms.internal.measurement.zzxa
                    private final String zzbps;
                    private final boolean zzbpt = false;

                    {
                        this.zzbps = str;
                    }

                    @Override // com.google.android.gms.internal.measurement.zzxg
                    public final Object zzsq() {
                        return Boolean.valueOf(zzws.zza(zzwx.zzqx.getContentResolver(), this.zzbps, this.zzbpt));
                    }
                })).booleanValue();
            }
            return false;
        } catch (SecurityException e) {
            Log.e("PhenotypeFlag", "Unable to read GServices, returning default value.", e);
            return false;
        }
    }

    @Nullable
    @TargetApi(24)
    private final T zzsm() {
        if (zzd("gms:phenotype:phenotype_flag:debug_bypass_phenotype", false)) {
            String strValueOf = String.valueOf(this.zzbpk);
            Log.w("PhenotypeFlag", strValueOf.length() != 0 ? "Bypass reading Phenotype values for flag: ".concat(strValueOf) : new String("Bypass reading Phenotype values for flag: "));
            return null;
        }
        if (this.zzbpj.zzbpv == null) {
            zzxh zzxhVar = this.zzbpj;
            return null;
        }
        if (this.zzbpo == null) {
            this.zzbpo = zzwu.zza(zzqx.getContentResolver(), this.zzbpj.zzbpv);
        }
        final zzwu zzwuVar = this.zzbpo;
        String str = (String) zza(new zzxg(this, zzwuVar) { // from class: com.google.android.gms.internal.measurement.zzwy
            private final zzwx zzbpq;
            private final zzwu zzbpr;

            {
                this.zzbpq = this;
                this.zzbpr = zzwuVar;
            }

            @Override // com.google.android.gms.internal.measurement.zzxg
            public final Object zzsq() {
                return this.zzbpr.zzsh().get(this.zzbpq.zzbpk);
            }
        });
        if (str != null) {
            return zzfa(str);
        }
        return null;
    }

    @Nullable
    private final T zzsn() {
        zzxh zzxhVar = this.zzbpj;
        if (!zzso()) {
            return null;
        }
        try {
            String str = (String) zza(new zzxg(this) { // from class: com.google.android.gms.internal.measurement.zzwz
                private final zzwx zzbpq;

                {
                    this.zzbpq = this;
                }

                @Override // com.google.android.gms.internal.measurement.zzxg
                public final Object zzsq() {
                    return this.zzbpq.zzsp();
                }
            });
            if (str != null) {
                return zzfa(str);
            }
            return null;
        } catch (SecurityException e) {
            String strValueOf = String.valueOf(this.zzbpk);
            Log.e("PhenotypeFlag", strValueOf.length() != 0 ? "Unable to read GServices for flag: ".concat(strValueOf) : new String("Unable to read GServices for flag: "), e);
            return null;
        }
    }

    private static boolean zzso() {
        if (zzbpi == null) {
            if (zzqx == null) {
                return false;
            }
            zzbpi = Boolean.valueOf(PermissionChecker.checkSelfPermission(zzqx, "com.google.android.providers.gsf.permission.READ_GSERVICES") == 0);
        }
        return zzbpi.booleanValue();
    }

    public final T get() {
        if (zzqx == null) {
            throw new IllegalStateException("Must call PhenotypeFlag.init() first");
        }
        zzxh zzxhVar = this.zzbpj;
        T tZzsm = zzsm();
        if (tZzsm != null) {
            return tZzsm;
        }
        T tZzsn = zzsn();
        return tZzsn != null ? tZzsn : this.zzbpm;
    }

    protected abstract T zzfa(String str);

    final /* synthetic */ String zzsp() {
        return zzws.zza(zzqx.getContentResolver(), this.zzbpl, (String) null);
    }
}
