package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class h implements Comparator<chat.ola.vn.message.f> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.message.f fVar, chat.ola.vn.message.f fVar2) {
        if (fVar.k() == 5 && fVar2.k() != 5) {
            return -1;
        }
        if (fVar.k() != 5 && fVar2.k() == 5) {
            return 1;
        }
        long jA = fVar.a();
        long jA2 = fVar2.a();
        boolean z = fVar.z() > 0;
        boolean z2 = fVar2.z() > 0;
        if (z && !z2) {
            return -1;
        }
        if (!z && z2) {
            return 1;
        }
        if (jA > jA2) {
            return -1;
        }
        return jA < jA2 ? 1 : 0;
    }
}
