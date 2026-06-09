package bolts;

/* JADX INFO: loaded from: classes.dex */
public class k<TResult> {
    private final j<TResult> a = new j<>();

    public j<TResult> a() {
        return this.a;
    }

    public boolean a(Exception exc) {
        return this.a.b(exc);
    }

    public boolean a(TResult tresult) {
        return this.a.b(tresult);
    }

    public void b(Exception exc) {
        if (!a(exc)) {
            throw new IllegalStateException("Cannot set the error on a completed task.");
        }
    }

    public void b(TResult tresult) {
        if (!a(tresult)) {
            throw new IllegalStateException("Cannot set the result of a completed task.");
        }
    }

    public boolean b() {
        return this.a.i();
    }

    public void c() {
        if (!b()) {
            throw new IllegalStateException("Cannot cancel a completed task.");
        }
    }
}
