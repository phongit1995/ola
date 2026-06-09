package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class k implements w {
    protected int a;
    WeakReference<OlaCachedImageView> b;
    WeakReference<View> c;
    String d;

    public k(String str, OlaCachedImageView olaCachedImageView, View view, int i) {
        this.a = 100;
        this.d = null;
        this.b = new WeakReference<>(olaCachedImageView);
        if (view != null) {
            this.c = new WeakReference<>(view);
        }
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
    public final void b(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void b(String str, Bitmap bitmap) {
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
    public void e(String str) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(str, olaCachedImageView.getLoadingUrl())) {
                olaCachedImageView.setBackgroundColor(chat.ola.vn.f.K);
                f fVarI = f.i(this.d, this.a);
                fVarI.j(str);
                fVarI.a(new g() { // from class: chat.ola.vn.c.k.1
                    @Override // chat.ola.vn.c.g
                    public void a(f fVar) {
                        try {
                            if (!chat.ola.vn.util.m.b(k.this.d, fVar.f()) || k.this.b == null || k.this.b.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView2 = k.this.b.get();
                            if (chat.ola.vn.util.m.b(fVar.e(), olaCachedImageView2.getLoadingUrl())) {
                                olaCachedImageView2.a(fVar.c(), fVar.e());
                                olaCachedImageView2.setLoadingUrl(null);
                                olaCachedImageView2.setVisibility(0);
                                k.this.a(false);
                            }
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(f fVar) {
                        try {
                            if (!chat.ola.vn.util.m.b(k.this.d, fVar.f()) || k.this.b == null || k.this.b.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView2 = k.this.b.get();
                            if (chat.ola.vn.util.m.b(fVar.e(), olaCachedImageView2.getLoadingUrl())) {
                                olaCachedImageView2.setCachingId(fVar.e());
                                olaCachedImageView2.setLoadingUrl(null);
                                olaCachedImageView2.setVisibility(0);
                                k.this.a(false);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                });
                new e().a(fVarI);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public void e(String str, Bitmap bitmap) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(str, olaCachedImageView.getLoadingUrl())) {
                olaCachedImageView.a(bitmap, str);
                olaCachedImageView.setLoadingUrl(null);
                olaCachedImageView.setVisibility(0);
                a(false);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public final void f(String str) {
    }

    @Override // chat.ola.vn.c.w
    public final void f(String str, Bitmap bitmap) {
    }
}
