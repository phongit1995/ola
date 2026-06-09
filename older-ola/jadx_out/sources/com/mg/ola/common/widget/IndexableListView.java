package com.mg.ola.common.widget;

import android.content.Context;
import android.graphics.Canvas;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.widget.ListAdapter;
import android.widget.ListView;

/* JADX INFO: loaded from: classes2.dex */
public class IndexableListView extends ListView {
    private boolean a;
    private c b;
    private GestureDetector c;

    public IndexableListView(Context context) {
        super(context);
        this.a = false;
        this.b = null;
        this.c = null;
    }

    public IndexableListView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = false;
        this.b = null;
        this.c = null;
    }

    public IndexableListView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = false;
        this.b = null;
        this.c = null;
    }

    @Override // android.widget.AbsListView, android.view.View
    public void draw(Canvas canvas) {
        super.draw(canvas);
        if (this.b != null) {
            this.b.a(canvas);
        }
    }

    @Override // android.widget.AbsListView
    public boolean isFastScrollEnabled() {
        return this.a;
    }

    @Override // android.widget.AbsListView, android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        return true;
    }

    @Override // android.widget.ListView, android.widget.AbsListView, android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        if (this.b != null) {
            this.b.a(i, i2, i3, i4);
        }
    }

    @Override // android.widget.AbsListView, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (this.b != null && this.b.a(motionEvent)) {
            return true;
        }
        if (this.c == null) {
            this.c = new GestureDetector(getContext(), new GestureDetector.SimpleOnGestureListener() { // from class: com.mg.ola.common.widget.IndexableListView.1
                @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
                public boolean onFling(MotionEvent motionEvent2, MotionEvent motionEvent3, float f, float f2) {
                    if (IndexableListView.this.b != null) {
                        IndexableListView.this.b.a();
                    }
                    return super.onFling(motionEvent2, motionEvent3, f, f2);
                }
            });
        }
        this.c.onTouchEvent(motionEvent);
        return super.onTouchEvent(motionEvent);
    }

    @Override // android.widget.AdapterView
    public void setAdapter(ListAdapter listAdapter) {
        super.setAdapter(listAdapter);
        if (this.b != null) {
            this.b.a(listAdapter);
        }
    }

    @Override // android.widget.AbsListView
    public void setFastScrollEnabled(boolean z) {
        c cVar;
        this.a = z;
        if (this.a) {
            if (this.b != null) {
                return;
            } else {
                cVar = new c(getContext(), this);
            }
        } else {
            if (this.b == null) {
                return;
            }
            this.b.b();
            cVar = null;
        }
        this.b = cVar;
    }
}
