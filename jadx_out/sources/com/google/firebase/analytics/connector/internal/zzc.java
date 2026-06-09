package com.google.firebase.analytics.connector.internal;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.util.ArrayUtils;
import com.google.android.gms.internal.measurement.zzkd;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.firebase.analytics.FirebaseAnalytics;
import com.google.firebase.analytics.connector.AnalyticsConnector;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzc {
    private static final List<String> zzbqm = Arrays.asList("_e", "_f", "_iap", "_s", "_au", "_ui", "_cd", FirebaseAnalytics.Event.APP_OPEN);
    private static final List<String> zzbqn = Arrays.asList("auto", "app", "am");
    private static final List<String> zzbqo = Arrays.asList("_r", "_dbg");
    private static final List<String> zzbqp = Arrays.asList((String[]) ArrayUtils.concat(AppMeasurement.UserProperty.zzada, AppMeasurement.UserProperty.zzadb));
    private static final List<String> zzbqq = Arrays.asList("^_ltv_[A-Z]{3}$", "^_cc[1-5]{1}$");

    public static boolean zza(AnalyticsConnector.ConditionalUserProperty conditionalUserProperty) {
        String str;
        if (conditionalUserProperty == null || (str = conditionalUserProperty.origin) == null || str.isEmpty()) {
            return false;
        }
        if ((conditionalUserProperty.value != null && zzkd.zzf(conditionalUserProperty.value) == null) || !zzff(str) || !zzw(str, conditionalUserProperty.name)) {
            return false;
        }
        if (conditionalUserProperty.expiredEventName != null && (!zza(conditionalUserProperty.expiredEventName, conditionalUserProperty.expiredEventParams) || !zzb(str, conditionalUserProperty.expiredEventName, conditionalUserProperty.expiredEventParams))) {
            return false;
        }
        if (conditionalUserProperty.triggeredEventName != null && (!zza(conditionalUserProperty.triggeredEventName, conditionalUserProperty.triggeredEventParams) || !zzb(str, conditionalUserProperty.triggeredEventName, conditionalUserProperty.triggeredEventParams))) {
            return false;
        }
        if (conditionalUserProperty.timedOutEventName != null) {
            return zza(conditionalUserProperty.timedOutEventName, conditionalUserProperty.timedOutEventParams) && zzb(str, conditionalUserProperty.timedOutEventName, conditionalUserProperty.timedOutEventParams);
        }
        return true;
    }

    public static boolean zza(@NonNull String str, @Nullable Bundle bundle) {
        if (zzbqm.contains(str)) {
            return false;
        }
        if (bundle == null) {
            return true;
        }
        Iterator<String> it2 = zzbqo.iterator();
        while (it2.hasNext()) {
            if (bundle.containsKey(it2.next())) {
                return false;
            }
        }
        return true;
    }

    public static AppMeasurement.ConditionalUserProperty zzb(AnalyticsConnector.ConditionalUserProperty conditionalUserProperty) {
        AppMeasurement.ConditionalUserProperty conditionalUserProperty2 = new AppMeasurement.ConditionalUserProperty();
        conditionalUserProperty2.mOrigin = conditionalUserProperty.origin;
        conditionalUserProperty2.mActive = conditionalUserProperty.active;
        conditionalUserProperty2.mCreationTimestamp = conditionalUserProperty.creationTimestamp;
        conditionalUserProperty2.mExpiredEventName = conditionalUserProperty.expiredEventName;
        if (conditionalUserProperty.expiredEventParams != null) {
            conditionalUserProperty2.mExpiredEventParams = new Bundle(conditionalUserProperty.expiredEventParams);
        }
        conditionalUserProperty2.mName = conditionalUserProperty.name;
        conditionalUserProperty2.mTimedOutEventName = conditionalUserProperty.timedOutEventName;
        if (conditionalUserProperty.timedOutEventParams != null) {
            conditionalUserProperty2.mTimedOutEventParams = new Bundle(conditionalUserProperty.timedOutEventParams);
        }
        conditionalUserProperty2.mTimeToLive = conditionalUserProperty.timeToLive;
        conditionalUserProperty2.mTriggeredEventName = conditionalUserProperty.triggeredEventName;
        if (conditionalUserProperty.triggeredEventParams != null) {
            conditionalUserProperty2.mTriggeredEventParams = new Bundle(conditionalUserProperty.triggeredEventParams);
        }
        conditionalUserProperty2.mTriggeredTimestamp = conditionalUserProperty.triggeredTimestamp;
        conditionalUserProperty2.mTriggerEventName = conditionalUserProperty.triggerEventName;
        conditionalUserProperty2.mTriggerTimeout = conditionalUserProperty.triggerTimeout;
        if (conditionalUserProperty.value != null) {
            conditionalUserProperty2.mValue = zzkd.zzf(conditionalUserProperty.value);
        }
        return conditionalUserProperty2;
    }

    /* JADX WARN: Removed duplicated region for block: B:32:0x0061  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static boolean zzb(@android.support.annotation.NonNull java.lang.String r4, @android.support.annotation.NonNull java.lang.String r5, @android.support.annotation.Nullable android.os.Bundle r6) {
        /*
            java.lang.String r0 = "_cmp"
            boolean r5 = r0.equals(r5)
            r0 = 1
            if (r5 != 0) goto La
            return r0
        La:
            boolean r5 = zzff(r4)
            r1 = 0
            if (r5 != 0) goto L12
            return r1
        L12:
            if (r6 != 0) goto L15
            return r1
        L15:
            java.util.List<java.lang.String> r5 = com.google.firebase.analytics.connector.internal.zzc.zzbqo
            java.util.Iterator r5 = r5.iterator()
        L1b:
            boolean r2 = r5.hasNext()
            if (r2 == 0) goto L2e
            java.lang.Object r2 = r5.next()
            java.lang.String r2 = (java.lang.String) r2
            boolean r2 = r6.containsKey(r2)
            if (r2 == 0) goto L1b
            return r1
        L2e:
            r5 = -1
            int r2 = r4.hashCode()
            r3 = 101200(0x18b50, float:1.41811E-40)
            if (r2 == r3) goto L57
            r3 = 101230(0x18b6e, float:1.41853E-40)
            if (r2 == r3) goto L4d
            r3 = 3142703(0x2ff42f, float:4.403865E-39)
            if (r2 == r3) goto L43
            goto L61
        L43:
            java.lang.String r2 = "fiam"
            boolean r4 = r4.equals(r2)
            if (r4 == 0) goto L61
            r4 = 2
            goto L62
        L4d:
            java.lang.String r2 = "fdl"
            boolean r4 = r4.equals(r2)
            if (r4 == 0) goto L61
            r4 = 1
            goto L62
        L57:
            java.lang.String r2 = "fcm"
            boolean r4 = r4.equals(r2)
            if (r4 == 0) goto L61
            r4 = 0
            goto L62
        L61:
            r4 = -1
        L62:
            switch(r4) {
                case 0: goto L73;
                case 1: goto L6e;
                case 2: goto L66;
                default: goto L65;
            }
        L65:
            return r1
        L66:
            java.lang.String r4 = "_cis"
            java.lang.String r5 = "fiam_integration"
        L6a:
            r6.putString(r4, r5)
            return r0
        L6e:
            java.lang.String r4 = "_cis"
            java.lang.String r5 = "fdl_integration"
            goto L6a
        L73:
            java.lang.String r4 = "_cis"
            java.lang.String r5 = "fcm_integration"
            goto L6a
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.firebase.analytics.connector.internal.zzc.zzb(java.lang.String, java.lang.String, android.os.Bundle):boolean");
    }

    public static AnalyticsConnector.ConditionalUserProperty zzd(AppMeasurement.ConditionalUserProperty conditionalUserProperty) {
        AnalyticsConnector.ConditionalUserProperty conditionalUserProperty2 = new AnalyticsConnector.ConditionalUserProperty();
        conditionalUserProperty2.origin = conditionalUserProperty.mOrigin;
        conditionalUserProperty2.active = conditionalUserProperty.mActive;
        conditionalUserProperty2.creationTimestamp = conditionalUserProperty.mCreationTimestamp;
        conditionalUserProperty2.expiredEventName = conditionalUserProperty.mExpiredEventName;
        if (conditionalUserProperty.mExpiredEventParams != null) {
            conditionalUserProperty2.expiredEventParams = new Bundle(conditionalUserProperty.mExpiredEventParams);
        }
        conditionalUserProperty2.name = conditionalUserProperty.mName;
        conditionalUserProperty2.timedOutEventName = conditionalUserProperty.mTimedOutEventName;
        if (conditionalUserProperty.mTimedOutEventParams != null) {
            conditionalUserProperty2.timedOutEventParams = new Bundle(conditionalUserProperty.mTimedOutEventParams);
        }
        conditionalUserProperty2.timeToLive = conditionalUserProperty.mTimeToLive;
        conditionalUserProperty2.triggeredEventName = conditionalUserProperty.mTriggeredEventName;
        if (conditionalUserProperty.mTriggeredEventParams != null) {
            conditionalUserProperty2.triggeredEventParams = new Bundle(conditionalUserProperty.mTriggeredEventParams);
        }
        conditionalUserProperty2.triggeredTimestamp = conditionalUserProperty.mTriggeredTimestamp;
        conditionalUserProperty2.triggerEventName = conditionalUserProperty.mTriggerEventName;
        conditionalUserProperty2.triggerTimeout = conditionalUserProperty.mTriggerTimeout;
        if (conditionalUserProperty.mValue != null) {
            conditionalUserProperty2.value = zzkd.zzf(conditionalUserProperty.mValue);
        }
        return conditionalUserProperty2;
    }

    public static boolean zzff(@NonNull String str) {
        return !zzbqn.contains(str);
    }

    public static boolean zzfg(String str) {
        if (str == null || str.length() == 0) {
            return false;
        }
        int iCodePointAt = str.codePointAt(0);
        if (!Character.isLetter(iCodePointAt)) {
            return false;
        }
        int length = str.length();
        int iCharCount = Character.charCount(iCodePointAt);
        while (iCharCount < length) {
            int iCodePointAt2 = str.codePointAt(iCharCount);
            if (iCodePointAt2 != 95 && !Character.isLetterOrDigit(iCodePointAt2)) {
                return false;
            }
            iCharCount += Character.charCount(iCodePointAt2);
        }
        return true;
    }

    public static boolean zzfh(String str) {
        if (str == null || str.length() == 0) {
            return false;
        }
        int iCodePointAt = str.codePointAt(0);
        if (!Character.isLetter(iCodePointAt) && iCodePointAt != 95) {
            return false;
        }
        int length = str.length();
        int iCharCount = Character.charCount(iCodePointAt);
        while (iCharCount < length) {
            int iCodePointAt2 = str.codePointAt(iCharCount);
            if (iCodePointAt2 != 95 && !Character.isLetterOrDigit(iCodePointAt2)) {
                return false;
            }
            iCharCount += Character.charCount(iCodePointAt2);
        }
        return true;
    }

    public static String zzfi(String str) {
        String strZzak = AppMeasurement.Event.zzak(str);
        return strZzak != null ? strZzak : str;
    }

    public static String zzfj(String str) {
        String strZzal = AppMeasurement.Event.zzal(str);
        return strZzal != null ? strZzal : str;
    }

    public static boolean zzw(@NonNull String str, @NonNull String str2) {
        if ("_ce1".equals(str2) || "_ce2".equals(str2)) {
            return str.equals(AppMeasurement.FCM_ORIGIN) || str.equals("frc");
        }
        if (AppMeasurement.UserProperty.FIREBASE_LAST_NOTIFICATION.equals(str2)) {
            return str.equals(AppMeasurement.FCM_ORIGIN);
        }
        if (zzbqp.contains(str2)) {
            return false;
        }
        Iterator<String> it2 = zzbqq.iterator();
        while (it2.hasNext()) {
            if (str2.matches(it2.next())) {
                return false;
            }
        }
        return true;
    }
}
