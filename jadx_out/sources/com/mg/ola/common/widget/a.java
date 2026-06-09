package com.mg.ola.common.widget;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.database.DataSetObserver;
import android.os.Parcelable;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.View;
import android.view.ViewDebug;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Adapter;
import android.widget.AdapterView;

/* JADX INFO: loaded from: classes2.dex */
@TargetApi(14)
public abstract class a<T extends Adapter> extends ViewGroup {

    @ViewDebug.ExportedProperty(category = "list")
    int A;
    int B;
    int C;
    long D;
    boolean E;
    private int a;
    private View b;
    private boolean c;
    private boolean d;
    private a<T>.d e;

    @ViewDebug.ExportedProperty(category = "scrolling")
    int k;
    int l;
    int m;
    long n;
    long o;
    boolean p;
    int q;
    boolean r;
    c s;
    AdapterView.OnItemClickListener t;
    b u;
    boolean v;

    @ViewDebug.ExportedProperty(category = "list")
    int w;
    long x;

    @ViewDebug.ExportedProperty(category = "list")
    int y;
    long z;

    /* JADX INFO: renamed from: com.mg.ola.common.widget.a$a, reason: collision with other inner class name */
    class C0081a extends DataSetObserver {
        private Parcelable b = null;

        C0081a() {
        }

        @Override // android.database.DataSetObserver
        public void onChanged() {
            a.this.v = true;
            a.this.B = a.this.A;
            a.this.A = a.this.getAdapter().getCount();
            if (!a.this.getAdapter().hasStableIds() || this.b == null || a.this.B != 0 || a.this.A <= 0) {
                a.this.h();
            } else {
                a.this.onRestoreInstanceState(this.b);
                this.b = null;
            }
            a.this.c();
            a.this.requestLayout();
        }

        @Override // android.database.DataSetObserver
        public void onInvalidated() {
            a.this.v = true;
            if (a.this.getAdapter().hasStableIds()) {
                this.b = a.this.onSaveInstanceState();
            }
            a.this.B = a.this.A;
            a.this.A = 0;
            a.this.y = -1;
            a.this.z = Long.MIN_VALUE;
            a.this.w = -1;
            a.this.x = Long.MIN_VALUE;
            a.this.p = false;
            a.this.c();
            a.this.requestLayout();
        }
    }

    public interface b {
    }

    public interface c {
        void a(a<?> aVar);

        void a(a<?> aVar, View view, int i, long j);
    }

    private class d implements Runnable {
        private d() {
        }

        @Override // java.lang.Runnable
        public void run() {
            if (!a.this.v) {
                a.this.a();
            } else if (a.this.getAdapter() != null) {
                a.this.post(this);
            }
        }
    }

    public a(Context context) {
        super(context);
        this.k = 0;
        this.n = Long.MIN_VALUE;
        this.p = false;
        this.r = false;
        this.w = -1;
        this.x = Long.MIN_VALUE;
        this.y = -1;
        this.z = Long.MIN_VALUE;
        this.C = -1;
        this.D = Long.MIN_VALUE;
        this.E = false;
    }

    public a(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.k = 0;
        this.n = Long.MIN_VALUE;
        this.p = false;
        this.r = false;
        this.w = -1;
        this.x = Long.MIN_VALUE;
        this.y = -1;
        this.z = Long.MIN_VALUE;
        this.C = -1;
        this.D = Long.MIN_VALUE;
        this.E = false;
    }

    public a(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.k = 0;
        this.n = Long.MIN_VALUE;
        this.p = false;
        this.r = false;
        this.w = -1;
        this.x = Long.MIN_VALUE;
        this.y = -1;
        this.z = Long.MIN_VALUE;
        this.C = -1;
        this.D = Long.MIN_VALUE;
        this.E = false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a() {
        if (this.s == null) {
            return;
        }
        int selectedItemPosition = getSelectedItemPosition();
        if (selectedItemPosition < 0) {
            this.s.a(this);
        } else {
            this.s.a(this, getSelectedView(), selectedItemPosition, getAdapter().getItemId(selectedItemPosition));
        }
    }

    @SuppressLint({"WrongCall"})
    private void a(boolean z) {
        if (b()) {
            z = false;
        }
        if (!z) {
            if (this.b != null) {
                this.b.setVisibility(8);
            }
            setVisibility(0);
            return;
        }
        if (this.b != null) {
            this.b.setVisibility(0);
            setVisibility(8);
        } else {
            setVisibility(0);
        }
        if (this.v) {
            onLayout(false, getLeft(), getTop(), getRight(), getBottom());
        }
    }

    private boolean i() {
        int count;
        Adapter adapter = getAdapter();
        if (adapter == null || (count = adapter.getCount()) <= 0) {
            return false;
        }
        return getFirstVisiblePosition() > 0 || getLastVisiblePosition() < count - 1;
    }

    int a(int i, boolean z) {
        return i;
    }

    public long a(int i) {
        Adapter adapter = getAdapter();
        if (adapter == null || i < 0) {
            return Long.MIN_VALUE;
        }
        return adapter.getItemId(i);
    }

    @Override // android.view.ViewGroup
    public void addView(View view) {
        throw new UnsupportedOperationException("addView(View) is not supported in AdapterView");
    }

    @Override // android.view.ViewGroup
    public void addView(View view, int i) {
        throw new UnsupportedOperationException("addView(View, int) is not supported in AdapterView");
    }

    @Override // android.view.ViewGroup
    public void addView(View view, int i, ViewGroup.LayoutParams layoutParams) {
        throw new UnsupportedOperationException("addView(View, int, LayoutParams) is not supported in AdapterView");
    }

    @Override // android.view.ViewGroup, android.view.ViewManager
    public void addView(View view, ViewGroup.LayoutParams layoutParams) {
        throw new UnsupportedOperationException("addView(View, LayoutParams) is not supported in AdapterView");
    }

    boolean b() {
        return false;
    }

    void c() {
        Adapter adapter = getAdapter();
        boolean z = true;
        boolean z2 = !(adapter == null || adapter.getCount() == 0) || b();
        super.setFocusableInTouchMode(z2 && this.d);
        super.setFocusable(z2 && this.c);
        if (this.b != null) {
            if (adapter != null && !adapter.isEmpty()) {
                z = false;
            }
            a(z);
        }
    }

    @Override // android.view.ViewGroup
    protected boolean canAnimate() {
        return super.canAnimate() && this.A > 0;
    }

    void d() {
        if (this.s != null) {
            if (this.r || this.E) {
                if (this.e == null) {
                    this.e = new d();
                }
                post(this.e);
            } else {
                a();
            }
        }
        if (this.y == -1 || !isShown() || isInTouchMode()) {
            return;
        }
        sendAccessibilityEvent(4);
    }

    @Override // android.view.View
    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        View selectedView = getSelectedView();
        return selectedView != null && selectedView.getVisibility() == 0 && selectedView.dispatchPopulateAccessibilityEvent(accessibilityEvent);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchRestoreInstanceState(SparseArray<Parcelable> sparseArray) {
        dispatchThawSelfOnly(sparseArray);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchSaveInstanceState(SparseArray<Parcelable> sparseArray) {
        dispatchFreezeSelfOnly(sparseArray);
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x001d  */
    /* JADX WARN: Removed duplicated region for block: B:24:0x003f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    void e() {
        /*
            r5 = this;
            int r0 = r5.A
            r1 = 1
            r2 = 0
            if (r0 <= 0) goto L41
            boolean r3 = r5.p
            if (r3 == 0) goto L1d
            r5.p = r2
            int r3 = r5.g()
            if (r3 < 0) goto L1d
            int r4 = r5.a(r3, r1)
            if (r4 != r3) goto L1d
            r5.setNextSelectedPositionInt(r3)
            r3 = 1
            goto L1e
        L1d:
            r3 = 0
        L1e:
            if (r3 != 0) goto L3f
            int r4 = r5.getSelectedItemPosition()
            if (r4 < r0) goto L28
            int r0 = r0 - r1
            goto L29
        L28:
            r0 = r4
        L29:
            if (r0 >= 0) goto L2c
            r0 = 0
        L2c:
            int r4 = r5.a(r0, r1)
            if (r4 >= 0) goto L36
            int r4 = r5.a(r0, r2)
        L36:
            if (r4 < 0) goto L3f
            r5.setNextSelectedPositionInt(r4)
            r5.f()
            goto L42
        L3f:
            r1 = r3
            goto L42
        L41:
            r1 = 0
        L42:
            if (r1 != 0) goto L54
            r0 = -1
            r5.y = r0
            r3 = -9223372036854775808
            r5.z = r3
            r5.w = r0
            r5.x = r3
            r5.p = r2
            r5.f()
        L54:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.mg.ola.common.widget.a.e():void");
    }

    void f() {
        if (this.y == this.C && this.z == this.D) {
            return;
        }
        d();
        this.C = this.y;
        this.D = this.z;
    }

    int g() {
        int i = this.A;
        if (i == 0) {
            return -1;
        }
        long j = this.n;
        int i2 = this.m;
        if (j == Long.MIN_VALUE) {
            return -1;
        }
        int i3 = i - 1;
        int iMin = Math.min(i3, Math.max(0, i2));
        long jUptimeMillis = SystemClock.uptimeMillis() + 100;
        Adapter adapter = getAdapter();
        if (adapter == null) {
            return -1;
        }
        int i4 = iMin;
        int i5 = i4;
        while (true) {
            boolean z = false;
            while (SystemClock.uptimeMillis() <= jUptimeMillis) {
                if (adapter.getItemId(iMin) == j) {
                    return iMin;
                }
                boolean z2 = i4 == i3;
                boolean z3 = i5 == 0;
                if (z2 && z3) {
                    return -1;
                }
                if (z3 || (z && !z2)) {
                    break;
                }
                if (z2 || (!z && !z3)) {
                    i5--;
                    iMin = i5;
                    z = true;
                }
            }
            return -1;
            i4++;
            iMin = i4;
        }
    }

    public abstract T getAdapter();

    @ViewDebug.CapturedViewProperty
    public int getCount() {
        return this.A;
    }

    public View getEmptyView() {
        return this.b;
    }

    public int getFirstVisiblePosition() {
        return this.k;
    }

    public int getLastVisiblePosition() {
        return (this.k + getChildCount()) - 1;
    }

    public final AdapterView.OnItemClickListener getOnItemClickListener() {
        return this.t;
    }

    public final b getOnItemLongClickListener() {
        return this.u;
    }

    public final c getOnItemSelectedListener() {
        return this.s;
    }

    public Object getSelectedItem() {
        Adapter adapter = getAdapter();
        int selectedItemPosition = getSelectedItemPosition();
        if (adapter == null || adapter.getCount() <= 0 || selectedItemPosition < 0) {
            return null;
        }
        return adapter.getItem(selectedItemPosition);
    }

    @ViewDebug.CapturedViewProperty
    public long getSelectedItemId() {
        return this.x;
    }

    @ViewDebug.CapturedViewProperty
    public int getSelectedItemPosition() {
        return this.w;
    }

    public abstract View getSelectedView();

    void h() {
        if (getChildCount() > 0) {
            this.p = true;
            this.o = this.a;
            if (this.y >= 0) {
                View childAt = getChildAt(this.y - this.k);
                this.n = this.x;
                this.m = this.w;
                if (childAt != null) {
                    this.l = childAt.getTop();
                }
                this.q = 0;
                return;
            }
            View childAt2 = getChildAt(0);
            Adapter adapter = getAdapter();
            this.n = (this.k < 0 || this.k >= adapter.getCount()) ? -1L : adapter.getItemId(this.k);
            this.m = this.k;
            if (childAt2 != null) {
                this.l = childAt2.getTop();
            }
            this.q = 1;
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        removeCallbacks(this.e);
    }

    @Override // android.view.View
    public void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        super.onInitializeAccessibilityEvent(accessibilityEvent);
        accessibilityEvent.setScrollable(i());
        View selectedView = getSelectedView();
        if (selectedView != null) {
            accessibilityEvent.setEnabled(selectedView.isEnabled());
        }
        accessibilityEvent.setCurrentItemIndex(getSelectedItemPosition());
        accessibilityEvent.setFromIndex(getFirstVisiblePosition());
        accessibilityEvent.setToIndex(getLastVisiblePosition());
        accessibilityEvent.setItemCount(getCount());
    }

    @Override // android.view.View
    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo) {
        super.onInitializeAccessibilityNodeInfo(accessibilityNodeInfo);
        accessibilityNodeInfo.setScrollable(i());
        View selectedView = getSelectedView();
        if (selectedView != null) {
            accessibilityNodeInfo.setEnabled(selectedView.isEnabled());
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        this.a = getHeight();
    }

    @Override // android.view.ViewGroup
    @TargetApi(14)
    public boolean onRequestSendAccessibilityEvent(View view, AccessibilityEvent accessibilityEvent) {
        if (!super.onRequestSendAccessibilityEvent(view, accessibilityEvent)) {
            return false;
        }
        AccessibilityEvent accessibilityEventObtain = AccessibilityEvent.obtain();
        onInitializeAccessibilityEvent(accessibilityEventObtain);
        view.dispatchPopulateAccessibilityEvent(accessibilityEventObtain);
        accessibilityEvent.appendRecord(accessibilityEventObtain);
        return true;
    }

    @Override // android.view.ViewGroup
    public void removeAllViews() {
        throw new UnsupportedOperationException("removeAllViews() is not supported in AdapterView");
    }

    @Override // android.view.ViewGroup, android.view.ViewManager
    public void removeView(View view) {
        throw new UnsupportedOperationException("removeView(View) is not supported in AdapterView");
    }

    @Override // android.view.ViewGroup
    public void removeViewAt(int i) {
        throw new UnsupportedOperationException("removeViewAt(int) is not supported in AdapterView");
    }

    public abstract void setAdapter(T t);

    public void setEmptyView(View view) {
        this.b = view;
        Adapter adapter = getAdapter();
        a(adapter == null || adapter.isEmpty());
    }

    @Override // android.view.View
    public void setFocusable(boolean z) {
        Adapter adapter = getAdapter();
        boolean z2 = true;
        boolean z3 = adapter == null || adapter.getCount() == 0;
        this.c = z;
        if (!z) {
            this.d = false;
        }
        if (!z || (z3 && !b())) {
            z2 = false;
        }
        super.setFocusable(z2);
    }

    @Override // android.view.View
    public void setFocusableInTouchMode(boolean z) {
        Adapter adapter = getAdapter();
        boolean z2 = false;
        boolean z3 = adapter == null || adapter.getCount() == 0;
        this.d = z;
        if (z) {
            this.c = true;
        }
        if (z && (!z3 || b())) {
            z2 = true;
        }
        super.setFocusableInTouchMode(z2);
    }

    void setNextSelectedPositionInt(int i) {
        this.w = i;
        this.x = a(i);
        if (this.p && this.q == 0 && i >= 0) {
            this.m = i;
            this.n = this.x;
        }
    }

    @Override // android.view.View
    public void setOnClickListener(View.OnClickListener onClickListener) {
        throw new RuntimeException("Don't call setOnClickListener for an AdapterView. You probably want setOnItemClickListener instead");
    }

    public void setOnItemClickListener(AdapterView.OnItemClickListener onItemClickListener) {
        this.t = onItemClickListener;
    }

    public void setOnItemLongClickListener(b bVar) {
        if (!isLongClickable()) {
            setLongClickable(true);
        }
        this.u = bVar;
    }

    public void setOnItemSelectedListener(c cVar) {
        this.s = cVar;
    }

    void setSelectedPositionInt(int i) {
        this.y = i;
        this.z = a(i);
    }

    public abstract void setSelection(int i);
}
