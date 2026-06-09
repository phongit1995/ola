package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.support.v4.view.ViewPager;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public class k implements ViewPager.PageTransformer {
    private static float a = 0.75f;

    @Override // android.support.v4.view.ViewPager.PageTransformer
    @SuppressLint({"NewApi"})
    public void transformPage(View view, float f) {
        int width = view.getWidth();
        if (f >= -1.0f) {
            if (f <= 0.0f) {
                view.setAlpha(1.0f);
                view.setTranslationX(0.0f);
                view.setScaleX(1.0f);
                view.setScaleY(1.0f);
                return;
            }
            if (f <= 1.0f) {
                view.setAlpha(1.0f - f);
                view.setTranslationX(width * (-f));
                float fAbs = a + ((1.0f - a) * (1.0f - Math.abs(f)));
                view.setScaleX(fAbs);
                view.setScaleY(fAbs);
                return;
            }
        }
        view.setAlpha(0.0f);
    }
}
