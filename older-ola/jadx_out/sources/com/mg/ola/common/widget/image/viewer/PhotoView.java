package com.mg.ola.common.widget.image.viewer;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import com.mg.ola.common.widget.image.viewer.b;

/* JADX INFO: loaded from: classes2.dex */
public class PhotoView extends ImageView {
    private b a;
    private ImageView.ScaleType b;
    private String c;
    private String d;

    public PhotoView(Context context) {
        this(context, null);
        c();
    }

    public PhotoView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
        c();
    }

    public PhotoView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.c = null;
        c();
    }

    private void c() {
        super.setScaleType(ImageView.ScaleType.MATRIX);
        this.a = new b(this);
        if (this.b != null) {
            setScaleType(this.b);
            this.b = null;
        }
    }

    public void a(float f) {
        this.a.a(f, getWidth() / 2, getHeight() / 2);
    }

    public void a(Bitmap bitmap, String str) {
        if (this.c == null || str == null || !this.c.equals(str)) {
            super.setImageBitmap(bitmap);
            this.c = str;
        }
    }

    public boolean a() {
        try {
            return this.a.k();
        } catch (Throwable unused) {
            return false;
        }
    }

    public boolean a(String str) {
        return (this.c == null || str == null || !this.c.equals(str)) ? false : true;
    }

    public void b() {
        this.a.a();
    }

    public String getCachingId() {
        return this.c;
    }

    public RectF getDisplayRect() {
        return this.a.b();
    }

    public String getLoadingUrl() {
        return this.d;
    }

    public float getMaxScale() {
        return this.a.f();
    }

    public float getMidScale() {
        return this.a.e();
    }

    public float getMinScale() {
        return this.a.d();
    }

    public float getScale() {
        return this.a.g();
    }

    @Override // android.widget.ImageView
    public ImageView.ScaleType getScaleType() {
        return this.a.h();
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onDetachedFromWindow() {
        this.a.a();
        super.onDetachedFromWindow();
    }

    public void setAllowParentInterceptOnEdge(boolean z) {
        this.a.a(z);
    }

    @Override // android.widget.ImageView
    @Deprecated
    public void setImageBitmap(Bitmap bitmap) {
        super.setImageBitmap(bitmap);
    }

    @Override // android.widget.ImageView
    public void setImageDrawable(Drawable drawable) {
        super.setImageDrawable(drawable);
        if (this.a != null) {
            this.a.i();
        }
    }

    @Override // android.widget.ImageView
    public void setImageResource(int i) {
        if (this.c != null) {
            if (this.c.equals("" + i)) {
                return;
            }
        }
        super.setImageResource(i);
        this.c = "" + i;
        super.setImageResource(i);
        if (this.a != null) {
            this.a.i();
        }
    }

    @Override // android.widget.ImageView
    public void setImageURI(Uri uri) {
        super.setImageURI(uri);
        if (this.a != null) {
            this.a.i();
        }
    }

    public void setLoadingUrl(String str) {
        this.d = str;
    }

    public void setMaxScale(float f) {
        this.a.c(f);
    }

    public void setMidScale(float f) {
        this.a.b(f);
    }

    public void setMinScale(float f) {
        this.a.a(f);
    }

    @Override // android.view.View
    public void setOnLongClickListener(View.OnLongClickListener onLongClickListener) {
        this.a.a(onLongClickListener);
    }

    public void setOnMatrixChangeListener(b.e eVar) {
        this.a.a(eVar);
    }

    public void setOnPhotoTapListener(b.f fVar) {
        this.a.a(fVar);
    }

    public void setOnViewTapListener(b.g gVar) {
        this.a.a(gVar);
    }

    public void setScaleEnable(boolean z) {
        this.a.c(z);
    }

    @Override // android.widget.ImageView
    public void setScaleType(ImageView.ScaleType scaleType) {
        if (this.a != null) {
            this.a.a(scaleType);
        } else {
            this.b = scaleType;
        }
    }

    public void setZoomable(boolean z) {
        this.a.b(z);
    }
}
