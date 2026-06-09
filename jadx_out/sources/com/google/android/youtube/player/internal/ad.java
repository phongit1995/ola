package com.google.android.youtube.player.internal;

import android.app.Activity;
import android.content.Context;
import com.google.android.youtube.player.YouTubeThumbnailLoader;
import com.google.android.youtube.player.YouTubeThumbnailView;
import com.google.android.youtube.player.internal.t;

/* JADX INFO: loaded from: classes2.dex */
public final class ad extends ab {
    @Override // com.google.android.youtube.player.internal.ab
    public final YouTubeThumbnailLoader a(b bVar, YouTubeThumbnailView youTubeThumbnailView) {
        return new p(bVar, youTubeThumbnailView);
    }

    @Override // com.google.android.youtube.player.internal.ab
    public final b a(Context context, String str, t.a aVar, t.b bVar) {
        return new o(context, str, context.getPackageName(), z.d(context), aVar, bVar);
    }

    @Override // com.google.android.youtube.player.internal.ab
    public final d a(Activity activity, b bVar) {
        return w.a(activity, bVar.a());
    }
}
