package chat.ola.vn.entry.c;

import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class f {
    private static Map<String, e> a;

    public static e a(short s) {
        if (a == null) {
            return null;
        }
        return a.get(((int) s) + "");
    }

    public static short a(e eVar) {
        if (a == null) {
            a = new HashMap();
        }
        a.put(((int) eVar.a()) + "", eVar);
        return eVar.a();
    }

    public static e b(short s) {
        if (a == null) {
            return null;
        }
        return a.remove(((int) s) + "");
    }
}
