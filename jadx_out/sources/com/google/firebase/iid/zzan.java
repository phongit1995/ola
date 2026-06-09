package com.google.firebase.iid;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.Parcelable;
import android.support.v4.util.SimpleArrayMap;
import android.util.Log;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.iid.zzi;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes2.dex */
final class zzan {
    private static int zzby;
    private static PendingIntent zzck;
    private final zzah zzao;

    @GuardedBy("responseCallbacks")
    private final SimpleArrayMap<String, TaskCompletionSource<Bundle>> zzcl = new SimpleArrayMap<>();
    private Messenger zzcm = new Messenger(new zzao(this, Looper.getMainLooper()));
    private Messenger zzcn;
    private zzi zzco;
    private final Context zzz;

    public zzan(Context context, zzah zzahVar) {
        this.zzz = context;
        this.zzao = zzahVar;
    }

    private static synchronized void zza(Context context, Intent intent) {
        if (zzck == null) {
            Intent intent2 = new Intent();
            intent2.setPackage("com.google.example.invalidpackage");
            zzck = PendingIntent.getBroadcast(context, 0, intent2, 0);
        }
        intent.putExtra("app", zzck);
    }

    private final void zza(String str, Bundle bundle) {
        synchronized (this.zzcl) {
            TaskCompletionSource<Bundle> taskCompletionSourceRemove = this.zzcl.remove(str);
            if (taskCompletionSourceRemove != null) {
                taskCompletionSourceRemove.setResult(bundle);
            } else {
                String strValueOf = String.valueOf(str);
                Log.w("FirebaseInstanceId", strValueOf.length() != 0 ? "Missing callback for ".concat(strValueOf) : new String("Missing callback for "));
            }
        }
    }

    private static synchronized String zzab() {
        int i;
        i = zzby;
        zzby = i + 1;
        return Integer.toString(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzb(Message message) {
        String str;
        String strConcat;
        if (message == null || !(message.obj instanceof Intent)) {
            str = "FirebaseInstanceId";
            strConcat = "Dropping invalid message";
        } else {
            Intent intent = (Intent) message.obj;
            intent.setExtrasClassLoader(new zzi.zza());
            if (intent.hasExtra("google.messenger")) {
                Parcelable parcelableExtra = intent.getParcelableExtra("google.messenger");
                if (parcelableExtra instanceof zzi) {
                    this.zzco = (zzi) parcelableExtra;
                }
                if (parcelableExtra instanceof Messenger) {
                    this.zzcn = (Messenger) parcelableExtra;
                }
            }
            Intent intent2 = (Intent) message.obj;
            String action = intent2.getAction();
            if (!"com.google.android.c2dm.intent.REGISTRATION".equals(action)) {
                if (Log.isLoggable("FirebaseInstanceId", 3)) {
                    String strValueOf = String.valueOf(action);
                    Log.d("FirebaseInstanceId", strValueOf.length() != 0 ? "Unexpected response action: ".concat(strValueOf) : new String("Unexpected response action: "));
                    return;
                }
                return;
            }
            String stringExtra = intent2.getStringExtra("registration_id");
            if (stringExtra == null) {
                stringExtra = intent2.getStringExtra("unregistered");
            }
            if (stringExtra != null) {
                Matcher matcher = Pattern.compile("\\|ID\\|([^|]+)\\|:?+(.*)").matcher(stringExtra);
                if (!matcher.matches()) {
                    if (Log.isLoggable("FirebaseInstanceId", 3)) {
                        String strValueOf2 = String.valueOf(stringExtra);
                        Log.d("FirebaseInstanceId", strValueOf2.length() != 0 ? "Unexpected response string: ".concat(strValueOf2) : new String("Unexpected response string: "));
                        return;
                    }
                    return;
                }
                String strGroup = matcher.group(1);
                String strGroup2 = matcher.group(2);
                Bundle extras = intent2.getExtras();
                extras.putString("registration_id", strGroup2);
                zza(strGroup, extras);
                return;
            }
            String stringExtra2 = intent2.getStringExtra("error");
            if (stringExtra2 == null) {
                String strValueOf3 = String.valueOf(intent2.getExtras());
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf3).length() + 49);
                sb.append("Unexpected response, no error or registration id ");
                sb.append(strValueOf3);
                Log.w("FirebaseInstanceId", sb.toString());
                return;
            }
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf4 = String.valueOf(stringExtra2);
                Log.d("FirebaseInstanceId", strValueOf4.length() != 0 ? "Received InstanceID error ".concat(strValueOf4) : new String("Received InstanceID error "));
            }
            if (!stringExtra2.startsWith("|")) {
                synchronized (this.zzcl) {
                    for (int i = 0; i < this.zzcl.size(); i++) {
                        zza(this.zzcl.keyAt(i), intent2.getExtras());
                    }
                }
                return;
            }
            String[] strArrSplit = stringExtra2.split("\\|");
            if (strArrSplit.length > 2 && "ID".equals(strArrSplit[1])) {
                String str2 = strArrSplit[2];
                String strSubstring = strArrSplit[3];
                if (strSubstring.startsWith(":")) {
                    strSubstring = strSubstring.substring(1);
                }
                zza(str2, intent2.putExtra("error", strSubstring).getExtras());
                return;
            }
            str = "FirebaseInstanceId";
            String strValueOf5 = String.valueOf(stringExtra2);
            strConcat = strValueOf5.length() != 0 ? "Unexpected structured response ".concat(strValueOf5) : new String("Unexpected structured response ");
        }
        Log.w(str, strConcat);
    }

    private final Bundle zzd(Bundle bundle) throws IOException {
        Bundle bundleZze = zze(bundle);
        if (bundleZze == null || !bundleZze.containsKey("google.messenger")) {
            return bundleZze;
        }
        Bundle bundleZze2 = zze(bundle);
        if (bundleZze2 == null || !bundleZze2.containsKey("google.messenger")) {
            return bundleZze2;
        }
        return null;
    }

    /* JADX WARN: Removed duplicated region for block: B:33:0x00d8  */
    /* JADX WARN: Removed duplicated region for block: B:34:0x00de  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final android.os.Bundle zze(android.os.Bundle r9) throws java.io.IOException {
        /*
            Method dump skipped, instruction units count: 294
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.firebase.iid.zzan.zze(android.os.Bundle):android.os.Bundle");
    }

    final Bundle zzc(Bundle bundle) {
        if (this.zzao.zzz() < 12000000) {
            return zzd(bundle);
        }
        try {
            return (Bundle) Tasks.await(zzv.zzc(this.zzz).zzb(1, bundle));
        } catch (InterruptedException | ExecutionException e) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf = String.valueOf(e);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 22);
                sb.append("Error making request: ");
                sb.append(strValueOf);
                Log.d("FirebaseInstanceId", sb.toString());
            }
            if ((e.getCause() instanceof zzaf) && ((zzaf) e.getCause()).getErrorCode() == 4) {
                return zzd(bundle);
            }
            return null;
        }
    }
}
