package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class cx implements bb {
    cx() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 61, bkVar.g);
        if (bkVar.x != null) {
            cgVar.a((short) 94, bkVar.x);
        }
        if (bkVar.h != null) {
            cgVar.a((short) 50, bkVar.h);
        }
        if (bkVar.y != null) {
            cgVar.a((short) 86, bkVar.y);
        }
        cgVar.a((short) 51, bkVar.X + "x" + bkVar.Y);
        if (bkVar.z != null) {
            cgVar.a((short) 14, bkVar.z);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        byte[] bArrA = sVar.a((short) 42);
        if (bArrA == null) {
            ciVar.a();
            return;
        }
        String str = "" + String.valueOf(chat.ola.vn.util.e.a(bArrA[0]));
        String str2 = str + ".";
        String str3 = str2 + String.valueOf(chat.ola.vn.util.e.a(bArrA[1]));
        String str4 = str3 + ".";
        String str5 = str4 + String.valueOf(chat.ola.vn.util.e.a(bArrA[2]));
        String str6 = str5 + ".";
        gVar.a(str6 + String.valueOf(chat.ola.vn.util.e.a(bArrA[3])), ciVar);
    }
}
