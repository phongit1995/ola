package chat.ola.vn.c;

import android.annotation.TargetApi;
import android.graphics.Bitmap;
import android.view.View;
import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class v implements w {
    protected int a;
    WeakReference<OlaCachedImageView> b;
    WeakReference<View> c;
    String d;
    private boolean e;
    private boolean f = false;

    public v(String str, OlaCachedImageView olaCachedImageView, View view, int i, boolean z) {
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
    public void b(boolean z) {
        try {
            if (this.c == null || this.c.get() == null) {
                return;
            }
            this.c.get().setVisibility(z ? 0 : 8);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c.w
    @TargetApi(11)
    public void a(String str) {
        try {
            if (this.b == null || this.b.get() == null) {
                return;
            }
            OlaCachedImageView olaCachedImageView = this.b.get();
            if (chat.ola.vn.util.m.b(str, olaCachedImageView.getLoadingUrl())) {
                if (!this.f) {
                    t.a(olaCachedImageView, this.d, this.e);
                }
                f fVarE = f.e(this.d, this.a);
                fVarE.a(new g() { // from class: chat.ola.vn.c.v.1
                    /* JADX WARN: Code restructure failed: missing block: B:34:0x0065, code lost:
                    
                        r2 = r1;
                     */
                    /* JADX WARN: Multi-variable type inference failed */
                    /* JADX WARN: Type inference failed for: r0v11, types: [chat.ola.vn.view.OlaCachedImageView] */
                    /* JADX WARN: Type inference failed for: r1v3, types: [android.graphics.Bitmap] */
                    /* JADX WARN: Type inference failed for: r1v4 */
                    /* JADX WARN: Type inference failed for: r1v5 */
                    /* JADX WARN: Type inference failed for: r1v6, types: [boolean] */
                    /* JADX WARN: Type inference failed for: r1v7 */
                    /* JADX WARN: Type inference failed for: r2v1 */
                    /* JADX WARN: Type inference failed for: r2v10, types: [android.graphics.Bitmap] */
                    /* JADX WARN: Type inference failed for: r2v11, types: [android.graphics.Bitmap] */
                    /* JADX WARN: Type inference failed for: r2v2, types: [android.graphics.Bitmap] */
                    /* JADX WARN: Type inference failed for: r2v3 */
                    /* JADX WARN: Type inference failed for: r2v8 */
                    @Override // chat.ola.vn.c.g
                    /*
                        Code decompiled incorrectly, please refer to instructions dump.
                        To view partially-correct add '--show-bad-code' argument
                    */
                    public void a(chat.ola.vn.c.f r4) {
                        /*
                            r3 = this;
                            chat.ola.vn.c.v r0 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L76
                            java.lang.String r0 = r0.d     // Catch: java.lang.Throwable -> L76
                            java.lang.String r1 = r4.f()     // Catch: java.lang.Throwable -> L76
                            boolean r0 = chat.ola.vn.util.m.b(r0, r1)     // Catch: java.lang.Throwable -> L76
                            if (r0 == 0) goto L76
                            chat.ola.vn.c.v r0 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L76
                            java.lang.ref.WeakReference<chat.ola.vn.view.OlaCachedImageView> r0 = r0.b     // Catch: java.lang.Throwable -> L76
                            if (r0 == 0) goto L76
                            chat.ola.vn.c.v r0 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L76
                            java.lang.ref.WeakReference<chat.ola.vn.view.OlaCachedImageView> r0 = r0.b     // Catch: java.lang.Throwable -> L76
                            java.lang.Object r0 = r0.get()     // Catch: java.lang.Throwable -> L76
                            if (r0 == 0) goto L76
                            chat.ola.vn.c.v r0 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L76
                            java.lang.ref.WeakReference<chat.ola.vn.view.OlaCachedImageView> r0 = r0.b     // Catch: java.lang.Throwable -> L76
                            java.lang.Object r0 = r0.get()     // Catch: java.lang.Throwable -> L76
                            chat.ola.vn.view.OlaCachedImageView r0 = (chat.ola.vn.view.OlaCachedImageView) r0     // Catch: java.lang.Throwable -> L76
                            java.lang.String r1 = r4.e()     // Catch: java.lang.Throwable -> L76
                            java.lang.String r2 = r0.getLoadingUrl()     // Catch: java.lang.Throwable -> L76
                            boolean r1 = chat.ola.vn.util.m.b(r1, r2)     // Catch: java.lang.Throwable -> L76
                            if (r1 == 0) goto L76
                            android.graphics.Bitmap r1 = r4.c()     // Catch: java.lang.Throwable -> L76
                            chat.ola.vn.c.v r2 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L64
                            boolean r2 = chat.ola.vn.c.v.a(r2)     // Catch: java.lang.Throwable -> L64
                            if (r2 == 0) goto L47
                            android.graphics.Bitmap r2 = chat.ola.vn.c.f.a(r1)     // Catch: java.lang.Throwable -> L64
                            goto L65
                        L47:
                            chat.ola.vn.c.v r2 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L64
                            boolean r2 = chat.ola.vn.c.v.b(r2)     // Catch: java.lang.Throwable -> L64
                            if (r2 == 0) goto L64
                            android.content.Context r2 = chat.ola.vn.OlaApplication.a()     // Catch: java.lang.Throwable -> L64
                            android.graphics.Bitmap r2 = chat.ola.vn.balloon.b.a(r2, r1)     // Catch: java.lang.Throwable -> L64
                            boolean r1 = com.mg.ola.common.d.g.c()     // Catch: java.lang.Throwable -> L65
                            if (r1 == 0) goto L65
                            r1 = 1062836634(0x3f59999a, float:0.85)
                            r0.setAlpha(r1)     // Catch: java.lang.Throwable -> L65
                            goto L65
                        L64:
                            r2 = r1
                        L65:
                            java.lang.String r4 = r4.e()     // Catch: java.lang.Throwable -> L76
                            r0.a(r2, r4)     // Catch: java.lang.Throwable -> L76
                            r4 = 0
                            r0.setLoadingUrl(r4)     // Catch: java.lang.Throwable -> L76
                            chat.ola.vn.c.v r4 = chat.ola.vn.c.v.this     // Catch: java.lang.Throwable -> L76
                            r0 = 0
                            chat.ola.vn.c.v.a(r4, r0)     // Catch: java.lang.Throwable -> L76
                        L76:
                            return
                        */
                        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.c.v.AnonymousClass1.a(chat.ola.vn.c.f):void");
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(f fVar) {
                    }
                });
                new e().a(fVarE);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:31:0x0041, code lost:
    
        r1 = r4;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v5, types: [chat.ola.vn.view.OlaCachedImageView] */
    /* JADX WARN: Type inference failed for: r1v10, types: [android.graphics.Bitmap] */
    /* JADX WARN: Type inference failed for: r1v2 */
    /* JADX WARN: Type inference failed for: r1v3, types: [android.graphics.Bitmap] */
    /* JADX WARN: Type inference failed for: r1v4 */
    /* JADX WARN: Type inference failed for: r1v7 */
    /* JADX WARN: Type inference failed for: r1v9, types: [android.graphics.Bitmap] */
    /* JADX WARN: Type inference failed for: r4v0, types: [android.graphics.Bitmap] */
    /* JADX WARN: Type inference failed for: r4v1 */
    /* JADX WARN: Type inference failed for: r4v2 */
    /* JADX WARN: Type inference failed for: r4v3, types: [boolean] */
    /* JADX WARN: Type inference failed for: r4v4 */
    @Override // chat.ola.vn.c.w
    @android.annotation.TargetApi(11)
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(java.lang.String r3, android.graphics.Bitmap r4) {
        /*
            r2 = this;
            java.lang.ref.WeakReference<chat.ola.vn.view.OlaCachedImageView> r0 = r2.b     // Catch: java.lang.Throwable -> L4c
            if (r0 == 0) goto L4c
            java.lang.ref.WeakReference<chat.ola.vn.view.OlaCachedImageView> r0 = r2.b     // Catch: java.lang.Throwable -> L4c
            java.lang.Object r0 = r0.get()     // Catch: java.lang.Throwable -> L4c
            if (r0 == 0) goto L4c
            java.lang.ref.WeakReference<chat.ola.vn.view.OlaCachedImageView> r0 = r2.b     // Catch: java.lang.Throwable -> L4c
            java.lang.Object r0 = r0.get()     // Catch: java.lang.Throwable -> L4c
            chat.ola.vn.view.OlaCachedImageView r0 = (chat.ola.vn.view.OlaCachedImageView) r0     // Catch: java.lang.Throwable -> L4c
            java.lang.String r1 = r0.getLoadingUrl()     // Catch: java.lang.Throwable -> L4c
            boolean r1 = chat.ola.vn.util.m.b(r3, r1)     // Catch: java.lang.Throwable -> L4c
            if (r1 == 0) goto L4c
            boolean r1 = r2.e     // Catch: java.lang.Throwable -> L40
            if (r1 == 0) goto L27
            android.graphics.Bitmap r1 = chat.ola.vn.c.f.a(r4)     // Catch: java.lang.Throwable -> L40
            goto L41
        L27:
            boolean r1 = r2.f     // Catch: java.lang.Throwable -> L40
            if (r1 == 0) goto L40
            android.content.Context r1 = chat.ola.vn.OlaApplication.a()     // Catch: java.lang.Throwable -> L40
            android.graphics.Bitmap r1 = chat.ola.vn.balloon.b.a(r1, r4)     // Catch: java.lang.Throwable -> L40
            boolean r4 = com.mg.ola.common.d.g.c()     // Catch: java.lang.Throwable -> L41
            if (r4 == 0) goto L41
            r4 = 1062836634(0x3f59999a, float:0.85)
            r0.setAlpha(r4)     // Catch: java.lang.Throwable -> L41
            goto L41
        L40:
            r1 = r4
        L41:
            r0.a(r1, r3)     // Catch: java.lang.Throwable -> L4c
            r3 = 0
            r0.setLoadingUrl(r3)     // Catch: java.lang.Throwable -> L4c
            r3 = 0
            r2.b(r3)     // Catch: java.lang.Throwable -> L4c
        L4c:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.c.v.a(java.lang.String, android.graphics.Bitmap):void");
    }

    public void a(boolean z) {
        this.f = z;
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
