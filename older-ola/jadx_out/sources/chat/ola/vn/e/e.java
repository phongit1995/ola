package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class e implements Comparator<chat.ola.vn.balloon.e> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.balloon.e eVar, chat.ola.vn.balloon.e eVar2) {
        long jA;
        long jA2;
        try {
            jA = eVar.s.a();
            jA2 = eVar2.s.a();
        } catch (Throwable unused) {
        }
        if (jA > jA2) {
            return -1;
        }
        return jA < jA2 ? 1 : 0;
    }
}
