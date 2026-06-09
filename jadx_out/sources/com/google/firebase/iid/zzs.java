package com.google.firebase.iid;

import android.content.Context;
import android.content.SharedPreferences;
import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Properties;

/* JADX INFO: loaded from: classes2.dex */
final class zzs {
    zzs() {
    }

    @Nullable
    private static zzt zza(SharedPreferences sharedPreferences, String str) {
        String string = sharedPreferences.getString(zzaq.zzb(str, "|P|"), null);
        String string2 = sharedPreferences.getString(zzaq.zzb(str, "|K|"), null);
        if (string == null || string2 == null) {
            return null;
        }
        return new zzt(zza(string, string2), zzb(sharedPreferences, str));
    }

    @Nullable
    private static zzt zza(File file) throws IOException {
        FileInputStream fileInputStream = new FileInputStream(file);
        try {
            Properties properties = new Properties();
            properties.load(fileInputStream);
            String property = properties.getProperty("pub");
            String property2 = properties.getProperty("pri");
            if (property != null && property2 != null) {
                try {
                    return new zzt(zza(property, property2), Long.parseLong(properties.getProperty("cre")));
                } catch (NumberFormatException e) {
                    throw new zzu(e);
                }
            }
            return null;
        } finally {
            zza((Throwable) null, fileInputStream);
        }
    }

    private static KeyPair zza(String str, String str2) throws zzu {
        try {
            byte[] bArrDecode = Base64.decode(str, 8);
            byte[] bArrDecode2 = Base64.decode(str2, 8);
            try {
                KeyFactory keyFactory = KeyFactory.getInstance("RSA");
                return new KeyPair(keyFactory.generatePublic(new X509EncodedKeySpec(bArrDecode)), keyFactory.generatePrivate(new PKCS8EncodedKeySpec(bArrDecode2)));
            } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
                String strValueOf = String.valueOf(e);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 19);
                sb.append("Invalid key stored ");
                sb.append(strValueOf);
                Log.w("FirebaseInstanceId", sb.toString());
                throw new zzu(e);
            }
        } catch (IllegalArgumentException e2) {
            throw new zzu(e2);
        }
    }

    static void zza(Context context) {
        for (File file : zzb(context).listFiles()) {
            if (file.getName().startsWith("com.google.InstanceId")) {
                file.delete();
            }
        }
    }

    private static void zza(Context context, String str, zzt zztVar) {
        try {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                Log.d("FirebaseInstanceId", "Writing key to properties file");
            }
            File fileZzf = zzf(context, str);
            fileZzf.createNewFile();
            Properties properties = new Properties();
            properties.setProperty("pub", zztVar.zzp());
            properties.setProperty("pri", zztVar.zzq());
            properties.setProperty("cre", String.valueOf(zztVar.zzbl));
            FileOutputStream fileOutputStream = new FileOutputStream(fileZzf);
            Throwable th = null;
            try {
                properties.store(fileOutputStream, (String) null);
            } finally {
                zza(th, fileOutputStream);
            }
        } catch (IOException e) {
            String strValueOf = String.valueOf(e);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 21);
            sb.append("Failed to write key: ");
            sb.append(strValueOf);
            Log.w("FirebaseInstanceId", sb.toString());
        }
    }

    private static /* synthetic */ void zza(Throwable th, FileInputStream fileInputStream) throws IOException {
        if (th == null) {
            fileInputStream.close();
            return;
        }
        try {
            fileInputStream.close();
        } catch (Throwable th2) {
            com.google.android.gms.internal.firebase_messaging.zzh.zza(th, th2);
        }
    }

    private static /* synthetic */ void zza(Throwable th, FileOutputStream fileOutputStream) throws IOException {
        if (th == null) {
            fileOutputStream.close();
            return;
        }
        try {
            fileOutputStream.close();
        } catch (Throwable th2) {
            com.google.android.gms.internal.firebase_messaging.zzh.zza(th, th2);
        }
    }

    private static long zzb(SharedPreferences sharedPreferences, String str) {
        String string = sharedPreferences.getString(zzaq.zzb(str, "cre"), null);
        if (string == null) {
            return 0L;
        }
        try {
            return Long.parseLong(string);
        } catch (NumberFormatException unused) {
            return 0L;
        }
    }

    private static File zzb(Context context) {
        File noBackupFilesDir = ContextCompat.getNoBackupFilesDir(context);
        if (noBackupFilesDir != null && noBackupFilesDir.isDirectory()) {
            return noBackupFilesDir;
        }
        Log.w("FirebaseInstanceId", "noBackupFilesDir doesn't exist, using regular files directory instead");
        return context.getFilesDir();
    }

    private final void zzb(Context context, String str, zzt zztVar) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("com.google.android.gms.appid", 0);
        try {
            if (zztVar.equals(zza(sharedPreferences, str))) {
                return;
            }
        } catch (zzu unused) {
        }
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            Log.d("FirebaseInstanceId", "Writing key to shared preferences");
        }
        SharedPreferences.Editor editorEdit = sharedPreferences.edit();
        editorEdit.putString(zzaq.zzb(str, "|P|"), zztVar.zzp());
        editorEdit.putString(zzaq.zzb(str, "|K|"), zztVar.zzq());
        editorEdit.putString(zzaq.zzb(str, "cre"), String.valueOf(zztVar.zzbl));
        editorEdit.commit();
    }

    @Nullable
    private final zzt zzd(Context context, String str) throws zzu {
        try {
            zzt zztVarZze = zze(context, str);
            if (zztVarZze != null) {
                zzb(context, str, zztVarZze);
                return zztVarZze;
            }
            e = null;
        } catch (zzu e) {
            e = e;
        }
        try {
            zzt zztVarZza = zza(context.getSharedPreferences("com.google.android.gms.appid", 0), str);
            if (zztVarZza != null) {
                zza(context, str, zztVarZza);
                return zztVarZza;
            }
        } catch (zzu e2) {
            e = e2;
        }
        if (e != null) {
            throw e;
        }
        return null;
    }

    @Nullable
    private final zzt zze(Context context, String str) throws zzu {
        File fileZzf = zzf(context, str);
        if (!fileZzf.exists()) {
            return null;
        }
        try {
            return zza(fileZzf);
        } catch (IOException e) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf = String.valueOf(e);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 40);
                sb.append("Failed to read key from file, retrying: ");
                sb.append(strValueOf);
                Log.d("FirebaseInstanceId", sb.toString());
            }
            try {
                return zza(fileZzf);
            } catch (IOException e2) {
                String strValueOf2 = String.valueOf(e2);
                StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf2).length() + 45);
                sb2.append("IID file exists, but failed to read from it: ");
                sb2.append(strValueOf2);
                Log.w("FirebaseInstanceId", sb2.toString());
                throw new zzu(e2);
            }
        }
    }

    private static File zzf(Context context, String str) {
        String string;
        if (TextUtils.isEmpty(str)) {
            string = "com.google.InstanceId.properties";
        } else {
            try {
                String strEncodeToString = Base64.encodeToString(str.getBytes("UTF-8"), 11);
                StringBuilder sb = new StringBuilder(String.valueOf(strEncodeToString).length() + 33);
                sb.append("com.google.InstanceId_");
                sb.append(strEncodeToString);
                sb.append(".properties");
                string = sb.toString();
            } catch (UnsupportedEncodingException e) {
                throw new AssertionError(e);
            }
        }
        return new File(zzb(context), string);
    }

    @WorkerThread
    final zzt zzb(Context context, String str) throws zzu {
        zzt zztVarZzd = zzd(context, str);
        return zztVarZzd != null ? zztVarZzd : zzc(context, str);
    }

    @WorkerThread
    final zzt zzc(Context context, String str) {
        zzt zztVar = new zzt(zza.zzb(), System.currentTimeMillis());
        try {
            zzt zztVarZzd = zzd(context, str);
            if (zztVarZzd != null) {
                if (Log.isLoggable("FirebaseInstanceId", 3)) {
                    Log.d("FirebaseInstanceId", "Loaded key after generating new one, using loaded one");
                }
                return zztVarZzd;
            }
        } catch (zzu unused) {
        }
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            Log.d("FirebaseInstanceId", "Generated new key");
        }
        zza(context, str, zztVar);
        zzb(context, str, zztVar);
        return zztVar;
    }
}
