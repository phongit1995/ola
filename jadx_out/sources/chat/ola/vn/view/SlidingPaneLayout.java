package chat.ola.vn.view;

import android.R;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.view.AccessibilityDelegateCompat;
import android.support.v4.view.MotionEventCompat;
import android.support.v4.view.ViewCompat;
import android.support.v4.view.accessibility.AccessibilityNodeInfoCompat;
import android.support.v4.widget.ViewDragHelper;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class SlidingPaneLayout extends ViewGroup {
    static final f a;
    private int b;
    private int c;
    private Drawable d;
    private final int e;
    private boolean f;
    private View g;
    private float h;
    private float i;
    private int j;
    private boolean k;
    private int l;
    private float m;
    private float n;
    private e o;
    private final ViewDragHelper p;
    private boolean q;
    private boolean r;
    private final Rect s;
    private final ArrayList<b> t;

    static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new Parcelable.Creator<SavedState>() { // from class: chat.ola.vn.view.SlidingPaneLayout.SavedState.1
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
        boolean a;

        private SavedState(Parcel parcel) {
            super(parcel);
            this.a = parcel.readInt() != 0;
        }

        SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        @Override // android.view.View.BaseSavedState, android.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeInt(this.a ? 1 : 0);
        }
    }

    class a extends AccessibilityDelegateCompat {
        private final Rect b = new Rect();

        a() {
        }

        private void a(AccessibilityNodeInfoCompat accessibilityNodeInfoCompat, AccessibilityNodeInfoCompat accessibilityNodeInfoCompat2) {
            Rect rect = this.b;
            accessibilityNodeInfoCompat2.getBoundsInParent(rect);
            accessibilityNodeInfoCompat.setBoundsInParent(rect);
            accessibilityNodeInfoCompat2.getBoundsInScreen(rect);
            accessibilityNodeInfoCompat.setBoundsInScreen(rect);
            accessibilityNodeInfoCompat.setVisibleToUser(accessibilityNodeInfoCompat2.isVisibleToUser());
            accessibilityNodeInfoCompat.setPackageName(accessibilityNodeInfoCompat2.getPackageName());
            accessibilityNodeInfoCompat.setClassName(accessibilityNodeInfoCompat2.getClassName());
            accessibilityNodeInfoCompat.setContentDescription(accessibilityNodeInfoCompat2.getContentDescription());
            accessibilityNodeInfoCompat.setEnabled(accessibilityNodeInfoCompat2.isEnabled());
            accessibilityNodeInfoCompat.setClickable(accessibilityNodeInfoCompat2.isClickable());
            accessibilityNodeInfoCompat.setFocusable(accessibilityNodeInfoCompat2.isFocusable());
            accessibilityNodeInfoCompat.setFocused(accessibilityNodeInfoCompat2.isFocused());
            accessibilityNodeInfoCompat.setAccessibilityFocused(accessibilityNodeInfoCompat2.isAccessibilityFocused());
            accessibilityNodeInfoCompat.setSelected(accessibilityNodeInfoCompat2.isSelected());
            accessibilityNodeInfoCompat.setLongClickable(accessibilityNodeInfoCompat2.isLongClickable());
            accessibilityNodeInfoCompat.addAction(accessibilityNodeInfoCompat2.getActions());
            accessibilityNodeInfoCompat.setMovementGranularities(accessibilityNodeInfoCompat2.getMovementGranularities());
        }

        public boolean a(View view) {
            return SlidingPaneLayout.this.e(view);
        }

        @Override // android.support.v4.view.AccessibilityDelegateCompat
        public void onInitializeAccessibilityEvent(View view, AccessibilityEvent accessibilityEvent) {
            super.onInitializeAccessibilityEvent(view, accessibilityEvent);
            accessibilityEvent.setClassName(SlidingPaneLayout.class.getName());
        }

        @Override // android.support.v4.view.AccessibilityDelegateCompat
        public void onInitializeAccessibilityNodeInfo(View view, AccessibilityNodeInfoCompat accessibilityNodeInfoCompat) {
            AccessibilityNodeInfoCompat accessibilityNodeInfoCompatObtain = AccessibilityNodeInfoCompat.obtain(accessibilityNodeInfoCompat);
            super.onInitializeAccessibilityNodeInfo(view, accessibilityNodeInfoCompatObtain);
            a(accessibilityNodeInfoCompat, accessibilityNodeInfoCompatObtain);
            accessibilityNodeInfoCompatObtain.recycle();
            accessibilityNodeInfoCompat.setClassName(SlidingPaneLayout.class.getName());
            accessibilityNodeInfoCompat.setSource(view);
            Object parentForAccessibility = ViewCompat.getParentForAccessibility(view);
            if (parentForAccessibility instanceof View) {
                accessibilityNodeInfoCompat.setParent((View) parentForAccessibility);
            }
            int childCount = SlidingPaneLayout.this.getChildCount();
            for (int i = 0; i < childCount; i++) {
                View childAt = SlidingPaneLayout.this.getChildAt(i);
                if (!a(childAt) && childAt.getVisibility() == 0) {
                    ViewCompat.setImportantForAccessibility(childAt, 1);
                    accessibilityNodeInfoCompat.addChild(childAt);
                }
            }
        }

        @Override // android.support.v4.view.AccessibilityDelegateCompat
        public boolean onRequestSendAccessibilityEvent(ViewGroup viewGroup, View view, AccessibilityEvent accessibilityEvent) {
            if (a(view)) {
                return false;
            }
            return super.onRequestSendAccessibilityEvent(viewGroup, view, accessibilityEvent);
        }
    }

    private class b implements Runnable {
        final View a;

        b(View view) {
            this.a = view;
        }

        @Override // java.lang.Runnable
        public void run() {
            if (this.a.getParent() == SlidingPaneLayout.this) {
                ViewCompat.setLayerType(this.a, 0, null);
                SlidingPaneLayout.this.g(this.a);
            }
            SlidingPaneLayout.this.t.remove(this);
        }
    }

    private class c extends ViewDragHelper.Callback {
        private c() {
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public int clampViewPositionHorizontal(View view, int i, int i2) {
            int paddingLeft = SlidingPaneLayout.this.getPaddingLeft() + ((d) SlidingPaneLayout.this.g.getLayoutParams()).leftMargin;
            return Math.min(Math.max(i, paddingLeft), SlidingPaneLayout.this.j + paddingLeft);
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public int clampViewPositionVertical(View view, int i, int i2) {
            return view.getTop();
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public int getViewHorizontalDragRange(View view) {
            return SlidingPaneLayout.this.j;
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public void onEdgeDragStarted(int i, int i2) {
            SlidingPaneLayout.this.p.captureChildView(SlidingPaneLayout.this.g, i2);
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public void onViewCaptured(View view, int i) {
            SlidingPaneLayout.this.a();
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public void onViewDragStateChanged(int i) {
            SlidingPaneLayout slidingPaneLayout;
            boolean z;
            if (SlidingPaneLayout.this.p.getViewDragState() == 0) {
                if (SlidingPaneLayout.this.h == 0.0f) {
                    SlidingPaneLayout.this.d(SlidingPaneLayout.this.g);
                    SlidingPaneLayout.this.c(SlidingPaneLayout.this.g);
                    slidingPaneLayout = SlidingPaneLayout.this;
                    z = false;
                } else {
                    SlidingPaneLayout.this.b(SlidingPaneLayout.this.g);
                    slidingPaneLayout = SlidingPaneLayout.this;
                    z = true;
                }
                slidingPaneLayout.q = z;
            }
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public void onViewPositionChanged(View view, int i, int i2, int i3, int i4) {
            SlidingPaneLayout.this.a(i);
            SlidingPaneLayout.this.invalidate();
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public void onViewReleased(View view, float f, float f2) {
            int paddingLeft = SlidingPaneLayout.this.getPaddingLeft() + ((d) view.getLayoutParams()).leftMargin;
            if (f > 0.0f || (f == 0.0f && SlidingPaneLayout.this.h > 0.5f)) {
                paddingLeft += SlidingPaneLayout.this.j;
            }
            SlidingPaneLayout.this.p.settleCapturedViewAt(paddingLeft, view.getTop());
            SlidingPaneLayout.this.invalidate();
        }

        @Override // android.support.v4.widget.ViewDragHelper.Callback
        public boolean tryCaptureView(View view, int i) {
            if (SlidingPaneLayout.this.k) {
                return false;
            }
            return ((d) view.getLayoutParams()).b;
        }
    }

    public static class d extends ViewGroup.MarginLayoutParams {
        private static final int[] e = {R.attr.layout_weight};
        public float a;
        boolean b;
        boolean c;
        Paint d;

        public d() {
            super(-1, -1);
            this.a = 0.0f;
        }

        public d(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.a = 0.0f;
            TypedArray typedArrayObtainStyledAttributes = context.obtainStyledAttributes(attributeSet, e);
            this.a = typedArrayObtainStyledAttributes.getFloat(0, 0.0f);
            typedArrayObtainStyledAttributes.recycle();
        }

        public d(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.a = 0.0f;
        }

        public d(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
            this.a = 0.0f;
        }
    }

    public interface e {
        void a(View view);

        void a(View view, float f);

        void b(View view);
    }

    interface f {
        void a(SlidingPaneLayout slidingPaneLayout, View view);
    }

    static class g implements f {
        g() {
        }

        @Override // chat.ola.vn.view.SlidingPaneLayout.f
        public void a(SlidingPaneLayout slidingPaneLayout, View view) {
            ViewCompat.postInvalidateOnAnimation(slidingPaneLayout, view.getLeft(), view.getTop(), view.getRight(), view.getBottom());
        }
    }

    static class h extends g {
        private Method a;
        private Field b;

        h() {
            try {
                this.a = View.class.getDeclaredMethod("getDisplayList", (Class[]) null);
            } catch (NoSuchMethodException e) {
                Log.e("SlidingPaneLayout", "Couldn't fetch getDisplayList method; dimming won't work right.", e);
            }
            try {
                this.b = View.class.getDeclaredField("mRecreateDisplayList");
                this.b.setAccessible(true);
            } catch (NoSuchFieldException e2) {
                Log.e("SlidingPaneLayout", "Couldn't fetch mRecreateDisplayList field; dimming will be slow.", e2);
            }
        }

        @Override // chat.ola.vn.view.SlidingPaneLayout.g, chat.ola.vn.view.SlidingPaneLayout.f
        public void a(SlidingPaneLayout slidingPaneLayout, View view) {
            if (this.a == null || this.b == null) {
                view.invalidate();
                return;
            }
            try {
                this.b.setBoolean(view, true);
                this.a.invoke(view, (Object[]) null);
            } catch (Exception e) {
                Log.e("SlidingPaneLayout", "Error refreshing display list state", e);
            }
            super.a(slidingPaneLayout, view);
        }
    }

    static class i extends g {
        i() {
        }

        @Override // chat.ola.vn.view.SlidingPaneLayout.g, chat.ola.vn.view.SlidingPaneLayout.f
        public void a(SlidingPaneLayout slidingPaneLayout, View view) {
            ViewCompat.setLayerPaint(view, ((d) view.getLayoutParams()).d);
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    static {
        int i2 = Build.VERSION.SDK_INT;
        a = i2 >= 17 ? new i() : i2 >= 16 ? new h() : new g();
    }

    public SlidingPaneLayout(Context context) {
        this(context, null);
    }

    public SlidingPaneLayout(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public SlidingPaneLayout(Context context, AttributeSet attributeSet, int i2) {
        super(context, attributeSet, i2);
        this.b = -858993460;
        this.r = true;
        this.s = new Rect();
        this.t = new ArrayList<>();
        float f2 = context.getResources().getDisplayMetrics().density;
        this.e = (int) ((32.0f * f2) + 0.5f);
        ViewConfiguration.get(context);
        setWillNotDraw(false);
        ViewCompat.setAccessibilityDelegate(this, new a());
        ViewCompat.setImportantForAccessibility(this, 1);
        this.p = ViewDragHelper.create(this, 0.5f, new c());
        this.p.setEdgeTrackingEnabled(1);
        this.p.setMinVelocity(f2 * 400.0f);
    }

    private void a(float f2) {
        d dVar = (d) this.g.getLayoutParams();
        boolean z = dVar.c && dVar.leftMargin <= 0;
        int childCount = getChildCount();
        for (int i2 = 0; i2 < childCount; i2++) {
            View childAt = getChildAt(i2);
            if (childAt != this.g) {
                int i3 = (int) ((1.0f - this.i) * this.l);
                this.i = f2;
                childAt.offsetLeftAndRight(i3 - ((int) ((1.0f - f2) * this.l)));
                if (z) {
                    a(childAt, 1.0f - this.i, this.c);
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(int i2) {
        if (this.g == null) {
            this.h = 0.0f;
            return;
        }
        d dVar = (d) this.g.getLayoutParams();
        this.h = (i2 - (getPaddingLeft() + dVar.leftMargin)) / this.j;
        if (this.l != 0) {
            a(this.h);
        }
        if (dVar.c) {
            a(this.g, this.h, this.b);
        }
        a(this.g);
    }

    private void a(View view, float f2, int i2) {
        d dVar = (d) view.getLayoutParams();
        if (f2 <= 0.0f || i2 == 0) {
            if (ViewCompat.getLayerType(view) != 0) {
                if (dVar.d != null) {
                    dVar.d.setColorFilter(null);
                }
                b bVar = new b(view);
                this.t.add(bVar);
                ViewCompat.postOnAnimation(this, bVar);
                return;
            }
            return;
        }
        int i3 = (((int) ((((-16777216) & i2) >>> 24) * f2)) << 24) | (i2 & ViewCompat.MEASURED_SIZE_MASK);
        if (dVar.d == null) {
            dVar.d = new Paint();
        }
        dVar.d.setColorFilter(new PorterDuffColorFilter(i3, PorterDuff.Mode.SRC_OVER));
        if (ViewCompat.getLayerType(view) != 2) {
            ViewCompat.setLayerType(view, 2, dVar.d);
        }
        g(view);
    }

    private boolean a(View view, int i2) {
        if (!this.r && !a(0.0f, i2)) {
            return false;
        }
        this.q = false;
        return true;
    }

    private boolean b(View view, int i2) {
        if (!this.r && !a(1.0f, i2)) {
            return false;
        }
        this.q = true;
        return true;
    }

    private static boolean f(View view) {
        Drawable background;
        if (ViewCompat.isOpaque(view)) {
            return true;
        }
        return Build.VERSION.SDK_INT < 18 && (background = view.getBackground()) != null && background.getOpacity() == -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g(View view) {
        a.a(this, view);
    }

    void a() {
        int childCount = getChildCount();
        for (int i2 = 0; i2 < childCount; i2++) {
            View childAt = getChildAt(i2);
            if (childAt.getVisibility() == 4) {
                childAt.setVisibility(0);
            }
        }
    }

    void a(View view) {
        if (this.o != null) {
            this.o.a(view, this.h);
        }
    }

    boolean a(float f2, int i2) {
        if (!this.f) {
            return false;
        }
        if (!this.p.smoothSlideViewTo(this.g, (int) (getPaddingLeft() + ((d) this.g.getLayoutParams()).leftMargin + (f2 * this.j)), this.g.getTop())) {
            return false;
        }
        a();
        ViewCompat.postInvalidateOnAnimation(this);
        return true;
    }

    void b(View view) {
        if (this.o != null) {
            this.o.a(view);
        }
        sendAccessibilityEvent(32);
    }

    public boolean b() {
        return b(this.g, 0);
    }

    void c(View view) {
        if (this.o != null) {
            this.o.b(view);
        }
        sendAccessibilityEvent(32);
    }

    public boolean c() {
        return a(this.g, 0);
    }

    @Override // android.view.ViewGroup
    protected boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return (layoutParams instanceof d) && super.checkLayoutParams(layoutParams);
    }

    @Override // android.view.View
    public void computeScroll() {
        if (this.p.continueSettling(true)) {
            if (this.f) {
                ViewCompat.postInvalidateOnAnimation(this);
            } else {
                this.p.abort();
            }
        }
    }

    void d(View view) {
        int left;
        int right;
        int top;
        int bottom;
        View view2 = view;
        int paddingLeft = getPaddingLeft();
        int width = getWidth() - getPaddingRight();
        int paddingTop = getPaddingTop();
        int height = getHeight() - getPaddingBottom();
        if (view2 == null || !f(view)) {
            left = 0;
            right = 0;
            top = 0;
            bottom = 0;
        } else {
            left = view.getLeft();
            right = view.getRight();
            top = view.getTop();
            bottom = view.getBottom();
        }
        int childCount = getChildCount();
        int i2 = 0;
        while (i2 < childCount) {
            View childAt = getChildAt(i2);
            if (childAt == view2) {
                return;
            }
            childAt.setVisibility((Math.max(paddingLeft, childAt.getLeft()) < left || Math.max(paddingTop, childAt.getTop()) < top || Math.min(width, childAt.getRight()) > right || Math.min(height, childAt.getBottom()) > bottom) ? 0 : 4);
            i2++;
            view2 = view;
        }
    }

    public boolean d() {
        return !this.f || this.h == 1.0f;
    }

    @Override // android.view.View
    public void draw(Canvas canvas) {
        super.draw(canvas);
        View childAt = getChildCount() > 1 ? getChildAt(1) : null;
        if (childAt == null || this.d == null) {
            return;
        }
        int intrinsicWidth = this.d.getIntrinsicWidth();
        int left = childAt.getLeft();
        this.d.setBounds(left - intrinsicWidth, childAt.getTop(), left, childAt.getBottom());
        this.d.draw(canvas);
    }

    @Override // android.view.ViewGroup
    protected boolean drawChild(Canvas canvas, View view, long j) {
        boolean zDrawChild;
        d dVar = (d) view.getLayoutParams();
        int iSave = canvas.save(2);
        if (this.f && !dVar.b && this.g != null) {
            canvas.getClipBounds(this.s);
            this.s.right = Math.min(this.s.right, this.g.getLeft());
            canvas.clipRect(this.s);
        }
        if (Build.VERSION.SDK_INT < 11) {
            if (dVar.c && this.h > 0.0f) {
                if (!view.isDrawingCacheEnabled()) {
                    view.setDrawingCacheEnabled(true);
                }
                Bitmap drawingCache = view.getDrawingCache();
                if (drawingCache != null) {
                    canvas.drawBitmap(drawingCache, view.getLeft(), view.getTop(), dVar.d);
                    zDrawChild = false;
                } else {
                    Log.e("SlidingPaneLayout", "drawChild: child view " + view + " returned null drawing cache");
                }
            } else if (view.isDrawingCacheEnabled()) {
                view.setDrawingCacheEnabled(false);
            }
            zDrawChild = super.drawChild(canvas, view, j);
        } else {
            zDrawChild = super.drawChild(canvas, view, j);
        }
        canvas.restoreToCount(iSave);
        return zDrawChild;
    }

    public boolean e() {
        return this.f;
    }

    boolean e(View view) {
        if (view == null) {
            return false;
        }
        return this.f && ((d) view.getLayoutParams()).c && this.h > 0.0f;
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateDefaultLayoutParams() {
        return new d();
    }

    @Override // android.view.ViewGroup
    public ViewGroup.LayoutParams generateLayoutParams(AttributeSet attributeSet) {
        return new d(getContext(), attributeSet);
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof ViewGroup.MarginLayoutParams ? new d((ViewGroup.MarginLayoutParams) layoutParams) : new d(layoutParams);
    }

    public int getCoveredFadeColor() {
        return this.c;
    }

    public int getParallaxDistance() {
        return this.l;
    }

    public int getSliderFadeColor() {
        return this.b;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        this.r = true;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        this.r = true;
        int size = this.t.size();
        for (int i2 = 0; i2 < size; i2++) {
            this.t.get(i2).run();
        }
        this.t.clear();
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        boolean z;
        View childAt;
        int actionMasked = MotionEventCompat.getActionMasked(motionEvent);
        if (!this.f && actionMasked == 0 && getChildCount() > 1 && (childAt = getChildAt(1)) != null) {
            this.q = !this.p.isViewUnder(childAt, (int) motionEvent.getX(), (int) motionEvent.getY());
        }
        if (!this.f || (this.k && actionMasked != 0)) {
            this.p.cancel();
            return super.onInterceptTouchEvent(motionEvent);
        }
        if (actionMasked == 3 || actionMasked == 1) {
            this.p.cancel();
            return false;
        }
        if (actionMasked == 0) {
            this.k = false;
            float x = motionEvent.getX();
            float y = motionEvent.getY();
            this.m = x;
            this.n = y;
            if (this.p.isViewUnder(this.g, (int) x, (int) y) && e(this.g)) {
                z = true;
            }
            return this.p.shouldInterceptTouchEvent(motionEvent) || z;
        }
        if (actionMasked == 2) {
            float x2 = motionEvent.getX();
            float y2 = motionEvent.getY();
            float fAbs = Math.abs(x2 - this.m);
            float fAbs2 = Math.abs(y2 - this.n);
            if (fAbs > this.p.getTouchSlop() && fAbs2 > fAbs) {
                this.p.cancel();
                this.k = true;
                return false;
            }
        }
        z = false;
        if (this.p.shouldInterceptTouchEvent(motionEvent)) {
            return true;
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i2, int i3, int i4, int i5) {
        int i6;
        int i7 = i4 - i2;
        int paddingLeft = getPaddingLeft();
        int paddingRight = getPaddingRight();
        int paddingTop = getPaddingTop();
        int childCount = getChildCount();
        if (this.r) {
            this.h = (this.f && this.q) ? 1.0f : 0.0f;
        }
        int width = paddingLeft;
        int i8 = width;
        for (int i9 = 0; i9 < childCount; i9++) {
            View childAt = getChildAt(i9);
            if (childAt.getVisibility() != 8) {
                d dVar = (d) childAt.getLayoutParams();
                int measuredWidth = childAt.getMeasuredWidth();
                if (dVar.b) {
                    int i10 = i7 - paddingRight;
                    int iMin = (Math.min(width, i10 - this.e) - i8) - (dVar.leftMargin + dVar.rightMargin);
                    this.j = iMin;
                    dVar.c = ((dVar.leftMargin + i8) + iMin) + (measuredWidth / 2) > i10;
                    int i11 = (int) (iMin * this.h);
                    i8 += dVar.leftMargin + i11;
                    this.h = i11 / this.j;
                } else if (!this.f || this.l == 0) {
                    i8 = width;
                } else {
                    i6 = (int) ((1.0f - this.h) * this.l);
                    i8 = width;
                    int i12 = i8 - i6;
                    childAt.layout(i12, paddingTop, measuredWidth + i12, childAt.getMeasuredHeight() + paddingTop);
                    width += childAt.getWidth();
                }
                i6 = 0;
                int i122 = i8 - i6;
                childAt.layout(i122, paddingTop, measuredWidth + i122, childAt.getMeasuredHeight() + paddingTop);
                width += childAt.getWidth();
            }
        }
        if (this.r) {
            if (this.f) {
                if (this.l != 0) {
                    a(this.h);
                }
                if (((d) this.g.getLayoutParams()).c) {
                    a(this.g, this.h, this.b);
                }
            } else {
                for (int i13 = 0; i13 < childCount; i13++) {
                    a(getChildAt(i13), 0.0f, this.b);
                }
            }
            d(this.g);
        }
        this.r = false;
    }

    /* JADX WARN: Removed duplicated region for block: B:123:0x01e6  */
    /* JADX WARN: Removed duplicated region for block: B:126:0x01fc  */
    /* JADX WARN: Removed duplicated region for block: B:39:0x00b4 A[PHI: r13
      0x00b4: PHI (r13v2 float) = (r13v1 float), (r13v3 float) binds: [B:35:0x00a9, B:37:0x00b0] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:61:0x0110  */
    /* JADX WARN: Removed duplicated region for block: B:62:0x0112  */
    /* JADX WARN: Removed duplicated region for block: B:65:0x011a  */
    /* JADX WARN: Removed duplicated region for block: B:75:0x013c  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void onMeasure(int r21, int r22) {
        /*
            Method dump skipped, instruction units count: 571
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.SlidingPaneLayout.onMeasure(int, int):void");
    }

    @Override // android.view.View
    protected void onRestoreInstanceState(Parcelable parcelable) {
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.getSuperState());
        if (savedState.a) {
            b();
        } else {
            c();
        }
        this.q = savedState.a;
    }

    @Override // android.view.View
    protected Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        savedState.a = e() ? d() : this.q;
        return savedState;
    }

    @Override // android.view.View
    protected void onSizeChanged(int i2, int i3, int i4, int i5) {
        super.onSizeChanged(i2, i3, i4, i5);
        if (i2 != i4) {
            this.r = true;
        }
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (!this.f) {
            return super.onTouchEvent(motionEvent);
        }
        this.p.processTouchEvent(motionEvent);
        switch (motionEvent.getAction() & 255) {
            case 0:
                float x = motionEvent.getX();
                float y = motionEvent.getY();
                this.m = x;
                this.n = y;
                return true;
            case 1:
                if (e(this.g)) {
                    float x2 = motionEvent.getX();
                    float y2 = motionEvent.getY();
                    float f2 = x2 - this.m;
                    float f3 = y2 - this.n;
                    int touchSlop = this.p.getTouchSlop();
                    if ((f2 * f2) + (f3 * f3) < touchSlop * touchSlop && this.p.isViewUnder(this.g, (int) x2, (int) y2)) {
                        a(this.g, 0);
                        return true;
                    }
                }
                return true;
            default:
                return true;
        }
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestChildFocus(View view, View view2) {
        super.requestChildFocus(view, view2);
        if (isInTouchMode() || this.f) {
            return;
        }
        this.q = view == this.g;
    }

    public void setCoveredFadeColor(int i2) {
        this.c = i2;
    }

    public void setPanelSlideListener(e eVar) {
        this.o = eVar;
    }

    public void setParallaxDistance(int i2) {
        this.l = i2;
        requestLayout();
    }

    public void setShadowDrawable(Drawable drawable) {
        this.d = drawable;
    }

    public void setShadowResource(int i2) {
        setShadowDrawable(getResources().getDrawable(i2));
    }

    public void setSliderFadeColor(int i2) {
        this.b = i2;
    }
}
