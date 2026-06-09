package com.google.android.youtube.player;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.ImageView;
import com.google.android.youtube.player.internal.ab;
import com.google.android.youtube.player.internal.b;
import com.google.android.youtube.player.internal.t;

/* JADX INFO: loaded from: classes2.dex */
public final class YouTubeThumbnailView extends ImageView {
    private b a;

    public interface OnInitializedListener {
        void onInitializationFailure(YouTubeThumbnailView youTubeThumbnailView, YouTubeInitializationResult youTubeInitializationResult);

        void onInitializationSuccess(YouTubeThumbnailView youTubeThumbnailView, YouTubeThumbnailLoader youTubeThumbnailLoader);
    }

    public YouTubeThumbnailView(Context context) {
        this(context, null);
    }

    public YouTubeThumbnailView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public YouTubeThumbnailView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }

    static /* synthetic */ b b(YouTubeThumbnailView youTubeThumbnailView) {
        youTubeThumbnailView.a = null;
        return null;
    }

    public final void initialize(String str, final OnInitializedListener onInitializedListener) {
        this.a = ab.a().a(getContext(), str, new t.a() { // from class: com.google.android.youtube.player.YouTubeThumbnailView.1
            @Override // com.google.android.youtube.player.internal.t.a
            public final void a() {
                if (YouTubeThumbnailView.this.a != null) {
                    YouTubeThumbnailView youTubeThumbnailView = YouTubeThumbnailView.this;
                    onInitializedListener.onInitializationSuccess(youTubeThumbnailView, ab.a().a(YouTubeThumbnailView.this.a, youTubeThumbnailView));
                    YouTubeThumbnailView.b(YouTubeThumbnailView.this);
                }
            }

            @Override // com.google.android.youtube.player.internal.t.a
            public final void b() {
                YouTubeThumbnailView.b(YouTubeThumbnailView.this);
            }
        }, new t.b() { // from class: com.google.android.youtube.player.YouTubeThumbnailView.2
            @Override // com.google.android.youtube.player.internal.t.b
            public final void a(YouTubeInitializationResult youTubeInitializationResult) {
                onInitializedListener.onInitializationFailure(YouTubeThumbnailView.this, youTubeInitializationResult);
                YouTubeThumbnailView.b(YouTubeThumbnailView.this);
            }
        });
        this.a.e();
    }
}
