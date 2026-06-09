package chat.ola.vn.network.a.a;

import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class ah extends chat.ola.vn.entity.m<chat.ola.vn.entity.e> {
    private String c;
    private boolean d;

    public ah(String str, boolean z, long j) {
        super(j);
        this.c = str;
        this.d = z;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        String strF;
        StringBuilder sb;
        String str;
        String strA = chat.ola.vn.h.a();
        if (chat.ola.vn.util.m.a(this.c) || chat.ola.vn.util.m.a(strA)) {
            return null;
        }
        if (this.d) {
            strF = chat.ola.vn.h.f();
            sb = new StringBuilder();
            str = "mall/like?id=";
        } else {
            strF = chat.ola.vn.h.f();
            sb = new StringBuilder();
            str = "mall/unlike?id=";
        }
        sb.append(str);
        sb.append(this.c);
        sb.append("&owsn=");
        sb.append(strA);
        return chat.ola.vn.util.http.a.a(strF, sb.toString(), (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.e eVar) {
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.e a(byte[] bArr) {
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
