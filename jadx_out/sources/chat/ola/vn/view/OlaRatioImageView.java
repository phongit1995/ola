package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public class OlaRatioImageView extends OlaCachedImageView {
    private BASE_SIDE e;
    private double f;

    public enum BASE_SIDE {
        BASE_WIDTH,
        BASE_HEIGHT
    }

    public OlaRatioImageView(Context context) {
        super(context);
        this.e = BASE_SIDE.BASE_WIDTH;
        this.f = 1.7777777777777777d;
        a();
    }

    public OlaRatioImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.e = BASE_SIDE.BASE_WIDTH;
        this.f = 1.7777777777777777d;
        a();
    }

    public OlaRatioImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.e = BASE_SIDE.BASE_WIDTH;
        this.f = 1.7777777777777777d;
        a();
    }

    private void a() {
    }

    @Override // android.widget.ImageView, android.view.View
    @SuppressLint({"NewApi"})
    protected void onMeasure(int i, int i2) {
        if (this.f == 0.0d) {
            super.onMeasure(i, i2);
            return;
        }
        int size = View.MeasureSpec.getSize(i);
        int size2 = View.MeasureSpec.getSize(i2);
        switch (this.e) {
            case BASE_WIDTH:
                size2 = (int) (((double) size) / this.f);
                int maxHeight = com.mg.ola.common.d.g.g() ? getMaxHeight() : this.d;
                if (size2 > maxHeight && maxHeight > 0) {
                    size2 = maxHeight;
                }
                break;
            case BASE_HEIGHT:
                size = (int) (((double) size2) * this.f);
                int maxWidth = com.mg.ola.common.d.g.g() ? getMaxWidth() : this.c;
                if (size > maxWidth && maxWidth > 0) {
                    size = maxWidth;
                }
                break;
        }
        setMeasuredDimension(size, size2);
    }

    public void setBaseOrientation(BASE_SIDE base_side) {
        this.e = base_side;
        requestLayout();
    }

    public void setRatio(double d) {
        if (this.f != d) {
            this.f = d;
            requestLayout();
        }
    }
}
