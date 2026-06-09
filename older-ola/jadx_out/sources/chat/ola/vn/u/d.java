package chat.ola.vn.u;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.w.cg;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ScheduledFuture;

/* JADX INFO: loaded from: classes.dex */
class d implements Runnable {
    private static d h;
    protected Socket a;
    protected n b;
    protected h c;
    ScheduledFuture<?> d = null;
    private List<g> e;
    private Runnable f;
    private LinkedBlockingQueue<e> g;
    private ExecutorService i;

    private d() {
        int length;
        int i;
        this.f = null;
        this.g = null;
        this.i = null;
        int iNextInt = new Random().nextInt(chat.ola.vn.f.d.f_.length);
        String str = chat.ola.vn.f.d.f_[iNextInt];
        int i2 = iNextInt;
        boolean z = false;
        int i3 = 0;
        while (!z) {
            try {
                this.a = new Socket();
                this.a.connect(new InetSocketAddress(str, 1240), 30000);
                this.a.setKeepAlive(true);
                this.b = new n(this.a.getOutputStream());
                this.c = new h(this.a.getInputStream(), this);
                z = true;
            } finally {
                if (i3 == length) {
                }
            }
        }
        this.e = new CopyOnWriteArrayList();
        this.c.a(this.e);
        this.f = new Runnable() { // from class: chat.ola.vn.u.d.1
            @Override // java.lang.Runnable
            public void run() {
                d.this.b();
            }
        };
        this.g = new LinkedBlockingQueue<>(10);
        if (this.i == null) {
            this.i = Executors.newFixedThreadPool(1);
        }
        this.i.execute(this.c);
        chat.ola.vn.h.e().execute(this);
    }

    public static synchronized d d() {
        if (h == null) {
            h = new d();
        }
        return h;
    }

    synchronized void a() {
        try {
            if (this.d != null) {
                try {
                    this.d.cancel(true);
                } catch (Throwable unused) {
                }
            }
            this.d = OlaApplication.b(this.f, 180000L);
        } catch (Throwable unused2) {
        }
    }

    public void a(e eVar) {
        try {
            this.g.put(eVar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(g gVar) {
        if (gVar == null) {
            return;
        }
        try {
            int size = this.e.size();
            for (int i = 0; i < size; i++) {
                if (chat.ola.vn.util.m.b(this.e.get(i).b(), gVar.b())) {
                    this.e.remove(i);
                    this.e.add(gVar);
                    return;
                }
            }
            this.e.add(gVar);
        } catch (Throwable unused) {
        }
    }

    public synchronized void a(String str) {
        try {
            int size = this.e.size();
            for (int i = 0; i < size; i++) {
                if (chat.ola.vn.util.m.b(this.e.get(i).b(), str)) {
                    this.e.remove(i);
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    synchronized void b() {
        try {
            Iterator<g> it2 = this.e.iterator();
            while (it2.hasNext()) {
                it2.next().a();
            }
        } catch (Throwable unused) {
        }
        c();
    }

    public void b(final e eVar) {
        try {
            chat.ola.vn.h.Q.execute(new Runnable() { // from class: chat.ola.vn.u.d.2
                @Override // java.lang.Runnable
                public void run() {
                    cg cgVarA;
                    try {
                        a aVarA = k.a(eVar.j);
                        if (aVarA != null && (cgVarA = aVarA.a(eVar, d.this.e)) != null) {
                            d.this.b.a(cgVarA);
                        }
                        d.this.a();
                    } catch (Throwable unused) {
                        d.this.b();
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    public synchronized void c() {
        if (this.a == null) {
            return;
        }
        this.e = null;
        if (this.c != null) {
            this.c.a(this.e);
        }
        try {
            this.b.a();
            this.b = null;
        } catch (Throwable unused) {
        }
        try {
            this.c.a();
            this.c = null;
        } catch (Throwable unused2) {
        }
        try {
            this.a.close();
        } catch (Throwable unused3) {
        }
        this.a = null;
        try {
            this.d.cancel(true);
            this.d = null;
        } catch (Throwable th) {
            this.d = null;
            this.f = null;
            throw th;
        }
        this.f = null;
        try {
            this.g.clear();
        } catch (Throwable unused4) {
        }
        this.g = null;
        chat.ola.vn.h.d();
        try {
            try {
                this.i.shutdownNow();
                this.i = null;
            } catch (Throwable unused5) {
                this.i = null;
            }
            h = null;
        } catch (Throwable th2) {
            this.i = null;
            h = null;
            throw th2;
        }
    }

    @Override // java.lang.Runnable
    public void run() {
        cg cgVarA;
        boolean z = true;
        while (z) {
            try {
                e eVarTake = this.g.take();
                a aVarA = k.a(eVarTake.j);
                if (aVarA != null && (cgVarA = aVarA.a(eVarTake, this.e)) != null) {
                    this.b.a(cgVarA);
                }
                a();
            } catch (Throwable unused) {
                z = false;
                b();
            }
        }
    }
}
