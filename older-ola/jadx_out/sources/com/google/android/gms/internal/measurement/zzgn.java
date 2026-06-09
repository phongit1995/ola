package com.google.android.gms.internal.measurement;

import android.app.Application;
import android.content.Context;
import android.support.annotation.WorkerThread;
import android.text.TextUtils;
import com.google.android.gms.common.api.internal.GoogleServices;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.DefaultClock;
import com.google.android.gms.common.wrappers.Wrappers;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
public class zzgn implements zzhk {
    private static volatile zzgn zzaoc;
    private final Clock clock;
    private final long zzaga;
    private final zzee zzahs;
    private final String zzaod;
    private final zzeh zzaoe;
    private final zzft zzaof;
    private final zzfi zzaog;
    private final zzgi zzaoh;
    private final zzjj zzaoi;
    private final AppMeasurement zzaoj;
    private final FirebaseAnalytics zzaok;
    private final zzkd zzaol;
    private final zzfg zzaom;
    private final zzih zzaon;
    private final zzhm zzaoo;
    private final zzdu zzaop;
    private zzfe zzaoq;
    private zzik zzaor;
    private zzer zzaos;
    private zzfd zzaot;
    private zzfz zzaou;
    private Boolean zzaov;
    private long zzaow;
    private int zzaox;
    private int zzaoy;
    private final Context zzqx;
    private boolean zzvn = false;

    private zzgn(zzhl zzhlVar) {
        zzfk zzfkVarZziy;
        String str;
        Preconditions.checkNotNull(zzhlVar);
        this.zzahs = new zzee(zzhlVar.zzqx);
        zzez.zza(this.zzahs);
        this.zzqx = zzhlVar.zzqx;
        this.zzaod = zzhlVar.zzaod;
        zzwx.init(this.zzqx);
        this.clock = DefaultClock.getInstance();
        this.zzaga = this.clock.currentTimeMillis();
        this.zzaoe = new zzeh(this);
        zzft zzftVar = new zzft(this);
        zzftVar.zzm();
        this.zzaof = zzftVar;
        zzfi zzfiVar = new zzfi(this);
        zzfiVar.zzm();
        this.zzaog = zzfiVar;
        zzkd zzkdVar = new zzkd(this);
        zzkdVar.zzm();
        this.zzaol = zzkdVar;
        zzfg zzfgVar = new zzfg(this);
        zzfgVar.zzm();
        this.zzaom = zzfgVar;
        this.zzaop = new zzdu(this);
        zzih zzihVar = new zzih(this);
        zzihVar.zzm();
        this.zzaon = zzihVar;
        zzhm zzhmVar = new zzhm(this);
        zzhmVar.zzm();
        this.zzaoo = zzhmVar;
        this.zzaoj = new AppMeasurement(this);
        this.zzaok = new FirebaseAnalytics(this);
        zzjj zzjjVar = new zzjj(this);
        zzjjVar.zzm();
        this.zzaoi = zzjjVar;
        zzgi zzgiVar = new zzgi(this);
        zzgiVar.zzm();
        this.zzaoh = zzgiVar;
        zzee zzeeVar = this.zzahs;
        if (this.zzqx.getApplicationContext() instanceof Application) {
            zzhm zzhmVarZzfy = zzfy();
            if (zzhmVarZzfy.getContext().getApplicationContext() instanceof Application) {
                Application application = (Application) zzhmVarZzfy.getContext().getApplicationContext();
                if (zzhmVarZzfy.zzapl == null) {
                    zzhmVarZzfy.zzapl = new zzif(zzhmVarZzfy, null);
                }
                application.unregisterActivityLifecycleCallbacks(zzhmVarZzfy.zzapl);
                application.registerActivityLifecycleCallbacks(zzhmVarZzfy.zzapl);
                zzfkVarZziy = zzhmVarZzfy.zzgi().zzjc();
                str = "Registered activity lifecycle callback";
            }
            this.zzaoh.zzc(new zzgo(this, zzhlVar));
        }
        zzfkVarZziy = zzgi().zziy();
        str = "Application context is not an Application";
        zzfkVarZziy.log(str);
        this.zzaoh.zzc(new zzgo(this, zzhlVar));
    }

    public static zzgn zza(Context context, String str, String str2) {
        Preconditions.checkNotNull(context);
        Preconditions.checkNotNull(context.getApplicationContext());
        if (zzaoc == null) {
            synchronized (zzgn.class) {
                if (zzaoc == null) {
                    zzaoc = new zzgn(new zzhl(context, null));
                }
            }
        }
        return zzaoc;
    }

    private static void zza(zzdz zzdzVar) {
        if (zzdzVar == null) {
            throw new IllegalStateException("Component not created");
        }
        if (zzdzVar.isInitialized()) {
            return;
        }
        String strValueOf = String.valueOf(zzdzVar.getClass());
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 27);
        sb.append("Component not initialized: ");
        sb.append(strValueOf);
        throw new IllegalStateException(sb.toString());
    }

    private static void zza(zzhi zzhiVar) {
        if (zzhiVar == null) {
            throw new IllegalStateException("Component not created");
        }
    }

    private static void zza(zzhj zzhjVar) {
        if (zzhjVar == null) {
            throw new IllegalStateException("Component not created");
        }
        if (zzhjVar.isInitialized()) {
            return;
        }
        String strValueOf = String.valueOf(zzhjVar.getClass());
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 27);
        sb.append("Component not initialized: ");
        sb.append(strValueOf);
        throw new IllegalStateException(sb.toString());
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zza(zzhl zzhlVar) {
        zzfk zzfkVarZzja;
        String strConcat;
        zzgh().zzab();
        zzeh.zzhn();
        zzer zzerVar = new zzer(this);
        zzerVar.zzm();
        this.zzaos = zzerVar;
        zzfd zzfdVar = new zzfd(this);
        zzfdVar.zzm();
        this.zzaot = zzfdVar;
        zzfe zzfeVar = new zzfe(this);
        zzfeVar.zzm();
        this.zzaoq = zzfeVar;
        zzik zzikVar = new zzik(this);
        zzikVar.zzm();
        this.zzaor = zzikVar;
        this.zzaol.zzgm();
        this.zzaof.zzgm();
        this.zzaou = new zzfz(this);
        this.zzaot.zzgm();
        zzgi().zzja().zzg("App measurement is starting up, version", Long.valueOf(this.zzaoe.zzgw()));
        zzee zzeeVar = this.zzahs;
        zzgi().zzja().log("To enable debug logging run: adb shell setprop log.tag.FA VERBOSE");
        zzee zzeeVar2 = this.zzahs;
        String strZzah = zzfdVar.zzah();
        if (zzgg().zzcn(strZzah)) {
            zzfkVarZzja = zzgi().zzja();
            strConcat = "Faster debug mode event logging enabled. To disable, run:\n  adb shell setprop debug.firebase.analytics.app .none.";
        } else {
            zzfkVarZzja = zzgi().zzja();
            String strValueOf = String.valueOf(strZzah);
            strConcat = strValueOf.length() != 0 ? "To enable faster debug mode event logging run:\n  adb shell setprop debug.firebase.analytics.app ".concat(strValueOf) : new String("To enable faster debug mode event logging run:\n  adb shell setprop debug.firebase.analytics.app ");
        }
        zzfkVarZzja.log(strConcat);
        zzgi().zzjb().log("Debug-level message logging enabled");
        if (this.zzaox != this.zzaoy) {
            zzgi().zziv().zze("Not all components initialized", Integer.valueOf(this.zzaox), Integer.valueOf(this.zzaoy));
        }
        this.zzvn = true;
    }

    private final void zzch() {
        if (!this.zzvn) {
            throw new IllegalStateException("AppMeasurement is not initialized");
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final Context getContext() {
        return this.zzqx;
    }

    @WorkerThread
    public final boolean isEnabled() {
        zzgh().zzab();
        zzch();
        boolean zBooleanValue = false;
        if (this.zzaoe.zzho()) {
            return false;
        }
        Boolean boolZzhp = this.zzaoe.zzhp();
        if (boolZzhp != null) {
            zBooleanValue = boolZzhp.booleanValue();
        } else if (!GoogleServices.isMeasurementExplicitlyDisabled()) {
            zBooleanValue = true;
        }
        return zzgj().zzg(zBooleanValue);
    }

    @WorkerThread
    protected final void start() {
        zzgh().zzab();
        if (zzgj().zzalt.get() == 0) {
            zzgj().zzalt.set(this.clock.currentTimeMillis());
        }
        if (Long.valueOf(zzgj().zzaly.get()).longValue() == 0) {
            zzgi().zzjc().zzg("Persisting first open", Long.valueOf(this.zzaga));
            zzgj().zzaly.set(this.zzaga);
        }
        if (!zzkg()) {
            if (isEnabled()) {
                if (!zzgg().zzx("android.permission.INTERNET")) {
                    zzgi().zziv().log("App is missing INTERNET permission");
                }
                if (!zzgg().zzx("android.permission.ACCESS_NETWORK_STATE")) {
                    zzgi().zziv().log("App is missing ACCESS_NETWORK_STATE permission");
                }
                zzee zzeeVar = this.zzahs;
                if (!Wrappers.packageManager(this.zzqx).isCallerInstantApp() && !this.zzaoe.zzhu()) {
                    if (!zzgd.zza(this.zzqx)) {
                        zzgi().zziv().log("AppMeasurementReceiver not registered/enabled");
                    }
                    if (!zzkd.zza(this.zzqx, false)) {
                        zzgi().zziv().log("AppMeasurementService not registered/enabled");
                    }
                }
                zzgi().zziv().log("Uploading is not possible. App measurement disabled");
                return;
            }
            return;
        }
        zzee zzeeVar2 = this.zzahs;
        if (!TextUtils.isEmpty(zzfz().getGmpAppId())) {
            String strZzjj = zzgj().zzjj();
            if (strZzjj == null) {
                zzgj().zzbt(zzfz().getGmpAppId());
            } else if (!strZzjj.equals(zzfz().getGmpAppId())) {
                zzgi().zzja().log("Rechecking which service to use due to a GMP App Id change");
                zzgj().zzjm();
                this.zzaor.disconnect();
                this.zzaor.zzdf();
                zzgj().zzbt(zzfz().getGmpAppId());
                zzgj().zzaly.set(this.zzaga);
                zzgj().zzama.zzbv(null);
            }
        }
        zzfy().zzbu(zzgj().zzama.zzjq());
        zzee zzeeVar3 = this.zzahs;
        if (TextUtils.isEmpty(zzfz().getGmpAppId())) {
            return;
        }
        boolean zIsEnabled = isEnabled();
        if (!zzgj().zzjp() && !this.zzaoe.zzho()) {
            zzgj().zzh(!zIsEnabled);
        }
        if (!this.zzaoe.zzbc(zzfz().zzah()) || zIsEnabled) {
            zzfy().zzkm();
        }
        zzga().zza(new AtomicReference<>());
    }

    final void zzb(zzdz zzdzVar) {
        this.zzaox++;
    }

    final void zzb(zzhj zzhjVar) {
        this.zzaox++;
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final Clock zzbt() {
        return this.clock;
    }

    final void zzfu() {
        zzee zzeeVar = this.zzahs;
        throw new IllegalStateException("Unexpected call on client side");
    }

    final void zzfv() {
        zzee zzeeVar = this.zzahs;
    }

    public final zzdu zzfx() {
        if (this.zzaop == null) {
            throw new IllegalStateException("Component not created");
        }
        return this.zzaop;
    }

    public final zzhm zzfy() {
        zza((zzdz) this.zzaoo);
        return this.zzaoo;
    }

    public final zzfd zzfz() {
        zza((zzdz) this.zzaot);
        return this.zzaot;
    }

    public final zzik zzga() {
        zza((zzdz) this.zzaor);
        return this.zzaor;
    }

    public final zzih zzgb() {
        zza((zzdz) this.zzaon);
        return this.zzaon;
    }

    public final zzfe zzgc() {
        zza((zzdz) this.zzaoq);
        return this.zzaoq;
    }

    public final zzjj zzgd() {
        zza((zzdz) this.zzaoi);
        return this.zzaoi;
    }

    public final zzer zzge() {
        zza((zzhj) this.zzaos);
        return this.zzaos;
    }

    public final zzfg zzgf() {
        zza((zzhi) this.zzaom);
        return this.zzaom;
    }

    public final zzkd zzgg() {
        zza((zzhi) this.zzaol);
        return this.zzaol;
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final zzgi zzgh() {
        zza((zzhj) this.zzaoh);
        return this.zzaoh;
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final zzfi zzgi() {
        zza((zzhj) this.zzaog);
        return this.zzaog;
    }

    public final zzft zzgj() {
        zza((zzhi) this.zzaof);
        return this.zzaof;
    }

    public final zzeh zzgk() {
        return this.zzaoe;
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final zzee zzgl() {
        return this.zzahs;
    }

    public final zzfi zzjy() {
        if (this.zzaog == null || !this.zzaog.isInitialized()) {
            return null;
        }
        return this.zzaog;
    }

    public final zzfz zzjz() {
        return this.zzaou;
    }

    final zzgi zzka() {
        return this.zzaoh;
    }

    public final AppMeasurement zzkb() {
        return this.zzaoj;
    }

    public final FirebaseAnalytics zzkc() {
        return this.zzaok;
    }

    public final String zzkd() {
        return this.zzaod;
    }

    final long zzke() {
        Long lValueOf = Long.valueOf(zzgj().zzaly.get());
        return lValueOf.longValue() == 0 ? this.zzaga : Math.min(this.zzaga, lValueOf.longValue());
    }

    final void zzkf() {
        this.zzaoy++;
    }

    @WorkerThread
    protected final boolean zzkg() {
        zzch();
        zzgh().zzab();
        if (this.zzaov == null || this.zzaow == 0 || (this.zzaov != null && !this.zzaov.booleanValue() && Math.abs(this.clock.elapsedRealtime() - this.zzaow) > 1000)) {
            this.zzaow = this.clock.elapsedRealtime();
            zzee zzeeVar = this.zzahs;
            boolean z = false;
            if (zzgg().zzx("android.permission.INTERNET") && zzgg().zzx("android.permission.ACCESS_NETWORK_STATE") && (Wrappers.packageManager(this.zzqx).isCallerInstantApp() || this.zzaoe.zzhu() || (zzgd.zza(this.zzqx) && zzkd.zza(this.zzqx, false)))) {
                z = true;
            }
            this.zzaov = Boolean.valueOf(z);
            if (this.zzaov.booleanValue()) {
                this.zzaov = Boolean.valueOf(zzgg().zzck(zzfz().getGmpAppId()));
            }
        }
        return this.zzaov.booleanValue();
    }
}
