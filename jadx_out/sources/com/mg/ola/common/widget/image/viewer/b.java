package com.mg.ola.common.widget.image.viewer;

import android.content.Context;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.ImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes2.dex */
public class b implements View.OnTouchListener, ViewTreeObserver.OnGlobalLayoutListener {
    private float B;
    private WeakReference<ImageView> e;
    private ViewTreeObserver f;
    private e m;
    private f n;
    private g o;
    private View.OnLongClickListener p;
    private int q;
    private int r;
    private int s;
    private int t;
    private d u;
    private ScaleGestureDetector y;
    private GestureDetector z;
    private float a = 1.0f;
    private float b = 1.75f;
    private float c = 3.0f;
    private boolean d = true;
    private final Matrix g = new Matrix();
    private final Matrix h = new Matrix();
    private final Matrix i = new Matrix();
    private final Matrix j = new Matrix();
    private final RectF k = new RectF();
    private final float[] l = new float[9];
    private int v = 2;
    private boolean w = false;
    private ImageView.ScaleType x = ImageView.ScaleType.FIT_CENTER;
    private boolean A = false;
    private boolean C = true;

    /* JADX INFO: renamed from: com.mg.ola.common.widget.image.viewer.b$1, reason: invalid class name */
    static /* synthetic */ class AnonymousClass1 {
        static final /* synthetic */ int[] a = new int[ImageView.ScaleType.values().length];

        static {
            try {
                a[ImageView.ScaleType.MATRIX.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                a[ImageView.ScaleType.FIT_START.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                a[ImageView.ScaleType.FIT_END.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                a[ImageView.ScaleType.FIT_CENTER.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                a[ImageView.ScaleType.FIT_XY.ordinal()] = 5;
            } catch (NoSuchFieldError unused5) {
            }
        }
    }

    private class a implements Runnable {
        private final float b;
        private final float c;
        private final float d;
        private final float e;

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        public a(float f, float f2, float f3, float f4) {
            this.d = f2;
            this.b = f3;
            this.c = f4;
            this.e = f < f2 ? 1.07f : 0.93f;
        }

        @Override // java.lang.Runnable
        public void run() {
            ImageView imageViewC = b.this.c();
            if (imageViewC != null) {
                b.this.i.postScale(this.e, this.e, this.b, this.c);
                b.this.m();
                float fG = b.this.g();
                if ((this.e > 1.0f && fG < this.d) || (this.e < 1.0f && this.d < fG)) {
                    com.mg.ola.common.widget.image.viewer.a.a(imageViewC, this);
                    return;
                }
                float f = this.d / fG;
                b.this.i.postScale(f, f, this.b, this.c);
                b.this.m();
            }
        }
    }

    /* JADX INFO: renamed from: com.mg.ola.common.widget.image.viewer.b$b, reason: collision with other inner class name */
    private class C0083b extends GestureDetector.SimpleOnGestureListener {
        private C0083b() {
        }

        /* synthetic */ C0083b(b bVar, AnonymousClass1 anonymousClass1) {
            this();
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnDoubleTapListener
        public boolean onDoubleTap(MotionEvent motionEvent) {
            float fG;
            float x;
            float y;
            try {
                fG = b.this.g();
                x = motionEvent.getX();
                y = motionEvent.getY();
            } catch (Throwable unused) {
            }
            if (fG < b.this.b) {
                b.this.a(b.this.b, x, y, true);
            } else {
                if (fG < b.this.b || fG >= b.this.c) {
                    b.this.a(b.this.a, x, y, true);
                    b.this.A = false;
                    return true;
                }
                b.this.a(b.this.c, x, y, true);
            }
            b.this.A = true;
            return true;
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
            ImageView imageViewC = b.this.c();
            if (!b.b(imageViewC)) {
                return true;
            }
            b.this.u = b.this.new d(imageViewC.getContext());
            b.this.u.a(imageViewC.getWidth(), imageViewC.getHeight(), (int) (-f), (int) (-f2));
            imageViewC.post(b.this.u);
            return true;
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public void onLongPress(MotionEvent motionEvent) {
            if (b.this.p != null) {
                b.this.p.onLongClick((View) b.this.e.get());
            }
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
            ImageView imageViewC = b.this.c();
            if (imageViewC != null && b.b(imageViewC)) {
                b.this.i.postTranslate(-f, -f2);
                b.this.m();
                if (b.this.d && (b.this.v == 2 || ((b.this.v == 0 && f <= -1.0f) || (b.this.v == 1 && f >= 1.0f)))) {
                    imageViewC.getParent().requestDisallowInterceptTouchEvent(false);
                }
            }
            return true;
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnDoubleTapListener
        public final boolean onSingleTapConfirmed(MotionEvent motionEvent) {
            RectF rectFB;
            ImageView imageViewC = b.this.c();
            if (imageViewC == null) {
                return false;
            }
            if (b.this.n != null && (rectFB = b.this.b()) != null) {
                float x = motionEvent.getX();
                float y = motionEvent.getY();
                if (rectFB.contains(x, y)) {
                    b.this.n.a(imageViewC, x, y);
                    return true;
                }
            }
            if (b.this.o == null) {
                return false;
            }
            b.this.o.b(imageViewC, motionEvent.getX(), motionEvent.getY());
            return true;
        }
    }

    private class c extends ScaleGestureDetector.SimpleOnScaleGestureListener {
        private c() {
        }

        /* synthetic */ c(b bVar, AnonymousClass1 anonymousClass1) {
            this();
        }

        @Override // android.view.ScaleGestureDetector.SimpleOnScaleGestureListener, android.view.ScaleGestureDetector.OnScaleGestureListener
        public boolean onScale(ScaleGestureDetector scaleGestureDetector) {
            float scaleFactor = scaleGestureDetector.getScaleFactor();
            if (b.b(b.this.c()) && (b.this.g() < b.this.c || scaleFactor < 1.0f)) {
                b.this.i.postScale(scaleFactor, scaleFactor, scaleGestureDetector.getFocusX(), scaleGestureDetector.getFocusY());
                b.this.m();
                b.this.A = true;
            }
            return true;
        }
    }

    private class d implements Runnable {
        private final com.mg.ola.common.widget.image.viewer.d b;
        private int c;
        private int d;

        public d(Context context) {
            this.b = com.mg.ola.common.widget.image.viewer.d.a(context);
        }

        public void a() {
            this.b.a(true);
        }

        public void a(int i, int i2, int i3, int i4) {
            int i5;
            int iRound;
            int i6;
            int iRound2;
            RectF rectFB = b.this.b();
            if (rectFB == null) {
                return;
            }
            int iRound3 = Math.round(-rectFB.left);
            float f = i;
            if (f < rectFB.width()) {
                iRound = Math.round(rectFB.width() - f);
                i5 = 0;
            } else {
                i5 = iRound3;
                iRound = i5;
            }
            int iRound4 = Math.round(-rectFB.top);
            float f2 = i2;
            if (f2 < rectFB.height()) {
                iRound2 = Math.round(rectFB.height() - f2);
                i6 = 0;
            } else {
                i6 = iRound4;
                iRound2 = i6;
            }
            this.c = iRound3;
            this.d = iRound4;
            if (iRound3 == iRound && iRound4 == iRound2) {
                return;
            }
            this.b.a(iRound3, iRound4, i3, i4, i5, iRound, i6, iRound2, 0, 0);
        }

        @Override // java.lang.Runnable
        public void run() {
            ImageView imageViewC = b.this.c();
            if (imageViewC == null || !this.b.a()) {
                return;
            }
            int iB = this.b.b();
            int iC = this.b.c();
            b.this.i.postTranslate(this.c - iB, this.d - iC);
            b.this.b(b.this.j());
            this.c = iB;
            this.d = iC;
            com.mg.ola.common.widget.image.viewer.a.a(imageViewC, this);
        }
    }

    public interface e {
        void a(RectF rectF);
    }

    public interface f {
        void a(View view, float f, float f2);
    }

    public interface g {
        void b(View view, float f, float f2);
    }

    public b(ImageView imageView) {
        this.e = new WeakReference<>(imageView);
        imageView.setOnTouchListener(this);
        this.f = imageView.getViewTreeObserver();
        this.f.addOnGlobalLayoutListener(this);
        c(imageView);
        if (imageView.isInEditMode()) {
            return;
        }
        AnonymousClass1 anonymousClass1 = null;
        this.y = new ScaleGestureDetector(imageView.getContext(), new c(this, anonymousClass1));
        this.z = new GestureDetector(imageView.getContext(), new C0083b(this, anonymousClass1));
        b(true);
    }

    private float a(Matrix matrix, int i) {
        matrix.getValues(this.l);
        return this.l[i];
    }

    private RectF a(Matrix matrix) {
        Drawable drawable;
        ImageView imageViewC = c();
        if (imageViewC == null || (drawable = imageViewC.getDrawable()) == null) {
            return null;
        }
        this.k.set(0.0f, 0.0f, drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight());
        matrix.mapRect(this.k);
        return this.k;
    }

    private void a(Drawable drawable) {
        Matrix matrix;
        Matrix.ScaleToFit scaleToFit;
        float fMin;
        ImageView imageViewC = c();
        if (imageViewC == null || drawable == null) {
            return;
        }
        float width = imageViewC.getWidth();
        float height = imageViewC.getHeight();
        int intrinsicWidth = drawable.getIntrinsicWidth();
        int intrinsicHeight = drawable.getIntrinsicHeight();
        this.g.reset();
        float f2 = intrinsicWidth;
        float f3 = width / f2;
        float f4 = intrinsicHeight;
        float f5 = height / f4;
        if (this.x == ImageView.ScaleType.CENTER) {
            this.g.postTranslate((width - f2) / 2.0f, (height - f4) / 2.0f);
        } else {
            if (this.x == ImageView.ScaleType.CENTER_CROP) {
                fMin = Math.max(f3, f5);
            } else if (this.x == ImageView.ScaleType.CENTER_INSIDE) {
                fMin = Math.min(1.0f, Math.min(f3, f5));
            } else {
                RectF rectF = new RectF(0.0f, 0.0f, f2, f4);
                RectF rectF2 = new RectF(0.0f, 0.0f, width, height);
                switch (AnonymousClass1.a[this.x.ordinal()]) {
                    case 2:
                        matrix = this.g;
                        scaleToFit = Matrix.ScaleToFit.START;
                        break;
                    case 3:
                        matrix = this.g;
                        scaleToFit = Matrix.ScaleToFit.END;
                        break;
                    case 4:
                        matrix = this.g;
                        scaleToFit = Matrix.ScaleToFit.CENTER;
                        break;
                    case 5:
                        matrix = this.g;
                        scaleToFit = Matrix.ScaleToFit.FILL;
                        break;
                }
                matrix.setRectToRect(rectF, rectF2, scaleToFit);
            }
            this.g.postScale(fMin, fMin);
            this.g.postTranslate((width - (f2 * fMin)) / 2.0f, (height - (f4 * fMin)) / 2.0f);
        }
        p();
    }

    private static void b(float f2, float f3, float f4) {
        if (f2 >= f3) {
            throw new IllegalArgumentException("MinZoom should be less than MidZoom");
        }
        if (f3 >= f4) {
            throw new IllegalArgumentException("MidZoom should be less than MaxZoom");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(Matrix matrix) {
        RectF rectFA;
        ImageView imageViewC = c();
        if (imageViewC != null) {
            n();
            imageViewC.setImageMatrix(matrix);
            if (this.m == null || (rectFA = a(matrix)) == null) {
                return;
            }
            this.m.a(rectFA);
        }
    }

    private static boolean b(ImageView.ScaleType scaleType) {
        if (scaleType == null) {
            return false;
        }
        if (AnonymousClass1.a[scaleType.ordinal()] != 1) {
        }
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean b(ImageView imageView) {
        return (imageView == null || imageView.getDrawable() == null) ? false : true;
    }

    private static void c(ImageView imageView) {
        if (imageView == null || (imageView instanceof PhotoView)) {
            return;
        }
        imageView.setScaleType(ImageView.ScaleType.MATRIX);
    }

    private void l() {
        if (this.u != null) {
            this.u.a();
            this.u = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void m() {
        o();
        b(j());
    }

    private void n() {
        ImageView imageViewC = c();
        if (imageViewC != null && !(imageViewC instanceof PhotoView) && imageViewC.getScaleType() != ImageView.ScaleType.MATRIX) {
            throw new IllegalStateException("The ImageView's ScaleType has been changed since attaching a PhotoViewAttacher");
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x003c  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void o() {
        /*
            r9 = this;
            android.widget.ImageView r0 = r9.c()
            if (r0 != 0) goto L7
            return
        L7:
            android.graphics.Matrix r1 = r9.j()
            android.graphics.RectF r1 = r9.a(r1)
            if (r1 != 0) goto L12
            return
        L12:
            float r2 = r1.height()
            float r3 = r1.width()
            int r4 = r0.getHeight()
            float r4 = (float) r4
            int r5 = (r2 > r4 ? 1 : (r2 == r4 ? 0 : -1))
            r6 = 1073741824(0x40000000, float:2.0)
            r7 = 0
            if (r5 > 0) goto L40
            int[] r5 = com.mg.ola.common.widget.image.viewer.b.AnonymousClass1.a
            android.widget.ImageView$ScaleType r8 = r9.x
            int r8 = r8.ordinal()
            r5 = r5[r8]
            switch(r5) {
                case 2: goto L3c;
                case 3: goto L3a;
                default: goto L33;
            }
        L33:
            float r4 = r4 - r2
            float r4 = r4 / r6
        L35:
            float r2 = r1.top
        L37:
            float r2 = r4 - r2
            goto L51
        L3a:
            float r4 = r4 - r2
            goto L35
        L3c:
            float r2 = r1.top
            float r2 = -r2
            goto L51
        L40:
            float r2 = r1.top
            int r2 = (r2 > r7 ? 1 : (r2 == r7 ? 0 : -1))
            if (r2 <= 0) goto L47
            goto L3c
        L47:
            float r2 = r1.bottom
            int r2 = (r2 > r4 ? 1 : (r2 == r4 ? 0 : -1))
            if (r2 >= 0) goto L50
            float r2 = r1.bottom
            goto L37
        L50:
            r2 = 0
        L51:
            int r0 = r0.getWidth()
            float r0 = (float) r0
            int r4 = (r3 > r0 ? 1 : (r3 == r0 ? 0 : -1))
            if (r4 > 0) goto L78
            int[] r4 = com.mg.ola.common.widget.image.viewer.b.AnonymousClass1.a
            android.widget.ImageView$ScaleType r5 = r9.x
            int r5 = r5.ordinal()
            r4 = r4[r5]
            switch(r4) {
                case 2: goto L70;
                case 3: goto L6e;
                default: goto L67;
            }
        L67:
            float r0 = r0 - r3
            float r0 = r0 / r6
        L69:
            float r1 = r1.left
            float r0 = r0 - r1
        L6c:
            r7 = r0
            goto L74
        L6e:
            float r0 = r0 - r3
            goto L69
        L70:
            float r0 = r1.left
            float r0 = -r0
            goto L6c
        L74:
            r0 = 2
        L75:
            r9.v = r0
            goto L93
        L78:
            float r3 = r1.left
            int r3 = (r3 > r7 ? 1 : (r3 == r7 ? 0 : -1))
            if (r3 <= 0) goto L85
            r0 = 0
            r9.v = r0
            float r0 = r1.left
            float r7 = -r0
            goto L93
        L85:
            float r3 = r1.right
            int r3 = (r3 > r0 ? 1 : (r3 == r0 ? 0 : -1))
            if (r3 >= 0) goto L91
            float r1 = r1.right
            float r7 = r0 - r1
            r0 = 1
            goto L75
        L91:
            r0 = -1
            goto L75
        L93:
            android.graphics.Matrix r0 = r9.i
            r0.postTranslate(r7, r2)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.mg.ola.common.widget.image.viewer.b.o():void");
    }

    private void p() {
        this.i.reset();
        b(j());
        o();
    }

    private void q() {
        if (b(c())) {
            RectF rectFA = a(j());
            float height = c().getHeight();
            float width = c().getWidth() / rectFA.width();
            float fHeight = height / rectFA.height();
            if (width != fHeight && width > fHeight) {
                this.i.postScale(fHeight, fHeight);
            } else {
                this.i.postScale(width, width);
            }
        }
    }

    public final void a() {
        if (this.f != null && this.f.isAlive()) {
            this.f.removeGlobalOnLayoutListener(this);
        }
        this.f = null;
        this.m = null;
        this.n = null;
        this.o = null;
        this.e = null;
    }

    public void a(float f2) {
        b(f2, this.b, this.c);
        this.a = f2;
    }

    public void a(float f2, float f3, float f4) {
        this.B += f2;
        if (this.B >= 360.0f) {
            this.B -= 360.0f;
        }
        this.j.postRotate(f2, f3, f4);
        q();
        m();
    }

    public final void a(float f2, float f3, float f4, boolean z) {
        ImageView imageViewC = c();
        if (imageViewC != null) {
            if (z) {
                imageViewC.post(new a(g(), f2, f3, f4));
            } else {
                this.i.postScale(f2, f2, f3, f4);
                m();
            }
        }
    }

    public final void a(View.OnLongClickListener onLongClickListener) {
        this.p = onLongClickListener;
    }

    public final void a(ImageView.ScaleType scaleType) {
        if (!b(scaleType) || scaleType == this.x) {
            return;
        }
        this.x = scaleType;
        i();
    }

    public final void a(e eVar) {
        this.m = eVar;
    }

    public final void a(f fVar) {
        this.n = fVar;
    }

    public final void a(g gVar) {
        this.o = gVar;
    }

    public void a(boolean z) {
        this.d = z;
    }

    public final RectF b() {
        o();
        return a(j());
    }

    public void b(float f2) {
        b(this.a, f2, this.c);
        this.b = f2;
    }

    public final void b(boolean z) {
        this.w = z;
        i();
    }

    public final ImageView c() {
        ImageView imageView = this.e != null ? this.e.get() : null;
        if (imageView == null) {
            a();
        }
        return imageView;
    }

    public void c(float f2) {
        b(this.a, this.b, f2);
        this.c = f2;
    }

    public void c(boolean z) {
        this.C = z;
    }

    public float d() {
        return this.a;
    }

    public float e() {
        return this.b;
    }

    public float f() {
        return this.c;
    }

    public final float g() {
        return a(this.i, 0);
    }

    public final ImageView.ScaleType h() {
        return this.x;
    }

    public final void i() {
        ImageView imageViewC = c();
        if (imageViewC != null) {
            if (!this.w) {
                p();
            } else {
                c(imageViewC);
                a(imageViewC.getDrawable());
            }
        }
    }

    protected Matrix j() {
        this.h.set(this.g);
        this.h.postConcat(this.j);
        this.h.postConcat(this.i);
        return this.h;
    }

    public boolean k() {
        return this.A;
    }

    @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
    public final void onGlobalLayout() {
        ImageView imageViewC = c();
        if (imageViewC == null || !this.w) {
            return;
        }
        int top = imageViewC.getTop();
        int right = imageViewC.getRight();
        int bottom = imageViewC.getBottom();
        int left = imageViewC.getLeft();
        if (top == this.q && bottom == this.s && left == this.t && right == this.r) {
            return;
        }
        a(imageViewC.getDrawable());
        this.q = top;
        this.r = right;
        this.s = bottom;
        this.t = left;
    }

    /* JADX WARN: Removed duplicated region for block: B:9:0x001c  */
    @Override // android.view.View.OnTouchListener
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean onTouch(android.view.View r11, android.view.MotionEvent r12) {
        /*
            r10 = this;
            boolean r0 = r10.w
            r1 = 0
            if (r0 == 0) goto L6d
            int r0 = r12.getAction()
            r2 = 3
            r3 = 1
            if (r0 == r2) goto L1c
            switch(r0) {
                case 0: goto L11;
                case 1: goto L1c;
                default: goto L10;
            }
        L10:
            goto L4a
        L11:
            android.view.ViewParent r11 = r11.getParent()
            r11.requestDisallowInterceptTouchEvent(r3)
            r10.l()
            goto L4a
        L1c:
            float r0 = r10.g()
            float r2 = r10.a
            int r0 = (r0 > r2 ? 1 : (r0 == r2 ? 0 : -1))
            if (r0 >= 0) goto L4a
            android.graphics.RectF r0 = r10.b()
            if (r0 == 0) goto L46
            com.mg.ola.common.widget.image.viewer.b$a r2 = new com.mg.ola.common.widget.image.viewer.b$a
            float r6 = r10.g()
            float r7 = r10.a
            float r8 = r0.centerX()
            float r9 = r0.centerY()
            r4 = r2
            r5 = r10
            r4.<init>(r6, r7, r8, r9)
            r11.post(r2)
            r11 = 1
            goto L47
        L46:
            r11 = 0
        L47:
            r10.A = r1
            r1 = r11
        L4a:
            boolean r11 = r10.C
            if (r11 == 0) goto L6d
            android.view.GestureDetector r11 = r10.z     // Catch: java.lang.Exception -> L69
            if (r11 == 0) goto L5b
            android.view.GestureDetector r11 = r10.z     // Catch: java.lang.Exception -> L69
            boolean r11 = r11.onTouchEvent(r12)     // Catch: java.lang.Exception -> L69
            if (r11 == 0) goto L5b
            r1 = 1
        L5b:
            android.view.ScaleGestureDetector r11 = r10.y     // Catch: java.lang.Exception -> L69
            if (r11 == 0) goto L6d
            android.view.ScaleGestureDetector r11 = r10.y     // Catch: java.lang.Exception -> L69
            boolean r11 = r11.onTouchEvent(r12)     // Catch: java.lang.Exception -> L69
            if (r11 == 0) goto L6d
            r1 = 1
            return r1
        L69:
            r11 = move-exception
            r11.printStackTrace()
        L6d:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.mg.ola.common.widget.image.viewer.b.onTouch(android.view.View, android.view.MotionEvent):boolean");
    }
}
