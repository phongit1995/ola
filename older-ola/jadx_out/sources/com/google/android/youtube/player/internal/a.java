package com.google.android.youtube.player.internal;

import android.graphics.Bitmap;
import com.google.android.youtube.player.YouTubeThumbnailLoader;
import com.google.android.youtube.player.YouTubeThumbnailView;
import java.util.NoSuchElementException;

/* JADX INFO: loaded from: classes2.dex */
public abstract class a implements YouTubeThumbnailLoader {
    private final YouTubeThumbnailView a;
    private YouTubeThumbnailLoader.OnThumbnailLoadedListener b;
    private boolean c;
    private boolean d;

    public a(YouTubeThumbnailView youTubeThumbnailView) {
        this.a = (YouTubeThumbnailView) ac.a(youTubeThumbnailView, "thumbnailView cannot be null");
    }

    private void h() {
        if (!a()) {
            throw new IllegalStateException("This YouTubeThumbnailLoader has been released");
        }
    }

    public final void a(Bitmap bitmap, String str) {
        if (a()) {
            this.a.setImageBitmap(bitmap);
            if (this.b != null) {
                this.b.onThumbnailLoaded(this.a, str);
            }
        }
    }

    public abstract void a(String str);

    public abstract void a(String str, int i);

    protected boolean a() {
        return !this.d;
    }

    public abstract void b();

    public final void b(String str) {
        YouTubeThumbnailLoader.ErrorReason errorReasonValueOf;
        if (!a() || this.b == null) {
            return;
        }
        try {
            errorReasonValueOf = YouTubeThumbnailLoader.ErrorReason.valueOf(str);
        } catch (IllegalArgumentException | NullPointerException unused) {
            errorReasonValueOf = YouTubeThumbnailLoader.ErrorReason.UNKNOWN;
        }
        this.b.onThumbnailError(this.a, errorReasonValueOf);
    }

    public abstract void c();

    public abstract void d();

    public abstract boolean e();

    public abstract boolean f();

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void first() {
        h();
        if (!this.c) {
            throw new IllegalStateException("Must call setPlaylist first");
        }
        d();
    }

    public abstract void g();

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final boolean hasNext() {
        h();
        return e();
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final boolean hasPrevious() {
        h();
        return f();
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void next() {
        h();
        if (!this.c) {
            throw new IllegalStateException("Must call setPlaylist first");
        }
        if (!e()) {
            throw new NoSuchElementException("Called next at end of playlist");
        }
        b();
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void previous() {
        h();
        if (!this.c) {
            throw new IllegalStateException("Must call setPlaylist first");
        }
        if (!f()) {
            throw new NoSuchElementException("Called previous at start of playlist");
        }
        c();
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void release() {
        if (a()) {
            this.d = true;
            this.b = null;
            g();
        }
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void setOnThumbnailLoadedListener(YouTubeThumbnailLoader.OnThumbnailLoadedListener onThumbnailLoadedListener) {
        h();
        this.b = onThumbnailLoadedListener;
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void setPlaylist(String str) {
        setPlaylist(str, 0);
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void setPlaylist(String str, int i) {
        h();
        this.c = true;
        a(str, i);
    }

    @Override // com.google.android.youtube.player.YouTubeThumbnailLoader
    public final void setVideo(String str) {
        h();
        this.c = false;
        a(str);
    }
}
