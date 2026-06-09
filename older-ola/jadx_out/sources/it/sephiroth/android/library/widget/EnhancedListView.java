package it.sephiroth.android.library.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Rect;
import android.os.Build;
import android.os.Handler;
import android.os.Message;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.AbsListView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.TextView;
import chat.ola.vn.R;
import com.mg.ola.a.a.b.a;
import com.mg.ola.a.a.b.n;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

/* JADX INFO: loaded from: classes2.dex */
public class EnhancedListView extends ListView {
    private float A;
    private PopupWindow B;
    private int C;
    private Handler D;
    private Button E;
    private View F;
    private float a;
    private int b;
    private int c;
    private long d;
    private final Object[] e;
    private boolean f;
    private b g;
    private c h;
    private UndoStyle i;
    private boolean j;
    private SwipeDirection k;
    private long l;
    private int m;
    private List<f> n;
    private SortedSet<d> o;
    private List<View> p;
    private int q;
    private boolean r;
    private boolean s;
    private int t;
    private View u;
    private View v;
    private TextView w;
    private VelocityTracker x;
    private float y;
    private int z;

    public enum SwipeDirection {
        BOTH,
        START,
        END
    }

    public enum UndoStyle {
        SINGLE_POPUP,
        MULTILEVEL_POPUP,
        COLLAPSED_POPUP
    }

    private class a extends Handler {
        private a() {
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            if (message.what == EnhancedListView.this.C) {
                EnhancedListView.this.b();
            }
        }
    }

    public interface b {
        f a(EnhancedListView enhancedListView, int i);
    }

    public interface c {
        boolean a(EnhancedListView enhancedListView, int i);
    }

    private class d implements Comparable<d> {
        public int a;
        public View b;
        public View c;

        d(int i, View view, View view2) {
            this.a = i;
            this.b = view;
            this.c = view2;
        }

        @Override // java.lang.Comparable
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public int compareTo(d dVar) {
            return dVar.a - this.a;
        }
    }

    private class e implements View.OnClickListener {
        private e() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (!EnhancedListView.this.n.isEmpty()) {
                switch (EnhancedListView.this.i) {
                    case SINGLE_POPUP:
                        ((f) EnhancedListView.this.n.get(0)).a();
                        EnhancedListView.this.n.clear();
                        break;
                    case COLLAPSED_POPUP:
                        Collections.reverse(EnhancedListView.this.n);
                        Iterator it2 = EnhancedListView.this.n.iterator();
                        while (it2.hasNext()) {
                            ((f) it2.next()).a();
                        }
                        EnhancedListView.this.n.clear();
                        break;
                    case MULTILEVEL_POPUP:
                        ((f) EnhancedListView.this.n.get(EnhancedListView.this.n.size() - 1)).a();
                        EnhancedListView.this.n.remove(EnhancedListView.this.n.size() - 1);
                        break;
                }
            }
            if (!EnhancedListView.this.n.isEmpty()) {
                EnhancedListView.this.c();
                EnhancedListView.this.d();
            } else if (EnhancedListView.this.B.isShowing()) {
                EnhancedListView.this.B.dismiss();
            }
            EnhancedListView.f(EnhancedListView.this);
        }
    }

    public static abstract class f {
        public abstract void a();

        public void b() {
        }

        public String c() {
            return null;
        }
    }

    public EnhancedListView(Context context) {
        super(context);
        this.e = new Object[0];
        this.i = UndoStyle.SINGLE_POPUP;
        this.j = true;
        this.k = SwipeDirection.BOTH;
        this.l = 5000L;
        this.n = new ArrayList();
        this.o = new TreeSet();
        this.p = new LinkedList();
        this.t = 1;
        this.D = new a();
        a(context);
    }

    public EnhancedListView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.e = new Object[0];
        this.i = UndoStyle.SINGLE_POPUP;
        this.j = true;
        this.k = SwipeDirection.BOTH;
        this.l = 5000L;
        this.n = new ArrayList();
        this.o = new TreeSet();
        this.p = new LinkedList();
        this.t = 1;
        this.D = new a();
        a(context);
    }

    public EnhancedListView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.e = new Object[0];
        this.i = UndoStyle.SINGLE_POPUP;
        this.j = true;
        this.k = SwipeDirection.BOTH;
        this.l = 5000L;
        this.n = new ArrayList();
        this.o = new TreeSet();
        this.p = new LinkedList();
        this.t = 1;
        this.D = new a();
        a(context);
    }

    private void a(Context context) {
        if (isInEditMode()) {
            return;
        }
        ViewConfiguration viewConfiguration = ViewConfiguration.get(context);
        this.a = getResources().getDimension(R.dimen.metric_32dp);
        this.b = viewConfiguration.getScaledMinimumFlingVelocity();
        this.c = viewConfiguration.getScaledMaximumFlingVelocity();
        this.d = context.getResources().getInteger(android.R.integer.config_shortAnimTime);
        this.F = ((LayoutInflater) getContext().getSystemService("layout_inflater")).inflate(R.layout.elv_undo_popup, (ViewGroup) null);
        this.E = (Button) this.F.findViewById(R.id.undo);
        this.E.setOnClickListener(new e());
        this.E.setOnTouchListener(new View.OnTouchListener() { // from class: it.sephiroth.android.library.widget.EnhancedListView.1
            @Override // android.view.View.OnTouchListener
            public boolean onTouch(View view, MotionEvent motionEvent) {
                EnhancedListView.f(EnhancedListView.this);
                return false;
            }
        });
        this.w = (TextView) this.F.findViewById(R.id.text);
        this.B = new PopupWindow(this.F, -2, -2, false);
        this.B.setAnimationStyle(R.style.elv_fade_animation);
        this.A = getResources().getDisplayMetrics().density;
        setOnScrollListener(e());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final View view, final View view2, int i) {
        final ViewGroup.LayoutParams layoutParams = view2.getLayoutParams();
        final int i2 = layoutParams.height;
        n nVarA = n.b(view2.getHeight(), 1).a(this.d);
        nVarA.a(new com.mg.ola.a.a.b.b() { // from class: it.sephiroth.android.library.widget.EnhancedListView.3
            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            public void a(com.mg.ola.a.a.b.a aVar) {
                boolean z;
                synchronized (EnhancedListView.this.e) {
                    EnhancedListView.i(EnhancedListView.this);
                    EnhancedListView.this.p.remove(view);
                    z = EnhancedListView.this.q == 0;
                }
                if (z) {
                    for (d dVar : EnhancedListView.this.o) {
                        if (EnhancedListView.this.i == UndoStyle.SINGLE_POPUP) {
                            Iterator it2 = EnhancedListView.this.n.iterator();
                            while (it2.hasNext()) {
                                ((f) it2.next()).b();
                            }
                            EnhancedListView.this.n.clear();
                        }
                        f fVarA = EnhancedListView.this.g.a(EnhancedListView.this, dVar.a);
                        if (fVarA != null) {
                            EnhancedListView.this.n.add(fVarA);
                        }
                        EnhancedListView.f(EnhancedListView.this);
                    }
                    if (!EnhancedListView.this.n.isEmpty()) {
                        EnhancedListView.this.c();
                        EnhancedListView.this.d();
                        EnhancedListView.this.getResources().getDimension(R.dimen.metric_16dp);
                        int[] iArr = new int[2];
                        view.getLocationInWindow(iArr);
                        float f2 = iArr[1];
                        EnhancedListView.this.B.setWidth((int) Math.min(EnhancedListView.this.A * 400.0f, EnhancedListView.this.getWidth() * 0.9f));
                        EnhancedListView.this.B.showAtLocation(EnhancedListView.this, 49, 0, (int) f2);
                        if (!EnhancedListView.this.j) {
                            EnhancedListView.this.D.sendMessageDelayed(EnhancedListView.this.D.obtainMessage(EnhancedListView.this.C), EnhancedListView.this.l);
                        }
                    }
                    for (d dVar2 : EnhancedListView.this.o) {
                        com.mg.ola.a.a.c.b.a(dVar2.b, 1.0f);
                        com.mg.ola.a.a.c.b.e(dVar2.b, 0.0f);
                        ViewGroup.LayoutParams layoutParams2 = dVar2.c.getLayoutParams();
                        layoutParams2.height = i2;
                        dVar2.c.setLayoutParams(layoutParams2);
                    }
                    EnhancedListView.this.o.clear();
                }
            }
        });
        nVarA.a(new n.b() { // from class: it.sephiroth.android.library.widget.EnhancedListView.4
            @Override // com.mg.ola.a.a.b.n.b
            public void a(n nVar) {
                layoutParams.height = ((Integer) nVar.l()).intValue();
                view2.setLayoutParams(layoutParams);
            }
        });
        this.o.add(new d(i, view, view2));
        nVarA.a();
    }

    private void a(final View view, final View view2, final int i, boolean z) {
        synchronized (this.e) {
            if (this.p.contains(view)) {
                return;
            }
            this.q++;
            this.p.add(view);
            com.mg.ola.a.a.c.c.a(view).a(z ? this.t : -this.t).b(0.0f).a(this.d).a(new com.mg.ola.a.a.b.b() { // from class: it.sephiroth.android.library.widget.EnhancedListView.2
                @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                public void a(com.mg.ola.a.a.b.a aVar) {
                    EnhancedListView.this.a(view, view2, i);
                }
            });
        }
    }

    @SuppressLint({"NewApi"})
    private boolean a(float f2) {
        int i = (Build.VERSION.SDK_INT < 17 || getLayoutDirection() != 1) ? 1 : -1;
        switch (this.k) {
            case START:
                if (i * f2 < 0.0f) {
                }
                break;
            case END:
                if (i * f2 > 0.0f) {
                }
                break;
        }
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c() {
        String strC;
        if (this.n.size() > 1) {
            strC = getResources().getString(R.string.string_deleted, Integer.valueOf(this.n.size()));
        } else if (this.n.size() >= 1) {
            strC = this.n.get(this.n.size() - 1).c();
            if (strC == null) {
                strC = getResources().getString(R.string.string_deleted);
            }
        } else {
            strC = null;
        }
        this.w.setText(strC);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        Resources resources;
        int i;
        if (this.n.size() <= 1 || this.i != UndoStyle.COLLAPSED_POPUP) {
            resources = getResources();
            i = R.string.string_undo;
        } else {
            resources = getResources();
            i = R.string.string_undo_all;
        }
        this.E.setText(resources.getString(i));
    }

    private AbsListView.OnScrollListener e() {
        return new AbsListView.OnScrollListener() { // from class: it.sephiroth.android.library.widget.EnhancedListView.5
            @Override // android.widget.AbsListView.OnScrollListener
            public void onScroll(AbsListView absListView, int i, int i2, int i3) {
            }

            @Override // android.widget.AbsListView.OnScrollListener
            public void onScrollStateChanged(AbsListView absListView, int i) {
                EnhancedListView.this.r = i == 1;
            }
        };
    }

    static /* synthetic */ int f(EnhancedListView enhancedListView) {
        int i = enhancedListView.C;
        enhancedListView.C = i + 1;
        return i;
    }

    static /* synthetic */ int i(EnhancedListView enhancedListView) {
        int i = enhancedListView.q - 1;
        enhancedListView.q = i;
        return i;
    }

    public EnhancedListView a() {
        if (this.g == null) {
            throw new IllegalStateException("You must pass an OnDismissCallback to the list before enabling Swipe to Dismiss.");
        }
        this.f = true;
        return this;
    }

    public EnhancedListView a(int i) {
        this.m = i;
        return this;
    }

    public EnhancedListView a(long j) {
        this.l = j;
        return this;
    }

    public EnhancedListView a(SwipeDirection swipeDirection) {
        this.k = swipeDirection;
        return this;
    }

    public EnhancedListView a(UndoStyle undoStyle) {
        this.i = undoStyle;
        return this;
    }

    public EnhancedListView a(b bVar) {
        this.g = bVar;
        return this;
    }

    public EnhancedListView a(boolean z) {
        this.j = z;
        return this;
    }

    public void b() {
        Iterator<f> it2 = this.n.iterator();
        while (it2.hasNext()) {
            it2.next().b();
        }
        this.n.clear();
        if (this.B.isShowing()) {
            this.B.dismiss();
        }
    }

    @Override // android.widget.AbsListView, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        View viewFindViewById;
        boolean z;
        if (!this.f) {
            return super.onTouchEvent(motionEvent);
        }
        if (this.B.isShowing()) {
            this.D.sendMessage(this.D.obtainMessage(this.C));
        }
        if (this.t < 2) {
            this.t = getWidth();
        }
        boolean z2 = true;
        switch (motionEvent.getActionMasked()) {
            case 0:
                if (this.r) {
                    return super.onTouchEvent(motionEvent);
                }
                Rect rect = new Rect();
                int childCount = getChildCount();
                int[] iArr = new int[2];
                getLocationOnScreen(iArr);
                int rawX = ((int) motionEvent.getRawX()) - iArr[0];
                int rawY = ((int) motionEvent.getRawY()) - iArr[1];
                int headerViewsCount = getHeaderViewsCount();
                while (true) {
                    if (headerViewsCount < childCount) {
                        View childAt = getChildAt(headerViewsCount);
                        if (childAt != null) {
                            childAt.getHitRect(rect);
                            if (rect.contains(rawX, rawY)) {
                                if (this.m <= 0 || (viewFindViewById = childAt.findViewById(this.m)) == null) {
                                    this.v = childAt;
                                    this.u = childAt;
                                } else {
                                    this.u = viewFindViewById;
                                    this.v = childAt;
                                }
                            }
                        }
                        headerViewsCount++;
                    }
                }
                if (this.u != null) {
                    int positionForView = getPositionForView(this.u) - getHeaderViewsCount();
                    if (this.h == null || this.h.a(this, positionForView)) {
                        this.y = motionEvent.getRawX();
                        this.z = positionForView;
                        this.x = VelocityTracker.obtain();
                        this.x.addMovement(motionEvent);
                    } else {
                        this.v = null;
                        this.u = null;
                    }
                }
                super.onTouchEvent(motionEvent);
                return true;
            case 1:
                if (this.x != null) {
                    float rawX2 = motionEvent.getRawX() - this.y;
                    this.x.addMovement(motionEvent);
                    this.x.computeCurrentVelocity(1000);
                    float fAbs = Math.abs(this.x.getXVelocity());
                    float fAbs2 = Math.abs(this.x.getYVelocity());
                    if (Math.abs(rawX2) > this.t / 2 && this.s) {
                        z = rawX2 > 0.0f;
                    } else if (this.b > fAbs || fAbs > this.c || fAbs2 >= fAbs || !this.s || !a(this.x.getXVelocity()) || rawX2 < this.t * 0.2f) {
                        z = false;
                        z2 = false;
                    } else if (this.x.getXVelocity() > 0.0f) {
                    }
                    if (z2) {
                        a(this.u, this.v, this.z, z);
                    } else if (this.s) {
                        com.mg.ola.a.a.c.c.a(this.u).a(0.0f).b(1.0f).a(this.d).a((a.InterfaceC0079a) null);
                    }
                    this.x = null;
                    this.y = 0.0f;
                    this.u = null;
                    this.v = null;
                    this.z = -1;
                    this.s = false;
                }
                break;
            case 2:
                if (this.x != null && !this.r) {
                    this.x.addMovement(motionEvent);
                    float rawX3 = motionEvent.getRawX() - this.y;
                    if (a(rawX3)) {
                        ViewParent parent = getParent();
                        if (parent != null) {
                            parent.requestDisallowInterceptTouchEvent(true);
                        }
                        if (Math.abs(rawX3) > this.a) {
                            this.s = true;
                            requestDisallowInterceptTouchEvent(true);
                            MotionEvent motionEventObtain = MotionEvent.obtain(motionEvent);
                            motionEventObtain.setAction((motionEvent.getActionIndex() << 8) | 3);
                            super.onTouchEvent(motionEventObtain);
                        }
                    } else {
                        this.y = motionEvent.getRawX();
                        rawX3 = 0.0f;
                    }
                    if (this.s) {
                        com.mg.ola.a.a.c.b.e(this.u, rawX3);
                        com.mg.ola.a.a.c.b.a(this.u, Math.max(0.0f, Math.min(1.0f, 1.0f - ((Math.abs(rawX3) * 2.0f) / this.t))));
                        return true;
                    }
                }
                break;
        }
        return super.onTouchEvent(motionEvent);
    }

    @Override // android.view.View
    protected void onWindowVisibilityChanged(int i) {
        super.onWindowVisibilityChanged(i);
        if (i != 0) {
            b();
        }
    }
}
