package chat.ola.vn.view;

import android.annotation.TargetApi;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public class FocusIndicatorView extends View {
    public FocusIndicatorView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    @TargetApi(16)
    private void setDrawable(int i) {
        if (com.mg.ola.common.d.g.g()) {
            setBackground(getResources().getDrawable(i));
        } else {
            setBackgroundDrawable(getResources().getDrawable(i));
        }
    }
}
