package com.google.android.gms.internal.measurement;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import android.util.Pair;
import com.google.android.gms.auth.api.credentials.CredentialsApi;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzek extends zzjs {
    private static final String[] zzagl = {"last_bundled_timestamp", "ALTER TABLE events ADD COLUMN last_bundled_timestamp INTEGER;", "last_sampled_complex_event_id", "ALTER TABLE events ADD COLUMN last_sampled_complex_event_id INTEGER;", "last_sampling_rate", "ALTER TABLE events ADD COLUMN last_sampling_rate INTEGER;", "last_exempt_from_sampling", "ALTER TABLE events ADD COLUMN last_exempt_from_sampling INTEGER;"};
    private static final String[] zzagm = {FirebaseAnalytics.Param.ORIGIN, "ALTER TABLE user_attributes ADD COLUMN origin TEXT;"};
    private static final String[] zzagn = {"app_version", "ALTER TABLE apps ADD COLUMN app_version TEXT;", "app_store", "ALTER TABLE apps ADD COLUMN app_store TEXT;", "gmp_version", "ALTER TABLE apps ADD COLUMN gmp_version INTEGER;", "dev_cert_hash", "ALTER TABLE apps ADD COLUMN dev_cert_hash INTEGER;", "measurement_enabled", "ALTER TABLE apps ADD COLUMN measurement_enabled INTEGER;", "last_bundle_start_timestamp", "ALTER TABLE apps ADD COLUMN last_bundle_start_timestamp INTEGER;", "day", "ALTER TABLE apps ADD COLUMN day INTEGER;", "daily_public_events_count", "ALTER TABLE apps ADD COLUMN daily_public_events_count INTEGER;", "daily_events_count", "ALTER TABLE apps ADD COLUMN daily_events_count INTEGER;", "daily_conversions_count", "ALTER TABLE apps ADD COLUMN daily_conversions_count INTEGER;", "remote_config", "ALTER TABLE apps ADD COLUMN remote_config BLOB;", "config_fetched_time", "ALTER TABLE apps ADD COLUMN config_fetched_time INTEGER;", "failed_config_fetch_time", "ALTER TABLE apps ADD COLUMN failed_config_fetch_time INTEGER;", "app_version_int", "ALTER TABLE apps ADD COLUMN app_version_int INTEGER;", "firebase_instance_id", "ALTER TABLE apps ADD COLUMN firebase_instance_id TEXT;", "daily_error_events_count", "ALTER TABLE apps ADD COLUMN daily_error_events_count INTEGER;", "daily_realtime_events_count", "ALTER TABLE apps ADD COLUMN daily_realtime_events_count INTEGER;", "health_monitor_sample", "ALTER TABLE apps ADD COLUMN health_monitor_sample TEXT;", "android_id", "ALTER TABLE apps ADD COLUMN android_id INTEGER;", "adid_reporting_enabled", "ALTER TABLE apps ADD COLUMN adid_reporting_enabled INTEGER;", "ssaid_reporting_enabled", "ALTER TABLE apps ADD COLUMN ssaid_reporting_enabled INTEGER;"};
    private static final String[] zzago = {"realtime", "ALTER TABLE raw_events ADD COLUMN realtime INTEGER;"};
    private static final String[] zzagp = {"has_realtime", "ALTER TABLE queue ADD COLUMN has_realtime INTEGER;", "retry_count", "ALTER TABLE queue ADD COLUMN retry_count INTEGER;"};
    private static final String[] zzagq = {"previous_install_count", "ALTER TABLE app2 ADD COLUMN previous_install_count INTEGER;"};
    private final zzen zzagr;
    private final zzjo zzags;

    zzek(zzjt zzjtVar) {
        super(zzjtVar);
        this.zzags = new zzjo(zzbt());
        this.zzagr = new zzen(this, getContext(), "google_app_measurement.db");
    }

    @WorkerThread
    private final long zza(String str, String[] strArr) throws Throwable {
        Cursor cursorRawQuery;
        Cursor cursor = null;
        try {
            try {
                cursorRawQuery = getWritableDatabase().rawQuery(str, strArr);
            } catch (SQLiteException e) {
                e = e;
            }
        } catch (Throwable th) {
            th = th;
            cursorRawQuery = cursor;
        }
        try {
            if (!cursorRawQuery.moveToFirst()) {
                throw new SQLiteException("Database returned empty set");
            }
            long j = cursorRawQuery.getLong(0);
            if (cursorRawQuery != null) {
                cursorRawQuery.close();
            }
            return j;
        } catch (SQLiteException e2) {
            e = e2;
            cursor = cursorRawQuery;
            zzgi().zziv().zze("Database error", str, e);
            throw e;
        } catch (Throwable th2) {
            th = th2;
            if (cursorRawQuery != null) {
                cursorRawQuery.close();
            }
            throw th;
        }
    }

    @WorkerThread
    private final long zza(String str, String[] strArr, long j) throws Throwable {
        Cursor cursorRawQuery;
        Cursor cursor = null;
        try {
            try {
                cursorRawQuery = getWritableDatabase().rawQuery(str, strArr);
            } catch (SQLiteException e) {
                e = e;
            }
        } catch (Throwable th) {
            th = th;
        }
        try {
            if (!cursorRawQuery.moveToFirst()) {
                if (cursorRawQuery != null) {
                    cursorRawQuery.close();
                }
                return j;
            }
            long j2 = cursorRawQuery.getLong(0);
            if (cursorRawQuery != null) {
                cursorRawQuery.close();
            }
            return j2;
        } catch (SQLiteException e2) {
            e = e2;
            cursor = cursorRawQuery;
            zzgi().zziv().zze("Database error", str, e);
            throw e;
        } catch (Throwable th2) {
            th = th2;
            cursor = cursorRawQuery;
            if (cursor != null) {
                cursor.close();
            }
            throw th;
        }
    }

    @WorkerThread
    @VisibleForTesting
    private final Object zza(Cursor cursor, int i) {
        int type = cursor.getType(i);
        switch (type) {
            case 0:
                zzgi().zziv().log("Loaded invalid null value from database");
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                zzgi().zziv().log("Loaded invalid blob type value, ignoring it");
                break;
            default:
                zzgi().zziv().zzg("Loaded invalid unknown value type, ignoring it", Integer.valueOf(type));
                break;
        }
        return null;
    }

    @WorkerThread
    private static void zza(ContentValues contentValues, String str, Object obj) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(obj);
        if (obj instanceof String) {
            contentValues.put(str, (String) obj);
        } else if (obj instanceof Long) {
            contentValues.put(str, (Long) obj);
        } else {
            if (!(obj instanceof Double)) {
                throw new IllegalArgumentException("Invalid value type");
            }
            contentValues.put(str, (Double) obj);
        }
    }

    @WorkerThread
    private final boolean zza(String str, int i, zzkh zzkhVar) {
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzkhVar);
        if (TextUtils.isEmpty(zzkhVar.zzatl)) {
            zzgi().zziy().zzd("Event filter had no event name. Audience definition ignored. appId, audienceId, filterId", zzfi.zzbp(str), Integer.valueOf(i), String.valueOf(zzkhVar.zzatk));
            return false;
        }
        try {
            byte[] bArr = new byte[zzkhVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzkhVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            ContentValues contentValues = new ContentValues();
            contentValues.put("app_id", str);
            contentValues.put("audience_id", Integer.valueOf(i));
            contentValues.put("filter_id", zzkhVar.zzatk);
            contentValues.put("event_name", zzkhVar.zzatl);
            contentValues.put("data", bArr);
            try {
                if (getWritableDatabase().insertWithOnConflict("event_filters", null, contentValues, 5) != -1) {
                    return true;
                }
                zzgi().zziv().zzg("Failed to insert event filter (got -1). appId", zzfi.zzbp(str));
                return true;
            } catch (SQLiteException e) {
                zzgi().zziv().zze("Error storing event filter. appId", zzfi.zzbp(str), e);
                return false;
            }
        } catch (IOException e2) {
            zzgi().zziv().zze("Configuration loss. Failed to serialize event filter. appId", zzfi.zzbp(str), e2);
            return false;
        }
    }

    @WorkerThread
    private final boolean zza(String str, int i, zzkk zzkkVar) {
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzkkVar);
        if (TextUtils.isEmpty(zzkkVar.zzauc)) {
            zzgi().zziy().zzd("Property filter had no property name. Audience definition ignored. appId, audienceId, filterId", zzfi.zzbp(str), Integer.valueOf(i), String.valueOf(zzkkVar.zzatk));
            return false;
        }
        try {
            byte[] bArr = new byte[zzkkVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzkkVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            ContentValues contentValues = new ContentValues();
            contentValues.put("app_id", str);
            contentValues.put("audience_id", Integer.valueOf(i));
            contentValues.put("filter_id", zzkkVar.zzatk);
            contentValues.put("property_name", zzkkVar.zzauc);
            contentValues.put("data", bArr);
            try {
                if (getWritableDatabase().insertWithOnConflict("property_filters", null, contentValues, 5) != -1) {
                    return true;
                }
                zzgi().zziv().zzg("Failed to insert property filter (got -1). appId", zzfi.zzbp(str));
                return false;
            } catch (SQLiteException e) {
                zzgi().zziv().zze("Error storing property filter. appId", zzfi.zzbp(str), e);
                return false;
            }
        } catch (IOException e2) {
            zzgi().zziv().zze("Configuration loss. Failed to serialize property filter. appId", zzfi.zzbp(str), e2);
            return false;
        }
    }

    private final boolean zza(String str, List<Integer> list) throws Throwable {
        Preconditions.checkNotEmpty(str);
        zzch();
        zzab();
        SQLiteDatabase writableDatabase = getWritableDatabase();
        try {
            long jZza = zza("select count(1) from audience_filter_values where app_id=?", new String[]{str});
            int iMax = Math.max(0, Math.min(CredentialsApi.CREDENTIAL_PICKER_REQUEST_CODE, zzgk().zzb(str, zzez.zzajj)));
            if (jZza <= iMax) {
                return false;
            }
            ArrayList arrayList = new ArrayList();
            for (int i = 0; i < list.size(); i++) {
                Integer num = list.get(i);
                if (num == null || !(num instanceof Integer)) {
                    return false;
                }
                arrayList.add(Integer.toString(num.intValue()));
            }
            String strJoin = TextUtils.join(",", arrayList);
            StringBuilder sb = new StringBuilder(String.valueOf(strJoin).length() + 2);
            sb.append("(");
            sb.append(strJoin);
            sb.append(")");
            String string = sb.toString();
            StringBuilder sb2 = new StringBuilder(String.valueOf(string).length() + 140);
            sb2.append("audience_id in (select audience_id from audience_filter_values where app_id=? and audience_id not in ");
            sb2.append(string);
            sb2.append(" order by rowid desc limit -1 offset ?)");
            return writableDatabase.delete("audience_filter_values", sb2.toString(), new String[]{str, Integer.toString(iMax)}) > 0;
        } catch (SQLiteException e) {
            zzgi().zziv().zze("Database error querying filters. appId", zzfi.zzbp(str), e);
            return false;
        }
    }

    private final boolean zzid() {
        return getContext().getDatabasePath("google_app_measurement.db").exists();
    }

    @WorkerThread
    public final void beginTransaction() {
        zzch();
        getWritableDatabase().beginTransaction();
    }

    @WorkerThread
    public final void endTransaction() {
        zzch();
        getWritableDatabase().endTransaction();
    }

    @WorkerThread
    @VisibleForTesting
    final SQLiteDatabase getWritableDatabase() {
        zzab();
        try {
            return this.zzagr.getWritableDatabase();
        } catch (SQLiteException e) {
            zzgi().zziy().zzg("Error opening database", e);
            throw e;
        }
    }

    @WorkerThread
    public final void setTransactionSuccessful() {
        zzch();
        getWritableDatabase().setTransactionSuccessful();
    }

    public final long zza(zzku zzkuVar) throws IOException {
        long jZzc;
        zzab();
        zzch();
        Preconditions.checkNotNull(zzkuVar);
        Preconditions.checkNotEmpty(zzkuVar.zzth);
        try {
            byte[] bArr = new byte[zzkuVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzkuVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            zzjz zzjzVarZzjf = zzjf();
            Preconditions.checkNotNull(bArr);
            zzjzVarZzjf.zzgg().zzab();
            MessageDigest messageDigest = zzkd.getMessageDigest();
            if (messageDigest == null) {
                zzjzVarZzjf.zzgi().zziv().log("Failed to get MD5");
                jZzc = 0;
            } else {
                jZzc = zzkd.zzc(messageDigest.digest(bArr));
            }
            ContentValues contentValues = new ContentValues();
            contentValues.put("app_id", zzkuVar.zzth);
            contentValues.put("metadata_fingerprint", Long.valueOf(jZzc));
            contentValues.put("metadata", bArr);
            try {
                getWritableDatabase().insertWithOnConflict("raw_events_metadata", null, contentValues, 4);
                return jZzc;
            } catch (SQLiteException e) {
                zzgi().zziv().zze("Error storing raw event metadata. appId", zzfi.zzbp(zzkuVar.zzth), e);
                throw e;
            }
        } catch (IOException e2) {
            zzgi().zziv().zze("Data loss. Failed to serialize event metadata. appId", zzfi.zzbp(zzkuVar.zzth), e2);
            throw e2;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:33:0x008f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final android.util.Pair<com.google.android.gms.internal.measurement.zzkr, java.lang.Long> zza(java.lang.String r8, java.lang.Long r9) {
        /*
            r7 = this;
            r7.zzab()
            r7.zzch()
            r0 = 0
            android.database.sqlite.SQLiteDatabase r1 = r7.getWritableDatabase()     // Catch: java.lang.Throwable -> L74 android.database.sqlite.SQLiteException -> L77
            java.lang.String r2 = "select main_event, children_to_process from main_event_params where app_id=? and event_id=?"
            r3 = 2
            java.lang.String[] r3 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> L74 android.database.sqlite.SQLiteException -> L77
            r4 = 0
            r3[r4] = r8     // Catch: java.lang.Throwable -> L74 android.database.sqlite.SQLiteException -> L77
            java.lang.String r5 = java.lang.String.valueOf(r9)     // Catch: java.lang.Throwable -> L74 android.database.sqlite.SQLiteException -> L77
            r6 = 1
            r3[r6] = r5     // Catch: java.lang.Throwable -> L74 android.database.sqlite.SQLiteException -> L77
            android.database.Cursor r1 = r1.rawQuery(r2, r3)     // Catch: java.lang.Throwable -> L74 android.database.sqlite.SQLiteException -> L77
            boolean r2 = r1.moveToFirst()     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            if (r2 != 0) goto L37
            com.google.android.gms.internal.measurement.zzfi r8 = r7.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            com.google.android.gms.internal.measurement.zzfk r8 = r8.zzjc()     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            java.lang.String r9 = "Main event not found"
            r8.log(r9)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            if (r1 == 0) goto L36
            r1.close()
        L36:
            return r0
        L37:
            byte[] r2 = r1.getBlob(r4)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            long r5 = r1.getLong(r6)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            java.lang.Long r3 = java.lang.Long.valueOf(r5)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            int r5 = r2.length     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            com.google.android.gms.internal.measurement.zzaca r2 = com.google.android.gms.internal.measurement.zzaca.zza(r2, r4, r5)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            com.google.android.gms.internal.measurement.zzkr r4 = new com.google.android.gms.internal.measurement.zzkr     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            r4.<init>()     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            r4.zzb(r2)     // Catch: java.io.IOException -> L5a android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            android.util.Pair r8 = android.util.Pair.create(r4, r3)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            if (r1 == 0) goto L59
            r1.close()
        L59:
            return r8
        L5a:
            r2 = move-exception
            com.google.android.gms.internal.measurement.zzfi r3 = r7.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            com.google.android.gms.internal.measurement.zzfk r3 = r3.zziv()     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            java.lang.String r4 = "Failed to merge main event. appId, eventId"
            java.lang.Object r8 = com.google.android.gms.internal.measurement.zzfi.zzbp(r8)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            r3.zzd(r4, r8, r9, r2)     // Catch: android.database.sqlite.SQLiteException -> L72 java.lang.Throwable -> L8c
            if (r1 == 0) goto L71
            r1.close()
        L71:
            return r0
        L72:
            r8 = move-exception
            goto L79
        L74:
            r8 = move-exception
            r1 = r0
            goto L8d
        L77:
            r8 = move-exception
            r1 = r0
        L79:
            com.google.android.gms.internal.measurement.zzfi r9 = r7.zzgi()     // Catch: java.lang.Throwable -> L8c
            com.google.android.gms.internal.measurement.zzfk r9 = r9.zziv()     // Catch: java.lang.Throwable -> L8c
            java.lang.String r2 = "Error selecting main event"
            r9.zzg(r2, r8)     // Catch: java.lang.Throwable -> L8c
            if (r1 == 0) goto L8b
            r1.close()
        L8b:
            return r0
        L8c:
            r8 = move-exception
        L8d:
            if (r1 == 0) goto L92
            r1.close()
        L92:
            throw r8
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zza(java.lang.String, java.lang.Long):android.util.Pair");
    }

    /* JADX WARN: Removed duplicated region for block: B:43:0x0149  */
    /* JADX WARN: Removed duplicated region for block: B:50:? A[SYNTHETIC] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.measurement.zzel zza(long r22, java.lang.String r24, boolean r25, boolean r26, boolean r27, boolean r28, boolean r29) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 333
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zza(long, java.lang.String, boolean, boolean, boolean, boolean, boolean):com.google.android.gms.internal.measurement.zzel");
    }

    @WorkerThread
    public final void zza(zzea zzeaVar) {
        Preconditions.checkNotNull(zzeaVar);
        zzab();
        zzch();
        ContentValues contentValues = new ContentValues();
        contentValues.put("app_id", zzeaVar.zzah());
        contentValues.put("app_instance_id", zzeaVar.getAppInstanceId());
        contentValues.put("gmp_app_id", zzeaVar.getGmpAppId());
        contentValues.put("resettable_device_id_hash", zzeaVar.zzgq());
        contentValues.put("last_bundle_index", Long.valueOf(zzeaVar.zzgy()));
        contentValues.put("last_bundle_start_timestamp", Long.valueOf(zzeaVar.zzgs()));
        contentValues.put("last_bundle_end_timestamp", Long.valueOf(zzeaVar.zzgt()));
        contentValues.put("app_version", zzeaVar.zzag());
        contentValues.put("app_store", zzeaVar.zzgv());
        contentValues.put("gmp_version", Long.valueOf(zzeaVar.zzgw()));
        contentValues.put("dev_cert_hash", Long.valueOf(zzeaVar.zzgx()));
        contentValues.put("measurement_enabled", Boolean.valueOf(zzeaVar.isMeasurementEnabled()));
        contentValues.put("day", Long.valueOf(zzeaVar.zzhc()));
        contentValues.put("daily_public_events_count", Long.valueOf(zzeaVar.zzhd()));
        contentValues.put("daily_events_count", Long.valueOf(zzeaVar.zzhe()));
        contentValues.put("daily_conversions_count", Long.valueOf(zzeaVar.zzhf()));
        contentValues.put("config_fetched_time", Long.valueOf(zzeaVar.zzgz()));
        contentValues.put("failed_config_fetch_time", Long.valueOf(zzeaVar.zzha()));
        contentValues.put("app_version_int", Long.valueOf(zzeaVar.zzgu()));
        contentValues.put("firebase_instance_id", zzeaVar.zzgr());
        contentValues.put("daily_error_events_count", Long.valueOf(zzeaVar.zzhh()));
        contentValues.put("daily_realtime_events_count", Long.valueOf(zzeaVar.zzhg()));
        contentValues.put("health_monitor_sample", zzeaVar.zzhi());
        contentValues.put("android_id", Long.valueOf(zzeaVar.zzhk()));
        contentValues.put("adid_reporting_enabled", Boolean.valueOf(zzeaVar.zzhl()));
        contentValues.put("ssaid_reporting_enabled", Boolean.valueOf(zzeaVar.zzhm()));
        try {
            SQLiteDatabase writableDatabase = getWritableDatabase();
            if (writableDatabase.update("apps", contentValues, "app_id = ?", new String[]{zzeaVar.zzah()}) == 0 && writableDatabase.insertWithOnConflict("apps", null, contentValues, 5) == -1) {
                zzgi().zziv().zzg("Failed to insert/update app (got -1). appId", zzfi.zzbp(zzeaVar.zzah()));
            }
        } catch (SQLiteException e) {
            zzgi().zziv().zze("Error storing app. appId", zzfi.zzbp(zzeaVar.zzah()), e);
        }
    }

    @WorkerThread
    public final void zza(zzet zzetVar) {
        Preconditions.checkNotNull(zzetVar);
        zzab();
        zzch();
        ContentValues contentValues = new ContentValues();
        contentValues.put("app_id", zzetVar.zzth);
        contentValues.put("name", zzetVar.name);
        contentValues.put("lifetime_count", Long.valueOf(zzetVar.zzahh));
        contentValues.put("current_bundle_count", Long.valueOf(zzetVar.zzahi));
        contentValues.put("last_fire_timestamp", Long.valueOf(zzetVar.zzahj));
        contentValues.put("last_bundled_timestamp", Long.valueOf(zzetVar.zzahk));
        contentValues.put("last_sampled_complex_event_id", zzetVar.zzahl);
        contentValues.put("last_sampling_rate", zzetVar.zzahm);
        contentValues.put("last_exempt_from_sampling", (zzetVar.zzahn == null || !zzetVar.zzahn.booleanValue()) ? null : 1L);
        try {
            if (getWritableDatabase().insertWithOnConflict("events", null, contentValues, 5) == -1) {
                zzgi().zziv().zzg("Failed to insert/update event aggregates (got -1). appId", zzfi.zzbp(zzetVar.zzth));
            }
        } catch (SQLiteException e) {
            zzgi().zziv().zze("Error storing event aggregates. appId", zzfi.zzbp(zzetVar.zzth), e);
        }
    }

    @WorkerThread
    public final boolean zza(zzef zzefVar) {
        Preconditions.checkNotNull(zzefVar);
        zzab();
        zzch();
        if (zzh(zzefVar.packageName, zzefVar.zzage.name) == null && zza("SELECT COUNT(1) FROM conditional_properties WHERE app_id=?", new String[]{zzefVar.packageName}) >= 1000) {
            return false;
        }
        ContentValues contentValues = new ContentValues();
        contentValues.put("app_id", zzefVar.packageName);
        contentValues.put(FirebaseAnalytics.Param.ORIGIN, zzefVar.origin);
        contentValues.put("name", zzefVar.zzage.name);
        zza(contentValues, FirebaseAnalytics.Param.VALUE, zzefVar.zzage.getValue());
        contentValues.put("active", Boolean.valueOf(zzefVar.active));
        contentValues.put("trigger_event_name", zzefVar.triggerEventName);
        contentValues.put("trigger_timeout", Long.valueOf(zzefVar.triggerTimeout));
        zzgg();
        contentValues.put("timed_out_event", zzkd.zza(zzefVar.zzagf));
        contentValues.put("creation_timestamp", Long.valueOf(zzefVar.creationTimestamp));
        zzgg();
        contentValues.put("triggered_event", zzkd.zza(zzefVar.zzagg));
        contentValues.put("triggered_timestamp", Long.valueOf(zzefVar.zzage.zzast));
        contentValues.put("time_to_live", Long.valueOf(zzefVar.timeToLive));
        zzgg();
        contentValues.put("expired_event", zzkd.zza(zzefVar.zzagh));
        try {
            if (getWritableDatabase().insertWithOnConflict("conditional_properties", null, contentValues, 5) == -1) {
                zzgi().zziv().zzg("Failed to insert/update conditional user property (got -1)", zzfi.zzbp(zzefVar.packageName));
                return true;
            }
        } catch (SQLiteException e) {
            zzgi().zziv().zze("Error storing conditional user property", zzfi.zzbp(zzefVar.packageName), e);
        }
        return true;
    }

    public final boolean zza(zzes zzesVar, long j, boolean z) {
        zzfk zzfkVarZziv;
        String str;
        ContentValues contentValues;
        zzab();
        zzch();
        Preconditions.checkNotNull(zzesVar);
        Preconditions.checkNotEmpty(zzesVar.zzth);
        zzkr zzkrVar = new zzkr();
        zzkrVar.zzavc = Long.valueOf(zzesVar.zzahf);
        zzkrVar.zzava = new zzks[zzesVar.zzahg.size()];
        int i = 0;
        for (String str2 : zzesVar.zzahg) {
            zzks zzksVar = new zzks();
            int i2 = i + 1;
            zzkrVar.zzava[i] = zzksVar;
            zzksVar.name = str2;
            zzjf().zza(zzksVar, zzesVar.zzahg.get(str2));
            i = i2;
        }
        try {
            byte[] bArr = new byte[zzkrVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzkrVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            zzgi().zzjc().zze("Saving event, name, data size", zzgf().zzbm(zzesVar.name), Integer.valueOf(bArr.length));
            contentValues = new ContentValues();
            contentValues.put("app_id", zzesVar.zzth);
            contentValues.put("name", zzesVar.name);
            contentValues.put(AppMeasurement.Param.TIMESTAMP, Long.valueOf(zzesVar.timestamp));
            contentValues.put("metadata_fingerprint", Long.valueOf(j));
            contentValues.put("data", bArr);
            contentValues.put("realtime", Integer.valueOf(z ? 1 : 0));
        } catch (IOException e) {
            e = e;
            zzfkVarZziv = zzgi().zziv();
            str = "Data loss. Failed to serialize event params/data. appId";
        }
        try {
            if (getWritableDatabase().insert("raw_events", null, contentValues) != -1) {
                return true;
            }
            zzgi().zziv().zzg("Failed to insert raw event (got -1). appId", zzfi.zzbp(zzesVar.zzth));
            return false;
        } catch (SQLiteException e2) {
            e = e2;
            zzfkVarZziv = zzgi().zziv();
            str = "Error storing raw event. appId";
            zzfkVarZziv.zze(str, zzfi.zzbp(zzesVar.zzth), e);
            return false;
        }
    }

    @WorkerThread
    public final boolean zza(zzkc zzkcVar) {
        Preconditions.checkNotNull(zzkcVar);
        zzab();
        zzch();
        if (zzh(zzkcVar.zzth, zzkcVar.name) == null) {
            if (zzkd.zzcg(zzkcVar.name)) {
                if (zza("select count(1) from user_attributes where app_id=? and name not like '!_%' escape '!'", new String[]{zzkcVar.zzth}) >= 25) {
                    return false;
                }
            } else if (zza("select count(1) from user_attributes where app_id=? and origin=? AND name like '!_%' escape '!'", new String[]{zzkcVar.zzth, zzkcVar.origin}) >= 25) {
                return false;
            }
        }
        ContentValues contentValues = new ContentValues();
        contentValues.put("app_id", zzkcVar.zzth);
        contentValues.put(FirebaseAnalytics.Param.ORIGIN, zzkcVar.origin);
        contentValues.put("name", zzkcVar.name);
        contentValues.put("set_timestamp", Long.valueOf(zzkcVar.zzast));
        zza(contentValues, FirebaseAnalytics.Param.VALUE, zzkcVar.value);
        try {
            if (getWritableDatabase().insertWithOnConflict("user_attributes", null, contentValues, 5) == -1) {
                zzgi().zziv().zzg("Failed to insert/update user property (got -1). appId", zzfi.zzbp(zzkcVar.zzth));
                return true;
            }
        } catch (SQLiteException e) {
            zzgi().zziv().zze("Error storing user property. appId", zzfi.zzbp(zzkcVar.zzth), e);
        }
        return true;
    }

    @WorkerThread
    public final boolean zza(zzku zzkuVar, boolean z) {
        zzfk zzfkVarZziv;
        String str;
        zzab();
        zzch();
        Preconditions.checkNotNull(zzkuVar);
        Preconditions.checkNotEmpty(zzkuVar.zzth);
        Preconditions.checkNotNull(zzkuVar.zzavm);
        zzhx();
        long jCurrentTimeMillis = zzbt().currentTimeMillis();
        if (zzkuVar.zzavm.longValue() < jCurrentTimeMillis - zzeh.zzhq() || zzkuVar.zzavm.longValue() > jCurrentTimeMillis + zzeh.zzhq()) {
            zzgi().zziy().zzd("Storing bundle outside of the max uploading time span. appId, now, timestamp", zzfi.zzbp(zzkuVar.zzth), Long.valueOf(jCurrentTimeMillis), zzkuVar.zzavm);
        }
        try {
            byte[] bArr = new byte[zzkuVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzkuVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            byte[] bArrZzb = zzjf().zzb(bArr);
            zzgi().zzjc().zzg("Saving bundle, size", Integer.valueOf(bArrZzb.length));
            ContentValues contentValues = new ContentValues();
            contentValues.put("app_id", zzkuVar.zzth);
            contentValues.put("bundle_end_timestamp", zzkuVar.zzavm);
            contentValues.put("data", bArrZzb);
            contentValues.put("has_realtime", Integer.valueOf(z ? 1 : 0));
            if (zzkuVar.zzawj != null) {
                contentValues.put("retry_count", zzkuVar.zzawj);
            }
            try {
                if (getWritableDatabase().insert("queue", null, contentValues) != -1) {
                    return true;
                }
                zzgi().zziv().zzg("Failed to insert bundle (got -1). appId", zzfi.zzbp(zzkuVar.zzth));
                return false;
            } catch (SQLiteException e) {
                e = e;
                zzfkVarZziv = zzgi().zziv();
                str = "Error storing bundle. appId";
                zzfkVarZziv.zze(str, zzfi.zzbp(zzkuVar.zzth), e);
                return false;
            }
        } catch (IOException e2) {
            e = e2;
            zzfkVarZziv = zzgi().zziv();
            str = "Data loss. Failed to serialize bundle. appId";
        }
    }

    public final boolean zza(String str, Long l, long j, zzkr zzkrVar) {
        zzab();
        zzch();
        Preconditions.checkNotNull(zzkrVar);
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(l);
        try {
            byte[] bArr = new byte[zzkrVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzkrVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            zzgi().zzjc().zze("Saving complex main event, appId, data size", zzgf().zzbm(str), Integer.valueOf(bArr.length));
            ContentValues contentValues = new ContentValues();
            contentValues.put("app_id", str);
            contentValues.put("event_id", l);
            contentValues.put("children_to_process", Long.valueOf(j));
            contentValues.put("main_event", bArr);
            try {
                if (getWritableDatabase().insertWithOnConflict("main_event_params", null, contentValues, 5) != -1) {
                    return true;
                }
                zzgi().zziv().zzg("Failed to insert complex main event (got -1). appId", zzfi.zzbp(str));
                return false;
            } catch (SQLiteException e) {
                zzgi().zziv().zze("Error storing complex main event. appId", zzfi.zzbp(str), e);
                return false;
            }
        } catch (IOException e2) {
            zzgi().zziv().zzd("Data loss. Failed to serialize event params/data. appId, eventId", zzfi.zzbp(str), l, e2);
            return false;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:26:0x005b  */
    /* JADX WARN: Type inference failed for: r5v0, types: [long] */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v3, types: [android.database.Cursor] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final java.lang.String zzag(long r5) throws java.lang.Throwable {
        /*
            r4 = this;
            r4.zzab()
            r4.zzch()
            r0 = 0
            android.database.sqlite.SQLiteDatabase r1 = r4.getWritableDatabase()     // Catch: java.lang.Throwable -> L40 android.database.sqlite.SQLiteException -> L43
            java.lang.String r2 = "select app_id from apps where app_id in (select distinct app_id from raw_events) and config_fetched_time < ? order by failed_config_fetch_time limit 1;"
            r3 = 1
            java.lang.String[] r3 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> L40 android.database.sqlite.SQLiteException -> L43
            java.lang.String r5 = java.lang.String.valueOf(r5)     // Catch: java.lang.Throwable -> L40 android.database.sqlite.SQLiteException -> L43
            r6 = 0
            r3[r6] = r5     // Catch: java.lang.Throwable -> L40 android.database.sqlite.SQLiteException -> L43
            android.database.Cursor r5 = r1.rawQuery(r2, r3)     // Catch: java.lang.Throwable -> L40 android.database.sqlite.SQLiteException -> L43
            boolean r1 = r5.moveToFirst()     // Catch: android.database.sqlite.SQLiteException -> L3e java.lang.Throwable -> L58
            if (r1 != 0) goto L34
            com.google.android.gms.internal.measurement.zzfi r6 = r4.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L3e java.lang.Throwable -> L58
            com.google.android.gms.internal.measurement.zzfk r6 = r6.zzjc()     // Catch: android.database.sqlite.SQLiteException -> L3e java.lang.Throwable -> L58
            java.lang.String r1 = "No expired configs for apps with pending events"
            r6.log(r1)     // Catch: android.database.sqlite.SQLiteException -> L3e java.lang.Throwable -> L58
            if (r5 == 0) goto L33
            r5.close()
        L33:
            return r0
        L34:
            java.lang.String r6 = r5.getString(r6)     // Catch: android.database.sqlite.SQLiteException -> L3e java.lang.Throwable -> L58
            if (r5 == 0) goto L3d
            r5.close()
        L3d:
            return r6
        L3e:
            r6 = move-exception
            goto L45
        L40:
            r6 = move-exception
            r5 = r0
            goto L59
        L43:
            r6 = move-exception
            r5 = r0
        L45:
            com.google.android.gms.internal.measurement.zzfi r1 = r4.zzgi()     // Catch: java.lang.Throwable -> L58
            com.google.android.gms.internal.measurement.zzfk r1 = r1.zziv()     // Catch: java.lang.Throwable -> L58
            java.lang.String r2 = "Error selecting expired configs"
            r1.zzg(r2, r6)     // Catch: java.lang.Throwable -> L58
            if (r5 == 0) goto L57
            r5.close()
        L57:
            return r0
        L58:
            r6 = move-exception
        L59:
            if (r5 == 0) goto L5e
            r5.close()
        L5e:
            throw r6
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzag(long):java.lang.String");
    }

    @WorkerThread
    public final List<Pair<zzku, Long>> zzb(String str, int i, int i2) throws Throwable {
        Throwable th;
        Cursor cursorQuery;
        SQLiteException sQLiteException;
        byte[] bArrZza;
        zzab();
        zzch();
        Preconditions.checkArgument(i > 0);
        Preconditions.checkArgument(i2 > 0);
        Preconditions.checkNotEmpty(str);
        Cursor cursor = null;
        try {
            try {
                cursorQuery = getWritableDatabase().query("queue", new String[]{"rowid", "data", "retry_count"}, "app_id=?", new String[]{str}, null, null, "rowid", String.valueOf(i));
            } catch (SQLiteException e) {
                sQLiteException = e;
            }
        } catch (Throwable th2) {
            th = th2;
            cursorQuery = cursor;
        }
        try {
            if (!cursorQuery.moveToFirst()) {
                List<Pair<zzku, Long>> listEmptyList = Collections.emptyList();
                if (cursorQuery != null) {
                    cursorQuery.close();
                }
                return listEmptyList;
            }
            ArrayList arrayList = new ArrayList();
            int length = 0;
            do {
                long j = cursorQuery.getLong(0);
                try {
                    bArrZza = zzjf().zza(cursorQuery.getBlob(1));
                } catch (IOException e2) {
                    zzgi().zziv().zze("Failed to unzip queued bundle. appId", zzfi.zzbp(str), e2);
                }
                if (!arrayList.isEmpty() && bArrZza.length + length > i2) {
                    break;
                }
                zzaca zzacaVarZza = zzaca.zza(bArrZza, 0, bArrZza.length);
                zzku zzkuVar = new zzku();
                try {
                    zzkuVar.zzb(zzacaVarZza);
                    if (!cursorQuery.isNull(2)) {
                        zzkuVar.zzawj = Integer.valueOf(cursorQuery.getInt(2));
                    }
                    length += bArrZza.length;
                    arrayList.add(Pair.create(zzkuVar, Long.valueOf(j)));
                } catch (IOException e3) {
                    zzgi().zziv().zze("Failed to merge queued bundle. appId", zzfi.zzbp(str), e3);
                }
                if (!cursorQuery.moveToNext()) {
                    break;
                }
            } while (length <= i2);
            if (cursorQuery != null) {
                cursorQuery.close();
            }
            return arrayList;
        } catch (SQLiteException e4) {
            sQLiteException = e4;
            cursor = cursorQuery;
            zzgi().zziv().zze("Error querying bundles. appId", zzfi.zzbp(str), sQLiteException);
            List<Pair<zzku, Long>> listEmptyList2 = Collections.emptyList();
            if (cursor != null) {
                cursor.close();
            }
            return listEmptyList2;
        } catch (Throwable th3) {
            th = th3;
            if (cursorQuery == null) {
                throw th;
            }
            cursorQuery.close();
            throw th;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:23:0x009f, code lost:
    
        zzgi().zziv().zzg("Read more than the max allowed user properties, ignoring excess", 1000);
     */
    /* JADX WARN: Removed duplicated region for block: B:63:0x0148  */
    /* JADX WARN: Removed duplicated region for block: B:68:0x0151  */
    /* JADX WARN: Removed duplicated region for block: B:89:? A[SYNTHETIC] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final java.util.List<com.google.android.gms.internal.measurement.zzkc> zzb(java.lang.String r24, java.lang.String r25, java.lang.String r26) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 341
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzb(java.lang.String, java.lang.String, java.lang.String):java.util.List");
    }

    /* JADX WARN: Code restructure failed: missing block: B:11:0x008d, code lost:
    
        zzgi().zziv().zzg("Read more than the max allowed conditional properties, ignoring extra", 1000);
     */
    /* JADX WARN: Removed duplicated region for block: B:37:0x0177  */
    /* JADX WARN: Removed duplicated region for block: B:47:? A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final java.util.List<com.google.android.gms.internal.measurement.zzef> zzb(java.lang.String r39, java.lang.String[] r40) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 379
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzb(java.lang.String, java.lang.String[]):java.util.List");
    }

    @WorkerThread
    final void zzb(String str, zzkg[] zzkgVarArr) {
        boolean z;
        zzfk zzfkVarZziy;
        String str2;
        Object objZzbp;
        Integer num;
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(zzkgVarArr);
        SQLiteDatabase writableDatabase = getWritableDatabase();
        writableDatabase.beginTransaction();
        try {
            zzch();
            zzab();
            Preconditions.checkNotEmpty(str);
            SQLiteDatabase writableDatabase2 = getWritableDatabase();
            writableDatabase2.delete("property_filters", "app_id=?", new String[]{str});
            writableDatabase2.delete("event_filters", "app_id=?", new String[]{str});
            for (zzkg zzkgVar : zzkgVarArr) {
                zzch();
                zzab();
                Preconditions.checkNotEmpty(str);
                Preconditions.checkNotNull(zzkgVar);
                Preconditions.checkNotNull(zzkgVar.zzatg);
                Preconditions.checkNotNull(zzkgVar.zzatf);
                if (zzkgVar.zzate != null) {
                    int iIntValue = zzkgVar.zzate.intValue();
                    zzkh[] zzkhVarArr = zzkgVar.zzatg;
                    int length = zzkhVarArr.length;
                    int i = 0;
                    while (true) {
                        if (i >= length) {
                            for (zzkk zzkkVar : zzkgVar.zzatf) {
                                if (zzkkVar.zzatk == null) {
                                    zzfkVarZziy = zzgi().zziy();
                                    str2 = "Property filter with no ID. Audience definition ignored. appId, audienceId";
                                    objZzbp = zzfi.zzbp(str);
                                    num = zzkgVar.zzate;
                                }
                            }
                            zzkh[] zzkhVarArr2 = zzkgVar.zzatg;
                            int length2 = zzkhVarArr2.length;
                            int i2 = 0;
                            while (true) {
                                if (i2 >= length2) {
                                    z = true;
                                    break;
                                } else {
                                    if (!zza(str, iIntValue, zzkhVarArr2[i2])) {
                                        z = false;
                                        break;
                                    }
                                    i2++;
                                }
                            }
                            if (z) {
                                zzkk[] zzkkVarArr = zzkgVar.zzatf;
                                int length3 = zzkkVarArr.length;
                                int i3 = 0;
                                while (true) {
                                    if (i3 >= length3) {
                                        break;
                                    }
                                    if (!zza(str, iIntValue, zzkkVarArr[i3])) {
                                        z = false;
                                        break;
                                    }
                                    i3++;
                                }
                            }
                            if (!z) {
                                zzch();
                                zzab();
                                Preconditions.checkNotEmpty(str);
                                SQLiteDatabase writableDatabase3 = getWritableDatabase();
                                writableDatabase3.delete("property_filters", "app_id=? and audience_id=?", new String[]{str, String.valueOf(iIntValue)});
                                writableDatabase3.delete("event_filters", "app_id=? and audience_id=?", new String[]{str, String.valueOf(iIntValue)});
                            }
                        } else {
                            if (zzkhVarArr[i].zzatk == null) {
                                zzfkVarZziy = zzgi().zziy();
                                str2 = "Event filter with no ID. Audience definition ignored. appId, audienceId";
                                objZzbp = zzfi.zzbp(str);
                                num = zzkgVar.zzate;
                                break;
                            }
                            i++;
                        }
                    }
                    zzfkVarZziy.zze(str2, objZzbp, num);
                    break;
                } else {
                    zzgi().zziy().zzg("Audience with no ID. appId", zzfi.zzbp(str));
                }
            }
            ArrayList arrayList = new ArrayList();
            for (zzkg zzkgVar2 : zzkgVarArr) {
                arrayList.add(zzkgVar2.zzate);
            }
            zza(str, arrayList);
            writableDatabase.setTransactionSuccessful();
        } finally {
            writableDatabase.endTransaction();
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:41:0x00bd  */
    /* JADX WARN: Removed duplicated region for block: B:51:? A[SYNTHETIC] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final java.util.List<com.google.android.gms.internal.measurement.zzkc> zzbe(java.lang.String r25) throws java.lang.Throwable {
        /*
            r24 = this;
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r25)
            r24.zzab()
            r24.zzch()
            java.util.ArrayList r1 = new java.util.ArrayList
            r1.<init>()
            r2 = 0
            android.database.sqlite.SQLiteDatabase r3 = r24.getWritableDatabase()     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            java.lang.String r4 = "user_attributes"
            r5 = 4
            java.lang.String[] r5 = new java.lang.String[r5]     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            java.lang.String r6 = "name"
            r12 = 0
            r5[r12] = r6     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            java.lang.String r6 = "origin"
            r13 = 1
            r5[r13] = r6     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            java.lang.String r6 = "set_timestamp"
            r14 = 2
            r5[r14] = r6     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            java.lang.String r6 = "value"
            r15 = 3
            r5[r15] = r6     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            java.lang.String r6 = "app_id=?"
            java.lang.String[] r7 = new java.lang.String[r13]     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            r7[r12] = r25     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            r8 = 0
            r9 = 0
            java.lang.String r10 = "rowid"
            java.lang.String r11 = "1000"
            android.database.Cursor r3 = r3.query(r4, r5, r6, r7, r8, r9, r10, r11)     // Catch: java.lang.Throwable -> L97 android.database.sqlite.SQLiteException -> L9d
            boolean r4 = r3.moveToFirst()     // Catch: java.lang.Throwable -> L8e android.database.sqlite.SQLiteException -> L92
            if (r4 != 0) goto L48
            if (r3 == 0) goto L47
            r3.close()
        L47:
            return r1
        L48:
            java.lang.String r19 = r3.getString(r12)     // Catch: java.lang.Throwable -> L8e android.database.sqlite.SQLiteException -> L92
            java.lang.String r4 = r3.getString(r13)     // Catch: java.lang.Throwable -> L8e android.database.sqlite.SQLiteException -> L92
            if (r4 != 0) goto L54
            java.lang.String r4 = ""
        L54:
            r18 = r4
            long r20 = r3.getLong(r14)     // Catch: java.lang.Throwable -> L8e android.database.sqlite.SQLiteException -> L92
            r4 = r24
            java.lang.Object r22 = r4.zza(r3, r15)     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            if (r22 != 0) goto L74
            com.google.android.gms.internal.measurement.zzfi r5 = r24.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            com.google.android.gms.internal.measurement.zzfk r5 = r5.zziv()     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            java.lang.String r6 = "Read invalid user property value, ignoring it. appId"
            java.lang.Object r7 = com.google.android.gms.internal.measurement.zzfi.zzbp(r25)     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            r5.zzg(r6, r7)     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            goto L80
        L74:
            com.google.android.gms.internal.measurement.zzkc r5 = new com.google.android.gms.internal.measurement.zzkc     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            r16 = r5
            r17 = r25
            r16.<init>(r17, r18, r19, r20, r22)     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            r1.add(r5)     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
        L80:
            boolean r5 = r3.moveToNext()     // Catch: android.database.sqlite.SQLiteException -> L8c java.lang.Throwable -> Lb9
            if (r5 != 0) goto L48
            if (r3 == 0) goto L8b
            r3.close()
        L8b:
            return r1
        L8c:
            r0 = move-exception
            goto L95
        L8e:
            r0 = move-exception
            r4 = r24
            goto Lba
        L92:
            r0 = move-exception
            r4 = r24
        L95:
            r1 = r0
            goto La2
        L97:
            r0 = move-exception
            r4 = r24
            r1 = r0
            r3 = r2
            goto Lbb
        L9d:
            r0 = move-exception
            r4 = r24
            r1 = r0
            r3 = r2
        La2:
            com.google.android.gms.internal.measurement.zzfi r5 = r24.zzgi()     // Catch: java.lang.Throwable -> Lb9
            com.google.android.gms.internal.measurement.zzfk r5 = r5.zziv()     // Catch: java.lang.Throwable -> Lb9
            java.lang.String r6 = "Error querying user properties. appId"
            java.lang.Object r7 = com.google.android.gms.internal.measurement.zzfi.zzbp(r25)     // Catch: java.lang.Throwable -> Lb9
            r5.zze(r6, r7, r1)     // Catch: java.lang.Throwable -> Lb9
            if (r3 == 0) goto Lb8
            r3.close()
        Lb8:
            return r2
        Lb9:
            r0 = move-exception
        Lba:
            r1 = r0
        Lbb:
            if (r3 == 0) goto Lc0
            r3.close()
        Lc0:
            throw r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzbe(java.lang.String):java.util.List");
    }

    /* JADX WARN: Removed duplicated region for block: B:66:0x0238  */
    /* JADX WARN: Removed duplicated region for block: B:76:? A[SYNTHETIC] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.measurement.zzea zzbf(java.lang.String r21) {
        /*
            Method dump skipped, instruction units count: 572
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzbf(java.lang.String):com.google.android.gms.internal.measurement.zzea");
    }

    public final long zzbg(String str) {
        Preconditions.checkNotEmpty(str);
        zzab();
        zzch();
        try {
            return getWritableDatabase().delete("raw_events", "rowid in (select rowid from raw_events where app_id=? order by rowid desc limit -1 offset ?)", new String[]{str, String.valueOf(Math.max(0, Math.min(1000000, zzgk().zzb(str, zzez.zzait))))});
        } catch (SQLiteException e) {
            zzgi().zziv().zze("Error deleting over the limit events. appId", zzfi.zzbp(str), e);
            return 0L;
        }
    }

    @WorkerThread
    public final byte[] zzbh(String str) throws Throwable {
        Cursor cursorQuery;
        Preconditions.checkNotEmpty(str);
        zzab();
        zzch();
        try {
            cursorQuery = getWritableDatabase().query("apps", new String[]{"remote_config"}, "app_id=?", new String[]{str}, null, null, null);
            try {
                try {
                    if (!cursorQuery.moveToFirst()) {
                        if (cursorQuery != null) {
                            cursorQuery.close();
                        }
                        return null;
                    }
                    byte[] blob = cursorQuery.getBlob(0);
                    if (cursorQuery.moveToNext()) {
                        zzgi().zziv().zzg("Got multiple records for app config, expected one. appId", zzfi.zzbp(str));
                    }
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                    return blob;
                } catch (SQLiteException e) {
                    e = e;
                    zzgi().zziv().zze("Error querying remote config. appId", zzfi.zzbp(str), e);
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                    return null;
                }
            } catch (Throwable th) {
                th = th;
            }
            th = th;
        } catch (SQLiteException e2) {
            e = e2;
            cursorQuery = null;
        } catch (Throwable th2) {
            th = th2;
            cursorQuery = null;
        }
        if (cursorQuery != null) {
            cursorQuery.close();
        }
        throw th;
    }

    final Map<Integer, zzkv> zzbi(String str) {
        Cursor cursorQuery;
        zzch();
        zzab();
        Preconditions.checkNotEmpty(str);
        try {
            cursorQuery = getWritableDatabase().query("audience_filter_values", new String[]{"audience_id", "current_results"}, "app_id=?", new String[]{str}, null, null, null);
            try {
                try {
                    if (!cursorQuery.moveToFirst()) {
                        if (cursorQuery != null) {
                            cursorQuery.close();
                        }
                        return null;
                    }
                    ArrayMap arrayMap = new ArrayMap();
                    do {
                        int i = cursorQuery.getInt(0);
                        byte[] blob = cursorQuery.getBlob(1);
                        zzaca zzacaVarZza = zzaca.zza(blob, 0, blob.length);
                        zzkv zzkvVar = new zzkv();
                        try {
                            zzkvVar.zzb(zzacaVarZza);
                            arrayMap.put(Integer.valueOf(i), zzkvVar);
                        } catch (IOException e) {
                            zzgi().zziv().zzd("Failed to merge filter results. appId, audienceId, error", zzfi.zzbp(str), Integer.valueOf(i), e);
                        }
                    } while (cursorQuery.moveToNext());
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                    return arrayMap;
                } catch (SQLiteException e2) {
                    e = e2;
                    zzgi().zziv().zze("Database error querying filter results. appId", zzfi.zzbp(str), e);
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                    return null;
                }
            } catch (Throwable th) {
                th = th;
            }
            th = th;
        } catch (SQLiteException e3) {
            e = e3;
            cursorQuery = null;
        } catch (Throwable th2) {
            th = th2;
            cursorQuery = null;
        }
        if (cursorQuery != null) {
            cursorQuery.close();
        }
        throw th;
    }

    public final long zzbj(String str) {
        Preconditions.checkNotEmpty(str);
        return zza("select count(1) from events where app_id=? and name not like '!_%' escape '!'", new String[]{str}, 0L);
    }

    @WorkerThread
    public final List<zzef> zzc(String str, String str2, String str3) {
        Preconditions.checkNotEmpty(str);
        zzab();
        zzch();
        ArrayList arrayList = new ArrayList(3);
        arrayList.add(str);
        StringBuilder sb = new StringBuilder("app_id=?");
        if (!TextUtils.isEmpty(str2)) {
            arrayList.add(str2);
            sb.append(" and origin=?");
        }
        if (!TextUtils.isEmpty(str3)) {
            arrayList.add(String.valueOf(str3).concat("*"));
            sb.append(" and name glob ?");
        }
        return zzb(sb.toString(), (String[]) arrayList.toArray(new String[arrayList.size()]));
    }

    @WorkerThread
    @VisibleForTesting
    final void zzc(List<Long> list) {
        zzab();
        zzch();
        Preconditions.checkNotNull(list);
        Preconditions.checkNotZero(list.size());
        if (zzid()) {
            String strJoin = TextUtils.join(",", list);
            StringBuilder sb = new StringBuilder(String.valueOf(strJoin).length() + 2);
            sb.append("(");
            sb.append(strJoin);
            sb.append(")");
            String string = sb.toString();
            StringBuilder sb2 = new StringBuilder(String.valueOf(string).length() + 80);
            sb2.append("SELECT COUNT(1) FROM queue WHERE rowid IN ");
            sb2.append(string);
            sb2.append(" AND retry_count =  2147483647 LIMIT 1");
            if (zza(sb2.toString(), (String[]) null) > 0) {
                zzgi().zziy().log("The number of upload retries exceeds the limit. Will remain unchanged.");
            }
            try {
                SQLiteDatabase writableDatabase = getWritableDatabase();
                StringBuilder sb3 = new StringBuilder(String.valueOf(string).length() + 127);
                sb3.append("UPDATE queue SET retry_count = IFNULL(retry_count, 0) + 1 WHERE rowid IN ");
                sb3.append(string);
                sb3.append(" AND (retry_count IS NULL OR retry_count < 2147483647)");
                writableDatabase.execSQL(sb3.toString());
            } catch (SQLiteException e) {
                zzgi().zziv().zzg("Error incrementing retry count. error", e);
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:61:0x0125  */
    /* JADX WARN: Removed duplicated region for block: B:71:? A[SYNTHETIC] */
    /* JADX WARN: Type inference failed for: r15v1 */
    /* JADX WARN: Type inference failed for: r15v12 */
    /* JADX WARN: Type inference failed for: r15v4, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r15v9 */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.measurement.zzet zzf(java.lang.String r23, java.lang.String r24) {
        /*
            Method dump skipped, instruction units count: 297
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzf(java.lang.String, java.lang.String):com.google.android.gms.internal.measurement.zzet");
    }

    @WorkerThread
    public final void zzg(String str, String str2) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        zzab();
        zzch();
        try {
            zzgi().zzjc().zzg("Deleted user attribute rows", Integer.valueOf(getWritableDatabase().delete("user_attributes", "app_id=? and name=?", new String[]{str, str2})));
        } catch (SQLiteException e) {
            zzgi().zziv().zzd("Error deleting user attribute. appId", zzfi.zzbp(str), zzgf().zzbo(str2), e);
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzjs
    protected final boolean zzgn() {
        return false;
    }

    /* JADX WARN: Removed duplicated region for block: B:30:0x00a9  */
    /* JADX WARN: Removed duplicated region for block: B:35:0x00b1  */
    /* JADX WARN: Removed duplicated region for block: B:44:? A[SYNTHETIC] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.measurement.zzkc zzh(java.lang.String r20, java.lang.String r21) {
        /*
            r19 = this;
            r8 = r21
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r20)
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r21)
            r19.zzab()
            r19.zzch()
            r9 = 0
            android.database.sqlite.SQLiteDatabase r10 = r19.getWritableDatabase()     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            java.lang.String r11 = "user_attributes"
            r1 = 3
            java.lang.String[] r12 = new java.lang.String[r1]     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            java.lang.String r1 = "set_timestamp"
            r2 = 0
            r12[r2] = r1     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            java.lang.String r1 = "value"
            r3 = 1
            r12[r3] = r1     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            java.lang.String r1 = "origin"
            r4 = 2
            r12[r4] = r1     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            java.lang.String r13 = "app_id=? and name=?"
            java.lang.String[] r14 = new java.lang.String[r4]     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            r14[r2] = r20     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            r14[r3] = r8     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            r15 = 0
            r16 = 0
            r17 = 0
            android.database.Cursor r10 = r10.query(r11, r12, r13, r14, r15, r16, r17)     // Catch: java.lang.Throwable -> L83 android.database.sqlite.SQLiteException -> L89
            boolean r1 = r10.moveToFirst()     // Catch: java.lang.Throwable -> L7a android.database.sqlite.SQLiteException -> L7e
            if (r1 != 0) goto L44
            if (r10 == 0) goto L43
            r10.close()
        L43:
            return r9
        L44:
            long r5 = r10.getLong(r2)     // Catch: java.lang.Throwable -> L7a android.database.sqlite.SQLiteException -> L7e
            r11 = r19
            java.lang.Object r7 = r11.zza(r10, r3)     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            java.lang.String r3 = r10.getString(r4)     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            com.google.android.gms.internal.measurement.zzkc r12 = new com.google.android.gms.internal.measurement.zzkc     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            r1 = r12
            r2 = r20
            r4 = r8
            r1.<init>(r2, r3, r4, r5, r7)     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            boolean r1 = r10.moveToNext()     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            if (r1 == 0) goto L72
            com.google.android.gms.internal.measurement.zzfi r1 = r19.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            com.google.android.gms.internal.measurement.zzfk r1 = r1.zziv()     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            java.lang.String r2 = "Got multiple records for user property, expected one. appId"
            java.lang.Object r3 = com.google.android.gms.internal.measurement.zzfi.zzbp(r20)     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
            r1.zzg(r2, r3)     // Catch: android.database.sqlite.SQLiteException -> L78 java.lang.Throwable -> Lad
        L72:
            if (r10 == 0) goto L77
            r10.close()
        L77:
            return r12
        L78:
            r0 = move-exception
            goto L81
        L7a:
            r0 = move-exception
            r11 = r19
            goto Lae
        L7e:
            r0 = move-exception
            r11 = r19
        L81:
            r1 = r0
            goto L8e
        L83:
            r0 = move-exception
            r11 = r19
            r1 = r0
            r10 = r9
            goto Laf
        L89:
            r0 = move-exception
            r11 = r19
            r1 = r0
            r10 = r9
        L8e:
            com.google.android.gms.internal.measurement.zzfi r2 = r19.zzgi()     // Catch: java.lang.Throwable -> Lad
            com.google.android.gms.internal.measurement.zzfk r2 = r2.zziv()     // Catch: java.lang.Throwable -> Lad
            java.lang.String r3 = "Error querying user property. appId"
            java.lang.Object r4 = com.google.android.gms.internal.measurement.zzfi.zzbp(r20)     // Catch: java.lang.Throwable -> Lad
            com.google.android.gms.internal.measurement.zzfg r5 = r19.zzgf()     // Catch: java.lang.Throwable -> Lad
            java.lang.String r5 = r5.zzbo(r8)     // Catch: java.lang.Throwable -> Lad
            r2.zzd(r3, r4, r5, r1)     // Catch: java.lang.Throwable -> Lad
            if (r10 == 0) goto Lac
            r10.close()
        Lac:
            return r9
        Lad:
            r0 = move-exception
        Lae:
            r1 = r0
        Laf:
            if (r10 == 0) goto Lb4
            r10.close()
        Lb4:
            throw r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzh(java.lang.String, java.lang.String):com.google.android.gms.internal.measurement.zzkc");
    }

    @WorkerThread
    public final String zzhv() throws Throwable {
        Throwable th;
        Cursor cursorRawQuery;
        try {
            cursorRawQuery = getWritableDatabase().rawQuery("select app_id from queue order by has_realtime desc, rowid asc limit 1;", null);
            try {
                try {
                    if (!cursorRawQuery.moveToFirst()) {
                        if (cursorRawQuery != null) {
                            cursorRawQuery.close();
                        }
                        return null;
                    }
                    String string = cursorRawQuery.getString(0);
                    if (cursorRawQuery != null) {
                        cursorRawQuery.close();
                    }
                    return string;
                } catch (SQLiteException e) {
                    e = e;
                    zzgi().zziv().zzg("Database error getting next bundle app id", e);
                    if (cursorRawQuery != null) {
                        cursorRawQuery.close();
                    }
                    return null;
                }
            } catch (Throwable th2) {
                th = th2;
            }
            th = th2;
        } catch (SQLiteException e2) {
            e = e2;
            cursorRawQuery = null;
        } catch (Throwable th3) {
            th = th3;
            cursorRawQuery = null;
        }
        if (cursorRawQuery != null) {
            cursorRawQuery.close();
        }
        throw th;
    }

    public final boolean zzhw() {
        return zza("select count(1) > 0 from queue where has_realtime = 1", (String[]) null) != 0;
    }

    @WorkerThread
    final void zzhx() {
        int iDelete;
        zzab();
        zzch();
        if (zzid()) {
            long j = zzgj().zzalw.get();
            long jElapsedRealtime = zzbt().elapsedRealtime();
            if (Math.abs(jElapsedRealtime - j) > zzez.zzajc.get().longValue()) {
                zzgj().zzalw.set(jElapsedRealtime);
                zzab();
                zzch();
                if (!zzid() || (iDelete = getWritableDatabase().delete("queue", "abs(bundle_end_timestamp - ?) > cast(? as integer)", new String[]{String.valueOf(zzbt().currentTimeMillis()), String.valueOf(zzeh.zzhq())})) <= 0) {
                    return;
                }
                zzgi().zzjc().zzg("Deleted stale rows. rowsDeleted", Integer.valueOf(iDelete));
            }
        }
    }

    @WorkerThread
    public final long zzhy() {
        return zza("select max(bundle_end_timestamp) from queue", (String[]) null, 0L);
    }

    @WorkerThread
    public final long zzhz() {
        return zza("select max(timestamp) from raw_events", (String[]) null, 0L);
    }

    /* JADX WARN: Removed duplicated region for block: B:39:0x0156  */
    /* JADX WARN: Removed duplicated region for block: B:47:? A[SYNTHETIC] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.measurement.zzef zzi(java.lang.String r34, java.lang.String r35) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 346
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzi(java.lang.String, java.lang.String):com.google.android.gms.internal.measurement.zzef");
    }

    public final boolean zzia() {
        return zza("select count(1) > 0 from raw_events", (String[]) null) != 0;
    }

    public final boolean zzib() {
        return zza("select count(1) > 0 from raw_events where realtime = 1", (String[]) null) != 0;
    }

    public final long zzic() throws Throwable {
        Cursor cursorRawQuery;
        Cursor cursor = null;
        try {
            try {
                cursorRawQuery = getWritableDatabase().rawQuery("select rowid from raw_events order by rowid desc limit 1;", null);
            } catch (Throwable th) {
                th = th;
            }
        } catch (SQLiteException e) {
            e = e;
        }
        try {
            if (!cursorRawQuery.moveToFirst()) {
                if (cursorRawQuery != null) {
                    cursorRawQuery.close();
                }
                return -1L;
            }
            long j = cursorRawQuery.getLong(0);
            if (cursorRawQuery != null) {
                cursorRawQuery.close();
            }
            return j;
        } catch (SQLiteException e2) {
            e = e2;
            cursor = cursorRawQuery;
            zzgi().zziv().zzg("Error querying raw events", e);
            if (cursor != null) {
                cursor.close();
            }
            return -1L;
        } catch (Throwable th2) {
            th = th2;
            cursor = cursorRawQuery;
            if (cursor != null) {
                cursor.close();
            }
            throw th;
        }
    }

    @WorkerThread
    public final int zzj(String str, String str2) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        zzab();
        zzch();
        try {
            return getWritableDatabase().delete("conditional_properties", "app_id=? and name=?", new String[]{str, str2});
        } catch (SQLiteException e) {
            zzgi().zziv().zzd("Error deleting conditional property", zzfi.zzbp(str), zzgf().zzbo(str2), e);
            return 0;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:35:0x00b8  */
    /* JADX WARN: Type inference failed for: r14v1 */
    /* JADX WARN: Type inference failed for: r14v3, types: [android.database.Cursor] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final java.util.Map<java.lang.Integer, java.util.List<com.google.android.gms.internal.measurement.zzkh>> zzk(java.lang.String r13, java.lang.String r14) {
        /*
            r12 = this;
            r12.zzch()
            r12.zzab()
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r13)
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r14)
            android.support.v4.util.ArrayMap r0 = new android.support.v4.util.ArrayMap
            r0.<init>()
            android.database.sqlite.SQLiteDatabase r1 = r12.getWritableDatabase()
            r9 = 0
            java.lang.String r2 = "event_filters"
            r3 = 2
            java.lang.String[] r4 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            java.lang.String r5 = "audience_id"
            r10 = 0
            r4[r10] = r5     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            java.lang.String r5 = "data"
            r11 = 1
            r4[r11] = r5     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            java.lang.String r5 = "app_id=? AND event_name=?"
            java.lang.String[] r6 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            r6[r10] = r13     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            r6[r11] = r14     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            r14 = 0
            r7 = 0
            r8 = 0
            r3 = r4
            r4 = r5
            r5 = r6
            r6 = r14
            android.database.Cursor r14 = r1.query(r2, r3, r4, r5, r6, r7, r8)     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            boolean r1 = r14.moveToFirst()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r1 != 0) goto L48
            java.util.Map r0 = java.util.Collections.emptyMap()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r14 == 0) goto L47
            r14.close()
        L47:
            return r0
        L48:
            byte[] r1 = r14.getBlob(r11)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            int r2 = r1.length     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzaca r1 = com.google.android.gms.internal.measurement.zzaca.zza(r1, r10, r2)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzkh r2 = new com.google.android.gms.internal.measurement.zzkh     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r2.<init>()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r2.zzb(r1)     // Catch: java.io.IOException -> L79 android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            int r1 = r14.getInt(r10)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.Integer r3 = java.lang.Integer.valueOf(r1)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.Object r3 = r0.get(r3)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.util.List r3 = (java.util.List) r3     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r3 != 0) goto L75
            java.util.ArrayList r3 = new java.util.ArrayList     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r3.<init>()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.Integer r1 = java.lang.Integer.valueOf(r1)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r0.put(r1, r3)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
        L75:
            r3.add(r2)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            goto L8b
        L79:
            r1 = move-exception
            com.google.android.gms.internal.measurement.zzfi r2 = r12.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzfk r2 = r2.zziv()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.String r3 = "Failed to merge filter. appId"
            java.lang.Object r4 = com.google.android.gms.internal.measurement.zzfi.zzbp(r13)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r2.zze(r3, r4, r1)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
        L8b:
            boolean r1 = r14.moveToNext()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r1 != 0) goto L48
            if (r14 == 0) goto L96
            r14.close()
        L96:
            return r0
        L97:
            r0 = move-exception
            goto L9e
        L99:
            r13 = move-exception
            r14 = r9
            goto Lb6
        L9c:
            r0 = move-exception
            r14 = r9
        L9e:
            com.google.android.gms.internal.measurement.zzfi r1 = r12.zzgi()     // Catch: java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzfk r1 = r1.zziv()     // Catch: java.lang.Throwable -> Lb5
            java.lang.String r2 = "Database error querying filters. appId"
            java.lang.Object r13 = com.google.android.gms.internal.measurement.zzfi.zzbp(r13)     // Catch: java.lang.Throwable -> Lb5
            r1.zze(r2, r13, r0)     // Catch: java.lang.Throwable -> Lb5
            if (r14 == 0) goto Lb4
            r14.close()
        Lb4:
            return r9
        Lb5:
            r13 = move-exception
        Lb6:
            if (r14 == 0) goto Lbb
            r14.close()
        Lbb:
            throw r13
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzk(java.lang.String, java.lang.String):java.util.Map");
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:35:0x00b8  */
    /* JADX WARN: Type inference failed for: r14v1 */
    /* JADX WARN: Type inference failed for: r14v3, types: [android.database.Cursor] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final java.util.Map<java.lang.Integer, java.util.List<com.google.android.gms.internal.measurement.zzkk>> zzl(java.lang.String r13, java.lang.String r14) {
        /*
            r12 = this;
            r12.zzch()
            r12.zzab()
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r13)
            com.google.android.gms.common.internal.Preconditions.checkNotEmpty(r14)
            android.support.v4.util.ArrayMap r0 = new android.support.v4.util.ArrayMap
            r0.<init>()
            android.database.sqlite.SQLiteDatabase r1 = r12.getWritableDatabase()
            r9 = 0
            java.lang.String r2 = "property_filters"
            r3 = 2
            java.lang.String[] r4 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            java.lang.String r5 = "audience_id"
            r10 = 0
            r4[r10] = r5     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            java.lang.String r5 = "data"
            r11 = 1
            r4[r11] = r5     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            java.lang.String r5 = "app_id=? AND property_name=?"
            java.lang.String[] r6 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            r6[r10] = r13     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            r6[r11] = r14     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            r14 = 0
            r7 = 0
            r8 = 0
            r3 = r4
            r4 = r5
            r5 = r6
            r6 = r14
            android.database.Cursor r14 = r1.query(r2, r3, r4, r5, r6, r7, r8)     // Catch: java.lang.Throwable -> L99 android.database.sqlite.SQLiteException -> L9c
            boolean r1 = r14.moveToFirst()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r1 != 0) goto L48
            java.util.Map r0 = java.util.Collections.emptyMap()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r14 == 0) goto L47
            r14.close()
        L47:
            return r0
        L48:
            byte[] r1 = r14.getBlob(r11)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            int r2 = r1.length     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzaca r1 = com.google.android.gms.internal.measurement.zzaca.zza(r1, r10, r2)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzkk r2 = new com.google.android.gms.internal.measurement.zzkk     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r2.<init>()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r2.zzb(r1)     // Catch: java.io.IOException -> L79 android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            int r1 = r14.getInt(r10)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.Integer r3 = java.lang.Integer.valueOf(r1)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.Object r3 = r0.get(r3)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.util.List r3 = (java.util.List) r3     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r3 != 0) goto L75
            java.util.ArrayList r3 = new java.util.ArrayList     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r3.<init>()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.Integer r1 = java.lang.Integer.valueOf(r1)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r0.put(r1, r3)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
        L75:
            r3.add(r2)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            goto L8b
        L79:
            r1 = move-exception
            com.google.android.gms.internal.measurement.zzfi r2 = r12.zzgi()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzfk r2 = r2.zziv()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            java.lang.String r3 = "Failed to merge filter"
            java.lang.Object r4 = com.google.android.gms.internal.measurement.zzfi.zzbp(r13)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            r2.zze(r3, r4, r1)     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
        L8b:
            boolean r1 = r14.moveToNext()     // Catch: android.database.sqlite.SQLiteException -> L97 java.lang.Throwable -> Lb5
            if (r1 != 0) goto L48
            if (r14 == 0) goto L96
            r14.close()
        L96:
            return r0
        L97:
            r0 = move-exception
            goto L9e
        L99:
            r13 = move-exception
            r14 = r9
            goto Lb6
        L9c:
            r0 = move-exception
            r14 = r9
        L9e:
            com.google.android.gms.internal.measurement.zzfi r1 = r12.zzgi()     // Catch: java.lang.Throwable -> Lb5
            com.google.android.gms.internal.measurement.zzfk r1 = r1.zziv()     // Catch: java.lang.Throwable -> Lb5
            java.lang.String r2 = "Database error querying filters. appId"
            java.lang.Object r13 = com.google.android.gms.internal.measurement.zzfi.zzbp(r13)     // Catch: java.lang.Throwable -> Lb5
            r1.zze(r2, r13, r0)     // Catch: java.lang.Throwable -> Lb5
            if (r14 == 0) goto Lb4
            r14.close()
        Lb4:
            return r9
        Lb5:
            r13 = move-exception
        Lb6:
            if (r14 == 0) goto Lbb
            r14.close()
        Lbb:
            throw r13
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzl(java.lang.String, java.lang.String):java.util.Map");
    }

    /* JADX WARN: Can't wrap try/catch for region: R(8:0|2|(5:41|3|4|39|5)|(6:7|(3:9|10|11)(1:12)|30|31|32|33)|38|13|(3:15|16|17)(3:18|32|33)|(1:(0))) */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x00ca, code lost:
    
        r0 = e;
     */
    @android.support.annotation.WorkerThread
    @com.google.android.gms.common.util.VisibleForTesting
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final long zzm(java.lang.String r19, java.lang.String r20) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 243
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzek.zzm(java.lang.String, java.lang.String):long");
    }
}
