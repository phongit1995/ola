package com.google.android.gms.internal.measurement;

import android.content.SharedPreferences;
import android.os.Build;
import android.support.annotation.NonNull;
import android.support.annotation.WorkerThread;
import android.text.TextUtils;
import android.util.Pair;
import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.common.util.VisibleForTesting;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.Locale;

/* JADX INFO: loaded from: classes2.dex */
final class zzft extends zzhj {

    @VisibleForTesting
    static final Pair<String, Long> zzalr = new Pair<>("", 0L);
    private SharedPreferences zzabe;
    public zzfx zzals;
    public final zzfw zzalt;
    public final zzfw zzalu;
    public final zzfw zzalv;
    public final zzfw zzalw;
    public final zzfw zzalx;
    public final zzfw zzaly;
    public final zzfw zzalz;
    public final zzfy zzama;
    private String zzamb;
    private boolean zzamc;
    private long zzamd;
    private String zzame;
    private long zzamf;
    private final Object zzamg;
    public final zzfw zzamh;
    public final zzfw zzami;
    public final zzfv zzamj;
    public final zzfw zzamk;
    public final zzfw zzaml;
    public boolean zzamm;

    zzft(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzalt = new zzfw(this, "last_upload", 0L);
        this.zzalu = new zzfw(this, "last_upload_attempt", 0L);
        this.zzalv = new zzfw(this, "backoff", 0L);
        this.zzalw = new zzfw(this, "last_delete_stale", 0L);
        this.zzamh = new zzfw(this, "time_before_start", 10000L);
        this.zzami = new zzfw(this, "session_timeout", 1800000L);
        this.zzamj = new zzfv(this, "start_new_session", true);
        this.zzamk = new zzfw(this, "last_pause_time", 0L);
        this.zzaml = new zzfw(this, "time_active", 0L);
        this.zzalx = new zzfw(this, "midnight_offset", 0L);
        this.zzaly = new zzfw(this, "first_open_time", 0L);
        this.zzalz = new zzfw(this, "app_install_time", 0L);
        this.zzama = new zzfy(this, "app_instance_id", null);
        this.zzamg = new Object();
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final SharedPreferences zzji() {
        zzab();
        zzch();
        return this.zzabe;
    }

    @WorkerThread
    final void setMeasurementEnabled(boolean z) {
        zzab();
        zzgi().zzjc().zzg("Setting measurementEnabled", Boolean.valueOf(z));
        SharedPreferences.Editor editorEdit = zzji().edit();
        editorEdit.putBoolean("measurement_enabled", z);
        editorEdit.apply();
    }

    @WorkerThread
    @NonNull
    final Pair<String, Boolean> zzbr(String str) {
        zzab();
        long jElapsedRealtime = zzbt().elapsedRealtime();
        if (this.zzamb != null && jElapsedRealtime < this.zzamd) {
            return new Pair<>(this.zzamb, Boolean.valueOf(this.zzamc));
        }
        this.zzamd = jElapsedRealtime + zzgk().zza(str, zzez.zzaif);
        AdvertisingIdClient.setShouldSkipGmsCoreVersionCheck(true);
        try {
            AdvertisingIdClient.Info advertisingIdInfo = AdvertisingIdClient.getAdvertisingIdInfo(getContext());
            if (advertisingIdInfo != null) {
                this.zzamb = advertisingIdInfo.getId();
                this.zzamc = advertisingIdInfo.isLimitAdTrackingEnabled();
            }
            if (this.zzamb == null) {
                this.zzamb = "";
            }
        } catch (Exception e) {
            zzgi().zzjb().zzg("Unable to get advertising id", e);
            this.zzamb = "";
        }
        AdvertisingIdClient.setShouldSkipGmsCoreVersionCheck(false);
        return new Pair<>(this.zzamb, Boolean.valueOf(this.zzamc));
    }

    @WorkerThread
    final String zzbs(String str) {
        zzab();
        String str2 = (String) zzbr(str).first;
        MessageDigest messageDigest = zzkd.getMessageDigest();
        if (messageDigest == null) {
            return null;
        }
        return String.format(Locale.US, "%032X", new BigInteger(1, messageDigest.digest(str2.getBytes())));
    }

    @WorkerThread
    final void zzbt(String str) {
        zzab();
        SharedPreferences.Editor editorEdit = zzji().edit();
        editorEdit.putString("gmp_app_id", str);
        editorEdit.apply();
    }

    final void zzbu(String str) {
        synchronized (this.zzamg) {
            this.zzame = str;
            this.zzamf = zzbt().elapsedRealtime();
        }
    }

    @WorkerThread
    final void zzf(boolean z) {
        zzab();
        zzgi().zzjc().zzg("Setting useService", Boolean.valueOf(z));
        SharedPreferences.Editor editorEdit = zzji().edit();
        editorEdit.putBoolean("use_service", z);
        editorEdit.apply();
    }

    @WorkerThread
    final boolean zzg(boolean z) {
        zzab();
        return zzji().getBoolean("measurement_enabled", z);
    }

    @Override // com.google.android.gms.internal.measurement.zzhj
    protected final boolean zzgn() {
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzhj
    @WorkerThread
    protected final void zzgo() {
        this.zzabe = getContext().getSharedPreferences("com.google.android.gms.measurement.prefs", 0);
        this.zzamm = this.zzabe.getBoolean("has_been_opened", false);
        if (!this.zzamm) {
            SharedPreferences.Editor editorEdit = this.zzabe.edit();
            editorEdit.putBoolean("has_been_opened", true);
            editorEdit.apply();
        }
        this.zzals = new zzfx(this, "health_monitor", Math.max(0L, zzez.zzaig.get().longValue()));
    }

    @WorkerThread
    final void zzh(boolean z) {
        zzab();
        zzgi().zzjc().zzg("Updating deferred analytics collection", Boolean.valueOf(z));
        SharedPreferences.Editor editorEdit = zzji().edit();
        editorEdit.putBoolean("deferred_analytics_collection", z);
        editorEdit.apply();
    }

    @WorkerThread
    final String zzjj() {
        zzab();
        return zzji().getString("gmp_app_id", null);
    }

    final String zzjk() {
        synchronized (this.zzamg) {
            if (Math.abs(zzbt().elapsedRealtime() - this.zzamf) >= 1000) {
                return null;
            }
            return this.zzame;
        }
    }

    @WorkerThread
    final Boolean zzjl() {
        zzab();
        if (zzji().contains("use_service")) {
            return Boolean.valueOf(zzji().getBoolean("use_service", false));
        }
        return null;
    }

    @WorkerThread
    final void zzjm() {
        zzab();
        zzgi().zzjc().log("Clearing collection preferences.");
        boolean zContains = zzji().contains("measurement_enabled");
        boolean zZzg = zContains ? zzg(true) : true;
        SharedPreferences.Editor editorEdit = zzji().edit();
        editorEdit.clear();
        editorEdit.apply();
        if (zContains) {
            setMeasurementEnabled(zZzg);
        }
    }

    @WorkerThread
    protected final String zzjn() {
        zzab();
        String string = zzji().getString("previous_os_version", null);
        zzge().zzch();
        String str = Build.VERSION.RELEASE;
        if (!TextUtils.isEmpty(str) && !str.equals(string)) {
            SharedPreferences.Editor editorEdit = zzji().edit();
            editorEdit.putString("previous_os_version", str);
            editorEdit.apply();
        }
        return string;
    }

    @WorkerThread
    final boolean zzjo() {
        zzab();
        return zzji().getBoolean("deferred_analytics_collection", false);
    }

    @WorkerThread
    final boolean zzjp() {
        return this.zzabe.contains("deferred_analytics_collection");
    }
}
