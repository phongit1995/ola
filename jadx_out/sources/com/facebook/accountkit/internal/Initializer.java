package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import java.lang.reflect.Method;
import java.net.CookieManager;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public final class Initializer {
    private final ArrayList<AccountKit.InitializeCallback> callbacks = new ArrayList<>();
    private volatile Data data = null;
    private volatile State state = State.UNINITIALIZED;

    private static final class Data {
        final AccessTokenManager accessTokenManager;
        final Context applicationContext;
        final String applicationId;
        final String applicationName;
        final String clientToken;
        final LocalBroadcastManager localBroadcastManager;
        final LoginManager loginManager;
        final UpdateManager updateManager;

        Data(Context context, String str, String str2, String str3, AccessTokenManager accessTokenManager, LocalBroadcastManager localBroadcastManager, LoginManager loginManager, UpdateManager updateManager) {
            this.applicationContext = context;
            this.applicationId = str;
            this.applicationName = str2;
            this.clientToken = str3;
            this.accessTokenManager = accessTokenManager;
            this.localBroadcastManager = localBroadcastManager;
            this.loginManager = loginManager;
            this.updateManager = updateManager;
        }
    }

    private enum State {
        UNINITIALIZED,
        INITIALIZED,
        FAILED
    }

    private static void fixSamsungClipboardUIManagerMemoryLeak(Context context) {
        if (Build.VERSION.SDK_INT >= 21) {
            try {
                Method declaredMethod = Class.forName("android.sec.clipboard.ClipboardUIManager").getDeclaredMethod("getInstance", Context.class);
                declaredMethod.setAccessible(true);
                declaredMethod.invoke(null, context);
            } catch (Exception unused) {
            }
        }
    }

    private static String getRequiredString(Bundle bundle, String str, InternalAccountKitError internalAccountKitError) {
        String string = bundle.getString(str);
        if (string == null) {
            throw new AccountKitException(AccountKitError.Type.INITIALIZATION_ERROR, internalAccountKitError);
        }
        return string;
    }

    private boolean isValidLocale(String str) {
        for (Locale locale : Locale.getAvailableLocales()) {
            if (str.equalsIgnoreCase(locale.toString())) {
                return true;
            }
        }
        return false;
    }

    private synchronized void loadAccessToken() {
        if (!isInitialized()) {
            this.data.accessTokenManager.loadCurrentAccessToken();
            Iterator<AccountKit.InitializeCallback> it2 = this.callbacks.iterator();
            while (it2.hasNext()) {
                it2.next().onInitialized();
            }
            this.callbacks.clear();
        }
    }

    private void setDefaultLocale(Context context, String str) {
        if (isValidLocale(str)) {
            Locale locale = new Locale(str);
            Configuration configuration = context.getResources().getConfiguration();
            configuration.locale = locale;
            context.getResources().updateConfiguration(configuration, null);
        }
    }

    AccessTokenManager getAccessTokenManager() {
        Validate.sdkInitialized();
        return this.data.accessTokenManager;
    }

    boolean getAccountKitFacebookAppEventsEnabled() {
        return getLogger().getFacebookAppEventsEnabled();
    }

    public Context getApplicationContext() {
        Validate.sdkInitialized();
        return this.data.applicationContext;
    }

    public String getApplicationId() {
        Validate.sdkInitialized();
        return this.data.applicationId;
    }

    String getApplicationName() {
        Validate.sdkInitialized();
        return this.data.applicationName;
    }

    String getClientToken() {
        Validate.sdkInitialized();
        return this.data.clientToken;
    }

    public InternalLogger getLogger() {
        Validate.sdkInitialized();
        return this.data.loginManager.getLogger();
    }

    LoginManager getLoginManager() {
        Validate.sdkInitialized();
        return this.data.loginManager;
    }

    UpdateManager getUpdateManager() {
        Validate.sdkInitialized();
        return this.data.updateManager;
    }

    public synchronized void initialize(@NonNull Context context, AccountKit.InitializeCallback initializeCallback) {
        ApplicationInfo applicationInfo;
        if (isInitialized()) {
            if (initializeCallback != null) {
                initializeCallback.onInitialized();
            }
            return;
        }
        if (initializeCallback != null) {
            this.callbacks.add(initializeCallback);
        }
        Validate.checkInternetPermissionAndThrow(context);
        Context applicationContext = context.getApplicationContext();
        fixSamsungClipboardUIManagerMemoryLeak(applicationContext);
        try {
            applicationInfo = applicationContext.getPackageManager().getApplicationInfo(applicationContext.getPackageName(), 128);
        } catch (PackageManager.NameNotFoundException unused) {
            applicationInfo = null;
        }
        if (applicationInfo != null && applicationInfo.metaData != null) {
            Bundle bundle = applicationInfo.metaData;
            String requiredString = getRequiredString(bundle, "com.facebook.sdk.ApplicationId", InternalAccountKitError.INVALID_APP_ID);
            String requiredString2 = getRequiredString(bundle, AccountKit.CLIENT_TOKEN_PROPERTY, InternalAccountKitError.INVALID_CLIENT_TOKEN);
            String requiredString3 = getRequiredString(bundle, AccountKit.APPLICATION_NAME_PROPERTY, InternalAccountKitError.INVALID_APP_NAME);
            boolean z = bundle.getBoolean(AccountKit.FACEBOOK_APP_EVENTS_ENABLED_PROPERTY, true);
            setDefaultLocale(context, bundle.getString(AccountKit.APPLICATION_DEFAULT_LANGUAGE, "en-us"));
            LocalBroadcastManager localBroadcastManager = LocalBroadcastManager.getInstance(applicationContext);
            InternalLogger internalLogger = new InternalLogger(context.getApplicationContext(), requiredString, z);
            AccessTokenManager accessTokenManager = new AccessTokenManager(applicationContext, localBroadcastManager);
            LoginManager loginManager = new LoginManager(internalLogger, accessTokenManager, localBroadcastManager);
            this.data = new Data(applicationContext, requiredString, requiredString3, requiredString2, accessTokenManager, localBroadcastManager, loginManager, new UpdateManager(internalLogger, localBroadcastManager));
            if (CookieManager.getDefault() == null) {
                CookieManager.setDefault(new CookieManager(new AccountKitCookieStore(context), null));
            }
            loadAccessToken();
            this.state = State.INITIALIZED;
            loginManager.getLogger().logEvent(InternalLogger.EVENT_NAME_SDK_START);
            NativeProtocol.updateAllAvailableProtocolVersionsAsync();
            return;
        }
        this.state = State.FAILED;
    }

    public boolean isInitialized() {
        return this.state == State.INITIALIZED;
    }
}
