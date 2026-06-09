package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;
import com.mg.ola.common.widget.RotateImageView;

/* JADX INFO: loaded from: classes.dex */
public class ShutterButton extends RotateImageView {
    private a a;
    private boolean b;

    public interface a {
        void a(ShutterButton shutterButton);

        void a(ShutterButton shutterButton, boolean z);
    }

    public ShutterButton(Context context) {
        super(context);
    }

    public ShutterButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    public ShutterButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        if (this.a != null) {
            this.a.a(this, z);
        }
    }

    @Override // android.widget.ImageView, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        final boolean zIsPressed = isPressed();
        if (zIsPressed != this.b) {
            if (zIsPressed) {
                a(zIsPressed);
            } else {
                post(new Runnable() { // from class: chat.ola.vn.view.ShutterButton.1
                    @Override // java.lang.Runnable
                    public void run() {
                        ShutterButton.this.a(zIsPressed);
                    }
                });
            }
            this.b = zIsPressed;
        }
    }

    @Override // android.view.View
    public boolean performClick() {
        boolean zPerformClick = super.performClick();
        if (this.a != null) {
            this.a.a(this);
        }
        return zPerformClick;
    }

    public void setOnShutterButtonListener(a aVar) {
        this.a = aVar;
    }
}
