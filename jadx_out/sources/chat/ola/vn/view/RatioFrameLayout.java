package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public class RatioFrameLayout extends FrameLayout {
    private BASE_SIDE a;
    private double b;

    public enum BASE_SIDE {
        BASE_WIDTH,
        BASE_HEIGHT
    }

    public RatioFrameLayout(Context context) {
        super(context);
        this.a = BASE_SIDE.BASE_WIDTH;
        this.b = 1.7777777777777777d;
    }

    public RatioFrameLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = BASE_SIDE.BASE_WIDTH;
        this.b = 1.7777777777777777d;
    }

    public RatioFrameLayout(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = BASE_SIDE.BASE_WIDTH;
        this.b = 1.7777777777777777d;
    }

    @Override // android.widget.FrameLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        if (this.b != 0.0d) {
            int size = View.MeasureSpec.getSize(i);
            int size2 = View.MeasureSpec.getSize(i2);
            switch (this.a) {
                case BASE_WIDTH:
                    size2 = (int) (((double) size) / this.b);
                    break;
                case BASE_HEIGHT:
                    size = (int) (((double) size2) * this.b);
                    break;
            }
            i = View.MeasureSpec.makeMeasureSpec(size, CrashUtils.ErrorDialogData.SUPPRESSED);
            i2 = View.MeasureSpec.makeMeasureSpec(size2, CrashUtils.ErrorDialogData.SUPPRESSED);
        }
        super.onMeasure(i, i2);
    }

    public void setBaseOrientation(BASE_SIDE base_side) {
        this.a = base_side;
        requestLayout();
    }

    public void setRatio(double d) {
        this.b = d;
        requestLayout();
    }
}
