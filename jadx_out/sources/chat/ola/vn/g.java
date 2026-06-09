package chat.ola.vn;

import chat.ola.vn.e.l;
import chat.ola.vn.entity.x;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class g {
    static List<x> a = new ArrayList();
    static Map<String, x> b = new HashMap();
    public static boolean c = false;
    private static l d;

    public static List<x> a() {
        return a;
    }

    public static void a(x xVar) {
        if (xVar == null) {
            return;
        }
        x xVar2 = b.get(xVar.a());
        if (xVar2 == null) {
            a.add(xVar);
            b.put(xVar.a(), xVar);
        } else if (!m.a(xVar.b)) {
            xVar2.b = xVar.b;
        }
        if (d == null) {
            d = new l();
        }
        Collections.sort(a, d);
    }

    public static void b() {
        try {
            a.clear();
            b.clear();
            c = false;
        } catch (Throwable unused) {
        }
    }
}
