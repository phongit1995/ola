package chat.ola.vn.w;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class av implements bb {
    av() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        List<chat.ola.vn.message.f> listA = s.a(sVar, ciVar.i());
        if (listA != null) {
            for (chat.ola.vn.message.f fVar : listA) {
                fVar.f((short) 1);
                fVar.a((short) 2);
            }
            gVar.a(listA);
        }
    }
}
