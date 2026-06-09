package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;

/* JADX INFO: loaded from: classes.dex */
public class OlaSquareHeightCachedImageView extends OlaCachedImageView {
    public OlaSquareHeightCachedImageView(Context context) {
        super(context);
    }

    public OlaSquareHeightCachedImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    public OlaSquareHeightCachedImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onMeasure(int i, int i2) {
        int defaultSize = getDefaultSize(getSuggestedMinimumHeight(), i2);
        setMeasuredDimension(defaultSize, defaultSize);
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i2, i2, i3, i4);
    }
}
