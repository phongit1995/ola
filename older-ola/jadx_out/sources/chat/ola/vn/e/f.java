package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class f implements Comparator<chat.ola.vn.message.f> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.message.f fVar, chat.ola.vn.message.f fVar2) {
        try {
            return fVar.j().compareTo(fVar2.j());
        } catch (Throwable unused) {
            return 0;
        }
    }
}
