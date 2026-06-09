package com.facebook.internal;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Looper;
import android.os.Parcel;
import android.support.annotation.Nullable;
import com.facebook.FacebookException;
import java.lang.reflect.Method;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: loaded from: classes.dex */
public class AttributionIdentifiers {
    private static final String ANDROID_ID_COLUMN_NAME = "androidid";
    private static final String ATTRIBUTION_ID_COLUMN_NAME = "aid";
    private static final String ATTRIBUTION_ID_CONTENT_PROVIDER = "com.facebook.katana.provider.AttributionIdProvider";
    private static final String ATTRIBUTION_ID_CONTENT_PROVIDER_WAKIZASHI = "com.facebook.wakizashi.provider.AttributionIdProvider";
    private static final int CONNECTION_RESULT_SUCCESS = 0;
    private static final long IDENTIFIER_REFRESH_INTERVAL_MILLIS = 3600000;
    private static final String LIMIT_TRACKING_COLUMN_NAME = "limit_tracking";
    private static final String TAG = AttributionIdentifiers.class.getCanonicalName();
    private static AttributionIdentifiers recentlyFetchedIdentifiers;
    private String androidAdvertiserId;
    private String androidInstallerPackage;
    private String attributionId;
    private long fetchTime;
    private boolean limitTracking;

    private static final class GoogleAdInfo implements IInterface {
        private static final int FIRST_TRANSACTION_CODE = 1;
        private static final int SECOND_TRANSACTION_CODE = 2;
        private IBinder binder;

        GoogleAdInfo(IBinder iBinder) {
            this.binder = iBinder;
        }

        @Override // android.os.IInterface
        public IBinder asBinder() {
            return this.binder;
        }

        public String getAdvertiserId() {
            Parcel parcelObtain = Parcel.obtain();
            Parcel parcelObtain2 = Parcel.obtain();
            try {
                parcelObtain.writeInterfaceToken("com.google.android.gms.ads.identifier.internal.IAdvertisingIdService");
                this.binder.transact(1, parcelObtain, parcelObtain2, 0);
                parcelObtain2.readException();
                return parcelObtain2.readString();
            } finally {
                parcelObtain2.recycle();
                parcelObtain.recycle();
            }
        }

        public boolean isTrackingLimited() {
            Parcel parcelObtain = Parcel.obtain();
            Parcel parcelObtain2 = Parcel.obtain();
            try {
                parcelObtain.writeInterfaceToken("com.google.android.gms.ads.identifier.internal.IAdvertisingIdService");
                parcelObtain.writeInt(1);
                this.binder.transact(2, parcelObtain, parcelObtain2, 0);
                parcelObtain2.readException();
                return parcelObtain2.readInt() != 0;
            } finally {
                parcelObtain2.recycle();
                parcelObtain.recycle();
            }
        }
    }

    private static final class GoogleAdServiceConnection implements ServiceConnection {
        private AtomicBoolean consumed;
        private final BlockingQueue<IBinder> queue;

        private GoogleAdServiceConnection() {
            this.consumed = new AtomicBoolean(false);
            this.queue = new LinkedBlockingDeque();
        }

        public IBinder getBinder() {
            if (this.consumed.compareAndSet(true, true)) {
                throw new IllegalStateException("Binder already consumed");
            }
            return this.queue.take();
        }

        @Override // android.content.ServiceConnection
        public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
            if (iBinder != null) {
                try {
                    this.queue.put(iBinder);
                } catch (InterruptedException unused) {
                }
            }
        }

        @Override // android.content.ServiceConnection
        public void onServiceDisconnected(ComponentName componentName) {
        }
    }

    private static AttributionIdentifiers cacheAndReturnIdentifiers(AttributionIdentifiers attributionIdentifiers) {
        attributionIdentifiers.fetchTime = System.currentTimeMillis();
        recentlyFetchedIdentifiers = attributionIdentifiers;
        return attributionIdentifiers;
    }

    private static AttributionIdentifiers getAndroidId(Context context) {
        AttributionIdentifiers androidIdViaReflection = getAndroidIdViaReflection(context);
        if (androidIdViaReflection != null) {
            return androidIdViaReflection;
        }
        AttributionIdentifiers androidIdViaService = getAndroidIdViaService(context);
        return androidIdViaService == null ? new AttributionIdentifiers() : androidIdViaService;
    }

    private static AttributionIdentifiers getAndroidIdViaReflection(Context context) {
        Method methodQuietly;
        Object objInvokeMethodQuietly;
        try {
            if (Looper.myLooper() == Looper.getMainLooper()) {
                throw new FacebookException("getAndroidId cannot be called on the main thread.");
            }
            Method methodQuietly2 = Utility.getMethodQuietly("com.google.android.gms.common.GooglePlayServicesUtil", "isGooglePlayServicesAvailable", (Class<?>[]) new Class[]{Context.class});
            if (methodQuietly2 == null) {
                return null;
            }
            Object objInvokeMethodQuietly2 = Utility.invokeMethodQuietly(null, methodQuietly2, context);
            if (!(objInvokeMethodQuietly2 instanceof Integer) || ((Integer) objInvokeMethodQuietly2).intValue() != 0 || (methodQuietly = Utility.getMethodQuietly("com.google.android.gms.ads.identifier.AdvertisingIdClient", "getAdvertisingIdInfo", (Class<?>[]) new Class[]{Context.class})) == null || (objInvokeMethodQuietly = Utility.invokeMethodQuietly(null, methodQuietly, context)) == null) {
                return null;
            }
            Method methodQuietly3 = Utility.getMethodQuietly(objInvokeMethodQuietly.getClass(), "getId", (Class<?>[]) new Class[0]);
            Method methodQuietly4 = Utility.getMethodQuietly(objInvokeMethodQuietly.getClass(), "isLimitAdTrackingEnabled", (Class<?>[]) new Class[0]);
            if (methodQuietly3 == null || methodQuietly4 == null) {
                return null;
            }
            AttributionIdentifiers attributionIdentifiers = new AttributionIdentifiers();
            attributionIdentifiers.androidAdvertiserId = (String) Utility.invokeMethodQuietly(objInvokeMethodQuietly, methodQuietly3, new Object[0]);
            attributionIdentifiers.limitTracking = ((Boolean) Utility.invokeMethodQuietly(objInvokeMethodQuietly, methodQuietly4, new Object[0])).booleanValue();
            return attributionIdentifiers;
        } catch (Exception e) {
            Utility.logd("android_id", e);
            return null;
        }
    }

    private static AttributionIdentifiers getAndroidIdViaService(Context context) {
        GoogleAdServiceConnection googleAdServiceConnection = new GoogleAdServiceConnection();
        Intent intent = new Intent("com.google.android.gms.ads.identifier.service.START");
        intent.setPackage("com.google.android.gms");
        if (!context.bindService(intent, googleAdServiceConnection, 1)) {
            return null;
        }
        try {
            GoogleAdInfo googleAdInfo = new GoogleAdInfo(googleAdServiceConnection.getBinder());
            AttributionIdentifiers attributionIdentifiers = new AttributionIdentifiers();
            attributionIdentifiers.androidAdvertiserId = googleAdInfo.getAdvertiserId();
            attributionIdentifiers.limitTracking = googleAdInfo.isTrackingLimited();
            return attributionIdentifiers;
        } catch (Exception e) {
            Utility.logd("android_id", e);
            return null;
        } finally {
            context.unbindService(googleAdServiceConnection);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:22:0x006a A[Catch: all -> 0x00d6, Exception -> 0x00d8, TryCatch #4 {Exception -> 0x00d8, all -> 0x00d6, blocks: (B:12:0x002f, B:15:0x004e, B:20:0x0064, B:22:0x006a, B:24:0x006e, B:26:0x0073, B:16:0x0054), top: B:65:0x002f }] */
    /* JADX WARN: Removed duplicated region for block: B:24:0x006e A[Catch: all -> 0x00d6, Exception -> 0x00d8, TryCatch #4 {Exception -> 0x00d8, all -> 0x00d6, blocks: (B:12:0x002f, B:15:0x004e, B:20:0x0064, B:22:0x006a, B:24:0x006e, B:26:0x0073, B:16:0x0054), top: B:65:0x002f }] */
    /* JADX WARN: Removed duplicated region for block: B:26:0x0073 A[Catch: all -> 0x00d6, Exception -> 0x00d8, TRY_LEAVE, TryCatch #4 {Exception -> 0x00d8, all -> 0x00d6, blocks: (B:12:0x002f, B:15:0x004e, B:20:0x0064, B:22:0x006a, B:24:0x006e, B:26:0x0073, B:16:0x0054), top: B:65:0x002f }] */
    /* JADX WARN: Removed duplicated region for block: B:60:0x00fe  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static com.facebook.internal.AttributionIdentifiers getAttributionIdentifiers(android.content.Context r10) {
        /*
            Method dump skipped, instruction units count: 258
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.internal.AttributionIdentifiers.getAttributionIdentifiers(android.content.Context):com.facebook.internal.AttributionIdentifiers");
    }

    @Nullable
    private static String getInstallerPackageName(Context context) {
        PackageManager packageManager = context.getPackageManager();
        if (packageManager != null) {
            return packageManager.getInstallerPackageName(context.getPackageName());
        }
        return null;
    }

    public String getAndroidAdvertiserId() {
        return this.androidAdvertiserId;
    }

    public String getAndroidInstallerPackage() {
        return this.androidInstallerPackage;
    }

    public String getAttributionId() {
        return this.attributionId;
    }

    public boolean isTrackingLimited() {
        return this.limitTracking;
    }
}
