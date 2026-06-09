package com.google.android.gms.internal.measurement;

import android.content.ContentResolver;
import android.database.ContentObserver;
import android.database.Cursor;
import android.database.sqlite.SQLiteException;
import android.net.Uri;
import android.support.annotation.GuardedBy;
import android.util.Log;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/* JADX INFO: loaded from: classes2.dex */
public final class zzwu {
    private static final ConcurrentHashMap<Uri, zzwu> zzbox = new ConcurrentHashMap<>();
    private static final String[] zzbpe = {"key", FirebaseAnalytics.Param.VALUE};
    private final Uri uri;
    private final ContentResolver zzboy;
    private volatile Map<String, String> zzbpb;
    private final Object zzbpa = new Object();
    private final Object zzbpc = new Object();

    @GuardedBy("listenersLock")
    private final List<zzww> zzbpd = new ArrayList();
    private final ContentObserver zzboz = new zzwv(this, null);

    private zzwu(ContentResolver contentResolver, Uri uri) {
        this.zzboy = contentResolver;
        this.uri = uri;
    }

    public static zzwu zza(ContentResolver contentResolver, Uri uri) {
        zzwu zzwuVar = zzbox.get(uri);
        if (zzwuVar != null) {
            return zzwuVar;
        }
        zzwu zzwuVar2 = new zzwu(contentResolver, uri);
        zzwu zzwuVarPutIfAbsent = zzbox.putIfAbsent(uri, zzwuVar2);
        if (zzwuVarPutIfAbsent != null) {
            return zzwuVarPutIfAbsent;
        }
        zzwuVar2.zzboy.registerContentObserver(zzwuVar2.uri, false, zzwuVar2.zzboz);
        return zzwuVar2;
    }

    private final Map<String, String> zzsj() {
        try {
            HashMap map = new HashMap();
            Cursor cursorQuery = this.zzboy.query(this.uri, zzbpe, null, null, null);
            if (cursorQuery == null) {
                return map;
            }
            while (cursorQuery.moveToNext()) {
                try {
                    map.put(cursorQuery.getString(0), cursorQuery.getString(1));
                } finally {
                    cursorQuery.close();
                }
            }
            return map;
        } catch (SQLiteException | SecurityException unused) {
            Log.e("ConfigurationContentLoader", "PhenotypeFlag unable to load ContentProvider, using default values");
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzsk() {
        synchronized (this.zzbpc) {
            Iterator<zzww> it2 = this.zzbpd.iterator();
            while (it2.hasNext()) {
                it2.next().zzsl();
            }
        }
    }

    public final Map<String, String> zzsh() {
        Map<String, String> mapZzsj = zzwx.zzd("gms:phenotype:phenotype_flag:debug_disable_caching", false) ? zzsj() : this.zzbpb;
        if (mapZzsj == null) {
            synchronized (this.zzbpa) {
                mapZzsj = this.zzbpb;
                if (mapZzsj == null) {
                    mapZzsj = zzsj();
                    this.zzbpb = mapZzsj;
                }
            }
        }
        return mapZzsj != null ? mapZzsj : Collections.emptyMap();
    }

    public final void zzsi() {
        synchronized (this.zzbpa) {
            this.zzbpb = null;
        }
    }
}
