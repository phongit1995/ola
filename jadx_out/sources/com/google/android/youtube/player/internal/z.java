package com.google.android.youtube.player.internal;

import android.R;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Build;
import com.facebook.internal.AnalyticsEvents;
import com.google.android.gms.common.util.DeviceProperties;

/* JADX INFO: loaded from: classes2.dex */
public final class z {
    private static final Uri a = Uri.parse("http://play.google.com/store/apps/details");

    public static int a(Context context, Context context2) {
        int identifier = context2 != null ? context2.getResources().getIdentifier("clientTheme", AnalyticsEvents.PARAMETER_LIKE_VIEW_STYLE, a(context)) : 0;
        return identifier == 0 ? Build.VERSION.SDK_INT >= 14 ? R.style.Theme.DeviceDefault : Build.VERSION.SDK_INT >= 11 ? R.style.Theme.Holo : R.style.Theme : identifier;
    }

    public static Intent a(String str) {
        Uri uriFromParts = Uri.fromParts("package", str, null);
        Intent intent = new Intent("android.settings.APPLICATION_DETAILS_SETTINGS");
        intent.setData(uriFromParts);
        return intent;
    }

    public static String a(Context context) {
        Intent intent = new Intent("com.google.android.youtube.api.service.START");
        PackageManager packageManager = context.getPackageManager();
        ResolveInfo resolveInfoResolveService = packageManager.resolveService(intent, 0);
        return (resolveInfoResolveService == null || resolveInfoResolveService.serviceInfo == null || resolveInfoResolveService.serviceInfo.packageName == null) ? packageManager.hasSystemFeature(DeviceProperties.FEATURE_TV_1) ? "com.google.android.youtube.googletv" : "com.google.android.youtube" : resolveInfoResolveService.serviceInfo.packageName;
    }

    public static boolean a(Context context, String str) {
        try {
            Resources resourcesForApplication = context.getPackageManager().getResourcesForApplication(str);
            if (str.equals("com.google.android.youtube.googletvdev")) {
                str = "com.google.android.youtube.googletv";
            }
            int identifier = resourcesForApplication.getIdentifier("youtube_api_version_code", "integer", str);
            return identifier == 0 || 1000 > resourcesForApplication.getInteger(identifier);
        } catch (PackageManager.NameNotFoundException unused) {
            return true;
        }
    }

    public static boolean a(PackageManager packageManager) {
        return packageManager.hasSystemFeature(DeviceProperties.FEATURE_TV_1);
    }

    public static Context b(Context context) {
        try {
            return context.createPackageContext(a(context), 3);
        } catch (PackageManager.NameNotFoundException unused) {
            return null;
        }
    }

    public static Intent b(String str) {
        Intent intent = new Intent("android.intent.action.VIEW");
        intent.setData(a.buildUpon().appendQueryParameter("id", str).build());
        intent.setPackage("com.android.vending");
        intent.addFlags(524288);
        return intent;
    }

    public static int c(Context context) {
        return a(context, b(context));
    }

    public static String d(Context context) {
        try {
            return context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionName;
        } catch (PackageManager.NameNotFoundException e) {
            throw new IllegalStateException("Cannot retrieve calling Context's PackageInfo", e);
        }
    }
}
