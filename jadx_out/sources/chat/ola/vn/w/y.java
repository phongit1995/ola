package chat.ola.vn.w;

import java.util.Calendar;

/* JADX INFO: loaded from: classes.dex */
class y implements bb {
    y() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (!chat.ola.vn.util.m.a(bkVar.i)) {
            cgVar.a((short) 22, bkVar.i);
        }
        if (!chat.ola.vn.util.m.a(bkVar.j)) {
            cgVar.a((short) 4, bkVar.j);
        }
        if (bkVar.O != null) {
            String id = Calendar.getInstance().getTimeZone().getID();
            cgVar.a((short) 58, bkVar.O.longValue());
            if (!chat.ola.vn.util.m.a(id)) {
                cgVar.a((short) 109, id);
            }
        }
        if (bkVar.ao != null) {
            cgVar.a((short) 23, bkVar.ao);
        }
        if (bkVar.P != null) {
            cgVar.a((short) 88, bkVar.P.byteValue());
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        gVar.c();
    }
}
