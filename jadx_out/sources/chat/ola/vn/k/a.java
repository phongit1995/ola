package chat.ola.vn.k;

import chat.ola.vn.entity.m;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class a {
    private static Map<String, m<?>> a = new HashMap();

    public static m<?> a(long j) {
        m<?> mVarRemove;
        try {
            synchronized (a) {
                mVarRemove = a.remove("" + j);
            }
            return mVarRemove;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static m<?> a(m<?> mVar) {
        try {
            synchronized (a) {
                m<?> mVar2 = a.get("" + mVar.a);
                if (mVar2 != null) {
                    return mVar2;
                }
                a.put("" + mVar.a, mVar);
                return mVar;
            }
        } catch (Throwable unused) {
            return mVar;
        }
    }
}
