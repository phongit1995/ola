package chat.ola.vn.view;

import android.animation.LayoutTransition;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.database.DataSetObserver;
import android.graphics.Canvas;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaGalleryView extends HorizontalScrollView implements GestureDetector.OnGestureListener, View.OnClickListener {
    protected LinearLayout a;
    private ListAdapter b;
    private AdapterView.OnItemClickListener c;
    private List<View> d;
    private List<View> e;
    private int f;

    public OlaGalleryView(Context context) {
        super(context);
        this.f = 5;
        c();
    }

    public OlaGalleryView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f = 5;
        c();
    }

    public OlaGalleryView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f = 5;
        c();
    }

    @SuppressLint({"NewApi"})
    private void c() {
        try {
            setHorizontalScrollBarEnabled(false);
            setFillViewport(true);
            this.a = new LinearLayout(getContext());
            if (com.mg.ola.common.d.g.c()) {
                this.a.setLayoutTransition(new LayoutTransition());
            }
            this.a.setOrientation(0);
            this.a.setGravity(19);
            this.d = new ArrayList();
            this.e = new ArrayList();
            addView(this.a, new ViewGroup.LayoutParams(-2, -1));
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        try {
            if (this.b == null) {
                return;
            }
            int size = this.d.size();
            int size2 = this.e.size();
            int count = this.b.getCount();
            try {
                int childCount = ((this.a.getChildCount() - size) - size2) - count;
                if (childCount > 0) {
                    this.a.removeViews(size + count, childCount);
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
            for (int i = 0; i < count; i++) {
                int i2 = size + i;
                View childAt = this.a.getChildCount() <= (size + size2) + i ? null : this.a.getChildAt(i2);
                View view = this.b.getView(i, childAt, this.a);
                view.setOnClickListener(this);
                LinearLayout.LayoutParams layoutParams = view.getLayoutParams() != null ? new LinearLayout.LayoutParams(view.getLayoutParams()) : new LinearLayout.LayoutParams(-2, -2);
                layoutParams.setMargins(this.f, 0, 0, 0);
                if (childAt == null) {
                    this.a.addView(view, i2, layoutParams);
                }
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    public void a() {
        d();
    }

    public void a(View view) {
        if (view != null) {
            this.a.addView(view);
            this.e.add(view);
        }
    }

    public void b() {
        if (this.a.getChildCount() > 0) {
            View childAt = this.a.getChildAt(this.a.getChildCount() - 1);
            smoothScrollTo(childAt.getLeft(), childAt.getTop());
        }
    }

    public int getLeftItemCount() {
        return this.d.size();
    }

    public int getRightItemCount() {
        return this.e.size();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        if (this.c != null) {
            int iIndexOfChild = this.a.indexOfChild(view) - this.d.size();
            this.c.onItemClick(null, view, iIndexOfChild, iIndexOfChild);
        }
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onDown(MotionEvent motionEvent) {
        return false;
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onFling(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        return false;
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public void onLongPress(MotionEvent motionEvent) {
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onScroll(MotionEvent motionEvent, MotionEvent motionEvent2, float f, float f2) {
        return false;
    }

    @Override // android.view.View
    protected void onScrollChanged(int i, int i2, int i3, int i4) {
        super.onScrollChanged(i, i2, i3, i4);
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public void onShowPress(MotionEvent motionEvent) {
    }

    @Override // android.view.GestureDetector.OnGestureListener
    public boolean onSingleTapUp(MotionEvent motionEvent) {
        return false;
    }

    public void setAdapter(ListAdapter listAdapter) {
        this.b = listAdapter;
        this.b.registerDataSetObserver(new DataSetObserver() { // from class: chat.ola.vn.view.OlaGalleryView.2
            @Override // android.database.DataSetObserver
            public void onChanged() {
                super.onChanged();
                OlaGalleryView.this.d();
            }
        });
        d();
    }

    public void setChildSpace(int i) {
        this.f = i;
    }

    public void setChildSpaceRes(int i) {
        try {
            this.f = getResources().getDimensionPixelSize(i);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void setDisplayChild(int i) {
        final View childAt = this.a.getChildAt(i);
        if (childAt == null) {
            return;
        }
        post(new Runnable() { // from class: chat.ola.vn.view.OlaGalleryView.1
            @Override // java.lang.Runnable
            public void run() {
                OlaGalleryView.this.smoothScrollTo(childAt.getLeft() - ((OlaGalleryView.this.getWidth() - childAt.getWidth()) / 2), 0);
            }
        });
    }

    @TargetApi(11)
    public void setEnableLayoutAnimation(boolean z) {
        LinearLayout linearLayout;
        LayoutTransition layoutTransition;
        if (z) {
            if (!com.mg.ola.common.d.g.c()) {
                return;
            }
            linearLayout = this.a;
            layoutTransition = new LayoutTransition();
        } else {
            if (!com.mg.ola.common.d.g.c()) {
                return;
            }
            linearLayout = this.a;
            layoutTransition = null;
        }
        linearLayout.setLayoutTransition(layoutTransition);
    }

    public void setOnItemClickListener(AdapterView.OnItemClickListener onItemClickListener) {
        this.c = onItemClickListener;
    }
}
