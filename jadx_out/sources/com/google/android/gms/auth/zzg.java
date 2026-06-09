package com.google.android.gms.auth;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.ComponentName;
import android.content.Context;
import android.os.Bundle;
import android.os.RemoteException;
import android.os.SystemClock;
import android.support.annotation.RequiresPermission;
import android.text.TextUtils;
import com.google.android.gms.common.BlockingServiceConnection;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.GooglePlayServicesUtilLight;
import com.google.android.gms.common.internal.GmsClientSupervisor;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.common.util.GmsVersion;
import java.io.IOException;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class zzg {
    public static final int CHANGE_TYPE_ACCOUNT_ADDED = 1;
    public static final int CHANGE_TYPE_ACCOUNT_REMOVED = 2;
    public static final int CHANGE_TYPE_ACCOUNT_RENAMED_FROM = 3;
    public static final int CHANGE_TYPE_ACCOUNT_RENAMED_TO = 4;
    public static final String GOOGLE_ACCOUNT_TYPE = "com.google";

    @SuppressLint({"InlinedApi"})
    public static final String KEY_ANDROID_PACKAGE_NAME = "androidPackageName";

    @SuppressLint({"InlinedApi"})
    public static final String KEY_CALLER_UID = "callerUid";
    public static final String KEY_SUPPRESS_PROGRESS_SCREEN = "suppressProgressScreen";
    public static final String WORK_ACCOUNT_TYPE = "com.google.work";
    private static final String[] ACCEPTABLE_ACCOUNT_TYPES = {"com.google", "com.google.work", "cn.google"};
    private static final ComponentName zzp = new ComponentName("com.google.android.gms", "com.google.android.gms.auth.GetToken");
    private static final Logger zzq = new Logger("Auth", "GoogleAuthUtil");

    zzg() {
    }

    public static void clearToken(Context context, String str) throws GoogleAuthException, IOException {
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        ensurePlayServicesAvailable(context, GmsVersion.VERSION_URDA);
        Bundle bundle = new Bundle();
        String str2 = context.getApplicationInfo().packageName;
        bundle.putString("clientPackageName", str2);
        if (!bundle.containsKey(KEY_ANDROID_PACKAGE_NAME)) {
            bundle.putString(KEY_ANDROID_PACKAGE_NAME, str2);
        }
        zzd(context, zzp, new zzi(str, bundle));
    }

    private static void ensurePlayServicesAvailable(Context context, int i) throws GoogleAuthException {
        try {
            GooglePlayServicesUtilLight.ensurePlayServicesAvailable(context.getApplicationContext(), i);
        } catch (GooglePlayServicesNotAvailableException e) {
            throw new GoogleAuthException(e.getMessage());
        } catch (GooglePlayServicesRepairableException e2) {
            throw new GooglePlayServicesAvailabilityException(e2.getConnectionStatusCode(), e2.getMessage(), e2.getIntent());
        }
    }

    public static List<AccountChangeEvent> getAccountChangeEvents(Context context, int i, String str) throws GoogleAuthException {
        Preconditions.checkNotEmpty(str, "accountName must be provided");
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        ensurePlayServicesAvailable(context, GmsVersion.VERSION_URDA);
        return (List) zzd(context, zzp, new zzj(str, i));
    }

    public static String getAccountId(Context context, String str) throws GoogleAuthException {
        Preconditions.checkNotEmpty(str, "accountName must be provided");
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        ensurePlayServicesAvailable(context, GmsVersion.VERSION_URDA);
        return getToken(context, str, "^^_account_id_^^", new Bundle());
    }

    public static String getToken(Context context, Account account, String str) {
        return getToken(context, account, str, new Bundle());
    }

    public static String getToken(Context context, Account account, String str, Bundle bundle) {
        zze(account);
        return zze(context, account, str, bundle).zze();
    }

    @Deprecated
    public static String getToken(Context context, String str, String str2) {
        return getToken(context, new Account(str, "com.google"), str2);
    }

    @Deprecated
    public static String getToken(Context context, String str, String str2, Bundle bundle) {
        return getToken(context, new Account(str, "com.google"), str2, bundle);
    }

    @RequiresPermission("android.permission.MANAGE_ACCOUNTS")
    @Deprecated
    public static void invalidateToken(Context context, String str) {
        AccountManager.get(context).invalidateAuthToken("com.google", str);
    }

    @TargetApi(23)
    public static Bundle removeAccount(Context context, Account account) throws GoogleAuthException {
        Preconditions.checkNotNull(context);
        zze(account);
        ensurePlayServicesAvailable(context, GmsVersion.VERSION_URDA);
        return (Bundle) zzd(context, zzp, new zzk(account));
    }

    @TargetApi(26)
    public static Boolean requestGoogleAccountsAccess(Context context) throws GoogleAuthException {
        Preconditions.checkNotNull(context);
        ensurePlayServicesAvailable(context, 11400000);
        return (Boolean) zzd(context, zzp, new zzl(context.getApplicationInfo().packageName));
    }

    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    private static <T> T zzd(Context context, ComponentName componentName, zzm<T> zzmVar) throws IOException {
        BlockingServiceConnection blockingServiceConnection = new BlockingServiceConnection();
        GmsClientSupervisor gmsClientSupervisor = GmsClientSupervisor.getInstance(context);
        if (!gmsClientSupervisor.bindService(componentName, blockingServiceConnection, "GoogleAuthUtil")) {
            throw new IOException("Could not bind to service.");
        }
        try {
            try {
                return zzmVar.zze(blockingServiceConnection.getService());
            } catch (RemoteException | InterruptedException e) {
                zzq.i("GoogleAuthUtil", "Error on service connection.", e);
                throw new IOException("Error on service connection.", e);
            }
        } finally {
            gmsClientSupervisor.unbindService(componentName, blockingServiceConnection, "GoogleAuthUtil");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <T> T zzd(T t) throws IOException {
        if (t != null) {
            return t;
        }
        zzq.w("GoogleAuthUtil", "Binder call returned null.");
        throw new IOException("Service unavailable.");
    }

    public static TokenData zze(Context context, Account account, String str, Bundle bundle) throws GoogleAuthException {
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        Preconditions.checkNotEmpty(str, "Scope cannot be empty or null.");
        zze(account);
        ensurePlayServicesAvailable(context, GmsVersion.VERSION_URDA);
        Bundle bundle2 = bundle == null ? new Bundle() : new Bundle(bundle);
        String str2 = context.getApplicationInfo().packageName;
        bundle2.putString("clientPackageName", str2);
        if (TextUtils.isEmpty(bundle2.getString(KEY_ANDROID_PACKAGE_NAME))) {
            bundle2.putString(KEY_ANDROID_PACKAGE_NAME, str2);
        }
        bundle2.putLong("service_connection_start_time_millis", SystemClock.elapsedRealtime());
        return (TokenData) zzd(context, zzp, new zzh(account, str, bundle2));
    }

    private static void zze(Account account) {
        if (account == null) {
            throw new IllegalArgumentException("Account cannot be null");
        }
        if (TextUtils.isEmpty(account.name)) {
            throw new IllegalArgumentException("Account name cannot be empty!");
        }
        for (String str : ACCEPTABLE_ACCOUNT_TYPES) {
            if (str.equals(account.type)) {
                return;
            }
        }
        throw new IllegalArgumentException("Account type not supported");
    }
}
