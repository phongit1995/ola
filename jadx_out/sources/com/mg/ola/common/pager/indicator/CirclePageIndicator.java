package com.mg.ola.common.pager.indicator;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.view.MotionEventCompat;
import android.support.v4.view.ViewConfigurationCompat;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import chat.ola.vn.R;
import chat.ola.vn.i;
import com.mg.ola.common.widget.OlaViewPager;

/* JADX INFO: loaded from: classes2.dex */
public class CirclePageIndicator extends View implements ViewPager.OnPageChangeListener, a {
    private float a;
    private final Paint b;
    private final Paint c;
    private final Paint d;
    private OlaViewPager e;
    private ViewPager.OnPageChangeListener f;
    private int g;
    private int h;
    private int i;
    private int j;
    private int k;
    private int l;
    private boolean m;
    private boolean n;
    private int o;
    private float p;
    private int q;
    private boolean r;
    private float s;

    static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new Parcelable.Creator<SavedState>() { // from class: com.mg.ola.common.pager.indicator.CirclePageIndicator.SavedState.1
            @Override // android.os.Parcelable.Creator
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel);
            }

            @Override // android.os.Parcelable.Creator
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        };
        int a;

        private SavedState(Parcel parcel) {
            super(parcel);
            this.a = parcel.readInt();
        }

        public SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        @Override // android.view.View.BaseSavedState, android.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeInt(this.a);
        }
    }

    public CirclePageIndicator(Context context) {
        this(context, null);
    }

    public CirclePageIndicator(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, R.attr.CirclePageIndicatorStyle);
    }

    public CirclePageIndicator(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.p = -1.0f;
        this.q = -1;
        Resources resources = getResources();
        int color = resources.getColor(R.color.default_circle_indicator_page_color);
        int color2 = resources.getColor(R.color.default_circle_indicator_fill_color);
        int integer = resources.getInteger(R.integer.default_circle_indicator_orientation);
        int color3 = resources.getColor(R.color.default_circle_indicator_stroke_color);
        float dimension = resources.getDimension(R.dimen.default_circle_indicator_stroke_width);
        float dimension2 = resources.getDimension(R.dimen.default_circle_indicator_radius);
        boolean z = resources.getBoolean(R.bool.default_circle_indicator_centered);
        boolean z2 = resources.getBoolean(R.bool.default_circle_indicator_snap);
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, i.b.CirclePageIndicator, i, R.style.Widget_CirclePageIndicator);
        this.m = typedArrayObtainStyledAttributes.getBoolean(0, z);
        this.l = typedArrayObtainStyledAttributes.getInt(2, integer);
        this.b = new Paint(1);
        this.b.setStyle(Paint.Style.FILL);
        this.b.setColor(typedArrayObtainStyledAttributes.getColor(3, color));
        this.c = new Paint(1);
        this.c.setStyle(Paint.Style.STROKE);
        this.c.setColor(typedArrayObtainStyledAttributes.getColor(6, color3));
        this.c.setStrokeWidth(typedArrayObtainStyledAttributes.getDimension(7, dimension));
        this.d = new Paint(1);
        this.d.setStyle(Paint.Style.FILL);
        this.d.setColor(typedArrayObtainStyledAttributes.getColor(1, color2));
        this.a = typedArrayObtainStyledAttributes.getDimension(4, dimension2);
        this.n = typedArrayObtainStyledAttributes.getBoolean(5, z2);
        typedArrayObtainStyledAttributes.recycle();
        this.o = ViewConfigurationCompat.getScaledPagingTouchSlop(ViewConfiguration.get(context));
    }

    private int a(int i) {
        int mode = View.MeasureSpec.getMode(i);
        int size = View.MeasureSpec.getSize(i);
        if (mode == 1073741824 || this.e == null) {
            return size;
        }
        int count = this.e.getAdapter().getCount();
        int paddingLeft = (int) (getPaddingLeft() + getPaddingRight() + (count * 2 * (this.a + this.s)) + ((count - 1) * this.a) + 1.0f);
        return mode == Integer.MIN_VALUE ? Math.min(paddingLeft, size) : paddingLeft;
    }

    private void a() {
        if (this.e != null) {
            this.k = this.l == 0 ? this.e.getWidth() : this.e.getHeight();
        }
    }

    private int b(int i) {
        int mode = View.MeasureSpec.getMode(i);
        int size = View.MeasureSpec.getSize(i);
        if (mode == 1073741824) {
            return size;
        }
        int paddingTop = (int) ((this.a * 2.0f) + getPaddingTop() + getPaddingBottom() + 1.0f + this.s);
        return mode == Integer.MIN_VALUE ? Math.min(paddingTop, size) : paddingTop;
    }

    public int getFillColor() {
        return this.d.getColor();
    }

    public int getOrientation() {
        return this.l;
    }

    public int getPageColor() {
        return this.b.getColor();
    }

    public float getRadius() {
        return this.a;
    }

    public int getStrokeColor() {
        return this.c.getColor();
    }

    public float getStrokeWidth() {
        return this.c.getStrokeWidth();
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        int count;
        int height;
        int paddingTop;
        int paddingBottom;
        int paddingLeft;
        float f;
        float f2;
        float f3;
        super.onDraw(canvas);
        if (this.e == null || (count = this.e.getAdapter().getCount()) == 0) {
            return;
        }
        if (this.g >= count) {
            setCurrentItem(count - 1);
            return;
        }
        if (this.l == 0) {
            height = getWidth();
            paddingTop = getPaddingLeft();
            paddingBottom = getPaddingRight();
            paddingLeft = getPaddingTop();
        } else {
            height = getHeight();
            paddingTop = getPaddingTop();
            paddingBottom = getPaddingBottom();
            paddingLeft = getPaddingLeft();
        }
        float f4 = this.a * 3.0f;
        float f5 = paddingLeft + this.a;
        float f6 = paddingTop + this.a + this.s;
        if (this.m) {
            f6 += (((height - paddingTop) - paddingBottom) / 2.0f) - ((count * f4) / 2.0f);
        }
        float strokeWidth = this.a;
        if (this.c.getStrokeWidth() > 0.0f) {
            strokeWidth -= this.c.getStrokeWidth() / 2.0f;
        }
        for (int i = 0; i < count; i++) {
            float f7 = (i * f4) + f6;
            if (this.l == 0) {
                f7 = 1.0f + f5;
                f3 = f7;
            } else {
                f3 = 1.0f + f5;
            }
            if (this.b.getAlpha() > 0) {
                canvas.drawCircle(f3, f7, strokeWidth, this.b);
            }
            if (strokeWidth != this.a) {
                canvas.drawCircle(f3, f7, this.a, this.c);
            }
        }
        float f8 = (this.n ? this.h : this.g) * f4;
        if (!this.n && this.k != 0) {
            f8 += ((this.i * 1.0f) / this.k) * f4;
        }
        if (this.l == 0) {
            f2 = f5 + 1.0f;
            f = f6 + f8;
        } else {
            f = f5 + 1.0f;
            f2 = f6 + f8;
        }
        canvas.drawCircle(f, f2, this.a, this.d);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        int iB;
        int iA;
        if (this.l == 0) {
            iB = a(i);
            iA = b(i2);
        } else {
            iB = b(i);
            iA = a(i2);
        }
        setMeasuredDimension(iB, iA);
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrollStateChanged(int i) {
        this.j = i;
        if (i == 0) {
            try {
                this.g = this.e.getCurrentItem();
                this.h = this.e.getCurrentItem();
                this.i = 0;
                invalidate();
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
        if (this.f != null) {
            this.f.onPageScrollStateChanged(i);
        }
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrolled(int i, float f, int i2) {
        this.g = i;
        this.i = i2;
        a();
        invalidate();
        if (this.f != null) {
            this.f.onPageScrolled(i, f, i2);
        }
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageSelected(int i) {
        if (this.n || this.j == 0) {
            this.g = i;
            this.h = i;
            invalidate();
        }
        if (this.f != null) {
            this.f.onPageSelected(i);
        }
    }

    @Override // android.view.View
    public void onRestoreInstanceState(Parcelable parcelable) {
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.getSuperState());
        this.g = savedState.a;
        this.h = savedState.a;
        requestLayout();
    }

    @Override // android.view.View
    public Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        savedState.a = this.g;
        return savedState;
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        float x;
        if (super.onTouchEvent(motionEvent)) {
            return true;
        }
        if (this.e == null || this.e.getAdapter().getCount() == 0) {
            return false;
        }
        switch (motionEvent.getAction() & 255) {
            case 0:
                this.q = MotionEventCompat.getPointerId(motionEvent, 0);
                x = motionEvent.getX();
                this.p = x;
                return true;
            case 1:
            case 3:
                if (!this.r) {
                    int count = this.e.getAdapter().getCount();
                    float width = getWidth();
                    float f = width / 2.0f;
                    float f2 = width / 6.0f;
                    if (this.g > 0 && motionEvent.getX() < f - f2) {
                        this.e.setCurrentItem(this.g - 1);
                        return true;
                    }
                    if (this.g < count - 1 && motionEvent.getX() > f + f2) {
                        this.e.setCurrentItem(this.g + 1);
                        return true;
                    }
                }
                this.r = false;
                this.q = -1;
                if (this.e.isFakeDragging()) {
                    this.e.endFakeDrag();
                    return true;
                }
                return true;
            case 2:
                float x2 = MotionEventCompat.getX(motionEvent, MotionEventCompat.findPointerIndex(motionEvent, this.q));
                float f3 = x2 - this.p;
                if (!this.r && Math.abs(f3) > this.o) {
                    this.r = true;
                }
                if (this.r) {
                    if (!this.e.isFakeDragging()) {
                        this.e.beginFakeDrag();
                    }
                    this.p = x2;
                    this.e.fakeDragBy(f3);
                    return true;
                }
                return true;
            case 4:
            default:
                return true;
            case 5:
                int actionIndex = MotionEventCompat.getActionIndex(motionEvent);
                this.p = MotionEventCompat.getX(motionEvent, actionIndex);
                this.q = MotionEventCompat.getPointerId(motionEvent, actionIndex);
                return true;
            case 6:
                int actionIndex2 = MotionEventCompat.getActionIndex(motionEvent);
                if (MotionEventCompat.getPointerId(motionEvent, actionIndex2) == this.q) {
                    this.q = MotionEventCompat.getPointerId(motionEvent, actionIndex2 == 0 ? 1 : 0);
                }
                x = MotionEventCompat.getX(motionEvent, MotionEventCompat.findPointerIndex(motionEvent, this.q));
                this.p = x;
                return true;
        }
    }

    public void setCentered(boolean z) {
        this.m = z;
        invalidate();
    }

    public void setCurrentItem(int i) {
        if (this.e == null) {
            throw new IllegalStateException("OlaViewPager has not been bound.");
        }
        this.e.setCurrentItem(i);
        this.g = i;
        invalidate();
    }

    public void setFillColor(int i) {
        this.d.setColor(i);
        invalidate();
    }

    public void setOnPageChangeListener(ViewPager.OnPageChangeListener onPageChangeListener) {
        this.f = onPageChangeListener;
    }

    public void setOrientation(int i) {
        switch (i) {
            case 0:
            case 1:
                this.l = i;
                a();
                requestLayout();
                return;
            default:
                throw new IllegalArgumentException("Orientation must be either HORIZONTAL or VERTICAL.");
        }
    }

    public void setPageColor(int i) {
        this.b.setColor(i);
        invalidate();
    }

    public void setRadius(float f) {
        this.a = f;
        invalidate();
    }

    public void setSnap(boolean z) {
        this.n = z;
        invalidate();
    }

    public void setStrokeColor(int i) {
        this.c.setColor(i);
        invalidate();
    }

    public void setStrokeWidth(float f) {
        this.c.setStrokeWidth(f);
        this.s = f;
        invalidate();
    }

    public void setViewPager(OlaViewPager olaViewPager) {
        if (olaViewPager.getAdapter() == null) {
            throw new IllegalStateException("OlaViewPager does not have adapter instance.");
        }
        this.e = olaViewPager;
        this.e.setOnPageChangeListener(this);
        a();
        invalidate();
    }
}
