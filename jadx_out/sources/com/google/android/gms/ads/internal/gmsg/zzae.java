package com.google.android.gms.ads.internal.gmsg;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.view.View;
import com.google.android.gms.ads.internal.zzbv;
import com.google.android.gms.common.util.CrashUtils;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.ads.zzci;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@VisibleForTesting
public final class zzae {
    private final Context mContext;
    private final View mView;
    private final zzci zzbne;

    public zzae(Context context, zzci zzciVar, View view) {
        this.mContext = context;
        this.zzbne = zzciVar;
        this.mView = view;
    }

    private static Intent zza(Intent intent, ResolveInfo resolveInfo) {
        Intent intent2 = new Intent(intent);
        intent2.setClassName(resolveInfo.activityInfo.packageName, resolveInfo.activityInfo.name);
        return intent2;
    }

    @VisibleForTesting
    private final ResolveInfo zza(Intent intent, ArrayList<ResolveInfo> arrayList) {
        ResolveInfo resolveInfo = null;
        try {
            PackageManager packageManager = this.mContext.getPackageManager();
            if (packageManager == null) {
                return null;
            }
            List<ResolveInfo> listQueryIntentActivities = packageManager.queryIntentActivities(intent, 65536);
            ResolveInfo resolveInfoResolveActivity = packageManager.resolveActivity(intent, 65536);
            if (listQueryIntentActivities != null && resolveInfoResolveActivity != null) {
                int i = 0;
                while (true) {
                    if (i >= listQueryIntentActivities.size()) {
                        break;
                    }
                    ResolveInfo resolveInfo2 = listQueryIntentActivities.get(i);
                    if (resolveInfoResolveActivity != null && resolveInfoResolveActivity.activityInfo.name.equals(resolveInfo2.activityInfo.name)) {
                        resolveInfo = resolveInfoResolveActivity;
                        break;
                    }
                    i++;
                }
            }
            arrayList.addAll(listQueryIntentActivities);
            return resolveInfo;
        } catch (Throwable th) {
            zzbv.zzeo().zza(th, "OpenSystemBrowserHandler.getDefaultBrowserResolverForIntent");
            return resolveInfo;
        }
    }

    @VisibleForTesting
    private final ResolveInfo zzb(Intent intent) {
        return zza(intent, new ArrayList<>());
    }

    private static Intent zze(Uri uri) {
        if (uri == null) {
            return null;
        }
        Intent intent = new Intent("android.intent.action.VIEW");
        intent.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        intent.setData(uri);
        intent.setAction("android.intent.action.VIEW");
        return intent;
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x0064  */
    /* JADX WARN: Removed duplicated region for block: B:21:0x00a2  */
    /* JADX WARN: Removed duplicated region for block: B:24:0x00b8  */
    /* JADX WARN: Removed duplicated region for block: B:26:0x00bd  */
    @com.google.android.gms.common.util.VisibleForTesting
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final android.content.Intent zzi(java.util.Map<java.lang.String, java.lang.String> r12) {
        /*
            Method dump skipped, instruction units count: 290
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.gmsg.zzae.zzi(java.util.Map):android.content.Intent");
    }
}
