package it.sephiroth.android.library.widget;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.support.v4.util.SparseArrayCompat;
import android.util.AttributeSet;
import android.view.FocusFinder;
import android.view.KeyEvent;
import android.view.SoundEffectConstants;
import android.view.View;
import android.view.ViewDebug;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.ArrayAdapter;
import android.widget.Checkable;
import android.widget.ListAdapter;
import android.widget.RemoteViews;
import chat.ola.vn.R;
import chat.ola.vn.i;
import com.google.android.gms.common.util.CrashUtils;
import it.sephiroth.android.library.widget.AbsHListView;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
@RemoteViews.RemoteView
public class HListView extends AbsHListView {
    private ArrayList<b> aA;
    private boolean aB;
    private boolean aC;
    private boolean aD;
    private boolean aE;
    private boolean aF;
    private boolean aG;
    private final Rect aH;
    private Paint aI;
    private final a aJ;
    private c aK;
    Drawable au;
    int av;
    int aw;
    Drawable ax;
    Drawable ay;
    private ArrayList<b> az;

    private static class a {
        private int a;
        private int b;

        private a() {
        }

        public int a() {
            return this.a;
        }

        void a(int i, int i2) {
            this.a = i;
            this.b = i2;
        }

        public int b() {
            return this.b;
        }
    }

    public static class b {
        public View a;
        public Object b;
        public boolean c;
    }

    private class c implements Runnable {
        private int b;
        private int c;

        private c() {
        }

        public c a(int i, int i2) {
            this.b = i;
            this.c = i2;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            HListView.this.e(this.b, this.c);
        }
    }

    public HListView(Context context) {
        this(context, null);
    }

    public HListView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, R.attr.hlv_listViewStyle);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public HListView(Context context, AttributeSet attributeSet, int i) {
        Drawable drawable;
        Drawable drawable2;
        Drawable drawable3;
        boolean z;
        super(context, attributeSet, i);
        this.az = new ArrayList<>();
        this.aA = new ArrayList<>();
        boolean z2 = true;
        this.aF = true;
        int dimensionPixelSize = 0;
        this.aG = false;
        this.aH = new Rect();
        CharSequence[] textArray = null;
        this.aJ = new a();
        TypedArray typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, i.b.HListView, i, 0);
        int integer = -1;
        if (typedArrayObtainStyledAttributes != null) {
            textArray = typedArrayObtainStyledAttributes.getTextArray(0);
            drawable = typedArrayObtainStyledAttributes.getDrawable(1);
            drawable2 = typedArrayObtainStyledAttributes.getDrawable(7);
            drawable3 = typedArrayObtainStyledAttributes.getDrawable(6);
            dimensionPixelSize = typedArrayObtainStyledAttributes.getDimensionPixelSize(2, 0);
            boolean z3 = typedArrayObtainStyledAttributes.getBoolean(4, true);
            boolean z4 = typedArrayObtainStyledAttributes.getBoolean(3, true);
            integer = typedArrayObtainStyledAttributes.getInteger(5, -1);
            typedArrayObtainStyledAttributes.recycle();
            z = z4;
            z2 = z3;
        } else {
            drawable = null;
            drawable2 = null;
            drawable3 = null;
            z = true;
        }
        if (textArray != null) {
            setAdapter((ListAdapter) new ArrayAdapter(context, android.R.layout.simple_list_item_1, textArray));
        }
        if (drawable != null) {
            setDivider(drawable);
        }
        if (drawable2 != null) {
            setOverscrollHeader(drawable2);
        }
        if (drawable3 != null) {
            setOverscrollFooter(drawable3);
        }
        if (dimensionPixelSize != 0) {
            setDividerWidth(dimensionPixelSize);
        }
        this.aD = z2;
        this.aE = z;
        this.aw = integer;
    }

    private boolean A() {
        int childCount = getChildCount();
        return (this.V + childCount) - 1 < this.ao - 1 || getChildAt(childCount + (-1)).getRight() < (getScrollX() + getWidth()) - this.u.right;
    }

    private int a(int i, View view, int i2) {
        int i3;
        view.getDrawingRect(this.aH);
        offsetDescendantRectToMyCoords(view, this.aH);
        if (i == 33) {
            if (this.aH.left < this.u.left) {
                i3 = this.u.left - this.aH.left;
                if (i2 <= 0) {
                    return i3;
                }
                return i3 + getArrowScrollPreviewLength();
            }
            return 0;
        }
        int width = getWidth() - this.u.right;
        if (this.aH.bottom > width) {
            i3 = this.aH.right - width;
            if (i2 >= this.ao - 1) {
                return i3;
            }
            return i3 + getArrowScrollPreviewLength();
        }
        return 0;
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x0050  */
    /* JADX WARN: Removed duplicated region for block: B:13:0x0058  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private android.view.View a(int r9, int r10, int r11) {
        /*
            r8 = this;
            int r0 = r8.getHorizontalFadingEdgeLength()
            int r7 = r8.am
            int r10 = r8.c(r10, r0, r7)
            int r11 = r8.b(r11, r0, r7)
            android.graphics.Rect r0 = r8.u
            int r5 = r0.top
            r4 = 1
            r6 = 1
            r1 = r8
            r2 = r7
            r3 = r9
            android.view.View r9 = r1.a(r2, r3, r4, r5, r6)
            int r0 = r9.getRight()
            if (r0 <= r11) goto L34
            int r0 = r9.getLeft()
            int r0 = r0 - r10
            int r10 = r9.getRight()
            int r10 = r10 - r11
            int r10 = java.lang.Math.min(r0, r10)
            int r10 = -r10
        L30:
            r9.offsetLeftAndRight(r10)
            goto L49
        L34:
            int r0 = r9.getLeft()
            if (r0 >= r10) goto L49
            int r0 = r9.getLeft()
            int r10 = r10 - r0
            int r0 = r9.getRight()
            int r11 = r11 - r0
            int r10 = java.lang.Math.min(r10, r11)
            goto L30
        L49:
            r8.a(r9, r7)
            boolean r10 = r8.K
            if (r10 != 0) goto L58
            int r10 = r8.getChildCount()
            r8.l(r10)
            return r9
        L58:
            int r10 = r8.getChildCount()
            r8.m(r10)
            return r9
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.HListView.a(int, int, int):android.view.View");
    }

    private View a(int i, int i2, boolean z, int i3, boolean z2) {
        View viewA;
        boolean z3;
        if (this.aj || (viewA = this.p.c(i)) == null) {
            viewA = a(i, this.P);
            z3 = this.P[0];
        } else {
            z3 = true;
        }
        a(viewA, i, i2, z, i3, z2, z3);
        return viewA;
    }

    private View a(View view, View view2, int i, int i2, int i3) {
        View viewA;
        int left;
        boolean z;
        int horizontalFadingEdgeLength = getHorizontalFadingEdgeLength();
        int i4 = this.am;
        int iC = c(i2, horizontalFadingEdgeLength, i4);
        int iB = b(i2, horizontalFadingEdgeLength, i4);
        if (i > 0) {
            View viewA2 = a(i4 - 1, view.getLeft(), true, this.u.top, false);
            int i5 = this.av;
            View viewA3 = a(i4, viewA2.getRight() + i5, true, this.u.top, true);
            if (viewA3.getRight() > iB) {
                int i6 = -Math.min(Math.min(viewA3.getLeft() - iC, viewA3.getRight() - iB), (i3 - i2) / 2);
                viewA2.offsetLeftAndRight(i6);
                viewA3.offsetLeftAndRight(i6);
            }
            if (this.K) {
                f(this.am + 1, viewA3.getRight() + i5);
                y();
                g(this.am - 2, viewA3.getLeft() - i5);
                return viewA3;
            }
            g(this.am - 2, viewA3.getLeft() - i5);
            y();
            f(this.am + 1, viewA3.getRight() + i5);
            return viewA3;
        }
        if (i < 0) {
            if (view2 != null) {
                left = view2.getLeft();
                z = true;
            } else {
                left = view.getLeft();
                z = false;
            }
            viewA = a(i4, left, z, this.u.top, true);
            if (viewA.getLeft() < iC) {
                viewA.offsetLeftAndRight(Math.min(Math.min(iC - viewA.getLeft(), iB - viewA.getRight()), (i3 - i2) / 2));
            }
        } else {
            int left2 = view.getLeft();
            viewA = a(i4, left2, true, this.u.top, true);
            if (left2 < i2 && viewA.getRight() < i2 + 20) {
                viewA.offsetLeftAndRight(i2 - viewA.getLeft());
            }
        }
        a(viewA, i4);
        return viewA;
    }

    private void a(View view, int i) {
        int i2 = this.av;
        if (this.K) {
            f(i + 1, view.getRight() + i2);
            y();
            g(i - 1, view.getLeft() - i2);
        } else {
            g(i - 1, view.getLeft() - i2);
            y();
            f(i + 1, view.getRight() + i2);
        }
    }

    private void a(View view, int i, int i2) {
        AbsHListView.f fVar = (AbsHListView.f) view.getLayoutParams();
        if (fVar == null) {
            fVar = (AbsHListView.f) generateDefaultLayoutParams();
            view.setLayoutParams(fVar);
        }
        fVar.a = this.j.getItemViewType(i);
        fVar.c = true;
        int childMeasureSpec = ViewGroup.getChildMeasureSpec(i2, this.u.top + this.u.bottom, fVar.height);
        int i3 = fVar.width;
        view.measure(i3 > 0 ? View.MeasureSpec.makeMeasureSpec(i3, CrashUtils.ErrorDialogData.SUPPRESSED) : View.MeasureSpec.makeMeasureSpec(0, 0), childMeasureSpec);
    }

    private void a(View view, int i, int i2, boolean z) {
        int i3;
        View view2;
        boolean z2;
        if (i2 == -1) {
            throw new IllegalArgumentException("newSelectedPosition needs to be valid");
        }
        int i4 = this.am - this.V;
        int i5 = i2 - this.V;
        if (i == 33) {
            i3 = i4;
            view2 = view;
            view = getChildAt(i5);
            z2 = true;
        } else {
            View childAt = getChildAt(i5);
            i3 = i5;
            i5 = i4;
            view2 = childAt;
            z2 = false;
        }
        int childCount = getChildCount();
        if (view != null) {
            view.setSelected(!z && z2);
            b(view, i5, childCount);
        }
        if (view2 != null) {
            view2.setSelected((z || z2) ? false : true);
            b(view2, i3, childCount);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    @TargetApi(11)
    private void a(View view, int i, int i2, boolean z, int i3, boolean z2, boolean z3) {
        boolean z4 = z2 && h();
        boolean z5 = z4 != view.isSelected();
        int i4 = this.F;
        boolean z6 = i4 > 0 && i4 < 3 && this.A == i;
        boolean z7 = z6 != view.isPressed();
        boolean z8 = !z3 || z5 || view.isLayoutRequested();
        AbsHListView.f fVar = (AbsHListView.f) view.getLayoutParams();
        if (fVar == null) {
            fVar = (AbsHListView.f) generateDefaultLayoutParams();
        }
        fVar.a = this.j.getItemViewType(i);
        if ((!z3 || fVar.c) && !(fVar.b && fVar.a == -2)) {
            fVar.c = false;
            if (fVar.a == -2) {
                fVar.b = true;
            }
            addViewInLayout(view, z ? -1 : 0, fVar, true);
        } else {
            attachViewToParent(view, z ? -1 : 0, fVar);
        }
        if (z5) {
            view.setSelected(z4);
        }
        if (z7) {
            view.setPressed(z6);
        }
        if (this.b != 0 && this.f != null) {
            if (view instanceof Checkable) {
                ((Checkable) view).setChecked(this.f.get(i, false).booleanValue());
            } else if (Build.VERSION.SDK_INT >= 11) {
                view.setActivated(this.f.get(i, false).booleanValue());
            }
        }
        if (z8) {
            int childMeasureSpec = ViewGroup.getChildMeasureSpec(this.v, this.u.top + this.u.bottom, fVar.height);
            int i5 = fVar.width;
            view.measure(i5 > 0 ? View.MeasureSpec.makeMeasureSpec(i5, CrashUtils.ErrorDialogData.SUPPRESSED) : View.MeasureSpec.makeMeasureSpec(0, 0), childMeasureSpec);
        } else {
            cleanupLayoutState(view);
        }
        int measuredWidth = view.getMeasuredWidth();
        int measuredHeight = view.getMeasuredHeight();
        int i6 = z ? i2 : i2 - measuredWidth;
        if (z8) {
            view.layout(i6, i3, measuredWidth + i6, measuredHeight + i3);
        } else {
            view.offsetLeftAndRight(i6 - view.getLeft());
            view.offsetTopAndBottom(i3 - view.getTop());
        }
        if (this.y && !view.isDrawingCacheEnabled()) {
            view.setDrawingCacheEnabled(true);
        }
        if (Build.VERSION.SDK_INT < 11 || !z3 || ((AbsHListView.f) view.getLayoutParams()).d == i) {
            return;
        }
        view.jumpDrawablesToCurrentState();
    }

    private void a(ArrayList<b> arrayList) {
        if (arrayList != null) {
            int size = arrayList.size();
            for (int i = 0; i < size; i++) {
                AbsHListView.f fVar = (AbsHListView.f) arrayList.get(i).a.getLayoutParams();
                if (fVar != null) {
                    fVar.b = false;
                }
            }
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Failed to find 'out' block for switch in B:21:0x002f. Please report as an issue. */
    /* JADX WARN: Removed duplicated region for block: B:106:0x0124  */
    /* JADX WARN: Removed duplicated region for block: B:126:0x0163  */
    @android.annotation.TargetApi(11)
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private boolean a(int r7, int r8, android.view.KeyEvent r9) {
        /*
            Method dump skipped, instruction units count: 420
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.HListView.a(int, int, android.view.KeyEvent):boolean");
    }

    private boolean a(View view, View view2) {
        if (view == view2) {
            return true;
        }
        Object parent = view.getParent();
        return (parent instanceof ViewGroup) && a((View) parent, view2);
    }

    private int b(int i, int i2, int i3) {
        return i3 != this.ao + (-1) ? i - i2 : i;
    }

    private View b(View view, int i) {
        int i2 = i - 1;
        View viewA = a(i2, this.P);
        a(viewA, i2, view.getLeft() - this.av, false, this.u.top, false, this.P[0]);
        return viewA;
    }

    private void b(View view, int i, int i2) {
        int width = view.getWidth();
        d(view);
        if (view.getMeasuredWidth() == width) {
            return;
        }
        e(view);
        int measuredWidth = view.getMeasuredWidth() - width;
        while (true) {
            i++;
            if (i >= i2) {
                return;
            } else {
                getChildAt(i).offsetLeftAndRight(measuredWidth);
            }
        }
    }

    private int c(int i, int i2, int i3) {
        return i3 > 0 ? i + i2 : i;
    }

    private View c(View view, int i) {
        int i2 = i + 1;
        View viewA = a(i2, this.P);
        a(viewA, i2, view.getRight() + this.av, true, this.u.top, false, this.P[0]);
        return viewA;
    }

    private boolean c(View view) {
        ArrayList<b> arrayList = this.az;
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            if (view == arrayList.get(i).a) {
                return true;
            }
        }
        ArrayList<b> arrayList2 = this.aA;
        int size2 = arrayList2.size();
        for (int i2 = 0; i2 < size2; i2++) {
            if (view == arrayList2.get(i2).a) {
                return true;
            }
        }
        return false;
    }

    private void d(View view) {
        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
        if (layoutParams == null) {
            layoutParams = new ViewGroup.LayoutParams(-2, -1);
        }
        int childMeasureSpec = ViewGroup.getChildMeasureSpec(this.v, this.u.top + this.u.bottom, layoutParams.height);
        int i = layoutParams.width;
        view.measure(i > 0 ? View.MeasureSpec.makeMeasureSpec(i, CrashUtils.ErrorDialogData.SUPPRESSED) : View.MeasureSpec.makeMeasureSpec(0, 0), childMeasureSpec);
    }

    private void e(View view) {
        int measuredWidth = view.getMeasuredWidth();
        int measuredHeight = view.getMeasuredHeight();
        int i = this.u.top;
        int left = view.getLeft();
        view.layout(left, i, measuredWidth + left, measuredHeight + i);
    }

    private int f(View view) {
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            if (a(view, getChildAt(i))) {
                return this.V + i;
            }
        }
        throw new IllegalArgumentException("newFocus is not a child of any of the children of the list!");
    }

    private View f(int i, int i2) {
        int right = getRight() - getLeft();
        View view = null;
        int right2 = i2;
        while (true) {
            if (right2 >= right || i >= this.ao) {
                break;
            }
            boolean z = i == this.am;
            View viewA = a(i, right2, true, this.u.top, z);
            right2 = this.av + viewA.getRight();
            if (z) {
                view = viewA;
            }
            i++;
        }
        d(this.V, (this.V + getChildCount()) - 1);
        return view;
    }

    private int g(View view) {
        view.getDrawingRect(this.aH);
        offsetDescendantRectToMyCoords(view, this.aH);
        int right = (getRight() - getLeft()) - this.u.right;
        if (this.aH.right < this.u.left) {
            return this.u.left - this.aH.right;
        }
        if (this.aH.left > right) {
            return this.aH.left - right;
        }
        return 0;
    }

    private View g(int i, int i2) {
        View view = null;
        int left = i2;
        while (true) {
            if (left <= 0 || i < 0) {
                break;
            }
            boolean z = i == this.am;
            View viewA = a(i, left, false, this.u.top, z);
            left = viewA.getLeft() - this.av;
            if (z) {
                view = viewA;
            }
            i--;
        }
        this.V = i + 1;
        d(this.V, (this.V + getChildCount()) - 1);
        return view;
    }

    private int getArrowScrollPreviewLength() {
        return Math.max(2, getHorizontalFadingEdgeLength());
    }

    private View h(int i, int i2) {
        int i3 = i2 - i;
        int iM = m();
        View viewA = a(iM, i, true, this.u.top, true);
        this.V = iM;
        int measuredWidth = viewA.getMeasuredWidth();
        if (measuredWidth <= i3) {
            viewA.offsetLeftAndRight((i3 - measuredWidth) / 2);
        }
        a(viewA, iM);
        if (this.K) {
            m(getChildCount());
            return viewA;
        }
        l(getChildCount());
        return viewA;
    }

    private View i(int i, int i2) {
        View viewF;
        View viewG;
        boolean z = i == this.am;
        View viewA = a(i, i2, true, this.u.top, z);
        this.V = i;
        int i3 = this.av;
        if (this.K) {
            viewF = f(i + 1, viewA.getRight() + i3);
            y();
            viewG = g(i - 1, viewA.getLeft() - i3);
            int childCount = getChildCount();
            if (childCount > 0) {
                m(childCount);
            }
        } else {
            View viewG2 = g(i - 1, viewA.getLeft() - i3);
            y();
            View viewF2 = f(i + 1, viewA.getRight() + i3);
            int childCount2 = getChildCount();
            if (childCount2 > 0) {
                l(childCount2);
            }
            viewF = viewF2;
            viewG = viewG2;
        }
        return z ? viewA : viewG != null ? viewG : viewF;
    }

    private int j(int i, int i2) {
        int width = getWidth() - this.u.right;
        int i3 = this.u.left;
        int childCount = getChildCount();
        if (i != 130) {
            int i4 = i2 != -1 ? i2 - this.V : 0;
            int i5 = this.V + i4;
            View childAt = getChildAt(i4);
            int arrowScrollPreviewLength = i5 > 0 ? getArrowScrollPreviewLength() + i3 : i3;
            if (childAt.getLeft() >= arrowScrollPreviewLength) {
                return 0;
            }
            if (i2 != -1 && childAt.getRight() - arrowScrollPreviewLength >= getMaxScrollAmount()) {
                return 0;
            }
            int left = arrowScrollPreviewLength - childAt.getLeft();
            if (this.V == 0) {
                left = Math.min(left, i3 - getChildAt(0).getLeft());
            }
            return Math.min(left, getMaxScrollAmount());
        }
        int i6 = childCount - 1;
        int i7 = i2 != -1 ? i2 - this.V : i6;
        int i8 = this.V + i7;
        View childAt2 = getChildAt(i7);
        int arrowScrollPreviewLength2 = i8 < this.ao + (-1) ? width - getArrowScrollPreviewLength() : width;
        if (childAt2.getRight() <= arrowScrollPreviewLength2) {
            return 0;
        }
        if (i2 != -1 && arrowScrollPreviewLength2 - childAt2.getLeft() >= getMaxScrollAmount()) {
            return 0;
        }
        int right = childAt2.getRight() - arrowScrollPreviewLength2;
        if (this.V + childCount == this.ao) {
            right = Math.min(right, getChildAt(i6).getRight() - width);
        }
        return Math.min(right, getMaxScrollAmount());
    }

    private View k(int i) {
        this.V = Math.min(this.V, this.am);
        this.V = Math.min(this.V, this.ao - 1);
        if (this.V < 0) {
            this.V = 0;
        }
        return f(this.V, i);
    }

    private void l(int i) {
        if ((this.V + i) - 1 != this.ao - 1 || i <= 0) {
            return;
        }
        int right = ((getRight() - getLeft()) - this.u.right) - getChildAt(i - 1).getRight();
        View childAt = getChildAt(0);
        int left = childAt.getLeft();
        if (right > 0) {
            if (this.V > 0 || left < this.u.top) {
                if (this.V == 0) {
                    right = Math.min(right, this.u.top - left);
                }
                d(right);
                if (this.V > 0) {
                    g(this.V - 1, childAt.getLeft() - this.av);
                    y();
                }
            }
        }
    }

    private void m(int i) {
        if (this.V != 0 || i <= 0) {
            return;
        }
        int left = getChildAt(0).getLeft();
        int i2 = this.u.left;
        int right = (getRight() - getLeft()) - this.u.right;
        int iMin = left - i2;
        View childAt = getChildAt(i - 1);
        int right2 = childAt.getRight();
        int i3 = (this.V + i) - 1;
        if (iMin > 0) {
            if (i3 < this.ao - 1 || right2 > right) {
                if (i3 == this.ao - 1) {
                    iMin = Math.min(iMin, right2 - right);
                }
                d(-iMin);
                if (i3 >= this.ao - 1) {
                    return;
                } else {
                    f(i3 + 1, childAt.getRight() + this.av);
                }
            } else if (i3 != this.ao - 1) {
                return;
            }
            y();
        }
    }

    private boolean n(int i) {
        View selectedView;
        if (i != 33 && i != 130) {
            throw new IllegalArgumentException("direction must be one of {View.FOCUS_UP, View.FOCUS_DOWN}");
        }
        int childCount = getChildCount();
        if (!this.aG || childCount <= 0 || this.am == -1 || (selectedView = getSelectedView()) == null || !selectedView.hasFocus() || !(selectedView instanceof ViewGroup)) {
            return false;
        }
        View viewFindFocus = selectedView.findFocus();
        View viewFindNextFocus = FocusFinder.getInstance().findNextFocus((ViewGroup) selectedView, viewFindFocus, i);
        if (viewFindNextFocus != null) {
            viewFindFocus.getFocusedRect(this.aH);
            offsetDescendantRectToMyCoords(viewFindFocus, this.aH);
            offsetRectIntoDescendantCoords(viewFindNextFocus, this.aH);
            if (viewFindNextFocus.requestFocus(i, this.aH)) {
                return true;
            }
        }
        View viewFindNextFocus2 = FocusFinder.getInstance().findNextFocus((ViewGroup) getRootView(), viewFindFocus, i);
        if (viewFindNextFocus2 != null) {
            return a(viewFindNextFocus2, this);
        }
        return false;
    }

    private boolean o(int i) {
        View focusedChild;
        if (getChildCount() <= 0) {
            return false;
        }
        View selectedView = getSelectedView();
        int i2 = this.am;
        int iP = p(i);
        int iJ = j(i, iP);
        a aVarQ = this.aG ? q(i) : null;
        if (aVarQ != null) {
            iP = aVarQ.a();
            iJ = aVarQ.b();
        }
        boolean z = aVarQ != null;
        if (iP != -1) {
            a(selectedView, i, iP, aVarQ != null);
            setSelectedPositionInt(iP);
            setNextSelectedPositionInt(iP);
            selectedView = getSelectedView();
            if (this.aG && aVarQ == null && (focusedChild = getFocusedChild()) != null) {
                focusedChild.clearFocus();
            }
            u();
            i2 = iP;
            z = true;
        }
        if (iJ > 0) {
            if (i != 33) {
                iJ = -iJ;
            }
            r(iJ);
            z = true;
        }
        if (this.aG && aVarQ == null && selectedView != null && selectedView.hasFocus()) {
            View viewFindFocus = selectedView.findFocus();
            if (!a(viewFindFocus, this) || g(viewFindFocus) > 0) {
                viewFindFocus.clearFocus();
            }
        }
        if (iP == -1 && selectedView != null && !a(selectedView, this)) {
            l();
            this.M = -1;
            selectedView = null;
        }
        if (!z) {
            return false;
        }
        if (selectedView != null) {
            a(i2, selectedView);
            this.J = selectedView.getLeft();
        }
        if (!awakenScrollBars()) {
            invalidate();
        }
        b();
        return true;
    }

    private int p(int i) {
        int i2 = this.V;
        if (i == 130) {
            int i3 = this.am != -1 ? this.am + 1 : i2;
            if (i3 >= this.j.getCount()) {
                return -1;
            }
            if (i3 < i2) {
                i3 = i2;
            }
            int lastVisiblePosition = getLastVisiblePosition();
            ListAdapter adapter = getAdapter();
            while (i3 <= lastVisiblePosition) {
                if (adapter.isEnabled(i3) && getChildAt(i3 - i2).getVisibility() == 0) {
                    return i3;
                }
                i3++;
            }
        } else {
            int childCount = (getChildCount() + i2) - 1;
            int childCount2 = (this.am != -1 ? this.am : getChildCount() + i2) - 1;
            if (childCount2 < 0 || childCount2 >= this.j.getCount()) {
                return -1;
            }
            if (childCount2 <= childCount) {
                childCount = childCount2;
            }
            ListAdapter adapter2 = getAdapter();
            while (childCount >= i2) {
                if (adapter2.isEnabled(childCount) && getChildAt(childCount - i2).getVisibility() == 0) {
                    return childCount;
                }
                childCount--;
            }
        }
        return -1;
    }

    private a q(int i) {
        int width;
        View viewFindNextFocusFromRect;
        int iP;
        View selectedView = getSelectedView();
        if (selectedView == null || !selectedView.hasFocus()) {
            if (i == 130) {
                width = this.u.left + (this.V > 0 ? getArrowScrollPreviewLength() : 0);
                if (selectedView != null && selectedView.getLeft() > width) {
                    width = selectedView.getLeft();
                }
            } else {
                width = (getWidth() - this.u.right) - ((this.V + getChildCount()) - 1 < this.ao ? getArrowScrollPreviewLength() : 0);
                if (selectedView != null && selectedView.getRight() < width) {
                    width = selectedView.getRight();
                }
            }
            this.aH.set(width, 0, width, 0);
            viewFindNextFocusFromRect = FocusFinder.getInstance().findNextFocusFromRect(this, this.aH, i);
        } else {
            viewFindNextFocusFromRect = FocusFinder.getInstance().findNextFocus(this, selectedView.findFocus(), i);
        }
        if (viewFindNextFocusFromRect != null) {
            int iF = f(viewFindNextFocusFromRect);
            if (this.am != -1 && iF != this.am && (iP = p(i)) != -1 && ((i == 130 && iP < iF) || (i == 33 && iP > iF))) {
                return null;
            }
            int iA = a(i, viewFindNextFocusFromRect, iF);
            int maxScrollAmount = getMaxScrollAmount();
            if (iA < maxScrollAmount) {
                viewFindNextFocusFromRect.requestFocus(i);
                this.aJ.a(iF, iA);
            } else if (g(viewFindNextFocusFromRect) < maxScrollAmount) {
                viewFindNextFocusFromRect.requestFocus(i);
                this.aJ.a(iF, maxScrollAmount);
            }
            return this.aJ;
        }
        return null;
    }

    private void r(int i) {
        int i2;
        d(i);
        int width = getWidth() - this.u.right;
        int i3 = this.u.left;
        AbsHListView.k kVar = this.p;
        if (i < 0) {
            int childCount = getChildCount();
            View childAt = getChildAt(childCount - 1);
            while (childAt.getRight() < width && (this.V + childCount) - 1 < this.ao - 1) {
                childAt = c(childAt, i2);
                childCount++;
            }
            if (childAt.getBottom() < width) {
                d(width - childAt.getRight());
            }
            View childAt2 = getChildAt(0);
            while (childAt2.getRight() < i3) {
                if (kVar.b(((AbsHListView.f) childAt2.getLayoutParams()).a)) {
                    detachViewFromParent(childAt2);
                    kVar.a(childAt2, this.V);
                } else {
                    removeViewInLayout(childAt2);
                }
                childAt2 = getChildAt(0);
                this.V++;
            }
            return;
        }
        View childAt3 = getChildAt(0);
        while (childAt3.getLeft() > i3 && this.V > 0) {
            childAt3 = b(childAt3, this.V);
            this.V--;
        }
        if (childAt3.getLeft() > i3) {
            d(i3 - childAt3.getLeft());
        }
        int childCount2 = getChildCount();
        while (true) {
            childCount2--;
            View childAt4 = getChildAt(childCount2);
            if (childAt4.getLeft() <= width) {
                return;
            }
            if (kVar.b(((AbsHListView.f) childAt4.getLayoutParams()).a)) {
                detachViewFromParent(childAt4);
                kVar.a(childAt4, this.V + childCount2);
            } else {
                removeViewInLayout(childAt4);
            }
        }
    }

    private void y() {
        int childCount = getChildCount();
        if (childCount > 0) {
            int i = 0;
            if (this.K) {
                int right = getChildAt(childCount - 1).getRight() - (getWidth() - this.u.right);
                if (this.V + childCount < this.ao) {
                    right += this.av;
                }
                if (right <= 0) {
                    i = right;
                }
            } else {
                int left = getChildAt(0).getLeft() - this.u.left;
                if (this.V != 0) {
                    left -= this.av;
                }
                if (left >= 0) {
                    i = left;
                }
            }
            if (i != 0) {
                d(-i);
            }
        }
    }

    private boolean z() {
        return this.V > 0 || getChildAt(0).getLeft() > getScrollX() + this.u.left;
    }

    final int a(int i, int i2, int i3, int i4, int i5) {
        ListAdapter listAdapter = this.j;
        if (listAdapter == null) {
            return this.u.left + this.u.right;
        }
        int measuredWidth = this.u.left + this.u.right;
        int i6 = 0;
        int i7 = (this.av <= 0 || this.au == null) ? 0 : this.av;
        if (i3 == -1) {
            i3 = listAdapter.getCount() - 1;
        }
        AbsHListView.k kVar = this.p;
        boolean zX = x();
        boolean[] zArr = this.P;
        while (i2 <= i3) {
            View viewA = a(i2, zArr);
            a(viewA, i2, i);
            if (i2 > 0) {
                measuredWidth += i7;
            }
            if (zX && kVar.b(((AbsHListView.f) viewA.getLayoutParams()).a)) {
                kVar.a(viewA, -1);
            }
            measuredWidth += viewA.getMeasuredWidth();
            if (measuredWidth >= i4) {
                return (i5 < 0 || i2 <= i5 || i6 <= 0 || measuredWidth == i4) ? i4 : i6;
            }
            if (i5 >= 0 && i2 >= i5) {
                i6 = measuredWidth;
            }
            i2++;
        }
        return measuredWidth;
    }

    void a(Canvas canvas, Rect rect, int i) {
        Drawable drawable = this.au;
        drawable.setBounds(rect);
        drawable.draw(canvas);
    }

    void a(Canvas canvas, Drawable drawable, Rect rect) {
        int minimumWidth = drawable.getMinimumWidth();
        canvas.save();
        canvas.clipRect(rect);
        if (rect.right - rect.left < minimumWidth) {
            rect.left = rect.right - minimumWidth;
        }
        drawable.setBounds(rect);
        drawable.draw(canvas);
        canvas.restore();
    }

    public void a(View view, Object obj, boolean z) {
        if (this.j != null && !(this.j instanceof it.sephiroth.android.library.widget.b)) {
            throw new IllegalStateException("Cannot add header view to list -- setAdapter has already been called.");
        }
        b bVar = new b();
        bVar.a = view;
        bVar.b = obj;
        bVar.c = z;
        this.az.add(bVar);
        if (this.j == null || this.i == null) {
            return;
        }
        this.i.onChanged();
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    protected void a(boolean z) {
        int childCount = getChildCount();
        if (z) {
            f(this.V + childCount, childCount > 0 ? this.av + getChildAt(childCount - 1).getRight() : 0);
            l(getChildCount());
        } else {
            g(this.V - 1, childCount > 0 ? getChildAt(0).getLeft() - this.av : getWidth() - 0);
            m(getChildCount());
        }
    }

    final int[] a(int i, int i2, int i3, int i4, int i5, int i6) {
        ListAdapter listAdapter = this.j;
        if (listAdapter == null) {
            return new int[]{this.u.left + this.u.right, this.u.top + this.u.bottom};
        }
        int i7 = this.u.left + this.u.right;
        int i8 = this.u.top + this.u.bottom;
        int i9 = (this.av <= 0 || this.au == null) ? 0 : this.av;
        int count = i3;
        if (count == -1) {
            count = listAdapter.getCount() - 1;
        }
        AbsHListView.k kVar = this.p;
        boolean zX = x();
        boolean[] zArr = this.P;
        int iMax = 0;
        int iMax2 = 0;
        for (int i10 = i2; i10 <= count; i10++) {
            View viewA = a(i10, zArr);
            a(viewA, i10, i);
            if (zX && kVar.b(((AbsHListView.f) viewA.getLayoutParams()).a)) {
                kVar.a(viewA, -1);
            }
            iMax = Math.max(iMax, viewA.getMeasuredWidth() + i9);
            iMax2 = Math.max(iMax2, viewA.getMeasuredHeight());
        }
        return new int[]{Math.min(i7 + iMax, i4), Math.min(i8 + iMax2, i5)};
    }

    @Override // it.sephiroth.android.library.widget.a
    protected int b(int i, boolean z) {
        int iMin;
        ListAdapter listAdapter = this.j;
        if (listAdapter == null || isInTouchMode()) {
            return -1;
        }
        int count = listAdapter.getCount();
        if (this.aF) {
            if (i < 0 || i >= count) {
                return -1;
            }
            return i;
        }
        if (z) {
            iMin = Math.max(0, i);
            while (iMin < count && !listAdapter.isEnabled(iMin)) {
                iMin++;
            }
        } else {
            iMin = Math.min(i, count - 1);
            while (iMin >= 0 && !listAdapter.isEnabled(iMin)) {
                iMin--;
            }
        }
        if (iMin < 0 || iMin >= count) {
            return -1;
        }
        return iMin;
    }

    void b(Canvas canvas, Drawable drawable, Rect rect) {
        int minimumWidth = drawable.getMinimumWidth();
        canvas.save();
        canvas.clipRect(rect);
        if (rect.right - rect.left < minimumWidth) {
            rect.right = rect.left + minimumWidth;
        }
        drawable.setBounds(rect);
        drawable.draw(canvas);
        canvas.restore();
    }

    public void b(View view) {
        a(view, (Object) null, true);
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    public void c(int i) {
        super.c(i);
    }

    @Override // it.sephiroth.android.library.widget.a, android.view.ViewGroup
    protected boolean canAnimate() {
        return super.canAnimate() && this.ao > 0;
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    protected void d() {
        a(this.az);
        a(this.aA);
        super.d();
        this.h = 0;
    }

    /* JADX WARN: Removed duplicated region for block: B:53:0x00e8 A[PHI: r5
      0x00e8: PHI (r5v15 int) = (r5v12 int), (r5v12 int), (r5v12 int), (r5v9 int), (r5v9 int) binds: [B:56:0x00f7, B:57:0x00f9, B:60:0x00ff, B:51:0x00e5, B:48:0x00df] A[DONT_GENERATE, DONT_INLINE]] */
    @Override // it.sephiroth.android.library.widget.AbsHListView, android.view.ViewGroup, android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void dispatchDraw(android.graphics.Canvas r31) {
        /*
            Method dump skipped, instruction units count: 520
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.HListView.dispatchDraw(android.graphics.Canvas):void");
    }

    @Override // android.view.ViewGroup, android.view.View
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        boolean zDispatchKeyEvent = super.dispatchKeyEvent(keyEvent);
        return (zDispatchKeyEvent || getFocusedChild() == null || keyEvent.getAction() != 0) ? zDispatchKeyEvent : onKeyDown(keyEvent.getKeyCode(), keyEvent);
    }

    @Override // android.view.ViewGroup
    protected boolean drawChild(Canvas canvas, View view, long j) {
        boolean zDrawChild = super.drawChild(canvas, view, j);
        if (this.z) {
            this.z = false;
        }
        return zDrawChild;
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    protected int e(int i) {
        int childCount = getChildCount();
        if (childCount <= 0) {
            return -1;
        }
        if (this.K) {
            for (int i2 = childCount - 1; i2 >= 0; i2--) {
                if (i >= getChildAt(i2).getLeft()) {
                    return this.V + i2;
                }
            }
            return -1;
        }
        for (int i3 = 0; i3 < childCount; i3++) {
            if (i <= getChildAt(i3).getRight()) {
                return this.V + i3;
            }
        }
        return -1;
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    protected void e() {
        View view;
        View childAt;
        int i;
        View view2;
        View viewFindFocus;
        View view3;
        View viewK;
        int iM;
        int i2;
        boolean z;
        int i3;
        boolean z2 = this.at;
        if (z2) {
            return;
        }
        this.at = true;
        try {
            super.e();
            invalidate();
            if (this.j == null) {
                d();
                b();
                if (z2) {
                    return;
                }
                this.at = false;
                return;
            }
            int left = this.u.left;
            int right = (getRight() - getLeft()) - this.u.right;
            int childCount = getChildCount();
            switch (this.h) {
                case 2:
                    int i4 = this.ak - this.V;
                    if (i4 >= 0 && i4 < childCount) {
                        childAt = getChildAt(i4);
                        view = null;
                    }
                    i = 0;
                    view2 = null;
                case 1:
                case 3:
                case 4:
                case 5:
                    view = null;
                    childAt = null;
                    i = 0;
                    view2 = null;
                    break;
                default:
                    int i5 = this.am - this.V;
                    View childAt2 = (i5 < 0 || i5 >= childCount) ? null : getChildAt(i5);
                    View childAt3 = getChildAt(0);
                    int i6 = this.ak >= 0 ? this.ak - this.am : 0;
                    View view4 = childAt2;
                    childAt = getChildAt(i5 + i6);
                    view = view4;
                    int i7 = i6;
                    view2 = childAt3;
                    i = i7;
                    break;
            }
            boolean z3 = this.aj;
            if (z3) {
                q();
            }
            if (this.ao == 0) {
                d();
                b();
                if (z2) {
                    return;
                }
                this.at = false;
                return;
            }
            if (this.ao != this.j.getCount()) {
                throw new IllegalStateException("The content of the adapter has changed but ListView did not receive a notification. Make sure the content of your adapter is not modified from a background thread, but only from the UI thread. [in ListView(" + getId() + ", " + getClass() + ") with Adapter(" + this.j.getClass() + ")]");
            }
            setSelectedPositionInt(this.ak);
            int i8 = this.V;
            AbsHListView.k kVar = this.p;
            if (z3) {
                for (int i9 = 0; i9 < childCount; i9++) {
                    kVar.a(getChildAt(i9), i8 + i9);
                }
            } else {
                kVar.a(childCount, i8);
            }
            View focusedChild = getFocusedChild();
            if (focusedChild != null) {
                if (!z3 || c(focusedChild)) {
                    viewFindFocus = findFocus();
                    if (viewFindFocus != null) {
                        viewFindFocus.onStartTemporaryDetach();
                    }
                    view3 = focusedChild;
                } else {
                    viewFindFocus = null;
                    view3 = null;
                }
                requestFocus();
            } else {
                viewFindFocus = null;
                view3 = null;
            }
            detachAllViewsFromParent();
            kVar.d();
            switch (this.h) {
                case 1:
                    this.V = 0;
                    viewK = k(left);
                    y();
                    z = true;
                    break;
                case 2:
                    viewK = childAt != null ? a(childAt.getLeft(), left, right) : h(left, right);
                    z = true;
                    break;
                case 3:
                    viewK = g(this.ao - 1, right);
                    y();
                    z = true;
                    break;
                case 4:
                    iM = m();
                    i2 = this.W;
                    viewK = i(iM, i2);
                    z = true;
                    break;
                case 5:
                    iM = this.aa;
                    i2 = this.W;
                    viewK = i(iM, i2);
                    z = true;
                    break;
                case 6:
                    viewK = a(view, childAt, i, left, right);
                    z = true;
                    break;
                default:
                    if (childCount != 0) {
                        z = true;
                        if (this.am >= 0 && this.am < this.ao) {
                            i3 = this.am;
                            if (view != null) {
                                left = view.getLeft();
                            }
                        } else if (this.V >= this.ao) {
                            viewK = i(0, left);
                            break;
                        } else {
                            i3 = this.V;
                            if (view2 != null) {
                                left = view2.getLeft();
                            }
                        }
                        viewK = i(i3, left);
                    } else if (this.K) {
                        z = true;
                        setSelectedPositionInt(b(this.ao - 1, false));
                        viewK = g(this.ao - 1, right);
                    } else {
                        setSelectedPositionInt(b(0, true));
                        viewK = k(left);
                        z = true;
                    }
                    break;
            }
            kVar.e();
            if (viewK == null) {
                if (this.F <= 0 || this.F >= 3) {
                    this.J = 0;
                    this.o.setEmpty();
                } else {
                    View childAt4 = getChildAt(this.A - this.V);
                    if (childAt4 != null) {
                        a(this.A, childAt4);
                    }
                }
                if (hasFocus() && viewFindFocus != null) {
                    viewFindFocus.requestFocus();
                }
            } else if (this.aG && hasFocus() && !viewK.hasFocus()) {
                if ((viewK != view3 || viewFindFocus == null || !viewFindFocus.requestFocus()) && !viewK.requestFocus()) {
                    z = false;
                }
                if (z) {
                    viewK.setSelected(false);
                    this.o.setEmpty();
                    this.J = viewK.getLeft();
                } else {
                    View focusedChild2 = getFocusedChild();
                    if (focusedChild2 != null) {
                        focusedChild2.clearFocus();
                    }
                    a(-1, viewK);
                    this.J = viewK.getLeft();
                }
            } else {
                a(-1, viewK);
                this.J = viewK.getLeft();
            }
            if (viewFindFocus != null && viewFindFocus.getWindowToken() != null) {
                viewFindFocus.onFinishTemporaryDetach();
            }
            this.h = 0;
            this.aj = false;
            if (this.O != null) {
                post(this.O);
                this.O = null;
            }
            this.ad = false;
            setNextSelectedPositionInt(this.am);
            f();
            if (this.ao > 0) {
                u();
            }
            b();
            if (z2) {
                return;
            }
            this.at = false;
        } finally {
        }
    }

    public void e(int i, int i2) {
        if (this.j == null) {
            return;
        }
        if (isInTouchMode()) {
            this.M = i;
        } else {
            i = b(i, true);
            if (i >= 0) {
                setNextSelectedPositionInt(i);
            }
        }
        if (i >= 0) {
            this.h = 4;
            this.W = this.u.left + i2;
            if (this.ad) {
                this.aa = i;
                this.ab = this.j.getItemId(i);
            }
            if (this.I != null) {
                this.I.a();
            }
            requestLayout();
        }
    }

    @Override // it.sephiroth.android.library.widget.a
    public ListAdapter getAdapter() {
        return this.j;
    }

    @Deprecated
    public long[] getCheckItemIds() {
        if (this.j != null && this.j.hasStableIds()) {
            return getCheckedItemIds();
        }
        if (this.b == 0 || this.f == null || this.j == null) {
            return new long[0];
        }
        SparseArrayCompat<Boolean> sparseArrayCompat = this.f;
        int size = sparseArrayCompat.size();
        long[] jArr = new long[size];
        ListAdapter listAdapter = this.j;
        int i = 0;
        for (int i2 = 0; i2 < size; i2++) {
            if (sparseArrayCompat.valueAt(i2).booleanValue()) {
                jArr[i] = listAdapter.getItemId(sparseArrayCompat.keyAt(i2));
                i++;
            }
        }
        if (i == size) {
            return jArr;
        }
        long[] jArr2 = new long[i];
        System.arraycopy(jArr, 0, jArr2, 0, i);
        return jArr2;
    }

    public Drawable getDivider() {
        return this.au;
    }

    public int getDividerWidth() {
        return this.av;
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    public int getFooterViewsCount() {
        return this.aA.size();
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    public int getHeaderViewsCount() {
        return this.az.size();
    }

    public boolean getItemsCanFocus() {
        return this.aG;
    }

    public int getMaxScrollAmount() {
        return (int) ((getRight() - getLeft()) * 0.33f);
    }

    public Drawable getOverscrollFooter() {
        return this.ay;
    }

    public Drawable getOverscrollHeader() {
        return this.ax;
    }

    boolean h(int i) {
        int iMin;
        boolean z;
        int iB;
        if (i == 33) {
            iMin = Math.max(0, (this.am - getChildCount()) - 1);
        } else {
            if (i == 130) {
                iMin = Math.min(this.ao - 1, (this.am + getChildCount()) - 1);
                z = true;
                if (iMin >= 0 || (iB = b(iMin, z)) < 0) {
                    return false;
                }
                this.h = 4;
                this.W = getPaddingLeft() + getHorizontalFadingEdgeLength();
                if (z && iB > this.ao - getChildCount()) {
                    this.h = 3;
                }
                if (!z && iB < getChildCount()) {
                    this.h = 1;
                }
                setSelectionInt(iB);
                b();
                if (!awakenScrollBars()) {
                    invalidate();
                }
                return true;
            }
            iMin = -1;
        }
        z = false;
        if (iMin >= 0) {
        }
        return false;
    }

    /* JADX WARN: Removed duplicated region for block: B:17:0x0031  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    boolean i(int r4) {
        /*
            r3 = this;
            r0 = 0
            r1 = 1
            r2 = 33
            if (r4 != r2) goto L19
            int r4 = r3.am
            if (r4 == 0) goto L31
            int r4 = r3.b(r0, r1)
            if (r4 < 0) goto L32
            r3.h = r1
        L12:
            r3.setSelectionInt(r4)
            r3.b()
            goto L32
        L19:
            r2 = 130(0x82, float:1.82E-43)
            if (r4 != r2) goto L31
            int r4 = r3.am
            int r2 = r3.ao
            int r2 = r2 - r1
            if (r4 >= r2) goto L31
            int r4 = r3.ao
            int r4 = r4 - r1
            int r4 = r3.b(r4, r1)
            if (r4 < 0) goto L32
            r0 = 3
            r3.h = r0
            goto L12
        L31:
            r1 = 0
        L32:
            if (r1 == 0) goto L40
            boolean r4 = r3.awakenScrollBars()
            if (r4 != 0) goto L40
            r3.awakenScrollBars()
            r3.invalidate()
        L40:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.HListView.i(int):boolean");
    }

    @Override // android.view.View
    public boolean isOpaque() {
        boolean z = (this.z && this.aB && this.aC) || super.isOpaque();
        if (z) {
            int paddingLeft = this.u != null ? this.u.left : getPaddingLeft();
            View childAt = getChildAt(0);
            if (childAt == null || childAt.getLeft() > paddingLeft) {
                return false;
            }
            int width = getWidth() - (this.u != null ? this.u.right : getPaddingRight());
            View childAt2 = getChildAt(getChildCount() - 1);
            if (childAt2 == null || childAt2.getRight() < width) {
                return false;
            }
        }
        return z;
    }

    boolean j(int i) {
        try {
            this.af = true;
            boolean zO = o(i);
            if (zO) {
                playSoundEffect(SoundEffectConstants.getContantForFocusDirection(i));
            }
            return zO;
        } finally {
            this.af = false;
        }
    }

    @Override // android.view.View
    protected void onFinishInflate() {
        super.onFinishInflate();
        int childCount = getChildCount();
        if (childCount > 0) {
            for (int i = 0; i < childCount; i++) {
                b(getChildAt(i));
            }
            removeAllViews();
        }
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, android.view.View
    protected void onFocusChanged(boolean z, int i, Rect rect) {
        super.onFocusChanged(z, i, rect);
        ListAdapter listAdapter = this.j;
        int i2 = 0;
        int i3 = -1;
        if (listAdapter != null && z && rect != null) {
            rect.offset(getScrollX(), getScrollY());
            if (listAdapter.getCount() < getChildCount() + this.V) {
                this.h = 0;
                e();
            }
            Rect rect2 = this.aH;
            int childCount = getChildCount();
            int i4 = this.V;
            int left = 0;
            int i5 = Integer.MAX_VALUE;
            while (i2 < childCount) {
                if (listAdapter.isEnabled(i4 + i2)) {
                    View childAt = getChildAt(i2);
                    childAt.getDrawingRect(rect2);
                    offsetDescendantRectToMyCoords(childAt, rect2);
                    int iA = a(rect, rect2, i);
                    if (iA < i5) {
                        left = childAt.getLeft();
                        i3 = i2;
                        i5 = iA;
                    }
                }
                i2++;
            }
            i2 = left;
        }
        if (i3 >= 0) {
            e(i3 + this.V, i2);
        } else {
            requestLayout();
        }
    }

    @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
    public void onGlobalLayout() {
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, it.sephiroth.android.library.widget.a, android.view.View
    public void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        super.onInitializeAccessibilityEvent(accessibilityEvent);
        accessibilityEvent.setClassName(HListView.class.getName());
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, it.sephiroth.android.library.widget.a, android.view.View
    @TargetApi(14)
    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo) {
        super.onInitializeAccessibilityNodeInfo(accessibilityNodeInfo);
        accessibilityNodeInfo.setClassName(HListView.class.getName());
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return a(i, 1, keyEvent);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent) {
        return a(i, i2, keyEvent);
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        return a(i, 1, keyEvent);
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, android.view.View
    @TargetApi(11)
    protected void onMeasure(int i, int i2) {
        int i3;
        int i4;
        super.onMeasure(i, i2);
        int mode = View.MeasureSpec.getMode(i);
        int mode2 = View.MeasureSpec.getMode(i2);
        int size = View.MeasureSpec.getSize(i);
        int size2 = View.MeasureSpec.getSize(i2);
        this.ao = this.j == null ? 0 : this.j.getCount();
        if (this.ao <= 0 || !(mode == 0 || mode2 == 0)) {
            i3 = 0;
            i4 = 0;
        } else {
            View viewA = a(0, this.P);
            a(viewA, 0, i2);
            int measuredWidth = viewA.getMeasuredWidth();
            int measuredHeight = viewA.getMeasuredHeight();
            iCombineMeasuredStates = Build.VERSION.SDK_INT >= 11 ? combineMeasuredStates(0, viewA.getMeasuredState()) : 0;
            if (x() && this.p.b(((AbsHListView.f) viewA.getLayoutParams()).a)) {
                this.p.a(viewA, -1);
            }
            i3 = iCombineMeasuredStates;
            i4 = measuredWidth;
            iCombineMeasuredStates = measuredHeight;
        }
        if (mode2 == 0) {
            size2 = this.u.top + this.u.bottom + iCombineMeasuredStates + getHorizontalScrollbarHeight();
        } else if (mode2 == Integer.MIN_VALUE && this.ao > 0 && this.aw > -1) {
            size2 = a(i2, this.aw, this.aw, size, size2, -1)[1];
        } else if (Build.VERSION.SDK_INT >= 11) {
            size2 |= (-16777216) & i3;
        }
        if (mode == 0) {
            size = this.u.left + this.u.right + i4 + (getHorizontalFadingEdgeLength() * 2);
        }
        int iA = size;
        if (mode == Integer.MIN_VALUE) {
            iA = a(i2, 0, -1, iA, -1);
        }
        setMeasuredDimension(iA, size2);
        this.v = i2;
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        View focusedChild;
        if (getChildCount() > 0 && (focusedChild = getFocusedChild()) != null) {
            int iIndexOfChild = this.V + indexOfChild(focusedChild);
            int left = focusedChild.getLeft() - Math.max(0, focusedChild.getRight() - (i - getPaddingLeft()));
            if (this.aK == null) {
                this.aK = new c();
            }
            post(this.aK.a(iIndexOfChild, left));
        }
        super.onSizeChanged(i, i2, i3, i4);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public boolean requestChildRectangleOnScreen(View view, Rect rect, boolean z) {
        int iMax;
        int i = rect.left;
        rect.offset(view.getLeft(), view.getTop());
        rect.offset(-view.getScrollX(), -view.getScrollY());
        int width = getWidth();
        int scrollX = getScrollX();
        int i2 = scrollX + width;
        int horizontalFadingEdgeLength = getHorizontalFadingEdgeLength();
        if (z() && (this.am > 0 || i > horizontalFadingEdgeLength)) {
            scrollX += horizontalFadingEdgeLength;
        }
        int right = getChildAt(getChildCount() - 1).getRight();
        if (A() && (this.am < this.ao - 1 || rect.right < right - horizontalFadingEdgeLength)) {
            i2 -= horizontalFadingEdgeLength;
        }
        if (rect.right > i2 && rect.left > scrollX) {
            iMax = Math.min((rect.width() > width ? rect.left - scrollX : rect.right - i2) + 0, right - i2);
        } else if (rect.left >= scrollX || rect.right >= i2) {
            iMax = 0;
        } else {
            iMax = Math.max(rect.width() > width ? 0 - (i2 - rect.right) : 0 - (scrollX - rect.left), getChildAt(0).getLeft() - scrollX);
        }
        boolean z2 = iMax != 0;
        if (z2) {
            r(-iMax);
            a(-1, view);
            this.J = view.getTop();
            invalidate();
        }
        return z2;
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView, it.sephiroth.android.library.widget.a
    public void setAdapter(ListAdapter listAdapter) {
        if (this.j != null && this.i != null) {
            this.j.unregisterDataSetObserver(this.i);
        }
        d();
        this.p.b();
        if (this.az.size() > 0 || this.aA.size() > 0) {
            this.j = new it.sephiroth.android.library.widget.b(this.az, this.aA, listAdapter);
        } else {
            this.j = listAdapter;
        }
        this.ar = -1;
        this.as = Long.MIN_VALUE;
        super.setAdapter(listAdapter);
        if (this.j != null) {
            this.aF = this.j.areAllItemsEnabled();
            this.ap = this.ao;
            this.ao = this.j.getCount();
            s();
            this.i = new AbsHListView.a();
            this.j.registerDataSetObserver(this.i);
            this.p.a(this.j.getViewTypeCount());
            int iB = this.K ? b(this.ao - 1, false) : b(0, true);
            setSelectedPositionInt(iB);
            setNextSelectedPositionInt(iB);
            if (this.ao == 0) {
            }
            requestLayout();
        }
        this.aF = true;
        s();
        u();
        requestLayout();
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    public void setCacheColorHint(int i) {
        boolean z = (i >>> 24) == 255;
        this.aB = z;
        if (z) {
            if (this.aI == null) {
                this.aI = new Paint();
            }
            this.aI.setColor(i);
        }
        super.setCacheColorHint(i);
    }

    public void setDivider(Drawable drawable) {
        if (drawable != null) {
            this.av = drawable.getIntrinsicWidth();
        } else {
            this.av = 0;
        }
        this.au = drawable;
        this.aC = drawable == null || drawable.getOpacity() == -1;
        requestLayout();
        invalidate();
    }

    public void setDividerWidth(int i) {
        this.av = i;
        requestLayout();
        invalidate();
    }

    public void setFooterDividersEnabled(boolean z) {
        this.aE = z;
        invalidate();
    }

    public void setHeaderDividersEnabled(boolean z) {
        this.aD = z;
        invalidate();
    }

    public void setItemsCanFocus(boolean z) {
        this.aG = z;
        if (z) {
            return;
        }
        setDescendantFocusability(393216);
    }

    public void setOverscrollFooter(Drawable drawable) {
        this.ay = drawable;
        invalidate();
    }

    public void setOverscrollHeader(Drawable drawable) {
        this.ax = drawable;
        if (getScrollX() < 0) {
            invalidate();
        }
    }

    @Override // it.sephiroth.android.library.widget.a
    public void setSelection(int i) {
        e(i, 0);
    }

    @Override // it.sephiroth.android.library.widget.AbsHListView
    public void setSelectionInt(int i) {
        setNextSelectedPositionInt(i);
        int i2 = this.am;
        boolean z = true;
        if (i2 < 0 || (i != i2 - 1 && i != i2 + 1)) {
            z = false;
        }
        if (this.I != null) {
            this.I.a();
        }
        e();
        if (z) {
            awakenScrollBars();
        }
    }

    @ViewDebug.ExportedProperty(category = "list")
    protected boolean x() {
        return true;
    }
}
