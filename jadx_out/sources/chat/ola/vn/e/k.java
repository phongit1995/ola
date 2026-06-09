package chat.ola.vn.e;

import chat.ola.vn.entity.w;
import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class k implements Comparator<w> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(w wVar, w wVar2) {
        if (wVar.d > wVar2.d) {
            return -1;
        }
        return wVar.d < wVar2.d ? 1 : 0;
    }
}
