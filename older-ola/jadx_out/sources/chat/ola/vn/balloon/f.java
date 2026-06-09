package chat.ola.vn.balloon;

import android.content.Context;
import android.view.View;
import android.view.WindowManager;
import android.widget.RelativeLayout;

/* JADX INFO: loaded from: classes.dex */
public class f extends RelativeLayout {
    public WindowManager.LayoutParams a;
    e b;
    private chat.ola.vn.message.d c;

    public f(Context context, e eVar) {
        super(context);
        this.b = eVar;
        int windowWidth = eVar.getWindowWidth() - eVar.getBalloonWidth();
        this.a = new WindowManager.LayoutParams(-2, -2, 2003, 40, -3);
        this.a.gravity = 51;
        this.a.width = windowWidth;
        this.a.x = eVar.b.x + eVar.getBalloonWidth();
        this.a.y = eVar.b.y;
    }

    private void a() {
        View viewB;
        removeAllViews();
        if (this.c != null) {
            chat.ola.vn.entry.b.b.b bVar = null;
            switch (this.c.e()) {
                case 1:
                    bVar = new chat.ola.vn.entry.b.b.b(getContext());
                    break;
            }
            if (bVar == null || (viewB = bVar.b()) == null) {
                return;
            }
            addView(viewB);
            bVar.a(this.b.s, this.c);
        }
    }

    public void setMessage(chat.ola.vn.message.d dVar) {
        this.c = dVar;
        a();
    }

    @Override // android.view.View
    public void setVisibility(int i) {
        super.setVisibility(i);
        if (i != 0) {
            this.c = null;
        }
    }
}
