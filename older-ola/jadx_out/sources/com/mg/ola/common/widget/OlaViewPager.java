package com.mg.ola.common.widget;

import android.content.Context;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public class OlaViewPager extends ViewPager {
    private boolean a;
    private List<ViewGroup> b;

    public OlaViewPager(Context context) {
        super(context);
        this.a = true;
        this.b = new ArrayList();
    }

    public OlaViewPager(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = true;
        this.b = new ArrayList();
    }

    @Override // android.support.v4.view.ViewPager, android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        if (!this.a) {
            return false;
        }
        for (ViewGroup viewGroup : this.b) {
            if (viewGroup.getVisibility() == 0) {
                viewGroup.requestDisallowInterceptTouchEvent(true);
            }
        }
        try {
            return super.onInterceptTouchEvent(motionEvent);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override // android.support.v4.view.ViewPager, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (this.a) {
            return super.onTouchEvent(motionEvent);
        }
        return false;
    }

    public void setPagingEnabled(boolean z) {
        this.a = z;
    }
}
