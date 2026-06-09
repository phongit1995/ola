package android.support.transition;

/* JADX INFO: loaded from: classes.dex */
interface TransitionSetImpl {
    TransitionSetImpl addTransition(TransitionImpl transitionImpl);

    int getOrdering();

    TransitionSetImpl removeTransition(TransitionImpl transitionImpl);

    TransitionSetImpl setOrdering(int i);
}
