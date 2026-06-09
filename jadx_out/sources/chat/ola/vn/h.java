package chat.ola.vn;

import android.annotation.SuppressLint;
import android.util.Log;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.ag;
import chat.ola.vn.util.m;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class h {
    public static int A = 0;
    public static Integer B = null;
    public static Integer C = null;
    public static Integer D = null;
    public static long E = 0;
    public static boolean F = true;
    public static int G = 0;
    public static short H = 0;
    public static boolean I = false;
    public static boolean J = false;
    public static int K = 0;
    public static String L = null;
    public static String M = null;
    public static String N = null;
    public static ag O = null;
    public static String S = null;
    public static String T = "US";
    private static String U = null;
    private static String V = null;
    private static String W = null;
    private static String X = null;
    private static int Y = 0;
    private static ExecutorService Z = null;
    public static boolean a = false;
    public static boolean b = false;
    public static int c = 0;
    public static int d = 0;
    public static String e = null;
    public static String f = null;
    public static String g = null;
    public static boolean h = false;
    public static int i = 0;
    public static List<String> j = null;
    public static List<String> k = null;
    public static boolean l = false;
    public static long m = Long.MAX_VALUE;
    public static long n = 0;
    public static long o = 0;
    public static long p = -1;
    public static int q = -1;
    public static int r;
    public static long y;
    public static int z;
    public static chat.ola.vn.r.b s = new chat.ola.vn.r.b();
    public static chat.ola.vn.message.g t = new chat.ola.vn.message.g();
    public static chat.ola.vn.r.a.e u = new chat.ola.vn.r.a.e();
    public static chat.ola.vn.r.a.c v = new chat.ola.vn.r.a.c();
    public static chat.ola.vn.r.a w = new chat.ola.vn.r.a.b();
    public static chat.ola.vn.r.a.f x = new chat.ola.vn.r.a.f();
    public static ScheduledExecutorService P = new ScheduledThreadPoolExecutor(1, new ThreadFactory() { // from class: chat.ola.vn.h.1
        @Override // java.util.concurrent.ThreadFactory
        public Thread newThread(Runnable runnable) {
            Thread thread = new Thread(runnable);
            thread.setName(OlaApplication.a + " Schedule-" + h.Y);
            h.k();
            return thread;
        }
    });
    public static ExecutorService Q = new ThreadPoolExecutor(1, 1, 10000, TimeUnit.MILLISECONDS, new LinkedBlockingQueue(), new ThreadFactory() { // from class: chat.ola.vn.h.2
        @Override // java.util.concurrent.ThreadFactory
        public Thread newThread(Runnable runnable) {
            Thread thread = new Thread(runnable);
            thread.setName(OlaApplication.a + " Sender-" + h.Y);
            h.k();
            return thread;
        }
    });
    public static ExecutorService R = new ThreadPoolExecutor(1, 2, 5000, TimeUnit.MILLISECONDS, new LinkedBlockingQueue(5), new ThreadFactory() { // from class: chat.ola.vn.h.3
        @Override // java.util.concurrent.ThreadFactory
        public Thread newThread(Runnable runnable) {
            Thread thread = new Thread(runnable);
            thread.setName("Mics Thread-" + h.Y);
            h.k();
            return thread;
        }
    });

    public static String a() {
        try {
            if (m.a(U)) {
                d(e.a().i());
            }
        } catch (Throwable unused) {
        }
        return U;
    }

    public static void a(Runnable runnable) {
        try {
            R.execute(runnable);
        } catch (Throwable th) {
            Log.e("OlaChat", "---executeShortTask---", th);
        }
    }

    public static boolean a(String str) {
        try {
            return !str.startsWith("fb:");
        } catch (Throwable unused) {
            return true;
        }
    }

    public static String b() {
        if (m.c(V)) {
            try {
                V = chat.ola.vn.h.b.c(OlaApplication.a(), a());
            } catch (Throwable unused) {
            }
        }
        return V;
    }

    public static void b(String str) {
        V = str;
    }

    public static String c() {
        if (m.c(W)) {
            try {
                W = chat.ola.vn.h.b.d(OlaApplication.a(), a());
            } catch (Throwable unused) {
            }
        }
        return W;
    }

    public static void c(String str) {
        X = str;
        e.a().b(str);
    }

    public static void d() {
        try {
            Z.shutdown();
        } catch (Throwable th) {
            Z = null;
            throw th;
        }
        Z = null;
    }

    public static void d(String str) {
        try {
            if (m.a(str) && m.a(U)) {
                x.g();
                t.k();
                u.e();
                s.j();
                return;
            }
            if (m.b(str, U)) {
                return;
            }
            try {
                if (str != null) {
                    U = str.toLowerCase();
                } else {
                    U = null;
                }
            } catch (Throwable unused) {
                U = null;
            }
            V = null;
            W = null;
            O = null;
            X = null;
            H = (short) 0;
            x.g();
            t.k();
            u.e();
            s.j();
            if (m.a(U)) {
                e.a().a((String) null);
                e.a().b((String) null);
                return;
            }
            try {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.h.5
                    @Override // java.lang.Runnable
                    public void run() {
                        h.t.e(chat.ola.vn.h.b.t(h.a()));
                    }
                });
            } catch (Throwable unused2) {
            }
            try {
                final List<String> listP = chat.ola.vn.h.b.p(a());
                final List<af> listE = chat.ola.vn.h.b.e();
                final List<chat.ola.vn.entity.g> listS = chat.ola.vn.h.b.s(a());
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.h.6
                    @Override // java.lang.Runnable
                    public void run() {
                        g.b();
                        if (h.u.c() == 1) {
                            if (listE != null && listE.size() > 0) {
                                h.u.a(listE);
                            }
                            if (listS != null && listS.size() > 0) {
                                h.u.a(null, (short) 0, listS);
                                h.u.d = ((chat.ola.vn.entity.g) listS.get(1)).e();
                            }
                        }
                        h.t.f(listP);
                    }
                });
            } catch (Throwable unused3) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static ExecutorService e() {
        if (Z == null) {
            int iAvailableProcessors = Runtime.getRuntime().availableProcessors();
            if (iAvailableProcessors < 0) {
                iAvailableProcessors = 0;
            }
            int i2 = iAvailableProcessors + 2;
            Z = new ThreadPoolExecutor(i2, i2, 5000L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue(), new ThreadFactory() { // from class: chat.ola.vn.h.4
                private int a = 0;

                @Override // java.util.concurrent.ThreadFactory
                public Thread newThread(Runnable runnable) {
                    Thread thread = new Thread(runnable);
                    thread.setName("Stinger Thread-" + this.a);
                    this.a = this.a + 1;
                    return thread;
                }
            });
        }
        return Z;
    }

    public static String f() {
        if (X == null) {
            try {
                X = e.a().j();
            } catch (Throwable unused) {
            }
        }
        return X;
    }

    public static boolean g() {
        return (m.a(a()) || m.a(f())) ? false : true;
    }

    public static boolean h() {
        return (m.a(a()) || m.c(b())) ? false : true;
    }

    public static boolean i() {
        return m.b(T, "VN");
    }

    static /* synthetic */ int k() {
        int i2 = Y + 1;
        Y = i2;
        return i2;
    }
}
