package chat.ola.vn.h;

import android.graphics.Bitmap;
import chat.ola.vn.entity.ah;

/* JADX INFO: loaded from: classes.dex */
public class c extends ah {
    private Bitmap a;

    public c(int i) {
        super(i);
    }

    public static c a(ah ahVar) {
        c cVar = new c(ahVar.b());
        cVar.a(ahVar.f());
        cVar.b(ahVar.e());
        cVar.a(ahVar.d());
        return cVar;
    }

    public Bitmap a() {
        return this.a;
    }

    public void a(Bitmap bitmap) {
        this.a = bitmap;
    }
}
