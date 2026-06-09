package com.google.android.gms.internal.measurement;

import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.util.Log;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes2.dex */
public class zzws {
    private static HashMap<String, String> zzbop;
    private static Object zzbou;
    private static boolean zzbov;
    private static final Uri CONTENT_URI = Uri.parse("content://com.google.android.gsf.gservices");
    private static final Uri zzbol = Uri.parse("content://com.google.android.gsf.gservices/prefix");
    public static final Pattern zzbom = Pattern.compile("^(1|true|t|on|yes|y)$", 2);
    public static final Pattern zzbon = Pattern.compile("^(0|false|f|off|no|n)$", 2);
    private static final AtomicBoolean zzboo = new AtomicBoolean();
    private static final HashMap<String, Boolean> zzboq = new HashMap<>();
    private static final HashMap<String, Integer> zzbor = new HashMap<>();
    private static final HashMap<String, Long> zzbos = new HashMap<>();
    private static final HashMap<String, Float> zzbot = new HashMap<>();
    private static String[] zzbow = new String[0];

    private static <T> T zza(HashMap<String, T> map, String str, T t) {
        synchronized (zzws.class) {
            if (!map.containsKey(str)) {
                return null;
            }
            T t2 = map.get(str);
            if (t2 == null) {
                t2 = t;
            }
            return t2;
        }
    }

    public static String zza(ContentResolver contentResolver, String str, String str2) {
        synchronized (zzws.class) {
            zza(contentResolver);
            Object obj = zzbou;
            if (zzbop.containsKey(str)) {
                String str3 = zzbop.get(str);
                if (str3 == null) {
                    str3 = null;
                }
                return str3;
            }
            for (String str4 : zzbow) {
                if (str.startsWith(str4)) {
                    if (!zzbov || zzbop.isEmpty()) {
                        zzbop.putAll(zza(contentResolver, zzbow));
                        zzbov = true;
                        if (zzbop.containsKey(str)) {
                            String str5 = zzbop.get(str);
                            if (str5 == null) {
                                str5 = null;
                            }
                            return str5;
                        }
                    }
                    return null;
                }
            }
            Cursor cursorQuery = contentResolver.query(CONTENT_URI, null, null, new String[]{str}, null);
            if (cursorQuery == null) {
                return null;
            }
            try {
                if (!cursorQuery.moveToFirst()) {
                    zza(obj, str, (String) null);
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                    return null;
                }
                String string = cursorQuery.getString(1);
                if (string != null && string.equals(null)) {
                    string = null;
                }
                zza(obj, str, string);
                if (string == null) {
                    string = null;
                }
                if (cursorQuery != null) {
                    cursorQuery.close();
                }
                return string;
            } finally {
                if (cursorQuery != null) {
                    cursorQuery.close();
                }
            }
        }
    }

    private static Map<String, String> zza(ContentResolver contentResolver, String... strArr) {
        Cursor cursorQuery = contentResolver.query(zzbol, null, null, strArr, null);
        TreeMap treeMap = new TreeMap();
        if (cursorQuery == null) {
            return treeMap;
        }
        while (cursorQuery.moveToNext()) {
            try {
                treeMap.put(cursorQuery.getString(0), cursorQuery.getString(1));
            } finally {
                cursorQuery.close();
            }
        }
        return treeMap;
    }

    private static void zza(ContentResolver contentResolver) {
        if (zzbop == null) {
            zzboo.set(false);
            zzbop = new HashMap<>();
            zzbou = new Object();
            zzbov = false;
            contentResolver.registerContentObserver(CONTENT_URI, true, new zzwt(null));
            return;
        }
        if (zzboo.getAndSet(false)) {
            zzbop.clear();
            zzboq.clear();
            zzbor.clear();
            zzbos.clear();
            zzbot.clear();
            zzbou = new Object();
            zzbov = false;
        }
    }

    private static void zza(Object obj, String str, String str2) {
        synchronized (zzws.class) {
            if (obj == zzbou) {
                zzbop.put(str, str2);
            }
        }
    }

    private static <T> void zza(Object obj, HashMap<String, T> map, String str, T t) {
        synchronized (zzws.class) {
            if (obj == zzbou) {
                map.put(str, t);
                zzbop.remove(str);
            }
        }
    }

    public static boolean zza(ContentResolver contentResolver, String str, boolean z) {
        Object objZzb = zzb(contentResolver);
        Boolean bool = (Boolean) zza(zzboq, str, Boolean.valueOf(z));
        if (bool != null) {
            return bool.booleanValue();
        }
        String strZza = zza(contentResolver, str, (String) null);
        if (strZza != null && !strZza.equals("")) {
            if (zzbom.matcher(strZza).matches()) {
                bool = true;
                z = true;
            } else if (zzbon.matcher(strZza).matches()) {
                bool = false;
                z = false;
            } else {
                Log.w("Gservices", "attempt to read gservices key " + str + " (value \"" + strZza + "\") as boolean");
            }
        }
        zza(objZzb, zzboq, str, bool);
        return z;
    }

    private static Object zzb(ContentResolver contentResolver) {
        Object obj;
        synchronized (zzws.class) {
            zza(contentResolver);
            obj = zzbou;
        }
        return obj;
    }
}
