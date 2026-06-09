package chat.ola.vn.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.widget.ImageView;

/* JADX INFO: loaded from: classes.dex */
public abstract class c extends ImageView {
    private final Matrix a;
    private final float[] b;
    private a c;
    private Runnable d;
    protected Matrix g;
    protected Matrix h;
    protected final com.mg.ola.common.a.a i;
    int j;
    int k;
    float l;
    int m;
    int n;
    int o;
    int p;
    protected Handler q;

    public interface a {
        void a(Bitmap bitmap);
    }

    public c(Context context) {
        super(context);
        this.g = new Matrix();
        this.h = new Matrix();
        this.a = new Matrix();
        this.b = new float[9];
        this.i = new com.mg.ola.common.a.a(null);
        this.j = -1;
        this.k = -1;
        this.q = new Handler();
        this.d = null;
        a();
    }

    public c(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.g = new Matrix();
        this.h = new Matrix();
        this.a = new Matrix();
        this.b = new float[9];
        this.i = new com.mg.ola.common.a.a(null);
        this.j = -1;
        this.k = -1;
        this.q = new Handler();
        this.d = null;
        a();
    }

    private void a(Bitmap bitmap, int i) {
        super.setImageBitmap(bitmap);
        Drawable drawable = getDrawable();
        if (drawable != null) {
            drawable.setDither(true);
        }
        Bitmap bitmapB = this.i.b();
        this.i.a(bitmap);
        this.i.a(i);
        if (bitmapB == null || bitmapB == bitmap || this.c == null) {
            return;
        }
        this.c.a(bitmapB);
    }

    private void a(com.mg.ola.common.a.a aVar, Matrix matrix) {
        float width = getWidth();
        float height = getHeight();
        float f = aVar.f();
        float fE = aVar.e();
        matrix.reset();
        float fMin = Math.min(Math.min(width / f, 2.0f), Math.min(height / fE, 2.0f));
        matrix.postConcat(aVar.c());
        matrix.postScale(fMin, fMin);
        matrix.postTranslate((width - (f * fMin)) / 2.0f, (height - (fE * fMin)) / 2.0f);
    }

    protected float a(Matrix matrix) {
        return a(matrix, 0);
    }

    protected float a(Matrix matrix, int i) {
        matrix.getValues(this.b);
        return this.b[i];
    }

    protected void a() {
        setScaleType(ImageView.ScaleType.MATRIX);
    }

    protected void a(float f) {
        a(f, getWidth() / 2.0f, getHeight() / 2.0f);
    }

    protected void a(float f, float f2) {
        this.h.postTranslate(f, f2);
    }

    protected void a(float f, float f2, float f3) {
        if (f > this.l) {
            f = this.l;
        }
        float scale = f / getScale();
        this.h.postScale(scale, scale, f2, f3);
        setImageMatrix(getImageViewMatrix());
        a(true, true);
    }

    protected void a(float f, final float f2, final float f3, final float f4, final Runnable runnable) {
        final float scale = (f - getScale()) / f4;
        final float scale2 = getScale();
        final long jCurrentTimeMillis = System.currentTimeMillis();
        this.q.post(new Runnable() { // from class: chat.ola.vn.view.c.2
            @Override // java.lang.Runnable
            public void run() {
                float fMin = Math.min(f4, System.currentTimeMillis() - jCurrentTimeMillis);
                c.this.a(scale2 + (scale * fMin), f2, f3);
                if (fMin < f4) {
                    c.this.q.post(this);
                } else if (runnable != null) {
                    runnable.run();
                }
            }
        });
    }

    public void a(Bitmap bitmap, boolean z) {
        a(new com.mg.ola.common.a.a(bitmap), z);
    }

    public void a(final com.mg.ola.common.a.a aVar, final boolean z) {
        if (getWidth() <= 0) {
            this.d = new Runnable() { // from class: chat.ola.vn.view.c.1
                @Override // java.lang.Runnable
                public void run() {
                    c.this.a(aVar, z);
                }
            };
            return;
        }
        if (aVar.b() != null) {
            a(aVar, this.g);
            a(aVar.b(), aVar.a());
        } else {
            this.g.reset();
            setImageBitmap(null);
        }
        if (z) {
            this.h.reset();
        }
        setImageMatrix(getImageViewMatrix());
        this.l = b();
    }

    protected void a(boolean z, boolean z2) {
        float f;
        float f2;
        float height;
        float f3;
        if (this.i.b() == null) {
            return;
        }
        Matrix imageViewMatrix = getImageViewMatrix();
        float f4 = 0.0f;
        RectF rectF = new RectF(0.0f, 0.0f, this.i.b().getWidth(), this.i.b().getHeight());
        imageViewMatrix.mapRect(rectF);
        float fHeight = rectF.height();
        float fWidth = rectF.width();
        if (z2) {
            float height2 = getHeight();
            if (fHeight < height2) {
                height = (height2 - fHeight) / 2.0f;
                f3 = rectF.top;
            } else if (rectF.top > 0.0f) {
                f = -rectF.top;
            } else {
                if (rectF.bottom < height2) {
                    height = getHeight();
                    f3 = rectF.bottom;
                }
                f = 0.0f;
            }
            f = height - f3;
        } else {
            f = 0.0f;
        }
        if (z) {
            float width = getWidth();
            if (fWidth < width) {
                width = (width - fWidth) / 2.0f;
                f2 = rectF.left;
            } else if (rectF.left > 0.0f) {
                f4 = -rectF.left;
            } else if (rectF.right < width) {
                f2 = rectF.right;
            }
            f4 = width - f2;
        }
        a(f4, f);
        setImageMatrix(getImageViewMatrix());
    }

    protected float b() {
        if (this.i.b() == null) {
            return 1.0f;
        }
        return Math.max(this.i.f() / this.j, this.i.e() / this.k) * 4.0f;
    }

    protected void b(float f, float f2) {
        a(f, f2);
        setImageMatrix(getImageViewMatrix());
    }

    protected Matrix getImageViewMatrix() {
        this.a.set(this.g);
        this.a.postConcat(this.h);
        return this.a;
    }

    protected float getScale() {
        return a(this.h);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 4 || getScale() <= 1.0f) {
            return super.onKeyDown(i, keyEvent);
        }
        a(1.0f);
        return true;
    }

    @Override // android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        this.m = i;
        this.n = i3;
        this.o = i2;
        this.p = i4;
        this.j = i3 - i;
        this.k = i4 - i2;
        Runnable runnable = this.d;
        if (runnable != null) {
            this.d = null;
            runnable.run();
        }
        if (this.i.b() != null) {
            a(this.i, this.g);
            setImageMatrix(getImageViewMatrix());
        }
    }

    @Override // android.widget.ImageView
    public void setImageBitmap(Bitmap bitmap) {
        a(bitmap, 0);
    }

    public void setRecycler(a aVar) {
        this.c = aVar;
    }
}
