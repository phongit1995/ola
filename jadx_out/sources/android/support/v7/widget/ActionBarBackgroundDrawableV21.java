package android.support.v7.widget;

import android.graphics.Outline;
import android.graphics.drawable.Drawable;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(21)
class ActionBarBackgroundDrawableV21 extends ActionBarBackgroundDrawable {
    public ActionBarBackgroundDrawableV21(ActionBarContainer actionBarContainer) {
        super(actionBarContainer);
    }

    @Override // android.graphics.drawable.Drawable
    public void getOutline(@NonNull Outline outline) {
        Drawable drawable;
        if (this.mContainer.mIsSplit) {
            if (this.mContainer.mSplitBackground == null) {
                return;
            } else {
                drawable = this.mContainer.mSplitBackground;
            }
        } else if (this.mContainer.mBackground == null) {
            return;
        } else {
            drawable = this.mContainer.mBackground;
        }
        drawable.getOutline(outline);
    }
}
