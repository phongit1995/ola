package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.content.Context;
import com.google.android.gms.common.util.PlatformVersion;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@TargetApi(21)
@zzadh
final class zzaiw {
    private static final Map<String, String> zzcnl;
    private final List<String> zzcnm;
    private final zzaii zzcnn;
    private final Context zzrt;

    static {
        HashMap map = new HashMap();
        if (PlatformVersion.isAtLeastLollipop()) {
            map.put("android.webkit.resource.AUDIO_CAPTURE", "android.permission.RECORD_AUDIO");
            map.put("android.webkit.resource.VIDEO_CAPTURE", "android.permission.CAMERA");
        }
        zzcnl = map;
    }

    zzaiw(Context context, List<String> list, zzaii zzaiiVar) {
        this.zzrt = context;
        this.zzcnm = list;
        this.zzcnn = zzaiiVar;
    }

    final List<String> zzc(String[] strArr) {
        boolean z;
        boolean z2;
        String strValueOf;
        String strValueOf2;
        ArrayList arrayList = new ArrayList();
        for (String str : strArr) {
            Iterator<String> it2 = this.zzcnm.iterator();
            do {
                z = true;
                if (!it2.hasNext()) {
                    z2 = false;
                    break;
                }
                String next = it2.next();
                if (next.equals(str)) {
                    break;
                }
                strValueOf = String.valueOf("android.webkit.resource.");
                strValueOf2 = String.valueOf(next);
            } while (!(strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf)).equals(str));
            z2 = true;
            if (z2) {
                if (zzcnl.containsKey(str)) {
                    com.google.android.gms.ads.internal.zzbv.zzek();
                    if (!zzakk.zzl(this.zzrt, zzcnl.get(str))) {
                        z = false;
                    }
                }
                if (z) {
                    arrayList.add(str);
                } else {
                    this.zzcnn.zzch(str);
                }
            } else {
                this.zzcnn.zzcg(str);
            }
        }
        return arrayList;
    }
}
