package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class l implements w {
    protected int a;
    WeakReference<OlaCachedImageView> b;
    WeakReference<View> c;
    String d;
    private boolean e;

    public l(String str, OlaCachedImageView olaCachedImageView, View view, int i, boolean z) {
        this.a = 100;
        this.d = null;
        this.e = false;
        this.b = new WeakReference<>(olaCachedImageView);
        if (view != null) {
            this.c = new WeakReference<>(view);
        }
        this.e = z;
        this.d = str;
        this.a = i;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        try {
            if (this.c == null || this.c.get() == null) {
                return;
            }
            this.c.get().setVisibility(z ? 0 : 8);
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
    public void b(String str) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(str, olaCachedImageView.getLoadingUrl())) {
                olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                f fVarF = f.f(this.d, this.a);
                fVarF.a(new g() { // from class: chat.ola.vn.c.l.1
                    @Override // chat.ola.vn.c.g
                    public void a(f fVar) {
                        try {
                            if (!chat.ola.vn.util.m.b(l.this.d, fVar.f()) || l.this.b == null || l.this.b.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView2 = l.this.b.get();
                            if (chat.ola.vn.util.m.b(fVar.e(), olaCachedImageView2.getLoadingUrl())) {
                                Bitmap bitmapC = fVar.c();
                                try {
                                    if (l.this.e) {
                                        bitmapC = f.a(bitmapC);
                                    }
                                } catch (Throwable unused) {
                                }
                                olaCachedImageView2.setScaleType(ImageView.ScaleType.CENTER_CROP);
                                olaCachedImageView2.a(bitmapC, fVar.e());
                                olaCachedImageView2.setLoadingUrl(null);
                                olaCachedImageView2.setVisibility(0);
                                l.this.a(false);
                            }
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(f fVar) {
                    }
                });
                new e().a(fVarF);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public void b(String str, Bitmap bitmap) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(str, olaCachedImageView.getLoadingUrl())) {
                try {
                    if (this.e) {
                        bitmap = f.a(bitmap);
                    }
                } catch (Throwable unused) {
                }
                olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                olaCachedImageView.a(bitmap, str);
                olaCachedImageView.setLoadingUrl(null);
                olaCachedImageView.setVisibility(0);
                a(false);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c.w
    public final void c(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void c(String str, Bitmap bitmap) {
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
