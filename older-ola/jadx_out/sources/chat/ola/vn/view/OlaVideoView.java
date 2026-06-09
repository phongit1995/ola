package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.widget.VideoView;

/* JADX INFO: loaded from: classes.dex */
public class OlaVideoView extends VideoView {
    public OlaVideoView(Context context) {
        super(context);
        a();
    }

    public OlaVideoView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a();
    }

    public OlaVideoView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        a();
    }

    private void a() {
    }

    @Override // android.widget.VideoView, android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return false;
    }
}
