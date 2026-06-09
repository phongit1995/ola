package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;
import com.mg.ola.common.widget.image.viewer.PhotoView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class q extends c {
    WeakReference<View> a;
    private WeakReference<PhotoView> b;
    private String c;
    private int d;
    private boolean e;
    private ImageView.ScaleType f;

    public q(PhotoView photoView, ImageView.ScaleType scaleType, View view, String str, int i, boolean z) {
        this.d = 0;
        this.e = false;
        this.f = ImageView.ScaleType.CENTER_CROP;
        this.b = new WeakReference<>(photoView);
        this.c = str;
        if (view != null) {
            this.a = new WeakReference<>(view);
        }
        this.e = z;
        this.d = i;
        this.f = scaleType;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        try {
            if (this.a == null || this.a.get() == null) {
                return;
            }
            this.a.get().setVisibility(z ? 0 : 8);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public void f(String str) {
        try {
            if (this.b == null || this.b.get() == null || !chat.ola.vn.util.m.b(str, this.b.get().getLoadingUrl())) {
                return;
            }
            a(true);
            d dVar = new d();
            f fVarA = f.a(this.c, this.d, true);
            fVarA.j(str);
            fVarA.a(new g() { // from class: chat.ola.vn.c.q.1
                @Override // chat.ola.vn.c.g
                public void a(f fVar) {
                    try {
                        if (q.this.b == null || q.this.b.get() == null) {
                            return;
                        }
                        PhotoView photoView = (PhotoView) q.this.b.get();
                        if (chat.ola.vn.util.m.b(photoView.getLoadingUrl(), fVar.e())) {
                            Bitmap bitmapC = fVar.c();
                            try {
                                if (q.this.e) {
                                    bitmapC = f.a(bitmapC);
                                }
                            } catch (Throwable unused) {
                            }
                            photoView.setScaleType(q.this.f);
                            photoView.a(bitmapC, photoView.getLoadingUrl());
                            photoView.setLoadingUrl(null);
                            q.this.a(false);
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }

                @Override // chat.ola.vn.c.g
                public void b(f fVar) {
                    q.this.a(false);
                }
            });
            dVar.execute(fVarA);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public void f(String str, Bitmap bitmap) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            PhotoView photoView = this.b.get();
            if (chat.ola.vn.util.m.b(photoView.getLoadingUrl(), str)) {
                try {
                    if (this.e) {
                        bitmap = f.a(bitmap);
                    }
                } catch (Throwable unused) {
                }
                photoView.setScaleType(this.f);
                photoView.a(bitmap, str);
                photoView.setLoadingUrl(null);
                a(false);
            }
        } catch (Throwable unused2) {
        }
    }
}
