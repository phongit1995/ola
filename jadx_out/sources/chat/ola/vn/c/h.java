package chat.ola.vn.c;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class h implements w {
    WeakReference<OlaCachedImageView> a;
    private String b;
    private int c;

    public h(String str, OlaCachedImageView olaCachedImageView, int i) {
        this.c = 480;
        this.a = new WeakReference<>(olaCachedImageView);
        this.c = i;
        this.b = str;
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
                f fVarG = f.g(this.b, this.c);
                fVarG.a(new g() { // from class: chat.ola.vn.c.h.1
                    @Override // chat.ola.vn.c.g
                    @SuppressLint({"NewApi"})
                    public void a(f fVar) {
                        Bitmap bitmapA;
                        try {
                            if (h.this.a == null || h.this.a.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView = h.this.a.get();
                            if (chat.ola.vn.util.m.a(olaCachedImageView.getLoadingUrl(), fVar.e())) {
                                Bitmap bitmapC = fVar.c();
                                try {
                                    bitmapA = chat.ola.vn.balloon.b.a(OlaApplication.a(), bitmapC);
                                    try {
                                        if (com.mg.ola.common.d.g.c()) {
                                            olaCachedImageView.setAlpha(0.85f);
                                        }
                                    } catch (Throwable unused) {
                                    }
                                } catch (Throwable unused2) {
                                    bitmapA = bitmapC;
                                }
                                olaCachedImageView.a(bitmapA, fVar.e());
                                olaCachedImageView.setLoadingUrl(null);
                            }
                        } catch (Throwable unused3) {
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
    @SuppressLint({"NewApi"})
    public void c(String str, Bitmap bitmap) {
        Bitmap bitmapA;
        try {
            if (this.a == null || this.a.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.a.get();
            if (chat.ola.vn.util.m.a(str, olaCachedImageView.getLoadingUrl())) {
                try {
                    bitmapA = chat.ola.vn.balloon.b.a(OlaApplication.a(), bitmap);
                    try {
                        if (com.mg.ola.common.d.g.c()) {
                            olaCachedImageView.setAlpha(0.85f);
                        }
                    } catch (Throwable unused) {
                    }
                } catch (Throwable unused2) {
                    bitmapA = bitmap;
                }
                olaCachedImageView.a(bitmapA, str);
                olaCachedImageView.setLoadingUrl(null);
            }
        } catch (Throwable unused3) {
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
