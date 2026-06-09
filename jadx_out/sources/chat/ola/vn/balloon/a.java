package chat.ola.vn.balloon;

import android.os.Handler;
import android.view.WindowManager;

/* JADX INFO: loaded from: classes.dex */
public interface a {
    void a();

    void b();

    boolean c();

    boolean d();

    Handler getBalloonHandler();

    int getBalloonHeight();

    WindowManager.LayoutParams getBalloonLayoutParameter();

    int getBalloonWidth();

    int getCurrentPositionX();

    int getCurrentPositionY();

    int getWindowHeight();

    int getWindowWidth();
}
