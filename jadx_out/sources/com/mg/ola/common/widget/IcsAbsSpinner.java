package com.mg.ola.common.widget;

import android.content.Context;
import android.database.DataSetObserver;
import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SpinnerAdapter;
import com.mg.ola.common.widget.a;

/* JADX INFO: loaded from: classes2.dex */
public abstract class IcsAbsSpinner extends com.mg.ola.common.widget.a<SpinnerAdapter> {
    private DataSetObserver F;
    SpinnerAdapter a;
    int b;
    int c;
    boolean d;
    int e;
    int f;
    int g;
    int h;
    final Rect i;
    final a j;

    static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new Parcelable.Creator<SavedState>() { // from class: com.mg.ola.common.widget.IcsAbsSpinner.SavedState.1
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
        int b;

        private SavedState(Parcel parcel) {
            super(parcel);
            this.a = parcel.readLong();
            this.b = parcel.readInt();
        }

        SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        public String toString() {
            return "AbsSpinner.SavedState{" + Integer.toHexString(System.identityHashCode(this)) + " selectedId=" + this.a + " position=" + this.b + "}";
        }

        @Override // android.view.View.BaseSavedState, android.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeLong(this.a);
            parcel.writeInt(this.b);
        }
    }

    class a {
        private final SparseArray<View> b = new SparseArray<>();

        a() {
        }

        View a(int i) {
            View view = this.b.get(i);
            if (view != null) {
                this.b.delete(i);
            }
            return view;
        }

        public void a(int i, View view) {
            this.b.put(i, view);
        }
    }

    public IcsAbsSpinner(Context context) {
        super(context);
        this.e = 0;
        this.f = 0;
        this.g = 0;
        this.h = 0;
        this.i = new Rect();
        this.j = new a();
        i();
    }

    public IcsAbsSpinner(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public IcsAbsSpinner(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.e = 0;
        this.f = 0;
        this.g = 0;
        this.h = 0;
        this.i = new Rect();
        this.j = new a();
        i();
    }

    private void i() {
        setFocusable(true);
        setWillNotDraw(false);
    }

    int a(View view) {
        return view.getMeasuredHeight();
    }

    void a() {
        this.v = false;
        this.p = false;
        removeAllViewsInLayout();
        this.C = -1;
        this.D = Long.MIN_VALUE;
        setSelectedPositionInt(-1);
        setNextSelectedPositionInt(-1);
        invalidate();
    }

    int b(View view) {
        return view.getMeasuredWidth();
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateDefaultLayoutParams() {
        return new ViewGroup.LayoutParams(-1, -2);
    }

    @Override // com.mg.ola.common.widget.a
    public SpinnerAdapter getAdapter() {
        return this.a;
    }

    @Override // com.mg.ola.common.widget.a
    public int getCount() {
        return this.A;
    }

    @Override // com.mg.ola.common.widget.a
    public View getSelectedView() {
        if (this.A <= 0 || this.y < 0) {
            return null;
        }
        return getChildAt(this.y - this.k);
    }

    /* JADX WARN: Removed duplicated region for block: B:37:0x00a6  */
    @Override // android.view.View
    @android.annotation.TargetApi(11)
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void onMeasure(int r8, int r9) {
        /*
            Method dump skipped, instruction units count: 238
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.mg.ola.common.widget.IcsAbsSpinner.onMeasure(int, int):void");
    }

    @Override // android.view.View
    public void onRestoreInstanceState(Parcelable parcelable) {
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.getSuperState());
        if (savedState.a >= 0) {
            this.v = true;
            this.p = true;
            this.n = savedState.a;
            this.m = savedState.b;
            this.q = 0;
            requestLayout();
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.view.View
    public Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        savedState.a = getSelectedItemId();
        savedState.b = savedState.a >= 0 ? getSelectedItemPosition() : -1;
        return savedState;
    }

    @Override // android.view.View, android.view.ViewParent
    public void requestLayout() {
        if (this.d) {
            return;
        }
        super.requestLayout();
    }

    @Override // com.mg.ola.common.widget.a
    public void setAdapter(SpinnerAdapter spinnerAdapter) {
        if (this.a != null) {
            this.a.unregisterDataSetObserver(this.F);
            a();
        }
        this.a = spinnerAdapter;
        this.C = -1;
        this.D = Long.MIN_VALUE;
        if (this.a != null) {
            this.B = this.A;
            this.A = this.a.getCount();
            c();
            this.F = new a.C0081a();
            this.a.registerDataSetObserver(this.F);
            int i = this.A > 0 ? 0 : -1;
            setSelectedPositionInt(i);
            setNextSelectedPositionInt(i);
            if (this.A == 0) {
            }
            requestLayout();
        }
        c();
        a();
        f();
        requestLayout();
    }

    @Override // com.mg.ola.common.widget.a
    public void setSelection(int i) {
        setNextSelectedPositionInt(i);
        requestLayout();
        invalidate();
    }
}
