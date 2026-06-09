package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class n implements w {
    WeakReference<OlaCachedImageView> a;
    WeakReference<View> b;
    private int c;
    private int d;
    private int e;
    private boolean f;

    public n(OlaCachedImageView olaCachedImageView, View view, int i, int i2, int i3, boolean z) {
        this.c = 0;
        this.d = 0;
        this.e = 0;
        this.f = false;
        this.a = new WeakReference<>(olaCachedImageView);
        if (view != null) {
            this.b = new WeakReference<>(view);
        }
        this.c = i;
        this.d = i2;
        this.e = i3;
        this.f = z;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            this.b.get().setVisibility(z ? 0 : 8);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public final void a(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void a(String str, Bitmap bitmap) {
    }

    @Override // chat.ola.vn.c.w
    public final void b(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void b(String str, Bitmap bitmap) {
    }

    @Override // chat.ola.vn.c.w
    public void c(String str) {
        f fVarG;
        if (this.a == null || this.a.get() == null) {
            return;
        }
        try {
            if (chat.ola.vn.util.m.a(str, this.a.get().getLoadingUrl())) {
                a(true);
                f.g(str);
                switch (this.c) {
                    case 1:
                        fVarG = f.g(str);
                        break;
                    case 2:
                        fVarG = f.h(str);
                        break;
                    default:
                        fVarG = f.a(str, this.d, this.e);
                        break;
                }
                fVarG.a(new g() { // from class: chat.ola.vn.c.n.1
                    @Override // chat.ola.vn.c.g
                    public void a(f fVar) {
                        try {
                            if (n.this.a == null || n.this.a.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView = n.this.a.get();
                            if (chat.ola.vn.util.m.a(olaCachedImageView.getLoadingUrl(), fVar.g())) {
                                Bitmap bitmapC = fVar.c();
                                try {
                                    if (n.this.f) {
                                        bitmapC = f.a(bitmapC);
                                    }
                                } catch (Throwable unused) {
                                }
                                olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                                olaCachedImageView.a(bitmapC, olaCachedImageView.getLoadingUrl());
                                olaCachedImageView.setLoadingUrl(null);
                                n.this.a(false);
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(f fVar) {
                    }
                });
                new e().a(fVarG);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public void c(String str, Bitmap bitmap) {
        try {
            if (this.a == null || this.a.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.a.get();
            if (chat.ola.vn.util.m.a(str, olaCachedImageView.getLoadingUrl())) {
                try {
                    if (this.f) {
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

    @Override // chat.ola.vn.c.w
    public final void d(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void d(String str, Bitmap bitmap) {
    }

    @Override // chat.ola.vn.c.w
    public final void e(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void e(String str, Bitmap bitmap) {
    }

    @Override // chat.ola.vn.c.w
    public final void f(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void f(String str, Bitmap bitmap) {
    }
}
