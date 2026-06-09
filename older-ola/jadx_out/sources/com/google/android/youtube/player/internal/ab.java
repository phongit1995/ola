package com.google.android.youtube.player.internal;

import android.app.Activity;
import android.content.Context;
import com.google.android.youtube.player.YouTubeThumbnailLoader;
import com.google.android.youtube.player.YouTubeThumbnailView;
import com.google.android.youtube.player.internal.t;

/* JADX INFO: loaded from: classes2.dex */
public abstract class ab {
    private static final ab a = b();

    public static ab a() {
        return a;
    }

    private static ab b() {
        try {
            try {
                return (ab) Class.forName("com.google.android.youtube.api.locallylinked.LocallyLinkedFactory").asSubclass(ab.class).newInstance();
            } catch (IllegalAccessException e) {
                throw new IllegalStateException(e);
            } catch (InstantiationException e2) {
                throw new IllegalStateException(e2);
            }
        } catch (ClassNotFoundException unused) {
            return new ad();
        }
    }

    public abstract YouTubeThumbnailLoader a(b bVar, YouTubeThumbnailView youTubeThumbnailView);

    public abstract b a(Context context, String str, t.a aVar, t.b bVar);

    public abstract d a(Activity activity, b bVar);
}
