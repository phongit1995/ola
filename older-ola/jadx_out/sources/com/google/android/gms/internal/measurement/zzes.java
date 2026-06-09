package com.google.android.gms.internal.measurement;

import android.os.Bundle;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import java.util.Iterator;

/* JADX INFO: loaded from: classes2.dex */
public final class zzes {
    final String name;
    private final String origin;
    final long timestamp;
    final long zzahf;
    final zzeu zzahg;
    final String zzth;

    zzes(zzgn zzgnVar, String str, String str2, String str3, long j, long j2, Bundle bundle) {
        zzeu zzeuVar;
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotEmpty(str3);
        this.zzth = str2;
        this.name = str3;
        this.origin = TextUtils.isEmpty(str) ? null : str;
        this.timestamp = j;
        this.zzahf = j2;
        if (this.zzahf != 0 && this.zzahf > this.timestamp) {
            zzgnVar.zzgi().zziy().zzg("Event created with reverse previous/current timestamps. appId", zzfi.zzbp(str2));
        }
        if (bundle == null || bundle.isEmpty()) {
            zzeuVar = new zzeu(new Bundle());
        } else {
            Bundle bundle2 = new Bundle(bundle);
            Iterator<String> it2 = bundle2.keySet().iterator();
            while (it2.hasNext()) {
                String next = it2.next();
                if (next == null) {
                    zzgnVar.zzgi().zziv().log("Param name can't be null");
                } else {
                    Object objZzh = zzgnVar.zzgg().zzh(next, bundle2.get(next));
                    if (objZzh == null) {
                        zzgnVar.zzgi().zziy().zzg("Param value can't be null", zzgnVar.zzgf().zzbn(next));
                    } else {
                        zzgnVar.zzgg().zza(bundle2, next, objZzh);
                    }
                }
                it2.remove();
            }
            zzeuVar = new zzeu(bundle2);
        }
        this.zzahg = zzeuVar;
    }

    private zzes(zzgn zzgnVar, String str, String str2, String str3, long j, long j2, zzeu zzeuVar) {
        Preconditions.checkNotEmpty(str2);
        Preconditions.checkNotEmpty(str3);
        Preconditions.checkNotNull(zzeuVar);
        this.zzth = str2;
        this.name = str3;
        this.origin = TextUtils.isEmpty(str) ? null : str;
        this.timestamp = j;
        this.zzahf = j2;
        if (this.zzahf != 0 && this.zzahf > this.timestamp) {
            zzgnVar.zzgi().zziy().zze("Event created with reverse previous/current timestamps. appId, name", zzfi.zzbp(str2), zzfi.zzbp(str3));
        }
        this.zzahg = zzeuVar;
    }

    public final String toString() {
        String str = this.zzth;
        String str2 = this.name;
        String strValueOf = String.valueOf(this.zzahg);
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 33 + String.valueOf(str2).length() + String.valueOf(strValueOf).length());
        sb.append("Event{appId='");
        sb.append(str);
        sb.append("', name='");
        sb.append(str2);
        sb.append("', params=");
        sb.append(strValueOf);
        sb.append('}');
        return sb.toString();
    }

    final zzes zza(zzgn zzgnVar, long j) {
        return new zzes(zzgnVar, this.origin, this.zzth, this.name, this.timestamp, j, this.zzahg);
    }
}
