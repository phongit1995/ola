package it.sephiroth.android.library.widget;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.database.DataSetObserver;
import android.os.Build;
import android.os.Parcelable;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.ContextMenu;
import android.view.View;
import android.view.ViewDebug;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Adapter;

/* JADX INFO: loaded from: classes2.dex */
public abstract class a<T extends Adapter> extends ViewGroup {

    @ViewDebug.ExportedProperty(category = "scrolling")
    protected int V;
    protected int W;
    private int a;
    protected int aa;
    protected long ab;
    protected long ac;
    protected boolean ad;
    int ae;
    protected boolean af;
    e ag;
    c ah;
    d ai;
    public boolean aj;

    @ViewDebug.ExportedProperty(category = "list")
    protected int ak;
    protected long al;

    @ViewDebug.ExportedProperty(category = "list")
    protected int am;
    protected long an;

    @ViewDebug.ExportedProperty(category = "list")
    protected int ao;
    protected int ap;
    AccessibilityManager aq;
    protected int ar;
    protected long as;
    protected boolean at;
    private View b;
    private boolean c;
    private boolean d;
    private a<T>.f e;

    /* JADX INFO: renamed from: it.sephiroth.android.library.widget.a$a, reason: collision with other inner class name */
    public static class ContextMenuContextMenuInfoC0085a implements ContextMenu.ContextMenuInfo {
        public View a;
        public int b;
        public long c;

        public ContextMenuContextMenuInfoC0085a(View view, int i, long j) {
            this.a = view;
            this.b = i;
            this.c = j;
        }
    }

    class b extends DataSetObserver {
        private Parcelable a = null;

        b() {
        }

        @Override // android.database.DataSetObserver
        public void onChanged() {
            a.this.aj = true;
            a.this.ap = a.this.ao;
            a.this.ao = a.this.getAdapter().getCount();
            if (!a.this.getAdapter().hasStableIds() || this.a == null || a.this.ap != 0 || a.this.ao <= 0) {
                a.this.w();
            } else {
                a.this.onRestoreInstanceState(this.a);
                this.a = null;
            }
            a.this.s();
            a.this.requestLayout();
        }

        @Override // android.database.DataSetObserver
        public void onInvalidated() {
            a.this.aj = true;
            if (a.this.getAdapter().hasStableIds()) {
                this.a = a.this.onSaveInstanceState();
            }
            a.this.ap = a.this.ao;
            a.this.ao = 0;
            a.this.am = -1;
            a.this.an = Long.MIN_VALUE;
            a.this.ak = -1;
            a.this.al = Long.MIN_VALUE;
            a.this.ad = false;
            a.this.s();
            a.this.requestLayout();
        }
    }

    public interface c {
        void a(a<?> aVar, View view, int i, long j);
    }

    public interface d {
        boolean a(a<?> aVar, View view, int i, long j);
    }

    public interface e {
        void a(a<?> aVar);

        void a(a<?> aVar, View view, int i, long j);
    }

    private class f implements Runnable {
        private f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            if (!a.this.aj) {
                a.this.a();
                a.this.b();
            } else if (a.this.getAdapter() != null) {
                a.this.post(this);
            }
        }
    }

    public a(Context context) {
        super(context);
        this.V = 0;
        this.ab = Long.MIN_VALUE;
        this.ad = false;
        this.af = false;
        this.ak = -1;
        this.al = Long.MIN_VALUE;
        this.am = -1;
        this.an = Long.MIN_VALUE;
        this.ar = -1;
        this.as = Long.MIN_VALUE;
        this.at = false;
    }

    public a(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.V = 0;
        this.ab = Long.MIN_VALUE;
        this.ad = false;
        this.af = false;
        this.ak = -1;
        this.al = Long.MIN_VALUE;
        this.am = -1;
        this.an = Long.MIN_VALUE;
        this.ar = -1;
        this.as = Long.MIN_VALUE;
        this.at = false;
    }

    @TargetApi(16)
    public a(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.V = 0;
        this.ab = Long.MIN_VALUE;
        this.ad = false;
        this.af = false;
        this.ak = -1;
        this.al = Long.MIN_VALUE;
        this.am = -1;
        this.an = Long.MIN_VALUE;
        this.ar = -1;
        this.as = Long.MIN_VALUE;
        this.at = false;
        if (Build.VERSION.SDK_INT >= 16 && getImportantForAccessibility() == 0) {
            setImportantForAccessibility(1);
        }
        if (isInEditMode()) {
            return;
        }
        this.aq = (AccessibilityManager) getContext().getSystemService("accessibility");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a() {
        if (this.ag == null) {
            return;
        }
        int selectedItemPosition = getSelectedItemPosition();
        if (selectedItemPosition < 0) {
            this.ag.a(this);
        } else {
            this.ag.a(this, getSelectedView(), selectedItemPosition, getAdapter().getItemId(selectedItemPosition));
        }
    }

    @SuppressLint({"WrongCall"})
    private void a(boolean z) {
        if (r()) {
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
        if (this.aj) {
            onLayout(false, getLeft(), getTop(), getRight(), getBottom());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b() {
        if (this.aq.isEnabled() && getSelectedItemPosition() >= 0) {
            sendAccessibilityEvent(4);
        }
    }

    private boolean c() {
        int count;
        Adapter adapter = getAdapter();
        if (adapter == null || (count = adapter.getCount()) <= 0) {
            return false;
        }
        return getFirstVisiblePosition() > 0 || getLastVisiblePosition() < count - 1;
    }

    public int a(View view) {
        while (true) {
            try {
                View view2 = (View) view.getParent();
                if (view2.equals(this)) {
                    break;
                }
                view = view2;
            } catch (ClassCastException unused) {
            }
        }
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            if (getChildAt(i).equals(view)) {
                return this.V + i;
            }
        }
        return -1;
    }

    public boolean a(View view, int i, long j) {
        if (this.ah == null) {
            return false;
        }
        playSoundEffect(0);
        if (view != null) {
            view.sendAccessibilityEvent(1);
        }
        this.ah.a(this, view, i, j);
        return true;
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

    protected int b(int i, boolean z) {
        return i;
    }

    @Override // android.view.ViewGroup
    protected boolean canAnimate() {
        return super.canAnimate() && this.ao > 0;
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

    public long g(int i) {
        Adapter adapter = getAdapter();
        if (adapter == null || i < 0) {
            return Long.MIN_VALUE;
        }
        return adapter.getItemId(i);
    }

    public abstract T getAdapter();

    @ViewDebug.CapturedViewProperty
    public int getCount() {
        return this.ao;
    }

    public View getEmptyView() {
        return this.b;
    }

    public int getFirstVisiblePosition() {
        return this.V;
    }

    public int getLastVisiblePosition() {
        return (this.V + getChildCount()) - 1;
    }

    public final c getOnItemClickListener() {
        return this.ah;
    }

    public final d getOnItemLongClickListener() {
        return this.ai;
    }

    public final e getOnItemSelectedListener() {
        return this.ag;
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
        return this.al;
    }

    @ViewDebug.CapturedViewProperty
    public int getSelectedItemPosition() {
        return this.ak;
    }

    public abstract View getSelectedView();

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        removeCallbacks(this.e);
    }

    @Override // android.view.View
    @TargetApi(14)
    public void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        super.onInitializeAccessibilityEvent(accessibilityEvent);
        accessibilityEvent.setClassName(a.class.getName());
        accessibilityEvent.setScrollable(c());
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
    @TargetApi(14)
    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo) {
        super.onInitializeAccessibilityNodeInfo(accessibilityNodeInfo);
        accessibilityNodeInfo.setClassName(a.class.getName());
        accessibilityNodeInfo.setScrollable(c());
        View selectedView = getSelectedView();
        if (selectedView != null) {
            accessibilityNodeInfo.setEnabled(selectedView.isEnabled());
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        this.a = getWidth();
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

    /* JADX WARN: Removed duplicated region for block: B:11:0x001d  */
    /* JADX WARN: Removed duplicated region for block: B:24:0x003f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    void q() {
        /*
            r5 = this;
            int r0 = r5.ao
            r1 = 1
            r2 = 0
            if (r0 <= 0) goto L41
            boolean r3 = r5.ad
            if (r3 == 0) goto L1d
            r5.ad = r2
            int r3 = r5.v()
            if (r3 < 0) goto L1d
            int r4 = r5.b(r3, r1)
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
            int r4 = r5.b(r0, r1)
            if (r4 >= 0) goto L36
            int r4 = r5.b(r0, r2)
        L36:
            if (r4 < 0) goto L3f
            r5.setNextSelectedPositionInt(r4)
            r5.u()
            goto L42
        L3f:
            r1 = r3
            goto L42
        L41:
            r1 = 0
        L42:
            if (r1 != 0) goto L54
            r0 = -1
            r5.am = r0
            r3 = -9223372036854775808
            r5.an = r3
            r5.ak = r0
            r5.al = r3
            r5.ad = r2
            r5.u()
        L54:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: it.sephiroth.android.library.widget.a.q():void");
    }

    boolean r() {
        return false;
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

    protected void s() {
        Adapter adapter = getAdapter();
        boolean z = true;
        boolean z2 = !(adapter == null || adapter.getCount() == 0) || r();
        super.setFocusableInTouchMode(z2 && this.d);
        super.setFocusable(z2 && this.c);
        if (this.b != null) {
            if (adapter != null && !adapter.isEmpty()) {
                z = false;
            }
            a(z);
        }
    }

    public abstract void setAdapter(T t);

    @TargetApi(16)
    public void setEmptyView(View view) {
        this.b = view;
        boolean z = true;
        if (Build.VERSION.SDK_INT >= 16 && view != null && view.getImportantForAccessibility() == 0) {
            view.setImportantForAccessibility(1);
        }
        Adapter adapter = getAdapter();
        if (adapter != null && !adapter.isEmpty()) {
            z = false;
        }
        a(z);
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
        if (!z || (z3 && !r())) {
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
        if (z && (!z3 || r())) {
            z2 = true;
        }
        super.setFocusableInTouchMode(z2);
    }

    protected void setNextSelectedPositionInt(int i) {
        this.ak = i;
        this.al = g(i);
        if (this.ad && this.ae == 0 && i >= 0) {
            this.aa = i;
            this.ab = this.al;
        }
    }

    @Override // android.view.View
    public void setOnClickListener(View.OnClickListener onClickListener) {
        throw new RuntimeException("Don't call setOnClickListener for an AdapterView. You probably want setOnItemClickListener instead");
    }

    public void setOnItemClickListener(c cVar) {
        this.ah = cVar;
    }

    public void setOnItemLongClickListener(d dVar) {
        if (!isLongClickable()) {
            setLongClickable(true);
        }
        this.ai = dVar;
    }

    public void setOnItemSelectedListener(e eVar) {
        this.ag = eVar;
    }

    protected void setSelectedPositionInt(int i) {
        this.am = i;
        this.an = g(i);
    }

    public abstract void setSelection(int i);

    void t() {
        if (this.ag != null || this.aq.isEnabled()) {
            if (!this.af && !this.at) {
                a();
                b();
            } else {
                if (this.e == null) {
                    this.e = new f();
                }
                post(this.e);
            }
        }
    }

    protected void u() {
        if (this.am == this.ar && this.an == this.as) {
            return;
        }
        t();
        this.ar = this.am;
        this.as = this.an;
    }

    int v() {
        int i = this.ao;
        if (i == 0) {
            return -1;
        }
        long j = this.ab;
        int i2 = this.aa;
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

    public void w() {
        if (getChildCount() > 0) {
            this.ad = true;
            this.ac = this.a;
            if (this.am >= 0) {
                View childAt = getChildAt(this.am - this.V);
                this.ab = this.al;
                this.aa = this.ak;
                if (childAt != null) {
                    this.W = childAt.getLeft();
                }
                this.ae = 0;
                return;
            }
            View childAt2 = getChildAt(0);
            Adapter adapter = getAdapter();
            this.ab = (this.V < 0 || this.V >= adapter.getCount()) ? -1L : adapter.getItemId(this.V);
            this.aa = this.V;
            if (childAt2 != null) {
                this.W = childAt2.getLeft();
            }
            this.ae = 1;
        }
    }
}
