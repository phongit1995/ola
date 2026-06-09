package com.google.android.gms.internal.measurement;

import android.net.Uri;
import android.support.annotation.WorkerThread;
import android.support.v7.widget.helper.ItemTouchHelper;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
public final class zzez {
    static zzee zzahs;
    static List<zza<Integer>> zzaht = new ArrayList();
    static List<zza<Long>> zzahu = new ArrayList();
    static List<zza<Boolean>> zzahv = new ArrayList();
    static List<zza<String>> zzahw = new ArrayList();
    static List<zza<Double>> zzahx = new ArrayList();
    private static final zzxh zzahy;
    private static zza<Boolean> zzahz;
    private static zza<Boolean> zzaia;
    private static zza<Boolean> zzaib;
    public static zza<Boolean> zzaic;
    public static zza<Boolean> zzaid;
    public static zza<String> zzaie;
    public static zza<Long> zzaif;
    public static zza<Long> zzaig;
    public static zza<Long> zzaih;
    public static zza<String> zzaii;
    public static zza<String> zzaij;
    public static zza<Integer> zzaik;
    public static zza<Integer> zzail;
    public static zza<Integer> zzaim;
    public static zza<Integer> zzain;
    public static zza<Integer> zzaio;
    public static zza<Integer> zzaip;
    public static zza<Integer> zzaiq;
    public static zza<Integer> zzair;
    public static zza<Integer> zzais;
    public static zza<Integer> zzait;
    public static zza<String> zzaiu;
    public static zza<Long> zzaiv;
    public static zza<Long> zzaiw;
    public static zza<Long> zzaix;
    public static zza<Long> zzaiy;
    public static zza<Long> zzaiz;
    public static zza<Long> zzaja;
    public static zza<Long> zzajb;
    public static zza<Long> zzajc;
    public static zza<Long> zzajd;
    public static zza<Long> zzaje;
    public static zza<Long> zzajf;
    public static zza<Integer> zzajg;
    public static zza<Long> zzajh;
    public static zza<Integer> zzaji;
    public static zza<Integer> zzajj;
    public static zza<Long> zzajk;
    public static zza<Boolean> zzajl;
    public static zza<String> zzajm;
    public static zza<Long> zzajn;
    public static zza<Integer> zzajo;
    public static zza<Double> zzajp;
    public static zza<Boolean> zzajq;
    public static zza<Boolean> zzajr;
    public static zza<Boolean> zzajs;
    public static zza<Boolean> zzajt;
    public static zza<Boolean> zzaju;
    public static zza<Boolean> zzajv;
    public static zza<Boolean> zzajw;
    public static zza<Boolean> zzajx;
    public static zza<Boolean> zzajy;
    private static zza<Boolean> zzajz;

    @VisibleForTesting
    public static final class zza<V> {
        private final V zzaaa;
        private zzwx<V> zzaka;
        private final V zzakb;
        private volatile V zzakc;
        private final String zzny;

        private zza(String str, V v, V v2) {
            this.zzny = str;
            this.zzaaa = v;
            this.zzakb = v2;
        }

        static zza<Double> zza(String str, double d, double d2) {
            zza<Double> zzaVar = new zza<>(str, Double.valueOf(-3.0d), Double.valueOf(-3.0d));
            zzez.zzahx.add(zzaVar);
            return zzaVar;
        }

        static zza<Long> zzb(String str, long j, long j2) {
            zza<Long> zzaVar = new zza<>(str, Long.valueOf(j), Long.valueOf(j2));
            zzez.zzahu.add(zzaVar);
            return zzaVar;
        }

        static zza<Boolean> zzb(String str, boolean z, boolean z2) {
            zza<Boolean> zzaVar = new zza<>(str, Boolean.valueOf(z), Boolean.valueOf(z2));
            zzez.zzahv.add(zzaVar);
            return zzaVar;
        }

        static zza<Integer> zzc(String str, int i, int i2) {
            zza<Integer> zzaVar = new zza<>(str, Integer.valueOf(i), Integer.valueOf(i2));
            zzez.zzaht.add(zzaVar);
            return zzaVar;
        }

        static zza<String> zzd(String str, String str2, String str3) {
            zza<String> zzaVar = new zza<>(str, str2, str3);
            zzez.zzahw.add(zzaVar);
            return zzaVar;
        }

        @WorkerThread
        private static void zzip() {
            synchronized (zza.class) {
                if (zzee.isMainThread()) {
                    throw new IllegalStateException("Tried to refresh flag cache on main thread or on package side.");
                }
                zzee zzeeVar = zzez.zzahs;
                for (zza<Boolean> zzaVar : zzez.zzahv) {
                    ((zza) zzaVar).zzakc = (V) ((zza) zzaVar).zzaka.get();
                }
                for (zza<String> zzaVar2 : zzez.zzahw) {
                    ((zza) zzaVar2).zzakc = (V) ((zza) zzaVar2).zzaka.get();
                }
                for (zza<Long> zzaVar3 : zzez.zzahu) {
                    ((zza) zzaVar3).zzakc = (V) ((zza) zzaVar3).zzaka.get();
                }
                for (zza<Integer> zzaVar4 : zzez.zzaht) {
                    ((zza) zzaVar4).zzakc = (V) ((zza) zzaVar4).zzaka.get();
                }
                for (zza<Double> zzaVar5 : zzez.zzahx) {
                    ((zza) zzaVar5).zzakc = (V) ((zza) zzaVar5).zzaka.get();
                }
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public static void zzm() {
            synchronized (zza.class) {
                for (zza<Boolean> zzaVar : zzez.zzahv) {
                    zzxh zzxhVar = zzez.zzahy;
                    String str = ((zza) zzaVar).zzny;
                    zzee zzeeVar = zzez.zzahs;
                    ((zza) zzaVar).zzaka = (zzwx<V>) zzxhVar.zzf(str, ((zza) zzaVar).zzaaa.booleanValue());
                }
                for (zza<String> zzaVar2 : zzez.zzahw) {
                    zzxh zzxhVar2 = zzez.zzahy;
                    String str2 = ((zza) zzaVar2).zzny;
                    zzee zzeeVar2 = zzez.zzahs;
                    ((zza) zzaVar2).zzaka = (zzwx<V>) zzxhVar2.zzv(str2, ((zza) zzaVar2).zzaaa);
                }
                for (zza<Long> zzaVar3 : zzez.zzahu) {
                    zzxh zzxhVar3 = zzez.zzahy;
                    String str3 = ((zza) zzaVar3).zzny;
                    zzee zzeeVar3 = zzez.zzahs;
                    ((zza) zzaVar3).zzaka = (zzwx<V>) zzxhVar3.zze(str3, ((zza) zzaVar3).zzaaa.longValue());
                }
                for (zza<Integer> zzaVar4 : zzez.zzaht) {
                    zzxh zzxhVar4 = zzez.zzahy;
                    String str4 = ((zza) zzaVar4).zzny;
                    zzee zzeeVar4 = zzez.zzahs;
                    ((zza) zzaVar4).zzaka = (zzwx<V>) zzxhVar4.zzd(str4, ((zza) zzaVar4).zzaaa.intValue());
                }
                for (zza<Double> zzaVar5 : zzez.zzahx) {
                    zzxh zzxhVar5 = zzez.zzahy;
                    String str5 = ((zza) zzaVar5).zzny;
                    zzee zzeeVar5 = zzez.zzahs;
                    ((zza) zzaVar5).zzaka = (zzwx<V>) zzxhVar5.zzb(str5, ((zza) zzaVar5).zzaaa.doubleValue());
                }
            }
        }

        public final V get() {
            if (zzez.zzahs == null) {
                return this.zzaaa;
            }
            zzee zzeeVar = zzez.zzahs;
            if (zzee.isMainThread()) {
                return this.zzakc == null ? this.zzaaa : this.zzakc;
            }
            zzip();
            return this.zzaka.get();
        }

        public final V get(V v) {
            if (v != null) {
                return v;
            }
            if (zzez.zzahs == null) {
                return this.zzaaa;
            }
            zzee zzeeVar = zzez.zzahs;
            if (zzee.isMainThread()) {
                return this.zzakc == null ? this.zzaaa : this.zzakc;
            }
            zzip();
            return this.zzaka.get();
        }

        public final String getKey() {
            return this.zzny;
        }
    }

    static {
        String strValueOf = String.valueOf(Uri.encode("com.google.android.gms.measurement"));
        zzahy = new zzxh(Uri.parse(strValueOf.length() != 0 ? "content://com.google.android.gms.phenotype/".concat(strValueOf) : new String("content://com.google.android.gms.phenotype/")));
        zzahz = zza.zzb("measurement.log_third_party_store_events_enabled", false, false);
        zzaia = zza.zzb("measurement.log_installs_enabled", false, false);
        zzaib = zza.zzb("measurement.log_upgrades_enabled", false, false);
        zzaic = zza.zzb("measurement.log_androidId_enabled", false, false);
        zzaid = zza.zzb("measurement.upload_dsid_enabled", false, false);
        zzaie = zza.zzd("measurement.log_tag", "FA", "FA-SVC");
        zzaif = zza.zzb("measurement.ad_id_cache_time", 10000L, 10000L);
        zzaig = zza.zzb("measurement.monitoring.sample_period_millis", 86400000L, 86400000L);
        zzaih = zza.zzb("measurement.config.cache_time", 86400000L, 3600000L);
        zzaii = zza.zzd("measurement.config.url_scheme", "https", "https");
        zzaij = zza.zzd("measurement.config.url_authority", "app-measurement.com", "app-measurement.com");
        zzaik = zza.zzc("measurement.upload.max_bundles", 100, 100);
        zzail = zza.zzc("measurement.upload.max_batch_size", 65536, 65536);
        zzaim = zza.zzc("measurement.upload.max_bundle_size", 65536, 65536);
        zzain = zza.zzc("measurement.upload.max_events_per_bundle", 1000, 1000);
        zzaio = zza.zzc("measurement.upload.max_events_per_day", 100000, 100000);
        zzaip = zza.zzc("measurement.upload.max_error_events_per_day", 1000, 1000);
        zzaiq = zza.zzc("measurement.upload.max_public_events_per_day", 50000, 50000);
        zzair = zza.zzc("measurement.upload.max_conversions_per_day", 500, 500);
        zzais = zza.zzc("measurement.upload.max_realtime_events_per_day", 10, 10);
        zzait = zza.zzc("measurement.store.max_stored_events_per_app", 100000, 100000);
        zzaiu = zza.zzd("measurement.upload.url", "https://app-measurement.com/a", "https://app-measurement.com/a");
        zzaiv = zza.zzb("measurement.upload.backoff_period", 43200000L, 43200000L);
        zzaiw = zza.zzb("measurement.upload.window_interval", 3600000L, 3600000L);
        zzaix = zza.zzb("measurement.upload.interval", 3600000L, 3600000L);
        zzaiy = zza.zzb("measurement.upload.realtime_upload_interval", 10000L, 10000L);
        zzaiz = zza.zzb("measurement.upload.debug_upload_interval", 1000L, 1000L);
        zzaja = zza.zzb("measurement.upload.minimum_delay", 500L, 500L);
        zzajb = zza.zzb("measurement.alarm_manager.minimum_interval", 60000L, 60000L);
        zzajc = zza.zzb("measurement.upload.stale_data_deletion_interval", 86400000L, 86400000L);
        zzajd = zza.zzb("measurement.upload.refresh_blacklisted_config_interval", 604800000L, 604800000L);
        zzaje = zza.zzb("measurement.upload.initial_upload_delay_time", 15000L, 15000L);
        zzajf = zza.zzb("measurement.upload.retry_time", 1800000L, 1800000L);
        zzajg = zza.zzc("measurement.upload.retry_count", 6, 6);
        zzajh = zza.zzb("measurement.upload.max_queue_time", 2419200000L, 2419200000L);
        zzaji = zza.zzc("measurement.lifetimevalue.max_currency_tracked", 4, 4);
        zzajj = zza.zzc("measurement.audience.filter_result_max_count", ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
        zzajk = zza.zzb("measurement.service_client.idle_disconnect_millis", 5000L, 5000L);
        zzajl = zza.zzb("measurement.test.boolean_flag", false, false);
        zzajm = zza.zzd("measurement.test.string_flag", "---", "---");
        zzajn = zza.zzb("measurement.test.long_flag", -1L, -1L);
        zzajo = zza.zzc("measurement.test.int_flag", -2, -2);
        zzajp = zza.zza("measurement.test.double_flag", -3.0d, -3.0d);
        zzajq = zza.zzb("measurement.lifetimevalue.user_engagement_tracking_enabled", false, false);
        zzajr = zza.zzb("measurement.audience.complex_param_evaluation", false, false);
        zzajs = zza.zzb("measurement.validation.internal_limits_internal_event_params", false, false);
        zzajt = zza.zzb("measurement.quality.unsuccessful_update_retry_counter", false, false);
        zzaju = zza.zzb("measurement.iid.disable_on_collection_disabled", true, true);
        zzajv = zza.zzb("measurement.app_launch.call_only_when_enabled", true, true);
        zzajw = zza.zzb("measurement.run_on_worker_inline", true, false);
        zzajx = zza.zzb("measurement.audience.dynamic_filters", false, false);
        zzajy = zza.zzb("measurement.reset_analytics.persist_time", false, false);
        zzajz = zza.zzb("measurement.validation.value_and_currency_params", false, false);
    }

    static void zza(zzee zzeeVar) {
        zzahs = zzeeVar;
        zza.zzm();
    }
}
