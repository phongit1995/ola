package com.mg.ola.common.widget.date;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.widget.LinearLayout;
import chat.ola.vn.R;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes2.dex */
public class ScrollPickerView extends LinearLayout {
    private static final BitmapFactory.Options a = new BitmapFactory.Options();
    private static final Paint[] b;
    private Rect c;
    private Rect d;
    private Rect e;
    private Rect f;
    private Bitmap g;
    private Bitmap h;
    private Rect[] i;
    private Rect[] j;

    public enum ScrollType {
        Ranged,
        Loop,
        None
    }

    static {
        a.inPreferredConfig = Bitmap.Config.ARGB_8888;
        b = new Paint[]{new Paint(), new Paint(), new Paint()};
        b[0].setColor(-1);
        b[1].setColor(790572847);
        b[2].setColor(-15921649);
    }

    public ScrollPickerView(Context context) {
        super(context);
        this.c = new Rect();
        this.d = new Rect();
        this.e = new Rect();
        this.f = new Rect();
        this.i = new Rect[0];
        this.j = new Rect[0];
        a(context);
    }

    public ScrollPickerView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.c = new Rect();
        this.d = new Rect();
        this.e = new Rect();
        this.f = new Rect();
        this.i = new Rect[0];
        this.j = new Rect[0];
        a(context);
    }

    private int a(int i, float f, float f2) {
        float f3;
        float f4;
        if (f <= 10.0f) {
            f4 = f / f2;
            f3 = i;
        } else {
            f3 = i;
            f4 = 0.1f;
        }
        return (int) (f3 * f4);
    }

    private void a() {
        ArrayList arrayList = new ArrayList();
        for (int i = 0; i < this.i.length; i++) {
            Rect rect = this.i[i];
            Rect rect2 = new Rect(rect.left, rect.top, rect.left + 4, rect.bottom);
            Rect rect3 = new Rect(rect.right - 4, rect.top, rect.right, rect.bottom);
            arrayList.add(rect2);
            arrayList.add(rect3);
        }
        this.j = (Rect[]) arrayList.toArray(new Rect[0]);
    }

    private void a(Context context) {
        this.h = BitmapFactory.decodeResource(context.getResources(), R.drawable.com_ttshrk_view_scroll_picker_bar, a);
        this.c.set(0, 0, this.h.getWidth(), this.h.getHeight());
        this.g = BitmapFactory.decodeResource(context.getResources(), R.drawable.com_ttshrk_view_scroll_picker_background, a);
        this.e.set(0, 0, this.g.getWidth(), this.g.getHeight());
        setBackgroundColor(-1);
    }

    private int b(int i) {
        return (int) (((double) i) * 0.06d);
    }

    public int a(int i) {
        if (i >= getChildCount()) {
            return 0;
        }
        return ((a) getChildAt(i)).a();
    }

    public void a(int i, int i2) {
        if (i >= getChildCount()) {
            return;
        }
        ((a) getChildAt(i)).a(i2);
    }

    public void a(String[] strArr, float f, ScrollType scrollType) {
        a aVarA = f.a(getContext(), scrollType);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-1, -1);
        layoutParams.weight = f;
        aVarA.a(strArr);
        addView(aVarA, layoutParams);
    }

    public void b(int i, int i2) {
        if (i >= getChildCount()) {
            return;
        }
        ((a) getChildAt(i)).b(i2);
    }

    void c(int i, int i2) {
        int childCount = getChildCount();
        Rect rect = new Rect();
        rect.top = b(i2);
        rect.left = b(i);
        rect.bottom = i2 - rect.top;
        rect.right = ((i - rect.left) - (childCount * 4)) + 4;
        float f = 0.0f;
        for (int i3 = 0; i3 < childCount; i3++) {
            f += ((LinearLayout.LayoutParams) getChildAt(i3).getLayoutParams()).weight;
        }
        int i4 = rect.left;
        int i5 = rect.top;
        this.i = new Rect[childCount];
        int i6 = i4;
        for (int i7 = 0; i7 < childCount; i7++) {
            View childAt = getChildAt(i7);
            int iA = a(rect.width(), ((LinearLayout.LayoutParams) childAt.getLayoutParams()).weight, f);
            int i8 = i6 + iA;
            childAt.layout(i6, i5, i8, rect.height() + i5);
            this.i[i7] = new Rect(i6, 0, i8, i2);
            i6 += iA + 4;
        }
        a();
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchDraw(Canvas canvas) {
        canvas.drawRect(this.f, b[2]);
        for (int i = 0; i < this.i.length; i++) {
            canvas.drawRect(this.i[i], b[0]);
        }
        for (int i2 = 0; i2 < this.j.length; i2++) {
            canvas.drawRect(this.j[i2], b[1]);
        }
        canvas.drawBitmap(this.h, this.c, this.d, (Paint) null);
        int childCount = getChildCount();
        long drawingTime = getDrawingTime();
        for (int i3 = 0; i3 < childCount; i3++) {
            drawChild(canvas, getChildAt(i3), drawingTime);
        }
        canvas.drawBitmap(this.g, this.e, this.f, (Paint) null);
    }

    public int[] getAllSlotIndexes() {
        int childCount = getChildCount();
        int[] iArr = new int[childCount];
        for (int i = 0; i < childCount; i++) {
            iArr[i] = ((a) getChildAt(i)).a();
        }
        return iArr;
    }

    @Override // android.widget.LinearLayout, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        Log.i("Datetimepicker#onLayout", "ch:" + z + ", l:" + i + ", t:" + i2 + ", r:" + i3 + ", b:" + i4);
        if (z) {
            c(i3 - i, i4 - i2);
        }
    }

    @Override // android.view.View
    public void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        int iWidth = (int) ((i / this.e.width()) * this.c.width());
        int iHeight = (int) ((i2 / this.e.height()) * this.c.height());
        this.d.set((-iWidth) / 2, (-iHeight) / 2, iWidth / 2, iHeight / 2);
        this.d.offset(i / 2, i2 / 2);
        this.f.set(0, 0, i, i2);
    }
}
