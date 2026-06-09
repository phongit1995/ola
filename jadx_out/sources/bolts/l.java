package bolts;

import bolts.j;

/* JADX INFO: loaded from: classes.dex */
class l {
    private j<?> a;

    public l(j<?> jVar) {
        this.a = jVar;
    }

    public void a() {
        this.a = null;
    }

    protected void finalize() throws Throwable {
        j.b bVarA;
        try {
            j<?> jVar = this.a;
            if (jVar != null && (bVarA = j.a()) != null) {
                bVarA.a(jVar, new UnobservedTaskException(jVar.g()));
            }
        } finally {
            super.finalize();
        }
    }
}
