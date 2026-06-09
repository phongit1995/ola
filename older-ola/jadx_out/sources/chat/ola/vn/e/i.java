package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class i implements Comparator<chat.ola.vn.entity.i> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.entity.i iVar, chat.ola.vn.entity.i iVar2) {
        if (iVar.c() > iVar2.c()) {
            return -1;
        }
        return iVar.c() < iVar2.c() ? 1 : 0;
    }
}
