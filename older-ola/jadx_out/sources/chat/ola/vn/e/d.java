package chat.ola.vn.e;

import chat.ola.vn.entity.t;
import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class d implements Comparator<t> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(t tVar, t tVar2) {
        return (int) (tVar2.A() - tVar.A());
    }
}
