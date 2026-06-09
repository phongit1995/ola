package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.view.View;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class u implements w {
    protected int a;
    WeakReference<OlaCachedImageView> b;
    WeakReference<View> c;
    String d;
    boolean e;

    public u(String str, OlaCachedImageView olaCachedImageView, View view, int i, boolean z) {
        this.a = 720;
        this.d = null;
        this.e = true;
        this.b = new WeakReference<>(olaCachedImageView);
        if (view != null) {
            this.c = new WeakReference<>(view);
        }
        this.d = str;
        this.a = i;
        this.e = z;
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
    public void d(String str) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(str, olaCachedImageView.getLoadingUrl())) {
                olaCachedImageView.a(null, null);
                if (this.e) {
                    olaCachedImageView.setBackgroundColor(chat.ola.vn.f.K);
                }
                f fVarH = f.h(this.d, this.a);
                fVarH.j(str);
                fVarH.a(new g() { // from class: chat.ola.vn.c.u.1
                    @Override // chat.ola.vn.c.g
                    public void a(f fVar) {
                        try {
                            if (!chat.ola.vn.util.m.b(u.this.d, fVar.f()) || u.this.b == null || u.this.b.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView2 = u.this.b.get();
                            if (chat.ola.vn.util.m.b(fVar.e(), olaCachedImageView2.getLoadingUrl())) {
                                olaCachedImageView2.a(fVar.c(), fVar.e());
                                olaCachedImageView2.setLoadingUrl(null);
                                olaCachedImageView2.setVisibility(0);
                                u.this.a(false);
                            }
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(f fVar) {
                        try {
                            if (!chat.ola.vn.util.m.b(u.this.d, fVar.f()) || u.this.b == null || u.this.b.get() == null) {
                                return;
                            }
                            OlaCachedImageView olaCachedImageView2 = u.this.b.get();
                            if (chat.ola.vn.util.m.b(fVar.e(), olaCachedImageView2.getLoadingUrl())) {
                                olaCachedImageView2.setCachingId(fVar.e());
                                olaCachedImageView2.setLoadingUrl(null);
                                u.this.a(false);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                });
                new e().a(fVarH);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    public void d(String str, Bitmap bitmap) {
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
