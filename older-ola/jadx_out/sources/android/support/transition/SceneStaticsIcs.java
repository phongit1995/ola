package android.support.transition;

import android.annotation.TargetApi;
import android.content.Context;
import android.support.annotation.RequiresApi;
import android.view.ViewGroup;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(14)
@TargetApi(14)
class SceneStaticsIcs extends SceneStaticsImpl {
    SceneStaticsIcs() {
    }

    @Override // android.support.transition.SceneStaticsImpl
    public SceneImpl getSceneForLayout(ViewGroup viewGroup, int i, Context context) {
        SceneIcs sceneIcs = new SceneIcs();
        sceneIcs.mScene = ScenePort.getSceneForLayout(viewGroup, i, context);
        return sceneIcs;
    }
}
