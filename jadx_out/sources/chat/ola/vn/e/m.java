package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class m implements Comparator<chat.ola.vn.x.c> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.x.c cVar, chat.ola.vn.x.c cVar2) {
        int i;
        int i2;
        if (cVar.f == cVar2.f) {
            i = cVar2.e;
            i2 = cVar.e;
        } else {
            i = cVar2.f;
            i2 = cVar.f;
        }
        return i - i2;
    }
}
