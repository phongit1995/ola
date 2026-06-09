package chat.ola.vn.w;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class bw implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        List<chat.ola.vn.message.f> list = bkVar.b;
        if (list == null || list.size() <= 0) {
            return;
        }
        for (chat.ola.vn.message.f fVar : list) {
            cgVar.a((short) 138, fVar.j());
            cgVar.a((short) 139, cc.b(fVar.k()));
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
    }
}
