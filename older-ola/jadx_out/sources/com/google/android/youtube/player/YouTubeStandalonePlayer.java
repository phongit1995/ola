package com.google.android.youtube.player;

import android.app.Activity;
import android.content.Intent;
import com.google.android.youtube.player.internal.z;

/* JADX INFO: loaded from: classes2.dex */
public final class YouTubeStandalonePlayer {
    private YouTubeStandalonePlayer() {
    }

    private static Intent a(Intent intent, Activity activity, String str, int i, boolean z, boolean z2) {
        intent.putExtra("developer_key", str).putExtra("app_package", activity.getPackageName()).putExtra("app_version", z.d(activity)).putExtra("autoplay", z).putExtra("lightbox_mode", z2).putExtra("start_time_millis", i).putExtra("window_has_status_bar", (activity.getWindow().getAttributes().flags & 1024) == 0);
        return intent;
    }

    public static Intent createPlaylistIntent(Activity activity, String str, String str2) {
        return createPlaylistIntent(activity, str, str2, 0, 0, false, false);
    }

    public static Intent createPlaylistIntent(Activity activity, String str, String str2, int i, int i2, boolean z, boolean z2) {
        return a(new Intent("com.google.android.youtube.api.StandalonePlayerActivity.START").putExtra("playlist_id", str2).putExtra("current_index", i), activity, str, i2, z, z2);
    }

    public static Intent createVideoIntent(Activity activity, String str, String str2) {
        return createVideoIntent(activity, str, str2, 0, false, false);
    }

    public static Intent createVideoIntent(Activity activity, String str, String str2, int i, boolean z, boolean z2) {
        return a(new Intent("com.google.android.youtube.api.StandalonePlayerActivity.START").putExtra("video_id", str2), activity, str, i, z, z2);
    }

    public static YouTubeInitializationResult getReturnedInitializationResult(Intent intent) {
        try {
            return YouTubeInitializationResult.valueOf(intent.getExtras().getString("initialization_result"));
        } catch (IllegalArgumentException unused) {
            return YouTubeInitializationResult.UNKNOWN_ERROR;
        } catch (NullPointerException unused2) {
            return YouTubeInitializationResult.UNKNOWN_ERROR;
        }
    }
}
