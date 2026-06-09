package com.facebook.internal;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Parcel;
import android.os.StatFs;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.WindowManager;
import android.view.autofill.AutofillManager;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import com.facebook.AccessToken;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.places.model.PlaceFields;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.BufferedInputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.TimeZone;
import java.util.regex.Pattern;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/* JADX INFO: loaded from: classes.dex */
public final class Utility {
    public static final int DEFAULT_STREAM_BUFFER_SIZE = 8192;
    private static final String EXTRA_APP_EVENTS_INFO_FORMAT_VERSION = "a2";
    private static final int GINGERBREAD_MR1 = 10;
    private static final String HASH_ALGORITHM_MD5 = "MD5";
    private static final String HASH_ALGORITHM_SHA1 = "SHA-1";
    static final String LOG_TAG = "FacebookSDK";
    private static final int REFRESH_TIME_FOR_EXTENDED_DEVICE_INFO_MILLIS = 1800000;
    private static final String URL_SCHEME = "https";
    private static final String UTF8 = "UTF-8";
    private static long availableExternalStorageGB = -1;
    private static String carrierName = "NoCarrier";
    private static String deviceTimeZoneName = "";
    private static String deviceTimezoneAbbreviation = "";
    private static final String noCarrierConstant = "NoCarrier";
    private static int numCPUCores = 0;
    private static long timestampOfLastCheck = -1;
    private static long totalExternalStorageGB = -1;

    public interface GraphMeRequestWithCacheCallback {
        void onFailure(FacebookException facebookException);

        void onSuccess(JSONObject jSONObject);
    }

    public interface Mapper<T, K> {
        K apply(T t);
    }

    public static class PermissionsPair {
        List<String> declinedPermissions;
        List<String> grantedPermissions;

        public PermissionsPair(List<String> list, List<String> list2) {
            this.grantedPermissions = list;
            this.declinedPermissions = list2;
        }

        public List<String> getDeclinedPermissions() {
            return this.declinedPermissions;
        }

        public List<String> getGrantedPermissions() {
            return this.grantedPermissions;
        }
    }

    public interface Predicate<T> {
        boolean apply(T t);
    }

    public static <T> boolean areObjectsEqual(T t, T t2) {
        return t == null ? t2 == null : t.equals(t2);
    }

    public static <T> ArrayList<T> arrayList(T... tArr) {
        ArrayList<T> arrayList = new ArrayList<>(tArr.length);
        for (T t : tArr) {
            arrayList.add(t);
        }
        return arrayList;
    }

    public static <T> List<T> asListNoNulls(T... tArr) {
        ArrayList arrayList = new ArrayList();
        for (T t : tArr) {
            if (t != null) {
                arrayList.add(t);
            }
        }
        return arrayList;
    }

    public static JSONObject awaitGetGraphMeRequestWithCache(String str) {
        JSONObject profileInformation = ProfileInformationCache.getProfileInformation(str);
        if (profileInformation != null) {
            return profileInformation;
        }
        GraphResponse graphResponseExecuteAndWait = getGraphMeRequestWithCache(str).executeAndWait();
        if (graphResponseExecuteAndWait.getError() != null) {
            return null;
        }
        return graphResponseExecuteAndWait.getJSONObject();
    }

    public static Uri buildUri(String str, String str2, Bundle bundle) {
        Uri.Builder builder = new Uri.Builder();
        builder.scheme(URL_SCHEME);
        builder.authority(str);
        builder.path(str2);
        if (bundle != null) {
            for (String str3 : bundle.keySet()) {
                Object obj = bundle.get(str3);
                if (obj instanceof String) {
                    builder.appendQueryParameter(str3, (String) obj);
                }
            }
        }
        return builder.build();
    }

    public static void clearCaches(Context context) {
        ImageDownloader.clearCache(context);
    }

    private static void clearCookiesForDomain(Context context, String str) {
        CookieSyncManager.createInstance(context).sync();
        CookieManager cookieManager = CookieManager.getInstance();
        String cookie = cookieManager.getCookie(str);
        if (cookie == null) {
            return;
        }
        for (String str2 : cookie.split(";")) {
            String[] strArrSplit = str2.split("=");
            if (strArrSplit.length > 0) {
                cookieManager.setCookie(str, strArrSplit[0].trim() + "=;expires=Sat, 1 Jan 2000 00:00:01 UTC;");
            }
        }
        cookieManager.removeExpiredCookie();
    }

    public static void clearFacebookCookies(Context context) {
        clearCookiesForDomain(context, "facebook.com");
        clearCookiesForDomain(context, ".facebook.com");
        clearCookiesForDomain(context, "https://facebook.com");
        clearCookiesForDomain(context, "https://.facebook.com");
    }

    public static void closeQuietly(Closeable closeable) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (IOException unused) {
            }
        }
    }

    public static String coerceValueIfNullOrEmpty(String str, String str2) {
        return isNullOrEmpty(str) ? str2 : str;
    }

    private static long convertBytesToGB(double d) {
        return Math.round(d / 1.073741824E9d);
    }

    static Map<String, Object> convertJSONObjectToHashMap(JSONObject jSONObject) {
        HashMap map = new HashMap();
        JSONArray jSONArrayNames = jSONObject.names();
        for (int i = 0; i < jSONArrayNames.length(); i++) {
            try {
                String string = jSONArrayNames.getString(i);
                Object objConvertJSONObjectToHashMap = jSONObject.get(string);
                if (objConvertJSONObjectToHashMap instanceof JSONObject) {
                    objConvertJSONObjectToHashMap = convertJSONObjectToHashMap((JSONObject) objConvertJSONObjectToHashMap);
                }
                map.put(string, objConvertJSONObjectToHashMap);
            } catch (JSONException unused) {
            }
        }
        return map;
    }

    public static int copyAndCloseInputStream(InputStream inputStream, OutputStream outputStream) throws Throwable {
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

    public static void deleteDirectory(File file) {
        File[] fileArrListFiles;
        if (file.exists()) {
            if (file.isDirectory() && (fileArrListFiles = file.listFiles()) != null) {
                for (File file2 : fileArrListFiles) {
                    deleteDirectory(file2);
                }
            }
            file.delete();
        }
    }

    public static void disconnectQuietly(URLConnection uRLConnection) {
        if (uRLConnection == null || !(uRLConnection instanceof HttpURLConnection)) {
            return;
        }
        ((HttpURLConnection) uRLConnection).disconnect();
    }

    private static boolean externalStorageExists() {
        return "mounted".equals(Environment.getExternalStorageState());
    }

    public static <T> List<T> filter(List<T> list, Predicate<T> predicate) {
        if (list == null) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        for (T t : list) {
            if (predicate.apply(t)) {
                arrayList.add(t);
            }
        }
        if (arrayList.size() == 0) {
            return null;
        }
        return arrayList;
    }

    public static String generateRandomString(int i) {
        return new BigInteger(i * 5, new Random()).toString(32);
    }

    public static String getActivityName(Context context) {
        return context == null ? "null" : context == context.getApplicationContext() ? "unknown" : context.getClass().getSimpleName();
    }

    public static Date getBundleLongAsDate(Bundle bundle, String str, Date date) {
        long jLongValue;
        if (bundle == null) {
            return null;
        }
        Object obj = bundle.get(str);
        if (obj instanceof Long) {
            jLongValue = ((Long) obj).longValue();
        } else {
            if (!(obj instanceof String)) {
                return null;
            }
            try {
                jLongValue = Long.parseLong((String) obj);
            } catch (NumberFormatException unused) {
                return null;
            }
        }
        return jLongValue == 0 ? new Date(Long.MAX_VALUE) : new Date(date.getTime() + (jLongValue * 1000));
    }

    public static long getContentSize(Uri uri) throws Throwable {
        Throwable th;
        Cursor cursorQuery;
        try {
            cursorQuery = FacebookSdk.getApplicationContext().getContentResolver().query(uri, null, null, null, null);
            try {
                int columnIndex = cursorQuery.getColumnIndex("_size");
                cursorQuery.moveToFirst();
                long j = cursorQuery.getLong(columnIndex);
                if (cursorQuery != null) {
                    cursorQuery.close();
                }
                return j;
            } catch (Throwable th2) {
                th = th2;
                if (cursorQuery != null) {
                    cursorQuery.close();
                }
                throw th;
            }
        } catch (Throwable th3) {
            th = th3;
            cursorQuery = null;
        }
    }

    private static GraphRequest getGraphMeRequestWithCache(String str) {
        Bundle bundle = new Bundle();
        bundle.putString(GraphRequest.FIELDS_PARAM, "id,name,first_name,middle_name,last_name,link");
        bundle.putString("access_token", str);
        return new GraphRequest(null, "me", bundle, HttpMethod.GET, null);
    }

    public static void getGraphMeRequestWithCacheAsync(final String str, final GraphMeRequestWithCacheCallback graphMeRequestWithCacheCallback) {
        JSONObject profileInformation = ProfileInformationCache.getProfileInformation(str);
        if (profileInformation != null) {
            graphMeRequestWithCacheCallback.onSuccess(profileInformation);
            return;
        }
        GraphRequest.Callback callback = new GraphRequest.Callback() { // from class: com.facebook.internal.Utility.1
            @Override // com.facebook.GraphRequest.Callback
            public void onCompleted(GraphResponse graphResponse) {
                if (graphResponse.getError() != null) {
                    graphMeRequestWithCacheCallback.onFailure(graphResponse.getError().getException());
                } else {
                    ProfileInformationCache.putProfileInformation(str, graphResponse.getJSONObject());
                    graphMeRequestWithCacheCallback.onSuccess(graphResponse.getJSONObject());
                }
            }
        };
        GraphRequest graphMeRequestWithCache = getGraphMeRequestWithCache(str);
        graphMeRequestWithCache.setCallback(callback);
        graphMeRequestWithCache.executeAsync();
    }

    public static String getMetadataApplicationId(Context context) {
        Validate.notNull(context, PlaceFields.CONTEXT);
        FacebookSdk.sdkInitialize(context);
        return FacebookSdk.getApplicationId();
    }

    public static Method getMethodQuietly(Class<?> cls, String str, Class<?>... clsArr) {
        try {
            return cls.getMethod(str, clsArr);
        } catch (NoSuchMethodException unused) {
            return null;
        }
    }

    public static Method getMethodQuietly(String str, String str2, Class<?>... clsArr) {
        try {
            return getMethodQuietly(Class.forName(str), str2, clsArr);
        } catch (ClassNotFoundException unused) {
            return null;
        }
    }

    public static Object getStringPropertyAsJSON(JSONObject jSONObject, String str, String str2) throws JSONException {
        Object objOpt = jSONObject.opt(str);
        if (objOpt != null && (objOpt instanceof String)) {
            objOpt = new JSONTokener((String) objOpt).nextValue();
        }
        if (objOpt == null || (objOpt instanceof JSONObject) || (objOpt instanceof JSONArray)) {
            return objOpt;
        }
        if (str2 == null) {
            throw new FacebookException("Got an unexpected non-JSON object.");
        }
        JSONObject jSONObject2 = new JSONObject();
        jSONObject2.putOpt(str2, objOpt);
        return jSONObject2;
    }

    public static String getUriString(Uri uri) {
        if (uri == null) {
            return null;
        }
        return uri.toString();
    }

    public static PermissionsPair handlePermissionResponse(JSONObject jSONObject) throws JSONException {
        String strOptString;
        JSONArray jSONArray = jSONObject.getJSONObject(NativeProtocol.RESULT_ARGS_PERMISSIONS).getJSONArray("data");
        ArrayList arrayList = new ArrayList(jSONArray.length());
        ArrayList arrayList2 = new ArrayList(jSONArray.length());
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i);
            String strOptString2 = jSONObjectOptJSONObject.optString("permission");
            if (strOptString2 != null && !strOptString2.equals("installed") && (strOptString = jSONObjectOptJSONObject.optString("status")) != null) {
                if (strOptString.equals("granted")) {
                    arrayList.add(strOptString2);
                } else if (strOptString.equals("declined")) {
                    arrayList2.add(strOptString2);
                }
            }
        }
        return new PermissionsPair(arrayList, arrayList2);
    }

    public static boolean hasSameId(JSONObject jSONObject, JSONObject jSONObject2) {
        if (jSONObject == null || jSONObject2 == null || !jSONObject.has("id") || !jSONObject2.has("id")) {
            return false;
        }
        if (jSONObject.equals(jSONObject2)) {
            return true;
        }
        String strOptString = jSONObject.optString("id");
        String strOptString2 = jSONObject2.optString("id");
        if (strOptString == null || strOptString2 == null) {
            return false;
        }
        return strOptString.equals(strOptString2);
    }

    private static String hashBytes(MessageDigest messageDigest, byte[] bArr) {
        messageDigest.update(bArr);
        byte[] bArrDigest = messageDigest.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : bArrDigest) {
            sb.append(Integer.toHexString((b >> 4) & 15));
            sb.append(Integer.toHexString((b >> 0) & 15));
        }
        return sb.toString();
    }

    public static <T> HashSet<T> hashSet(T... tArr) {
        HashSet<T> hashSet = new HashSet<>(tArr.length);
        for (T t : tArr) {
            hashSet.add(t);
        }
        return hashSet;
    }

    private static String hashWithAlgorithm(String str, String str2) {
        return hashWithAlgorithm(str, str2.getBytes());
    }

    private static String hashWithAlgorithm(String str, byte[] bArr) {
        try {
            return hashBytes(MessageDigest.getInstance(str), bArr);
        } catch (NoSuchAlgorithmException unused) {
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:42:0x005d A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:45:0x000e A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static int[] intersectRanges(int[] r10, int[] r11) {
        /*
            if (r10 != 0) goto L3
            return r11
        L3:
            if (r11 != 0) goto L6
            return r10
        L6:
            int r0 = r10.length
            int r1 = r11.length
            int r0 = r0 + r1
            int[] r0 = new int[r0]
            r1 = 0
            r2 = 0
            r3 = 0
        Le:
            int r4 = r10.length
            if (r1 >= r4) goto L69
            int r4 = r11.length
            if (r2 >= r4) goto L69
            r4 = r10[r1]
            r5 = r11[r2]
            int r6 = r10.length
            int r6 = r6 + (-1)
            r7 = 2147483647(0x7fffffff, float:NaN)
            if (r1 >= r6) goto L25
            int r6 = r1 + 1
            r6 = r10[r6]
            goto L28
        L25:
            r6 = 2147483647(0x7fffffff, float:NaN)
        L28:
            int r8 = r11.length
            int r8 = r8 + (-1)
            if (r2 >= r8) goto L32
            int r8 = r2 + 1
            r8 = r11[r8]
            goto L35
        L32:
            r8 = 2147483647(0x7fffffff, float:NaN)
        L35:
            r9 = -2147483648(0xffffffff80000000, float:-0.0)
            if (r4 >= r5) goto L4e
            if (r6 <= r5) goto L46
            if (r6 <= r8) goto L42
            int r2 = r2 + 2
            r4 = r5
        L40:
            r6 = r8
            goto L5b
        L42:
            int r1 = r1 + 2
            r4 = r5
            goto L5b
        L46:
            int r1 = r1 + 2
        L48:
            r4 = -2147483648(0xffffffff80000000, float:-0.0)
            r6 = 2147483647(0x7fffffff, float:NaN)
            goto L5b
        L4e:
            if (r8 <= r4) goto L58
            if (r8 <= r6) goto L55
            int r1 = r1 + 2
            goto L5b
        L55:
            int r2 = r2 + 2
            goto L40
        L58:
            int r2 = r2 + 2
            goto L48
        L5b:
            if (r4 == r9) goto Le
            int r5 = r3 + 1
            r0[r3] = r4
            if (r6 == r7) goto L68
            int r3 = r5 + 1
            r0[r5] = r6
            goto Le
        L68:
            r3 = r5
        L69:
            int[] r10 = java.util.Arrays.copyOf(r0, r3)
            return r10
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.internal.Utility.intersectRanges(int[], int[]):int[]");
    }

    public static Object invokeMethodQuietly(Object obj, Method method, Object... objArr) {
        try {
            return method.invoke(obj, objArr);
        } catch (IllegalAccessException | InvocationTargetException unused) {
            return null;
        }
    }

    public static boolean isAutofillAvailable(Context context) {
        AutofillManager autofillManager;
        return Build.VERSION.SDK_INT >= 26 && (autofillManager = (AutofillManager) context.getSystemService(AutofillManager.class)) != null && autofillManager.isAutofillSupported() && autofillManager.isEnabled();
    }

    public static boolean isContentUri(Uri uri) {
        return uri != null && FirebaseAnalytics.Param.CONTENT.equalsIgnoreCase(uri.getScheme());
    }

    public static boolean isCurrentAccessToken(AccessToken accessToken) {
        if (accessToken != null) {
            return accessToken.equals(AccessToken.getCurrentAccessToken());
        }
        return false;
    }

    public static boolean isFileUri(Uri uri) {
        return uri != null && "file".equalsIgnoreCase(uri.getScheme());
    }

    public static boolean isNullOrEmpty(String str) {
        return str == null || str.length() == 0;
    }

    public static <T> boolean isNullOrEmpty(Collection<T> collection) {
        return collection == null || collection.size() == 0;
    }

    public static <T> boolean isSubset(Collection<T> collection, Collection<T> collection2) {
        if (collection2 == null || collection2.size() == 0) {
            return collection == null || collection.size() == 0;
        }
        HashSet hashSet = new HashSet(collection2);
        Iterator<T> it2 = collection.iterator();
        while (it2.hasNext()) {
            if (!hashSet.contains(it2.next())) {
                return false;
            }
        }
        return true;
    }

    public static boolean isWebUri(Uri uri) {
        if (uri != null) {
            return "http".equalsIgnoreCase(uri.getScheme()) || URL_SCHEME.equalsIgnoreCase(uri.getScheme()) || "fbstaging".equalsIgnoreCase(uri.getScheme());
        }
        return false;
    }

    public static Set<String> jsonArrayToSet(JSONArray jSONArray) {
        HashSet hashSet = new HashSet();
        for (int i = 0; i < jSONArray.length(); i++) {
            hashSet.add(jSONArray.getString(i));
        }
        return hashSet;
    }

    public static List<String> jsonArrayToStringList(JSONArray jSONArray) {
        ArrayList arrayList = new ArrayList();
        for (int i = 0; i < jSONArray.length(); i++) {
            arrayList.add(jSONArray.getString(i));
        }
        return arrayList;
    }

    public static void logd(String str, Exception exc) {
        if (!FacebookSdk.isDebugEnabled() || str == null || exc == null) {
            return;
        }
        Log.d(str, exc.getClass().getSimpleName() + ": " + exc.getMessage());
    }

    public static void logd(String str, String str2) {
        if (!FacebookSdk.isDebugEnabled() || str == null || str2 == null) {
            return;
        }
        Log.d(str, str2);
    }

    public static void logd(String str, String str2, Throwable th) {
        if (!FacebookSdk.isDebugEnabled() || isNullOrEmpty(str)) {
            return;
        }
        Log.d(str, str2, th);
    }

    public static <T, K> List<K> map(List<T> list, Mapper<T, K> mapper) {
        if (list == null) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        Iterator<T> it2 = list.iterator();
        while (it2.hasNext()) {
            K kApply = mapper.apply(it2.next());
            if (kApply != null) {
                arrayList.add(kApply);
            }
        }
        if (arrayList.size() == 0) {
            return null;
        }
        return arrayList;
    }

    public static String md5hash(String str) {
        return hashWithAlgorithm(HASH_ALGORITHM_MD5, str);
    }

    public static boolean mustFixWindowParamsForAutofill(Context context) {
        return isAutofillAvailable(context);
    }

    public static Bundle parseUrlQueryString(String str) {
        Bundle bundle = new Bundle();
        if (!isNullOrEmpty(str)) {
            for (String str2 : str.split("&")) {
                String[] strArrSplit = str2.split("=");
                try {
                    if (strArrSplit.length == 2) {
                        bundle.putString(URLDecoder.decode(strArrSplit[0], UTF8), URLDecoder.decode(strArrSplit[1], UTF8));
                    } else if (strArrSplit.length == 1) {
                        bundle.putString(URLDecoder.decode(strArrSplit[0], UTF8), "");
                    }
                } catch (UnsupportedEncodingException e) {
                    logd(LOG_TAG, e);
                }
            }
        }
        return bundle;
    }

    public static void putCommaSeparatedStringList(Bundle bundle, String str, List<String> list) {
        if (list != null) {
            StringBuilder sb = new StringBuilder();
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                sb.append(it2.next());
                sb.append(",");
            }
            bundle.putString(str, sb.length() > 0 ? sb.substring(0, sb.length() - 1) : "");
        }
    }

    public static boolean putJSONValueInBundle(Bundle bundle, String str, Object obj) {
        String string;
        if (obj == null) {
            bundle.remove(str);
            return true;
        }
        if (obj instanceof Boolean) {
            bundle.putBoolean(str, ((Boolean) obj).booleanValue());
            return true;
        }
        if (obj instanceof boolean[]) {
            bundle.putBooleanArray(str, (boolean[]) obj);
            return true;
        }
        if (obj instanceof Double) {
            bundle.putDouble(str, ((Double) obj).doubleValue());
            return true;
        }
        if (obj instanceof double[]) {
            bundle.putDoubleArray(str, (double[]) obj);
            return true;
        }
        if (obj instanceof Integer) {
            bundle.putInt(str, ((Integer) obj).intValue());
            return true;
        }
        if (obj instanceof int[]) {
            bundle.putIntArray(str, (int[]) obj);
            return true;
        }
        if (obj instanceof Long) {
            bundle.putLong(str, ((Long) obj).longValue());
            return true;
        }
        if (obj instanceof long[]) {
            bundle.putLongArray(str, (long[]) obj);
            return true;
        }
        if (obj instanceof String) {
            string = (String) obj;
        } else {
            if (!(obj instanceof JSONArray) && !(obj instanceof JSONObject)) {
                return false;
            }
            string = obj.toString();
        }
        bundle.putString(str, string);
        return true;
    }

    public static void putNonEmptyString(Bundle bundle, String str, String str2) {
        if (isNullOrEmpty(str2)) {
            return;
        }
        bundle.putString(str, str2);
    }

    public static void putUri(Bundle bundle, String str, Uri uri) {
        if (uri != null) {
            putNonEmptyString(bundle, str, uri.toString());
        }
    }

    public static String readStreamToString(InputStream inputStream) throws Throwable {
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

    public static Map<String, String> readStringMapFromParcel(Parcel parcel) {
        int i = parcel.readInt();
        if (i < 0) {
            return null;
        }
        HashMap map = new HashMap();
        for (int i2 = 0; i2 < i; i2++) {
            map.put(parcel.readString(), parcel.readString());
        }
        return map;
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
            File[] fileArrListFiles = new File("/sys/devices/system/cpu/").listFiles(new FilenameFilter() { // from class: com.facebook.internal.Utility.2
                @Override // java.io.FilenameFilter
                public boolean accept(File file, String str) {
                    return Pattern.matches("cpu[0-9]+", str);
                }
            });
            if (fileArrListFiles != null) {
                numCPUCores = fileArrListFiles.length;
            }
        } catch (Exception unused) {
        }
        if (numCPUCores <= 0) {
            numCPUCores = Math.max(Runtime.getRuntime().availableProcessors(), 1);
        }
        return numCPUCores;
    }

    private static void refreshCarrierName(Context context) {
        if (carrierName.equals(noCarrierConstant)) {
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
            deviceTimezoneAbbreviation = timeZone.getDisplayName(timeZone.inDaylightTime(new Date()), 0);
            deviceTimeZoneName = timeZone.getID();
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

    public static String safeGetStringFromResponse(JSONObject jSONObject, String str) {
        return jSONObject != null ? jSONObject.optString(str, "") : "";
    }

    public static void setAppEventAttributionParameters(JSONObject jSONObject, AttributionIdentifiers attributionIdentifiers, String str, boolean z) throws JSONException {
        if (attributionIdentifiers != null && attributionIdentifiers.getAttributionId() != null) {
            jSONObject.put("attribution", attributionIdentifiers.getAttributionId());
        }
        if (attributionIdentifiers != null && attributionIdentifiers.getAndroidAdvertiserId() != null) {
            jSONObject.put("advertiser_id", attributionIdentifiers.getAndroidAdvertiserId());
            jSONObject.put("advertiser_tracking_enabled", !attributionIdentifiers.isTrackingLimited());
        }
        if (attributionIdentifiers != null && attributionIdentifiers.getAndroidInstallerPackage() != null) {
            jSONObject.put("installer_package", attributionIdentifiers.getAndroidInstallerPackage());
        }
        jSONObject.put("anon_id", str);
        jSONObject.put("application_tracking_enabled", !z);
    }

    public static void setAppEventExtendedDeviceInfoParameters(JSONObject jSONObject, Context context) throws JSONException {
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
        jSONArray.put(deviceTimezoneAbbreviation);
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
            jSONArray.put(String.format("%.2f", Double.valueOf(d)));
            jSONArray.put(refreshBestGuessNumberOfCPUCores());
            jSONArray.put(totalExternalStorageGB);
            jSONArray.put(availableExternalStorageGB);
            jSONArray.put(deviceTimeZoneName);
            jSONObject.put("extinfo", jSONArray.toString());
        }
        i2 = 0;
        i3 = 0;
        jSONArray.put(i2);
        jSONArray.put(i3);
        jSONArray.put(String.format("%.2f", Double.valueOf(d)));
        jSONArray.put(refreshBestGuessNumberOfCPUCores());
        jSONArray.put(totalExternalStorageGB);
        jSONArray.put(availableExternalStorageGB);
        jSONArray.put(deviceTimeZoneName);
        jSONObject.put("extinfo", jSONArray.toString());
    }

    public static String sha1hash(String str) {
        return hashWithAlgorithm(HASH_ALGORITHM_SHA1, str);
    }

    public static String sha1hash(byte[] bArr) {
        return hashWithAlgorithm(HASH_ALGORITHM_SHA1, bArr);
    }

    public static boolean stringsEqualOrEmpty(String str, String str2) {
        boolean zIsEmpty = TextUtils.isEmpty(str);
        boolean zIsEmpty2 = TextUtils.isEmpty(str2);
        if (zIsEmpty && zIsEmpty2) {
            return true;
        }
        if (zIsEmpty || zIsEmpty2) {
            return false;
        }
        return str.equals(str2);
    }

    public static JSONArray tryGetJSONArrayFromResponse(JSONObject jSONObject, String str) {
        if (jSONObject != null) {
            return jSONObject.optJSONArray(str);
        }
        return null;
    }

    public static JSONObject tryGetJSONObjectFromResponse(JSONObject jSONObject, String str) {
        if (jSONObject != null) {
            return jSONObject.optJSONObject(str);
        }
        return null;
    }

    public static <T> Collection<T> unmodifiableCollection(T... tArr) {
        return Collections.unmodifiableCollection(Arrays.asList(tArr));
    }

    public static void writeStringMapToParcel(Parcel parcel, Map<String, String> map) {
        if (map == null) {
            parcel.writeInt(-1);
            return;
        }
        parcel.writeInt(map.size());
        for (Map.Entry<String, String> entry : map.entrySet()) {
            parcel.writeString(entry.getKey());
            parcel.writeString(entry.getValue());
        }
    }
}
