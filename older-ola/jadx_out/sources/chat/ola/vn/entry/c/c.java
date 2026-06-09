package chat.ola.vn.entry.c;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.g;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c extends e {
    public String a;
    protected long b;

    public c(String str, long j) {
        this.a = null;
        this.b = 0L;
        this.b = j;
        this.a = str;
    }

    private void a(String str) {
        if (str == null) {
            List<chat.ola.vn.entry.b> listI = h.u.i();
            if (listI != null && listI.size() > 0) {
                chat.ola.vn.entry.b bVar = listI.get(1);
                h.u.d = bVar.b.e();
            }
            chat.ola.vn.h.b.a(h.a(), listI);
        }
    }

    private void a(String str, short s, List<g> list) {
        h.u.b(str, s, list);
    }

    private void a(List<g> list) {
        h.u.c(list);
    }

    private void b() {
        List<chat.ola.vn.entry.b> listI;
        if (m.a(this.a) || this.b != 0) {
            i.a(chat.ola.vn.c.c(), R.string.title_ola_me, R.string.message_fail_load_me);
            return;
        }
        String str = this.a;
        chat.ola.vn.r.a.e eVar = h.u;
        String strG = eVar.g();
        if (!m.b(strG, str) && (listI = eVar.i()) != null && listI.size() > 0) {
            chat.ola.vn.entry.a aVar = new chat.ola.vn.entry.a();
            aVar.a = new ArrayList();
            aVar.b = strG;
            aVar.e = eVar.a();
            aVar.c = eVar.r();
            aVar.d = eVar.s();
            aVar.a.addAll(listI);
            eVar.a(aVar);
        }
        a(str, (short) 0, new ArrayList());
        a(str);
        eVar.a(0);
        eVar.a(false);
        j.d(chat.ola.vn.c.c(), R.string.me_no_content_page);
    }

    @Override // chat.ola.vn.entry.c.e
    public short a() {
        return (short) 4;
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
        try {
            chat.ola.vn.r.a.e eVar = h.u;
            if (i != 34) {
                b();
            } else {
                try {
                    if (chat.ola.vn.c.c() != null) {
                        if (this.b == 0) {
                            b();
                        } else {
                            j.b(chat.ola.vn.c.c(), R.string.message_can_not_load_more);
                        }
                    }
                } catch (Throwable unused) {
                }
            }
            eVar.a(false);
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(Object... objArr) {
        List<chat.ola.vn.entry.b> listI;
        String str = (String) objArr[0];
        short sShortValue = ((Short) objArr[1]).shortValue();
        List<g> list = (List) objArr[2];
        chat.ola.vn.r.a.e eVar = h.u;
        String strG = eVar.g();
        if (!m.b(strG, str) && (listI = eVar.i()) != null && listI.size() > 0) {
            chat.ola.vn.entry.a aVar = new chat.ola.vn.entry.a();
            aVar.a = new ArrayList();
            aVar.b = strG;
            aVar.e = eVar.a();
            aVar.c = eVar.r();
            aVar.d = eVar.s();
            aVar.a.addAll(listI);
            eVar.a(aVar);
        }
        if (this.b == 0) {
            if (m.a(str)) {
                if (list == null) {
                    eVar.a(1);
                    eVar.a(false);
                }
                try {
                    if (!m.a(h.L)) {
                        g gVar = new g();
                        ArrayList arrayList = new ArrayList(1);
                        chat.ola.vn.entity.d dVar = new chat.ola.vn.entity.d();
                        dVar.f(OlaApplication.a(R.string.message_update_ola));
                        dVar.a("wap");
                        dVar.a(true);
                        try {
                            dVar.b(h.L);
                        } catch (Throwable unused) {
                        }
                        arrayList.add(dVar);
                        gVar.a(arrayList);
                        gVar.b(0L);
                        gVar.a(OlaApplication.a(R.string.message_update_ola));
                        gVar.e((short) 0);
                        gVar.i(OlaApplication.a(R.string.message_update_ola));
                        gVar.g(OlaApplication.a(R.string.message_new_version));
                        gVar.b(0);
                        gVar.a(0L);
                        gVar.b(!m.a(h.M) ? h.M : OlaApplication.a(R.string.message_update_ola_promotion_content));
                        gVar.c(h.N);
                        gVar.d((short) 3);
                        gVar.f("update");
                        gVar.c(System.currentTimeMillis());
                        list.add(0, gVar);
                    }
                } catch (Throwable unused2) {
                }
            }
            a(str, sShortValue, list);
        } else {
            a(list);
        }
        a(str);
        eVar.a(0);
        eVar.a(false);
    }
}
