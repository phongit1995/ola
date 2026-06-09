package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;

/* JADX INFO: loaded from: classes.dex */
public class OlaSquareCachedImageView extends OlaCachedImageView {
    public OlaSquareCachedImageView(Context context) {
        super(context);
    }

    public OlaSquareCachedImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    public OlaSquareCachedImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onMeasure(int i, int i2) {
        int defaultSize = getDefaultSize(getSuggestedMinimumWidth(), i);
        setMeasuredDimension(defaultSize, defaultSize);
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i, i3, i4);
    }
}
