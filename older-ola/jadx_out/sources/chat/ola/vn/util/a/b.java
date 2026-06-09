package chat.ola.vn.util.a;

import android.annotation.TargetApi;
import android.graphics.Point;
import android.graphics.Rect;
import android.hardware.Camera;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public Rect a;
    public int b;
    public int c;
    public Point d;
    public Point e;
    public Point f;

    public b() {
        this.c = -1;
        this.d = null;
        this.e = null;
        this.f = null;
    }

    @TargetApi(14)
    public b(Camera.Face face) {
        this.c = -1;
        this.d = null;
        this.e = null;
        this.f = null;
        this.a = face.rect;
        this.c = face.id;
        this.d = face.leftEye;
        this.e = face.rightEye;
        this.f = face.mouth;
        this.b = face.score;
    }
}
