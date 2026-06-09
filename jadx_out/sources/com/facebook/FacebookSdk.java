package com.facebook;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.AsyncTask;
import android.support.v4.media.session.PlaybackStateCompat;
import android.util.Base64;
import android.util.Log;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.appevents.internal.ActivityLifecycleTracker;
import com.facebook.appevents.internal.AppEventsLoggerUtility;
import com.facebook.internal.AttributionIdentifiers;
import com.facebook.internal.BoltsMeasurementEventListener;
import com.facebook.internal.FetchedAppSettingsManager;
import com.facebook.internal.LockOnGetVariable;
import com.facebook.internal.NativeProtocol;
import com.facebook.internal.ServerProtocol;
import com.facebook.internal.Utility;
import com.facebook.internal.Validate;
import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.Executor;
import java.util.concurrent.FutureTask;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public final class FacebookSdk {
    public static final String APPLICATION_ID_PROPERTY = "com.facebook.sdk.ApplicationId";
    public static final String APPLICATION_NAME_PROPERTY = "com.facebook.sdk.ApplicationName";
    private static final String ATTRIBUTION_PREFERENCES = "com.facebook.sdk.attributionTracking";
    public static final String AUTO_LOG_APP_EVENTS_ENABLED_PROPERTY = "com.facebook.sdk.AutoLogAppEventsEnabled";
    static final String CALLBACK_OFFSET_CHANGED_AFTER_INIT = "The callback request code offset can't be updated once the SDK is initialized. Call FacebookSdk.setCallbackRequestCodeOffset inside your Application.onCreate method";
    static final String CALLBACK_OFFSET_NEGATIVE = "The callback request code offset can't be negative.";
    public static final String CALLBACK_OFFSET_PROPERTY = "com.facebook.sdk.CallbackOffset";
    public static final String CLIENT_TOKEN_PROPERTY = "com.facebook.sdk.ClientToken";
    private static final int DEFAULT_CALLBACK_REQUEST_CODE_OFFSET = 64206;
    private static final int DEFAULT_CORE_POOL_SIZE = 5;
    private static final int DEFAULT_KEEP_ALIVE = 1;
    private static final int DEFAULT_MAXIMUM_POOL_SIZE = 128;
    private static final String FACEBOOK_COM = "facebook.com";
    private static final int MAX_REQUEST_CODE_RANGE = 100;
    private static final String PUBLISH_ACTIVITY_PATH = "%s/activities";
    public static final String WEB_DIALOG_THEME = "com.facebook.sdk.WebDialogTheme";
    private static volatile String appClientToken = null;
    private static Context applicationContext = null;
    private static volatile String applicationId = null;
    private static volatile String applicationName = null;
    private static volatile Boolean autoLogAppEventsEnabled = null;
    private static LockOnGetVariable<File> cacheDir = null;
    private static int callbackRequestCodeOffset = 64206;
    private static Executor executor = null;
    private static volatile String facebookDomain = "facebook.com";
    private static volatile boolean isDebugEnabled = false;
    private static boolean isLegacyTokenUpgradeSupported = false;
    private static final String TAG = FacebookSdk.class.getCanonicalName();
    private static final HashSet<LoggingBehavior> loggingBehaviors = new HashSet<>(Arrays.asList(LoggingBehavior.DEVELOPER_ERRORS));
    private static AtomicLong onProgressThreshold = new AtomicLong(PlaybackStateCompat.ACTION_PREPARE_FROM_SEARCH);
    private static final Object LOCK = new Object();
    private static String graphApiVersion = ServerProtocol.getDefaultAPIVersion();
    private static final BlockingQueue<Runnable> DEFAULT_WORK_QUEUE = new LinkedBlockingQueue(10);
    private static final ThreadFactory DEFAULT_THREAD_FACTORY = new ThreadFactory() { // from class: com.facebook.FacebookSdk.1
        private final AtomicInteger counter = new AtomicInteger(0);

        @Override // java.util.concurrent.ThreadFactory
        public Thread newThread(Runnable runnable) {
            return new Thread(runnable, "FacebookSdk #" + this.counter.incrementAndGet());
        }
    };
    private static Boolean sdkInitialized = false;

    public interface InitializeCallback {
        void onInitialized();
    }

    public static void addLoggingBehavior(LoggingBehavior loggingBehavior) {
        synchronized (loggingBehaviors) {
            loggingBehaviors.add(loggingBehavior);
            updateGraphDebugBehavior();
        }
    }

    public static void clearLoggingBehaviors() {
        synchronized (loggingBehaviors) {
            loggingBehaviors.clear();
        }
    }

    public static Context getApplicationContext() {
        Validate.sdkInitialized();
        return applicationContext;
    }

    public static String getApplicationId() {
        Validate.sdkInitialized();
        return applicationId;
    }

    public static String getApplicationName() {
        Validate.sdkInitialized();
        return applicationName;
    }

    public static String getApplicationSignature(Context context) throws NoSuchAlgorithmException {
        PackageManager packageManager;
        Validate.sdkInitialized();
        if (context == null || (packageManager = context.getPackageManager()) == null) {
            return null;
        }
        try {
            PackageInfo packageInfo = packageManager.getPackageInfo(context.getPackageName(), 64);
            Signature[] signatureArr = packageInfo.signatures;
            if (signatureArr == null || signatureArr.length == 0) {
                return null;
            }
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");
            messageDigest.update(packageInfo.signatures[0].toByteArray());
            return Base64.encodeToString(messageDigest.digest(), 9);
        } catch (PackageManager.NameNotFoundException | NoSuchAlgorithmException unused) {
        }
        return null;
    }

    public static boolean getAutoLogAppEventsEnabled() {
        Validate.sdkInitialized();
        return autoLogAppEventsEnabled.booleanValue();
    }

    public static File getCacheDir() {
        Validate.sdkInitialized();
        return cacheDir.getValue();
    }

    public static int getCallbackRequestCodeOffset() {
        Validate.sdkInitialized();
        return callbackRequestCodeOffset;
    }

    public static String getClientToken() {
        Validate.sdkInitialized();
        return appClientToken;
    }

    public static Executor getExecutor() {
        synchronized (LOCK) {
            if (executor == null) {
                executor = AsyncTask.THREAD_POOL_EXECUTOR;
            }
        }
        return executor;
    }

    public static String getFacebookDomain() {
        return facebookDomain;
    }

    public static String getGraphApiVersion() {
        return graphApiVersion;
    }

    public static boolean getLimitEventAndDataUsage(Context context) {
        Validate.sdkInitialized();
        return context.getSharedPreferences(AppEventsLogger.APP_EVENT_PREFERENCES, 0).getBoolean("limitEventUsage", false);
    }

    public static Set<LoggingBehavior> getLoggingBehaviors() {
        Set<LoggingBehavior> setUnmodifiableSet;
        synchronized (loggingBehaviors) {
            setUnmodifiableSet = Collections.unmodifiableSet(new HashSet(loggingBehaviors));
        }
        return setUnmodifiableSet;
    }

    public static long getOnProgressThreshold() {
        Validate.sdkInitialized();
        return onProgressThreshold.get();
    }

    public static String getSdkVersion() {
        return FacebookSdkVersion.BUILD;
    }

    public static boolean isDebugEnabled() {
        return isDebugEnabled;
    }

    public static boolean isFacebookRequestCode(int i) {
        return i >= callbackRequestCodeOffset && i < callbackRequestCodeOffset + 100;
    }

    public static synchronized boolean isInitialized() {
        return sdkInitialized.booleanValue();
    }

    public static boolean isLegacyTokenUpgradeSupported() {
        return isLegacyTokenUpgradeSupported;
    }

    public static boolean isLoggingBehaviorEnabled(LoggingBehavior loggingBehavior) {
        boolean z;
        synchronized (loggingBehaviors) {
            z = isDebugEnabled() && loggingBehaviors.contains(loggingBehavior);
        }
        return z;
    }

    static void loadDefaultsFromMetadata(Context context) {
        if (context == null) {
            return;
        }
        try {
            ApplicationInfo applicationInfo = context.getPackageManager().getApplicationInfo(context.getPackageName(), 128);
            if (applicationInfo == null || applicationInfo.metaData == null) {
                return;
            }
            if (applicationId == null) {
                Object obj = applicationInfo.metaData.get("com.facebook.sdk.ApplicationId");
                if (obj instanceof String) {
                    String strSubstring = (String) obj;
                    if (strSubstring.toLowerCase(Locale.ROOT).startsWith("fb")) {
                        strSubstring = strSubstring.substring(2);
                    }
                    applicationId = strSubstring;
                } else if (obj instanceof Integer) {
                    throw new FacebookException("App Ids cannot be directly placed in the manifest.They must be prefixed by 'fb' or be placed in the string resource file.");
                }
            }
            if (applicationName == null) {
                applicationName = applicationInfo.metaData.getString(APPLICATION_NAME_PROPERTY);
            }
            if (appClientToken == null) {
                appClientToken = applicationInfo.metaData.getString(CLIENT_TOKEN_PROPERTY);
            }
            if (callbackRequestCodeOffset == DEFAULT_CALLBACK_REQUEST_CODE_OFFSET) {
                callbackRequestCodeOffset = applicationInfo.metaData.getInt(CALLBACK_OFFSET_PROPERTY, DEFAULT_CALLBACK_REQUEST_CODE_OFFSET);
            }
            if (autoLogAppEventsEnabled == null) {
                autoLogAppEventsEnabled = Boolean.valueOf(applicationInfo.metaData.getBoolean(AUTO_LOG_APP_EVENTS_ENABLED_PROPERTY, true));
            }
        } catch (PackageManager.NameNotFoundException unused) {
        }
    }

    static void publishInstallAndWaitForResponse(Context context, String str) {
        try {
            if (context == null || str == null) {
                throw new IllegalArgumentException("Both context and applicationId must be non-null");
            }
            AttributionIdentifiers attributionIdentifiers = AttributionIdentifiers.getAttributionIdentifiers(context);
            SharedPreferences sharedPreferences = context.getSharedPreferences(ATTRIBUTION_PREFERENCES, 0);
            String str2 = str + "ping";
            long j = sharedPreferences.getLong(str2, 0L);
            try {
                GraphRequest graphRequestNewPostRequest = GraphRequest.newPostRequest(null, String.format(PUBLISH_ACTIVITY_PATH, str), AppEventsLoggerUtility.getJSONObjectForGraphAPICall(AppEventsLoggerUtility.GraphAPIActivityType.MOBILE_INSTALL_EVENT, attributionIdentifiers, AppEventsLogger.getAnonymousAppDeviceGUID(context), getLimitEventAndDataUsage(context), context), null);
                if (j == 0) {
                    graphRequestNewPostRequest.executeAndWait();
                    SharedPreferences.Editor editorEdit = sharedPreferences.edit();
                    editorEdit.putLong(str2, System.currentTimeMillis());
                    editorEdit.apply();
                }
            } catch (JSONException e) {
                throw new FacebookException("An error occurred while publishing install.", e);
            }
        } catch (Exception e2) {
            Utility.logd("Facebook-publish", e2);
        }
    }

    public static void publishInstallAsync(Context context, final String str) {
        final Context applicationContext2 = context.getApplicationContext();
        getExecutor().execute(new Runnable() { // from class: com.facebook.FacebookSdk.4
            @Override // java.lang.Runnable
            public void run() {
                FacebookSdk.publishInstallAndWaitForResponse(applicationContext2, str);
            }
        });
    }

    public static void removeLoggingBehavior(LoggingBehavior loggingBehavior) {
        synchronized (loggingBehaviors) {
            loggingBehaviors.remove(loggingBehavior);
        }
    }

    @Deprecated
    public static synchronized void sdkInitialize(Context context) {
        sdkInitialize(context, (InitializeCallback) null);
    }

    @Deprecated
    public static synchronized void sdkInitialize(Context context, int i) {
        sdkInitialize(context, i, null);
    }

    @Deprecated
    public static synchronized void sdkInitialize(Context context, int i, InitializeCallback initializeCallback) {
        if (sdkInitialized.booleanValue() && i != callbackRequestCodeOffset) {
            throw new FacebookException(CALLBACK_OFFSET_CHANGED_AFTER_INIT);
        }
        if (i < 0) {
            throw new FacebookException(CALLBACK_OFFSET_NEGATIVE);
        }
        callbackRequestCodeOffset = i;
        sdkInitialize(context, initializeCallback);
    }

    @Deprecated
    public static synchronized void sdkInitialize(final Context context, final InitializeCallback initializeCallback) {
        if (sdkInitialized.booleanValue()) {
            if (initializeCallback != null) {
                initializeCallback.onInitialized();
            }
            return;
        }
        Validate.notNull(context, "applicationContext");
        Validate.hasFacebookActivity(context, false);
        Validate.hasInternetPermissions(context, false);
        applicationContext = context.getApplicationContext();
        loadDefaultsFromMetadata(applicationContext);
        if (Utility.isNullOrEmpty(applicationId)) {
            throw new FacebookException("A valid Facebook app id must be set in the AndroidManifest.xml or set by calling FacebookSdk.setApplicationId before initializing the sdk.");
        }
        if ((applicationContext instanceof Application) && autoLogAppEventsEnabled.booleanValue()) {
            ActivityLifecycleTracker.startTracking((Application) applicationContext, applicationId);
        }
        sdkInitialized = true;
        FetchedAppSettingsManager.loadAppSettingsAsync();
        NativeProtocol.updateAllAvailableProtocolVersionsAsync();
        BoltsMeasurementEventListener.getInstance(applicationContext);
        cacheDir = new LockOnGetVariable<>((Callable) new Callable<File>() { // from class: com.facebook.FacebookSdk.2
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // java.util.concurrent.Callable
            public File call() {
                return FacebookSdk.applicationContext.getCacheDir();
            }
        });
        getExecutor().execute(new FutureTask(new Callable<Void>() { // from class: com.facebook.FacebookSdk.3
            @Override // java.util.concurrent.Callable
            public Void call() {
                AccessTokenManager.getInstance().loadCurrentAccessToken();
                ProfileManager.getInstance().loadCurrentProfile();
                if (AccessToken.getCurrentAccessToken() != null && Profile.getCurrentProfile() == null) {
                    Profile.fetchProfileForCurrentAccessToken();
                }
                if (initializeCallback != null) {
                    initializeCallback.onInitialized();
                }
                AppEventsLogger.initializeLib(FacebookSdk.applicationContext, FacebookSdk.applicationId);
                AppEventsLogger.newLogger(context.getApplicationContext()).flush();
                return null;
            }
        }));
    }

    public static void setApplicationId(String str) {
        applicationId = str;
    }

    public static void setApplicationName(String str) {
        applicationName = str;
    }

    public static void setAutoLogAppEventsEnabled(boolean z) {
        autoLogAppEventsEnabled = Boolean.valueOf(z);
    }

    public static void setCacheDir(File file) {
        cacheDir = new LockOnGetVariable<>(file);
    }

    public static void setClientToken(String str) {
        appClientToken = str;
    }

    public static void setExecutor(Executor executor2) {
        Validate.notNull(executor2, "executor");
        synchronized (LOCK) {
            executor = executor2;
        }
    }

    public static void setFacebookDomain(String str) {
        Log.w(TAG, "WARNING: Calling setFacebookDomain from non-DEBUG code.");
        facebookDomain = str;
    }

    public static void setGraphApiVersion(String str) {
        if (Utility.isNullOrEmpty(str) || graphApiVersion.equals(str)) {
            return;
        }
        graphApiVersion = str;
    }

    public static void setIsDebugEnabled(boolean z) {
        isDebugEnabled = z;
    }

    public static void setLegacyTokenUpgradeSupported(boolean z) {
        isLegacyTokenUpgradeSupported = z;
    }

    public static void setLimitEventAndDataUsage(Context context, boolean z) {
        context.getSharedPreferences(AppEventsLogger.APP_EVENT_PREFERENCES, 0).edit().putBoolean("limitEventUsage", z).apply();
    }

    public static void setOnProgressThreshold(long j) {
        onProgressThreshold.set(j);
    }

    private static void updateGraphDebugBehavior() {
        if (!loggingBehaviors.contains(LoggingBehavior.GRAPH_API_DEBUG_INFO) || loggingBehaviors.contains(LoggingBehavior.GRAPH_API_DEBUG_WARNING)) {
            return;
        }
        loggingBehaviors.add(LoggingBehavior.GRAPH_API_DEBUG_WARNING);
    }
}
