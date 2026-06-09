package chat.ola.vn.e;

import chat.ola.vn.entity.x;
import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class l implements Comparator<x> {
    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(x xVar, x xVar2) {
        try {
            String str = xVar.b;
            if (chat.ola.vn.util.m.a(str)) {
                str = xVar.c;
            }
            String str2 = xVar2.b;
            if (chat.ola.vn.util.m.a(str2)) {
                str2 = xVar2.c;
            }
            return str.compareTo(str2);
        } catch (Throwable unused) {
            return 0;
        }
    }
}
