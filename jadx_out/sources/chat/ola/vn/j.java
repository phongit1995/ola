package chat.ola.vn;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import chat.ola.vn.entity.ah;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class j {
    private static j b;
    private chat.ola.vn.h.c[] a = new chat.ola.vn.h.c[255];
    private Bitmap c;

    private j() {
        b();
    }

    public static j a() {
        if (b == null) {
            b = new j();
        }
        return b;
    }

    private void b() {
        try {
            a(chat.ola.vn.h.b.d());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public Bitmap a(int i) {
        chat.ola.vn.h.c cVar;
        if (this.a != null && (cVar = this.a[i]) != null) {
            return cVar.a();
        }
        if (this.c == null) {
            this.c = BitmapFactory.decodeResource(OlaApplication.a().getResources(), R.drawable.smiles_online);
        }
        return this.c;
    }

    public void a(List<ah> list) {
        try {
            int size = list.size();
            for (int i = 0; i < size; i++) {
                ah ahVar = list.get(i);
                Bitmap bitmapDecodeByteArray = BitmapFactory.decodeByteArray(ahVar.c(), 0, ahVar.c().length);
                if (bitmapDecodeByteArray != null) {
                    ahVar.a((byte[]) null);
                    chat.ola.vn.h.c cVarA = chat.ola.vn.h.c.a(ahVar);
                    cVarA.a(bitmapDecodeByteArray);
                    this.a[cVarA.b()] = cVarA;
                }
            }
            chat.ola.vn.h.c cVar = new chat.ola.vn.h.c(0);
            cVar.a(true);
            cVar.a("Online");
            if (this.c == null) {
                this.c = BitmapFactory.decodeResource(OlaApplication.a().getResources(), R.drawable.smiles_online);
            }
            cVar.a(this.c);
            this.a[0] = cVar;
        } catch (Throwable unused) {
        }
    }

    public ah b(int i) {
        try {
            chat.ola.vn.h.c cVar = this.a[i];
            return cVar == null ? this.a[0] : cVar;
        } catch (Throwable unused) {
            return null;
        }
    }
}
