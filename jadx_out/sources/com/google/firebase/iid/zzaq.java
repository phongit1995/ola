package com.google.firebase.iid;

import android.content.Context;
import android.content.SharedPreferences;
import android.support.annotation.GuardedBy;
import android.support.v4.content.ContextCompat;
import android.support.v4.util.ArrayMap;
import android.util.Log;
import java.io.File;
import java.io.IOException;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzaq {
    private final SharedPreferences zzcv;
    private final zzs zzcw;

    @GuardedBy("this")
    private final Map<String, zzt> zzcx;
    private final Context zzz;

    public zzaq(Context context) {
        this(context, new zzs());
    }

    private zzaq(Context context, zzs zzsVar) {
        this.zzcx = new ArrayMap();
        this.zzz = context;
        this.zzcv = context.getSharedPreferences("com.google.android.gms.appid", 0);
        this.zzcw = zzsVar;
        File file = new File(ContextCompat.getNoBackupFilesDir(this.zzz), "com.google.android.gms.appid-no-backup");
        if (file.exists()) {
            return;
        }
        try {
            if (!file.createNewFile() || isEmpty()) {
                return;
            }
            Log.i("FirebaseInstanceId", "App restored, clearing state");
            zzaf();
            FirebaseInstanceId.getInstance().zzj();
        } catch (IOException e) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.d("FirebaseInstanceId", strValueOf.length() != 0 ? "Error creating file in no backup dir: ".concat(strValueOf) : new String("Error creating file in no backup dir: "));
            }
        }
    }

    private final synchronized boolean isEmpty() {
        return this.zzcv.getAll().isEmpty();
    }

    static String zzb(String str, String str2) {
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 3 + String.valueOf(str2).length());
        sb.append(str);
        sb.append("|S|");
        sb.append(str2);
        return sb.toString();
    }

    private static String zzb(String str, String str2, String str3) {
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 4 + String.valueOf(str2).length() + String.valueOf(str3).length());
        sb.append(str);
        sb.append("|T|");
        sb.append(str2);
        sb.append("|");
        sb.append(str3);
        return sb.toString();
    }

    public final synchronized void zza(String str, String str2, String str3, String str4, String str5) {
        String strZza = zzar.zza(str4, str5, System.currentTimeMillis());
        if (strZza == null) {
            return;
        }
        SharedPreferences.Editor editorEdit = this.zzcv.edit();
        editorEdit.putString(zzb(str, str2, str3), strZza);
        editorEdit.commit();
    }

    public final synchronized String zzae() {
        return this.zzcv.getString("topic_operaion_queue", "");
    }

    public final synchronized void zzaf() {
        this.zzcx.clear();
        zzs.zza(this.zzz);
        this.zzcv.edit().clear().commit();
    }

    public final synchronized zzar zzc(String str, String str2, String str3) {
        return zzar.zzi(this.zzcv.getString(zzb(str, str2, str3), null));
    }

    public final synchronized void zzd(String str, String str2, String str3) {
        String strZzb = zzb(str, str2, str3);
        SharedPreferences.Editor editorEdit = this.zzcv.edit();
        editorEdit.remove(strZzb);
        editorEdit.commit();
    }

    public final synchronized void zzf(String str) {
        this.zzcv.edit().putString("topic_operaion_queue", str).apply();
    }

    public final synchronized zzt zzg(String str) {
        zzt zztVarZzc;
        zzt zztVar = this.zzcx.get(str);
        if (zztVar != null) {
            return zztVar;
        }
        try {
            zztVarZzc = this.zzcw.zzb(this.zzz, str);
        } catch (zzu unused) {
            Log.w("FirebaseInstanceId", "Stored data is corrupt, generating new identity");
            FirebaseInstanceId.getInstance().zzj();
            zztVarZzc = this.zzcw.zzc(this.zzz, str);
        }
        this.zzcx.put(str, zztVarZzc);
        return zztVarZzc;
    }

    public final synchronized void zzh(String str) {
        String strConcat = String.valueOf(str).concat("|T|");
        SharedPreferences.Editor editorEdit = this.zzcv.edit();
        for (String str2 : this.zzcv.getAll().keySet()) {
            if (str2.startsWith(strConcat)) {
                editorEdit.remove(str2);
            }
        }
        editorEdit.commit();
    }
}
