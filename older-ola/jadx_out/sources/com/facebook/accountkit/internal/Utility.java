package com.facebook.accountkit.internal;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Looper;
import android.os.StatFs;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.content.PermissionChecker;
import android.telephony.TelephonyManager;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.Pair;
import android.util.Patterns;
import android.view.Display;
import android.view.WindowManager;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.PhoneNumber;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.i18n.phonenumbers.NumberParseException;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;
import java.io.BufferedInputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.concurrent.Executor;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.regex.Pattern;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/* JADX INFO: loaded from: classes.dex */
public final class Utility {
    private static final ScheduledThreadPoolExecutor BACKGROUND_EXECUTOR = new ScheduledThreadPoolExecutor(1);
    private static final String EXTRA_APP_EVENTS_INFO_FORMAT_VERSION = "a2";
    private static final String HASH_ALGORITHM_SHA1 = "SHA-1";
    private static final String NO_CARRIER = "NoCarrier";
    private static final int REFRESH_TIME_FOR_EXTENDED_DEVICE_INFO_MILLIS = 1800000;
    private static final String TAG = "com.facebook.accountkit.internal.Utility";
    private static long availableExternalStorageGB = -1;
    private static String carrierName = "NoCarrier";
    private static String deviceTimezone = "";
    private static int numCPUCores = 0;
    private static long timestampOfLastCheck = -1;
    private static long totalExternalStorageGB = -1;

    public static <T> boolean areObjectsEqual(T t, T t2) {
        return t == null ? t2 == null : t.equals(t2);
    }

    static void assertUIThread() {
        if (Looper.getMainLooper().equals(Looper.myLooper())) {
            return;
        }
        Log.w(TAG, "This method should be called from the UI thread");
    }

    public static String cleanPhoneNumberString(String str) {
        return isNullOrEmpty(str) ? "" : str.replaceAll("[^\\d]", "");
    }

    static void closeQuietly(Closeable closeable) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (IOException unused) {
            }
        }
    }

    private static long convertBytesToGB(double d) {
        return Math.round(d / 1.073741824E9d);
    }

    @Nullable
    public static PhoneNumber convertI8nPhoneNumber(@Nullable Phonenumber.PhoneNumber phoneNumber) {
        if (phoneNumber == null || !PhoneNumberUtil.getInstance().isValidNumber(phoneNumber)) {
            return null;
        }
        return new PhoneNumber(String.valueOf(phoneNumber.getCountryCode()), String.valueOf(phoneNumber.getNationalNumber()), PhoneNumberUtil.getInstance().getRegionCodeForNumber(phoneNumber));
    }

    static int copyAndCloseInputStream(InputStream inputStream, OutputStream outputStream) throws Throwable {
        BufferedInputStream bufferedInputStream;
        try {
            bufferedInputStream = new BufferedInputStream(inputStream);
            try {
                byte[] bArr = new byte[8192];
                int i = 0;
                while (true) {
                    int i2 = bufferedInputStream.read(bArr);
                    if (i2 == -1) {
                        break;
                    }
                    outputStream.write(bArr, 0, i2);
                    i += i2;
                }
                if (bufferedInputStream != null) {
                    bufferedInputStream.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
                return i;
            } catch (Throwable th) {
                th = th;
                if (bufferedInputStream != null) {
                    bufferedInputStream.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
            bufferedInputStream = null;
        }
    }

    static Pair<AccountKitError, InternalAccountKitError> createErrorFromServerError(AccountKitRequestError accountKitRequestError) {
        AccountKitError accountKitError;
        int errorCode = accountKitRequestError.getErrorCode();
        if (accountKitRequestError.getSubErrorCode() == 1550001) {
            errorCode = InternalAccountKitError.INVALID_PHONE_NUMBER;
        }
        InternalAccountKitError internalAccountKitError = new InternalAccountKitError(errorCode, accountKitRequestError.getErrorMessage(), accountKitRequestError.getUserErrorMessage());
        int errorCode2 = accountKitRequestError.getErrorCode();
        if (errorCode2 != 15003) {
            switch (errorCode2) {
                case 100:
                    accountKitError = new AccountKitError(AccountKitError.Type.ARGUMENT_ERROR, internalAccountKitError);
                    break;
                case 101:
                    accountKitError = new AccountKitError(AccountKitError.Type.NETWORK_CONNECTION_ERROR, internalAccountKitError);
                    break;
                default:
                    switch (errorCode2) {
                        case InternalAccountKitError.LOGIN_REQUEST_EXPIRED /* 1948001 */:
                            accountKitError = new AccountKitError(AccountKitError.Type.LOGIN_INVALIDATED, internalAccountKitError);
                            break;
                        case InternalAccountKitError.INVALID_CREDENTIALS_OR_LOGIN_REQUEST /* 1948002 */:
                            accountKitError = new AccountKitError(AccountKitError.Type.ARGUMENT_ERROR, internalAccountKitError);
                            break;
                        case InternalAccountKitError.TOO_MANY_ATTEMPTS /* 1948003 */:
                            accountKitError = new AccountKitError(AccountKitError.Type.SERVER_ERROR, internalAccountKitError);
                            break;
                        default:
                            accountKitError = new AccountKitError(AccountKitError.Type.SERVER_ERROR, internalAccountKitError);
                            break;
                    }
                    break;
            }
        } else {
            accountKitError = new AccountKitError(AccountKitError.Type.ARGUMENT_ERROR, internalAccountKitError);
        }
        return new Pair<>(accountKitError, internalAccountKitError);
    }

    @Nullable
    public static Phonenumber.PhoneNumber createI8nPhoneNumber(@Nullable String str) {
        if (isNullOrEmpty(str)) {
            return null;
        }
        if (!str.startsWith("+")) {
            str = "+" + str;
        }
        try {
            return PhoneNumberUtil.getInstance().parse(str, "");
        } catch (NumberParseException unused) {
            return null;
        }
    }

    @Nullable
    public static PhoneNumber createPhoneNumber(@Nullable String str) {
        return convertI8nPhoneNumber(createI8nPhoneNumber(str));
    }

    static void disconnectQuietly(URLConnection uRLConnection) {
        if (uRLConnection instanceof HttpURLConnection) {
            ((HttpURLConnection) uRLConnection).disconnect();
        }
    }

    private static boolean externalStorageExists() {
        return "mounted".equals(Environment.getExternalStorageState());
    }

    static ScheduledThreadPoolExecutor getBackgroundExecutor() {
        return BACKGROUND_EXECUTOR;
    }

    @Nullable
    public static String getCountryCode(String str) {
        if (isNullOrEmpty(str)) {
            return null;
        }
        if (str.startsWith("+")) {
            str = str.substring(1);
        }
        try {
            StringBuilder sb = new StringBuilder(str.length());
            String str2 = null;
            for (int i = 0; i < str.length() && str2 == null; i++) {
                try {
                    sb.append(str.charAt(i));
                    String regionCodeForCountryCode = PhoneNumberUtil.getInstance().getRegionCodeForCountryCode(Integer.valueOf(sb.toString()).intValue());
                    try {
                        str2 = regionCodeForCountryCode.equals("ZZ") ? null : regionCodeForCountryCode;
                    } catch (NumberFormatException unused) {
                        return regionCodeForCountryCode;
                    }
                } catch (NumberFormatException unused2) {
                    return str2;
                }
            }
            return str2;
        } catch (NumberFormatException unused3) {
            return null;
        }
    }

    public static String getCurrentCountry(Context context) {
        String networkCountryIso;
        try {
            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService("phone");
            String simCountryIso = telephonyManager.getSimCountryIso();
            if (simCountryIso != null && simCountryIso.length() == 2) {
                return simCountryIso.toLowerCase(Locale.US);
            }
            if (telephonyManager.getPhoneType() == 2 || (networkCountryIso = telephonyManager.getNetworkCountryIso()) == null || networkCountryIso.length() != 2) {
                return null;
            }
            return networkCountryIso.toLowerCase(Locale.US);
        } catch (Exception unused) {
            return null;
        }
    }

    public static List<String> getDeviceEmailsIfAvailable(Context context) {
        if (!hasGetAccountsPermissions(context)) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        for (Account account : AccountManager.get(context).getAccounts()) {
            if (!isNullOrEmpty(account.name) && Patterns.EMAIL_ADDRESS.matcher(account.name).matches() && !arrayList.contains(account.name)) {
                arrayList.add(account.name);
            }
        }
        return arrayList;
    }

    public static int getHashCode(Object obj) {
        if (obj == null) {
            return 0;
        }
        return obj.hashCode();
    }

    static String getMetadataApplicationId() {
        return AccountKit.getApplicationId();
    }

    public static String getRedirectURL() {
        return "ak" + AccountKit.getApplicationId() + "://authorize";
    }

    static Object getStringPropertyAsJSON(JSONObject jSONObject, String str) {
        Object objOpt = jSONObject.opt(str);
        return (objOpt == null || !(objOpt instanceof String)) ? objOpt : new JSONTokener((String) objOpt).nextValue();
    }

    public static Executor getThreadPoolExecutor() {
        return AccountKit.getExecutor();
    }

    static boolean hasGetAccountsPermissions(@NonNull Context context) {
        return hasPermission(context, "android.permission.GET_ACCOUNTS");
    }

    public static boolean hasGooglePlayServices(Context context) {
        return GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(context) == 0;
    }

    private static boolean hasPermission(Context context, String str) {
        try {
            return PermissionChecker.checkCallingOrSelfPermission(context, str) == 0;
        } catch (Exception unused) {
            return false;
        }
    }

    static boolean hasReadPhoneStatePermissions(@NonNull Context context) {
        return hasPermission(context, "android.permission.READ_PHONE_STATE");
    }

    public static boolean hasReceiveSmsPermissions(@NonNull Context context) {
        return hasPermission(context, "android.permission.RECEIVE_SMS");
    }

    private static String hashBytes(MessageDigest messageDigest, byte[] bArr) {
        messageDigest.update(bArr);
        byte[] bArrDigest = messageDigest.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : bArrDigest) {
            sb.append(Integer.toHexString((b >> 4) & 15));
            sb.append(Integer.toHexString(b & 15));
        }
        return sb.toString();
    }

    static boolean isConfirmationCodeRetryable(InternalAccountKitError internalAccountKitError) {
        return internalAccountKitError != null && internalAccountKitError.getCode() == 15003;
    }

    static boolean isDebuggable(Context context) {
        try {
            return (context.getPackageManager().getPackageInfo(context.getPackageName(), 0).applicationInfo.flags & 2) != 0;
        } catch (PackageManager.NameNotFoundException unused) {
            return false;
        }
    }

    public static boolean isNullOrEmpty(String str) {
        return str == null || str.length() == 0;
    }

    static void logd(String str, Exception exc) {
        if (str == null || exc == null) {
            return;
        }
        Log.d(str, exc.getClass().getSimpleName() + ": " + exc.getMessage());
    }

    static void logd(String str, String str2, Throwable th) {
        if (isNullOrEmpty(str)) {
            return;
        }
        Log.d(str, str2, th);
    }

    static boolean notEquals(Object obj, Object obj2) {
        return obj == null || !obj.equals(obj2);
    }

    static void putNonNullString(Bundle bundle, String str, String str2) {
        if (bundle == null || str == null || str2 == null) {
            return;
        }
        bundle.putString(str, str2);
    }

    @SuppressLint({"HardwareIds"})
    @Nullable
    public static String readPhoneNumberIfAvailable(Context context) {
        TelephonyManager telephonyManager;
        if (!hasReadPhoneStatePermissions(context) || (telephonyManager = (TelephonyManager) context.getSystemService("phone")) == null) {
            return null;
        }
        return telephonyManager.getLine1Number();
    }

    static String readStreamToString(InputStream inputStream) throws Throwable {
        BufferedInputStream bufferedInputStream;
        Throwable th;
        InputStreamReader inputStreamReader;
        try {
            bufferedInputStream = new BufferedInputStream(inputStream);
            try {
                inputStreamReader = new InputStreamReader(bufferedInputStream);
                try {
                    StringBuilder sb = new StringBuilder();
                    char[] cArr = new char[2048];
                    while (true) {
                        int i = inputStreamReader.read(cArr);
                        if (i == -1) {
                            String string = sb.toString();
                            closeQuietly(bufferedInputStream);
                            closeQuietly(inputStreamReader);
                            return string;
                        }
                        sb.append(cArr, 0, i);
                    }
                } catch (Throwable th2) {
                    th = th2;
                    closeQuietly(bufferedInputStream);
                    closeQuietly(inputStreamReader);
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                inputStreamReader = null;
            }
        } catch (Throwable th4) {
            bufferedInputStream = null;
            th = th4;
            inputStreamReader = null;
        }
    }

    private static void refreshAvailableExternalStorage() {
        try {
            if (externalStorageExists()) {
                StatFs statFs = new StatFs(Environment.getExternalStorageDirectory().getPath());
                availableExternalStorageGB = ((long) statFs.getAvailableBlocks()) * ((long) statFs.getBlockSize());
            }
            availableExternalStorageGB = convertBytesToGB(availableExternalStorageGB);
        } catch (Exception unused) {
        }
    }

    private static int refreshBestGuessNumberOfCPUCores() {
        if (numCPUCores > 0) {
            return numCPUCores;
        }
        try {
            numCPUCores = new File("/sys/devices/system/cpu/").listFiles(new FilenameFilter() { // from class: com.facebook.accountkit.internal.Utility.1
                @Override // java.io.FilenameFilter
                public boolean accept(File file, String str) {
                    return Pattern.matches("cpu[0-9]+", str);
                }
            }).length;
        } catch (Exception unused) {
        }
        if (numCPUCores <= 0) {
            numCPUCores = Math.max(Runtime.getRuntime().availableProcessors(), 1);
        }
        return numCPUCores;
    }

    private static void refreshCarrierName(Context context) {
        if (carrierName.equals(NO_CARRIER)) {
            try {
                carrierName = ((TelephonyManager) context.getSystemService("phone")).getNetworkOperatorName();
            } catch (Exception unused) {
            }
        }
    }

    private static void refreshPeriodicExtendedDeviceInfo(Context context) {
        if (timestampOfLastCheck == -1 || System.currentTimeMillis() - timestampOfLastCheck >= 1800000) {
            timestampOfLastCheck = System.currentTimeMillis();
            refreshTimezone();
            refreshCarrierName(context);
            refreshTotalExternalStorage();
            refreshAvailableExternalStorage();
        }
    }

    private static void refreshTimezone() {
        try {
            TimeZone timeZone = TimeZone.getDefault();
            deviceTimezone = timeZone.getDisplayName(timeZone.inDaylightTime(new Date()), 0);
        } catch (Exception unused) {
        }
    }

    private static void refreshTotalExternalStorage() {
        try {
            if (externalStorageExists()) {
                StatFs statFs = new StatFs(Environment.getExternalStorageDirectory().getPath());
                totalExternalStorageGB = ((long) statFs.getBlockCount()) * ((long) statFs.getBlockSize());
            }
            totalExternalStorageGB = convertBytesToGB(totalExternalStorageGB);
        } catch (Exception unused) {
        }
    }

    static void setAppEventAttributionParameters(JSONObject jSONObject, String str) throws JSONException {
        jSONObject.put("anon_id", str);
    }

    static void setAppEventExtendedDeviceInfoParameters(JSONObject jSONObject, Context context) throws JSONException {
        int i;
        Locale locale;
        int i2;
        int i3;
        WindowManager windowManager;
        JSONArray jSONArray = new JSONArray();
        jSONArray.put(EXTRA_APP_EVENTS_INFO_FORMAT_VERSION);
        refreshPeriodicExtendedDeviceInfo(context);
        String packageName = context.getPackageName();
        String str = "";
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(packageName, 0);
            i = packageInfo.versionCode;
            try {
                str = packageInfo.versionName;
            } catch (PackageManager.NameNotFoundException unused) {
            }
        } catch (PackageManager.NameNotFoundException unused2) {
            i = -1;
        }
        jSONArray.put(packageName);
        jSONArray.put(i);
        jSONArray.put(str);
        jSONArray.put(Build.VERSION.RELEASE);
        jSONArray.put(Build.MODEL);
        try {
            locale = context.getResources().getConfiguration().locale;
        } catch (Exception unused3) {
            locale = Locale.getDefault();
        }
        jSONArray.put(locale.getLanguage() + "_" + locale.getCountry());
        jSONArray.put(deviceTimezone);
        jSONArray.put(carrierName);
        double d = 0.0d;
        try {
            windowManager = (WindowManager) context.getSystemService("window");
        } catch (Exception unused4) {
        }
        if (windowManager != null) {
            Display defaultDisplay = windowManager.getDefaultDisplay();
            DisplayMetrics displayMetrics = new DisplayMetrics();
            defaultDisplay.getMetrics(displayMetrics);
            i2 = displayMetrics.widthPixels;
            try {
                i3 = displayMetrics.heightPixels;
                try {
                    d = displayMetrics.density;
                } catch (Exception unused5) {
                }
            } catch (Exception unused6) {
                i3 = 0;
            }
            jSONArray.put(i2);
            jSONArray.put(i3);
            jSONArray.put(String.format(Locale.ENGLISH, "%.2f", Double.valueOf(d)));
            jSONArray.put(refreshBestGuessNumberOfCPUCores());
            jSONArray.put(totalExternalStorageGB);
            jSONArray.put(availableExternalStorageGB);
            jSONObject.put("extinfo", jSONArray.toString());
        }
        i2 = 0;
        i3 = 0;
        jSONArray.put(i2);
        jSONArray.put(i3);
        jSONArray.put(String.format(Locale.ENGLISH, "%.2f", Double.valueOf(d)));
        jSONArray.put(refreshBestGuessNumberOfCPUCores());
        jSONArray.put(totalExternalStorageGB);
        jSONArray.put(availableExternalStorageGB);
        jSONObject.put("extinfo", jSONArray.toString());
    }

    static String sha1hash(byte[] bArr) {
        try {
            return hashBytes(MessageDigest.getInstance(HASH_ALGORITHM_SHA1), bArr);
        } catch (NoSuchAlgorithmException unused) {
            return null;
        }
    }
}
