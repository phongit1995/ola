package android.support.transition;

import android.annotation.TargetApi;
import android.support.annotation.RequiresApi;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(19)
@TargetApi(19)
class ChangeBoundsKitKat extends TransitionKitKat implements ChangeBoundsInterface {
    public ChangeBoundsKitKat(TransitionInterface transitionInterface) {
        init(transitionInterface, new android.transition.ChangeBounds());
    }

    @Override // android.support.transition.ChangeBoundsInterface
    public void setResizeClip(boolean z) {
        ((android.transition.ChangeBounds) this.mTransition).setResizeClip(z);
    }
}
