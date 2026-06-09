package chat.ola.vn.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.support.v4.internal.view.SupportMenu;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.widget.ImageView;
import java.util.Stack;

/* JADX INFO: loaded from: classes.dex */
public class OlaPaintableImageView extends ImageView {
    protected String a;
    private Stack<a> b;
    private a c;
    private Paint d;
    private b e;
    private boolean f;
    private boolean g;

    private class a {
        public Path a = new Path();
        public Paint b = new Paint();

        public a() {
        }
    }

    private class b {
        public float a;
        public float b;

        public b(float f, float f2) {
            this.a = f;
            this.b = f2;
        }
    }

    public OlaPaintableImageView(Context context) {
        super(context);
        this.e = new b(0.0f, 0.0f);
        this.a = null;
        this.f = true;
        this.g = false;
    }

    public OlaPaintableImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.e = new b(0.0f, 0.0f);
        this.a = null;
        this.f = true;
        this.g = false;
    }

    public OlaPaintableImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.e = new b(0.0f, 0.0f);
        this.a = null;
        this.f = true;
        this.g = false;
    }

    @Override // android.view.View
    public void draw(Canvas canvas) {
        super.draw(canvas);
        try {
            if (this.b != null) {
                int size = this.b.size();
                for (int i = 0; i < size; i++) {
                    canvas.drawPath(this.b.get(i).a, this.b.get(i).b);
                }
            }
        } catch (Exception e) {
            Log.e("draw", e + "---------" + e.getMessage());
        }
    }

    public Bitmap getBitmapAfterPainting() {
        try {
            setDrawingCacheEnabled(true);
            return getDrawingCache();
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        switch (motionEvent.getActionMasked()) {
            case 0:
            case 5:
                try {
                    this.c = new a();
                    if (this.d != null) {
                        this.c.b.set(this.d);
                    } else {
                        this.d = new Paint();
                        this.d.setColor(SupportMenu.CATEGORY_MASK);
                        this.d.setStrokeWidth(2.0f);
                        this.d.setStyle(Paint.Style.FILL_AND_STROKE);
                        this.d.setAntiAlias(true);
                        this.d.setShadowLayer(1.0f, 0.0f, 0.0f, this.d.getColor());
                    }
                    this.c.a.moveTo(motionEvent.getX(), motionEvent.getY());
                    if (this.b == null) {
                        this.b = new Stack<>();
                    }
                    this.b.add(this.c);
                    this.e.a = motionEvent.getX();
                    this.e.b = motionEvent.getY();
                    this.g = true;
                    invalidate();
                    break;
                } catch (Exception unused) {
                }
                return true;
            case 1:
            case 3:
            case 6:
                try {
                    if (this.g) {
                        if (this.e.a == motionEvent.getX() && this.e.b == motionEvent.getY()) {
                            this.c.a.quadTo(this.e.a, this.e.b, motionEvent.getX() + 1.0f, motionEvent.getY() + 1.0f);
                        }
                    } else if (this.e.a != motionEvent.getX() || this.e.b != motionEvent.getY()) {
                        this.c.a.moveTo(this.e.a, this.e.b);
                        this.c.a.quadTo(this.e.a, this.e.b, motionEvent.getX(), motionEvent.getY());
                    }
                    invalidate();
                    this.g = false;
                    break;
                } catch (Exception unused2) {
                }
                return true;
            case 2:
                try {
                    if (this.e.a != motionEvent.getX() || this.e.b != motionEvent.getY()) {
                        this.c.a.moveTo(this.e.a, this.e.b);
                        this.c.a.quadTo(this.e.a, this.e.b, motionEvent.getX(), motionEvent.getY());
                        this.e.a = motionEvent.getX();
                        this.e.b = motionEvent.getY();
                        this.g = false;
                        invalidate();
                    }
                    break;
                } catch (Exception unused3) {
                }
                return true;
            case 4:
            default:
                return super.onTouchEvent(motionEvent);
        }
    }
}
