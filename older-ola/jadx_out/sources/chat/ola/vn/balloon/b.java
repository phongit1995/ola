package chat.ola.vn.balloon;

import android.R;
import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.support.v4.view.GestureDetectorCompat;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.WindowManager;
import android.widget.RelativeLayout;
import chat.ola.vn.OlaApplication;

/* JADX INFO: loaded from: classes.dex */
public abstract class b extends RelativeLayout implements a {
    protected byte a;
    public WindowManager.LayoutParams b;
    protected chat.ola.vn.p.e c;
    protected int d;
    protected int e;
    protected float f;
    protected float g;
    boolean h;
    boolean i;
    protected GestureDetectorCompat j;
    protected int k;
    protected d l;
    protected Rect m;
    protected int n;
    protected int o;
    protected c p;
    protected OlaBalloonService q;
    protected long r;

    public b(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = (byte) 0;
        this.f = 0.0f;
        this.g = 0.0f;
        this.h = false;
        this.i = false;
        this.n = -1;
        this.o = -1;
        this.r = 0L;
    }

    public b(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = (byte) 0;
        this.f = 0.0f;
        this.g = 0.0f;
        this.h = false;
        this.i = false;
        this.n = -1;
        this.o = -1;
        this.r = 0L;
    }

    public b(OlaBalloonService olaBalloonService, int i, int i2) {
        super(olaBalloonService);
        this.a = (byte) 0;
        this.f = 0.0f;
        this.g = 0.0f;
        this.h = false;
        this.i = false;
        this.n = -1;
        this.o = -1;
        this.r = 0L;
        this.r = System.currentTimeMillis();
        this.q = olaBalloonService;
        this.d = i;
        this.e = i2;
        this.k = getResources().getConfiguration().orientation;
        this.b = new WindowManager.LayoutParams(this.d, this.e, 2002, 40, -3);
        this.b.gravity = 51;
        this.b.windowAnimations = R.style.Animation;
        setBackgroundColor(0);
        this.j = new GestureDetectorCompat(olaBalloonService, new GestureDetector.OnGestureListener() { // from class: chat.ola.vn.balloon.b.1
            @Override // android.view.GestureDetector.OnGestureListener
            public boolean onDown(MotionEvent motionEvent) {
                return false;
            }

            @Override // android.view.GestureDetector.OnGestureListener
            public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
                float fAbs = b.this.h ? Math.abs(f) : -Math.abs(f);
                float fAbs2 = b.this.i ? Math.abs(f2) : -Math.abs(f2);
                int i3 = b.this.b.x + ((int) fAbs);
                int i4 = b.this.b.y + ((int) fAbs2);
                b.this.a = (byte) 2;
                int[] iArrA = b.a((a) b.this, i3, i4);
                if (iArrA != null) {
                    i3 = iArrA[0];
                    i4 = iArrA[1];
                }
                b.this.a(i3, i4);
                return true;
            }

            @Override // android.view.GestureDetector.OnGestureListener
            public void onLongPress(MotionEvent motionEvent) {
            }

            @Override // android.view.GestureDetector.OnGestureListener
            public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
                return false;
            }

            @Override // android.view.GestureDetector.OnGestureListener
            public void onShowPress(MotionEvent motionEvent) {
            }

            @Override // android.view.GestureDetector.OnGestureListener
            public boolean onSingleTapUp(MotionEvent motionEvent) {
                return false;
            }
        });
    }

    public static Bitmap a(Context context, Bitmap bitmap) {
        return a(context, bitmap, true, true);
    }

    public static Bitmap a(Context context, Bitmap bitmap, boolean z, boolean z2) {
        Drawable drawable = context.getResources().getDrawable(chat.ola.vn.R.drawable.bg_border_chat_balloon);
        Bitmap bitmapDecodeResource = BitmapFactory.decodeResource(context.getResources(), chat.ola.vn.R.drawable.bg_border_chat_balloon);
        Rect rect = new Rect();
        drawable.getPadding(rect);
        int width = bitmapDecodeResource.getWidth();
        int height = bitmapDecodeResource.getHeight();
        rect.right = width - rect.right;
        rect.bottom = height - rect.bottom;
        int iWidth = width - rect.width();
        Bitmap bitmapCreateBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmapCreateBitmap);
        Paint paint = new Paint();
        paint.setAntiAlias(true);
        canvas.drawARGB(0, 0, 0, 0);
        paint.setColor(-12434878);
        float f = width / 2.0f;
        canvas.drawCircle(f, f, (width - iWidth) / 2, paint);
        paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
        if (z) {
            Rect rect2 = new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
            int i = iWidth / 2;
            int i2 = width - i;
            Rect rect3 = new Rect(i, i, i2, i2);
            if (!z2) {
                paint = null;
            }
            canvas.drawBitmap(bitmap, rect2, rect3, paint);
        } else {
            int width2 = (width - bitmap.getWidth()) / 2;
            int height2 = (height - bitmap.getHeight()) / 2;
            Rect rect4 = new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
            Rect rect5 = new Rect(width2, height2, width - width2, width - height2);
            if (!z2) {
                paint = null;
            }
            canvas.drawBitmap(bitmap, rect4, rect5, paint);
        }
        Rect rect6 = new Rect(0, 0, width, height);
        canvas.drawBitmap(bitmapDecodeResource, rect6, rect6, (Paint) null);
        return bitmapCreateBitmap;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(int i, int i2) {
        if (OlaApplication.c != null) {
            OlaApplication.c.a(this, this.b, i, i2, 800L);
        }
    }

    public static int[] a(a aVar, int i, int i2) {
        int windowWidth = aVar.getWindowWidth() - aVar.getBalloonWidth();
        int windowHeight = aVar.getWindowHeight() - aVar.getBalloonHeight();
        int currentPositionX = aVar.getCurrentPositionX();
        int currentPositionY = aVar.getCurrentPositionY();
        if (i < 0) {
            float f = i2 - currentPositionY;
            int i3 = ((int) ((currentPositionX / (currentPositionX - i)) * f)) + currentPositionY;
            return i3 < 0 ? new int[]{currentPositionX + ((int) ((currentPositionY / (currentPositionY - i2)) * (i - currentPositionX))), 0} : i3 > windowHeight ? new int[]{currentPositionX + ((int) (((windowHeight - currentPositionY) / f) * (i - currentPositionX))), windowHeight} : new int[]{0, i3};
        }
        if (i > windowWidth) {
            float f2 = i - currentPositionX;
            float f3 = i2 - currentPositionY;
            int i4 = ((int) (((windowWidth - currentPositionX) / f2) * f3)) + currentPositionY;
            return i4 < 0 ? new int[]{currentPositionX + ((int) ((currentPositionY / (currentPositionY - i2)) * f2)), 0} : i4 > windowHeight ? new int[]{currentPositionX + ((int) (((windowHeight - currentPositionY) / f3) * f2)), windowHeight} : new int[]{windowWidth, i4};
        }
        if (i2 < 0) {
            float f4 = i - currentPositionX;
            int i5 = ((int) ((currentPositionY / (currentPositionY - i2)) * f4)) + currentPositionX;
            return i5 < 0 ? new int[]{0, currentPositionY + ((int) ((currentPositionX / (currentPositionX - i)) * (i2 - currentPositionY)))} : i5 > windowWidth ? new int[]{windowWidth, currentPositionY + ((int) (((windowWidth - currentPositionX) / f4) * (i2 - currentPositionY)))} : new int[]{i5, 0};
        }
        if (i2 <= windowHeight) {
            return null;
        }
        float f5 = i2 - currentPositionY;
        float f6 = i - currentPositionX;
        int i6 = ((int) (((windowHeight - currentPositionY) / f5) * f6)) + currentPositionX;
        return i6 < 0 ? new int[]{0, currentPositionY + ((int) ((currentPositionX / (currentPositionX - i)) * f5))} : i6 > windowWidth ? new int[]{windowWidth, currentPositionY + ((int) (((windowWidth - currentPositionX) / f6) * f5))} : new int[]{i6, windowHeight};
    }

    private void b(int i, int i2) {
        if (OlaApplication.c != null) {
            OlaApplication.c.a(this, this.b, i, i2);
        }
    }

    private void f() {
        int windowWidth = 0;
        try {
            try {
                try {
                    if (this.l != null) {
                        Rect rect = new Rect(this.b.x, this.b.y, this.b.x + this.b.width, this.b.y + this.b.height);
                        Rect rect2 = new Rect(0, getWindowHeight() - (getWindowHeight() / 6), getWindowWidth(), getWindowHeight());
                        try {
                            rect2 = new Rect(this.l.b.x, this.l.b.y, this.l.b.x + this.l.getBalloonWidth(), this.l.b.y + this.l.getBalloonHeight());
                        } catch (Throwable unused) {
                        }
                        if (rect2.intersect(rect)) {
                            this.a = (byte) 4;
                            b(this.b.x, getWindowHeight() - getBalloonHeight());
                            return;
                        }
                    }
                } catch (Throwable unused2) {
                    return;
                }
            } catch (Throwable unused3) {
                this.a = (byte) 4;
                b(this.b.x, getWindowHeight() - getBalloonHeight());
                return;
            }
        } catch (Throwable unused4) {
            this.q.b(this);
        }
        int balloonWidth = this.b.x + (getBalloonWidth() / 2);
        int windowWidth2 = getWindowWidth() - balloonWidth;
        int iMin = Math.min(balloonWidth, windowWidth2);
        int i = this.b.x;
        int i2 = this.b.y;
        if (i <= 0) {
            this.a = (byte) 0;
            return;
        }
        if (i >= getWindowWidth() - getBalloonWidth()) {
            this.a = (byte) 0;
            return;
        }
        if (iMin != balloonWidth) {
            windowWidth = iMin == windowWidth2 ? getWindowWidth() - getBalloonWidth() : i;
        }
        this.a = (byte) 1;
        b(windowWidth, i2);
    }

    @Override // chat.ola.vn.balloon.a
    public void a() {
        if (OlaApplication.c != null) {
            OlaApplication.c.a(this, this.b);
        }
    }

    @Override // chat.ola.vn.balloon.a
    public void b() {
        byte b = this.a;
        if (b == 4) {
            this.a = (byte) 0;
            setVisibility(8);
            return;
        }
        switch (b) {
            case 1:
                this.a = (byte) 0;
                if (this.p != null) {
                    this.p.a(this);
                }
                break;
            case 2:
                f();
                break;
        }
    }

    @Override // chat.ola.vn.balloon.a
    public boolean c() {
        return this.a == 1 || this.a == 2 || this.a == 4;
    }

    @Override // chat.ola.vn.balloon.a
    public boolean d() {
        try {
            if (this.b.y + this.b.height < getWindowHeight()) {
                return false;
            }
            this.a = (byte) 0;
            if (!e()) {
                setVisibility(8);
                if (this.q != null) {
                    try {
                        this.q.a(this);
                    } catch (Throwable unused) {
                    }
                }
            }
            return true;
        } catch (Throwable unused2) {
            return false;
        }
    }

    public boolean e() {
        return true;
    }

    public int getBackupX() {
        return this.n;
    }

    public int getBackupY() {
        return this.o;
    }

    public Rect getBalloonBound() {
        if (this.m == null) {
            this.m = new Rect(this.b.x, this.b.y, this.b.x + getBalloonWidth(), this.b.y + getBalloonHeight());
        } else {
            this.m.set(this.b.x, this.b.y, this.b.x + getBalloonWidth(), this.b.y + getBalloonHeight());
        }
        return this.m;
    }

    @Override // chat.ola.vn.balloon.a
    public Handler getBalloonHandler() {
        return getHandler();
    }

    @Override // chat.ola.vn.balloon.a
    public int getBalloonHeight() {
        return this.e;
    }

    @Override // chat.ola.vn.balloon.a
    public WindowManager.LayoutParams getBalloonLayoutParameter() {
        return this.b;
    }

    public d getBalloonTerminator() {
        return this.l;
    }

    @Override // chat.ola.vn.balloon.a
    public int getBalloonWidth() {
        return this.d;
    }

    public long getLastAccess() {
        return this.r;
    }

    public c getOlaBalloonAnimationListener() {
        return this.p;
    }

    public chat.ola.vn.p.e getOlaBalloonListener() {
        return this.c;
    }

    @Override // chat.ola.vn.balloon.a
    public int getWindowHeight() {
        try {
            return this.q.e();
        } catch (Throwable unused) {
            return chat.ola.vn.e.d;
        }
    }

    @Override // chat.ola.vn.balloon.a
    public int getWindowWidth() {
        try {
            return this.q.d();
        } catch (Throwable unused) {
            return chat.ola.vn.e.c;
        }
    }

    @Override // android.view.View
    protected void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        this.k = getResources().getConfiguration().orientation;
        f();
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        int windowWidth;
        int windowHeight;
        if (this.j.onTouchEvent(motionEvent)) {
            if (motionEvent.getAction() == 1 && this.l != null) {
                this.l.f();
            }
            return false;
        }
        switch (motionEvent.getAction()) {
            case 0:
                this.a = (byte) 3;
                this.f = motionEvent.getRawX();
                this.g = motionEvent.getRawY();
                break;
            case 1:
                if (this.l != null) {
                    this.l.f();
                }
                if (this.a == 1) {
                    f();
                } else if (this.a == 3) {
                    this.a = (byte) 0;
                    if (this.c != null) {
                        this.c.b(this);
                    }
                }
                break;
            case 2:
                float rawX = motionEvent.getRawX();
                float rawY = motionEvent.getRawY();
                float f = rawX - this.f;
                float f2 = rawY - this.g;
                if (f >= 0.0f) {
                    this.h = true;
                } else {
                    this.h = false;
                }
                if (f2 >= 0.0f) {
                    this.i = true;
                } else {
                    this.i = false;
                }
                if (this.a == 1 || Math.max(Math.abs(f), Math.abs(f2)) >= Math.max(getWindowWidth(), getWindowHeight()) / 100) {
                    if (this.l != null) {
                        this.l.e();
                    }
                    this.a = (byte) 1;
                    this.f = rawX;
                    this.g = rawY;
                    int i = (int) (this.b.x + f);
                    int i2 = (int) (this.b.y + f2);
                    if (Math.max(Math.abs(f), Math.abs(f2)) > Math.max(getWindowWidth(), getWindowHeight()) / 100) {
                        windowWidth = (int) (rawX - (getBalloonWidth() / 2));
                        windowHeight = (int) (rawY - (getBalloonHeight() / 2));
                    } else {
                        windowWidth = i;
                        windowHeight = i2;
                    }
                    if (windowWidth < 0) {
                        windowWidth = 0;
                    } else if (windowWidth > getWindowWidth() - getBalloonWidth()) {
                        windowWidth = getWindowWidth() - getBalloonWidth();
                    }
                    if (windowHeight < 0) {
                        windowHeight = 0;
                    } else if (windowHeight > getWindowHeight() - getBalloonHeight()) {
                        windowHeight = getWindowHeight() - getBalloonHeight();
                    }
                    this.b.x = windowWidth;
                    this.b.y = windowHeight;
                    if (OlaApplication.c != null) {
                        OlaApplication.c.a(this, this.b);
                    }
                }
                break;
        }
        return false;
    }

    public void setBackupX(int i) {
        this.n = i;
    }

    public void setBackupY(int i) {
        this.o = i;
    }

    public void setBalloonTerminator(d dVar) {
        this.l = dVar;
    }

    public void setLastAccess(long j) {
        this.r = j;
    }

    public void setOlaBalloonAnimationListener(c cVar) {
        this.p = cVar;
    }

    public void setOlaBalloonListener(chat.ola.vn.p.e eVar) {
        this.c = eVar;
    }
}
