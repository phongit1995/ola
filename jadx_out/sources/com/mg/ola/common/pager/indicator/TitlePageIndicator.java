package com.mg.ola.common.pager.indicator;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RectF;
import android.graphics.Typeface;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.view.MotionEventCompat;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewConfigurationCompat;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import chat.ola.vn.R;
import chat.ola.vn.i;
import com.mg.ola.common.widget.OlaViewPager;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
public class TitlePageIndicator extends View implements com.mg.ola.common.pager.indicator.a {
    private OlaViewPager a;
    private ViewPager.OnPageChangeListener b;
    private PagerAdapter c;
    private int d;
    private int e;
    private int f;
    private final Paint g;
    private boolean h;
    private int i;
    private int j;
    private Path k;
    private final Paint l;
    private IndicatorStyle m;
    private final Paint n;
    private float o;
    private float p;
    private float q;
    private float r;
    private float s;
    private float t;
    private float u;
    private int v;
    private float w;
    private int x;
    private boolean y;
    private a z;

    public enum IndicatorStyle {
        None(0),
        Triangle(1),
        Underline(2);

        public final int d;

        IndicatorStyle(int i) {
            this.d = i;
        }

        public static IndicatorStyle a(int i) {
            for (IndicatorStyle indicatorStyle : values()) {
                if (indicatorStyle.d == i) {
                    return indicatorStyle;
                }
            }
            return null;
        }
    }

    static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new Parcelable.Creator<SavedState>() { // from class: com.mg.ola.common.pager.indicator.TitlePageIndicator.SavedState.1
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

    public interface a {
        void a(int i);
    }

    public TitlePageIndicator(Context context) {
        this(context, null);
    }

    public TitlePageIndicator(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, R.attr.TitlePageIndicatorStyle);
    }

    public TitlePageIndicator(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.g = new Paint();
        this.l = new Paint();
        this.n = new Paint();
        this.w = -1.0f;
        this.x = -1;
        Resources resources = getResources();
        int color = resources.getColor(R.color.default_title_indicator_footer_color);
        float dimension = resources.getDimension(R.dimen.default_title_indicator_footer_line_height);
        int integer = resources.getInteger(R.integer.default_title_indicator_footer_indicator_style);
        float dimension2 = resources.getDimension(R.dimen.default_title_indicator_footer_indicator_height);
        float dimension3 = resources.getDimension(R.dimen.default_title_indicator_footer_indicator_underline_padding);
        float dimension4 = resources.getDimension(R.dimen.default_title_indicator_footer_padding);
        int color2 = resources.getColor(R.color.default_title_indicator_selected_color);
        boolean z = resources.getBoolean(R.bool.default_title_indicator_selected_bold);
        int color3 = resources.getColor(R.color.default_title_indicator_text_color);
        float dimension5 = resources.getDimension(R.dimen.default_title_indicator_text_size);
        float dimension6 = resources.getDimension(R.dimen.default_title_indicator_title_padding);
        float dimension7 = resources.getDimension(R.dimen.default_title_indicator_clip_padding);
        float dimension8 = resources.getDimension(R.dimen.default_title_indicator_top_padding);
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, i.b.TitlePageIndicator, i, R.style.Widget_TitlePageIndicator);
        this.u = typedArrayObtainStyledAttributes.getDimension(5, dimension);
        this.m = IndicatorStyle.a(typedArrayObtainStyledAttributes.getInteger(3, integer));
        this.o = typedArrayObtainStyledAttributes.getDimension(2, dimension2);
        this.p = typedArrayObtainStyledAttributes.getDimension(4, dimension3);
        this.q = typedArrayObtainStyledAttributes.getDimension(6, dimension4);
        this.s = typedArrayObtainStyledAttributes.getDimension(12, dimension8);
        this.r = typedArrayObtainStyledAttributes.getDimension(11, dimension6);
        this.t = typedArrayObtainStyledAttributes.getDimension(0, dimension7);
        this.j = typedArrayObtainStyledAttributes.getColor(8, color2);
        this.i = typedArrayObtainStyledAttributes.getColor(9, color3);
        this.h = typedArrayObtainStyledAttributes.getBoolean(7, z);
        float dimension9 = typedArrayObtainStyledAttributes.getDimension(10, dimension5);
        int color4 = typedArrayObtainStyledAttributes.getColor(1, color);
        this.g.setTextSize(dimension9);
        this.g.setAntiAlias(true);
        this.l.setStyle(Paint.Style.FILL_AND_STROKE);
        this.l.setStrokeWidth(this.u);
        this.l.setColor(color4);
        this.n.setStyle(Paint.Style.FILL_AND_STROKE);
        this.n.setColor(color4);
        typedArrayObtainStyledAttributes.recycle();
        this.v = ViewConfigurationCompat.getScaledPagingTouchSlop(ViewConfiguration.get(context));
    }

    private RectF a(int i, Paint paint) {
        RectF rectF = new RectF();
        rectF.right = paint.measureText(this.c.getPageTitle(i).toString());
        rectF.bottom = paint.descent() - paint.ascent();
        return rectF;
    }

    private ArrayList<RectF> a(Paint paint) {
        ArrayList<RectF> arrayList = new ArrayList<>();
        int count = this.a.getAdapter().getCount();
        int width = getWidth() / 2;
        for (int i = 0; i < count; i++) {
            RectF rectFA = a(i, paint);
            float f = rectFA.right - rectFA.left;
            float f2 = rectFA.bottom - rectFA.top;
            rectFA.left = ((width - (f / 2.0f)) - this.e) + ((i - this.d) * r2);
            rectFA.right = rectFA.left + f;
            rectFA.top = 0.0f;
            rectFA.bottom = f2;
            arrayList.add(rectFA);
        }
        return arrayList;
    }

    private void a(RectF rectF, float f, int i) {
        rectF.right = i - this.t;
        rectF.left = rectF.right - f;
    }

    private void b(RectF rectF, float f, int i) {
        rectF.left = i + this.t;
        rectF.right = this.t + f;
    }

    public float getClipPadding() {
        return this.t;
    }

    public int getFooterColor() {
        return this.l.getColor();
    }

    public float getFooterIndicatorHeight() {
        return this.o;
    }

    public float getFooterIndicatorPadding() {
        return this.q;
    }

    public IndicatorStyle getFooterIndicatorStyle() {
        return this.m;
    }

    public float getFooterLineHeight() {
        return this.u;
    }

    public int getSelectedColor() {
        return this.j;
    }

    public int getTextColor() {
        return this.i;
    }

    public float getTextSize() {
        return this.g.getTextSize();
    }

    public float getTitlePadding() {
        return this.r;
    }

    public float getTopPadding() {
        return this.s;
    }

    public Typeface getTypeface() {
        return this.g.getTypeface();
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        int count;
        float f;
        float f2;
        int i;
        float f3;
        super.onDraw(canvas);
        if (this.a == null || (count = this.a.getAdapter().getCount()) == 0) {
            return;
        }
        ArrayList<RectF> arrayListA = a(this.g);
        int size = arrayListA.size();
        if (this.d >= size) {
            setCurrentItem(size - 1);
            return;
        }
        int i2 = count - 1;
        float width = getWidth() / 2.0f;
        int left = getLeft();
        float f4 = left;
        float f5 = this.t + f4;
        int width2 = getWidth();
        int height = getHeight();
        int i3 = left + width2;
        float f6 = i3;
        float f7 = f6 - this.t;
        int i4 = this.d;
        if (this.e <= width) {
            f2 = this.e * 1.0f;
            f = width;
        } else {
            f = width;
            i4++;
            f2 = (width2 - this.e) * 1.0f;
        }
        float f8 = f2 / width2;
        boolean z = f8 <= 0.25f;
        boolean z2 = f8 <= 0.05f;
        float f9 = (0.25f - f8) / 0.25f;
        RectF rectF = arrayListA.get(this.d);
        float f10 = rectF.right - rectF.left;
        if (rectF.left < f5) {
            b(rectF, f10, left);
        }
        if (rectF.right > f7) {
            a(rectF, f10, i3);
        }
        if (this.d > 0) {
            int i5 = this.d - 1;
            while (i5 >= 0) {
                RectF rectF2 = arrayListA.get(i5);
                if (rectF2.left < f5) {
                    f3 = f5;
                    float f11 = rectF2.right - rectF2.left;
                    b(rectF2, f11, left);
                    RectF rectF3 = arrayListA.get(i5 + 1);
                    i = left;
                    if (rectF2.right + this.r > rectF3.left) {
                        rectF2.left = (rectF3.left - f11) - this.r;
                        rectF2.right = rectF2.left + f11;
                    }
                } else {
                    i = left;
                    f3 = f5;
                }
                i5--;
                f5 = f3;
                left = i;
            }
        }
        if (this.d < i2) {
            for (int i6 = this.d + 1; i6 < count; i6++) {
                RectF rectF4 = arrayListA.get(i6);
                if (rectF4.right > f7) {
                    float f12 = rectF4.right - rectF4.left;
                    a(rectF4, f12, i3);
                    RectF rectF5 = arrayListA.get(i6 - 1);
                    if (rectF4.left - this.r < rectF5.right) {
                        rectF4.left = rectF5.right + this.r;
                        rectF4.right = rectF4.left + f12;
                    }
                }
            }
        }
        int i7 = this.i >>> 24;
        int i8 = 0;
        while (i8 < count) {
            RectF rectF6 = arrayListA.get(i8);
            if ((rectF6.left > f4 && rectF6.left < f6) || (rectF6.right > f4 && rectF6.right < f6)) {
                boolean z3 = i8 == i4;
                this.g.setFakeBoldText(z3 && z2 && this.h);
                this.g.setColor(this.i);
                if (z3 && z) {
                    this.g.setAlpha(i7 - ((int) (i7 * f9)));
                }
                canvas.drawText(this.c.getPageTitle(i8).toString(), rectF6.left, rectF6.bottom + this.s, this.g);
                if (z3 && z) {
                    this.g.setColor(this.j);
                    this.g.setAlpha((int) ((this.j >>> 24) * f9));
                    canvas.drawText(this.c.getPageTitle(i8).toString(), rectF6.left, rectF6.bottom + this.s, this.g);
                }
            }
            i8++;
        }
        this.k = new Path();
        float f13 = height;
        this.k.moveTo(0.0f, f13 - (this.u / 2.0f));
        this.k.lineTo(width2, f13 - (this.u / 2.0f));
        this.k.close();
        canvas.drawPath(this.k, this.l);
        switch (this.m) {
            case Triangle:
                this.k = new Path();
                float f14 = f;
                this.k.moveTo(f14, (f13 - this.u) - this.o);
                this.k.lineTo(this.o + f14, f13 - this.u);
                this.k.lineTo(f14 - this.o, f13 - this.u);
                this.k.close();
                canvas.drawPath(this.k, this.n);
                break;
            case Underline:
                if (z && i4 < size) {
                    RectF rectF7 = arrayListA.get(i4);
                    this.k = new Path();
                    this.k.moveTo(rectF7.left - this.p, f13 - this.u);
                    this.k.lineTo(rectF7.right + this.p, f13 - this.u);
                    this.k.lineTo(rectF7.right + this.p, (f13 - this.u) - this.o);
                    this.k.lineTo(rectF7.left - this.p, (f13 - this.u) - this.o);
                    this.k.close();
                    this.n.setAlpha((int) (f9 * 255.0f));
                    canvas.drawPath(this.k, this.n);
                    this.n.setAlpha(255);
                    break;
                }
                break;
        }
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        float size;
        int size2 = View.MeasureSpec.getSize(i);
        if (View.MeasureSpec.getMode(i2) == 1073741824) {
            size = View.MeasureSpec.getSize(i2);
        } else {
            RectF rectF = new RectF();
            rectF.bottom = this.g.descent() - this.g.ascent();
            size = this.s + (rectF.bottom - rectF.top) + this.u + this.q;
            if (this.m != IndicatorStyle.None) {
                size += this.o;
            }
        }
        setMeasuredDimension(size2, (int) size);
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrollStateChanged(int i) {
        this.f = i;
        if (this.b != null) {
            this.b.onPageScrollStateChanged(i);
        }
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrolled(int i, float f, int i2) {
        this.d = i;
        this.e = i2;
        invalidate();
        if (this.b != null) {
            this.b.onPageScrolled(i, f, i2);
        }
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageSelected(int i) {
        if (this.f == 0) {
            this.d = i;
            invalidate();
        }
        if (this.b != null) {
            this.b.onPageSelected(i);
        }
    }

    @Override // android.view.View
    public void onRestoreInstanceState(Parcelable parcelable) {
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.getSuperState());
        this.d = savedState.a;
        requestLayout();
    }

    @Override // android.view.View
    public Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        savedState.a = this.d;
        return savedState;
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        float x;
        OlaViewPager olaViewPager;
        int i;
        if (super.onTouchEvent(motionEvent)) {
            return true;
        }
        if (this.a == null || this.a.getAdapter().getCount() == 0) {
            return false;
        }
        switch (motionEvent.getAction() & 255) {
            case 0:
                this.x = MotionEventCompat.getPointerId(motionEvent, 0);
                x = motionEvent.getX();
                this.w = x;
                return true;
            case 1:
            case 3:
                if (!this.y) {
                    int count = this.a.getAdapter().getCount();
                    float width = getWidth();
                    float f = width / 2.0f;
                    float f2 = width / 6.0f;
                    float f3 = f - f2;
                    float f4 = f + f2;
                    float x2 = motionEvent.getX();
                    if (x2 < f3) {
                        if (this.d > 0) {
                            olaViewPager = this.a;
                            i = this.d - 1;
                            olaViewPager.setCurrentItem(i);
                            return true;
                        }
                    } else if (x2 > f4) {
                        if (this.d < count - 1) {
                            olaViewPager = this.a;
                            i = this.d + 1;
                            olaViewPager.setCurrentItem(i);
                            return true;
                        }
                    } else if (this.z != null) {
                        this.z.a(this.d);
                    }
                    return true;
                }
                this.y = false;
                this.x = -1;
                if (this.a.isFakeDragging()) {
                    this.a.endFakeDrag();
                    return true;
                }
                return true;
            case 2:
                float x3 = MotionEventCompat.getX(motionEvent, MotionEventCompat.findPointerIndex(motionEvent, this.x));
                float f5 = x3 - this.w;
                if (!this.y && Math.abs(f5) > this.v) {
                    this.y = true;
                }
                if (this.y) {
                    if (!this.a.isFakeDragging()) {
                        this.a.beginFakeDrag();
                    }
                    this.w = x3;
                    this.a.fakeDragBy(f5);
                    return true;
                }
                return true;
            case 4:
            default:
                return true;
            case 5:
                int actionIndex = MotionEventCompat.getActionIndex(motionEvent);
                this.w = MotionEventCompat.getX(motionEvent, actionIndex);
                this.x = MotionEventCompat.getPointerId(motionEvent, actionIndex);
                return true;
            case 6:
                int actionIndex2 = MotionEventCompat.getActionIndex(motionEvent);
                if (MotionEventCompat.getPointerId(motionEvent, actionIndex2) == this.x) {
                    this.x = MotionEventCompat.getPointerId(motionEvent, actionIndex2 == 0 ? 1 : 0);
                }
                x = MotionEventCompat.getX(motionEvent, MotionEventCompat.findPointerIndex(motionEvent, this.x));
                this.w = x;
                return true;
        }
    }

    public void setClipPadding(float f) {
        this.t = f;
        invalidate();
    }

    public void setCurrentItem(int i) {
        if (this.a == null) {
            throw new IllegalStateException("OlaViewPager has not been bound.");
        }
        this.a.setCurrentItem(i);
        this.d = i;
        invalidate();
    }

    public void setFooterColor(int i) {
        this.l.setColor(i);
        this.n.setColor(i);
        invalidate();
    }

    public void setFooterIndicatorHeight(float f) {
        this.o = f;
        invalidate();
    }

    public void setFooterIndicatorPadding(float f) {
        this.q = f;
        invalidate();
    }

    public void setFooterIndicatorStyle(IndicatorStyle indicatorStyle) {
        this.m = indicatorStyle;
        invalidate();
    }

    public void setFooterLineHeight(float f) {
        this.u = f;
        this.l.setStrokeWidth(this.u);
        invalidate();
    }

    public void setOnCenterItemClickListener(a aVar) {
        this.z = aVar;
    }

    public void setOnPageChangeListener(ViewPager.OnPageChangeListener onPageChangeListener) {
        this.b = onPageChangeListener;
    }

    public void setSelectedBold(boolean z) {
        this.h = z;
        invalidate();
    }

    public void setSelectedColor(int i) {
        this.j = i;
        invalidate();
    }

    public void setTextColor(int i) {
        this.g.setColor(i);
        this.i = i;
        invalidate();
    }

    public void setTextSize(float f) {
        this.g.setTextSize(f);
        invalidate();
    }

    public void setTitlePadding(float f) {
        this.r = f;
        invalidate();
    }

    public void setTopPadding(float f) {
        this.s = f;
        invalidate();
    }

    public void setTypeface(Typeface typeface) {
        this.g.setTypeface(typeface);
        invalidate();
    }

    public void setViewPager(OlaViewPager olaViewPager) {
        PagerAdapter adapter = olaViewPager.getAdapter();
        if (adapter == null) {
            throw new IllegalStateException("OlaViewPager does not have adapter instance.");
        }
        this.a = olaViewPager;
        this.a.setOnPageChangeListener(this);
        this.c = adapter;
        invalidate();
    }
}
