package com.google.android.gms.internal.ads;

import android.R;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.ActivityManager;
import android.app.AlertDialog;
import android.app.KeyguardManager;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.ResolveInfo;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Debug;
import android.os.Handler;
import android.os.Looper;
import android.os.PowerManager;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.customtabs.CustomTabsIntent;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.Window;
import android.view.WindowManager;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.AdapterView;
import android.widget.PopupWindow;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.google.android.gms.ads.AdActivity;
import com.google.android.gms.common.util.CrashUtils;
import com.google.android.gms.common.util.IOUtils;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.Wrappers;
import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.regex.Pattern;
import javax.annotation.concurrent.GuardedBy;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzakk {
    public static final Handler zzcrm = new zzakc(Looper.getMainLooper());

    @GuardedBy("mLock")
    private String zzcpq;

    @GuardedBy("this")
    private Pattern zzcrq;

    @GuardedBy("this")
    private Pattern zzcrr;
    private final Object mLock = new Object();
    private boolean zzcrn = true;
    private boolean zzcro = false;
    private boolean zzcrp = false;

    @VisibleForTesting
    public static Bundle zza(zzgk zzgkVar) {
        String strZzqv;
        String strZzqx;
        String strZzgo;
        if (zzgkVar == null) {
            return null;
        }
        if (!((Boolean) zzkb.zzik().zzd(zznk.zzawq)).booleanValue()) {
            if (!((Boolean) zzkb.zzik().zzd(zznk.zzaws)).booleanValue()) {
                return null;
            }
        }
        if (com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzqu() && com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzqw()) {
            return null;
        }
        if (zzgkVar.zzha()) {
            zzgkVar.wakeup();
        }
        zzge zzgeVarZzgy = zzgkVar.zzgy();
        if (zzgeVarZzgy != null) {
            strZzqv = zzgeVarZzgy.getSignature();
            strZzgo = zzgeVarZzgy.zzgo();
            strZzqx = zzgeVarZzgy.zzgp();
            if (strZzqv != null) {
                com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzcn(strZzqv);
            }
            if (strZzqx != null) {
                com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzco(strZzqx);
            }
        } else {
            strZzqv = com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzqv();
            strZzqx = com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzqx();
            strZzgo = null;
        }
        Bundle bundle = new Bundle(1);
        if (strZzqx != null) {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzaws)).booleanValue() && !com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzqw()) {
                bundle.putString("v_fp_vertical", strZzqx);
            }
        }
        if (strZzqv != null) {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzawq)).booleanValue() && !com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zzqu()) {
                bundle.putString("fingerprint", strZzqv);
                if (!strZzqv.equals(strZzgo)) {
                    bundle.putString("v_fp", strZzgo);
                }
            }
        }
        if (bundle.isEmpty()) {
            return null;
        }
        return bundle;
    }

    public static DisplayMetrics zza(WindowManager windowManager) {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        windowManager.getDefaultDisplay().getMetrics(displayMetrics);
        return displayMetrics;
    }

    public static PopupWindow zza(View view, int i, int i2, boolean z) {
        return new PopupWindow(view, i, i2, false);
    }

    public static String zza(Context context, View view, zzjn zzjnVar) {
        if (!((Boolean) zzkb.zzik().zzd(zznk.zzaxi)).booleanValue()) {
            return null;
        }
        try {
            JSONObject jSONObject = new JSONObject();
            JSONObject jSONObject2 = new JSONObject();
            jSONObject2.put("width", zzjnVar.width);
            jSONObject2.put("height", zzjnVar.height);
            jSONObject.put("size", jSONObject2);
            jSONObject.put("activity", zzap(context));
            if (!zzjnVar.zzarc) {
                JSONArray jSONArray = new JSONArray();
                while (view != null) {
                    Object parent = view.getParent();
                    if (parent != null) {
                        int iIndexOfChild = parent instanceof ViewGroup ? ((ViewGroup) parent).indexOfChild(view) : -1;
                        JSONObject jSONObject3 = new JSONObject();
                        jSONObject3.put("type", parent.getClass().getName());
                        jSONObject3.put("index_of_child", iIndexOfChild);
                        jSONArray.put(jSONObject3);
                    }
                    view = (parent == null || !(parent instanceof View)) ? null : (View) parent;
                }
                if (jSONArray.length() > 0) {
                    jSONObject.put("parents", jSONArray);
                }
            }
            return jSONObject.toString();
        } catch (JSONException e) {
            zzakb.zzc("Fail to get view hierarchy json", e);
            return null;
        }
    }

    public static String zza(InputStreamReader inputStreamReader) {
        StringBuilder sb = new StringBuilder(8192);
        char[] cArr = new char[2048];
        while (true) {
            int i = inputStreamReader.read(cArr);
            if (i == -1) {
                return sb.toString();
            }
            sb.append(cArr, 0, i);
        }
    }

    private final JSONArray zza(Collection<?> collection) throws JSONException {
        JSONArray jSONArray = new JSONArray();
        Iterator<?> it2 = collection.iterator();
        while (it2.hasNext()) {
            zza(jSONArray, it2.next());
        }
        return jSONArray;
    }

    public static void zza(Context context, Intent intent) {
        try {
            context.startActivity(intent);
        } catch (Throwable unused) {
            intent.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            context.startActivity(intent);
        }
    }

    @TargetApi(18)
    public static void zza(Context context, Uri uri) {
        try {
            Intent intent = new Intent("android.intent.action.VIEW", uri);
            Bundle bundle = new Bundle();
            intent.putExtras(bundle);
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbdy)).booleanValue()) {
                zzb(context, intent);
            }
            bundle.putString("com.android.browser.application_id", context.getPackageName());
            context.startActivity(intent);
            String string = uri.toString();
            StringBuilder sb = new StringBuilder(String.valueOf(string).length() + 26);
            sb.append("Opening ");
            sb.append(string);
            sb.append(" in a new browser.");
            zzakb.zzck(sb.toString());
        } catch (ActivityNotFoundException e) {
            zzakb.zzb("No browser is found.", e);
        }
    }

    public static void zza(Context context, String str, List<String> list) {
        Iterator<String> it2 = list.iterator();
        while (it2.hasNext()) {
            new zzami(context, str, it2.next()).zznt();
        }
    }

    public static void zza(Context context, Throwable th) {
        if (context == null) {
            return;
        }
        boolean zBooleanValue = false;
        try {
            zBooleanValue = ((Boolean) zzkb.zzik().zzd(zznk.zzaui)).booleanValue();
        } catch (IllegalStateException unused) {
        }
        if (zBooleanValue) {
            CrashUtils.addDynamiteErrorToDropBox(context, th);
        }
    }

    private final void zza(JSONArray jSONArray, Object obj) throws JSONException {
        Object objZza;
        if (obj instanceof Bundle) {
            objZza = zzf((Bundle) obj);
        } else if (obj instanceof Map) {
            objZza = zzn((Map) obj);
        } else {
            if (!(obj instanceof Collection)) {
                if (!(obj instanceof Object[])) {
                    jSONArray.put(obj);
                    return;
                }
                JSONArray jSONArray2 = new JSONArray();
                for (Object obj2 : (Object[]) obj) {
                    zza(jSONArray2, obj2);
                }
                jSONArray.put(jSONArray2);
                return;
            }
            objZza = zza((Collection<?>) obj);
        }
        jSONArray.put(objZza);
    }

    private final void zza(JSONObject jSONObject, String str, Object obj) throws JSONException {
        Collection<?> collectionAsList;
        Object objZza;
        if (obj instanceof Bundle) {
            objZza = zzf((Bundle) obj);
        } else if (obj instanceof Map) {
            objZza = zzn((Map) obj);
        } else {
            if (obj instanceof Collection) {
                if (str == null) {
                    str = "null";
                }
                collectionAsList = (Collection) obj;
            } else {
                if (!(obj instanceof Object[])) {
                    jSONObject.put(str, obj);
                    return;
                }
                collectionAsList = Arrays.asList((Object[]) obj);
            }
            objZza = zza(collectionAsList);
        }
        jSONObject.put(str, objZza);
    }

    @TargetApi(24)
    public static boolean zza(Activity activity, Configuration configuration) {
        zzkb.zzif();
        int iZza = zzamu.zza(activity, configuration.screenHeightDp);
        int iZza2 = zzamu.zza(activity, configuration.screenWidthDp);
        DisplayMetrics displayMetricsZza = zza((WindowManager) activity.getApplicationContext().getSystemService("window"));
        int i = displayMetricsZza.heightPixels;
        int i2 = displayMetricsZza.widthPixels;
        int identifier = activity.getResources().getIdentifier("status_bar_height", "dimen", AccountKitGraphConstants.SDK_TYPE_ANDROID);
        int dimensionPixelSize = identifier > 0 ? activity.getResources().getDimensionPixelSize(identifier) : 0;
        int iRound = ((int) Math.round(((double) activity.getResources().getDisplayMetrics().density) + 0.5d)) * ((Integer) zzkb.zzik().zzd(zznk.zzbek)).intValue();
        return zzb(i, iZza + dimensionPixelSize, iRound) && zzb(i2, iZza2, iRound);
    }

    public static boolean zza(ClassLoader classLoader, Class<?> cls, String str) {
        try {
            return cls.isAssignableFrom(Class.forName(str, false, classLoader));
        } catch (Throwable unused) {
            return false;
        }
    }

    public static boolean zzaj(Context context) {
        String str;
        boolean z;
        Intent intent = new Intent();
        intent.setClassName(context, AdActivity.CLASS_NAME);
        try {
            ResolveInfo resolveInfoResolveActivity = context.getPackageManager().resolveActivity(intent, 65536);
            if (resolveInfoResolveActivity == null || resolveInfoResolveActivity.activityInfo == null) {
                str = "Could not find com.google.android.gms.ads.AdActivity, please make sure it is declared in AndroidManifest.xml.";
            } else {
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 16) == 0) {
                    zzakb.zzdk(String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "keyboard"));
                    z = false;
                } else {
                    z = true;
                }
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 32) == 0) {
                    zzakb.zzdk(String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "keyboardHidden"));
                    z = false;
                }
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 128) == 0) {
                    zzakb.zzdk(String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "orientation"));
                    z = false;
                }
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 256) == 0) {
                    zzakb.zzdk(String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "screenLayout"));
                    z = false;
                }
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 512) == 0) {
                    zzakb.zzdk(String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "uiMode"));
                    z = false;
                }
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 1024) == 0) {
                    zzakb.zzdk(String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "screenSize"));
                    z = false;
                }
                if ((resolveInfoResolveActivity.activityInfo.configChanges & 2048) != 0) {
                    return z;
                }
                str = String.format("com.google.android.gms.ads.AdActivity requires the android:configChanges value to contain \"%s\".", "smallestScreenSize");
            }
            zzakb.zzdk(str);
            return false;
        } catch (Exception e) {
            zzakb.zzc("Could not verify that com.google.android.gms.ads.AdActivity is declared in AndroidManifest.xml", e);
            com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "AdUtil.hasAdActivity");
            return false;
        }
    }

    @VisibleForTesting
    protected static String zzam(Context context) {
        try {
            return new WebView(context).getSettings().getUserAgentString();
        } catch (Throwable unused) {
            return zzrg();
        }
    }

    public static AlertDialog.Builder zzan(Context context) {
        return new AlertDialog.Builder(context);
    }

    public static zzmw zzao(Context context) {
        return new zzmw(context);
    }

    private static String zzap(Context context) {
        List<ActivityManager.RunningTaskInfo> runningTasks;
        ActivityManager.RunningTaskInfo runningTaskInfo;
        try {
            ActivityManager activityManager = (ActivityManager) context.getSystemService("activity");
            if (activityManager != null && (runningTasks = activityManager.getRunningTasks(1)) != null && !runningTasks.isEmpty() && (runningTaskInfo = runningTasks.get(0)) != null && runningTaskInfo.topActivity != null) {
                return runningTaskInfo.topActivity.getClassName();
            }
        } catch (Exception unused) {
        }
        return null;
    }

    /* JADX WARN: Code restructure failed: missing block: B:16:0x0039, code lost:
    
        if (r3.importance != 100) goto L26;
     */
    /* JADX WARN: Code restructure failed: missing block: B:18:0x003f, code lost:
    
        if (r2.inKeyguardRestrictedInputMode() != false) goto L26;
     */
    /* JADX WARN: Code restructure failed: missing block: B:19:0x0041, code lost:
    
        r6 = (android.os.PowerManager) r6.getSystemService("power");
     */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x0049, code lost:
    
        if (r6 != null) goto L22;
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x004b, code lost:
    
        r6 = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:22:0x004d, code lost:
    
        r6 = r6.isScreenOn();
     */
    /* JADX WARN: Code restructure failed: missing block: B:23:0x0051, code lost:
    
        if (r6 == false) goto L26;
     */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x0053, code lost:
    
        return true;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static boolean zzaq(android.content.Context r6) {
        /*
            r0 = 0
            java.lang.String r1 = "activity"
            java.lang.Object r1 = r6.getSystemService(r1)     // Catch: java.lang.Throwable -> L55
            android.app.ActivityManager r1 = (android.app.ActivityManager) r1     // Catch: java.lang.Throwable -> L55
            java.lang.String r2 = "keyguard"
            java.lang.Object r2 = r6.getSystemService(r2)     // Catch: java.lang.Throwable -> L55
            android.app.KeyguardManager r2 = (android.app.KeyguardManager) r2     // Catch: java.lang.Throwable -> L55
            if (r1 == 0) goto L55
            if (r2 != 0) goto L16
            return r0
        L16:
            java.util.List r1 = r1.getRunningAppProcesses()     // Catch: java.lang.Throwable -> L55
            if (r1 != 0) goto L1d
            return r0
        L1d:
            java.util.Iterator r1 = r1.iterator()     // Catch: java.lang.Throwable -> L55
        L21:
            boolean r3 = r1.hasNext()     // Catch: java.lang.Throwable -> L55
            if (r3 == 0) goto L55
            java.lang.Object r3 = r1.next()     // Catch: java.lang.Throwable -> L55
            android.app.ActivityManager$RunningAppProcessInfo r3 = (android.app.ActivityManager.RunningAppProcessInfo) r3     // Catch: java.lang.Throwable -> L55
            int r4 = android.os.Process.myPid()     // Catch: java.lang.Throwable -> L55
            int r5 = r3.pid     // Catch: java.lang.Throwable -> L55
            if (r4 != r5) goto L21
            int r1 = r3.importance     // Catch: java.lang.Throwable -> L55
            r3 = 100
            if (r1 != r3) goto L55
            boolean r1 = r2.inKeyguardRestrictedInputMode()     // Catch: java.lang.Throwable -> L55
            if (r1 != 0) goto L55
            java.lang.String r1 = "power"
            java.lang.Object r6 = r6.getSystemService(r1)     // Catch: java.lang.Throwable -> L55
            android.os.PowerManager r6 = (android.os.PowerManager) r6     // Catch: java.lang.Throwable -> L55
            if (r6 != 0) goto L4d
            r6 = 0
            goto L51
        L4d:
            boolean r6 = r6.isScreenOn()     // Catch: java.lang.Throwable -> L55
        L51:
            if (r6 == 0) goto L55
            r6 = 1
            return r6
        L55:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zzaq(android.content.Context):boolean");
    }

    public static Bitmap zzar(Context context) {
        Bitmap bitmapZzu;
        if (!(context instanceof Activity)) {
            return null;
        }
        try {
        } catch (RuntimeException e) {
            zzakb.zzb("Fail to capture screen shot", e);
        }
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbbh)).booleanValue()) {
            Window window = ((Activity) context).getWindow();
            if (window != null) {
                bitmapZzu = zzv(window.getDecorView().getRootView());
            }
            return null;
        }
        bitmapZzu = zzu(((Activity) context).getWindow().getDecorView());
        return bitmapZzu;
    }

    public static int zzas(Context context) {
        ApplicationInfo applicationInfo = context.getApplicationInfo();
        if (applicationInfo == null) {
            return 0;
        }
        return applicationInfo.targetSdkVersion;
    }

    @Nullable
    private static KeyguardManager zzat(Context context) {
        Object systemService = context.getSystemService("keyguard");
        if (systemService == null || !(systemService instanceof KeyguardManager)) {
            return null;
        }
        return (KeyguardManager) systemService;
    }

    @TargetApi(16)
    public static boolean zzau(Context context) {
        KeyguardManager keyguardManagerZzat;
        return context != null && PlatformVersion.isAtLeastJellyBean() && (keyguardManagerZzat = zzat(context)) != null && keyguardManagerZzat.isKeyguardLocked();
    }

    public static boolean zzav(Context context) {
        try {
            context.getClassLoader().loadClass("com.google.android.gms.ads.internal.ClientApi");
            return false;
        } catch (ClassNotFoundException unused) {
            return true;
        } catch (Throwable th) {
            zzakb.zzb("Error loading class.", th);
            com.google.android.gms.ads.internal.zzbv.zzeo().zza(th, "AdUtil.isLiteSdk");
            return false;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:20:0x0061  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static android.webkit.WebResourceResponse zzb(java.net.HttpURLConnection r10) {
        /*
            com.google.android.gms.ads.internal.zzbv.zzek()
            java.lang.String r0 = r10.getContentType()
            boolean r1 = android.text.TextUtils.isEmpty(r0)
            r2 = 0
            if (r1 == 0) goto L12
            java.lang.String r0 = ""
        L10:
            r4 = r0
            goto L1f
        L12:
            java.lang.String r1 = ";"
            java.lang.String[] r0 = r0.split(r1)
            r0 = r0[r2]
            java.lang.String r0 = r0.trim()
            goto L10
        L1f:
            com.google.android.gms.ads.internal.zzbv.zzek()
            java.lang.String r0 = r10.getContentType()
            boolean r1 = android.text.TextUtils.isEmpty(r0)
            if (r1 != 0) goto L61
            java.lang.String r1 = ";"
            java.lang.String[] r0 = r0.split(r1)
            int r1 = r0.length
            r3 = 1
            if (r1 == r3) goto L61
            r1 = 1
        L37:
            int r5 = r0.length
            if (r1 >= r5) goto L61
            r5 = r0[r1]
            java.lang.String r5 = r5.trim()
            java.lang.String r6 = "charset"
            boolean r5 = r5.startsWith(r6)
            if (r5 == 0) goto L5e
            r5 = r0[r1]
            java.lang.String r5 = r5.trim()
            java.lang.String r6 = "="
            java.lang.String[] r5 = r5.split(r6)
            int r6 = r5.length
            if (r6 <= r3) goto L5e
            r0 = r5[r3]
            java.lang.String r0 = r0.trim()
            goto L63
        L5e:
            int r1 = r1 + 1
            goto L37
        L61:
            java.lang.String r0 = ""
        L63:
            r5 = r0
            java.util.Map r0 = r10.getHeaderFields()
            java.util.HashMap r8 = new java.util.HashMap
            int r1 = r0.size()
            r8.<init>(r1)
            java.util.Set r0 = r0.entrySet()
            java.util.Iterator r0 = r0.iterator()
        L79:
            boolean r1 = r0.hasNext()
            if (r1 == 0) goto Lb3
            java.lang.Object r1 = r0.next()
            java.util.Map$Entry r1 = (java.util.Map.Entry) r1
            java.lang.Object r3 = r1.getKey()
            if (r3 == 0) goto L79
            java.lang.Object r3 = r1.getValue()
            if (r3 == 0) goto L79
            java.lang.Object r3 = r1.getValue()
            java.util.List r3 = (java.util.List) r3
            int r3 = r3.size()
            if (r3 <= 0) goto L79
            java.lang.Object r3 = r1.getKey()
            java.lang.String r3 = (java.lang.String) r3
            java.lang.Object r1 = r1.getValue()
            java.util.List r1 = (java.util.List) r1
            java.lang.Object r1 = r1.get(r2)
            java.lang.String r1 = (java.lang.String) r1
            r8.put(r3, r1)
            goto L79
        Lb3:
            com.google.android.gms.internal.ads.zzakq r3 = com.google.android.gms.ads.internal.zzbv.zzem()
            int r6 = r10.getResponseCode()
            java.lang.String r7 = r10.getResponseMessage()
            java.io.InputStream r9 = r10.getInputStream()
            android.webkit.WebResourceResponse r10 = r3.zza(r4, r5, r6, r7, r8, r9)
            return r10
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zzb(java.net.HttpURLConnection):android.webkit.WebResourceResponse");
    }

    @TargetApi(18)
    public static void zzb(Context context, Intent intent) {
        if (intent != null && PlatformVersion.isAtLeastJellyBeanMR2()) {
            Bundle extras = intent.getExtras() != null ? intent.getExtras() : new Bundle();
            extras.putBinder(CustomTabsIntent.EXTRA_SESSION, null);
            extras.putString("com.android.browser.application_id", context.getPackageName());
            intent.putExtras(extras);
        }
    }

    @VisibleForTesting
    private static boolean zzb(int i, int i2, int i3) {
        return Math.abs(i - i2) <= i3;
    }

    public static String zzcu(String str) {
        return Uri.parse(str).buildUpon().query(null).build().toString();
    }

    public static int zzcv(String str) {
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            String strValueOf = String.valueOf(e);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 22);
            sb.append("Could not parse value:");
            sb.append(strValueOf);
            zzakb.zzdk(sb.toString());
            return 0;
        }
    }

    public static boolean zzcw(String str) {
        if (TextUtils.isEmpty(str)) {
            return false;
        }
        return str.matches("([^\\s]+(\\.(?i)(jpg|png|gif|bmp|webp))$)");
    }

    public static void zzd(Context context, String str, String str2) {
        ArrayList arrayList = new ArrayList();
        arrayList.add(str2);
        zza(context, str, arrayList);
    }

    public static void zzd(Runnable runnable) {
        if (Looper.getMainLooper().getThread() != Thread.currentThread()) {
            runnable.run();
        } else {
            zzaki.zzb(runnable);
        }
    }

    public static void zze(Context context, String str, String str2) {
        try {
            FileOutputStream fileOutputStreamOpenFileOutput = context.openFileOutput(str, 0);
            fileOutputStreamOpenFileOutput.write(str2.getBytes("UTF-8"));
            fileOutputStreamOpenFileOutput.close();
        } catch (Exception e) {
            zzakb.zzb("Error writing to file in internal storage.", e);
        }
    }

    @Nullable
    public static WebResourceResponse zzf(Context context, String str, String str2) {
        try {
            HashMap map = new HashMap();
            map.put("User-Agent", com.google.android.gms.ads.internal.zzbv.zzek().zzm(context, str));
            map.put("Cache-Control", "max-stale=3600");
            String str3 = new zzalt(context).zzc(str2, map).get(60L, TimeUnit.SECONDS);
            if (str3 != null) {
                return new WebResourceResponse("application/javascript", "UTF-8", new ByteArrayInputStream(str3.getBytes("UTF-8")));
            }
            return null;
        } catch (IOException | InterruptedException | ExecutionException | TimeoutException e) {
            zzakb.zzc("Could not fetch MRAID JS.", e);
            return null;
        }
    }

    private final JSONObject zzf(Bundle bundle) throws JSONException {
        JSONObject jSONObject = new JSONObject();
        for (String str : bundle.keySet()) {
            zza(jSONObject, str, bundle.get(str));
        }
        return jSONObject;
    }

    public static int[] zzf(Activity activity) {
        View viewFindViewById;
        Window window = activity.getWindow();
        return (window == null || (viewFindViewById = window.findViewById(R.id.content)) == null) ? zzrj() : new int[]{viewFindViewById.getWidth(), viewFindViewById.getHeight()};
    }

    public static Map<String, String> zzg(Uri uri) {
        if (uri == null) {
            return null;
        }
        HashMap map = new HashMap();
        for (String str : com.google.android.gms.ads.internal.zzbv.zzem().zzh(uri)) {
            map.put(str, uri.getQueryParameter(str));
        }
        return map;
    }

    public static boolean zzl(Context context, String str) {
        return Wrappers.packageManager(context).checkPermission(str, context.getPackageName()) == 0;
    }

    public static String zzn(Context context, String str) {
        try {
            return new String(IOUtils.readInputStreamFully(context.openFileInput(str), true), "UTF-8");
        } catch (IOException unused) {
            zzakb.zzck("Error reading from internal storage.");
            return "";
        }
    }

    private static String zzrg() {
        StringBuilder sb = new StringBuilder(256);
        sb.append("Mozilla/5.0 (Linux; U; Android");
        if (Build.VERSION.RELEASE != null) {
            sb.append(" ");
            sb.append(Build.VERSION.RELEASE);
        }
        sb.append("; ");
        sb.append(Locale.getDefault());
        if (Build.DEVICE != null) {
            sb.append("; ");
            sb.append(Build.DEVICE);
            if (Build.DISPLAY != null) {
                sb.append(" Build/");
                sb.append(Build.DISPLAY);
            }
        }
        sb.append(") AppleWebKit/533 Version/4.0 Safari/533");
        return sb.toString();
    }

    public static String zzrh() {
        return UUID.randomUUID().toString();
    }

    public static String zzri() {
        String str = Build.MANUFACTURER;
        String str2 = Build.MODEL;
        if (str2.startsWith(str)) {
            return str2;
        }
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 1 + String.valueOf(str2).length());
        sb.append(str);
        sb.append(" ");
        sb.append(str2);
        return sb.toString();
    }

    private static int[] zzrj() {
        return new int[]{0, 0};
    }

    public static Bundle zzrk() {
        Bundle bundle = new Bundle();
        try {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzavm)).booleanValue()) {
                Debug.MemoryInfo memoryInfo = new Debug.MemoryInfo();
                Debug.getMemoryInfo(memoryInfo);
                bundle.putParcelable("debug_memory_info", memoryInfo);
            }
            if (((Boolean) zzkb.zzik().zzd(zznk.zzavn)).booleanValue()) {
                Runtime runtime = Runtime.getRuntime();
                bundle.putLong("runtime_free_memory", runtime.freeMemory());
                bundle.putLong("runtime_max_memory", runtime.maxMemory());
                bundle.putLong("runtime_total_memory", runtime.totalMemory());
            }
            bundle.putInt("web_view_count", com.google.android.gms.ads.internal.zzbv.zzeo().zzqg());
            return bundle;
        } catch (Exception e) {
            zzakb.zzc("Unable to gather memory stats", e);
            return bundle;
        }
    }

    public static Bitmap zzs(View view) {
        view.setDrawingCacheEnabled(true);
        Bitmap bitmapCreateBitmap = Bitmap.createBitmap(view.getDrawingCache());
        view.setDrawingCacheEnabled(false);
        return bitmapCreateBitmap;
    }

    public static Bitmap zzt(View view) {
        if (view == null) {
            return null;
        }
        Bitmap bitmapZzv = zzv(view);
        return bitmapZzv == null ? zzu(view) : bitmapZzv;
    }

    private static Bitmap zzu(@NonNull View view) {
        try {
            int width = view.getWidth();
            int height = view.getHeight();
            if (width != 0 && height != 0) {
                Bitmap bitmapCreateBitmap = Bitmap.createBitmap(view.getWidth(), view.getHeight(), Bitmap.Config.RGB_565);
                Canvas canvas = new Canvas(bitmapCreateBitmap);
                view.layout(0, 0, width, height);
                view.draw(canvas);
                return bitmapCreateBitmap;
            }
            zzakb.zzdk("Width or height of view is zero");
            return null;
        } catch (RuntimeException e) {
            zzakb.zzb("Fail to capture the webview", e);
            return null;
        }
    }

    private static Bitmap zzv(@NonNull View view) {
        try {
            boolean zIsDrawingCacheEnabled = view.isDrawingCacheEnabled();
            view.setDrawingCacheEnabled(true);
            Bitmap drawingCache = view.getDrawingCache();
            bitmapCreateBitmap = drawingCache != null ? Bitmap.createBitmap(drawingCache) : null;
            view.setDrawingCacheEnabled(zIsDrawingCacheEnabled);
            return bitmapCreateBitmap;
        } catch (RuntimeException e) {
            zzakb.zzb("Fail to capture the web view", e);
            return bitmapCreateBitmap;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:7:0x0012  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static boolean zzw(android.view.View r2) {
        /*
            android.view.View r2 = r2.getRootView()
            r0 = 0
            if (r2 == 0) goto L12
            android.content.Context r2 = r2.getContext()
            boolean r1 = r2 instanceof android.app.Activity
            if (r1 == 0) goto L12
            android.app.Activity r2 = (android.app.Activity) r2
            goto L13
        L12:
            r2 = r0
        L13:
            r1 = 0
            if (r2 != 0) goto L17
            return r1
        L17:
            android.view.Window r2 = r2.getWindow()
            if (r2 != 0) goto L1e
            goto L22
        L1e:
            android.view.WindowManager$LayoutParams r0 = r2.getAttributes()
        L22:
            if (r0 == 0) goto L2d
            int r2 = r0.flags
            r0 = 524288(0x80000, float:7.34684E-40)
            r2 = r2 & r0
            if (r2 == 0) goto L2d
            r2 = 1
            return r2
        L2d:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zzw(android.view.View):boolean");
    }

    public static int zzx(@Nullable View view) {
        if (view == null) {
            return -1;
        }
        ViewParent parent = view.getParent();
        while (parent != null && !(parent instanceof AdapterView)) {
            parent = parent.getParent();
        }
        if (parent == null) {
            return -1;
        }
        return ((AdapterView) parent).getPositionForView(view);
    }

    public final JSONObject zza(@Nullable Bundle bundle, JSONObject jSONObject) {
        if (bundle != null) {
            try {
                return zzf(bundle);
            } catch (JSONException e) {
                zzakb.zzb("Error converting Bundle to JSON", e);
            }
        }
        return null;
    }

    public final void zza(Context context, String str, WebSettings webSettings) {
        webSettings.setUserAgentString(zzm(context, str));
    }

    public final void zza(Context context, @Nullable String str, String str2, Bundle bundle, boolean z) {
        if (z) {
            com.google.android.gms.ads.internal.zzbv.zzek();
            bundle.putString("device", zzri());
            bundle.putString("eids", TextUtils.join(",", zznk.zzjb()));
        }
        zzkb.zzif();
        zzamu.zza(context, str, str2, bundle, z, new zzakn(this, context, str));
    }

    public final void zza(Context context, String str, boolean z, HttpURLConnection httpURLConnection) {
        httpURLConnection.setConnectTimeout(60000);
        httpURLConnection.setInstanceFollowRedirects(false);
        httpURLConnection.setReadTimeout(60000);
        httpURLConnection.setRequestProperty("User-Agent", zzm(context, str));
        httpURLConnection.setUseCaches(false);
    }

    public final void zza(Context context, List<String> list) {
        if (context instanceof Activity) {
            Activity activity = (Activity) context;
            if (TextUtils.isEmpty(zzbfw.zzbn(activity))) {
                return;
            }
            if (list == null) {
                zzakb.v("Cannot ping urls: empty list.");
            } else {
                if (!zzoh.zzh(context)) {
                    zzakb.v("Cannot ping url because custom tabs is not supported");
                    return;
                }
                zzoh zzohVar = new zzoh();
                zzohVar.zza(new zzakl(this, list, zzohVar, context));
                zzohVar.zzd(activity);
            }
        }
    }

    public final boolean zza(View view, Context context) {
        Context applicationContext = context.getApplicationContext();
        return zza(view, applicationContext != null ? (PowerManager) applicationContext.getSystemService("power") : null, zzat(context));
    }

    /* JADX WARN: Removed duplicated region for block: B:14:0x002f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zza(android.view.View r4, android.os.PowerManager r5, android.app.KeyguardManager r6) {
        /*
            r3 = this;
            com.google.android.gms.internal.ads.zzakk r0 = com.google.android.gms.ads.internal.zzbv.zzek()
            boolean r0 = r0.zzcrn
            r1 = 1
            r2 = 0
            if (r0 != 0) goto L2f
            if (r6 != 0) goto Le
            r6 = 0
            goto L12
        Le:
            boolean r6 = r6.inKeyguardRestrictedInputMode()
        L12:
            if (r6 == 0) goto L2f
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r6 = com.google.android.gms.internal.ads.zznk.zzazu
            com.google.android.gms.internal.ads.zzni r0 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r6 = r0.zzd(r6)
            java.lang.Boolean r6 = (java.lang.Boolean) r6
            boolean r6 = r6.booleanValue()
            if (r6 == 0) goto L2d
            boolean r6 = zzw(r4)
            if (r6 == 0) goto L2d
            goto L2f
        L2d:
            r6 = 0
            goto L30
        L2f:
            r6 = 1
        L30:
            int r0 = r4.getVisibility()
            if (r0 != 0) goto L75
            boolean r0 = r4.isShown()
            if (r0 == 0) goto L75
            if (r5 == 0) goto L47
            boolean r5 = r5.isScreenOn()
            if (r5 == 0) goto L45
            goto L47
        L45:
            r5 = 0
            goto L48
        L47:
            r5 = 1
        L48:
            if (r5 == 0) goto L75
            if (r6 == 0) goto L75
            com.google.android.gms.internal.ads.zzna<java.lang.Boolean> r5 = com.google.android.gms.internal.ads.zznk.zzazs
            com.google.android.gms.internal.ads.zzni r6 = com.google.android.gms.internal.ads.zzkb.zzik()
            java.lang.Object r5 = r6.zzd(r5)
            java.lang.Boolean r5 = (java.lang.Boolean) r5
            boolean r5 = r5.booleanValue()
            if (r5 == 0) goto L74
            android.graphics.Rect r5 = new android.graphics.Rect
            r5.<init>()
            boolean r5 = r4.getLocalVisibleRect(r5)
            if (r5 != 0) goto L74
            android.graphics.Rect r5 = new android.graphics.Rect
            r5.<init>()
            boolean r4 = r4.getGlobalVisibleRect(r5)
            if (r4 == 0) goto L75
        L74:
            return r1
        L75:
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zza(android.view.View, android.os.PowerManager, android.app.KeyguardManager):boolean");
    }

    public final boolean zzak(Context context) {
        if (this.zzcro) {
            return false;
        }
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.USER_PRESENT");
        intentFilter.addAction("android.intent.action.SCREEN_OFF");
        context.getApplicationContext().registerReceiver(new zzakp(this, null), intentFilter);
        this.zzcro = true;
        return true;
    }

    public final boolean zzal(Context context) {
        if (this.zzcrp) {
            return false;
        }
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("com.google.android.ads.intent.DEBUG_LOGGING_ENABLEMENT_CHANGED");
        context.getApplicationContext().registerReceiver(new zzako(this, null), intentFilter);
        this.zzcrp = true;
        return true;
    }

    public final void zzb(Context context, String str, String str2, Bundle bundle, boolean z) {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzazx)).booleanValue()) {
            zza(context, str, str2, bundle, z);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x0025 A[Catch: all -> 0x0043, TryCatch #0 {, blocks: (B:6:0x0009, B:8:0x000d, B:11:0x0037, B:12:0x0041, B:10:0x0025), top: B:18:0x0009, outer: #1 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zzcx(java.lang.String r4) {
        /*
            r3 = this;
            boolean r0 = android.text.TextUtils.isEmpty(r4)
            r1 = 0
            if (r0 == 0) goto L8
            return r1
        L8:
            monitor-enter(r3)     // Catch: java.util.regex.PatternSyntaxException -> L46
            java.util.regex.Pattern r0 = r3.zzcrq     // Catch: java.lang.Throwable -> L43
            if (r0 == 0) goto L25
            com.google.android.gms.internal.ads.zzna<java.lang.String> r0 = com.google.android.gms.internal.ads.zznk.zzaxo     // Catch: java.lang.Throwable -> L43
            com.google.android.gms.internal.ads.zzni r2 = com.google.android.gms.internal.ads.zzkb.zzik()     // Catch: java.lang.Throwable -> L43
            java.lang.Object r0 = r2.zzd(r0)     // Catch: java.lang.Throwable -> L43
            java.lang.String r0 = (java.lang.String) r0     // Catch: java.lang.Throwable -> L43
            java.util.regex.Pattern r2 = r3.zzcrq     // Catch: java.lang.Throwable -> L43
            java.lang.String r2 = r2.pattern()     // Catch: java.lang.Throwable -> L43
            boolean r0 = r0.equals(r2)     // Catch: java.lang.Throwable -> L43
            if (r0 != 0) goto L37
        L25:
            com.google.android.gms.internal.ads.zzna<java.lang.String> r0 = com.google.android.gms.internal.ads.zznk.zzaxo     // Catch: java.lang.Throwable -> L43
            com.google.android.gms.internal.ads.zzni r2 = com.google.android.gms.internal.ads.zzkb.zzik()     // Catch: java.lang.Throwable -> L43
            java.lang.Object r0 = r2.zzd(r0)     // Catch: java.lang.Throwable -> L43
            java.lang.String r0 = (java.lang.String) r0     // Catch: java.lang.Throwable -> L43
            java.util.regex.Pattern r0 = java.util.regex.Pattern.compile(r0)     // Catch: java.lang.Throwable -> L43
            r3.zzcrq = r0     // Catch: java.lang.Throwable -> L43
        L37:
            java.util.regex.Pattern r0 = r3.zzcrq     // Catch: java.lang.Throwable -> L43
            java.util.regex.Matcher r4 = r0.matcher(r4)     // Catch: java.lang.Throwable -> L43
            boolean r4 = r4.matches()     // Catch: java.lang.Throwable -> L43
            monitor-exit(r3)     // Catch: java.lang.Throwable -> L43
            return r4
        L43:
            r4 = move-exception
            monitor-exit(r3)     // Catch: java.lang.Throwable -> L43
            throw r4     // Catch: java.util.regex.PatternSyntaxException -> L46
        L46:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zzcx(java.lang.String):boolean");
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x0025 A[Catch: all -> 0x0043, TryCatch #0 {, blocks: (B:6:0x0009, B:8:0x000d, B:11:0x0037, B:12:0x0041, B:10:0x0025), top: B:18:0x0009, outer: #1 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zzcy(java.lang.String r4) {
        /*
            r3 = this;
            boolean r0 = android.text.TextUtils.isEmpty(r4)
            r1 = 0
            if (r0 == 0) goto L8
            return r1
        L8:
            monitor-enter(r3)     // Catch: java.util.regex.PatternSyntaxException -> L46
            java.util.regex.Pattern r0 = r3.zzcrr     // Catch: java.lang.Throwable -> L43
            if (r0 == 0) goto L25
            com.google.android.gms.internal.ads.zzna<java.lang.String> r0 = com.google.android.gms.internal.ads.zznk.zzaxp     // Catch: java.lang.Throwable -> L43
            com.google.android.gms.internal.ads.zzni r2 = com.google.android.gms.internal.ads.zzkb.zzik()     // Catch: java.lang.Throwable -> L43
            java.lang.Object r0 = r2.zzd(r0)     // Catch: java.lang.Throwable -> L43
            java.lang.String r0 = (java.lang.String) r0     // Catch: java.lang.Throwable -> L43
            java.util.regex.Pattern r2 = r3.zzcrr     // Catch: java.lang.Throwable -> L43
            java.lang.String r2 = r2.pattern()     // Catch: java.lang.Throwable -> L43
            boolean r0 = r0.equals(r2)     // Catch: java.lang.Throwable -> L43
            if (r0 != 0) goto L37
        L25:
            com.google.android.gms.internal.ads.zzna<java.lang.String> r0 = com.google.android.gms.internal.ads.zznk.zzaxp     // Catch: java.lang.Throwable -> L43
            com.google.android.gms.internal.ads.zzni r2 = com.google.android.gms.internal.ads.zzkb.zzik()     // Catch: java.lang.Throwable -> L43
            java.lang.Object r0 = r2.zzd(r0)     // Catch: java.lang.Throwable -> L43
            java.lang.String r0 = (java.lang.String) r0     // Catch: java.lang.Throwable -> L43
            java.util.regex.Pattern r0 = java.util.regex.Pattern.compile(r0)     // Catch: java.lang.Throwable -> L43
            r3.zzcrr = r0     // Catch: java.lang.Throwable -> L43
        L37:
            java.util.regex.Pattern r0 = r3.zzcrr     // Catch: java.lang.Throwable -> L43
            java.util.regex.Matcher r4 = r0.matcher(r4)     // Catch: java.lang.Throwable -> L43
            boolean r4 = r4.matches()     // Catch: java.lang.Throwable -> L43
            monitor-exit(r3)     // Catch: java.lang.Throwable -> L43
            return r4
        L43:
            r4 = move-exception
            monitor-exit(r3)     // Catch: java.lang.Throwable -> L43
            throw r4     // Catch: java.util.regex.PatternSyntaxException -> L46
        L46:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zzcy(java.lang.String):boolean");
    }

    public final int[] zzg(Activity activity) {
        int[] iArrZzf = zzf(activity);
        zzkb.zzif();
        zzkb.zzif();
        return new int[]{zzamu.zzb(activity, iArrZzf[0]), zzamu.zzb(activity, iArrZzf[1])};
    }

    public final int[] zzh(Activity activity) {
        View viewFindViewById;
        Window window = activity.getWindow();
        int[] iArrZzrj = (window == null || (viewFindViewById = window.findViewById(R.id.content)) == null) ? zzrj() : new int[]{viewFindViewById.getTop(), viewFindViewById.getBottom()};
        zzkb.zzif();
        zzkb.zzif();
        return new int[]{zzamu.zzb(activity, iArrZzrj[0]), zzamu.zzb(activity, iArrZzrj[1])};
    }

    /* JADX WARN: Removed duplicated region for block: B:32:0x00a7 A[Catch: Exception -> 0x00b6, all -> 0x00d2, TRY_LEAVE, TryCatch #3 {Exception -> 0x00b6, blocks: (B:30:0x009d, B:32:0x00a7), top: B:48:0x009d, outer: #1 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final java.lang.String zzm(android.content.Context r5, java.lang.String r6) {
        /*
            Method dump skipped, instruction units count: 213
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzakk.zzm(android.content.Context, java.lang.String):java.lang.String");
    }

    public final JSONObject zzn(Map<String, ?> map) throws JSONException {
        try {
            JSONObject jSONObject = new JSONObject();
            for (String str : map.keySet()) {
                zza(jSONObject, str, map.get(str));
            }
            return jSONObject;
        } catch (ClassCastException e) {
            String strValueOf = String.valueOf(e.getMessage());
            throw new JSONException(strValueOf.length() != 0 ? "Could not convert map to JSON: ".concat(strValueOf) : new String("Could not convert map to JSON: "));
        }
    }
}
