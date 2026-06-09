package com.facebook.accountkit.internal;

import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ProviderInfo;
import android.content.pm.Signature;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.util.Log;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.HashSet;
import java.util.TreeSet;

/* JADX INFO: loaded from: classes.dex */
abstract class NativeAppInfo {
    private static final String FBI_HASH = "a4b7452e2ed8f5f191058ca7bbfd26b0d3214bfc";
    private static final String FBL2_HASH = "df6b721c8b4d3b6eb44c861d4415007e5a35fc95";
    private static final String FBL_HASH = "5e8f16062ea3cd2c4a0d547876baa6f38cabf625";
    private static final String FBR2_HASH = "cc2751449a350f668590264ed76692694a80308a";
    private static final String FBR_HASH = "8a3c4b262d721acd49a4bf97d5213199c86fa2b9";
    private static final String TAG = "NativeAppInfo";
    private static final HashSet<String> validAppSignatureHashes = buildAppSignatureHashes();
    private boolean appInstalled;
    private TreeSet<Integer> availableVersions;

    NativeAppInfo() {
    }

    private static HashSet<String> buildAppSignatureHashes() {
        HashSet<String> hashSet = new HashSet<>();
        hashSet.add(FBR_HASH);
        hashSet.add(FBR2_HASH);
        hashSet.add(FBI_HASH);
        hashSet.add(FBL_HASH);
        hashSet.add(FBL2_HASH);
        return hashSet;
    }

    public synchronized void fetchAvailableVersions(boolean z) {
        ProviderInfo providerInfoResolveContentProvider;
        if (this.availableVersions == null || z) {
            TreeSet<Integer> treeSet = new TreeSet<>();
            ContentResolver contentResolver = AccountKitController.getApplicationContext().getContentResolver();
            String[] strArr = {"version"};
            Uri uri = Uri.parse("content://" + getPackage() + ".provider.PlatformProvider/versions");
            Cursor cursorQuery = null;
            try {
                try {
                    providerInfoResolveContentProvider = AccountKitController.getApplicationContext().getPackageManager().resolveContentProvider(getPackage() + ".provider.PlatformProvider", 0);
                } catch (RuntimeException e) {
                    Log.e(TAG, "Failed to query content resolver.", e);
                    providerInfoResolveContentProvider = null;
                }
                if (providerInfoResolveContentProvider != null) {
                    try {
                        cursorQuery = contentResolver.query(uri, strArr, null, null, null);
                    } catch (NullPointerException | SecurityException unused) {
                        Log.e(TAG, "Failed to query content resolver.");
                    }
                    if (cursorQuery != null) {
                        while (cursorQuery.moveToNext()) {
                            treeSet.add(Integer.valueOf(cursorQuery.getInt(cursorQuery.getColumnIndex("version"))));
                        }
                    }
                }
                this.availableVersions = treeSet;
            } finally {
                if (cursorQuery != null) {
                    this.appInstalled = true;
                    cursorQuery.close();
                }
            }
        }
    }

    public TreeSet<Integer> getAvailableVersions() {
        if (this.availableVersions == null) {
            fetchAvailableVersions(false);
        }
        return this.availableVersions;
    }

    protected abstract String getPackage();

    protected abstract Intent getPlatformServiceIntent();

    public boolean isAppInstalled() {
        if (this.availableVersions == null) {
            fetchAvailableVersions(false);
        }
        return this.appInstalled;
    }

    public boolean validateSignature(Context context, String str) {
        String str2 = Build.BRAND;
        int i = context.getApplicationInfo().flags;
        if (str2.startsWith(MessengerShareContentUtility.TEMPLATE_GENERIC_TYPE) && (i & 2) != 0) {
            return true;
        }
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(str, 64);
            if (packageInfo.signatures == null || packageInfo.signatures.length <= 0) {
                return false;
            }
            for (Signature signature : packageInfo.signatures) {
                if (!validAppSignatureHashes.contains(Utility.sha1hash(signature.toByteArray()))) {
                    return false;
                }
            }
            return true;
        } catch (PackageManager.NameNotFoundException unused) {
        }
        return false;
    }
}
