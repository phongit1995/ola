package com.google.android.youtube.player;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import com.google.android.gms.actions.SearchIntents;
import com.google.android.youtube.player.internal.z;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class YouTubeIntents {
    private YouTubeIntents() {
    }

    private static Uri a(String str) {
        return Uri.parse("http://www.youtube.com/playlist?list=" + str);
    }

    private static String a(Context context) {
        return z.a(context.getPackageManager()) ? "com.google.android.youtube.googletv" : "com.google.android.youtube";
    }

    private static boolean a(Context context, Intent intent) {
        List<ResolveInfo> listQueryIntentActivities = context.getPackageManager().queryIntentActivities(intent, 65536);
        return (listQueryIntentActivities == null || listQueryIntentActivities.isEmpty()) ? false : true;
    }

    private static boolean a(Context context, Uri uri) {
        return a(context, new Intent("android.intent.action.VIEW", uri).setPackage(a(context)));
    }

    private static Intent b(Context context, Uri uri) {
        return new Intent("android.intent.action.VIEW", uri).setPackage(a(context));
    }

    public static boolean canResolveOpenPlaylistIntent(Context context) {
        return a(context, Uri.parse("http://www.youtube.com/playlist?list="));
    }

    public static boolean canResolvePlayPlaylistIntent(Context context) {
        int installedYouTubeVersionCode = getInstalledYouTubeVersionCode(context);
        return (!z.a(context.getPackageManager()) ? installedYouTubeVersionCode >= 4000 : installedYouTubeVersionCode >= Integer.MAX_VALUE) && canResolveOpenPlaylistIntent(context);
    }

    public static boolean canResolvePlayVideoIntent(Context context) {
        return a(context, Uri.parse("http://www.youtube.com/watch?v="));
    }

    public static boolean canResolveSearchIntent(Context context) {
        if (!z.a(context.getPackageManager()) || getInstalledYouTubeVersionCode(context) >= Integer.MAX_VALUE) {
            return a(context, new Intent("android.intent.action.SEARCH").setPackage(a(context)));
        }
        return false;
    }

    public static boolean canResolveUploadIntent(Context context) {
        return a(context, new Intent("com.google.android.youtube.intent.action.UPLOAD").setPackage(a(context)).setType("video/*"));
    }

    public static boolean canResolveUserIntent(Context context) {
        return a(context, Uri.parse("http://www.youtube.com/user/"));
    }

    public static Intent createOpenPlaylistIntent(Context context, String str) {
        Intent intentB = b(context, a(str));
        intentB.putExtra("authenticate", false);
        return intentB;
    }

    public static Intent createPlayPlaylistIntent(Context context, String str) {
        Intent intentB = b(context, a(str).buildUpon().appendQueryParameter("playnext", "1").build());
        intentB.putExtra("authenticate", false);
        return intentB;
    }

    public static Intent createPlayVideoIntent(Context context, String str) {
        return createPlayVideoIntentWithOptions(context, str, false, false);
    }

    public static Intent createPlayVideoIntentWithOptions(Context context, String str, boolean z, boolean z2) {
        return b(context, Uri.parse("http://www.youtube.com/watch?v=" + str)).putExtra("force_fullscreen", z).putExtra("finish_on_ended", z2);
    }

    public static Intent createSearchIntent(Context context, String str) {
        return new Intent("android.intent.action.SEARCH").setPackage(a(context)).putExtra(SearchIntents.EXTRA_QUERY, str);
    }

    public static Intent createUploadIntent(Context context, Uri uri) {
        if (uri == null) {
            throw new IllegalArgumentException("videoUri parameter cannot be null.");
        }
        if (uri.toString().startsWith("content://media/")) {
            return new Intent("com.google.android.youtube.intent.action.UPLOAD").setPackage(a(context)).setDataAndType(uri, "video/*");
        }
        throw new IllegalArgumentException("videoUri parameter must be a URI pointing to a valid video file. It must begin with \"content://media/\"");
    }

    public static Intent createUserIntent(Context context, String str) {
        return b(context, Uri.parse("http://www.youtube.com/user/" + str));
    }

    public static int getInstalledYouTubeVersionCode(Context context) {
        try {
            return context.getPackageManager().getPackageInfo(a(context), 0).versionCode;
        } catch (PackageManager.NameNotFoundException unused) {
            return -1;
        }
    }

    public static String getInstalledYouTubeVersionName(Context context) {
        try {
            return context.getPackageManager().getPackageInfo(a(context), 0).versionName;
        } catch (PackageManager.NameNotFoundException unused) {
            return null;
        }
    }

    public static boolean isYouTubeInstalled(Context context) {
        try {
            context.getPackageManager().getApplicationInfo(a(context), 0);
            return true;
        } catch (PackageManager.NameNotFoundException unused) {
            return false;
        }
    }

    public final boolean canResolvePlayVideoIntentWithOptions(Context context) {
        int installedYouTubeVersionCode = getInstalledYouTubeVersionCode(context);
        return (!z.a(context.getPackageManager()) ? installedYouTubeVersionCode >= 3300 : installedYouTubeVersionCode >= Integer.MAX_VALUE) && canResolvePlayVideoIntent(context);
    }
}
