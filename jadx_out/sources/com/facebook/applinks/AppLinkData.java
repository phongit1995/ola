package com.facebook.applinks;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;
import android.util.Log;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.internal.AttributionIdentifiers;
import com.facebook.internal.Utility;
import com.facebook.internal.Validate;
import com.facebook.places.model.PlaceFields;
import java.util.Iterator;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class AppLinkData {
    private static final String APPLINK_BRIDGE_ARGS_KEY = "bridge_args";
    private static final String APPLINK_METHOD_ARGS_KEY = "method_args";
    private static final String APPLINK_VERSION_KEY = "version";
    public static final String ARGUMENTS_EXTRAS_KEY = "extras";
    public static final String ARGUMENTS_NATIVE_CLASS_KEY = "com.facebook.platform.APPLINK_NATIVE_CLASS";
    public static final String ARGUMENTS_NATIVE_URL = "com.facebook.platform.APPLINK_NATIVE_URL";
    public static final String ARGUMENTS_REFERER_DATA_KEY = "referer_data";
    public static final String ARGUMENTS_TAPTIME_KEY = "com.facebook.platform.APPLINK_TAP_TIME_UTC";
    private static final String BRIDGE_ARGS_METHOD_KEY = "method";
    private static final String BUNDLE_AL_APPLINK_DATA_KEY = "al_applink_data";
    static final String BUNDLE_APPLINK_ARGS_KEY = "com.facebook.platform.APPLINK_ARGS";
    private static final String DEFERRED_APP_LINK_ARGS_FIELD = "applink_args";
    private static final String DEFERRED_APP_LINK_CLASS_FIELD = "applink_class";
    private static final String DEFERRED_APP_LINK_CLICK_TIME_FIELD = "click_time";
    private static final String DEFERRED_APP_LINK_EVENT = "DEFERRED_APP_LINK";
    private static final String DEFERRED_APP_LINK_PATH = "%s/activities";
    private static final String DEFERRED_APP_LINK_URL_FIELD = "applink_url";
    private static final String EXTRAS_DEEPLINK_CONTEXT_KEY = "deeplink_context";
    private static final String METHOD_ARGS_REF_KEY = "ref";
    private static final String METHOD_ARGS_TARGET_URL_KEY = "target_url";
    private static final String PROMOTION_CODE_KEY = "promo_code";
    private static final String REFERER_DATA_REF_KEY = "fb_ref";
    private static final String TAG = AppLinkData.class.getCanonicalName();
    private Bundle argumentBundle;
    private JSONObject arguments;
    private String promotionCode;
    private String ref;
    private Uri targetUri;

    public interface CompletionHandler {
        void onDeferredAppLinkDataFetched(AppLinkData appLinkData);
    }

    private AppLinkData() {
    }

    public static AppLinkData createFromActivity(Activity activity) {
        Validate.notNull(activity, "activity");
        Intent intent = activity.getIntent();
        if (intent == null) {
            return null;
        }
        AppLinkData appLinkDataCreateFromAlApplinkData = createFromAlApplinkData(intent);
        if (appLinkDataCreateFromAlApplinkData == null) {
            appLinkDataCreateFromAlApplinkData = createFromJson(intent.getStringExtra(BUNDLE_APPLINK_ARGS_KEY));
        }
        return appLinkDataCreateFromAlApplinkData == null ? createFromUri(intent.getData()) : appLinkDataCreateFromAlApplinkData;
    }

    public static AppLinkData createFromAlApplinkData(Intent intent) {
        Bundle bundleExtra;
        String string;
        String string2;
        if (intent == null || (bundleExtra = intent.getBundleExtra(BUNDLE_AL_APPLINK_DATA_KEY)) == null) {
            return null;
        }
        AppLinkData appLinkData = new AppLinkData();
        appLinkData.targetUri = intent.getData();
        if (appLinkData.targetUri == null && (string2 = bundleExtra.getString(METHOD_ARGS_TARGET_URL_KEY)) != null) {
            appLinkData.targetUri = Uri.parse(string2);
        }
        appLinkData.argumentBundle = bundleExtra;
        appLinkData.arguments = null;
        Bundle bundle = bundleExtra.getBundle(ARGUMENTS_REFERER_DATA_KEY);
        if (bundle != null) {
            appLinkData.ref = bundle.getString(REFERER_DATA_REF_KEY);
        }
        Bundle bundle2 = bundleExtra.getBundle(ARGUMENTS_EXTRAS_KEY);
        if (bundle2 != null && (string = bundle2.getString("deeplink_context")) != null) {
            try {
                JSONObject jSONObject = new JSONObject(string);
                if (jSONObject.has("promo_code")) {
                    appLinkData.promotionCode = jSONObject.getString("promo_code");
                    return appLinkData;
                }
            } catch (JSONException e) {
                Log.d(TAG, "Unable to parse deeplink_context JSON", e);
            }
        }
        return appLinkData;
    }

    /* JADX WARN: Removed duplicated region for block: B:20:0x0078 A[Catch: FacebookException | JSONException -> 0x00bf, TryCatch #0 {FacebookException | JSONException -> 0x00bf, blocks: (B:5:0x0004, B:7:0x0023, B:9:0x002b, B:11:0x0042, B:12:0x004a, B:18:0x006e, B:20:0x0078, B:21:0x0086, B:23:0x0090, B:25:0x00a0, B:27:0x00ae, B:28:0x00b6, B:13:0x004d, B:15:0x0057, B:17:0x0067), top: B:33:0x0004 }] */
    /* JADX WARN: Removed duplicated region for block: B:23:0x0090 A[Catch: FacebookException | JSONException -> 0x00bf, TryCatch #0 {FacebookException | JSONException -> 0x00bf, blocks: (B:5:0x0004, B:7:0x0023, B:9:0x002b, B:11:0x0042, B:12:0x004a, B:18:0x006e, B:20:0x0078, B:21:0x0086, B:23:0x0090, B:25:0x00a0, B:27:0x00ae, B:28:0x00b6, B:13:0x004d, B:15:0x0057, B:17:0x0067), top: B:33:0x0004 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static com.facebook.applinks.AppLinkData createFromJson(java.lang.String r4) {
        /*
            r0 = 0
            if (r4 != 0) goto L4
            return r0
        L4:
            org.json.JSONObject r1 = new org.json.JSONObject     // Catch: java.lang.Throwable -> Lbf
            r1.<init>(r4)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r4 = "version"
            java.lang.String r4 = r1.getString(r4)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "bridge_args"
            org.json.JSONObject r2 = r1.getJSONObject(r2)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r3 = "method"
            java.lang.String r2 = r2.getString(r3)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r3 = "applink"
            boolean r2 = r2.equals(r3)     // Catch: java.lang.Throwable -> Lbf
            if (r2 == 0) goto Lc7
            java.lang.String r2 = "2"
            boolean r4 = r4.equals(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r4 == 0) goto Lc7
            com.facebook.applinks.AppLinkData r4 = new com.facebook.applinks.AppLinkData     // Catch: java.lang.Throwable -> Lbf
            r4.<init>()     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "method_args"
            org.json.JSONObject r1 = r1.getJSONObject(r2)     // Catch: java.lang.Throwable -> Lbf
            r4.arguments = r1     // Catch: java.lang.Throwable -> Lbf
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "ref"
            boolean r1 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r1 == 0) goto L4d
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "ref"
            java.lang.String r1 = r1.getString(r2)     // Catch: java.lang.Throwable -> Lbf
        L4a:
            r4.ref = r1     // Catch: java.lang.Throwable -> Lbf
            goto L6e
        L4d:
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "referer_data"
            boolean r1 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r1 == 0) goto L6e
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "referer_data"
            org.json.JSONObject r1 = r1.getJSONObject(r2)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "fb_ref"
            boolean r2 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r2 == 0) goto L6e
            java.lang.String r2 = "fb_ref"
            java.lang.String r1 = r1.getString(r2)     // Catch: java.lang.Throwable -> Lbf
            goto L4a
        L6e:
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "target_url"
            boolean r1 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r1 == 0) goto L86
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "target_url"
            java.lang.String r1 = r1.getString(r2)     // Catch: java.lang.Throwable -> Lbf
            android.net.Uri r1 = android.net.Uri.parse(r1)     // Catch: java.lang.Throwable -> Lbf
            r4.targetUri = r1     // Catch: java.lang.Throwable -> Lbf
        L86:
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "extras"
            boolean r1 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r1 == 0) goto Lb6
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "extras"
            org.json.JSONObject r1 = r1.getJSONObject(r2)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "deeplink_context"
            boolean r2 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r2 == 0) goto Lb6
            java.lang.String r2 = "deeplink_context"
            org.json.JSONObject r1 = r1.getJSONObject(r2)     // Catch: java.lang.Throwable -> Lbf
            java.lang.String r2 = "promo_code"
            boolean r2 = r1.has(r2)     // Catch: java.lang.Throwable -> Lbf
            if (r2 == 0) goto Lb6
            java.lang.String r2 = "promo_code"
            java.lang.String r1 = r1.getString(r2)     // Catch: java.lang.Throwable -> Lbf
            r4.promotionCode = r1     // Catch: java.lang.Throwable -> Lbf
        Lb6:
            org.json.JSONObject r1 = r4.arguments     // Catch: java.lang.Throwable -> Lbf
            android.os.Bundle r1 = toBundle(r1)     // Catch: java.lang.Throwable -> Lbf
            r4.argumentBundle = r1     // Catch: java.lang.Throwable -> Lbf
            return r4
        Lbf:
            r4 = move-exception
            java.lang.String r1 = com.facebook.applinks.AppLinkData.TAG
            java.lang.String r2 = "Unable to parse AppLink JSON"
            android.util.Log.d(r1, r2, r4)
        Lc7:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.applinks.AppLinkData.createFromJson(java.lang.String):com.facebook.applinks.AppLinkData");
    }

    private static AppLinkData createFromUri(Uri uri) {
        if (uri == null) {
            return null;
        }
        AppLinkData appLinkData = new AppLinkData();
        appLinkData.targetUri = uri;
        return appLinkData;
    }

    public static void fetchDeferredAppLinkData(Context context, CompletionHandler completionHandler) {
        fetchDeferredAppLinkData(context, null, completionHandler);
    }

    public static void fetchDeferredAppLinkData(Context context, final String str, final CompletionHandler completionHandler) {
        Validate.notNull(context, PlaceFields.CONTEXT);
        Validate.notNull(completionHandler, "completionHandler");
        if (str == null) {
            str = Utility.getMetadataApplicationId(context);
        }
        Validate.notNull(str, "applicationId");
        final Context applicationContext = context.getApplicationContext();
        FacebookSdk.getExecutor().execute(new Runnable() { // from class: com.facebook.applinks.AppLinkData.1
            @Override // java.lang.Runnable
            public void run() {
                AppLinkData.fetchDeferredAppLinkFromServer(applicationContext, str, completionHandler);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void fetchDeferredAppLinkFromServer(Context context, String str, CompletionHandler completionHandler) {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put(NotificationCompat.CATEGORY_EVENT, DEFERRED_APP_LINK_EVENT);
            Utility.setAppEventAttributionParameters(jSONObject, AttributionIdentifiers.getAttributionIdentifiers(context), AppEventsLogger.getAnonymousAppDeviceGUID(context), FacebookSdk.getLimitEventAndDataUsage(context));
            Utility.setAppEventExtendedDeviceInfoParameters(jSONObject, FacebookSdk.getApplicationContext());
            jSONObject.put("application_package_name", context.getPackageName());
            Object[] objArr = {str};
            AppLinkData appLinkData = null;
            try {
                JSONObject jSONObject2 = GraphRequest.newPostRequest(null, String.format(DEFERRED_APP_LINK_PATH, objArr), jSONObject, null).executeAndWait().getJSONObject();
                if (jSONObject2 != null) {
                    String strOptString = jSONObject2.optString(DEFERRED_APP_LINK_ARGS_FIELD);
                    long jOptLong = jSONObject2.optLong(DEFERRED_APP_LINK_CLICK_TIME_FIELD, -1L);
                    String strOptString2 = jSONObject2.optString(DEFERRED_APP_LINK_CLASS_FIELD);
                    String strOptString3 = jSONObject2.optString(DEFERRED_APP_LINK_URL_FIELD);
                    if (!TextUtils.isEmpty(strOptString)) {
                        AppLinkData appLinkDataCreateFromJson = createFromJson(strOptString);
                        try {
                            if (jOptLong != -1) {
                                try {
                                    if (appLinkDataCreateFromJson.arguments != null) {
                                        appLinkDataCreateFromJson.arguments.put(ARGUMENTS_TAPTIME_KEY, jOptLong);
                                    }
                                    if (appLinkDataCreateFromJson.argumentBundle != null) {
                                        appLinkDataCreateFromJson.argumentBundle.putString(ARGUMENTS_TAPTIME_KEY, Long.toString(jOptLong));
                                    }
                                } catch (JSONException unused) {
                                    Log.d(TAG, "Unable to put tap time in AppLinkData.arguments");
                                }
                            }
                            if (strOptString2 != null) {
                                try {
                                    if (appLinkDataCreateFromJson.arguments != null) {
                                        appLinkDataCreateFromJson.arguments.put(ARGUMENTS_NATIVE_CLASS_KEY, strOptString2);
                                    }
                                    if (appLinkDataCreateFromJson.argumentBundle != null) {
                                        appLinkDataCreateFromJson.argumentBundle.putString(ARGUMENTS_NATIVE_CLASS_KEY, strOptString2);
                                    }
                                } catch (JSONException unused2) {
                                    Log.d(TAG, "Unable to put tap time in AppLinkData.arguments");
                                }
                            }
                            if (strOptString3 != null) {
                                try {
                                    if (appLinkDataCreateFromJson.arguments != null) {
                                        appLinkDataCreateFromJson.arguments.put(ARGUMENTS_NATIVE_URL, strOptString3);
                                    }
                                    if (appLinkDataCreateFromJson.argumentBundle != null) {
                                        appLinkDataCreateFromJson.argumentBundle.putString(ARGUMENTS_NATIVE_URL, strOptString3);
                                    }
                                } catch (JSONException unused3) {
                                    Log.d(TAG, "Unable to put tap time in AppLinkData.arguments");
                                }
                            }
                            appLinkData = appLinkDataCreateFromJson;
                        } catch (Exception unused4) {
                            appLinkData = appLinkDataCreateFromJson;
                            Utility.logd(TAG, "Unable to fetch deferred applink from server");
                        }
                    }
                }
            } catch (Exception unused5) {
            }
            completionHandler.onDeferredAppLinkDataFetched(appLinkData);
        } catch (JSONException e) {
            throw new FacebookException("An error occurred while preparing deferred app link", e);
        }
    }

    private static Bundle toBundle(JSONObject jSONObject) throws JSONException {
        Bundle bundle = new Bundle();
        Iterator<String> itKeys = jSONObject.keys();
        while (itKeys.hasNext()) {
            String next = itKeys.next();
            Object obj = jSONObject.get(next);
            if (obj instanceof JSONObject) {
                bundle.putBundle(next, toBundle((JSONObject) obj));
            } else if (obj instanceof JSONArray) {
                JSONArray jSONArray = (JSONArray) obj;
                int i = 0;
                if (jSONArray.length() == 0) {
                    bundle.putStringArray(next, new String[0]);
                } else {
                    Object obj2 = jSONArray.get(0);
                    if (obj2 instanceof JSONObject) {
                        Bundle[] bundleArr = new Bundle[jSONArray.length()];
                        while (i < jSONArray.length()) {
                            bundleArr[i] = toBundle(jSONArray.getJSONObject(i));
                            i++;
                        }
                        bundle.putParcelableArray(next, bundleArr);
                    } else {
                        if (obj2 instanceof JSONArray) {
                            throw new FacebookException("Nested arrays are not supported.");
                        }
                        String[] strArr = new String[jSONArray.length()];
                        while (i < jSONArray.length()) {
                            strArr[i] = jSONArray.get(i).toString();
                            i++;
                        }
                        bundle.putStringArray(next, strArr);
                    }
                }
            } else {
                bundle.putString(next, obj.toString());
            }
        }
        return bundle;
    }

    public Bundle getArgumentBundle() {
        return this.argumentBundle;
    }

    public String getPromotionCode() {
        return this.promotionCode;
    }

    public String getRef() {
        return this.ref;
    }

    public Bundle getRefererData() {
        if (this.argumentBundle != null) {
            return this.argumentBundle.getBundle(ARGUMENTS_REFERER_DATA_KEY);
        }
        return null;
    }

    public Uri getTargetUri() {
        return this.targetUri;
    }
}
