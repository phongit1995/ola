package chat.ola.vn.network;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaReleaseAppActivity;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.ac;
import chat.ola.vn.entity.ad;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.ah;
import chat.ola.vn.entity.l;
import chat.ola.vn.entity.s;
import chat.ola.vn.entity.t;
import chat.ola.vn.message.aa;
import chat.ola.vn.message.k;
import chat.ola.vn.message.q;
import chat.ola.vn.message.v;
import chat.ola.vn.service.OlaVoiceChatService;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import chat.ola.vn.w.ci;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class e implements chat.ola.vn.p.g {
    public static int b;
    protected OlaNetworkService a;

    public e(OlaNetworkService olaNetworkService) {
        this.a = olaNetworkService;
    }

    private void a(ci ciVar) {
        x.d = ciVar.n();
        String strA = chat.ola.vn.h.a();
        if ((x.j & 16384) != 16384) {
            x.j = chat.ola.vn.e.a().f();
        } else {
            chat.ola.vn.e.a().d(x.j);
        }
        if (m.a(strA)) {
            return;
        }
        x.c = ciVar.k();
        x.k = chat.ola.vn.h.b.h(strA);
        x.n = chat.ola.vn.h.b.j(strA);
        x.o = chat.ola.vn.h.b.n(strA);
        x.q = chat.ola.vn.h.b.q(strA);
        x.v = chat.ola.vn.h.b.o(strA);
        x.m = chat.ola.vn.h.b.g(strA);
        x.h = chat.ola.vn.h.b.k(strA);
        x.x = chat.ola.vn.h.b.l(strA);
        x.y = chat.ola.vn.h.b.m(strA);
        try {
            chat.ola.vn.me.a aVarR = chat.ola.vn.h.b.r(chat.ola.vn.h.a());
            if (aVarR != null) {
                chat.ola.vn.h.u.a(aVarR, false);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(String str, short s, chat.ola.vn.message.d dVar) {
        chat.ola.vn.message.d dVarO;
        try {
            chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, s);
            if (fVarD == null || (dVarO = fVarD.o(dVar.p())) == null) {
                return;
            }
            dVarO.a(dVar.q(), false);
            dVarO.b(dVar.t());
            if (dVar.q() == 3) {
                dVarO.c(dVar.i());
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(String str, short s, String str2, chat.ola.vn.message.d dVar) {
        try {
            chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, s);
            if (fVarD == null) {
                fVarD = chat.ola.vn.h.t.c(str, s);
            }
            chat.ola.vn.message.d dVarO = fVarD.o(str2);
            if (dVarO == null) {
                if (s == 0) {
                    chat.ola.vn.message.d dVarA = chat.ola.vn.message.e.a(dVar, (byte) 2);
                    dVarA.p = dVar.p;
                    fVarD.a(dVarA);
                    return;
                }
                return;
            }
            dVarO.p = dVar.p;
            if (!m.a(dVar.y())) {
                fVarD.a(str2, chat.ola.vn.message.e.a(dVar, (byte) 2));
                return;
            }
            dVarO.h(dVar.p());
            dVarO.f(dVar.k());
            dVarO.b(dVar.t());
            dVarO.b((byte) 1);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.g
    public void a() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.50
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (e.this.a.j() != 7) {
                        if (e.this.a.j() == 5) {
                            e.this.a.a(1);
                        }
                    } else {
                        try {
                            if (!OlaApplication.e()) {
                                j.d(OlaApplication.a(), R.string.message_connection_lost_network_content);
                            }
                        } catch (Throwable unused) {
                        }
                        e.this.a.a(1);
                        Iterator<f> it2 = e.this.a.j.iterator();
                        while (it2.hasNext()) {
                            it2.next().k();
                        }
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.67
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final int i, final List<chat.ola.vn.message.f> list) {
        chat.ola.vn.h.b.d(chat.ola.vn.h.a(), list);
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.54
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.t.j(list);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(i, list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final int i, final short s, final String str, final byte[] bArr, final chat.ola.vn.entity.d[] dVarArr, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.1
            @Override // java.lang.Runnable
            public void run() {
                e eVar;
                try {
                    if (e.this.a.j != null) {
                        int i2 = i;
                        if (i2 == 7 || i2 == 10) {
                            if (s2 == 58) {
                                if (!chat.ola.vn.h.h() || e.b >= 3) {
                                    e.b = 0;
                                    chat.ola.vn.h.d(null);
                                    chat.ola.vn.util.c.b.e(OlaApplication.a());
                                    if (e.this.a.j() > 5) {
                                        e.this.a.a(1);
                                    }
                                    Iterator<f> it2 = e.this.a.j.iterator();
                                    while (it2.hasNext()) {
                                        it2.next().a(i, str, bArr);
                                    }
                                } else {
                                    e.b++;
                                    chat.ola.vn.h.c(null);
                                    if (e.this.a.j() > 5) {
                                        e.this.a.a(5);
                                    } else {
                                        e.this.a.a(1);
                                    }
                                    eVar = e.this;
                                    eVar.a.m();
                                }
                            } else if (s2 == 59) {
                                e.b = 0;
                                chat.ola.vn.h.d(null);
                                chat.ola.vn.util.c.b.a(OlaApplication.a(), str);
                                if (e.this.a.j() > 5) {
                                    e.this.a.a(1);
                                }
                                Iterator<f> it3 = e.this.a.j.iterator();
                                while (it3.hasNext()) {
                                    it3.next().a(i, str, bArr);
                                }
                            }
                        } else if (i2 != 24) {
                            if (i2 != 41) {
                                switch (i2) {
                                    case 0:
                                        if (s2 != 58) {
                                            if (s2 == 59) {
                                                chat.ola.vn.h.d(null);
                                                if (e.this.a.j() > 5) {
                                                    e.this.a.a(1);
                                                }
                                                Iterator<f> it4 = e.this.a.j.iterator();
                                                while (it4.hasNext()) {
                                                    it4.next().a(i, str, bArr);
                                                }
                                            }
                                        } else if (chat.ola.vn.h.h() && e.b < 3) {
                                            e.b++;
                                            chat.ola.vn.h.c(null);
                                            if (e.this.a.j() == 6) {
                                                e.this.a.a(5);
                                            } else {
                                                e.this.a.a(1);
                                            }
                                            eVar = e.this;
                                            eVar.a.m();
                                        } else {
                                            e.b = 0;
                                            chat.ola.vn.h.d(null);
                                            chat.ola.vn.util.c.b.e(OlaApplication.a());
                                            if (e.this.a.j() > 6) {
                                                e.this.a.a(1);
                                            }
                                            Iterator<f> it5 = e.this.a.j.iterator();
                                            while (it5.hasNext()) {
                                                it5.next().a(i, str, bArr);
                                            }
                                        }
                                        break;
                                    case 1:
                                        if (s2 == 59) {
                                            e.b++;
                                            if (e.b < 3) {
                                                if (e.this.a.j() > 5) {
                                                    e.this.a.a(1);
                                                }
                                                e.this.a.m();
                                            } else {
                                                e.b = 0;
                                                chat.ola.vn.h.d(null);
                                                if (e.this.a.j() > 5) {
                                                    e.this.a.a(1);
                                                }
                                            }
                                        }
                                        break;
                                    case 2:
                                        if (s2 != 59) {
                                            Iterator<f> it6 = e.this.a.j.iterator();
                                            while (it6.hasNext()) {
                                                it6.next().a(str, bArr);
                                            }
                                        } else {
                                            e.b = 0;
                                            chat.ola.vn.h.d(null);
                                            if (e.this.a.j() > 5) {
                                                e.this.a.a(1);
                                            }
                                            Iterator<f> it7 = e.this.a.j.iterator();
                                            while (it7.hasNext()) {
                                                it7.next().a(i, str, bArr);
                                            }
                                        }
                                        break;
                                    default:
                                        switch (i2) {
                                            case 38:
                                                if (!OlaApplication.e() && chat.ola.vn.c.c() != null) {
                                                    chat.ola.vn.i.i.d(chat.ola.vn.c.c());
                                                }
                                                break;
                                            case 39:
                                                if (chat.ola.vn.c.c() != null) {
                                                    chat.ola.vn.i.i.d(chat.ola.vn.c.c(), "FAIL_NOT_ENOUGH_MONEY");
                                                }
                                                break;
                                        }
                                        break;
                                }
                                return;
                            }
                            if (s2 == 59) {
                                e.b = 0;
                                chat.ola.vn.h.d(null);
                                if (e.this.a.j() > 5) {
                                    e.this.a.a(1);
                                }
                                Iterator<f> it8 = e.this.a.j.iterator();
                                while (it8.hasNext()) {
                                    it8.next().b(str, bArr);
                                }
                            } else {
                                Iterator<f> it9 = e.this.a.j.iterator();
                                while (it9.hasNext()) {
                                    it9.next().a(str, bArr);
                                }
                            }
                        }
                        chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                        if (eVarB != null) {
                            eVarB.a(i, s, str, dVarArr);
                        }
                        Iterator<f> it10 = e.this.a.j.iterator();
                        while (it10.hasNext()) {
                            it10.next().a(i, str, bArr, dVarArr, s2);
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final long j, final int i, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.121
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(j, i, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(Long.valueOf(j), Integer.valueOf(i), Short.valueOf(s));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(long j, chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.g
    public void a(long j, String str) {
    }

    @Override // chat.ola.vn.p.g
    public void a(long j, String str, String str2) {
        try {
            chat.ola.vn.k.a.a(j).a(str2);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.g
    public void a(final long j, final String str, final String str2, final List<chat.ola.vn.message.f> list, final List<chat.ola.vn.message.f> list2, final short s) {
        if (s != 56) {
            try {
                chat.ola.vn.h.b.a(chat.ola.vn.h.a(), Long.valueOf(j));
            } catch (Throwable unused) {
            }
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.58
            @Override // java.lang.Runnable
            public void run() {
                try {
                    s sVar = new s(j, str);
                    sVar.c(str2);
                    chat.ola.vn.h.x.a(sVar, list);
                    chat.ola.vn.h.x.b(list2);
                    chat.ola.vn.h.x.a(1);
                    try {
                        Iterator<f> it2 = e.this.a.j.iterator();
                        while (it2.hasNext()) {
                            it2.next().a(j, str, str2, list, list2, s);
                        }
                    } catch (Throwable unused2) {
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a("");
                    }
                } catch (Throwable unused3) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(long j, String str, byte[] bArr, String str2) {
        try {
            chat.ola.vn.k.a.a(j).a(bArr, str2);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.g
    public void a(final long j, final String str, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.94
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(j, str, strArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(Long.valueOf(j), str, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final long j, final List<chat.ola.vn.message.d> list) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.59
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (chat.ola.vn.h.t != null) {
                        chat.ola.vn.message.f fVarA = chat.ola.vn.h.t.a(j);
                        if (fVarA == null) {
                            fVarA = chat.ola.vn.h.t.a(j, chat.ola.vn.h.x.a(j).d());
                        }
                        if (fVarA != null) {
                            Iterator it2 = list.iterator();
                            while (it2.hasNext()) {
                                fVarA.a((chat.ola.vn.message.d) it2.next());
                            }
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final long j, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.93
            @Override // java.lang.Runnable
            public void run() {
                String strA;
                try {
                    chat.ola.vn.h.o = j;
                    chat.ola.vn.entry.e eVarB = chat.ola.vn.h.v.b(R.string.general_tab_kenstore);
                    if (eVarB != null) {
                        if (chat.ola.vn.h.o == 0) {
                            strA = OlaApplication.a(R.string.message_purchase_ken_tip);
                        } else {
                            strA = OlaApplication.a(R.string.string_ballance) + ": " + m.a(chat.ola.vn.h.o) + " KEN";
                        }
                        eVarB.d(strA);
                        eVarB.b(1);
                        try {
                            ((OlaBottomTabActivity) chat.ola.vn.c.c()).I();
                        } catch (Throwable unused) {
                        }
                        chat.ola.vn.h.v.g();
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(j, s);
                    }
                    OlaApplication.a().sendBroadcast(new Intent("chat.ola.vn.ACTION_CHANGE_BALANCE"));
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final ad adVar, final List<ad> list, final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.11
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(adVar, list, str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(ad adVar, final short s) {
        final t tVar = new t(adVar);
        tVar.a(true);
        tVar.f();
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.15
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(tVar);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final ag agVar, final short s) {
        String strG;
        try {
            if (m.a(agVar.c) || m.b(agVar.c, chat.ola.vn.h.a())) {
                short s2 = chat.ola.vn.h.O != null ? chat.ola.vn.h.O.u : (short) 0;
                chat.ola.vn.h.O = agVar;
                if (s2 > 0 && chat.ola.vn.h.O.u == 0) {
                    chat.ola.vn.h.O.u = s2;
                }
                try {
                    chat.ola.vn.entry.e eVarB = chat.ola.vn.h.v.b(R.string.general_tab_personal);
                    String strA = null;
                    try {
                        strG = n.g(OlaApplication.a());
                    } catch (Throwable unused) {
                        strG = null;
                    }
                    if (!chat.ola.vn.c.x() || (!m.a(chat.ola.vn.h.O.f) && chat.ola.vn.h.O.x)) {
                        if (chat.ola.vn.h.O.w == -1) {
                            eVarB.c("!");
                            eVarB.b(2);
                            strA = OlaApplication.a(R.string.message_set_gender_to_find_friends);
                        } else {
                            if (m.a(chat.ola.vn.h.O.k) && !m.a(strG)) {
                                chat.ola.vn.h.O.k = strG;
                                this.a.a(strG, (String) null, (Long) null, (Byte) null);
                            }
                            eVarB.b(1);
                            eVarB.c((String) null);
                        }
                        eVarB.d(strA);
                    } else {
                        eVarB.c("!");
                        eVarB.b(2);
                        String strA2 = "";
                        if (m.a(chat.ola.vn.h.O.k)) {
                            chat.ola.vn.h.O.k = strG;
                        } else {
                            strG = null;
                        }
                        if (chat.ola.vn.c.x() && !m.a(chat.ola.vn.h.S) && m.a(chat.ola.vn.h.O.f)) {
                            chat.ola.vn.h.O.f = chat.ola.vn.h.S;
                            this.a.a(strG, chat.ola.vn.h.S, (Long) null, (Byte) null);
                        }
                        if (m.a(chat.ola.vn.h.O.f)) {
                            strA2 = OlaApplication.a(R.string.message_account_not_have_phonenumber);
                        } else if (!chat.ola.vn.h.O.x) {
                            strA2 = OlaApplication.a(R.string.message_phone_number_not_validate);
                        }
                        eVarB.d(strA2);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        } catch (Throwable unused2) {
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.12
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(agVar, s);
                    }
                    chat.ola.vn.entry.c.e eVarA = chat.ola.vn.entry.c.f.a(s);
                    if (eVarA != null) {
                        eVarA.a(agVar);
                    }
                } catch (Throwable unused3) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final chat.ola.vn.entity.b bVar, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.62
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(bVar, s);
                    }
                    chat.ola.vn.entry.c.e eVarA = chat.ola.vn.entry.c.f.a(s);
                    if (eVarA != null) {
                        eVarA.a(bVar);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final chat.ola.vn.entity.g gVar, final List<chat.ola.vn.entity.g> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.51
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(gVar, list, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(gVar, list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final chat.ola.vn.message.d dVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.103
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(dVar.i(), (short) 0);
                    if (fVarD == null) {
                        fVarD = chat.ola.vn.h.t.b(dVar.i(), (short) 0, true);
                    }
                    if (fVarD != null) {
                        fVarD.a(dVar);
                        chat.ola.vn.util.c.b.a(fVarD, dVar);
                        fVarD.K = Long.valueOf(System.currentTimeMillis());
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final chat.ola.vn.message.t tVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.18
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(tVar.i(), (short) 0, true)) == null) {
                        return;
                    }
                    fVarB.a(tVar);
                } catch (Throwable unused) {
                }
            }
        });
    }

    /* JADX WARN: Type inference failed for: r3v6, types: [chat.ola.vn.network.e$45] */
    @Override // chat.ola.vn.p.g
    public void a(final ci ciVar, short s) {
        b = 0;
        chat.ola.vn.h.m = ciVar.e;
        chat.ola.vn.h.y = System.currentTimeMillis();
        chat.ola.vn.h.d(ciVar.i());
        chat.ola.vn.h.H = ciVar.m();
        chat.ola.vn.h.o = 0L;
        OlaApplication.d = false;
        this.a.k = false;
        try {
            this.a.a("ola", true, (short) 0);
            this.a.a("#hai", true, (short) 0);
            chat.ola.vn.h.O = null;
            this.a.b((String) null, (short) 0);
        } catch (Throwable unused) {
        }
        this.a.a((short) 0);
        Long lF = chat.ola.vn.h.b.f(ciVar.i());
        if (lF != null) {
            boolean zI = chat.ola.vn.h.b.i(ciVar.i());
            String strB = chat.ola.vn.n.c.a().b();
            String strC = chat.ola.vn.n.c.a().c();
            if (lF.longValue() > 0) {
                this.a.a(lF.longValue(), zI, strB, strC, (short) 0);
            } else if (!m.a(strB) && !m.a(strC)) {
                this.a.a(lF.longValue(), strB, strC, (short) 0);
            }
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.33
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.h.t.D();
            }
        }, 30000L);
        a(ciVar);
        try {
            chat.ola.vn.c.f fVarB = chat.ola.vn.c.f.b(chat.ola.vn.h.a());
            fVarB.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.network.e.44
                @Override // chat.ola.vn.c.g
                public void a(chat.ola.vn.c.f fVar) {
                    chat.ola.vn.h.b.b(chat.ola.vn.h.a(), chat.ola.vn.badger.e.a(fVar.c()));
                }

                @Override // chat.ola.vn.c.g
                public void b(chat.ola.vn.c.f fVar) {
                }
            });
            new chat.ola.vn.c.e().a(fVarB);
        } catch (Throwable unused2) {
        }
        try {
            new AsyncTask<String, Void, Boolean>() { // from class: chat.ola.vn.network.e.45
                private ArrayList<chat.ola.vn.entry.e> b;
                private String c;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Boolean doInBackground(String... strArr) {
                    try {
                        String str = strArr[0];
                        this.b = new ArrayList<>();
                        this.c = chat.ola.vn.util.http.b.a(chat.ola.vn.h.f(), str, this.b);
                        return true;
                    } catch (Throwable unused3) {
                        return false;
                    }
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Boolean bool) {
                    try {
                        if (bool.booleanValue()) {
                            chat.ola.vn.h.v.a(this.c, this.b);
                            chat.ola.vn.h.v.g();
                        }
                    } catch (Throwable unused3) {
                    }
                }
            }.execute(chat.ola.vn.h.v.i());
        } catch (Throwable unused3) {
        }
        try {
            if (chat.ola.vn.n.b.b(OlaApplication.a())) {
                chat.ola.vn.n.b.a(OlaApplication.a());
            }
        } catch (Throwable unused4) {
        }
        chat.ola.vn.d.i();
        chat.ola.vn.d.h();
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.46
            @Override // java.lang.Runnable
            public void run() {
                String strA;
                try {
                    if (e.this.a.j() != 6) {
                        return;
                    }
                    e.this.a.a(7);
                    chat.ola.vn.util.c.b.d(OlaApplication.a());
                    e.this.a.n();
                    e.this.a.o();
                    chat.ola.vn.h.x.a(true);
                    if (!OlaApplication.e()) {
                        String strN = ciVar.n();
                        if (m.a(strN)) {
                            strA = chat.ola.vn.h.a();
                        } else {
                            strA = strN + " (" + chat.ola.vn.h.a() + ")";
                        }
                        chat.ola.vn.util.c.b.a(OlaApplication.a(R.string.message_go_online_wellcome, strA), (String) null);
                    }
                    if (chat.ola.vn.h.g == null) {
                        chat.ola.vn.h.g = n.f(OlaApplication.a());
                    }
                    e.this.a.d(chat.ola.vn.h.g, chat.ola.vn.h.f);
                    e.this.a.r();
                    e.this.a.h((short) 0);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().n();
                    }
                } catch (Throwable unused5) {
                }
                try {
                    OlaApplication.b.b(0);
                    OlaApplication.b.c(0);
                } catch (Throwable unused6) {
                }
                try {
                    e.this.a.w(null, (short) 0);
                    e.this.a.b("bmk", new String[]{"mehistory", "smileyhistory", "lastRoomId"}, (short) 0);
                    e.this.a.b("rss", new String[]{"rssbookmark", "rsshistory"}, (short) 0);
                    e.this.a.b("set", new String[]{"usersettings"}, (short) 0);
                } catch (Throwable unused7) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final Short sh, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.60
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (e.this.a == null || !e.this.a.h()) {
                        return;
                    }
                    if (sh != null) {
                        chat.ola.vn.h.H = sh.shortValue();
                        chat.ola.vn.h.O.u = chat.ola.vn.h.H;
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(sh, i);
                    }
                    e.this.a.d((short) 0);
                    chat.ola.vn.h.E = chat.ola.vn.h.b.a();
                    final long jCurrentTimeMillis = System.currentTimeMillis();
                    if (i <= 0 || i >= 3) {
                        if (i >= 0 || chat.ola.vn.h.H != 0 || jCurrentTimeMillis - chat.ola.vn.h.E < 259200000 || OlaApplication.e()) {
                            return;
                        }
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.60.2
                            @Override // java.lang.Runnable
                            public void run() {
                                if (OlaApplication.e() || chat.ola.vn.c.c() == null || e.this.a == null || !e.this.a.h()) {
                                    return;
                                }
                                chat.ola.vn.i.i.c(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_vip_introduction_notify, R.string.string_buy_vip, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.network.e.60.2.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i2) {
                                        if (i2 == 0) {
                                            try {
                                                if (chat.ola.vn.c.c() != null) {
                                                    BuyVipActivity.a(chat.ola.vn.c.c());
                                                }
                                            } catch (Throwable unused) {
                                                return;
                                            }
                                        }
                                        dialogInterface.dismiss();
                                    }
                                });
                                chat.ola.vn.h.E = jCurrentTimeMillis;
                                chat.ola.vn.h.b.a(chat.ola.vn.h.E);
                            }
                        }, 10000L);
                        return;
                    }
                    if (jCurrentTimeMillis - chat.ola.vn.h.E >= 86400000) {
                        if (OlaApplication.e()) {
                            chat.ola.vn.util.c.b.b(OlaApplication.a());
                        } else {
                            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.60.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    if (OlaApplication.e() || chat.ola.vn.c.c() == null || e.this.a == null || !e.this.a.h()) {
                                        chat.ola.vn.util.c.b.b(OlaApplication.a());
                                    } else {
                                        try {
                                            chat.ola.vn.i.i.c(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_vip_need_extension_notify, R.string.string_extend_vip, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.network.e.60.1.1
                                                @Override // android.content.DialogInterface.OnClickListener
                                                public void onClick(DialogInterface dialogInterface, int i2) {
                                                    if (i2 == 0) {
                                                        try {
                                                            if (chat.ola.vn.c.c() != null) {
                                                                BuyVipActivity.c(chat.ola.vn.c.c(), chat.ola.vn.h.a());
                                                            }
                                                        } catch (Throwable unused) {
                                                            return;
                                                        }
                                                    }
                                                    dialogInterface.dismiss();
                                                }
                                            });
                                        } catch (Throwable unused) {
                                        }
                                    }
                                }
                            }, 10000L);
                        }
                        chat.ola.vn.h.E = jCurrentTimeMillis;
                        chat.ola.vn.h.b.a(chat.ola.vn.h.E);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str) {
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.22
            @Override // java.lang.Runnable
            public void run() {
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final int i, final short s, final String str2, final long j, final List<ah> list, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.77
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.K = i;
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, i, s, str2, j, list, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(str, Integer.valueOf(i), Short.valueOf(s), str2, Long.valueOf(j), list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final int i, final int[] iArr, final int[] iArr2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.30
            @Override // java.lang.Runnable
            public void run() {
                boolean z;
                try {
                    if (m.b(str, chat.ola.vn.h.a())) {
                        return;
                    }
                    if (chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().f()) {
                        chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().a(iArr2[0], iArr2[1], chat.ola.vn.game.caro.a.a);
                        chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().a(false);
                        z = false;
                    } else {
                        chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().a(iArr2[0], iArr2[1], chat.ola.vn.game.caro.a.b);
                        chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().a(true);
                        z = true;
                    }
                    chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().a(!z);
                    chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).Q().b(false);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, i, iArr, iArr2);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final long j) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.104
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD == null) {
                        fVarD = chat.ola.vn.h.t.b(str, (short) 0, true);
                    }
                    if (fVarD != null) {
                        fVarD.a(chat.ola.vn.message.e.a(str, j));
                        fVarD.K = Long.valueOf(System.currentTimeMillis());
                        chat.ola.vn.util.c.b.a(OlaApplication.a(), str, chat.ola.vn.h.a(), j);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, long j, String str2, String str3, String str4, String str5, int i, String str6) {
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final long j, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.100
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.n = j;
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, j, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, Long.valueOf(j));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final chat.ola.vn.entity.i iVar, final l lVar, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.120
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, iVar, lVar, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, iVar, lVar);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final chat.ola.vn.message.d dVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.31
            @Override // java.lang.Runnable
            public void run() {
                e.this.a(str, (short) 0, dVar);
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, ci ciVar) {
        try {
            boolean z = true;
            if (chat.ola.vn.h.j != null && chat.ola.vn.h.j.size() > 0) {
                chat.ola.vn.h.j.remove(chat.ola.vn.h.j.size() - 1);
            }
            if (chat.ola.vn.h.j == null) {
                chat.ola.vn.h.j = new ArrayList();
            }
            Iterator<String> it2 = chat.ola.vn.h.j.iterator();
            while (true) {
                if (!it2.hasNext()) {
                    break;
                } else if (m.b(it2.next(), str)) {
                    z = false;
                    break;
                }
            }
            this.a.x(str);
            if (z) {
                chat.ola.vn.h.j.add(str);
                chat.ola.vn.h.b.a(chat.ola.vn.h.j);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, String str2) {
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final chat.ola.vn.message.d dVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.32
            @Override // java.lang.Runnable
            public void run() {
                e.this.a(str, (short) 0, str2, dVar);
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String str3, final String str4, final long j, short s) {
        try {
            chat.ola.vn.h.d(str);
            chat.ola.vn.h.b(str2);
            chat.ola.vn.h.c(str3);
            chat.ola.vn.e.a().a(str);
            chat.ola.vn.e.a().b(str3);
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.10
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        chat.ola.vn.h.b.a(OlaApplication.a(), str, str2, str3, str4);
                        e.this.a.b(str);
                        try {
                            if (j > 0) {
                                j.c(OlaApplication.a(), OlaApplication.a(R.string.message_last_login_time, com.mg.ola.common.d.i.a(j)));
                            }
                        } catch (Throwable unused) {
                        }
                        if (e.this.a.j != null && e.this.a.j.size() != 0) {
                            Iterator<f> it2 = e.this.a.j.iterator();
                            while (it2.hasNext()) {
                                it2.next().w();
                            }
                            return;
                        }
                        chat.ola.vn.c.c().w();
                    } catch (Throwable unused2) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String str3, final String str4, final String str5, final String str6) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.118
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (chat.ola.vn.h.t.e(str3) == null) {
                        chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(str3, (short) 2);
                        fVar.c(str5);
                        fVar.e(str6);
                        fVar.g(str4);
                        chat.ola.vn.h.t.k(fVar);
                        chat.ola.vn.h.t.b(str3, (short) 2, true).B = false;
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b((short) 20);
                    if (eVarB != null) {
                        eVarB.a(str2, str3, str4, str5, str6);
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, str3, str4, str5, str6);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String str3, final String str4, final String str5, final String str6, final String str7, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.98
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, str3, str4, str5, str6, str7, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str5, str6);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String str3, final String str4, final String str5, final String str6, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.117
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarD;
                try {
                    if (chat.ola.vn.h.t.e(str3) == null) {
                        if (m.a(str)) {
                            fVarD = chat.ola.vn.h.t.b(str3, (short) 2, true);
                            fVarD.B = false;
                            fVarD.c(str5);
                            fVarD.e(str6);
                            fVarD.g(str4);
                        } else {
                            fVarD = chat.ola.vn.h.t.d(str, (short) 2);
                            if (fVarD == null) {
                                fVarD = chat.ola.vn.h.t.b(str3, (short) 2, true);
                            } else {
                                chat.ola.vn.h.t.a(chat.ola.vn.message.f.b(str3, (short) 2), fVarD);
                                fVarD.a(str3);
                            }
                            fVarD.B = false;
                            fVarD.c(str5);
                            fVarD.e(str6);
                            fVarD.g(str4);
                        }
                        chat.ola.vn.h.t.k(fVarD);
                        chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                        if (eVarB != null) {
                            eVarB.a(str2, str3, str4, str5, str6);
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String str3, final String str4, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.108
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, str3, str4, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(new Object[0]);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, String str2, String str3, String str4, boolean z) {
        chat.ola.vn.h.L = str2;
        chat.ola.vn.h.M = str;
        chat.ola.vn.h.N = str4;
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String str3, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.99
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, str2, str3, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, str3);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final List<chat.ola.vn.entity.i> list, final String str3, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.133
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, list, str3, Short.valueOf(s));
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, list, str3, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final List<ac> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.86
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, list, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.71
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(new Object[0]);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, short s, final ah ahVar, final int i, final long j) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.79
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str2, (short) 0);
                    if (fVarD == null) {
                        fVarD = chat.ola.vn.h.t.b(str2, (short) 0, true);
                    }
                    if (fVarD != null) {
                        q qVarB = chat.ola.vn.message.e.b(str2, j, i, ahVar);
                        qVarB.a((byte) 2);
                        qVarB.n(str);
                        qVarB.f(OlaApplication.a(R.string.string_tradding_vip));
                        fVarD.a((chat.ola.vn.message.d) qVarB, true);
                        fVarD.K = Long.valueOf(System.currentTimeMillis());
                        chat.ola.vn.util.c.b.a(fVarD, qVarB);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final short s, final String str3, final String str4) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.3
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str2, (short) 2, true)) == null) {
                        return;
                    }
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                    dVar.d(str);
                    dVar.a(System.currentTimeMillis());
                    dVar.a(s);
                    k kVarA = chat.ola.vn.message.e.a(dVar, (byte) 1, str3, str4);
                    fVarB.a(kVarA);
                    chat.ola.vn.util.c.b.a(fVarB, kVarA);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final short s, final String str3, short s2, short s3) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.7
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str2, (short) 2, false)) == null) {
                        return;
                    }
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                    dVar.d(str);
                    dVar.a(s);
                    dVar.a(System.currentTimeMillis());
                    dVar.e(chat.ola.vn.h.a());
                    aa aaVarA = chat.ola.vn.message.e.a(dVar, (byte) 1, str3);
                    fVarB.a(aaVarA);
                    if (fVarB.I()) {
                        OlaVoiceChatService.b(OlaApplication.a(), aaVarA);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final chat.ola.vn.entity.g[] gVarArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.48
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, gVarArr, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final String str2, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.17
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().e(str, str2, strArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final List<l> list, final String str2, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.132
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, list, str2, Short.valueOf(s));
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, list, str2, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final List<chat.ola.vn.message.f> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.55
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarE;
                try {
                    if (chat.ola.vn.h.t != null && (fVarE = chat.ola.vn.h.t.e(str)) != null) {
                        fVarE.a(list);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, list);
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, list, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, short s) {
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.126
            @Override // java.lang.Runnable
            public void run() {
                try {
                    ah ahVarB = chat.ola.vn.j.a().b(s);
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD == null) {
                        fVarD = chat.ola.vn.h.t.b(str, (short) 0, true);
                    }
                    if (fVarD != null) {
                        q qVarB = chat.ola.vn.message.e.b(str, 0L, i, ahVarB);
                        qVarB.a((byte) 2);
                        qVarB.n(null);
                        qVarB.f(OlaApplication.a(R.string.string_tradding_vip));
                        fVarD.a((chat.ola.vn.message.d) qVarB, true);
                        fVarD.K = Long.valueOf(System.currentTimeMillis());
                        chat.ola.vn.util.c.b.a(fVarD, qVarB);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final int i, final long j, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.83
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s, i, j, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(0, str, Short.valueOf(s), Integer.valueOf(i), Long.valueOf(j));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final int i, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.84
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s, i, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(1, str, Short.valueOf(s), Integer.valueOf(i));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, short s, final v vVar) {
        if (s != 0) {
            return;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.38
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD != null) {
                        if (fVarD.h() == -1) {
                            fVarD.c(vVar.H);
                        }
                        if (m.a(fVarD.b()) || m.b(fVarD.j(), fVarD.b())) {
                            fVarD.c(vVar.B);
                        }
                        if (m.a(vVar.k())) {
                            vVar.f(fVarD.d());
                        }
                        if (fVarD.r() == -1) {
                            fVarD.a(vVar.F);
                        } else if (vVar.F == -1) {
                            vVar.F = fVarD.r();
                        }
                        if (fVarD.i() <= 0) {
                            fVarD.e(vVar.I);
                        } else if (vVar.I <= 0) {
                            try {
                                vVar.I = (byte) fVarD.i();
                                vVar.z = chat.ola.vn.j.a().b(vVar.I);
                            } catch (Throwable unused) {
                            }
                        }
                        fVarD.a(vVar);
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.39
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, s);
                    if (fVarD != null) {
                        fVarD.l(str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final String str2, final String str3) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.96
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarB = chat.ola.vn.h.t.b(str, (short) 0, true);
                    if (fVarB != null) {
                        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                        dVar.d(str);
                        dVar.a(System.currentTimeMillis());
                        dVar.a(s);
                        k kVarA = chat.ola.vn.message.e.a(dVar, (byte) 1, str2, str3);
                        fVarB.a(kVarA);
                        chat.ola.vn.util.c.b.a(fVarB, kVarA);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final String str2, final String str3, final boolean z) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.40
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.d dVarO;
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, s);
                    if (fVarD == null || (dVarO = fVarD.o(str2)) == null) {
                        return;
                    }
                    dVarO.w = z;
                    dVarO.f(str3);
                    dVarO.p = null;
                    fVarD.E();
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final String str2, final List<chat.ola.vn.message.d> list, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.4
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarB = chat.ola.vn.h.t.b(str, s, false);
                    if (fVarB != null) {
                        if (list == null || list.size() <= 0) {
                            fVarB.V = (byte) 2;
                            fVarB.O = null;
                            fVarB.Q = false;
                            fVarB.a((List<chat.ola.vn.message.d>) null, str2);
                        } else {
                            fVarB.V = (byte) 2;
                            fVarB.O = null;
                            fVarB.Q = true;
                            fVarB.a(list, str2);
                        }
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s), str2, list, Short.valueOf(s2));
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s, str2, list, s2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final String str2, short s2, short s3) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.95
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str, (short) 0, true)) == null) {
                        return;
                    }
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                    dVar.d(str);
                    dVar.a(s);
                    dVar.a(System.currentTimeMillis());
                    dVar.e(chat.ola.vn.h.a());
                    aa aaVarA = chat.ola.vn.message.e.a(dVar, (byte) 1, str2);
                    fVarB.a(aaVarA);
                    if (fVarB.I()) {
                        OlaVoiceChatService.b(OlaApplication.a(), aaVarA);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final String str2, final boolean z) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.42
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.d dVarO;
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, s);
                    if (fVarD == null || (dVarO = fVarD.o(str2)) == null) {
                        return;
                    }
                    dVarO.x = z;
                    fVarD.E();
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final List<chat.ola.vn.entity.g> list, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.49
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s, list, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s), list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final short s, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.76
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String str, final byte[] bArr) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.97
            @Override // java.lang.Runnable
            public void run() {
                Iterator<f> it2 = e.this.a.j.iterator();
                while (it2.hasNext()) {
                    it2.next().a(str, bArr);
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String str, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.p.g
    public void a(final List<chat.ola.vn.message.f> list) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.47
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.t.b(list);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a_(list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final List<chat.ola.vn.message.f> list, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.92
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.t.d(list);
                    chat.ola.vn.h.t.a((byte) 3);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(list, i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final List<l> list, final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.89
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(list, str, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(list, str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final List<ac> list, final List<ah> list2, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.82
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(list, list2, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(list, list2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final List<s> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.57
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.x.a(list);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(list, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.105
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final short s, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.78
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(s, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(Short.valueOf(s));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final byte[] bArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.61
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(bArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(bArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final chat.ola.vn.entity.j[] jVarArr, final int i, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.68
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.util.c.b.a(OlaApplication.a());
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(jVarArr, i, s);
                    }
                    if (jVarArr != null) {
                        for (int i2 = 0; i2 < jVarArr.length; i2++) {
                            jVarArr[i2].e = chat.ola.vn.util.i.d(jVarArr[i2].e, "").toString();
                        }
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(jVarArr, Integer.valueOf(i));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(chat.ola.vn.message.f[] fVarArr) {
        if (fVarArr == null) {
            return;
        }
        final ArrayList arrayList = new ArrayList();
        for (chat.ola.vn.message.f fVar : fVarArr) {
            chat.ola.vn.message.f fVarE = chat.ola.vn.h.t.e(fVar.j(), (short) 0);
            if (fVarE != null) {
                if (fVar.g() != fVarE.g()) {
                    arrayList.add(fVarE);
                }
                fVarE.b(fVar.g());
                if (fVar.g() != 2) {
                    fVarE.N = System.currentTimeMillis();
                }
                fVarE.c(fVar.f());
                fVarE.e(fVar.d());
                fVarE.e(fVar.i());
                fVarE.c(fVar.h());
            }
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.114
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.t.s();
                    if (OlaApplication.e()) {
                        return;
                    }
                    for (chat.ola.vn.message.f fVar2 : arrayList) {
                        if (fVar2.g() == 2) {
                            chat.ola.vn.util.c.b.a(OlaApplication.a(R.string.message_contact_status_online, fVar2.L().toString()), fVar2.j());
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(final String[] strArr, final String[] strArr2, final String str, final String str2, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.21
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (strArr != null && strArr.length > 0) {
                        List<chat.ola.vn.message.f> listY = chat.ola.vn.h.t.y();
                        if (str == null) {
                            listY = new ArrayList<>(strArr.length);
                            chat.ola.vn.r.a.e.b = 0;
                        }
                        chat.ola.vn.r.a.e.a = str2;
                        for (int i = 0; i < strArr.length; i++) {
                            try {
                                if (strArr[i].startsWith("#") || chat.ola.vn.h.t.e(strArr[i], (short) 0) == null) {
                                    chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strArr[i], (short) 0);
                                    try {
                                        fVar.b(strArr2[i]);
                                    } catch (Throwable unused) {
                                    }
                                    listY.add(fVar);
                                }
                            } catch (Throwable unused2) {
                            }
                        }
                        chat.ola.vn.h.t.h(listY);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(strArr, str2);
                    }
                } catch (Throwable unused3) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void a(String[] strArr, String[] strArr2, short s) {
    }

    @Override // chat.ola.vn.p.g
    public void b() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.124
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (e.this.a.j() == 7) {
                        chat.ola.vn.h.d(null);
                        e.this.a.k = true;
                        if (OlaApplication.e()) {
                            chat.ola.vn.util.c.b.c(OlaApplication.a());
                        } else {
                            j.d(chat.ola.vn.c.c() != null ? chat.ola.vn.c.c() : OlaApplication.a(), R.string.message_connection_login_another_content);
                        }
                        e.this.a.a(1);
                        Iterator<f> it2 = e.this.a.j.iterator();
                        while (it2.hasNext()) {
                            it2.next().l();
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.43
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final long j, final int i, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.122
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(j, i, s);
                    }
                    chat.ola.vn.h.u.d(i);
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(Long.valueOf(j), Integer.valueOf(i), Short.valueOf(s));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final long j, final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.91
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(j, str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final long j, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.8
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (chat.ola.vn.h.u.g() == null) {
                        OlaApplication.b.b(j, new chat.ola.vn.p.c() { // from class: chat.ola.vn.network.e.8.1
                            @Override // chat.ola.vn.p.c
                            public void a(long j2) {
                            }

                            @Override // chat.ola.vn.p.c
                            public void a(long j2, chat.ola.vn.entity.f fVar) {
                                chat.ola.vn.entity.g gVar = new chat.ola.vn.entity.g(fVar);
                                if (chat.ola.vn.h.u.g() == null) {
                                    chat.ola.vn.h.u.a(gVar);
                                }
                            }
                        });
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(j, s);
                    }
                } catch (Throwable unused) {
                }
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(Long.valueOf(j));
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final ad adVar, final List<ad> list, final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.13
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(adVar, list, str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final chat.ola.vn.message.t tVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.19
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(tVar.j(), (short) 2, true)) == null) {
                        return;
                    }
                    fVarB.a(tVar);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.70
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str);
                    }
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD != null) {
                        fVarD.m(str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(String str, int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.24
            @Override // java.lang.Runnable
            public void run() {
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final chat.ola.vn.message.d dVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.34
            @Override // java.lang.Runnable
            public void run() {
                e.this.a(str, (short) 2, dVar);
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(String str, String str2) {
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final String str2, final chat.ola.vn.message.d dVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.35
            @Override // java.lang.Runnable
            public void run() {
                e.this.a(str, (short) 2, str2, dVar);
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final String str2, final String str3, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.107
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, str3, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(new Object[0]);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final String str2, final List<chat.ola.vn.entity.a> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.87
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, str2, list, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final String str2, final chat.ola.vn.entity.g[] gVarArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.16
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        String str3 = str;
                        if (str3 == null) {
                            str3 = "";
                        }
                        String str4 = str2;
                        if (str4 == null) {
                            str4 = "";
                        }
                        eVarB.a(str3, str4, gVarArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final String str2, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.109
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2, strArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final List<chat.ola.vn.entity.i> list, final String str2, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.90
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, list, str2, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, list, str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final List<chat.ola.vn.entity.aa> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.5
            private void a(List<chat.ola.vn.entity.aa> list2) {
                chat.ola.vn.r.b bVar;
                try {
                    for (chat.ola.vn.entity.aa aaVar : list2) {
                        try {
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                        if (m.b(aaVar.a, "rsshistory")) {
                            try {
                                chat.ola.vn.h.s.b(chat.ola.vn.h.b.b(aaVar.b));
                            } catch (Throwable unused) {
                            }
                            chat.ola.vn.h.s.b(true);
                            bVar = chat.ola.vn.h.s;
                        } else if (m.b(aaVar.a, "rssbookmark")) {
                            try {
                                chat.ola.vn.h.s.a(chat.ola.vn.h.b.b(aaVar.b));
                            } catch (Throwable unused2) {
                            }
                            chat.ola.vn.h.s.a(true);
                            bVar = chat.ola.vn.h.s;
                        }
                        bVar.g();
                    }
                } catch (Throwable unused3) {
                }
            }

            private void b(List<chat.ola.vn.entity.aa> list2) {
                try {
                    for (chat.ola.vn.entity.aa aaVar : list2) {
                        try {
                            if (m.b(aaVar.a, "usersettings")) {
                                chat.ola.vn.w.s sVarB = o.b(aaVar.b);
                                try {
                                    String strB = sVarB.b((short) 107);
                                    x.u = true;
                                    if (!m.a(strB)) {
                                        x.u = Boolean.parseBoolean(strB);
                                    }
                                } catch (Throwable unused) {
                                }
                                try {
                                    String strB2 = sVarB.b((short) 86);
                                    x.l = (byte) 0;
                                    if (!m.a(strB2)) {
                                        x.l = Byte.parseByte(strB2);
                                    }
                                } catch (Throwable unused2) {
                                }
                                try {
                                    String strB3 = sVarB.b((short) 104);
                                    x.t = true;
                                    if (!m.a(strB3)) {
                                        x.t = Boolean.parseBoolean(strB3);
                                    }
                                } catch (Throwable unused3) {
                                }
                                try {
                                    String strB4 = sVarB.b((short) 105);
                                    x.b = false;
                                    if (!m.a(strB4)) {
                                        x.b = Boolean.valueOf(Boolean.parseBoolean(strB4));
                                    }
                                } catch (Throwable unused4) {
                                }
                                try {
                                    String strB5 = sVarB.b((short) 91);
                                    x.r = true;
                                    if (!m.a(strB5)) {
                                        x.r = Boolean.parseBoolean(strB5);
                                    }
                                } catch (Throwable unused5) {
                                }
                                try {
                                    String strB6 = sVarB.b((short) 95);
                                    x.s = false;
                                    if (!m.a(strB6)) {
                                        x.s = Boolean.parseBoolean(strB6);
                                    }
                                } catch (Throwable unused6) {
                                }
                                String strB7 = sVarB.b((short) 101);
                                x.p = (byte) 0;
                                if (!m.a(strB7)) {
                                    x.p = Byte.parseByte(strB7);
                                }
                            }
                        } catch (Throwable unused7) {
                        }
                    }
                } catch (Throwable unused8) {
                }
            }

            private void c(List<chat.ola.vn.entity.aa> list2) {
                try {
                    for (chat.ola.vn.entity.aa aaVar : list2) {
                        try {
                            if (m.b(aaVar.a, "mehistory")) {
                                List<chat.ola.vn.entry.g> listA = chat.ola.vn.h.b.a(aaVar.b);
                                if (listA == null || listA.size() <= 0) {
                                    chat.ola.vn.h.w.a((List<chat.ola.vn.entry.g>) null);
                                } else {
                                    ArrayList arrayList = new ArrayList();
                                    for (chat.ola.vn.entry.g gVar : listA) {
                                        String strA = gVar.a();
                                        if (!m.a(strA)) {
                                            chat.ola.vn.entity.x xVar = new chat.ola.vn.entity.x();
                                            if (strA.startsWith("#")) {
                                                xVar.c = strA;
                                                xVar.a = (byte) 1;
                                            } else {
                                                xVar.c = "@" + strA;
                                                xVar.a = (byte) 0;
                                            }
                                            if (arrayList == null) {
                                                arrayList = new ArrayList();
                                            }
                                            arrayList.add(gVar);
                                            chat.ola.vn.g.a(xVar);
                                        }
                                    }
                                    if (arrayList != null) {
                                        chat.ola.vn.h.w.a(arrayList);
                                    }
                                }
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                } catch (Throwable unused) {
                }
            }

            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.r.a.e eVar;
                try {
                    try {
                        try {
                            if (m.b(str, "bmk")) {
                                c(list);
                            } else if (m.b(str, "set")) {
                                b(list);
                            } else if (m.b(str, "rss")) {
                                a(list);
                            }
                            eVar = chat.ola.vn.h.u;
                        } catch (Throwable unused) {
                            eVar = chat.ola.vn.h.u;
                        }
                        eVar.g = true;
                        chat.ola.vn.g.c = true;
                        chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                        if (eVarB != null) {
                            if (list != null) {
                                eVarB.a(str, list, Short.valueOf(s));
                            } else {
                                eVarB.a(34, (short) 80, null, null);
                            }
                        }
                    } catch (Throwable th) {
                        chat.ola.vn.h.u.g = true;
                        chat.ola.vn.g.c = true;
                        throw th;
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.63
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final short s, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.128
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, s, i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final short s, final int i, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.85
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, s, i, s2);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(4, str, Short.valueOf(s), Integer.valueOf(i));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final short s, final String str2, final List<chat.ola.vn.message.d> list, final short s2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.6
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s), str2, list, Short.valueOf(s2));
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final String str, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.119
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, strArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.p.g
    public void b(final List<chat.ola.vn.message.f> list, final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.36
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.t.a(list, str);
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(list, str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final List<chat.ola.vn.message.f> list, short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.69
            @Override // java.lang.Runnable
            public void run() {
                boolean z;
                try {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(System.currentTimeMillis());
                    int i = calendar.get(5);
                    int i2 = calendar.get(2);
                    int i3 = calendar.get(1);
                    ArrayList<chat.ola.vn.message.f> arrayList = null;
                    String str = "";
                    chat.ola.vn.h.t.c(list);
                    for (chat.ola.vn.message.f fVar : list) {
                        chat.ola.vn.message.f fVarE = chat.ola.vn.h.t.e(fVar.j(), fVar.k());
                        if (fVarE != null) {
                            fVarE.b(fVar.f());
                        }
                        calendar.setTimeInMillis(fVar.f());
                        int i4 = calendar.get(5);
                        int i5 = calendar.get(2);
                        if (i == i4 && i2 == i5) {
                            if (arrayList == null) {
                                arrayList = new ArrayList();
                            }
                            if (fVarE != null) {
                                fVar = fVarE;
                            }
                            arrayList.add(fVar);
                            str = m.a(str) ? "@" + fVar.j() : str + ", @" + fVar.j();
                        }
                    }
                    if (arrayList == null || arrayList.size() <= 0) {
                        return;
                    }
                    chat.ola.vn.entry.e eVarB = chat.ola.vn.h.v.b(R.string.general_tab_birthday);
                    if (eVarB == null) {
                        eVarB = new chat.ola.vn.o.b(arrayList.size());
                    }
                    eVarB.c((i3 * 10000) + (i2 * 100) + i + 100000000);
                    eVarB.c(m.a(arrayList.size()));
                    eVarB.d(str);
                    eVarB.b(2);
                    chat.ola.vn.h.v.a(eVarB);
                    chat.ola.vn.h.v.a();
                    chat.ola.vn.h.v.g();
                    chat.ola.vn.h.t.c(arrayList);
                    String strC = chat.ola.vn.h.b.c();
                    String str2 = i + ":" + i2 + ":" + i3;
                    if (m.a(strC)) {
                        for (chat.ola.vn.message.f fVar2 : arrayList) {
                            str2 = str2 + ";" + fVar2.j();
                            chat.ola.vn.util.c.b.a(fVar2);
                            chat.ola.vn.h.b.a(str2);
                        }
                        return;
                    }
                    String[] strArrSplit = strC.split(";");
                    if (strArrSplit == null || strArrSplit.length <= 0) {
                        return;
                    }
                    if (!m.b(strArrSplit[0], str2)) {
                        for (chat.ola.vn.message.f fVar3 : arrayList) {
                            str2 = str2 + ";" + fVar3.j();
                            chat.ola.vn.util.c.b.a(fVar3);
                            chat.ola.vn.h.b.a(str2);
                        }
                        return;
                    }
                    String str3 = strC;
                    boolean z2 = false;
                    for (chat.ola.vn.message.f fVar4 : arrayList) {
                        int i6 = 1;
                        while (true) {
                            if (i6 >= strArrSplit.length) {
                                z = false;
                                break;
                            } else {
                                if (m.b(strArrSplit[i6], fVar4.j())) {
                                    z = true;
                                    break;
                                }
                                i6++;
                            }
                        }
                        if (!z) {
                            String str4 = str3 + ";" + fVar4.j();
                            chat.ola.vn.util.c.b.a(fVar4);
                            str3 = str4;
                            z2 = true;
                        }
                    }
                    if (z2) {
                        chat.ola.vn.h.b.a(str3);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.41
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(new Object[0]);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void b(final short s, final short s2) {
        x.e = Short.valueOf(s);
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s2);
                    if (eVarB != null) {
                        eVarB.a(Short.valueOf(s), Short.valueOf(s2));
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(s, s2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c() {
        try {
            this.a.b((String) null, (short) 0);
        } catch (Throwable unused) {
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.23
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().m();
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final ad adVar, final List<ad> list, final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.14
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(adVar, list, str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.72
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str);
                    }
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD != null) {
                        fVarD.n(str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(String str, int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.25
            @Override // java.lang.Runnable
            public void run() {
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final String str, final chat.ola.vn.message.d dVar) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.53
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str, (short) 2, true)) == null) {
                        return;
                    }
                    chat.ola.vn.message.d dVarA = m.b(chat.ola.vn.h.a(), dVar.i()) ? chat.ola.vn.message.e.a(dVar, (byte) 2) : chat.ola.vn.message.e.a(dVar, (byte) 1);
                    fVarB.a(dVarA);
                    chat.ola.vn.util.c.b.a(fVarB, dVarA);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.52
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str2, (short) 0, true)) == null) {
                        return;
                    }
                    chat.ola.vn.message.c cVarA = chat.ola.vn.message.e.a(str, str2);
                    fVarB.a(cVarA);
                    chat.ola.vn.util.c.b.a(fVarB, cVarA);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final String str, final String str2, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.110
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, str2, strArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.88
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b((short) 26);
                    if (eVarB != null) {
                        eVarB.a(str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final List<af> list) {
        if (list == null) {
            return;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.56
            @Override // java.lang.Runnable
            public void run() {
                boolean z;
                boolean z2;
                try {
                    if (list != null) {
                        for (af afVar : list) {
                            if (!m.b(afVar.b(), "#daptrung")) {
                                if (m.b(afVar.b(), "lk")) {
                                    z = true;
                                    z2 = false;
                                    break;
                                }
                            } else {
                                z = false;
                                break;
                            }
                        }
                        z = true;
                        z2 = true;
                    } else {
                        z = true;
                        z2 = true;
                    }
                    af afVar2 = z ? new af(OlaApplication.a(R.string.system_me_eggy), "#daptrung") : null;
                    af afVar3 = z2 ? new af(OlaApplication.a(R.string.system_me_likes), "lk") : null;
                    af afVar4 = new af("#Android", "#apk");
                    af afVar5 = new af("#Ola", "#Ola");
                    af afVar6 = new af(OlaApplication.a(R.string.system_me_funny), "#hai");
                    af afVar7 = new af(OlaApplication.a(R.string.system_me_diary), "my diary");
                    af afVar8 = new af(OlaApplication.a(R.string.system_me_box), "mariage diary");
                    if (list != null) {
                        list.add(0, afVar7);
                        list.add(1, afVar8);
                        if (afVar3 != null) {
                            list.add(afVar3);
                        }
                        if (afVar2 != null) {
                            list.add(afVar2);
                        }
                        list.add(afVar4);
                        list.add(afVar5);
                        list.add(afVar6);
                        chat.ola.vn.h.b.d((List<af>) list);
                        chat.ola.vn.h.u.a(list);
                        Iterator<f> it2 = e.this.a.j.iterator();
                        while (it2.hasNext()) {
                            it2.next().b(list);
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void c(final List<chat.ola.vn.message.f> list, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.75
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (list == null || list.isEmpty()) {
                        return;
                    }
                    chat.ola.vn.h.t.i(list);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(list, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(list);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.65
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Log.d("OlaNetworkService", "-----notifyLostConnection-----");
                    e.this.a.a(1);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().u();
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.80
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.s sVar;
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD == null || (sVar = (chat.ola.vn.message.s) fVarD.o("sent-tradding-vip")) == null) {
                        return;
                    }
                    sVar.c((byte) 3);
                    chat.ola.vn.util.c.b.b(OlaApplication.a(), str);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d(final String str, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.26
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.t.b(chat.ola.vn.message.f.b(str, (short) 0)).R();
                    chat.ola.vn.i.i.b(OlaApplication.a(), OlaApplication.a().getResources().getString(R.string.string_info), "@" + str + " " + OlaApplication.a().getResources().getString(R.string.message_my_friend_left_caro_game));
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.113
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().c(str, str2);
                    }
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                    dVar.d(str2);
                    dVar.a(System.currentTimeMillis());
                    dVar.f(OlaApplication.a(R.string.message_chatgroup_joined_format, "@" + str2));
                    if (chat.ola.vn.h.t != null) {
                        chat.ola.vn.message.f fVarB = chat.ola.vn.h.t.b(str, (short) 2, true);
                        if (fVarB != null) {
                            fVarB.a((List<chat.ola.vn.message.f>) null);
                            fVarB.a(chat.ola.vn.message.e.a(dVar, (byte) 0));
                        }
                        fVarB.B();
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d(final String str, final String str2, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.111
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().c(str, str2, strArr, s);
                    }
                    if (str == null || m.b(str, chat.ola.vn.h.a())) {
                        new ArrayList();
                        if (strArr != null && strArr.length > 0) {
                            ArrayList arrayList = new ArrayList(strArr.length);
                            for (String str3 : strArr) {
                                arrayList.add("#" + str3);
                            }
                            chat.ola.vn.h.u.d(arrayList);
                        }
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.130
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s));
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().d(str, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void d(final List<chat.ola.vn.entity.k> list, short s) {
        if (list != null && list.size() > 0) {
            OlaReleaseAppActivity.e = list.get(0);
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.20
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.r.a.c cVar;
                List<chat.ola.vn.entity.k> arrayList;
                try {
                    if (list == null) {
                        cVar = chat.ola.vn.h.v;
                        arrayList = new ArrayList<>();
                    } else {
                        cVar = chat.ola.vn.h.v;
                        arrayList = list;
                    }
                    cVar.a(arrayList);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void e() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.66
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (e.this.a.j() < 5) {
                        e.this.a.a(5);
                    }
                } catch (Throwable unused) {
                }
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().q();
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void e(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.81
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.s sVar;
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD == null || (sVar = (chat.ola.vn.message.s) fVarD.o("sent-tradding-vip")) == null) {
                        return;
                    }
                    sVar.c((byte) 2);
                    sVar.f(OlaApplication.a(R.string.string_denied) + " " + OlaApplication.a(R.string.string_tradding_vip));
                    chat.ola.vn.util.c.b.a(fVarD, sVar);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void e(final String str, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.27
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void e(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.115
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().d(str, str2);
                    }
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                    dVar.d(str2);
                    dVar.a(System.currentTimeMillis());
                    dVar.f(OlaApplication.a(R.string.message_chatgroup_deny_format, "@" + str2));
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str, (short) 2, true)) == null) {
                        return;
                    }
                    fVarB.a(chat.ola.vn.message.e.a(dVar, (byte) 0));
                    fVarB.B();
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void e(final String str, final String str2, final String[] strArr, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.112
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().d(str, str2, strArr, s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, str2, strArr);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void e(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.131
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s));
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().e(str, s);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void f() {
    }

    @Override // chat.ola.vn.p.g
    public void f(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.123
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().c(str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void f(final String str, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.28
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().c(str, i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void f(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.116
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.f fVarB;
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().e(str, str2);
                    }
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                    dVar.d(str2);
                    dVar.a(System.currentTimeMillis());
                    dVar.f(OlaApplication.a(R.string.message_chatgroup_leave_format, "@" + str2));
                    if (chat.ola.vn.h.t == null || (fVarB = chat.ola.vn.h.t.b(str, (short) 2, true)) == null) {
                        return;
                    }
                    fVarB.a(chat.ola.vn.message.e.a(dVar, (byte) 0));
                    fVarB.B();
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void f(String str, short s) {
        chat.ola.vn.h.e = str;
    }

    @Override // chat.ola.vn.p.g
    public void g() {
    }

    @Override // chat.ola.vn.p.g
    public void g(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.125
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.message.s sVar;
                try {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
                    if (fVarD == null || (sVar = (chat.ola.vn.message.s) fVarD.o("sent-tradding-vip")) == null) {
                        return;
                    }
                    sVar.c((byte) 2);
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void g(final String str, final int i) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.29
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().d(str, i);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void g(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.64
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str, str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void g(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.101
            @Override // java.lang.Runnable
            public void run() {
                Iterator<f> it2 = e.this.a.j.iterator();
                while (it2.hasNext()) {
                    it2.next().c(str, s);
                }
                chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                if (eVarB != null) {
                    eVarB.a(str);
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void h(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.127
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().d(str);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void h(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.73
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().a(str2);
                    }
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 2);
                    if (fVarD != null) {
                        fVarD.m(str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void h(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.106
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.h.b(str);
                    chat.ola.vn.h.b.a(OlaApplication.a(), chat.ola.vn.h.a(), str);
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(s);
                    }
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(new Object[0]);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void i(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.74
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(str, str2);
                    }
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 2);
                    if (fVarD != null) {
                        fVarD.n(str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void i(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.129
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str, Short.valueOf(s));
                    }
                } catch (Throwable unused) {
                }
                try {
                    if (m.a(str)) {
                        return;
                    }
                    chat.ola.vn.h.u.c(str);
                    j.d(OlaApplication.a(), R.string.message_create_clan_success_format, str);
                    if (OlaApplication.b != null) {
                        String strK = m.k(str);
                        if (m.a(strK)) {
                            return;
                        }
                        OlaApplication.b.a(OlaApplication.a(R.string.message_first_message_of_clan_format, "\"#" + strK + "\""), (String) null, (short) 0, (String) null, (short) 0);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void j(String str, String str2) {
        String strSubstring;
        final chat.ola.vn.message.d dVarO;
        String[] strArrE;
        try {
            final String strSubstring2 = null;
            if (m.a(str2) || (strArrE = m.e(str2, ";")) == null || strArrE.length <= 0) {
                strSubstring = null;
            } else {
                strSubstring = null;
                for (int i = 0; i < strArrE.length; i++) {
                    if (strArrE[i].startsWith("id=")) {
                        strSubstring2 = strArrE[i].substring(3);
                    }
                    if (strArrE[i].startsWith("chatgroupId=")) {
                        strSubstring = strArrE[i].substring("chatgroupId=".length());
                    }
                }
            }
            if (m.a(strSubstring2)) {
                return;
            }
            chat.ola.vn.message.f fVarD = !m.a(strSubstring) ? chat.ola.vn.h.t.d(strSubstring, (short) 2) : chat.ola.vn.h.t.d(str, (short) 0);
            if (fVarD == null || (dVarO = fVarD.o(strSubstring2)) == null) {
                return;
            }
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.102
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        if (m.a(strSubstring2)) {
                            return;
                        }
                        dVarO.b((byte) 2);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.g
    public void j(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.9
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().f(str, s);
                    }
                } catch (Throwable unused) {
                }
                try {
                    chat.ola.vn.entry.c.e eVarB = chat.ola.vn.entry.c.f.b(s);
                    if (eVarB != null) {
                        eVarB.a(str);
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.g
    public void k(final String str, final short s) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.e.37
            @Override // java.lang.Runnable
            public void run() {
                try {
                    chat.ola.vn.message.f fVarB = chat.ola.vn.h.t.b(str, s);
                    if (fVarB != null) {
                        fVarB.C();
                    }
                    Iterator<f> it2 = e.this.a.j.iterator();
                    while (it2.hasNext()) {
                        it2.next().g(str, s);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }
}
