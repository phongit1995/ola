package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class r implements w {
    WeakReference<OlaCachedImageView> a;
    WeakReference<View> b;
    private String c;
    private int d;
    private boolean e;
    private ImageView.ScaleType f;

    public r(String str, OlaCachedImageView olaCachedImageView, ImageView.ScaleType scaleType, View view, int i, boolean z) {
        this.d = 480;
        this.e = false;
        this.f = ImageView.ScaleType.CENTER_CROP;
        this.a = new WeakReference<>(olaCachedImageView);
        if (view != null) {
            this.b = new WeakReference<>(view);
        }
        this.c = str;
        this.d = i;
        this.e = z;
        this.f = scaleType;
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
        if (this.a == null || this.a.get() == null) {
            return;
        }
        try {
            if (chat.ola.vn.util.m.a(str, this.a.get().getLoadingUrl())) {
                a(true);
                f fVarG = f.g(this.c, this.d);
                fVarG.a(new g() { // from class: chat.ola.vn.c.r.1
                    @Override // chat.ola.vn.c.g
                    public void a(f fVar) {
                        try {
                            if (r.this.a == null || r.this.a.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView = r.this.a.get();
                            if (chat.ola.vn.util.m.a(olaCachedImageView.getLoadingUrl(), fVar.e())) {
                                Bitmap bitmapC = fVar.c();
                                try {
                                    if (r.this.e) {
                                        bitmapC = f.a(bitmapC);
                                    }
                                } catch (Throwable unused) {
                                }
                                olaCachedImageView.setScaleType(r.this.f);
                                olaCachedImageView.a(bitmapC, fVar.e());
                                olaCachedImageView.setLoadingUrl(null);
                                r.this.a(false);
                            }
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(f fVar) {
                        r.this.a(false);
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
                    if (this.e) {
                        bitmap = f.a(bitmap);
                    }
                } catch (Throwable unused) {
                }
                olaCachedImageView.setScaleType(this.f);
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
