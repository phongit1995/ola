package chat.ola.vn.o;

import android.content.Context;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.k;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class e extends chat.ola.vn.entry.e {
    private k m;
    private String n;

    public e() {
        super(R.string.general_tab_game_store, R.drawable.app_icon_game_store, R.string.general_tab_game_store);
        this.n = "MicroGame Studio";
        this.h = "gamestore.ola.vn";
        this.i = 0;
        this.g = 1;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void a(k kVar) {
        String strA;
        this.m = kVar;
        if (kVar != null) {
            this.f = 0;
            this.b = 0;
            this.d = kVar.a;
            this.e = kVar.f;
            this.c = kVar.j;
            this.g = 2;
            this.j = OlaApplication.a(R.string.string_free);
            strA = OlaApplication.a(R.string.string_free);
        } else {
            this.f = R.string.general_tab_game_store;
            this.b = R.drawable.app_icon_game_store;
            strA = null;
            this.d = null;
            this.e = OlaApplication.a(R.string.message_the_best_game_for_you);
            this.c = null;
            this.g = 1;
            this.j = null;
        }
        this.k = strA;
    }

    @Override // chat.ola.vn.entry.e
    public boolean b(Context context) {
        try {
            if (this.m == null) {
                chat.ola.vn.util.b.l(context, this.n);
                return true;
            }
            if (m.a(this.m.m)) {
                chat.ola.vn.util.b.n(context, this.m.h);
                return true;
            }
            chat.ola.vn.util.b.j(context, this.m.m);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }
}
