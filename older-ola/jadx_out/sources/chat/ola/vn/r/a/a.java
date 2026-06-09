package chat.ola.vn.r.a;

import chat.ola.vn.entry.g;
import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class a implements Comparator<g> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(g gVar, g gVar2) {
        if (gVar.c() < gVar2.c()) {
            return 1;
        }
        return gVar.c() > gVar2.c() ? -1 : 0;
    }
}
