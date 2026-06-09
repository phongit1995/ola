package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: loaded from: classes.dex */
final class NativeProtocol {
    static final String CONTENT_SCHEME = "content://";
    static final String EXTRA_APPLICATION_ID = "com.facebook.platform.extra.APPLICATION_ID";
    static final String EXTRA_EXPIRES_SECONDS_SINCE_EPOCH = "com.facebook.platform.extra.EXPIRES_SECONDS_SINCE_EPOCH";
    static final String EXTRA_SEAMLESS_LOGIN_TOKEN = "com.facebook.platform.extra.SEAMLESS_LOGIN_TOKEN";
    private static final String INTENT_ACTION_FBLITE_PLATFORM_SERVICE = "com.facebook.lite.platform.PLATFORM_SERVICE";
    private static final String INTENT_ACTION_PLATFORM_SERVICE = "com.facebook.platform.PLATFORM_SERVICE";
    static final int MESSAGE_GET_AK_SEAMLESS_TOKEN_REPLY = 65545;
    static final int MESSAGE_GET_AK_SEAMLESS_TOKEN_REQUEST = 65544;
    static final String PLATFORM_PROVIDER = ".provider.PlatformProvider";
    static final String PLATFORM_PROVIDER_VERSIONS = ".provider.PlatformProvider/versions";
    static final String PLATFORM_PROVIDER_VERSION_COLUMN = "version";
    static final int PROTOCOL_VERSION_20161017 = 20161017;
    static final String STATUS_ERROR_TYPE = "com.facebook.platform.status.ERROR_TYPE";
    private static List<NativeAppInfo> facebookAppInfoList;
    private static AtomicBoolean protocolVersionsAsyncUpdating = new AtomicBoolean(false);

    private static class FBLiteAppInfo extends NativeAppInfo {
        private static final String FBLITE_PACKAGE = "com.facebook.lite";

        private FBLiteAppInfo() {
        }

        @Override // com.facebook.accountkit.internal.NativeAppInfo
        protected String getPackage() {
            return FBLITE_PACKAGE;
        }

        @Override // com.facebook.accountkit.internal.NativeAppInfo
        protected Intent getPlatformServiceIntent() {
            return new Intent(NativeProtocol.INTENT_ACTION_FBLITE_PLATFORM_SERVICE).setPackage(getPackage());
        }
    }

    private static class KatanaAppInfo extends NativeAppInfo {
        private static final String KATANA_PACKAGE = "com.facebook.katana";

        private KatanaAppInfo() {
        }

        @Override // com.facebook.accountkit.internal.NativeAppInfo
        protected String getPackage() {
            return KATANA_PACKAGE;
        }

        @Override // com.facebook.accountkit.internal.NativeAppInfo
        protected Intent getPlatformServiceIntent() {
            return new Intent(NativeProtocol.INTENT_ACTION_PLATFORM_SERVICE).setPackage(getPackage());
        }
    }

    private static class WakizashiAppInfo extends NativeAppInfo {
        private static final String WAKIZASHI_PACKAGE = "com.facebook.wakizashi";

        private WakizashiAppInfo() {
        }

        @Override // com.facebook.accountkit.internal.NativeAppInfo
        protected String getPackage() {
            return WAKIZASHI_PACKAGE;
        }

        @Override // com.facebook.accountkit.internal.NativeAppInfo
        protected Intent getPlatformServiceIntent() {
            return new Intent(NativeProtocol.INTENT_ACTION_PLATFORM_SERVICE).setPackage(getPackage());
        }
    }

    static {
        facebookAppInfoList = Arrays.asList(new KatanaAppInfo(), new WakizashiAppInfo(), new FBLiteAppInfo());
    }

    NativeProtocol() {
    }

    static Intent createPlatformServiceIntent(Context context) {
        for (NativeAppInfo nativeAppInfo : facebookAppInfoList) {
            Intent intentValidateServiceIntent = validateServiceIntent(context, nativeAppInfo.getPlatformServiceIntent().addCategory("android.intent.category.DEFAULT"), nativeAppInfo);
            if (intentValidateServiceIntent != null) {
                return intentValidateServiceIntent;
            }
        }
        return null;
    }

    static void updateAllAvailableProtocolVersionsAsync() {
        if (protocolVersionsAsyncUpdating.compareAndSet(false, true)) {
            Utility.getThreadPoolExecutor().execute(new Runnable() { // from class: com.facebook.accountkit.internal.NativeProtocol.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        Iterator it2 = NativeProtocol.facebookAppInfoList.iterator();
                        while (it2.hasNext()) {
                            ((NativeAppInfo) it2.next()).fetchAvailableVersions(true);
                        }
                    } finally {
                        NativeProtocol.protocolVersionsAsyncUpdating.set(false);
                    }
                }
            });
        }
    }

    static boolean validateApplicationForService() {
        Iterator<NativeAppInfo> it2 = facebookAppInfoList.iterator();
        while (it2.hasNext()) {
            if (it2.next().isAppInstalled()) {
                return true;
            }
        }
        return false;
    }

    static boolean validateProtocolVersionForService(int i) {
        Iterator<NativeAppInfo> it2 = facebookAppInfoList.iterator();
        while (it2.hasNext()) {
            if (it2.next().getAvailableVersions().contains(Integer.valueOf(i))) {
                return true;
            }
        }
        return false;
    }

    private static Intent validateServiceIntent(Context context, Intent intent, NativeAppInfo nativeAppInfo) {
        ResolveInfo resolveInfoResolveService = context.getPackageManager().resolveService(intent, 0);
        if (resolveInfoResolveService != null && nativeAppInfo.validateSignature(context, resolveInfoResolveService.serviceInfo.packageName)) {
            return intent;
        }
        return null;
    }
}
