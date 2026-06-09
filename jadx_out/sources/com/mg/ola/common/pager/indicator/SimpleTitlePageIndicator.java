package com.mg.ola.common.pager.indicator;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
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
public class SimpleTitlePageIndicator extends View implements com.mg.ola.common.pager.indicator.a {
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
    private float k;
    private float l;
    private float m;
    private int n;
    private float o;
    private int p;
    private boolean q;
    private a r;

    static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new Parcelable.Creator<SavedState>() { // from class: com.mg.ola.common.pager.indicator.SimpleTitlePageIndicator.SavedState.1
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

    public SimpleTitlePageIndicator(Context context) {
        this(context, null);
    }

    public SimpleTitlePageIndicator(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, R.attr.TitlePageIndicatorStyle);
    }

    public SimpleTitlePageIndicator(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.g = new Paint();
        this.o = -1.0f;
        this.p = -1;
        Resources resources = getResources();
        int color = resources.getColor(R.color.default_title_indicator_footer_color);
        int color2 = resources.getColor(R.color.default_title_indicator_selected_color);
        boolean z = resources.getBoolean(R.bool.default_title_indicator_selected_bold);
        int color3 = resources.getColor(R.color.default_title_indicator_text_color);
        float dimension = resources.getDimension(R.dimen.default_title_indicator_text_size);
        float dimension2 = resources.getDimension(R.dimen.default_title_indicator_title_padding);
        float dimension3 = resources.getDimension(R.dimen.default_title_indicator_clip_padding);
        float dimension4 = resources.getDimension(R.dimen.default_title_indicator_top_padding);
        TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, i.b.TitlePageIndicator, i, R.style.Widget_TitlePageIndicator);
        this.l = typedArrayObtainStyledAttributes.getDimension(12, dimension4);
        this.k = typedArrayObtainStyledAttributes.getDimension(11, dimension2);
        this.m = typedArrayObtainStyledAttributes.getDimension(0, dimension3);
        this.j = typedArrayObtainStyledAttributes.getColor(8, color2);
        this.i = typedArrayObtainStyledAttributes.getColor(9, color3);
        this.h = typedArrayObtainStyledAttributes.getBoolean(7, z);
        float dimension5 = typedArrayObtainStyledAttributes.getDimension(10, dimension);
        typedArrayObtainStyledAttributes.getColor(1, color);
        this.g.setTextSize(dimension5);
        this.g.setAntiAlias(true);
        typedArrayObtainStyledAttributes.recycle();
        this.n = ViewConfigurationCompat.getScaledPagingTouchSlop(ViewConfiguration.get(context));
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
        rectF.right = i - this.m;
        rectF.left = rectF.right - f;
    }

    private void b(RectF rectF, float f, int i) {
        rectF.left = i + this.m;
        rectF.right = this.m + f;
    }

    public float getClipPadding() {
        return this.m;
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
        return this.k;
    }

    public float getTopPadding() {
        return this.l;
    }

    public Typeface getTypeface() {
        return this.g.getTypeface();
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        int count;
        int i;
        float f;
        int i2;
        float f2;
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
        int i3 = count - 1;
        float width = getWidth() / 2.0f;
        int left = getLeft();
        float f3 = left;
        float f4 = this.m + f3;
        int width2 = getWidth();
        getHeight();
        int i4 = left + width2;
        float f5 = i4;
        float f6 = f5 - this.m;
        int i5 = this.d;
        if (this.e <= width) {
            i = this.e;
        } else {
            i5++;
            i = width2 - this.e;
        }
        float f7 = (i * 1.0f) / width2;
        boolean z = f7 <= 0.25f;
        boolean z2 = f7 <= 0.05f;
        float f8 = (0.25f - f7) / 0.25f;
        RectF rectF = arrayListA.get(this.d);
        float f9 = rectF.right - rectF.left;
        if (rectF.left < f4) {
            b(rectF, f9, left);
        }
        if (rectF.right > f6) {
            a(rectF, f9, i4);
        }
        if (this.d > 0) {
            int i6 = this.d - 1;
            while (i6 >= 0) {
                RectF rectF2 = arrayListA.get(i6);
                if (rectF2.left < f4) {
                    f2 = f4;
                    float f10 = rectF2.right - rectF2.left;
                    b(rectF2, f10, left);
                    RectF rectF3 = arrayListA.get(i6 + 1);
                    i2 = left;
                    f = f8;
                    if (rectF2.right + this.k > rectF3.left) {
                        rectF2.left = (rectF3.left - f10) - this.k;
                        rectF2.right = rectF2.left + f10;
                    }
                } else {
                    f = f8;
                    i2 = left;
                    f2 = f4;
                }
                i6--;
                f4 = f2;
                left = i2;
                f8 = f;
            }
        }
        float f11 = f8;
        if (this.d < i3) {
            for (int i7 = this.d + 1; i7 < count; i7++) {
                RectF rectF4 = arrayListA.get(i7);
                if (rectF4.right > f6) {
                    float f12 = rectF4.right - rectF4.left;
                    a(rectF4, f12, i4);
                    RectF rectF5 = arrayListA.get(i7 - 1);
                    if (rectF4.left - this.k < rectF5.right) {
                        rectF4.left = rectF5.right + this.k;
                        rectF4.right = rectF4.left + f12;
                    }
                }
            }
        }
        int i8 = this.i >>> 24;
        int i9 = 0;
        while (i9 < count) {
            RectF rectF6 = arrayListA.get(i9);
            if ((rectF6.left > f3 && rectF6.left < f5) || (rectF6.right > f3 && rectF6.right < f5)) {
                boolean z3 = i9 == i5;
                this.g.setFakeBoldText(z3 && z2 && this.h);
                this.g.setColor(this.i);
                if (z3 && z) {
                    this.g.setAlpha(i8 - ((int) (i8 * f11)));
                }
                canvas.drawText(this.c.getPageTitle(i9).toString(), rectF6.left, rectF6.bottom + this.l, this.g);
                if (z3 && z) {
                    this.g.setColor(this.j);
                    this.g.setAlpha((int) ((this.j >>> 24) * f11));
                    canvas.drawText(this.c.getPageTitle(i9).toString(), rectF6.left, rectF6.bottom + this.l, this.g);
                }
            }
            i9++;
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
            size = this.l + (rectF.bottom - rectF.top);
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
                this.p = MotionEventCompat.getPointerId(motionEvent, 0);
                x = motionEvent.getX();
                this.o = x;
                return true;
            case 1:
            case 3:
                if (!this.q) {
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
                    } else if (this.r != null) {
                        this.r.a(this.d);
                    }
                    return true;
                }
                this.q = false;
                this.p = -1;
                if (this.a.isFakeDragging()) {
                    this.a.endFakeDrag();
                    return true;
                }
                return true;
            case 2:
                float x3 = MotionEventCompat.getX(motionEvent, MotionEventCompat.findPointerIndex(motionEvent, this.p));
                float f5 = x3 - this.o;
                if (!this.q && Math.abs(f5) > this.n) {
                    this.q = true;
                }
                if (this.q) {
                    if (!this.a.isFakeDragging()) {
                        this.a.beginFakeDrag();
                    }
                    this.o = x3;
                    this.a.fakeDragBy(f5);
                    return true;
                }
                return true;
            case 4:
            default:
                return true;
            case 5:
                int actionIndex = MotionEventCompat.getActionIndex(motionEvent);
                this.o = MotionEventCompat.getX(motionEvent, actionIndex);
                this.p = MotionEventCompat.getPointerId(motionEvent, actionIndex);
                return true;
            case 6:
                int actionIndex2 = MotionEventCompat.getActionIndex(motionEvent);
                if (MotionEventCompat.getPointerId(motionEvent, actionIndex2) == this.p) {
                    this.p = MotionEventCompat.getPointerId(motionEvent, actionIndex2 == 0 ? 1 : 0);
                }
                x = MotionEventCompat.getX(motionEvent, MotionEventCompat.findPointerIndex(motionEvent, this.p));
                this.o = x;
                return true;
        }
    }

    public void setClipPadding(float f) {
        this.m = f;
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

    public void setOnCenterItemClickListener(a aVar) {
        this.r = aVar;
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
        this.k = f;
        invalidate();
    }

    public void setTopPadding(float f) {
        this.l = f;
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
