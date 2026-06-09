package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class dj implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 114, bkVar.as);
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        int i = 0;
        if (bkVar.as != 0) {
            if (bkVar.a != null) {
                chat.ola.vn.entity.aa[] aaVarArr = bkVar.a;
                int length = aaVarArr.length;
                while (i < length) {
                    chat.ola.vn.entity.aa aaVar = aaVarArr[i];
                    if (!chat.ola.vn.util.m.a(aaVar.a) && aaVar.b != null && aaVar.b.length > 0) {
                        cgVar.a((short) 110, aaVar.a);
                        cgVar.a((short) 23, aaVar.b);
                    }
                    i++;
                }
            }
        } else if (bkVar.a != null) {
            chat.ola.vn.entity.aa[] aaVarArr2 = bkVar.a;
            int length2 = aaVarArr2.length;
            while (i < length2) {
                chat.ola.vn.entity.aa aaVar2 = aaVarArr2[i];
                if (!chat.ola.vn.util.m.a(aaVar2.a)) {
                    cgVar.a((short) 110, aaVar2.a);
                }
                i++;
            }
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
    }
}
