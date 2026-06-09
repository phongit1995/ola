package android.support.transition;

import android.annotation.TargetApi;
import android.support.annotation.RequiresApi;
import android.support.v4.util.ArrayMap;
import android.support.v4.util.LongSparseArray;
import android.util.SparseArray;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(14)
@TargetApi(14)
class TransitionValuesMaps {
    public ArrayMap<View, TransitionValues> viewValues = new ArrayMap<>();
    public SparseArray<TransitionValues> idValues = new SparseArray<>();
    public LongSparseArray<TransitionValues> itemIdValues = new LongSparseArray<>();

    TransitionValuesMaps() {
    }
}
