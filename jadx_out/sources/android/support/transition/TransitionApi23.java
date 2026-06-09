package android.support.transition;

import android.annotation.TargetApi;
import android.support.annotation.RequiresApi;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(23)
@TargetApi(23)
class TransitionApi23 extends TransitionKitKat {
    TransitionApi23() {
    }

    @Override // android.support.transition.TransitionKitKat, android.support.transition.TransitionImpl
    public TransitionImpl removeTarget(int i) {
        this.mTransition.removeTarget(i);
        return this;
    }
}
