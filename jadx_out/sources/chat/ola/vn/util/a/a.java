package chat.ola.vn.util.a;

import android.annotation.TargetApi;
import android.app.Activity;
import android.graphics.Matrix;
import android.hardware.Camera;
import com.mg.ola.common.d.g;

/* JADX INFO: loaded from: classes.dex */
public class a {
    @TargetApi(9)
    public static int a(int i, int i2) {
        if (!g.a()) {
            return 0;
        }
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        Camera.getCameraInfo(i2, cameraInfo);
        return cameraInfo.facing == 1 ? (360 - ((cameraInfo.orientation + i) % 360)) % 360 : ((cameraInfo.orientation - i) + 360) % 360;
    }

    public static int a(Activity activity) {
        switch (activity.getWindowManager().getDefaultDisplay().getRotation()) {
        }
        return 0;
    }

    public static void a(Matrix matrix, boolean z, int i, int i2, int i3) {
        matrix.setScale(z ? -1.0f : 1.0f, 1.0f);
        matrix.postRotate(i);
        float f = i2;
        float f2 = i3;
        matrix.postScale(f / 2000.0f, f2 / 2000.0f);
        matrix.postTranslate(f / 2.0f, f2 / 2.0f);
    }
}
