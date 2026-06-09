package com.mg.ola.common.widget;

import android.content.Context;
import android.content.res.Resources;
import android.database.DataSetObserver;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Handler;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.ViewTreeObserver;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.PopupWindow;
import chat.ola.vn.R;
import com.google.android.gms.common.util.CrashUtils;
import java.lang.reflect.Field;

/* JADX INFO: loaded from: classes2.dex */
public class b {
    private Drawable A;
    private int B;
    private boolean C;
    private boolean D;
    private int E;
    private int F;
    private boolean G;
    private Context a;
    private PopupWindow b;
    private ListAdapter c;
    private a d;
    private int e;
    private int f;
    private int g;
    private int h;
    private boolean i;
    private int j;
    private View k;
    private int l;
    private DataSetObserver m;
    private View n;
    private Drawable o;
    private AdapterView.OnItemClickListener p;
    private AdapterView.OnItemSelectedListener q;
    private final f r;
    private final e s;
    private final d t;
    private final RunnableC0082b u;
    private Handler v;
    private Rect w;
    private boolean x;
    private boolean y;
    private boolean z;

    private static class a extends ListView {
        private boolean a;
        private boolean b;

        public a(Context context, boolean z) {
            super(context, null, R.attr.mgDropDownListViewStyle);
            this.b = z;
            setCacheColorHint(0);
        }

        @Override // android.view.ViewGroup, android.view.View
        public boolean hasFocus() {
            return this.b || super.hasFocus();
        }

        @Override // android.view.View
        public boolean hasWindowFocus() {
            return this.b || super.hasWindowFocus();
        }

        @Override // android.view.View
        public boolean isFocused() {
            return this.b || super.isFocused();
        }

        @Override // android.view.View
        public boolean isInTouchMode() {
            return (this.b && this.a) || super.isInTouchMode();
        }
    }

    /* JADX INFO: renamed from: com.mg.ola.common.widget.b$b, reason: collision with other inner class name */
    private class RunnableC0082b implements Runnable {
        private RunnableC0082b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            b.this.e();
        }
    }

    private class c extends DataSetObserver {
        private c() {
        }

        @Override // android.database.DataSetObserver
        public void onChanged() {
            if (b.this.f()) {
                b.this.b();
            }
        }

        @Override // android.database.DataSetObserver
        public void onInvalidated() {
            b.this.d();
        }
    }

    private class d implements AbsListView.OnScrollListener {
        private d() {
        }

        @Override // android.widget.AbsListView.OnScrollListener
        public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        }

        @Override // android.widget.AbsListView.OnScrollListener
        public void onScrollStateChanged(AbsListView absListView, int i) {
            if (i != 1 || b.this.g() || b.this.b.getContentView() == null) {
                return;
            }
            b.this.v.removeCallbacks(b.this.r);
            b.this.r.run();
        }
    }

    private class e implements View.OnTouchListener {
        private e() {
        }

        @Override // android.view.View.OnTouchListener
        public boolean onTouch(View view, MotionEvent motionEvent) {
            int action = motionEvent.getAction();
            int x = (int) motionEvent.getX();
            int y = (int) motionEvent.getY();
            switch (action) {
                case 0:
                    if (b.this.b != null && b.this.b.isShowing() && x >= 0 && x < b.this.b.getWidth() && y >= 0 && y < b.this.b.getHeight()) {
                        b.this.v.postDelayed(b.this.r, 250L);
                        break;
                    }
                    break;
                case 1:
                    b.this.v.removeCallbacks(b.this.r);
                    break;
            }
            return false;
        }
    }

    private class f implements Runnable {
        private f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            int childCount = b.this.d.getChildCount();
            int count = b.this.d.getCount();
            if (b.this.d == null || count <= childCount || childCount > b.this.j || !b.this.G) {
                return;
            }
            b.this.b.setInputMethodMode(2);
            b.this.b();
        }
    }

    public b(Context context) {
        this(context, null, R.attr.mgListPopupWindowStyle);
    }

    public b(Context context, AttributeSet attributeSet, int i) {
        this.e = -2;
        this.f = -2;
        this.j = Integer.MAX_VALUE;
        this.l = 0;
        this.r = new f();
        this.s = new e();
        this.t = new d();
        this.u = new RunnableC0082b();
        this.v = new Handler();
        this.w = new Rect();
        this.y = true;
        this.z = false;
        this.C = false;
        this.E = Integer.MAX_VALUE;
        this.F = Integer.MAX_VALUE;
        this.a = context;
        this.b = new PopupWindow(context, attributeSet, i);
        this.b.setInputMethodMode(1);
        a(this.b);
    }

    private int a(int i, int i2, int i3, int i4, int i5) {
        ListAdapter listAdapter = this.c;
        if (listAdapter == null) {
            return this.d.getListPaddingTop() + this.d.getListPaddingBottom();
        }
        int listPaddingTop = this.d.getListPaddingTop() + this.d.getListPaddingBottom();
        int i6 = 0;
        int dividerHeight = (this.d.getDividerHeight() <= 0 || this.d.getDivider() == null) ? 0 : this.d.getDividerHeight();
        if (i3 == -1) {
            i3 = listAdapter.getCount() - 1;
        }
        while (i2 <= i3) {
            View view = this.c.getView(i2, null, this.d);
            if (this.d.getCacheColorHint() != 0) {
                view.setDrawingCacheBackgroundColor(this.d.getCacheColorHint());
            }
            a(view, i2, i);
            if (i2 > 0) {
                listPaddingTop += dividerHeight;
            }
            listPaddingTop += view.getMeasuredHeight();
            if (listPaddingTop >= i4) {
                return (i5 < 0 || i2 <= i5 || i6 <= 0 || listPaddingTop == i4) ? i4 : i6;
            }
            if (i5 >= 0 && i2 >= i5) {
                i6 = listPaddingTop;
            }
            i2++;
        }
        return listPaddingTop;
    }

    private int a(View view, int i, boolean z) {
        Rect rect = new Rect();
        view.getWindowVisibleDisplayFrame(rect);
        int[] iArr = new int[2];
        view.getLocationOnScreen(iArr);
        int i2 = rect.bottom;
        if (z) {
            i2 = view.getContext().getResources().getDisplayMetrics().heightPixels;
        }
        int iMax = Math.max((i2 - (iArr[1] + view.getHeight())) - i, (iArr[1] - rect.top) + i);
        if (this.b.getBackground() == null) {
            return iMax;
        }
        this.b.getBackground().getPadding(this.w);
        return iMax - (this.w.top + this.w.bottom);
    }

    private void a(View view, int i, int i2) {
        AbsListView.LayoutParams layoutParams = (AbsListView.LayoutParams) view.getLayoutParams();
        if (layoutParams == null) {
            layoutParams = new AbsListView.LayoutParams(-1, -2, 0);
            view.setLayoutParams(layoutParams);
        }
        int childMeasureSpec = ViewGroup.getChildMeasureSpec(i2, this.d.getPaddingLeft() + this.d.getPaddingRight(), layoutParams.width);
        int i3 = layoutParams.height;
        view.measure(childMeasureSpec, i3 > 0 ? View.MeasureSpec.makeMeasureSpec(i3, CrashUtils.ErrorDialogData.SUPPRESSED) : View.MeasureSpec.makeMeasureSpec(0, 0));
    }

    private void a(final PopupWindow popupWindow) {
        if (Build.VERSION.SDK_INT < 14) {
            try {
                final Field declaredField = PopupWindow.class.getDeclaredField("mAnchor");
                declaredField.setAccessible(true);
                Field declaredField2 = PopupWindow.class.getDeclaredField("mOnScrollChangedListener");
                declaredField2.setAccessible(true);
                final ViewTreeObserver.OnScrollChangedListener onScrollChangedListener = (ViewTreeObserver.OnScrollChangedListener) declaredField2.get(popupWindow);
                declaredField2.set(popupWindow, new ViewTreeObserver.OnScrollChangedListener() { // from class: com.mg.ola.common.widget.b.1
                    @Override // android.view.ViewTreeObserver.OnScrollChangedListener
                    public void onScrollChanged() {
                        try {
                            if (((View) declaredField.get(popupWindow)) == null) {
                                return;
                            }
                            onScrollChangedListener.onScrollChanged();
                        } catch (IllegalAccessException e2) {
                            e2.printStackTrace();
                        } catch (Throwable unused) {
                        }
                    }
                });
            } catch (Exception unused) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean g() {
        return this.b.getInputMethodMode() == 2;
    }

    private int h() {
        int measuredHeight;
        int i;
        if (this.d == null) {
            Context context = this.a;
            this.d = new a(context, !this.x);
            if (this.o != null) {
                this.d.setSelector(this.o);
            }
            this.d.setAdapter(this.c);
            this.d.setOnItemClickListener(this.p);
            this.d.setFocusable(true);
            this.d.setFocusableInTouchMode(true);
            this.d.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() { // from class: com.mg.ola.common.widget.b.2
                @Override // android.widget.AdapterView.OnItemSelectedListener
                public void onItemSelected(AdapterView<?> adapterView, View view, int i2, long j) {
                    a aVar;
                    if (i2 == -1 || (aVar = b.this.d) == null) {
                        return;
                    }
                    aVar.a = false;
                }

                @Override // android.widget.AdapterView.OnItemSelectedListener
                public void onNothingSelected(AdapterView<?> adapterView) {
                }
            });
            this.d.setOnScrollListener(this.t);
            if (this.q != null) {
                this.d.setOnItemSelectedListener(this.q);
            }
            View view = this.d;
            View view2 = this.k;
            if (view2 != null) {
                LinearLayout linearLayout = new LinearLayout(context);
                linearLayout.setOrientation(1);
                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-1, 0, 1.0f);
                switch (this.l) {
                    case 0:
                        linearLayout.addView(view2);
                        linearLayout.addView(view, layoutParams);
                        break;
                    case 1:
                        linearLayout.addView(view, layoutParams);
                        linearLayout.addView(view2);
                        break;
                }
                view2.measure(View.MeasureSpec.makeMeasureSpec(this.f, Integer.MIN_VALUE), 0);
                LinearLayout.LayoutParams layoutParams2 = (LinearLayout.LayoutParams) view2.getLayoutParams();
                measuredHeight = view2.getMeasuredHeight() + layoutParams2.topMargin + layoutParams2.bottomMargin;
                view = linearLayout;
            } else {
                measuredHeight = 0;
            }
            this.b.setContentView(view);
        } else {
            View view3 = this.k;
            if (view3 != null) {
                LinearLayout.LayoutParams layoutParams3 = (LinearLayout.LayoutParams) view3.getLayoutParams();
                measuredHeight = view3.getMeasuredHeight() + layoutParams3.topMargin + layoutParams3.bottomMargin;
            } else {
                measuredHeight = 0;
            }
        }
        Drawable background = this.b.getBackground();
        if (background != null) {
            background.getPadding(this.w);
            i = this.w.top + this.w.bottom;
            if (!this.i) {
                this.h = -this.w.top;
            }
        } else {
            i = 0;
        }
        int iA = a(this.n, this.h, this.b.getInputMethodMode() == 2);
        if (this.e == -1) {
            return iA + i;
        }
        int iA2 = a(0, 0, -1, iA - measuredHeight, -1);
        if (iA2 > 0) {
            measuredHeight += i;
        }
        return iA2 + measuredHeight;
    }

    private void j(int i) {
        PopupWindow popupWindow;
        int width;
        int i2;
        int i3 = 0;
        if (this.f == -1) {
            i2 = this.f;
        } else {
            if (this.f == -2) {
                popupWindow = this.b;
                width = this.n.getWidth();
            } else {
                popupWindow = this.b;
                width = this.f;
            }
            popupWindow.setWidth(Math.min(width, this.F));
            i2 = 0;
        }
        if (this.e == -1) {
            i3 = this.e;
        } else if (this.e == -2) {
            this.b.setHeight(Math.min(i, this.E));
        } else {
            this.b.setHeight(Math.min(this.e, this.E));
        }
        this.b.setWindowLayoutMode(i2, i3);
        this.b.setTouchInterceptor(this.s);
        this.b.showAsDropDown(this.n, this.g, this.h);
        this.d.setSelection(-1);
        if (!this.x || this.d.isInTouchMode()) {
            e();
        }
        if (this.x) {
            return;
        }
        this.v.post(this.u);
    }

    private void k(int i) {
        int width;
        boolean zG = g();
        if (this.f == -1) {
            width = -1;
        } else {
            width = this.f == -2 ? this.n.getWidth() : this.f;
        }
        if (this.e == -1) {
            if (!zG) {
                i = -1;
            }
            if (zG) {
                this.b.setWindowLayoutMode(this.f != -1 ? 0 : -1, 0);
            } else {
                this.b.setWindowLayoutMode(this.f == -1 ? -1 : 0, -1);
            }
        } else if (this.e != -2) {
            i = this.e;
        }
        this.b.update(this.n, this.g, this.h, width, i);
    }

    public ListAdapter a() {
        return this.c;
    }

    public void a(int i) {
        this.j = i;
    }

    public void a(Drawable drawable) {
        if (this.d != null) {
            this.d.setDivider(drawable);
        }
        this.A = drawable;
    }

    public void a(View view) {
        this.n = view;
        if (!this.C || this.n == null || this.n.getWidth() <= 0) {
            return;
        }
        f(this.n.getWidth());
    }

    public void a(AdapterView.OnItemClickListener onItemClickListener) {
        this.p = onItemClickListener;
    }

    public void a(ListAdapter listAdapter) {
        if (this.m == null) {
            this.m = new c();
        } else if (this.c != null) {
            this.c.unregisterDataSetObserver(this.m);
        }
        this.c = listAdapter;
        if (this.c != null) {
            listAdapter.registerDataSetObserver(this.m);
        }
        if (this.d != null) {
            this.d.setAdapter(this.c);
        }
    }

    public void a(PopupWindow.OnDismissListener onDismissListener) {
        this.b.setOnDismissListener(onDismissListener);
    }

    public void a(boolean z) {
        this.G = z;
    }

    public void b() {
        int iH = h();
        if (this.A != null) {
            this.d.setDivider(this.A);
        }
        if (this.B >= 0) {
            this.d.setDividerHeight(this.B);
        }
        if (this.b.isShowing()) {
            k(iH);
        } else {
            j(iH);
        }
        this.b.setOutsideTouchable(!this.D && c());
    }

    public void b(int i) {
        this.l = i;
    }

    public void b(boolean z) {
        this.D = z;
    }

    public void c(int i) {
        this.b.setSoftInputMode(i);
    }

    public void c(boolean z) {
        int width;
        this.C = z;
        if (!this.C) {
            width = -2;
        } else if (this.n == null || this.n.getWidth() <= 0) {
            return;
        } else {
            width = this.n.getWidth();
        }
        f(width);
    }

    public boolean c() {
        return this.y;
    }

    public void d() {
        this.b.dismiss();
        if (this.k != null) {
            ViewParent parent = this.k.getParent();
            if (parent instanceof ViewGroup) {
                ((ViewGroup) parent).removeView(this.k);
            }
        }
        this.b.setContentView(null);
        this.d = null;
        this.v.removeCallbacks(this.r);
    }

    public void d(int i) {
        if (i > 0) {
            try {
                this.b.setBackgroundDrawable(this.a.getResources().getDrawable(i));
            } catch (Resources.NotFoundException e2) {
                e2.printStackTrace();
            }
        }
    }

    public void d(boolean z) {
        this.y = z;
    }

    public void e() {
        a aVar = this.d;
        if (aVar != null) {
            aVar.a = true;
            aVar.requestLayout();
        }
    }

    public void e(int i) {
        this.h = i;
        this.i = true;
    }

    public void f(int i) {
        if (i == -2) {
            this.f = -2;
            return;
        }
        Drawable background = this.b.getBackground();
        if (background == null) {
            this.f = i;
        } else {
            background.getPadding(this.w);
            this.f = this.w.left + this.w.right + i;
        }
    }

    public boolean f() {
        return this.b.isShowing();
    }

    public void g(int i) {
        if (this.d != null) {
            this.d.setDividerHeight(i);
        }
        this.B = i;
    }

    public void h(int i) {
        this.E = i;
    }

    public void i(int i) {
        this.b.setInputMethodMode(i);
    }
}
