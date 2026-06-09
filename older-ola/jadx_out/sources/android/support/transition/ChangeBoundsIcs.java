package android.support.transition;

import android.annotation.TargetApi;
import android.support.annotation.RequiresApi;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(14)
@TargetApi(14)
class ChangeBoundsIcs extends TransitionIcs implements ChangeBoundsInterface {
    public ChangeBoundsIcs(TransitionInterface transitionInterface) {
        init(transitionInterface, new ChangeBoundsPort());
    }

    @Override // android.support.transition.ChangeBoundsInterface
    public void setResizeClip(boolean z) {
        ((ChangeBoundsPort) this.mTransition).setResizeClip(z);
    }
}
