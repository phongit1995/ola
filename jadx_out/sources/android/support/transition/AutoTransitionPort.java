package android.support.transition;

import android.annotation.TargetApi;
import android.support.annotation.RequiresApi;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(14)
@TargetApi(14)
class AutoTransitionPort extends TransitionSetPort {
    public AutoTransitionPort() {
        setOrdering(1);
        addTransition(new FadePort(2)).addTransition(new ChangeBoundsPort()).addTransition(new FadePort(1));
    }
}
