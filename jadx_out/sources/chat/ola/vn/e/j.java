package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class j implements Comparator<chat.ola.vn.entry.h> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.entry.h hVar, chat.ola.vn.entry.h hVar2) {
        if (hVar.a > hVar2.a) {
            return -1;
        }
        return hVar.a < hVar2.a ? 1 : 0;
    }
}
