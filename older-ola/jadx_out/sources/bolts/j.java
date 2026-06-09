package bolts;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CancellationException;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;

/* JADX INFO: loaded from: classes.dex */
public class j<TResult> {
    private static volatile b d;
    private boolean f;
    private boolean g;
    private TResult h;
    private Exception i;
    private boolean j;
    private l k;
    public static final ExecutorService a = d.a();
    private static final Executor c = d.b();
    public static final Executor b = bolts.a.b();
    private static j<?> m = new j<>((Object) null);
    private static j<Boolean> n = new j<>(true);
    private static j<Boolean> o = new j<>(false);
    private static j<?> p = new j<>(true);
    private final Object e = new Object();
    private List<h<TResult, Void>> l = new ArrayList();

    public class a extends k<TResult> {
        a() {
        }
    }

    public interface b {
        void a(j<?> jVar, UnobservedTaskException unobservedTaskException);
    }

    j() {
    }

    private j(TResult tresult) {
        b(tresult);
    }

    private j(boolean z) {
        if (z) {
            i();
        } else {
            b((Object) null);
        }
    }

    public static b a() {
        return d;
    }

    public static <TResult> j<TResult> a(Exception exc) {
        k kVar = new k();
        kVar.b(exc);
        return kVar.a();
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static <TResult> j<TResult> a(TResult tresult) {
        if (tresult == 0) {
            return (j<TResult>) m;
        }
        if (tresult instanceof Boolean) {
            return ((Boolean) tresult).booleanValue() ? (j<TResult>) n : (j<TResult>) o;
        }
        k kVar = new k();
        kVar.b(tresult);
        return kVar.a();
    }

    public static <TResult> j<TResult>.a b() {
        j jVar = new j();
        jVar.getClass();
        return new a();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <TContinuationResult, TResult> void c(final k<TContinuationResult> kVar, final h<TResult, TContinuationResult> hVar, final j<TResult> jVar, Executor executor, final e eVar) {
        try {
            executor.execute(new Runnable() { // from class: bolts.j.4
                /* JADX WARN: Multi-variable type inference failed */
                @Override // java.lang.Runnable
                public void run() {
                    if (eVar != null && eVar.a()) {
                        kVar.c();
                        return;
                    }
                    try {
                        kVar.b(hVar.then(jVar));
                    } catch (CancellationException unused) {
                        kVar.c();
                    } catch (Exception e) {
                        kVar.b(e);
                    }
                }
            });
        } catch (Exception e) {
            kVar.b(new ExecutorException(e));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <TContinuationResult, TResult> void d(final k<TContinuationResult> kVar, final h<TResult, j<TContinuationResult>> hVar, final j<TResult> jVar, Executor executor, final e eVar) {
        try {
            executor.execute(new Runnable() { // from class: bolts.j.5
                @Override // java.lang.Runnable
                public void run() {
                    if (eVar != null && eVar.a()) {
                        kVar.c();
                        return;
                    }
                    try {
                        j jVar2 = (j) hVar.then(jVar);
                        if (jVar2 == null) {
                            kVar.b((Object) null);
                        } else {
                            jVar2.a((h) new h<TContinuationResult, Void>() { // from class: bolts.j.5.1
                                @Override // bolts.h
                                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                                public Void then(j<TContinuationResult> jVar3) {
                                    if (eVar != null && eVar.a()) {
                                        kVar.c();
                                        return null;
                                    }
                                    if (jVar3.d()) {
                                        kVar.c();
                                        return null;
                                    }
                                    if (jVar3.e()) {
                                        kVar.b(jVar3.g());
                                        return null;
                                    }
                                    kVar.b(jVar3.f());
                                    return null;
                                }
                            });
                        }
                    } catch (CancellationException unused) {
                        kVar.c();
                    } catch (Exception e) {
                        kVar.b(e);
                    }
                }
            });
        } catch (Exception e) {
            kVar.b(new ExecutorException(e));
        }
    }

    public static <TResult> j<TResult> h() {
        return (j<TResult>) p;
    }

    private void j() {
        synchronized (this.e) {
            Iterator<h<TResult, Void>> it2 = this.l.iterator();
            while (it2.hasNext()) {
                try {
                    it2.next().then(this);
                } catch (RuntimeException e) {
                    throw e;
                } catch (Exception e2) {
                    throw new RuntimeException(e2);
                }
            }
            this.l = null;
        }
    }

    public <TContinuationResult> j<TContinuationResult> a(h<TResult, TContinuationResult> hVar) {
        return a(hVar, c, null);
    }

    public <TContinuationResult> j<TContinuationResult> a(h<TResult, j<TContinuationResult>> hVar, Executor executor) {
        return b(hVar, executor, null);
    }

    public <TContinuationResult> j<TContinuationResult> a(final h<TResult, TContinuationResult> hVar, final Executor executor, final e eVar) {
        boolean zC;
        final k kVar = new k();
        synchronized (this.e) {
            zC = c();
            if (!zC) {
                this.l.add(new h<TResult, Void>() { // from class: bolts.j.1
                    @Override // bolts.h
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public Void then(j<TResult> jVar) {
                        j.c(kVar, hVar, jVar, executor, eVar);
                        return null;
                    }
                });
            }
        }
        if (zC) {
            c(kVar, hVar, this, executor, eVar);
        }
        return kVar.a();
    }

    public <TContinuationResult> j<TContinuationResult> b(h<TResult, TContinuationResult> hVar) {
        return c(hVar, c, null);
    }

    public <TContinuationResult> j<TContinuationResult> b(final h<TResult, j<TContinuationResult>> hVar, final Executor executor, final e eVar) {
        boolean zC;
        final k kVar = new k();
        synchronized (this.e) {
            zC = c();
            if (!zC) {
                this.l.add(new h<TResult, Void>() { // from class: bolts.j.2
                    @Override // bolts.h
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public Void then(j<TResult> jVar) {
                        j.d(kVar, hVar, jVar, executor, eVar);
                        return null;
                    }
                });
            }
        }
        if (zC) {
            d(kVar, hVar, this, executor, eVar);
        }
        return kVar.a();
    }

    boolean b(Exception exc) {
        synchronized (this.e) {
            if (this.f) {
                return false;
            }
            this.f = true;
            this.i = exc;
            this.j = false;
            this.e.notifyAll();
            j();
            if (!this.j && a() != null) {
                this.k = new l(this);
            }
            return true;
        }
    }

    boolean b(TResult tresult) {
        synchronized (this.e) {
            if (this.f) {
                return false;
            }
            this.f = true;
            this.h = tresult;
            this.e.notifyAll();
            j();
            return true;
        }
    }

    public <TContinuationResult> j<TContinuationResult> c(final h<TResult, TContinuationResult> hVar, Executor executor, final e eVar) {
        return a(new h<TResult, j<TContinuationResult>>() { // from class: bolts.j.3
            @Override // bolts.h
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public j<TContinuationResult> then(j<TResult> jVar) {
                return (eVar == null || !eVar.a()) ? jVar.e() ? j.a(jVar.g()) : jVar.d() ? j.h() : jVar.a((h) hVar) : j.h();
            }
        }, executor);
    }

    public boolean c() {
        boolean z;
        synchronized (this.e) {
            z = this.f;
        }
        return z;
    }

    public boolean d() {
        boolean z;
        synchronized (this.e) {
            z = this.g;
        }
        return z;
    }

    public boolean e() {
        boolean z;
        synchronized (this.e) {
            z = g() != null;
        }
        return z;
    }

    public TResult f() {
        TResult tresult;
        synchronized (this.e) {
            tresult = this.h;
        }
        return tresult;
    }

    public Exception g() {
        Exception exc;
        synchronized (this.e) {
            if (this.i != null) {
                this.j = true;
                if (this.k != null) {
                    this.k.a();
                    this.k = null;
                }
            }
            exc = this.i;
        }
        return exc;
    }

    boolean i() {
        synchronized (this.e) {
            if (this.f) {
                return false;
            }
            this.f = true;
            this.g = true;
            this.e.notifyAll();
            j();
            return true;
        }
    }
}
