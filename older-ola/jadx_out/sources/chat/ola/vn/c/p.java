package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class p extends c {
    WeakReference<View> a;
    private WeakReference<OlaCachedImageView> b;
    private String c;
    private int d;
    private boolean e;

    public p(OlaCachedImageView olaCachedImageView, View view, String str, int i, boolean z) {
        this.d = 0;
        this.e = false;
        this.b = new WeakReference<>(olaCachedImageView);
        this.c = str;
        if (view != null) {
            this.a = new WeakReference<>(view);
        }
        this.e = z;
        this.d = i;
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
            fVarA.a(new g() { // from class: chat.ola.vn.c.p.1
                @Override // chat.ola.vn.c.g
                public void a(f fVar) {
                    try {
                        if (p.this.b == null || p.this.b.get() == null) {
                            return;
                        }
                        OlaCachedImageView olaCachedImageView = (OlaCachedImageView) p.this.b.get();
                        if (chat.ola.vn.util.m.b(olaCachedImageView.getLoadingUrl(), fVar.e())) {
                            Bitmap bitmapC = fVar.c();
                            try {
                                if (p.this.e) {
                                    bitmapC = f.a(bitmapC);
                                }
                            } catch (Throwable unused) {
                            }
                            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                            olaCachedImageView.a(bitmapC, olaCachedImageView.getLoadingUrl());
                            olaCachedImageView.setLoadingUrl(null);
                            p.this.a(false);
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }

                @Override // chat.ola.vn.c.g
                public void b(f fVar) {
                    p.this.a(false);
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
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(olaCachedImageView.getLoadingUrl(), str)) {
                try {
                    if (this.e) {
                        bitmap = f.a(bitmap);
                    }
                } catch (Throwable unused) {
                }
                olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                olaCachedImageView.a(bitmap, str);
                olaCachedImageView.setLoadingUrl(null);
                a(false);
            }
        } catch (Throwable unused2) {
        }
    }
}
