package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class a implements Comparator<chat.ola.vn.h.a> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.h.a aVar, chat.ola.vn.h.a aVar2) {
        if (aVar.e < aVar2.e) {
            return 1;
        }
        return aVar.e > aVar2.e ? -1 : 0;
    }
}
