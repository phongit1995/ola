package chat.ola.vn.view;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import chat.ola.vn.util.o;
import java.net.URLDecoder;

/* JADX INFO: loaded from: classes.dex */
public class a extends Drawable {
    private Bitmap a;
    private Matrix b;
    private Paint c;
    private int d;
    private int e;

    /* JADX INFO: renamed from: chat.ola.vn.view.a$1, reason: invalid class name */
    class AnonymousClass1 extends chat.ola.vn.c.i {
        final /* synthetic */ String a;

        AnonymousClass1(String str) {
            this.a = str;
        }

        @Override // chat.ola.vn.c.w
        public void c(String str) {
            try {
                chat.ola.vn.c.f fVarG = chat.ola.vn.c.f.g(this.a, Math.max(a.this.d, a.this.e));
                fVarG.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.view.a.1.2
                    @Override // chat.ola.vn.c.g
                    public void a(final chat.ola.vn.c.f fVar) {
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.a.1.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                a.this.a(fVar.c());
                            }
                        });
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(chat.ola.vn.c.f fVar) {
                    }
                });
                new chat.ola.vn.c.e().a(fVarG);
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.c.w
        public void c(String str, final Bitmap bitmap) {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.a.1.1
                @Override // java.lang.Runnable
                public void run() {
                    a.this.a(bitmap);
                }
            });
        }
    }

    /* JADX INFO: renamed from: chat.ola.vn.view.a$2, reason: invalid class name */
    class AnonymousClass2 extends chat.ola.vn.c.i {
        final /* synthetic */ String a;

        AnonymousClass2(String str) {
            this.a = str;
        }

        @Override // chat.ola.vn.c.w
        public void c(String str) {
            try {
                chat.ola.vn.c.f fVarA = chat.ola.vn.c.f.a(this.a, a.this.d, a.this.e);
                fVarA.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.view.a.2.1
                    @Override // chat.ola.vn.c.g
                    public void a(final chat.ola.vn.c.f fVar) {
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.a.2.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                a.this.a(fVar.c());
                            }
                        });
                    }

                    @Override // chat.ola.vn.c.g
                    public void b(chat.ola.vn.c.f fVar) {
                    }
                });
                new chat.ola.vn.c.e().a(fVarA);
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.c.w
        public void c(String str, final Bitmap bitmap) {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.a.2.2
                @Override // java.lang.Runnable
                public void run() {
                    a.this.a(bitmap);
                }
            });
        }
    }

    public a(int i, int i2) {
        this.d = i;
        this.e = i2;
        a();
        setBounds(0, 0, i, i2);
    }

    private void a() {
        this.b = new Matrix();
        this.c = new Paint();
    }

    public void a(Bitmap bitmap) {
        float f;
        float f2;
        this.a = bitmap;
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        int i = this.d;
        int i2 = this.e;
        float f3 = 0.0f;
        if (width * i2 > i * height) {
            float f4 = i2 / height;
            f2 = (i - (width * f4)) * 0.5f;
            f = f4;
        } else {
            f = i / width;
            f3 = (i2 - (height * f)) * 0.5f;
            f2 = 0.0f;
        }
        this.b.setScale(f, f);
        this.b.postTranslate((int) (f2 + 0.5f), (int) (f3 + 0.5f));
        invalidateSelf();
    }

    public void a(String str) {
        Bitmap bitmapDecodeResource;
        try {
            if (str.startsWith("#\u001b") || str.startsWith("##")) {
                str = str.substring(2, str.length() - 1);
            }
            switch (o.g(str)) {
                case 1:
                    t.a().a(str, new AnonymousClass1(str));
                    return;
                case 2:
                    bitmapDecodeResource = BitmapFactory.decodeResource(OlaApplication.b(), R.drawable.ic_media_video);
                    break;
                case 3:
                    bitmapDecodeResource = BitmapFactory.decodeResource(OlaApplication.b(), R.drawable.ic_media_sound);
                    break;
                default:
                    return;
            }
            a(bitmapDecodeResource);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void b(String str) {
        Resources resourcesB;
        int i;
        try {
            String strDecode = URLDecoder.decode(str.substring("file:\\".length(), str.length()), "UTF-8");
            switch (o.d(strDecode)) {
                case 1:
                    t.a().a(strDecode, new AnonymousClass2(strDecode));
                    return;
                case 2:
                    resourcesB = OlaApplication.b();
                    i = R.drawable.ic_media_video;
                    break;
                case 3:
                    resourcesB = OlaApplication.b();
                    i = R.drawable.ic_media_sound;
                    break;
                default:
                    return;
            }
            a(BitmapFactory.decodeResource(resourcesB, i));
        } catch (Throwable unused) {
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        int saveCount = canvas.getSaveCount();
        canvas.save();
        canvas.clipRect(0, 0, this.d, this.e);
        if (this.a != null) {
            canvas.drawBitmap(this.a, this.b, this.c);
        } else {
            canvas.drawColor(chat.ola.vn.f.v);
        }
        canvas.restoreToCount(saveCount);
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicHeight() {
        return this.e;
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicWidth() {
        return this.d;
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        return 0;
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        this.c.setAlpha(i);
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        this.c.setColorFilter(colorFilter);
    }
}
