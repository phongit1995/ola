package android.support.transition;

import android.animation.Animator;
import android.annotation.TargetApi;
import android.support.annotation.RequiresApi;
import android.view.View;
import android.view.ViewGroup;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(14)
@TargetApi(14)
abstract class VisibilityPort extends TransitionPort {
    private static final String PROPNAME_VISIBILITY = "android:visibility:visibility";
    private static final String PROPNAME_PARENT = "android:visibility:parent";
    private static final String[] sTransitionProperties = {PROPNAME_VISIBILITY, PROPNAME_PARENT};

    private static class VisibilityInfo {
        ViewGroup endParent;
        int endVisibility;
        boolean fadeIn;
        ViewGroup startParent;
        int startVisibility;
        boolean visibilityChange;

        VisibilityInfo() {
        }
    }

    VisibilityPort() {
    }

    private void captureValues(TransitionValues transitionValues) {
        transitionValues.values.put(PROPNAME_VISIBILITY, Integer.valueOf(transitionValues.view.getVisibility()));
        transitionValues.values.put(PROPNAME_PARENT, transitionValues.view.getParent());
    }

    /* JADX WARN: Code restructure failed: missing block: B:25:0x0074, code lost:
    
        if (r0.endVisibility == 0) goto L26;
     */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x0076, code lost:
    
        r0.fadeIn = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:33:0x0086, code lost:
    
        if (r0.startParent == null) goto L26;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private android.support.transition.VisibilityPort.VisibilityInfo getVisibilityChangeInfo(android.support.transition.TransitionValues r7, android.support.transition.TransitionValues r8) {
        /*
            r6 = this;
            android.support.transition.VisibilityPort$VisibilityInfo r0 = new android.support.transition.VisibilityPort$VisibilityInfo
            r0.<init>()
            r1 = 0
            r0.visibilityChange = r1
            r0.fadeIn = r1
            r2 = 0
            r3 = -1
            if (r7 == 0) goto L2b
            java.util.Map<java.lang.String, java.lang.Object> r4 = r7.values
            java.lang.String r5 = "android:visibility:visibility"
            java.lang.Object r4 = r4.get(r5)
            java.lang.Integer r4 = (java.lang.Integer) r4
            int r4 = r4.intValue()
            r0.startVisibility = r4
            java.util.Map<java.lang.String, java.lang.Object> r4 = r7.values
            java.lang.String r5 = "android:visibility:parent"
            java.lang.Object r4 = r4.get(r5)
            android.view.ViewGroup r4 = (android.view.ViewGroup) r4
            r0.startParent = r4
            goto L2f
        L2b:
            r0.startVisibility = r3
            r0.startParent = r2
        L2f:
            if (r8 == 0) goto L4e
            java.util.Map<java.lang.String, java.lang.Object> r2 = r8.values
            java.lang.String r3 = "android:visibility:visibility"
            java.lang.Object r2 = r2.get(r3)
            java.lang.Integer r2 = (java.lang.Integer) r2
            int r2 = r2.intValue()
            r0.endVisibility = r2
            java.util.Map<java.lang.String, java.lang.Object> r2 = r8.values
            java.lang.String r3 = "android:visibility:parent"
            java.lang.Object r2 = r2.get(r3)
            android.view.ViewGroup r2 = (android.view.ViewGroup) r2
        L4b:
            r0.endParent = r2
            goto L51
        L4e:
            r0.endVisibility = r3
            goto L4b
        L51:
            r2 = 1
            if (r7 == 0) goto L89
            if (r8 == 0) goto L89
            int r3 = r0.startVisibility
            int r4 = r0.endVisibility
            if (r3 != r4) goto L63
            android.view.ViewGroup r3 = r0.startParent
            android.view.ViewGroup r4 = r0.endParent
            if (r3 != r4) goto L63
            return r0
        L63:
            int r3 = r0.startVisibility
            int r4 = r0.endVisibility
            if (r3 == r4) goto L79
            int r3 = r0.startVisibility
            if (r3 != 0) goto L72
        L6d:
            r0.fadeIn = r1
        L6f:
            r0.visibilityChange = r2
            goto L89
        L72:
            int r3 = r0.endVisibility
            if (r3 != 0) goto L89
        L76:
            r0.fadeIn = r2
            goto L6f
        L79:
            android.view.ViewGroup r3 = r0.startParent
            android.view.ViewGroup r4 = r0.endParent
            if (r3 == r4) goto L89
            android.view.ViewGroup r3 = r0.endParent
            if (r3 != 0) goto L84
            goto L6d
        L84:
            android.view.ViewGroup r3 = r0.startParent
            if (r3 != 0) goto L89
            goto L76
        L89:
            if (r7 != 0) goto L90
            r0.fadeIn = r2
        L8d:
            r0.visibilityChange = r2
            return r0
        L90:
            if (r8 != 0) goto L95
            r0.fadeIn = r1
            goto L8d
        L95:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.transition.VisibilityPort.getVisibilityChangeInfo(android.support.transition.TransitionValues, android.support.transition.TransitionValues):android.support.transition.VisibilityPort$VisibilityInfo");
    }

    @Override // android.support.transition.TransitionPort
    public void captureEndValues(TransitionValues transitionValues) {
        captureValues(transitionValues);
    }

    @Override // android.support.transition.TransitionPort
    public void captureStartValues(TransitionValues transitionValues) {
        captureValues(transitionValues);
    }

    @Override // android.support.transition.TransitionPort
    public Animator createAnimator(ViewGroup viewGroup, TransitionValues transitionValues, TransitionValues transitionValues2) {
        VisibilityInfo visibilityChangeInfo = getVisibilityChangeInfo(transitionValues, transitionValues2);
        if (visibilityChangeInfo.visibilityChange) {
            boolean z = false;
            if (this.mTargets.size() > 0 || this.mTargetIds.size() > 0) {
                View view = transitionValues != null ? transitionValues.view : null;
                View view2 = transitionValues2 != null ? transitionValues2.view : null;
                int id = view != null ? view.getId() : -1;
                int id2 = view2 != null ? view2.getId() : -1;
                if (isValidTarget(view, id) || isValidTarget(view2, id2)) {
                    z = true;
                }
            }
            if (z || visibilityChangeInfo.startParent != null || visibilityChangeInfo.endParent != null) {
                return visibilityChangeInfo.fadeIn ? onAppear(viewGroup, transitionValues, visibilityChangeInfo.startVisibility, transitionValues2, visibilityChangeInfo.endVisibility) : onDisappear(viewGroup, transitionValues, visibilityChangeInfo.startVisibility, transitionValues2, visibilityChangeInfo.endVisibility);
            }
        }
        return null;
    }

    @Override // android.support.transition.TransitionPort
    public String[] getTransitionProperties() {
        return sTransitionProperties;
    }

    public boolean isVisible(TransitionValues transitionValues) {
        if (transitionValues == null) {
            return false;
        }
        return ((Integer) transitionValues.values.get(PROPNAME_VISIBILITY)).intValue() == 0 && ((View) transitionValues.values.get(PROPNAME_PARENT)) != null;
    }

    public Animator onAppear(ViewGroup viewGroup, TransitionValues transitionValues, int i, TransitionValues transitionValues2, int i2) {
        return null;
    }

    public Animator onDisappear(ViewGroup viewGroup, TransitionValues transitionValues, int i, TransitionValues transitionValues2, int i2) {
        return null;
    }
}
