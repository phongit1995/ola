package chat.ola.vn.e;

/* JADX INFO: loaded from: classes.dex */
public class g extends f {
    @Override // chat.ola.vn.e.f, java.util.Comparator
    /* JADX INFO: renamed from: a */
    public int compare(chat.ola.vn.message.f fVar, chat.ola.vn.message.f fVar2) {
        try {
            if (fVar.g() > fVar2.g()) {
                return -1;
            }
            if (fVar.g() < fVar2.g()) {
                return 1;
            }
            if (fVar.g() == 2 && fVar2.g() == 2) {
                long jV = fVar.v();
                long jV2 = fVar2.v();
                if (jV > 0 || jV2 > 0) {
                    if (jV > jV2) {
                        return -1;
                    }
                    if (jV < jV2) {
                        return 1;
                    }
                }
            }
            if (fVar.g() != 2 && fVar2.g() != 2) {
                long jV3 = fVar.v();
                long jV4 = fVar2.v();
                if (jV3 > 0 || jV4 > 0) {
                    if (jV3 > jV4) {
                        return -1;
                    }
                    if (jV3 < jV4) {
                        return 1;
                    }
                }
                if (fVar.N < fVar2.N) {
                    return 1;
                }
                if (fVar.N > fVar2.N) {
                    return -1;
                }
            }
        } catch (Throwable unused) {
        }
        return super.compare(fVar, fVar2);
    }
}
