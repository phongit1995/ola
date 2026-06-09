package chat.ola.vn.e;

import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class c implements Comparator<chat.ola.vn.entity.g> {
    private int a;

    public c() {
        this(true);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public c(boolean z) {
        this.a = z ? -1 : 1;
    }

    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.entity.g gVar, chat.ola.vn.entity.g gVar2) {
        if (gVar.d() < gVar2.d()) {
            return this.a * (-1);
        }
        if (gVar.d() == gVar2.d()) {
            return 0;
        }
        return this.a;
    }
}
