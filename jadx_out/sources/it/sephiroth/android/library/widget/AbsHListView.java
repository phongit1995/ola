package it.sephiroth.android.library.widget;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.TransitionDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.util.LongSparseArray;
import android.support.v4.util.SparseArrayCompat;
import android.support.v4.view.AccessibilityDelegateCompat;
import android.support.v4.view.MotionEventCompat;
import android.support.v4.view.accessibility.AccessibilityNodeInfoCompat;
import android.support.v4.widget.EdgeEffectCompat;
import android.support.v7.widget.helper.ItemTouchHelper;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.view.ActionMode;
import android.view.ContextMenu;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewDebug;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.ViewTreeObserver;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.animation.Interpolator;
import android.view.animation.LinearInterpolator;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.Checkable;
import android.widget.ListAdapter;
import chat.ola.vn.R;
import chat.ola.vn.i;
import it.sephiroth.android.library.a.a;
import it.sephiroth.android.library.widget.a;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
@TargetApi(11)
public abstract class AbsHListView extends it.sephiroth.android.library.widget.a<ListAdapter> implements ViewTreeObserver.OnGlobalLayoutListener, ViewTreeObserver.OnTouchModeChangeListener {
    static final Interpolator T = new LinearInterpolator();
    public static final int[] U = {0};
    protected int A;
    int B;
    int C;
    int D;
    int E;
    protected int F;
    int G;
    int H;
    protected j I;
    protected int J;
    protected boolean K;
    boolean L;
    protected int M;
    protected int N;
    protected Runnable O;
    protected final boolean[] P;
    int Q;
    int R;
    protected boolean S;
    a.AbstractC0084a a;
    private int aA;
    private c aB;
    private Runnable aC;
    private b aD;
    private i aE;
    private Runnable aF;
    private int aG;
    private int aH;
    private boolean aI;
    private int aJ;
    private int aK;
    private Runnable aL;
    private int aM;
    private int aN;
    private float aO;
    private int aP;
    private EdgeEffectCompat aQ;
    private EdgeEffectCompat aR;
    private int aS;
    private int aT;
    private int aU;
    private boolean aV;
    private int aW;
    private int aX;
    private g aY;
    private int aZ;
    private VelocityTracker au;
    private e av;
    private h aw;
    private boolean ax;
    private Rect ay;
    private ContextMenu.ContextMenuInfo az;
    protected int b;
    private int ba;
    private int bb;
    private SavedState bc;
    private float bd;
    public Object c;
    Object d;
    int e;
    protected SparseArrayCompat<Boolean> f;
    LongSparseArray<Integer> g;
    protected int h;
    protected a i;
    protected ListAdapter j;
    boolean k;
    boolean l;
    Drawable m;
    int n;
    protected Rect o;
    protected final k p;
    int q;
    int r;
    int s;
    int t;
    protected Rect u;
    protected int v;
    View w;
    View x;
    protected boolean y;
    protected boolean z;

    static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new Parcelable.Creator<SavedState>() { // from class: it.sephiroth.android.library.widget.AbsHListView.SavedState.1
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
        long a;
        long b;
        int c;
        int d;
        int e;
        String f;
        boolean g;
        int h;
        SparseArrayCompat<Boolean> i;
        LongSparseArray<Integer> j;

        private SavedState(Parcel parcel) {
            super(parcel);
            this.a = parcel.readLong();
            this.b = parcel.readLong();
            this.c = parcel.readInt();
            this.d = parcel.readInt();
            this.e = parcel.readInt();
            this.f = parcel.readString();
            this.g = parcel.readByte() != 0;
            this.h = parcel.readInt();
            this.i = b(parcel);
            this.j = a(parcel);
        }

        SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        private LongSparseArray<Integer> a(Parcel parcel) {
            int i = parcel.readInt();
            if (i <= 0) {
                return null;
            }
            LongSparseArray<Integer> longSparseArray = new LongSparseArray<>(i);
            a(longSparseArray, parcel, i);
            return longSparseArray;
        }

        private void a(LongSparseArray<Integer> longSparseArray, Parcel parcel) {
            int size = longSparseArray != null ? longSparseArray.size() : 0;
            parcel.writeInt(size);
            for (int i = 0; i < size; i++) {
                parcel.writeLong(longSparseArray.keyAt(i));
                parcel.writeInt(longSparseArray.valueAt(i).intValue());
            }
        }

        private void a(LongSparseArray<Integer> longSparseArray, Parcel parcel, int i) {
            while (i > 0) {
                longSparseArray.put(parcel.readLong(), Integer.valueOf(parcel.readInt()));
                i--;
            }
        }

        private void a(SparseArrayCompat<Boolean> sparseArrayCompat, Parcel parcel) {
            if (sparseArrayCompat == null) {
                parcel.writeInt(-1);
                return;
            }
            int size = sparseArrayCompat.size();
            parcel.writeInt(size);
            for (int i = 0; i < size; i++) {
                parcel.writeInt(sparseArrayCompat.keyAt(i));
                parcel.writeByte(sparseArrayCompat.valueAt(i).booleanValue() ? (byte) 1 : (byte) 0);
            }
        }

        private void a(SparseArrayCompat<Boolean> sparseArrayCompat, Parcel parcel, int i) {
            while (i > 0) {
                int i2 = parcel.readInt();
                boolean z = true;
                if (parcel.readByte() != 1) {
                    z = false;
                }
                sparseArrayCompat.append(i2, Boolean.valueOf(z));
                i--;
            }
        }

        private SparseArrayCompat<Boolean> b(Parcel parcel) {
            int i = parcel.readInt();
            if (i < 0) {
                return null;
            }
            SparseArrayCompat<Boolean> sparseArrayCompat = new SparseArrayCompat<>(i);
            a(sparseArrayCompat, parcel, i);
            return sparseArrayCompat;
        }

        public String toString() {
            return "AbsListView.SavedState{" + Integer.toHexString(System.identityHashCode(this)) + " selectedId=" + this.a + " firstId=" + this.b + " viewLeft=" + this.c + " position=" + this.d + " width=" + this.e + " filter=" + this.f + " checkState=" + this.i + "}";
        }

        @Override // android.view.View.BaseSavedState, android.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeLong(this.a);
            parcel.writeLong(this.b);
            parcel.writeInt(this.c);
            parcel.writeInt(this.d);
            parcel.writeInt(this.e);
            parcel.writeString(this.f);
            parcel.writeByte(this.g ? (byte) 1 : (byte) 0);
            parcel.writeInt(this.h);
            a(this.i, parcel);
            a(this.j, parcel);
        }
    }

    public class a extends it.sephiroth.android.library.widget.a<ListAdapter>.b {
        public a() {
            super();
        }

        @Override // it.sephiroth.android.library.widget.a.b, android.database.DataSetObserver
        public void onChanged() {
            super.onChanged();
        }

        @Override // it.sephiroth.android.library.widget.a.b, android.database.DataSetObserver
        public void onInvalidated() {
            super.onInvalidated();
        }
    }

    private class b extends n implements Runnable {
        private b() {
            super();
        }

        @Override // java.lang.Runnable
        public void run() {
            if (!AbsHListView.this.isPressed() || AbsHListView.this.am < 0) {
                return;
            }
            View childAt = AbsHListView.this.getChildAt(AbsHListView.this.am - AbsHListView.this.V);
            if (AbsHListView.this.aj) {
                AbsHListView.this.setPressed(false);
                if (childAt == null) {
                    return;
                }
            } else {
                if (!(b() ? AbsHListView.this.c(childAt, AbsHListView.this.am, AbsHListView.this.an) : false)) {
                    return;
                } else {
                    AbsHListView.this.setPressed(false);
                }
            }
            childAt.setPressed(false);
        }
    }

    private class c extends n implements Runnable {
        private c() {
            super();
        }

        @Override // java.lang.Runnable
        public void run() {
            View childAt = AbsHListView.this.getChildAt(AbsHListView.this.A - AbsHListView.this.V);
            if (childAt != null) {
                if (!((!b() || AbsHListView.this.aj) ? false : AbsHListView.this.c(childAt, AbsHListView.this.A, AbsHListView.this.j.getItemId(AbsHListView.this.A)))) {
                    AbsHListView.this.F = 2;
                    return;
                }
                AbsHListView.this.F = -1;
                AbsHListView.this.setPressed(false);
                childAt.setPressed(false);
            }
        }
    }

    final class d implements Runnable {
        d() {
        }

        @Override // java.lang.Runnable
        public void run() {
            Drawable current;
            if (AbsHListView.this.F == 0) {
                AbsHListView.this.F = 1;
                View childAt = AbsHListView.this.getChildAt(AbsHListView.this.A - AbsHListView.this.V);
                if (childAt == null || childAt.hasFocusable()) {
                    return;
                }
                AbsHListView.this.h = 0;
                if (!AbsHListView.this.aj) {
                    childAt.setPressed(true);
                    AbsHListView.this.setPressed(true);
                    AbsHListView.this.e();
                    AbsHListView.this.a(AbsHListView.this.A, childAt);
                    AbsHListView.this.refreshDrawableState();
                    int longPressTimeout = ViewConfiguration.getLongPressTimeout();
                    boolean zIsLongClickable = AbsHListView.this.isLongClickable();
                    if (AbsHListView.this.m != null && (current = AbsHListView.this.m.getCurrent()) != null && (current instanceof TransitionDrawable)) {
                        if (zIsLongClickable) {
                            ((TransitionDrawable) current).startTransition(longPressTimeout);
                        } else {
                            ((TransitionDrawable) current).resetTransition();
                        }
                    }
                    if (zIsLongClickable) {
                        if (AbsHListView.this.aB == null) {
                            AbsHListView.this.aB = new c();
                        }
                        AbsHListView.this.aB.a();
                        AbsHListView.this.postDelayed(AbsHListView.this.aB, longPressTimeout);
                        return;
                    }
                }
                AbsHListView.this.F = 2;
            }
        }
    }

    private class e implements Runnable {
        private final it.sephiroth.android.library.widget.c b;
        private int c;
        private final Runnable d = new Runnable() { // from class: it.sephiroth.android.library.widget.AbsHListView.e.1
            @Override // java.lang.Runnable
            public void run() {
                int i = AbsHListView.this.aP;
                VelocityTracker velocityTracker = AbsHListView.this.au;
                it.sephiroth.android.library.widget.c cVar = e.this.b;
                if (velocityTracker == null || i == -1) {
                    return;
                }
                velocityTracker.computeCurrentVelocity(1000, AbsHListView.this.aN);
                float f = -velocityTracker.getXVelocity(i);
                if (Math.abs(f) >= AbsHListView.this.aM && cVar.a(f, 0.0f)) {
                    AbsHListView.this.postDelayed(this, 40L);
                    return;
                }
                e.this.b();
                AbsHListView.this.F = 3;
                AbsHListView.this.b(1);
            }
        };

        e() {
            this.b = new it.sephiroth.android.library.widget.c(AbsHListView.this.getContext());
        }

        void a() {
            if (!this.b.a(AbsHListView.this.getScrollX(), 0, 0, 0, 0, 0)) {
                AbsHListView.this.F = -1;
                AbsHListView.this.b(0);
            } else {
                AbsHListView.this.F = 6;
                AbsHListView.this.invalidate();
                AbsHListView.this.a.a(this);
            }
        }

        void a(int i) {
            int i2 = i < 0 ? Integer.MAX_VALUE : 0;
            this.c = i2;
            this.b.a((Interpolator) null);
            this.b.a(i2, 0, i, 0, 0, Integer.MAX_VALUE, 0, Integer.MAX_VALUE);
            AbsHListView.this.F = 4;
            AbsHListView.this.a.a(this);
        }

        void a(int i, int i2, boolean z) {
            int i3 = i < 0 ? Integer.MAX_VALUE : 0;
            this.c = i3;
            this.b.a(z ? AbsHListView.T : null);
            this.b.a(i3, 0, i, 0, i2);
            AbsHListView.this.F = 4;
            AbsHListView.this.a.a(this);
        }

        void b() {
            AbsHListView.this.F = -1;
            AbsHListView.this.removeCallbacks(this);
            AbsHListView.this.removeCallbacks(this.d);
            AbsHListView.this.b(0);
            AbsHListView.this.F();
            this.b.e();
            AbsHListView.this.overScrollBy(0, 0, 0, 0, 0, 0, 0, 0, false);
        }

        void b(int i) {
            this.b.a((Interpolator) null);
            this.b.a(AbsHListView.this.getScrollX(), 0, i, 0, Integer.MIN_VALUE, Integer.MAX_VALUE, 0, 0, AbsHListView.this.getWidth(), 0);
            AbsHListView.this.F = 6;
            AbsHListView.this.invalidate();
            AbsHListView.this.a.a(this);
        }

        void c() {
            AbsHListView.this.postDelayed(this.d, 40L);
        }

        void c(int i) {
            this.b.a(AbsHListView.this.getScrollX(), 0, AbsHListView.this.R);
            int overScrollMode = AbsHListView.this.getOverScrollMode();
            if (overScrollMode == 0 || (overScrollMode == 1 && !AbsHListView.this.z())) {
                AbsHListView.this.F = 6;
                (i > 0 ? AbsHListView.this.aQ : AbsHListView.this.aR).onAbsorb((int) this.b.c());
            } else {
                AbsHListView.this.F = -1;
                if (AbsHListView.this.I != null) {
                    AbsHListView.this.I.a();
                }
            }
            AbsHListView.this.invalidate();
            AbsHListView.this.a.a(this);
        }

        @Override // java.lang.Runnable
        public void run() {
            int iMax;
            int i = AbsHListView.this.F;
            boolean z = false;
            if (i == 6) {
                it.sephiroth.android.library.widget.c cVar = this.b;
                if (cVar.d()) {
                    int scrollX = AbsHListView.this.getScrollX();
                    int iB = cVar.b();
                    if (!AbsHListView.this.overScrollBy(iB - scrollX, 0, scrollX, 0, 0, 0, AbsHListView.this.R, 0, false)) {
                        AbsHListView.this.invalidate();
                        AbsHListView.this.a.a(this);
                        return;
                    }
                    boolean z2 = scrollX <= 0 && iB > 0;
                    if (scrollX >= 0 && iB < 0) {
                        z = true;
                    }
                    if (!z2 && !z) {
                        a();
                        return;
                    }
                    int iC = (int) cVar.c();
                    if (z) {
                        iC = -iC;
                    }
                    cVar.e();
                    a(iC);
                    return;
                }
                b();
                return;
            }
            switch (i) {
                case 3:
                    if (this.b.a()) {
                    }
                case 4:
                    if (AbsHListView.this.aj) {
                        AbsHListView.this.e();
                    }
                    if (AbsHListView.this.ao == 0 || AbsHListView.this.getChildCount() == 0) {
                        b();
                    } else {
                        it.sephiroth.android.library.widget.c cVar2 = this.b;
                        boolean zD = cVar2.d();
                        int iB2 = cVar2.b();
                        int i2 = this.c - iB2;
                        if (i2 > 0) {
                            AbsHListView.this.A = AbsHListView.this.V;
                            AbsHListView.this.B = AbsHListView.this.getChildAt(0).getLeft();
                            iMax = Math.min(((AbsHListView.this.getWidth() - AbsHListView.this.getPaddingRight()) - AbsHListView.this.getPaddingLeft()) - 1, i2);
                        } else {
                            int childCount = AbsHListView.this.getChildCount() - 1;
                            AbsHListView.this.A = AbsHListView.this.V + childCount;
                            AbsHListView.this.B = AbsHListView.this.getChildAt(childCount).getLeft();
                            iMax = Math.max(-(((AbsHListView.this.getWidth() - AbsHListView.this.getPaddingRight()) - AbsHListView.this.getPaddingLeft()) - 1), i2);
                        }
                        View childAt = AbsHListView.this.getChildAt(AbsHListView.this.A - AbsHListView.this.V);
                        int left = childAt != null ? childAt.getLeft() : 0;
                        boolean zC = AbsHListView.this.c(iMax, iMax);
                        if (zC && iMax != 0) {
                            z = true;
                        }
                        if (!z) {
                            if (zD && !z) {
                                if (zC) {
                                    AbsHListView.this.invalidate();
                                }
                                this.c = iB2;
                                AbsHListView.this.a.a(this);
                            }
                            b();
                        } else {
                            if (childAt != null) {
                                AbsHListView.this.overScrollBy(-(iMax - (childAt.getLeft() - left)), 0, AbsHListView.this.getScrollX(), 0, 0, 0, AbsHListView.this.R, 0, false);
                            }
                            if (zD) {
                                c(iMax);
                            }
                        }
                    }
                    break;
                default:
                    b();
                    break;
            }
        }
    }

    public static class f extends ViewGroup.LayoutParams {
        public int a;
        public boolean b;
        public boolean c;
        public int d;
        public long e;

        public f(int i, int i2, int i3) {
            super(i, i2);
            this.e = -1L;
            this.a = i3;
        }

        public f(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.e = -1L;
        }

        public f(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.e = -1L;
        }
    }

    @TargetApi(14)
    class g extends AccessibilityDelegateCompat {
        g() {
        }

        @Override // android.support.v4.view.AccessibilityDelegateCompat
        public void onInitializeAccessibilityNodeInfo(View view, AccessibilityNodeInfoCompat accessibilityNodeInfoCompat) {
            int i;
            super.onInitializeAccessibilityNodeInfo(view, accessibilityNodeInfoCompat);
            int iA = AbsHListView.this.a(view);
            ListAdapter adapter = AbsHListView.this.getAdapter();
            if (iA == -1 || adapter == null || !AbsHListView.this.isEnabled() || !adapter.isEnabled(iA)) {
                return;
            }
            if (iA == AbsHListView.this.getSelectedItemPosition()) {
                accessibilityNodeInfoCompat.setSelected(true);
                i = 8;
            } else {
                i = 4;
            }
            accessibilityNodeInfoCompat.addAction(i);
            if (AbsHListView.this.isClickable()) {
                accessibilityNodeInfoCompat.addAction(16);
                accessibilityNodeInfoCompat.setClickable(true);
            }
            if (AbsHListView.this.isLongClickable()) {
                accessibilityNodeInfoCompat.addAction(32);
                accessibilityNodeInfoCompat.setLongClickable(true);
            }
        }

        @Override // android.support.v4.view.AccessibilityDelegateCompat
        public boolean performAccessibilityAction(View view, int i, Bundle bundle) {
            if (super.performAccessibilityAction(view, i, bundle)) {
                return true;
            }
            int iA = AbsHListView.this.a(view);
            ListAdapter adapter = AbsHListView.this.getAdapter();
            if (iA == -1 || adapter == null || !AbsHListView.this.isEnabled() || !adapter.isEnabled(iA)) {
                return false;
            }
            long jG = AbsHListView.this.g(iA);
            if (i == 4) {
                if (AbsHListView.this.getSelectedItemPosition() != iA) {
                    AbsHListView.this.setSelection(iA);
                    return true;
                }
                return false;
            }
            if (i == 8) {
                if (AbsHListView.this.getSelectedItemPosition() != iA) {
                    return false;
                }
                AbsHListView.this.setSelection(-1);
                return true;
            }
            if (i == 16) {
                if (AbsHListView.this.isClickable()) {
                    return AbsHListView.this.a(view, iA, jG);
                }
                return false;
            }
            if (i == 32 && AbsHListView.this.isLongClickable()) {
                return AbsHListView.this.c(view, iA, jG);
            }
            return false;
        }
    }

    public interface h {
        void a(AbsHListView absHListView, int i);

        void a(AbsHListView absHListView, int i, int i2, int i3);
    }

    private class i extends n implements Runnable {
        int a;

        private i() {
            super();
        }

        @Override // java.lang.Runnable
        public void run() {
            View childAt;
            if (AbsHListView.this.aj) {
                return;
            }
            ListAdapter listAdapter = AbsHListView.this.j;
            int i = this.a;
            if (listAdapter == null || AbsHListView.this.ao <= 0 || i == -1 || i >= listAdapter.getCount() || !b() || (childAt = AbsHListView.this.getChildAt(i - AbsHListView.this.V)) == null) {
                return;
            }
            AbsHListView.this.a(childAt, i, listAdapter.getItemId(i));
        }
    }

    public class j implements Runnable {
        private int b;
        private int c;
        private int d;
        private int e;
        private int f;
        private final int g;
        private int h;

        j() {
            this.g = ViewConfiguration.get(AbsHListView.this.getContext()).getScaledFadingEdgeLength();
        }

        public void a() {
            AbsHListView.this.removeCallbacks(this);
        }

        void a(final int i) {
            int i2;
            a();
            if (AbsHListView.this.aj) {
                AbsHListView.this.O = new Runnable() { // from class: it.sephiroth.android.library.widget.AbsHListView.j.1
                    @Override // java.lang.Runnable
                    public void run() {
                        j.this.a(i);
                    }
                };
                return;
            }
            int childCount = AbsHListView.this.getChildCount();
            if (childCount == 0) {
                return;
            }
            int i3 = AbsHListView.this.V;
            int i4 = (childCount + i3) - 1;
            int iMax = Math.max(0, Math.min(AbsHListView.this.getCount() - 1, i));
            int i5 = ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION;
            if (iMax < i3) {
                i2 = (i3 - iMax) + 1;
                this.b = 2;
            } else if (iMax <= i4) {
                a(iMax, -1, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
                return;
            } else {
                i2 = (iMax - i4) + 1;
                this.b = 1;
            }
            if (i2 > 0) {
                i5 = ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION / i2;
            }
            this.f = i5;
            this.c = iMax;
            this.d = -1;
            this.e = -1;
            AbsHListView.this.a.a(this);
        }

        void a(int i, int i2, int i3) {
            int i4 = AbsHListView.this.V;
            int childCount = (AbsHListView.this.getChildCount() + i4) - 1;
            int i5 = AbsHListView.this.u.left;
            int width = AbsHListView.this.getWidth() - AbsHListView.this.u.right;
            if (i < i4 || i > childCount) {
                Log.w("AbsListView", "scrollToVisible called with targetPos " + i + " not visible [" + i4 + ", " + childCount + "]");
            }
            if (i2 < i4 || i2 > childCount) {
                i2 = -1;
            }
            View childAt = AbsHListView.this.getChildAt(i - i4);
            int left = childAt.getLeft();
            int right = childAt.getRight();
            int iMin = right > width ? right - width : 0;
            if (left < i5) {
                iMin = left - i5;
            }
            if (iMin == 0) {
                return;
            }
            if (i2 >= 0) {
                View childAt2 = AbsHListView.this.getChildAt(i2 - i4);
                int left2 = childAt2.getLeft();
                int right2 = childAt2.getRight();
                int iAbs = Math.abs(iMin);
                if (iMin < 0 && right2 + iAbs > width) {
                    iMin = Math.max(0, right2 - width);
                } else if (iMin > 0 && left2 - iAbs < i5) {
                    iMin = Math.min(0, left2 - i5);
                }
            }
            AbsHListView.this.b(iMin, i3);
        }

        @Override // java.lang.Runnable
        public void run() {
            AbsHListView absHListView;
            int i;
            int width;
            int width2 = AbsHListView.this.getWidth();
            int i2 = AbsHListView.this.V;
            int i3 = 0;
            switch (this.b) {
                case 1:
                    int childCount = AbsHListView.this.getChildCount() - 1;
                    int i4 = i2 + childCount;
                    if (childCount >= 0) {
                        if (i4 != this.e) {
                            View childAt = AbsHListView.this.getChildAt(childCount);
                            AbsHListView.this.a((childAt.getWidth() - (width2 - childAt.getLeft())) + (i4 < AbsHListView.this.ao - 1 ? Math.max(AbsHListView.this.u.right, this.g) : AbsHListView.this.u.right), this.f, true);
                            this.e = i4;
                            if (i4 >= this.c) {
                            }
                            AbsHListView.this.a.a(this);
                        }
                        AbsHListView.this.a.a(this);
                        break;
                    }
                    break;
                case 2:
                    if (i2 != this.e) {
                        View childAt2 = AbsHListView.this.getChildAt(0);
                        if (childAt2 != null) {
                            AbsHListView.this.a(childAt2.getLeft() - (i2 > 0 ? Math.max(this.g, AbsHListView.this.u.left) : AbsHListView.this.u.left), this.f, true);
                            this.e = i2;
                            if (i2 <= this.c) {
                            }
                            AbsHListView.this.a.a(this);
                            break;
                        }
                    }
                    AbsHListView.this.a.a(this);
                    break;
                case 3:
                    int childCount2 = AbsHListView.this.getChildCount();
                    if (i2 != this.d && childCount2 > 1 && childCount2 + i2 < AbsHListView.this.ao) {
                        int i5 = i2 + 1;
                        if (i5 != this.e) {
                            View childAt3 = AbsHListView.this.getChildAt(1);
                            int width3 = childAt3.getWidth();
                            int left = childAt3.getLeft();
                            int iMax = Math.max(AbsHListView.this.u.right, this.g);
                            if (i5 < this.d) {
                                AbsHListView.this.a(Math.max(0, (width3 + left) - iMax), this.f, true);
                                this.e = i5;
                                AbsHListView.this.a.a(this);
                            } else if (left > iMax) {
                                absHListView = AbsHListView.this;
                                i = left - iMax;
                                absHListView.a(i, this.f, true);
                            }
                        }
                        AbsHListView.this.a.a(this);
                        break;
                    }
                    break;
                case 4:
                    int childCount3 = AbsHListView.this.getChildCount() - 2;
                    if (childCount3 >= 0) {
                        int i6 = i2 + childCount3;
                        if (i6 != this.e) {
                            View childAt4 = AbsHListView.this.getChildAt(childCount3);
                            int width4 = childAt4.getWidth();
                            int left2 = childAt4.getLeft();
                            int i7 = width2 - left2;
                            int iMax2 = Math.max(AbsHListView.this.u.left, this.g);
                            this.e = i6;
                            if (i6 <= this.d) {
                                int i8 = width2 - iMax2;
                                int i9 = left2 + width4;
                                if (i8 > i9) {
                                    absHListView = AbsHListView.this;
                                    i = -(i8 - i9);
                                    absHListView.a(i, this.f, true);
                                }
                            } else {
                                AbsHListView.this.a(-(i7 - iMax2), this.f, true);
                                AbsHListView.this.a.a(this);
                            }
                        }
                        AbsHListView.this.a.a(this);
                        break;
                    }
                    break;
                case 5:
                    if (this.e != i2) {
                        this.e = i2;
                        int childCount4 = AbsHListView.this.getChildCount();
                        int i10 = this.c;
                        int i11 = (i2 + childCount4) - 1;
                        if (i10 < i2) {
                            i3 = (i2 - i10) + 1;
                        } else if (i10 > i11) {
                            i3 = i10 - i11;
                        }
                        float fMin = Math.min(Math.abs(i3 / childCount4), 1.0f);
                        if (i10 < i2) {
                            width = -AbsHListView.this.getWidth();
                        } else if (i10 <= i11) {
                            AbsHListView.this.a(AbsHListView.this.getChildAt(i10 - i2).getLeft() - this.h, (int) (this.f * (Math.abs(r0) / AbsHListView.this.getWidth())), true);
                        } else {
                            width = AbsHListView.this.getWidth();
                        }
                        AbsHListView.this.a((int) (width * fMin), (int) (this.f * fMin), true);
                        AbsHListView.this.a.a(this);
                    }
                    AbsHListView.this.a.a(this);
                    break;
            }
        }
    }

    public class k {
        private l b;
        private int c;
        private View[] d = new View[0];
        private ArrayList<View>[] e;
        private int f;
        private ArrayList<View> g;
        private ArrayList<View> h;
        private SparseArrayCompat<View> i;

        public k() {
        }

        @SuppressLint({"NewApi"})
        private void f() {
            int length = this.d.length;
            int i = this.f;
            ArrayList<View>[] arrayListArr = this.e;
            int i2 = 0;
            for (int i3 = 0; i3 < i; i3++) {
                ArrayList<View> arrayList = arrayListArr[i3];
                int size = arrayList.size();
                int i4 = size - length;
                int i5 = size - 1;
                int i6 = 0;
                while (i6 < i4) {
                    AbsHListView.this.removeDetachedView(arrayList.remove(i5), false);
                    i6++;
                    i5--;
                }
            }
            if (this.i != null) {
                while (i2 < this.i.size()) {
                    if (!this.i.valueAt(i2).hasTransientState()) {
                        this.i.removeAt(i2);
                        i2--;
                    }
                    i2++;
                }
            }
        }

        public void a() {
            if (this.f == 1) {
                ArrayList<View> arrayList = this.g;
                int size = arrayList.size();
                for (int i = 0; i < size; i++) {
                    arrayList.get(i).forceLayout();
                }
            } else {
                int i2 = this.f;
                for (int i3 = 0; i3 < i2; i3++) {
                    ArrayList<View> arrayList2 = this.e[i3];
                    int size2 = arrayList2.size();
                    for (int i4 = 0; i4 < size2; i4++) {
                        arrayList2.get(i4).forceLayout();
                    }
                }
            }
            if (this.i != null) {
                int size3 = this.i.size();
                for (int i5 = 0; i5 < size3; i5++) {
                    this.i.valueAt(i5).forceLayout();
                }
            }
        }

        public void a(int i) {
            if (i < 1) {
                throw new IllegalArgumentException("Can't have a viewTypeCount < 1");
            }
            ArrayList<View>[] arrayListArr = new ArrayList[i];
            for (int i2 = 0; i2 < i; i2++) {
                arrayListArr[i2] = new ArrayList<>();
            }
            this.f = i;
            this.g = arrayListArr[0];
            this.e = arrayListArr;
        }

        public void a(int i, int i2) {
            if (this.d.length < i) {
                this.d = new View[i];
            }
            this.c = i2;
            View[] viewArr = this.d;
            for (int i3 = 0; i3 < i; i3++) {
                View childAt = AbsHListView.this.getChildAt(i3);
                f fVar = (f) childAt.getLayoutParams();
                if (fVar != null && fVar.a != -2) {
                    viewArr[i3] = childAt;
                }
            }
        }

        @SuppressLint({"NewApi"})
        public void a(View view, int i) {
            f fVar = (f) view.getLayoutParams();
            if (fVar == null) {
                return;
            }
            fVar.d = i;
            int i2 = fVar.a;
            boolean zHasTransientState = Build.VERSION.SDK_INT >= 16 ? view.hasTransientState() : false;
            if (b(i2) && !zHasTransientState) {
                view.onStartTemporaryDetach();
                (this.f == 1 ? this.g : this.e[i2]).add(view);
                if (Build.VERSION.SDK_INT >= 14) {
                    view.setAccessibilityDelegate(null);
                }
                if (this.b != null) {
                    this.b.a(view);
                    return;
                }
                return;
            }
            if (i2 != -2 || zHasTransientState) {
                if (this.h == null) {
                    this.h = new ArrayList<>();
                }
                this.h.add(view);
            }
            if (zHasTransientState) {
                if (this.i == null) {
                    this.i = new SparseArrayCompat<>();
                }
                view.onStartTemporaryDetach();
                this.i.put(i, view);
            }
        }

        public void b() {
            if (this.f == 1) {
                ArrayList<View> arrayList = this.g;
                int size = arrayList.size();
                for (int i = 0; i < size; i++) {
                    AbsHListView.this.removeDetachedView(arrayList.remove((size - 1) - i), false);
                }
            } else {
                int i2 = this.f;
                for (int i3 = 0; i3 < i2; i3++) {
                    ArrayList<View> arrayList2 = this.e[i3];
                    int size2 = arrayList2.size();
                    for (int i4 = 0; i4 < size2; i4++) {
                        AbsHListView.this.removeDetachedView(arrayList2.remove((size2 - 1) - i4), false);
                    }
                }
            }
            if (this.i != null) {
                this.i.clear();
            }
        }

        public boolean b(int i) {
            return i >= 0;
        }

        public View c(int i) {
            int i2 = i - this.c;
            View[] viewArr = this.d;
            if (i2 < 0 || i2 >= viewArr.length) {
                return null;
            }
            View view = viewArr[i2];
            viewArr[i2] = null;
            return view;
        }

        void c() {
            if (this.i != null) {
                this.i.clear();
            }
        }

        View d(int i) {
            int iIndexOfKey;
            if (this.i == null || (iIndexOfKey = this.i.indexOfKey(i)) < 0) {
                return null;
            }
            View viewValueAt = this.i.valueAt(iIndexOfKey);
            this.i.removeAt(iIndexOfKey);
            return viewValueAt;
        }

        public void d() {
            if (this.h == null) {
                return;
            }
            int size = this.h.size();
            for (int i = 0; i < size; i++) {
                AbsHListView.this.removeDetachedView(this.h.get(i), false);
            }
            this.h.clear();
        }

        View e(int i) {
            ArrayList<View> arrayList;
            if (this.f == 1) {
                arrayList = this.g;
            } else {
                int itemViewType = AbsHListView.this.j.getItemViewType(i);
                if (itemViewType < 0 || itemViewType >= this.e.length) {
                    return null;
                }
                arrayList = this.e[itemViewType];
            }
            return AbsHListView.a(arrayList, i);
        }

        @SuppressLint({"NewApi"})
        public void e() {
            View[] viewArr = this.d;
            boolean z = this.b != null;
            boolean z2 = this.f > 1;
            ArrayList<View> arrayList = this.g;
            for (int length = viewArr.length - 1; length >= 0; length--) {
                View view = viewArr[length];
                if (view != null) {
                    f fVar = (f) view.getLayoutParams();
                    int i = fVar.a;
                    viewArr[length] = null;
                    boolean zHasTransientState = Build.VERSION.SDK_INT >= 16 ? view.hasTransientState() : false;
                    if (!b(i) || zHasTransientState) {
                        if (i != -2 || zHasTransientState) {
                            AbsHListView.this.removeDetachedView(view, false);
                        }
                        if (zHasTransientState) {
                            if (this.i == null) {
                                this.i = new SparseArrayCompat<>();
                            }
                            this.i.put(this.c + length, view);
                        }
                    } else {
                        if (z2) {
                            arrayList = this.e[i];
                        }
                        view.onStartTemporaryDetach();
                        fVar.d = this.c + length;
                        arrayList.add(view);
                        if (Build.VERSION.SDK_INT >= 14) {
                            view.setAccessibilityDelegate(null);
                        }
                        if (z) {
                            this.b.a(view);
                        }
                    }
                }
            }
            f();
        }

        void f(int i) {
            if (this.f == 1) {
                ArrayList<View> arrayList = this.g;
                int size = arrayList.size();
                for (int i2 = 0; i2 < size; i2++) {
                    arrayList.get(i2).setDrawingCacheBackgroundColor(i);
                }
            } else {
                int i3 = this.f;
                for (int i4 = 0; i4 < i3; i4++) {
                    ArrayList<View> arrayList2 = this.e[i4];
                    int size2 = arrayList2.size();
                    for (int i5 = 0; i5 < size2; i5++) {
                        arrayList2.get(i5).setDrawingCacheBackgroundColor(i);
                    }
                }
            }
            for (View view : this.d) {
                if (view != null) {
                    view.setDrawingCacheBackgroundColor(i);
                }
            }
        }
    }

    public interface l {
        void a(View view);
    }

    public interface m {
        void a(Rect rect);
    }

    private class n {
        private int a;

        private n() {
        }

        public void a() {
            this.a = AbsHListView.this.getWindowAttachCount();
        }

        public boolean b() {
            return AbsHListView.this.hasWindowFocus() && AbsHListView.this.getWindowAttachCount() == this.a;
        }
    }

    public AbsHListView(Context context) {
        super(context);
        this.b = 0;
        this.h = 0;
        this.l = false;
        this.n = -1;
        this.o = new Rect();
        this.p = new k();
        this.q = 0;
        this.r = 0;
        this.s = 0;
        this.t = 0;
        this.u = new Rect();
        this.v = 0;
        this.F = -1;
        this.J = 0;
        this.ax = true;
        this.M = -1;
        this.az = null;
        this.aA = -1;
        this.aJ = 0;
        this.aO = 1.0f;
        this.P = new boolean[1];
        this.aP = -1;
        this.aU = 0;
        x();
    }

    public AbsHListView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, R.attr.hlv_absHListViewStyle);
    }

    public AbsHListView(Context context, AttributeSet attributeSet, int i2) {
        int i3;
        boolean z;
        boolean z2;
        boolean z3;
        int color;
        super(context, attributeSet, i2);
        int i4 = 0;
        this.b = 0;
        this.h = 0;
        this.l = false;
        this.n = -1;
        this.o = new Rect();
        this.p = new k();
        this.q = 0;
        this.r = 0;
        this.s = 0;
        this.t = 0;
        this.u = new Rect();
        this.v = 0;
        this.F = -1;
        this.J = 0;
        boolean z4 = true;
        this.ax = true;
        this.M = -1;
        Drawable drawable = null;
        this.az = null;
        this.aA = -1;
        this.aJ = 0;
        this.aO = 1.0f;
        this.P = new boolean[1];
        this.aP = -1;
        this.aU = 0;
        x();
        TypedArray typedArrayObtainStyledAttributes = context.getTheme().obtainStyledAttributes(attributeSet, i.b.AbsHListView, i2, 0);
        if (typedArrayObtainStyledAttributes != null) {
            drawable = typedArrayObtainStyledAttributes.getDrawable(0);
            z = typedArrayObtainStyledAttributes.getBoolean(1, false);
            z2 = typedArrayObtainStyledAttributes.getBoolean(6, false);
            z3 = typedArrayObtainStyledAttributes.getBoolean(2, true);
            int i5 = typedArrayObtainStyledAttributes.getInt(7, 0);
            color = typedArrayObtainStyledAttributes.getColor(3, 0);
            z4 = typedArrayObtainStyledAttributes.getBoolean(5, true);
            int i6 = typedArrayObtainStyledAttributes.getInt(4, 0);
            typedArrayObtainStyledAttributes.recycle();
            i3 = i6;
            i4 = i5;
        } else {
            i3 = 0;
            z = false;
            z2 = false;
            z3 = true;
            color = 0;
        }
        if (drawable != null) {
            setSelector(drawable);
        }
        this.l = z;
        setStackFromRight(z2);
        setScrollingCacheEnabled(z3);
        setTranscriptMode(i4);
        setCacheColorHint(color);
        setSmoothScrollbarEnabled(z4);
        setChoiceMode(i3);
    }

    private void A() {
        setSelector(getResources().getDrawable(android.R.drawable.list_selector_background));
    }

    private void B() {
        if (this.au == null) {
            this.au = VelocityTracker.obtain();
        } else {
            this.au.clear();
        }
    }

    private void C() {
        if (this.au == null) {
            this.au = VelocityTracker.obtain();
        }
    }

    private void D() {
        if (this.au != null) {
            this.au.recycle();
            this.au = null;
        }
    }

    private void E() {
        if (!this.L || this.y || this.a.a()) {
            return;
        }
        setChildrenDrawnWithCacheEnabled(true);
        setChildrenDrawingCacheEnabled(true);
        this.z = true;
        this.y = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        if (this.a.a()) {
            return;
        }
        if (this.aL == null) {
            this.aL = new Runnable() { // from class: it.sephiroth.android.library.widget.AbsHListView.2
                @Override // java.lang.Runnable
                public void run() {
                    if (AbsHListView.this.y) {
                        AbsHListView absHListView = AbsHListView.this;
                        AbsHListView.this.z = false;
                        absHListView.y = false;
                        AbsHListView.this.setChildrenDrawnWithCacheEnabled(false);
                        if ((AbsHListView.this.getPersistentDrawingCache() & 2) == 0) {
                            AbsHListView.this.setChildrenDrawingCacheEnabled(false);
                        }
                        if (AbsHListView.this.isAlwaysDrawnWithCacheEnabled()) {
                            return;
                        }
                        AbsHListView.this.invalidate();
                    }
                }
            };
        }
        post(this.aL);
    }

    private void G() {
        if (this.aQ != null) {
            this.aQ.finish();
            this.aR.finish();
        }
    }

    public static int a(Rect rect, Rect rect2, int i2) {
        int iWidth;
        int iHeight;
        int iWidth2;
        int iHeight2;
        if (i2 != 17) {
            if (i2 == 33) {
                iWidth = rect.left + (rect.width() / 2);
                iHeight = rect.top;
                iWidth2 = rect2.left + (rect2.width() / 2);
                iHeight2 = rect2.bottom;
            } else if (i2 == 66) {
                iWidth = rect.right;
                iHeight = rect.top + (rect.height() / 2);
                iWidth2 = rect2.left;
            } else if (i2 != 130) {
                switch (i2) {
                    case 1:
                    case 2:
                        iWidth = rect.right + (rect.width() / 2);
                        iHeight = rect.top + (rect.height() / 2);
                        iWidth2 = rect2.left + (rect2.width() / 2);
                        break;
                    default:
                        throw new IllegalArgumentException("direction must be one of {FOCUS_UP, FOCUS_DOWN, FOCUS_LEFT, FOCUS_RIGHT, FOCUS_FORWARD, FOCUS_BACKWARD}.");
                }
            } else {
                iWidth = rect.left + (rect.width() / 2);
                iHeight = rect.bottom;
                iWidth2 = rect2.left + (rect2.width() / 2);
                iHeight2 = rect2.top;
            }
            int i3 = iWidth2 - iWidth;
            int i4 = iHeight2 - iHeight;
            return (i4 * i4) + (i3 * i3);
        }
        iWidth = rect.left;
        iHeight = rect.top + (rect.height() / 2);
        iWidth2 = rect2.right;
        iHeight2 = rect2.top + (rect2.height() / 2);
        int i32 = iWidth2 - iWidth;
        int i42 = iHeight2 - iHeight;
        return (i42 * i42) + (i32 * i32);
    }

    static View a(ArrayList<View> arrayList, int i2) {
        int size = arrayList.size();
        if (size <= 0) {
            return null;
        }
        for (int i3 = 0; i3 < size; i3++) {
            View view = arrayList.get(i3);
            if (((f) view.getLayoutParams()).d == i2) {
                arrayList.remove(i3);
                return view;
            }
        }
        return arrayList.remove(size - 1);
    }

    private void a(int i2, int i3, int i4, int i5) {
        this.o.set(i2 - this.q, i3 - this.r, i4 + this.s, i5 + this.t);
    }

    private void a(Canvas canvas) {
        if (this.o.isEmpty()) {
            return;
        }
        Drawable drawable = this.m;
        drawable.setBounds(this.o);
        drawable.draw(canvas);
    }

    private void b(MotionEvent motionEvent) {
        int action = (motionEvent.getAction() & MotionEventCompat.ACTION_POINTER_INDEX_MASK) >> 8;
        if (motionEvent.getPointerId(action) == this.aP) {
            int i2 = action == 0 ? 1 : 0;
            this.D = (int) motionEvent.getX(i2);
            this.E = (int) motionEvent.getY(i2);
            this.H = 0;
            this.aP = motionEvent.getPointerId(i2);
        }
    }

    private boolean h(int i2) {
        int i3 = i2 - this.D;
        int iAbs = Math.abs(i3);
        boolean z = getScrollX() != 0;
        if (!z && iAbs <= this.aK) {
            return false;
        }
        E();
        if (z) {
            this.F = 5;
            this.H = 0;
        } else {
            this.F = 3;
            this.H = i3 > 0 ? this.aK : -this.aK;
        }
        Handler handler = getHandler();
        if (handler != null) {
            handler.removeCallbacks(this.aB);
        }
        setPressed(false);
        View childAt = getChildAt(this.A - this.V);
        if (childAt != null) {
            childAt.setPressed(false);
        }
        b(1);
        ViewParent parent = getParent();
        if (parent != null) {
            parent.requestDisallowInterceptTouchEvent(true);
        }
        i(i2);
        return true;
    }

    private void i(int i2) {
        int i3;
        int i4;
        int i5;
        int i6;
        int left;
        EdgeEffectCompat edgeEffectCompat;
        EdgeEffectCompat edgeEffectCompat2;
        ViewParent parent;
        int i7 = i2 - this.D;
        int i8 = i7 - this.H;
        int i9 = this.G != Integer.MIN_VALUE ? i2 - this.G : i8;
        if (this.F == 3) {
            if (i2 != this.G) {
                if (Math.abs(i7) > this.aK && (parent = getParent()) != null) {
                    parent.requestDisallowInterceptTouchEvent(true);
                }
                int childCount = this.A >= 0 ? this.A - this.V : getChildCount() / 2;
                View childAt = getChildAt(childCount);
                int left2 = childAt != null ? childAt.getLeft() : 0;
                boolean zC = i9 != 0 ? c(i8, i9) : false;
                View childAt2 = getChildAt(childCount);
                if (childAt2 != null) {
                    int left3 = childAt2.getLeft();
                    if (zC) {
                        int i10 = (-i9) - (left3 - left2);
                        overScrollBy(i10, 0, getScrollX(), 0, 0, 0, this.Q, 0, true);
                        if (Math.abs(this.Q) == Math.abs(getScrollX()) && this.au != null) {
                            this.au.clear();
                        }
                        int overScrollMode = getOverScrollMode();
                        if (overScrollMode == 0 || (overScrollMode == 1 && !z())) {
                            this.aU = 0;
                            this.F = 5;
                            if (i7 > 0) {
                                this.aQ.onPull(i10 / getWidth());
                                if (!this.aR.isFinished()) {
                                    edgeEffectCompat2 = this.aR;
                                    edgeEffectCompat2.onRelease();
                                }
                                invalidate();
                            } else if (i7 < 0) {
                                this.aR.onPull(i10 / getWidth());
                                if (!this.aQ.isFinished()) {
                                    edgeEffectCompat2 = this.aQ;
                                    edgeEffectCompat2.onRelease();
                                }
                                invalidate();
                            }
                        }
                    }
                    this.D = i2;
                }
                this.G = i2;
                return;
            }
            return;
        }
        if (this.F != 5 || i2 == this.G) {
            return;
        }
        int scrollX = getScrollX();
        int i11 = scrollX - i9;
        int i12 = i2 > this.G ? 1 : -1;
        if (this.aU == 0) {
            this.aU = i12;
        }
        int i13 = -i9;
        if ((i11 >= 0 || scrollX < 0) && (i11 <= 0 || scrollX > 0)) {
            i3 = i13;
            i4 = 0;
        } else {
            int i14 = -scrollX;
            i3 = i14;
            i4 = i9 + i14;
        }
        if (i3 != 0) {
            i5 = i4;
            int i15 = i3;
            i6 = i12;
            overScrollBy(i3, 0, getScrollX(), 0, 0, 0, this.Q, 0, true);
            int overScrollMode2 = getOverScrollMode();
            if (overScrollMode2 == 0 || (overScrollMode2 == 1 && !z())) {
                if (i7 > 0) {
                    this.aQ.onPull(i15 / getWidth());
                    if (!this.aR.isFinished()) {
                        edgeEffectCompat = this.aR;
                        edgeEffectCompat.onRelease();
                    }
                    invalidate();
                } else if (i7 < 0) {
                    this.aR.onPull(i15 / getWidth());
                    if (!this.aQ.isFinished()) {
                        edgeEffectCompat = this.aQ;
                        edgeEffectCompat.onRelease();
                    }
                    invalidate();
                }
            }
        } else {
            i5 = i4;
            i6 = i12;
        }
        if (i5 != 0) {
            if (getScrollX() != 0) {
                left = 0;
                this.a.a(0);
                k();
            } else {
                left = 0;
            }
            c(i5, i5);
            this.F = 3;
            int iF = f(i2);
            this.H = left;
            View childAt3 = getChildAt(iF - this.V);
            if (childAt3 != null) {
                left = childAt3.getLeft();
            }
            this.B = left;
            this.D = i2;
            this.A = iF;
        }
        this.G = i2;
        this.aU = i6;
    }

    private void x() {
        setClickable(true);
        setFocusableInTouchMode(true);
        setWillNotDraw(false);
        setAlwaysDrawnWithCacheEnabled(false);
        ViewConfiguration viewConfiguration = ViewConfiguration.get(getContext());
        this.aK = viewConfiguration.getScaledTouchSlop();
        this.aM = viewConfiguration.getScaledMinimumFlingVelocity();
        this.aN = viewConfiguration.getScaledMaximumFlingVelocity();
        this.Q = viewConfiguration.getScaledOverscrollDistance();
        this.R = viewConfiguration.getScaledOverflingDistance();
        this.a = it.sephiroth.android.library.a.a.a(this);
    }

    /* JADX WARN: Multi-variable type inference failed */
    private void y() {
        int i2 = this.V;
        int childCount = getChildCount();
        boolean z = Build.VERSION.SDK_INT >= 11;
        for (int i3 = 0; i3 < childCount; i3++) {
            View childAt = getChildAt(i3);
            int i4 = i2 + i3;
            if (childAt instanceof Checkable) {
                ((Checkable) childAt).setChecked(this.f.get(i4, false).booleanValue());
            } else if (z) {
                childAt.setActivated(this.f.get(i4, false).booleanValue());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean z() {
        int childCount = getChildCount();
        if (childCount == 0) {
            return true;
        }
        return childCount == this.ao && getChildAt(0).getLeft() >= this.u.left && getChildAt(childCount - 1).getRight() <= getWidth() - this.u.right;
    }

    public int a(int i2, int i3) {
        Rect rect = this.ay;
        if (rect == null) {
            this.ay = new Rect();
            rect = this.ay;
        }
        for (int childCount = getChildCount() - 1; childCount >= 0; childCount--) {
            View childAt = getChildAt(childCount);
            if (childAt.getVisibility() == 0) {
                childAt.getHitRect(rect);
                if (rect.contains(i2, i3)) {
                    return this.V + childCount;
                }
            }
        }
        return -1;
    }

    /* JADX WARN: Removed duplicated region for block: B:15:0x0035 A[PHI: r4
      0x0035: PHI (r4v2 android.view.View) = (r4v0 android.view.View), (r4v4 android.view.View) binds: [B:23:0x0057, B:14:0x0033] A[DONT_GENERATE, DONT_INLINE]] */
    @android.annotation.SuppressLint({"NewApi"})
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected android.view.View a(int r7, boolean[] r8) {
        /*
            r6 = this;
            r0 = 0
            r8[r0] = r0
            it.sephiroth.android.library.widget.AbsHListView$k r1 = r6.p
            android.view.View r1 = r1.d(r7)
            if (r1 == 0) goto Lc
            return r1
        Lc:
            it.sephiroth.android.library.widget.AbsHListView$k r1 = r6.p
            android.view.View r1 = r1.e(r7)
            r2 = 16
            r3 = 1
            if (r1 == 0) goto L41
            android.widget.ListAdapter r4 = r6.j
            android.view.View r4 = r4.getView(r7, r1, r6)
            int r5 = android.os.Build.VERSION.SDK_INT
            if (r5 < r2) goto L2a
            int r2 = r4.getImportantForAccessibility()
            if (r2 != 0) goto L2a
            r4.setImportantForAccessibility(r3)
        L2a:
            if (r4 == r1) goto L3b
            it.sephiroth.android.library.widget.AbsHListView$k r8 = r6.p
            r8.a(r1, r7)
            int r8 = r6.aH
            if (r8 == 0) goto L5a
        L35:
            int r8 = r6.aH
            r4.setDrawingCacheBackgroundColor(r8)
            goto L5a
        L3b:
            r8[r0] = r3
            r4.onFinishTemporaryDetach()
            goto L5a
        L41:
            android.widget.ListAdapter r8 = r6.j
            r0 = 0
            android.view.View r4 = r8.getView(r7, r0, r6)
            int r8 = android.os.Build.VERSION.SDK_INT
            if (r8 < r2) goto L55
            int r8 = r4.getImportantForAccessibility()
            if (r8 != 0) goto L55
            r4.setImportantForAccessibility(r3)
        L55:
            int r8 = r6.aH
            if (r8 == 0) goto L5a
            goto L35
        L5a:
            boolean r8 = r6.k
            if (r8 == 0) goto L81
            android.view.ViewGroup$LayoutParams r8 = r4.getLayoutParams()
            if (r8 != 0) goto L6b
            android.view.ViewGroup$LayoutParams r8 = r6.generateDefaultLayoutParams()
        L68:
            it.sephiroth.android.library.widget.AbsHListView$f r8 = (it.sephiroth.android.library.widget.AbsHListView.f) r8
            goto L76
        L6b:
            boolean r0 = r6.checkLayoutParams(r8)
            if (r0 != 0) goto L68
            android.view.ViewGroup$LayoutParams r8 = r6.generateLayoutParams(r8)
            goto L68
        L76:
            android.widget.ListAdapter r0 = r6.j
            long r0 = r0.getItemId(r7)
            r8.e = r0
            r4.setLayoutParams(r8)
        L81:
            android.view.accessibility.AccessibilityManager r7 = r6.aq
            boolean r7 = r7.isEnabled()
            if (r7 == 0) goto L94
            it.sephiroth.android.library.widget.AbsHListView$g r7 = r6.aY
            if (r7 != 0) goto L94
            it.sephiroth.android.library.widget.AbsHListView$g r7 = new it.sephiroth.android.library.widget.AbsHListView$g
            r7.<init>()
            r6.aY = r7
        L94:
            return r4
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.AbsHListView.a(int, boolean[]):android.view.View");
    }

    @Override // android.view.ViewGroup
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public f generateLayoutParams(AttributeSet attributeSet) {
        return new f(getContext(), attributeSet);
    }

    public void a() {
        if (this.f != null) {
            this.f.clear();
        }
        if (this.g != null) {
            this.g.clear();
        }
        this.e = 0;
    }

    public void a(int i2, int i3, boolean z) {
        if (this.av == null) {
            this.av = new e();
        }
        int i4 = this.V;
        int childCount = getChildCount();
        int i5 = i4 + childCount;
        int paddingLeft = getPaddingLeft();
        int width = getWidth() - getPaddingRight();
        if (i2 != 0 && this.ao != 0 && childCount != 0 && ((i4 != 0 || getChildAt(0).getLeft() != paddingLeft || i2 >= 0) && (i5 != this.ao || getChildAt(childCount - 1).getRight() != width || i2 <= 0))) {
            b(2);
            this.av.a(i2, i3, z);
        } else {
            this.av.b();
            if (this.I != null) {
                this.I.a();
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    protected void a(int i2, View view) {
        if (i2 != -1) {
            this.n = i2;
        }
        Rect rect = this.o;
        rect.set(view.getLeft(), view.getTop(), view.getRight(), view.getBottom());
        if (view instanceof m) {
            ((m) view).a(rect);
        }
        a(rect.left, rect.top, rect.right, rect.bottom);
        boolean z = this.aI;
        if (view.isEnabled() != z) {
            this.aI = !z;
            if (getSelectedItemPosition() != -1) {
                refreshDrawableState();
            }
        }
    }

    public void a(int i2, boolean z) {
        if (this.b == 0) {
            return;
        }
        if (Build.VERSION.SDK_INT >= 11 && z && this.b == 3 && this.c == null) {
            if (this.d == null || !((it.sephiroth.android.library.a.a.b) this.d).a()) {
                throw new IllegalStateException("AbsListView: attempted to start selection mode for CHOICE_MODE_MULTIPLE_MODAL but no choice mode callback was supplied. Call setMultiChoiceModeListener to set a callback.");
            }
            this.c = startActionMode((it.sephiroth.android.library.a.a.b) this.d);
        }
        if (this.b == 2 || (Build.VERSION.SDK_INT >= 11 && this.b == 3)) {
            boolean zBooleanValue = this.f.get(i2, false).booleanValue();
            this.f.put(i2, Boolean.valueOf(z));
            if (this.g != null && this.j.hasStableIds()) {
                if (z) {
                    this.g.put(this.j.getItemId(i2), Integer.valueOf(i2));
                } else {
                    this.g.delete(this.j.getItemId(i2));
                }
            }
            if (zBooleanValue != z) {
                this.e = z ? this.e + 1 : this.e - 1;
            }
            if (this.c != null) {
                ((it.sephiroth.android.library.a.a.b) this.d).a((ActionMode) this.c, i2, this.j.getItemId(i2), z);
            }
        } else {
            boolean z2 = this.g != null && this.j.hasStableIds();
            if (z || a(i2)) {
                this.f.clear();
                if (z2) {
                    this.g.clear();
                }
            }
            if (z) {
                this.f.put(i2, true);
                if (z2) {
                    this.g.put(this.j.getItemId(i2), Integer.valueOf(i2));
                }
                this.e = 1;
            } else if (this.f.size() == 0 || !this.f.valueAt(0).booleanValue()) {
                this.e = 0;
            }
        }
        if (this.af || this.at) {
            return;
        }
        this.aj = true;
        w();
        requestLayout();
    }

    protected abstract void a(boolean z);

    public boolean a(float f2, float f3, int i2) {
        int iA = a((int) f2, (int) f3);
        if (iA != -1) {
            long itemId = this.j.getItemId(iA);
            View childAt = getChildAt(iA - this.V);
            if (childAt != null) {
                this.az = b(childAt, iA, itemId);
                return super.showContextMenuForChild(this);
            }
        }
        return a(f2, f3, i2);
    }

    public boolean a(int i2) {
        if (this.b == 0 || this.f == null) {
            return false;
        }
        return this.f.get(i2, false).booleanValue();
    }

    @TargetApi(14)
    protected boolean a(MotionEvent motionEvent) {
        return Build.VERSION.SDK_INT >= 14 && (motionEvent.getButtonState() & 2) != 0 && a(motionEvent.getX(), motionEvent.getY(), motionEvent.getMetaState());
    }

    /* JADX WARN: Removed duplicated region for block: B:48:0x00e9  */
    @Override // it.sephiroth.android.library.widget.a
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean a(android.view.View r10, int r11, long r12) {
        /*
            Method dump skipped, instruction units count: 247
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.AbsHListView.a(android.view.View, int, long):boolean");
    }

    @Override // android.view.ViewGroup, android.view.View
    public void addTouchables(ArrayList<View> arrayList) {
        int childCount = getChildCount();
        int i2 = this.V;
        ListAdapter listAdapter = this.j;
        if (listAdapter == null) {
            return;
        }
        for (int i3 = 0; i3 < childCount; i3++) {
            View childAt = getChildAt(i3);
            if (listAdapter.isEnabled(i2 + i3)) {
                arrayList.add(childAt);
            }
            childAt.addTouchables(arrayList);
        }
    }

    ContextMenu.ContextMenuInfo b(View view, int i2, long j2) {
        return new a.ContextMenuContextMenuInfoC0085a(view, i2, j2);
    }

    protected void b() {
        if (this.aw != null) {
            this.aw.a(this, this.V, getChildCount(), this.ao);
        }
        onScrollChanged(0, 0, 0, 0);
    }

    void b(int i2) {
        if (i2 == this.aJ || this.aw == null) {
            return;
        }
        this.aJ = i2;
        this.aw.a(this, i2);
    }

    public void b(int i2, int i3) {
        a(i2, i3, false);
    }

    void c() {
        if (getChildCount() > 0) {
            d();
            requestLayout();
            invalidate();
        }
    }

    public void c(int i2) {
        if (this.I == null) {
            this.I = new j();
        }
        this.I.a(i2);
    }

    boolean c(int i2, int i3) {
        int i4;
        int i5;
        int i6;
        int childCount = getChildCount();
        if (childCount == 0) {
            return true;
        }
        int left = getChildAt(0).getLeft();
        int i7 = childCount - 1;
        int right = getChildAt(i7).getRight();
        Rect rect = this.u;
        int i8 = 0 - left;
        int width = right - (getWidth() - 0);
        int width2 = (getWidth() - getPaddingRight()) - getPaddingLeft();
        int iMax = i2 < 0 ? Math.max(-(width2 - 1), i2) : Math.min(width2 - 1, i2);
        int iMax2 = i3 < 0 ? Math.max(-(width2 - 1), i3) : Math.min(width2 - 1, i3);
        int i9 = this.V;
        this.aS = i9 == 0 ? left - rect.left : this.aS + iMax2;
        int i10 = i9 + childCount;
        this.aT = i10 == this.ao ? rect.right + right : this.aT + iMax2;
        boolean z = i9 == 0 && left >= rect.left && iMax2 >= 0;
        boolean z2 = i10 == this.ao && right <= getWidth() - rect.right && iMax2 <= 0;
        if (z || z2) {
            return iMax2 != 0;
        }
        boolean z3 = iMax2 < 0;
        boolean zIsInTouchMode = isInTouchMode();
        if (zIsInTouchMode) {
            l();
        }
        int headerViewsCount = getHeaderViewsCount();
        int footerViewsCount = this.ao - getFooterViewsCount();
        if (z3) {
            int i11 = -iMax2;
            int i12 = 0;
            i5 = 0;
            while (i12 < childCount) {
                View childAt = getChildAt(i12);
                if (childAt.getRight() >= i11) {
                    break;
                }
                i5++;
                int i13 = i9 + i12;
                if (i13 < headerViewsCount || i13 >= footerViewsCount) {
                    i6 = childCount;
                } else {
                    i6 = childCount;
                    this.p.a(childAt, i13);
                }
                i12++;
                childCount = i6;
            }
            i4 = 0;
        } else {
            int width3 = getWidth() - iMax2;
            int i14 = i7;
            i4 = 0;
            i5 = 0;
            while (i14 >= 0) {
                View childAt2 = getChildAt(i14);
                if (childAt2.getLeft() <= width3) {
                    break;
                }
                i5++;
                int i15 = i9 + i14;
                if (i15 >= headerViewsCount && i15 < footerViewsCount) {
                    this.p.a(childAt2, i15);
                }
                int i16 = i14;
                i14--;
                i4 = i16;
            }
        }
        this.C = this.B + iMax;
        this.at = true;
        if (i5 > 0) {
            detachViewsFromParent(i4, i5);
            this.p.d();
        }
        if (!awakenScrollBars()) {
            invalidate();
        }
        d(iMax2);
        if (z3) {
            this.V += i5;
        }
        int iAbs = Math.abs(iMax2);
        if (i8 < iAbs || width < iAbs) {
            a(z3);
        }
        if (!zIsInTouchMode && this.am != -1) {
            int i17 = this.am - this.V;
            if (i17 >= 0 && i17 < getChildCount()) {
                a(this.am, getChildAt(i17));
            }
        } else if (this.n != -1) {
            int i18 = this.n - this.V;
            if (i18 >= 0 && i18 < getChildCount()) {
                a(-1, getChildAt(i18));
            }
        } else {
            this.o.setEmpty();
        }
        this.at = false;
        b();
        return false;
    }

    boolean c(View view, int i2, long j2) {
        if (Build.VERSION.SDK_INT < 11 || this.b != 3) {
            boolean zA = this.ai != null ? this.ai.a(this, view, i2, j2) : false;
            if (!zA) {
                this.az = b(view, i2, j2);
                zA = super.showContextMenuForChild(this);
            }
            if (zA) {
                performHapticFeedback(0);
            }
            return zA;
        }
        if (this.c == null) {
            ActionMode actionModeStartActionMode = startActionMode((it.sephiroth.android.library.a.a.b) this.d);
            this.c = actionModeStartActionMode;
            if (actionModeStartActionMode != null) {
                a(i2, true);
                performHapticFeedback(0);
            }
        }
        return true;
    }

    @Override // android.view.View
    public boolean checkInputConnectionProxy(View view) {
        return false;
    }

    @Override // android.view.ViewGroup
    protected boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof f;
    }

    @Override // android.view.View
    protected int computeHorizontalScrollExtent() {
        int childCount = getChildCount();
        if (childCount <= 0) {
            return 0;
        }
        if (!this.ax) {
            return 1;
        }
        int i2 = childCount * 100;
        View childAt = getChildAt(0);
        int left = childAt.getLeft();
        int width = childAt.getWidth();
        if (width > 0) {
            i2 += (left * 100) / width;
        }
        View childAt2 = getChildAt(childCount - 1);
        int right = childAt2.getRight();
        int width2 = childAt2.getWidth();
        return width2 > 0 ? i2 - (((right - getWidth()) * 100) / width2) : i2;
    }

    @Override // android.view.View
    protected int computeHorizontalScrollOffset() {
        int i2 = this.V;
        int childCount = getChildCount();
        if (i2 >= 0 && childCount > 0) {
            if (!this.ax) {
                int i3 = this.ao;
                return (int) (i2 + (childCount * ((i2 != 0 ? i2 + childCount == i3 ? i3 : (childCount / 2) + i2 : 0) / i3)));
            }
            View childAt = getChildAt(0);
            int left = childAt.getLeft();
            int width = childAt.getWidth();
            if (width > 0) {
                return Math.max(((i2 * 100) - ((left * 100) / width)) + ((int) ((getScrollX() / getWidth()) * this.ao * 100.0f)), 0);
            }
        }
        return 0;
    }

    @Override // android.view.View
    protected int computeHorizontalScrollRange() {
        if (!this.ax) {
            return this.ao;
        }
        int iMax = Math.max(this.ao * 100, 0);
        return getScrollX() != 0 ? iMax + Math.abs((int) ((getScrollX() / getWidth()) * this.ao * 100.0f)) : iMax;
    }

    protected void d() {
        removeAllViewsInLayout();
        this.V = 0;
        this.aj = false;
        this.O = null;
        this.ad = false;
        this.bc = null;
        this.ar = -1;
        this.as = Long.MIN_VALUE;
        setSelectedPositionInt(-1);
        setNextSelectedPositionInt(-1);
        this.J = 0;
        this.n = -1;
        this.o.setEmpty();
        invalidate();
    }

    public void d(int i2) {
        int childCount = getChildCount();
        for (int i3 = 0; i3 < childCount; i3++) {
            getChildAt(i3).offsetLeftAndRight(i2);
        }
    }

    protected void d(int i2, int i3) {
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchDraw(Canvas canvas) {
        boolean z = this.l;
        if (!z) {
            a(canvas);
        }
        super.dispatchDraw(canvas);
        if (z) {
            a(canvas);
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchSetPressed(boolean z) {
    }

    @Override // android.view.View
    public void draw(Canvas canvas) {
        super.draw(canvas);
        if (this.aQ != null) {
            int scrollX = getScrollX();
            if (!this.aQ.isFinished()) {
                int iSave = canvas.save();
                int height = (getHeight() - (this.u.top + this.aW)) - (this.u.bottom + this.aX);
                int iMin = Math.min(0, this.aS + scrollX);
                canvas.rotate(-90.0f);
                canvas.translate((-getHeight()) + r2, iMin);
                this.aQ.setSize(height, height);
                if (this.aQ.draw(canvas)) {
                    invalidate();
                }
                canvas.restoreToCount(iSave);
            }
            if (this.aR.isFinished()) {
                return;
            }
            int iSave2 = canvas.save();
            int height2 = (getHeight() - (this.u.left + this.aW)) - (this.u.right + this.aX);
            int iMax = Math.max(getWidth(), scrollX + this.aT);
            canvas.rotate(90.0f);
            canvas.translate(-r2, -iMax);
            this.aR.setSize(height2, height2);
            if (this.aR.draw(canvas)) {
                invalidate();
            }
            canvas.restoreToCount(iSave2);
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        j();
    }

    protected abstract int e(int i2);

    protected void e() {
    }

    protected int f(int i2) {
        if (getChildCount() == 0) {
            return -1;
        }
        int iE = e(i2);
        return iE != -1 ? iE : (this.V + r0) - 1;
    }

    protected void f() {
        if (this.w != null) {
            boolean z = this.V > 0;
            if (!z && getChildCount() > 0) {
                z = getChildAt(0).getLeft() < this.u.left;
            }
            this.w.setVisibility(z ? 0 : 4);
        }
        if (this.x != null) {
            int childCount = getChildCount();
            boolean z2 = this.V + childCount < this.ao;
            if (!z2 && childCount > 0) {
                z2 = getChildAt(childCount - 1).getRight() > getRight() - this.u.right;
            }
            this.x.setVisibility(z2 ? 0 : 4);
        }
    }

    boolean g() {
        switch (this.F) {
            case 1:
            case 2:
                return true;
            default:
                return false;
        }
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateDefaultLayoutParams() {
        return new f(-2, -1, 0);
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return new f(layoutParams);
    }

    @ViewDebug.ExportedProperty(category = "drawing")
    public int getCacheColorHint() {
        return this.aH;
    }

    public int getCheckedItemCount() {
        return this.e;
    }

    public long[] getCheckedItemIds() {
        if (this.b == 0 || this.g == null || this.j == null) {
            return new long[0];
        }
        LongSparseArray<Integer> longSparseArray = this.g;
        int size = longSparseArray.size();
        long[] jArr = new long[size];
        for (int i2 = 0; i2 < size; i2++) {
            jArr[i2] = longSparseArray.keyAt(i2);
        }
        return jArr;
    }

    public int getCheckedItemPosition() {
        if (this.b == 1 && this.f != null && this.f.size() == 1) {
            return this.f.keyAt(0);
        }
        return -1;
    }

    public SparseArrayCompat<Boolean> getCheckedItemPositions() {
        if (this.b != 0) {
            return this.f;
        }
        return null;
    }

    public int getChoiceMode() {
        return this.b;
    }

    @Override // android.view.View
    protected ContextMenu.ContextMenuInfo getContextMenuInfo() {
        return this.az;
    }

    @Override // android.view.View
    public void getFocusedRect(Rect rect) {
        View selectedView = getSelectedView();
        if (selectedView == null || selectedView.getParent() != this) {
            super.getFocusedRect(rect);
        } else {
            selectedView.getFocusedRect(rect);
            offsetDescendantRectToMyCoords(selectedView, rect);
        }
    }

    protected int getFooterViewsCount() {
        return 0;
    }

    protected int getHeaderViewsCount() {
        return 0;
    }

    protected float getHorizontalScrollFactor() {
        if (this.bd == 0.0f) {
            TypedValue typedValue = new TypedValue();
            if (!getContext().getTheme().resolveAttribute(R.attr.hlv_listPreferredItemWidth, typedValue, true)) {
                throw new IllegalStateException("Expected theme to define hlv_listPreferredItemWidth.");
            }
            this.bd = typedValue.getDimension(getContext().getResources().getDisplayMetrics());
        }
        return this.bd;
    }

    @Override // android.view.View
    protected int getHorizontalScrollbarHeight() {
        return super.getHorizontalScrollbarHeight();
    }

    @Override // android.view.View
    protected float getLeftFadingEdgeStrength() {
        int childCount = getChildCount();
        float leftFadingEdgeStrength = super.getLeftFadingEdgeStrength();
        if (childCount == 0) {
            return leftFadingEdgeStrength;
        }
        if (this.V > 0) {
            return 1.0f;
        }
        return getChildAt(0).getLeft() < getPaddingLeft() ? (-(r0 - getPaddingLeft())) / getHorizontalFadingEdgeLength() : leftFadingEdgeStrength;
    }

    public int getListPaddingBottom() {
        return this.u.bottom;
    }

    public int getListPaddingLeft() {
        return this.u.left;
    }

    public int getListPaddingRight() {
        return this.u.right;
    }

    public int getListPaddingTop() {
        return this.u.top;
    }

    @Override // android.view.View
    protected float getRightFadingEdgeStrength() {
        int childCount = getChildCount();
        float rightFadingEdgeStrength = super.getRightFadingEdgeStrength();
        if (childCount == 0) {
            return rightFadingEdgeStrength;
        }
        if ((this.V + childCount) - 1 < this.ao - 1) {
            return 1.0f;
        }
        return getChildAt(childCount - 1).getRight() > getWidth() - getPaddingRight() ? ((r0 - r2) + getPaddingRight()) / getHorizontalFadingEdgeLength() : rightFadingEdgeStrength;
    }

    @Override // it.sephiroth.android.library.widget.a
    @ViewDebug.ExportedProperty
    public View getSelectedView() {
        if (this.ao <= 0 || this.am < 0) {
            return null;
        }
        return getChildAt(this.am - this.V);
    }

    public Drawable getSelector() {
        return this.m;
    }

    @Override // android.view.View
    public int getSolidColor() {
        return this.aH;
    }

    public int getTranscriptMode() {
        return this.aG;
    }

    protected boolean h() {
        return (hasFocus() && !isInTouchMode()) || g();
    }

    protected void i() {
        if (isEnabled() && isClickable()) {
            Drawable drawable = this.m;
            Rect rect = this.o;
            if (drawable != null) {
                if ((isFocused() || g()) && !rect.isEmpty()) {
                    View childAt = getChildAt(this.am - this.V);
                    if (childAt != null) {
                        if (childAt.hasFocusable()) {
                            return;
                        } else {
                            childAt.setPressed(true);
                        }
                    }
                    setPressed(true);
                    boolean zIsLongClickable = isLongClickable();
                    Drawable current = drawable.getCurrent();
                    if (current != null && (current instanceof TransitionDrawable)) {
                        if (zIsLongClickable) {
                            ((TransitionDrawable) current).startTransition(ViewConfiguration.getLongPressTimeout());
                        } else {
                            ((TransitionDrawable) current).resetTransition();
                        }
                    }
                    if (!zIsLongClickable || this.aj) {
                        return;
                    }
                    if (this.aD == null) {
                        this.aD = new b();
                    }
                    this.aD.a();
                    postDelayed(this.aD, ViewConfiguration.getLongPressTimeout());
                }
            }
        }
    }

    void j() {
        Drawable drawable;
        int[] drawableState;
        if (this.m != null) {
            if (h()) {
                drawable = this.m;
                drawableState = getDrawableState();
            } else {
                drawable = this.m;
                drawableState = U;
            }
            drawable.setState(drawableState);
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    @TargetApi(11)
    public void jumpDrawablesToCurrentState() {
        super.jumpDrawablesToCurrentState();
        if (this.m != null) {
            this.m.jumpToCurrentState();
        }
    }

    @TargetApi(11)
    protected void k() {
        if (this.a.a() && (getParent() instanceof View)) {
            ((View) getParent()).invalidate();
        }
    }

    protected void l() {
        if (this.am != -1) {
            if (this.h != 4) {
                this.M = this.am;
            }
            if (this.ak >= 0 && this.ak != this.am) {
                this.M = this.ak;
            }
            setSelectedPositionInt(-1);
            setNextSelectedPositionInt(-1);
            this.J = 0;
        }
    }

    protected int m() {
        int i2 = this.am;
        if (i2 < 0) {
            i2 = this.M;
        }
        return Math.min(Math.max(0, i2), this.ao - 1);
    }

    protected boolean n() {
        if (this.am >= 0 || !o()) {
            return false;
        }
        j();
        return true;
    }

    /* JADX WARN: Removed duplicated region for block: B:45:0x00b7  */
    /* JADX WARN: Removed duplicated region for block: B:51:0x00dc  */
    /* JADX WARN: Removed duplicated region for block: B:54:0x00e2 A[ORIG_RETURN, RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:60:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    boolean o() {
        /*
            Method dump skipped, instruction units count: 228
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.AbsHListView.o():boolean");
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        getViewTreeObserver().addOnTouchModeChangeListener(this);
        if (this.j != null && this.i == null) {
            this.i = new a();
            this.j.registerDataSetObserver(this.i);
            this.aj = true;
            this.ap = this.ao;
            this.ao = this.j.getCount();
        }
        this.S = true;
    }

    @Override // android.view.ViewGroup, android.view.View
    @SuppressLint({"Override"})
    protected int[] onCreateDrawableState(int i2) {
        if (this.aI) {
            return super.onCreateDrawableState(i2);
        }
        int i3 = ENABLED_STATE_SET[0];
        int[] iArrOnCreateDrawableState = super.onCreateDrawableState(i2 + 1);
        int length = iArrOnCreateDrawableState.length - 1;
        while (true) {
            if (length < 0) {
                length = -1;
                break;
            }
            if (iArrOnCreateDrawableState[length] == i3) {
                break;
            }
            length--;
        }
        if (length >= 0) {
            System.arraycopy(iArrOnCreateDrawableState, length + 1, iArrOnCreateDrawableState, length, (iArrOnCreateDrawableState.length - length) - 1);
        }
        return iArrOnCreateDrawableState;
    }

    @Override // android.view.View
    public InputConnection onCreateInputConnection(EditorInfo editorInfo) {
        return null;
    }

    @Override // it.sephiroth.android.library.widget.a, android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        this.p.b();
        getViewTreeObserver().removeOnTouchModeChangeListener(this);
        if (this.j != null && this.i != null) {
            this.j.unregisterDataSetObserver(this.i);
            this.i = null;
        }
        if (this.av != null) {
            removeCallbacks(this.av);
        }
        if (this.I != null) {
            this.I.a();
        }
        if (this.aL != null) {
            removeCallbacks(this.aL);
        }
        if (this.aE != null) {
            removeCallbacks(this.aE);
        }
        if (this.aF != null) {
            removeCallbacks(this.aF);
            this.aF = null;
        }
        this.S = false;
    }

    @Override // android.view.View
    protected void onFocusChanged(boolean z, int i2, Rect rect) {
        super.onFocusChanged(z, i2, rect);
        if (!z || this.am >= 0 || isInTouchMode()) {
            return;
        }
        if (!this.S && this.j != null) {
            this.aj = true;
            this.ap = this.ao;
            this.ao = this.j.getCount();
        }
        o();
    }

    @Override // android.view.View
    @TargetApi(12)
    public boolean onGenericMotionEvent(MotionEvent motionEvent) {
        if ((motionEvent.getSource() & 2) != 0 && motionEvent.getAction() == 8 && this.F == -1) {
            float axisValue = motionEvent.getAxisValue(10);
            if (axisValue != 0.0f) {
                int horizontalScrollFactor = (int) (axisValue * getHorizontalScrollFactor());
                if (!c(horizontalScrollFactor, horizontalScrollFactor)) {
                    return true;
                }
            }
        }
        return super.onGenericMotionEvent(motionEvent);
    }

    @Override // it.sephiroth.android.library.widget.a, android.view.View
    @TargetApi(14)
    public void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        super.onInitializeAccessibilityEvent(accessibilityEvent);
        accessibilityEvent.setClassName(AbsHListView.class.getName());
    }

    @Override // it.sephiroth.android.library.widget.a, android.view.View
    @SuppressLint({"Override"})
    @TargetApi(14)
    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo) {
        super.onInitializeAccessibilityNodeInfo(accessibilityNodeInfo);
        accessibilityNodeInfo.setClassName(AbsHListView.class.getName());
        if (isEnabled()) {
            if (getFirstVisiblePosition() > 0) {
                accessibilityNodeInfo.addAction(8192);
            }
            if (getLastVisiblePosition() < getCount() - 1) {
                accessibilityNodeInfo.addAction(4096);
            }
        }
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        int action = motionEvent.getAction();
        if (this.I != null) {
            this.I.a();
        }
        if (!this.S) {
            return false;
        }
        int i2 = action & 255;
        if (i2 != 6) {
            switch (i2) {
                case 0:
                    int i3 = this.F;
                    if (i3 == 6 || i3 == 5) {
                        this.H = 0;
                        return true;
                    }
                    int x = (int) motionEvent.getX();
                    int y = (int) motionEvent.getY();
                    this.aP = motionEvent.getPointerId(0);
                    int iE = e(x);
                    if (i3 != 4 && iE >= 0) {
                        this.B = getChildAt(iE - this.V).getLeft();
                        this.D = x;
                        this.E = y;
                        this.A = iE;
                        this.F = 0;
                        F();
                    }
                    this.G = Integer.MIN_VALUE;
                    B();
                    this.au.addMovement(motionEvent);
                    if (i3 == 4) {
                        return true;
                    }
                    break;
                case 1:
                case 3:
                    this.F = -1;
                    this.aP = -1;
                    D();
                    b(0);
                    return false;
                case 2:
                    if (this.F != 0) {
                        return false;
                    }
                    int iFindPointerIndex = motionEvent.findPointerIndex(this.aP);
                    if (iFindPointerIndex == -1) {
                        this.aP = motionEvent.getPointerId(0);
                        iFindPointerIndex = 0;
                    }
                    int x2 = (int) motionEvent.getX(iFindPointerIndex);
                    C();
                    this.au.addMovement(motionEvent);
                    if (h(x2)) {
                        return true;
                    }
                    break;
                default:
                    return false;
            }
        } else {
            b(motionEvent);
        }
        return false;
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i2, KeyEvent keyEvent) {
        return false;
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i2, KeyEvent keyEvent) {
        if (i2 == 23 || i2 == 66) {
            if (!isEnabled()) {
                return true;
            }
            if (isClickable() && isPressed() && this.am >= 0 && this.j != null && this.am < this.j.getCount()) {
                View childAt = getChildAt(this.am - this.V);
                if (childAt != null) {
                    a(childAt, this.am, this.an);
                    childAt.setPressed(false);
                }
                setPressed(false);
                return true;
            }
        }
        return super.onKeyUp(i2, keyEvent);
    }

    @Override // it.sephiroth.android.library.widget.a, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i2, int i3, int i4, int i5) {
        super.onLayout(z, i2, i3, i4, i5);
        this.af = true;
        if (z) {
            int childCount = getChildCount();
            for (int i6 = 0; i6 < childCount; i6++) {
                getChildAt(i6).forceLayout();
            }
            this.p.a();
        }
        e();
        this.af = false;
        this.N = (i4 - i2) / 3;
    }

    @Override // android.view.View
    protected void onMeasure(int i2, int i3) {
        if (this.m == null) {
            A();
        }
        Rect rect = this.u;
        rect.left = this.q + getPaddingLeft();
        rect.top = this.r + getPaddingTop();
        rect.right = this.s + getPaddingRight();
        rect.bottom = this.t + getPaddingBottom();
        if (this.aG == 1) {
            int childCount = getChildCount();
            int width = getWidth() - getPaddingRight();
            View childAt = getChildAt(childCount - 1);
            this.aV = this.V + childCount >= this.bb && (childAt != null ? childAt.getRight() : width) <= width;
        }
    }

    @Override // android.view.View
    protected void onOverScrolled(int i2, int i3, boolean z, boolean z2) {
        if (getScrollX() != i2) {
            onScrollChanged(i2, getScrollY(), getScrollX(), getScrollY());
            this.a.a(i2);
            k();
            awakenScrollBars();
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x0051  */
    /* JADX WARN: Removed duplicated region for block: B:14:0x0059  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void onRestoreInstanceState(android.os.Parcelable r7) {
        /*
            r6 = this;
            it.sephiroth.android.library.widget.AbsHListView$SavedState r7 = (it.sephiroth.android.library.widget.AbsHListView.SavedState) r7
            android.os.Parcelable r0 = r7.getSuperState()
            super.onRestoreInstanceState(r0)
            r0 = 1
            r6.aj = r0
            int r1 = r7.e
            long r1 = (long) r1
            r6.ac = r1
            long r1 = r7.a
            r3 = 0
            int r5 = (r1 > r3 ? 1 : (r1 == r3 ? 0 : -1))
            if (r5 < 0) goto L2d
            r6.ad = r0
            r6.bc = r7
            long r0 = r7.a
            r6.ab = r0
            int r0 = r7.d
            r6.aa = r0
            int r0 = r7.c
            r6.W = r0
            r0 = 0
        L2a:
            r6.ae = r0
            goto L4d
        L2d:
            long r1 = r7.b
            int r5 = (r1 > r3 ? 1 : (r1 == r3 ? 0 : -1))
            if (r5 < 0) goto L4d
            r1 = -1
            r6.setSelectedPositionInt(r1)
            r6.setNextSelectedPositionInt(r1)
            r6.n = r1
            r6.ad = r0
            r6.bc = r7
            long r1 = r7.b
            r6.ab = r1
            int r1 = r7.d
            r6.aa = r1
            int r1 = r7.c
            r6.W = r1
            goto L2a
        L4d:
            android.support.v4.util.SparseArrayCompat<java.lang.Boolean> r0 = r7.i
            if (r0 == 0) goto L55
            android.support.v4.util.SparseArrayCompat<java.lang.Boolean> r0 = r7.i
            r6.f = r0
        L55:
            android.support.v4.util.LongSparseArray<java.lang.Integer> r0 = r7.j
            if (r0 == 0) goto L5d
            android.support.v4.util.LongSparseArray<java.lang.Integer> r0 = r7.j
            r6.g = r0
        L5d:
            int r0 = r7.h
            r6.e = r0
            int r0 = android.os.Build.VERSION.SDK_INT
            r1 = 11
            if (r0 < r1) goto L7e
            boolean r7 = r7.g
            if (r7 == 0) goto L7e
            int r7 = r6.b
            r0 = 3
            if (r7 != r0) goto L7e
            java.lang.Object r7 = r6.d
            if (r7 == 0) goto L7e
            java.lang.Object r7 = r6.d
            it.sephiroth.android.library.a.a.b r7 = (it.sephiroth.android.library.a.a.b) r7
            android.view.ActionMode r7 = r6.startActionMode(r7)
            r6.c = r7
        L7e:
            r6.requestLayout()
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.AbsHListView.onRestoreInstanceState(android.os.Parcelable):void");
    }

    /* JADX WARN: Removed duplicated region for block: B:31:0x00b5  */
    /* JADX WARN: Removed duplicated region for block: B:40:0x00d4  */
    /* JADX WARN: Removed duplicated region for block: B:46:0x00bc A[EXC_TOP_SPLITTER, SYNTHETIC] */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.os.Parcelable onSaveInstanceState() {
        /*
            Method dump skipped, instruction units count: 250
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.AbsHListView.onSaveInstanceState():android.os.Parcelable");
    }

    @Override // android.view.View
    protected void onSizeChanged(int i2, int i3, int i4, int i5) {
        if (getChildCount() > 0) {
            this.aj = true;
            w();
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:94:0x01a7  */
    @Override // android.view.View
    @android.annotation.SuppressLint({"Override"})
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onTouchEvent(android.view.MotionEvent r12) {
        /*
            Method dump skipped, instruction units count: 960
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.AbsHListView.onTouchEvent(android.view.MotionEvent):boolean");
    }

    @Override // android.view.ViewTreeObserver.OnTouchModeChangeListener
    public void onTouchModeChanged(boolean z) {
        if (z) {
            l();
            if (getWidth() > 0 && getChildCount() > 0) {
                e();
            }
            j();
            return;
        }
        int i2 = this.F;
        if (i2 == 5 || i2 == 6) {
            if (this.av != null) {
                this.av.b();
            }
            if (this.I != null) {
                this.I.a();
            }
            if (getScrollX() != 0) {
                this.a.a(0);
                G();
                invalidate();
            }
        }
    }

    @Override // android.view.View
    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        int i2 = !isInTouchMode() ? 1 : 0;
        if (!z) {
            setChildrenDrawingCacheEnabled(false);
            if (this.av != null) {
                removeCallbacks(this.av);
                this.av.b();
                if (this.I != null) {
                    this.I.a();
                }
                if (getScrollX() != 0) {
                    this.a.a(0);
                    G();
                    invalidate();
                }
            }
            if (i2 == 1) {
                this.M = this.am;
            }
        } else if (i2 != this.aA && this.aA != -1) {
            if (i2 == 1) {
                o();
            } else {
                l();
                this.h = 0;
                e();
            }
        }
        this.aA = i2;
    }

    void p() {
        boolean z;
        this.f.clear();
        int i2 = 0;
        boolean z2 = false;
        while (i2 < this.g.size()) {
            long jKeyAt = this.g.keyAt(i2);
            int iIntValue = this.g.valueAt(i2).intValue();
            if (jKeyAt != this.j.getItemId(iIntValue)) {
                int iMax = Math.max(0, iIntValue - 20);
                int iMin = Math.min(iIntValue + 20, this.ao);
                while (true) {
                    if (iMax >= iMin) {
                        z = false;
                        break;
                    } else {
                        if (jKeyAt == this.j.getItemId(iMax)) {
                            this.f.put(iMax, true);
                            this.g.setValueAt(i2, Integer.valueOf(iMax));
                            z = true;
                            break;
                        }
                        iMax++;
                    }
                }
                if (!z) {
                    this.g.delete(jKeyAt);
                    i2--;
                    this.e--;
                    if (Build.VERSION.SDK_INT > 11 && this.c != null && this.d != null) {
                        ((it.sephiroth.android.library.a.a.b) this.d).a((ActionMode) this.c, iIntValue, jKeyAt, false);
                    }
                    z2 = true;
                }
            } else {
                this.f.put(iIntValue, true);
            }
            i2++;
        }
        if (!z2 || this.c == null || Build.VERSION.SDK_INT <= 11) {
            return;
        }
        ((ActionMode) this.c).invalidate();
    }

    @Override // android.view.View
    @TargetApi(16)
    public boolean performAccessibilityAction(int i2, Bundle bundle) {
        int width;
        if (super.performAccessibilityAction(i2, bundle)) {
            return true;
        }
        if (i2 != 4096) {
            if (i2 != 8192 || !isEnabled() || this.V <= 0) {
                return false;
            }
            width = -((getWidth() - this.u.left) - this.u.right);
        } else {
            if (!isEnabled() || getLastVisiblePosition() >= getCount() - 1) {
                return false;
            }
            width = (getWidth() - this.u.left) - this.u.right;
        }
        b(width, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
        return true;
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // it.sephiroth.android.library.widget.a
    protected void q() {
        int i2 = this.ao;
        int i3 = this.bb;
        this.bb = this.ao;
        if (this.b != 0 && this.j != null && this.j.hasStableIds()) {
            p();
        }
        this.p.c();
        if (i2 > 0) {
            if (this.ad) {
                this.ad = false;
                this.bc = null;
                if (this.aG == 2) {
                    this.h = 3;
                    return;
                }
                if (this.aG == 1) {
                    if (this.aV) {
                        this.aV = false;
                        this.h = 3;
                        return;
                    }
                    int childCount = getChildCount();
                    int width = getWidth() - getPaddingRight();
                    View childAt = getChildAt(childCount - 1);
                    int bottom = childAt != null ? childAt.getBottom() : width;
                    if (this.V + childCount >= i3 && bottom <= width) {
                        this.h = 3;
                        return;
                    }
                    awakenScrollBars();
                }
                switch (this.ae) {
                    case 0:
                        if (!isInTouchMode()) {
                            int iV = v();
                            if (iV >= 0 && b(iV, true) == iV) {
                                this.aa = iV;
                                if (this.ac == getWidth()) {
                                    this.h = 5;
                                } else {
                                    this.h = 2;
                                }
                                setNextSelectedPositionInt(iV);
                            }
                        } else {
                            this.h = 5;
                            this.aa = Math.min(Math.max(0, this.aa), i2 - 1);
                        }
                        break;
                    case 1:
                        this.h = 5;
                        this.aa = Math.min(Math.max(0, this.aa), i2 - 1);
                        break;
                }
                return;
            }
            if (!isInTouchMode()) {
                int selectedItemPosition = getSelectedItemPosition();
                int i4 = selectedItemPosition >= i2 ? i2 - 1 : selectedItemPosition;
                if (i4 < 0) {
                    i4 = 0;
                }
                int iB = b(i4, true);
                if (iB >= 0) {
                    setNextSelectedPositionInt(iB);
                    return;
                }
                int iB2 = b(i4, false);
                if (iB2 >= 0) {
                    setNextSelectedPositionInt(iB2);
                    return;
                }
            } else if (this.M >= 0) {
                return;
            }
        }
        this.h = this.K ? 3 : 1;
        this.am = -1;
        this.an = Long.MIN_VALUE;
        this.ak = -1;
        this.al = Long.MIN_VALUE;
        this.ad = false;
        this.bc = null;
        this.n = -1;
        u();
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestDisallowInterceptTouchEvent(boolean z) {
        if (z) {
            D();
        }
        super.requestDisallowInterceptTouchEvent(z);
    }

    @Override // android.view.View, android.view.ViewParent
    public void requestLayout() {
        if (this.at || this.af) {
            return;
        }
        super.requestLayout();
    }

    @Override // android.view.View, android.view.accessibility.AccessibilityEventSource
    public void sendAccessibilityEvent(int i2) {
        if (i2 == 4096) {
            int firstVisiblePosition = getFirstVisiblePosition();
            int lastVisiblePosition = getLastVisiblePosition();
            if (this.aZ == firstVisiblePosition && this.ba == lastVisiblePosition) {
                return;
            }
            this.aZ = firstVisiblePosition;
            this.ba = lastVisiblePosition;
        }
        super.sendAccessibilityEvent(i2);
    }

    @Override // it.sephiroth.android.library.widget.a
    public void setAdapter(ListAdapter listAdapter) {
        if (listAdapter != null) {
            this.k = this.j.hasStableIds();
            if (this.b != 0 && this.k && this.g == null) {
                this.g = new LongSparseArray<>();
            }
        }
        if (this.f != null) {
            this.f.clear();
        }
        if (this.g != null) {
            this.g.clear();
        }
    }

    public void setCacheColorHint(int i2) {
        if (i2 != this.aH) {
            this.aH = i2;
            int childCount = getChildCount();
            for (int i3 = 0; i3 < childCount; i3++) {
                getChildAt(i3).setDrawingCacheBackgroundColor(i2);
            }
            this.p.f(i2);
        }
    }

    @TargetApi(11)
    public void setChoiceMode(int i2) {
        this.b = i2;
        if (Build.VERSION.SDK_INT >= 11 && this.c != null) {
            if (Build.VERSION.SDK_INT >= 11) {
                ((ActionMode) this.c).finish();
            }
            this.c = null;
        }
        if (this.b != 0) {
            if (this.f == null) {
                this.f = new SparseArrayCompat<>();
            }
            if (this.g == null && this.j != null && this.j.hasStableIds()) {
                this.g = new LongSparseArray<>();
            }
            if (Build.VERSION.SDK_INT < 11 || this.b != 3) {
                return;
            }
            a();
            setLongClickable(true);
        }
    }

    public void setDrawSelectorOnTop(boolean z) {
        this.l = z;
    }

    public void setFriction(float f2) {
        if (this.av == null) {
            this.av = new e();
        }
        this.av.b.b(f2);
    }

    @TargetApi(11)
    public void setMultiChoiceModeListener(it.sephiroth.android.library.a.a.a aVar) {
        if (Build.VERSION.SDK_INT < 11) {
            Log.e("AbsListView", "setMultiChoiceModeListener not supported for this version of Android");
            return;
        }
        if (this.d == null) {
            this.d = new it.sephiroth.android.library.a.a.b(this);
        }
        ((it.sephiroth.android.library.a.a.b) this.d).a(aVar);
    }

    public void setOnScrollListener(h hVar) {
        this.aw = hVar;
        b();
    }

    @Override // android.view.View
    public void setOverScrollMode(int i2) {
        if (i2 == 2) {
            this.aQ = null;
            this.aR = null;
        } else if (this.aQ == null) {
            Context context = getContext();
            this.aQ = new EdgeEffectCompat(context);
            this.aR = new EdgeEffectCompat(context);
        }
        super.setOverScrollMode(i2);
    }

    public void setRecyclerListener(l lVar) {
        this.p.b = lVar;
    }

    public void setScrollingCacheEnabled(boolean z) {
        if (this.L && !z) {
            F();
        }
        this.L = z;
    }

    public abstract void setSelectionInt(int i2);

    public void setSelector(int i2) {
        setSelector(getResources().getDrawable(i2));
    }

    public void setSelector(Drawable drawable) {
        if (this.m != null) {
            this.m.setCallback(null);
            unscheduleDrawable(this.m);
        }
        this.m = drawable;
        Rect rect = new Rect();
        drawable.getPadding(rect);
        this.q = rect.left;
        this.r = rect.top;
        this.s = rect.right;
        this.t = rect.bottom;
        drawable.setCallback(this);
        j();
    }

    public void setSmoothScrollbarEnabled(boolean z) {
        this.ax = z;
    }

    public void setStackFromRight(boolean z) {
        if (this.K != z) {
            this.K = z;
            c();
        }
    }

    public void setTranscriptMode(int i2) {
        this.aG = i2;
    }

    public void setVelocityScale(float f2) {
        this.aO = f2;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public boolean showContextMenuForChild(View view) {
        int iA = a(view);
        if (iA < 0) {
            return false;
        }
        long itemId = this.j.getItemId(iA);
        boolean zA = this.ai != null ? this.ai.a(this, view, iA, itemId) : false;
        if (zA) {
            return zA;
        }
        this.az = b(getChildAt(iA - this.V), iA, itemId);
        return super.showContextMenuForChild(view);
    }

    @Override // android.view.View
    public boolean verifyDrawable(Drawable drawable) {
        return this.m == drawable || super.verifyDrawable(drawable);
    }
}
