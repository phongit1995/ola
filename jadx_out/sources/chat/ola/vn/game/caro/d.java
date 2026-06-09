package chat.ola.vn.game.caro;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.graphics.PointF;
import android.graphics.Rect;
import android.os.CountDownTimer;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.f;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class d extends View {
    public static int a = 50;
    private static int i = 4;
    private static int j = f.l;
    private static int k = -13751571;
    private static int l = -971959;
    private static int m = -1877116613;
    private static int n = -234850889;
    private static long o = 2000;
    private static long p = 100;
    private Point A;
    private Paint b;
    private Paint c;
    private Paint d;
    private Paint e;
    private Paint f;
    private List<Point> g;
    private List<Point> h;
    private int q;
    private int r;
    private Point s;
    private boolean t;
    private boolean u;
    private PointF v;
    private CountDownTimer w;
    private a x;
    private boolean y;
    private Point z;

    public interface a {
        void a(int i, int i2);
    }

    public d(Context context) {
        super(context);
        this.t = true;
        this.u = false;
        this.y = false;
        d();
    }

    public d(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.t = true;
        this.u = false;
        this.y = false;
        d();
    }

    public d(Context context, AttributeSet attributeSet, int i2) {
        super(context, attributeSet, i2);
        this.t = true;
        this.u = false;
        this.y = false;
        d();
    }

    private Point a(float f, float f2) {
        int i2 = (int) f;
        int i3 = (int) f2;
        try {
            return new Point(i2 - (i2 % a), i3 - (i3 % a));
        } catch (Throwable unused) {
            return null;
        }
    }

    private void a(Canvas canvas) {
        try {
            if (!this.t || this.s == null) {
                return;
            }
            canvas.drawRect(new Rect(this.s.x + 4, this.s.y + 4, (this.s.x + a) - 4, (this.s.y + a) - 4), this.e);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(Point point, Canvas canvas) {
        try {
            int i2 = a / 5;
            canvas.drawLine(point.x + i2, point.y + i2, (point.x + a) - i2, (point.y + a) - i2, this.c);
            canvas.drawLine(point.x + i2, (point.y + a) - i2, (point.x + a) - i2, point.y + i2, this.c);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private boolean a(Point point, List<Point> list) {
        if (point == null || list == null) {
            return false;
        }
        try {
            for (Point point2 : list) {
                if (point2.x == point.x && point2.y == point.y) {
                    return true;
                }
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    private void b(Canvas canvas) {
        if (this.y) {
            canvas.drawLine(this.z.x, this.z.y, this.A.x, this.A.y, this.f);
        }
    }

    private void b(Point point, Canvas canvas) {
        try {
            canvas.drawCircle(point.x + (a / 2), point.y + (a / 2), a / 3.0f, this.d);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private boolean b(Point point) {
        try {
            if (a(point, this.g)) {
                return false;
            }
            return !a(point, this.h);
        } catch (Throwable unused) {
            return false;
        }
    }

    private void c(Canvas canvas) {
        for (int i2 = 0; i2 <= this.r; i2++) {
            try {
                canvas.drawLine(a * i2, 0.0f, a * i2, canvas.getHeight(), this.b);
            } catch (Throwable th) {
                th.printStackTrace();
                return;
            }
        }
        for (int i3 = 0; i3 <= this.q; i3++) {
            canvas.drawLine(0.0f, a * i3, canvas.getWidth(), a * i3, this.b);
        }
    }

    private void d() {
        e();
        this.h = new ArrayList(0);
        this.g = new ArrayList(0);
        setBackgroundColor(j);
        this.w = new CountDownTimer(o, p) { // from class: chat.ola.vn.game.caro.d.1
            @Override // android.os.CountDownTimer
            public void onFinish() {
                d.this.e.setColor(d.m);
                d.this.invalidate();
            }

            @Override // android.os.CountDownTimer
            public void onTick(long j2) {
                Paint paint;
                int i2;
                if (d.this.e.getColor() == d.m) {
                    paint = d.this.e;
                    i2 = d.j;
                } else {
                    paint = d.this.e;
                    i2 = d.m;
                }
                paint.setColor(i2);
                d.this.invalidate();
            }
        };
    }

    private void d(Canvas canvas) {
        try {
            Iterator<Point> it2 = this.g.iterator();
            while (it2.hasNext()) {
                a(it2.next(), canvas);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void e() {
        this.b = new Paint(1);
        this.b.setStrokeWidth(1.0f);
        this.b.setColor(-12303292);
        this.c = new Paint(1);
        this.c.setStrokeWidth(i);
        this.c.setStrokeCap(Paint.Cap.ROUND);
        this.c.setColor(k);
        this.d = new Paint(1);
        this.d.setStrokeWidth(i);
        this.d.setStyle(Paint.Style.STROKE);
        this.d.setColor(l);
        this.e = new Paint(1);
        this.e.setStrokeWidth(i);
        this.e.setStyle(Paint.Style.FILL_AND_STROKE);
        this.e.setColor(m);
        this.f = new Paint(1);
        this.f.setStrokeWidth(a / 2);
        this.f.setStrokeCap(Paint.Cap.ROUND);
        this.f.setStyle(Paint.Style.FILL_AND_STROKE);
        this.f.setColor(n);
    }

    private void e(Canvas canvas) {
        try {
            Iterator<Point> it2 = this.h.iterator();
            while (it2.hasNext()) {
                b(it2.next(), canvas);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public Point a(int i2, int i3) {
        try {
            return new Point((i3 * a) + (a / 2), (i2 * a) + (a / 2));
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a() {
        this.h = null;
        this.g = null;
        this.s = null;
        this.z = null;
        this.A = null;
        this.y = false;
    }

    public void a(int i2, int i3, int i4, int i5) {
        a(a(i2, i3), a(i4, i5));
    }

    public void a(Point point) {
        try {
            if (point == null) {
                this.s = null;
                invalidate();
                return;
            }
            if (this.s == null) {
                this.s = new Point(point);
            } else {
                this.s.set(point.x, point.y);
            }
            if (this.w != null) {
                this.w.cancel();
                if (this.t) {
                    this.w.start();
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(Point point, Point point2) {
        if (point == null || point2 == null) {
            return;
        }
        this.z = new Point(point);
        this.A = new Point(point2);
        this.y = true;
        invalidate();
    }

    public void a(chat.ola.vn.game.caro.a aVar) {
        List<Point> list;
        if (aVar != null) {
            try {
                Point pointB = b(aVar);
                if (aVar.e == chat.ola.vn.game.caro.a.a) {
                    if (this.h == null) {
                        this.h = new ArrayList(0);
                    }
                    list = this.h;
                } else {
                    if (aVar.e != chat.ola.vn.game.caro.a.b) {
                        return;
                    }
                    if (this.g == null) {
                        this.g = new ArrayList(0);
                    }
                    list = this.g;
                }
                list.add(pointB);
                a(pointB);
            } catch (Throwable unused) {
            }
        }
    }

    public Point b(chat.ola.vn.game.caro.a aVar) {
        if (aVar == null) {
            return null;
        }
        try {
            return new Point(aVar.d * a, aVar.c * a);
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean b(int i2, int i3) {
        try {
            Rect rect = new Rect();
            getLocalVisibleRect(rect);
            return rect.contains(i2, i3);
        } catch (Throwable unused) {
            return false;
        }
    }

    public void c(int i2, int i3) {
        if (i2 < 0 || i3 < 0) {
            return;
        }
        try {
            this.q = i2;
            this.r = i3;
            setLayoutParams(new ViewGroup.LayoutParams(i3 * a, i2 * a));
            requestLayout();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.View
    public void draw(Canvas canvas) {
        super.draw(canvas);
        c(canvas);
        a(canvas);
        d(canvas);
        e(canvas);
        b(canvas);
    }

    public a getCaroViewListener() {
        return this.x;
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        switch (motionEvent.getActionMasked()) {
            case 0:
            case 5:
                if (this.v == null) {
                    this.v = new PointF();
                }
                this.v.set(motionEvent.getX(), motionEvent.getY());
                this.u = false;
                return true;
            case 1:
            case 6:
                if (!this.u) {
                    Point pointA = a(motionEvent.getX(), motionEvent.getY());
                    if (pointA != null && b(pointA) && this.x != null) {
                        this.x.a(pointA.y / a, pointA.x / a);
                    }
                    this.u = false;
                }
                return true;
            case 2:
                if (((float) Math.pow(Math.pow(motionEvent.getX() - this.v.x, 2.0d) + Math.pow(motionEvent.getY() - this.v.y, 2.0d), 0.5d)) > 1.0f) {
                    this.u = true;
                }
                return true;
            case 3:
            case 4:
            default:
                return super.onTouchEvent(motionEvent);
        }
    }

    public void setCaroViewListener(a aVar) {
        this.x = aVar;
    }

    public void setDrawBackgroundLastPoint(boolean z) {
        this.t = z;
    }

    public void setOList(List<chat.ola.vn.game.caro.a> list) {
        if (list != null) {
            try {
                if (this.h != null) {
                    this.h.clear();
                } else {
                    this.h = new ArrayList(0);
                }
                Iterator<chat.ola.vn.game.caro.a> it2 = list.iterator();
                while (it2.hasNext()) {
                    Point pointB = b(it2.next());
                    if (pointB != null) {
                        this.h.add(pointB);
                    }
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    public void setXList(List<chat.ola.vn.game.caro.a> list) {
        if (list != null) {
            try {
                if (this.g != null) {
                    this.g.clear();
                } else {
                    this.g = new ArrayList(0);
                }
                Iterator<chat.ola.vn.game.caro.a> it2 = list.iterator();
                while (it2.hasNext()) {
                    Point pointB = b(it2.next());
                    if (pointB != null) {
                        this.g.add(pointB);
                    }
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }
}
