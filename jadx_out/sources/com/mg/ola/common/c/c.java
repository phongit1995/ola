package com.mg.ola.common.c;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.PopupWindow;
import chat.ola.vn.R;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public abstract class c extends PopupWindow {
    protected boolean a;
    protected boolean b;
    protected boolean c;
    protected boolean d;
    protected int e;
    private final int[] f;
    private final Rect g;
    private int h;
    private Context i;
    private boolean j;
    private int k;
    private int l;
    private boolean m;
    private int n;
    private int o;
    private a p;
    private ArrayList<com.mg.ola.common.c.a> q;
    private int r;
    private boolean s;
    private int t;
    private int u;
    private int v;
    private int w;
    private int x;
    private int y;

    public interface a {
        void a(c cVar, int i);
    }

    public c(Context context) {
        super(context);
        this.f = new int[2];
        this.g = new Rect();
        this.q = new ArrayList<>();
        this.b = true;
        this.c = true;
        this.u = -1;
        this.v = -1;
        this.d = false;
        this.y = 0;
        this.i = context;
        if (Build.VERSION.SDK_INT < 14) {
            try {
                final Field declaredField = PopupWindow.class.getDeclaredField("mAnchor");
                declaredField.setAccessible(true);
                Field declaredField2 = PopupWindow.class.getDeclaredField("mOnScrollChangedListener");
                declaredField2.setAccessible(true);
                final ViewTreeObserver.OnScrollChangedListener onScrollChangedListener = (ViewTreeObserver.OnScrollChangedListener) declaredField2.get(this);
                declaredField2.set(this, new ViewTreeObserver.OnScrollChangedListener() { // from class: com.mg.ola.common.c.c.1
                    @Override // android.view.ViewTreeObserver.OnScrollChangedListener
                    public void onScrollChanged() {
                        try {
                            if (((View) declaredField.get(c.this)) == null) {
                                return;
                            }
                            onScrollChangedListener.onScrollChanged();
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        }
                    }
                });
            } catch (Exception unused) {
            }
        }
        i();
        setFocusable(true);
        setTouchable(true);
        setOutsideTouchable(true);
        setWidth(-2);
        setHeight(-2);
        WindowManager windowManager = (WindowManager) this.i.getSystemService("window");
        this.o = windowManager.getDefaultDisplay().getWidth();
        this.n = windowManager.getDefaultDisplay().getHeight();
        setSoftInputMode(1);
    }

    private void i() {
        this.j = true;
        this.k = this.i.getResources().getDimensionPixelSize(R.dimen.arrow_offset);
    }

    private void j() {
        View contentView = getContentView();
        if (!this.b) {
            contentView.findViewById(R.id.arrow_down).setVisibility(8);
            contentView.findViewById(R.id.arrow_up).setVisibility(8);
            return;
        }
        int i = this.m ? R.id.arrow_down : R.id.arrow_up;
        View viewFindViewById = contentView.findViewById(i);
        View viewFindViewById2 = contentView.findViewById(R.id.arrow_up);
        View viewFindViewById3 = contentView.findViewById(R.id.arrow_down);
        if (i == R.id.arrow_up) {
            viewFindViewById2.setVisibility(0);
            viewFindViewById3.setVisibility(4);
        } else if (i == R.id.arrow_down) {
            viewFindViewById2.setVisibility(4);
            viewFindViewById3.setVisibility(0);
        }
        ((ViewGroup.MarginLayoutParams) viewFindViewById.getLayoutParams()).leftMargin = ((this.u > 0 ? this.g.left + this.u : this.g.centerX()) - (viewFindViewById.getMeasuredWidth() / 2)) - this.r;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void k() {
        int i;
        switch (this.y) {
            case 0:
                int i2 = this.o;
                boolean z = this.m;
                int iCenterX = this.g.centerX();
                if (iCenterX > i2 / 4) {
                    if (iCenterX < (i2 * 3) / 4) {
                        i = !z ? R.style.QuickAction_Animations_PopDownMenu_Center : R.style.QuickAction_Animations_PopUpMenu_Center;
                    } else if (!z) {
                        i = R.style.QuickAction_Animations_PopDownMenu_Right;
                    } else {
                        i = R.style.QuickAction_Animations_PopUpMenu_Right;
                    }
                } else if (!z) {
                    i = R.style.QuickAction_Animations_PopDownMenu_Left;
                } else {
                    i = R.style.QuickAction_Animations_PopUpMenu_Left;
                }
                break;
            case 1:
                i = R.style.QuickAction_Animations_PopUpMenu_slide_fromleft;
                break;
            case 2:
                i = R.style.QuickAction_Animations_PopUpMenu_slide_fromright;
                break;
            case 3:
                i = R.style.QuickAction_Animations_PopUpMenu_slide_fromtop;
                break;
            case 4:
                i = R.style.QuickAction_Animations_PopUpMenu_slide_frombottom;
                break;
            default:
                return;
        }
        setAnimationStyle(i);
    }

    protected void a() {
    }

    public void a(int i) {
        setContentView(LayoutInflater.from(this.i).inflate(i, (ViewGroup) null));
    }

    protected void a(int i, int i2, boolean z) {
        this.r = i;
        this.l = i2;
        this.m = z;
        this.h |= 2;
    }

    protected abstract void a(Rect rect, View view);

    public void a(View view) {
        View contentView = getContentView();
        if (contentView == null) {
            throw new IllegalStateException("You need to set the content view using the setContentView method");
        }
        setBackgroundDrawable(new ColorDrawable(0));
        int[] iArr = this.f;
        view.getLocationOnScreen(iArr);
        this.g.set(iArr[0], iArr[1], iArr[0] + view.getWidth(), iArr[1] + view.getHeight());
        if (this.a) {
            f();
            a(this.q);
        }
        if (this.s) {
            this.l = this.g.top;
            this.r = this.g.left;
            this.b = false;
        } else {
            a(this.g, contentView);
            if ((this.h & 2) != 2) {
                throw new IllegalStateException("onMeasureAndLayout() did not set the widget specification by calling setWidgetSpecs()");
            }
        }
        if (this.v > 0) {
            this.l += this.m ? this.v : -this.v;
        }
        j();
        if (this.c) {
            k();
        }
        showAtLocation(view, 0, this.r + this.w, this.l + this.x);
    }

    public void a(com.mg.ola.common.c.a aVar) {
        if (aVar != null) {
            this.q.add(aVar);
            this.a = true;
        }
    }

    public void a(a aVar) {
        this.p = aVar;
    }

    protected abstract void a(List<com.mg.ola.common.c.a> list);

    public int b() {
        return this.k;
    }

    protected int c() {
        return this.o;
    }

    protected int d() {
        return this.t == 0 ? this.n : this.t;
    }

    @Override // android.widget.PopupWindow
    public void dismiss() {
        super.dismiss();
    }

    public boolean e() {
        return this.j;
    }

    protected void f() {
        if (this.q.isEmpty()) {
            return;
        }
        a();
    }

    protected Context g() {
        return this.i;
    }

    protected a h() {
        return this.p;
    }

    @Override // android.widget.PopupWindow
    public void setWidth(int i) {
        super.setWidth(i);
        this.e = i;
    }
}
