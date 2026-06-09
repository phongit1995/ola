package com.mg.ola.common.d;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;

/* JADX INFO: loaded from: classes.dex */
public class g {
    @TargetApi(9)
    public static boolean a() {
        return Build.VERSION.SDK_INT >= 9;
    }

    public static boolean a(Context context) {
        try {
            return context.getPackageManager().hasSystemFeature("android.hardware.telephony");
        } catch (Throwable unused) {
            return false;
        }
    }

    @TargetApi(10)
    public static boolean b() {
        return Build.VERSION.SDK_INT >= 10;
    }

    @TargetApi(11)
    public static boolean c() {
        return Build.VERSION.SDK_INT >= 11;
    }

    @TargetApi(12)
    public static boolean d() {
        return Build.VERSION.SDK_INT >= 12;
    }

    @TargetApi(13)
    public static boolean e() {
        return Build.VERSION.SDK_INT >= 13;
    }

    @TargetApi(14)
    public static boolean f() {
        return Build.VERSION.SDK_INT >= 14;
    }

    @TargetApi(16)
    public static boolean g() {
        return Build.VERSION.SDK_INT >= 16;
    }

    @TargetApi(19)
    public static boolean h() {
        return Build.VERSION.SDK_INT >= 19;
    }
}
