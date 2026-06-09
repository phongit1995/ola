package chat.ola.vn.view;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.hardware.Camera;
import android.util.AttributeSet;
import android.view.View;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class FaceView extends View {
    private final String a;
    private final boolean b;
    private int c;
    private int d;
    private boolean e;
    private boolean f;
    private Matrix g;
    private RectF h;
    private chat.ola.vn.util.a.b[] i;
    private Drawable j;
    private final Drawable k;
    private final Drawable l;
    private final Drawable m;

    public FaceView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = "FaceView";
        this.b = false;
        this.g = new Matrix();
        this.h = new RectF();
        this.k = getResources().getDrawable(R.drawable.ic_focus_focusing);
        this.l = getResources().getDrawable(R.drawable.ic_focus_face_focused);
        this.m = getResources().getDrawable(R.drawable.ic_focus_failed);
        this.j = this.k;
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        if (this.i != null && this.i.length > 0) {
            chat.ola.vn.util.a.a.a(this.g, this.e, this.c, getWidth(), getHeight());
            canvas.save();
            this.g.postRotate(this.d);
            canvas.rotate(-this.d);
            for (int i = 0; i < this.i.length; i++) {
                this.h.set(this.i[i].a);
                this.g.mapRect(this.h);
                this.j.setBounds(Math.round(this.h.left), Math.round(this.h.top), Math.round(this.h.right), Math.round(this.h.bottom));
                this.j.draw(canvas);
            }
            canvas.restore();
        }
        super.onDraw(canvas);
    }

    public void setDisplayOrientation(int i) {
        this.c = i;
    }

    public void setFaces(Camera.Face[] faceArr) {
        if (this.f) {
            return;
        }
        this.i = new chat.ola.vn.util.a.b[faceArr.length];
        int length = faceArr.length;
        for (int i = 0; i < length; i++) {
            this.i[i] = new chat.ola.vn.util.a.b(faceArr[i]);
        }
        invalidate();
    }

    public void setFaces(chat.ola.vn.util.a.b[] bVarArr) {
        if (this.f) {
            return;
        }
        this.i = bVarArr;
        invalidate();
    }

    public void setMirror(boolean z) {
        this.e = z;
    }

    public void setOrientation(int i) {
        this.d = i;
        invalidate();
    }
}
