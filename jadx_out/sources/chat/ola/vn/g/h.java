package chat.ola.vn.g;

import android.view.View;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public abstract class h {
    protected boolean a = false;
    protected boolean b = false;
    protected View c;
    protected View d;

    public h(View view) {
        try {
            this.d = view.findViewById(R.id.listViewBottomDividerView);
        } catch (Throwable unused) {
        }
    }

    /*  JADX ERROR: JadxRuntimeException in pass: RegionMakerVisitor
        jadx.core.utils.exceptions.JadxRuntimeException: Can't find top splitter block for handler:B:13:0x0014
        	at jadx.core.utils.BlockUtils.getTopSplitterForHandler(BlockUtils.java:1182)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.collectHandlerRegions(ExcHandlersRegionMaker.java:53)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.process(ExcHandlersRegionMaker.java:38)
        	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:27)
        */
    public final void a(int r4) {
        /*
            r3 = this;
            r0 = 0
            r1 = 8
            boolean r2 = r3.b()     // Catch: java.lang.Throwable -> L14
            if (r2 == 0) goto Lf
            android.view.View r2 = r3.c     // Catch: java.lang.Throwable -> L14
            r2.setVisibility(r1)     // Catch: java.lang.Throwable -> L14
            goto L14
        Lf:
            android.view.View r2 = r3.c     // Catch: java.lang.Throwable -> L14
            r2.setVisibility(r0)     // Catch: java.lang.Throwable -> L14
        L14:
            boolean r2 = r3.a()     // Catch: java.lang.Throwable -> L25
            if (r2 == 0) goto L20
            android.view.View r0 = r3.d     // Catch: java.lang.Throwable -> L25
            r0.setVisibility(r1)     // Catch: java.lang.Throwable -> L25
            goto L25
        L20:
            android.view.View r1 = r3.d     // Catch: java.lang.Throwable -> L25
            r1.setVisibility(r0)     // Catch: java.lang.Throwable -> L25
        L25:
            r3.b(r4)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.g.h.a(int):void");
    }

    public void a(boolean z) {
        this.a = z;
    }

    public boolean a() {
        return this.a;
    }

    public void b(int i) {
    }

    public void b(boolean z) {
        this.b = z;
    }

    public boolean b() {
        return this.b;
    }
}
