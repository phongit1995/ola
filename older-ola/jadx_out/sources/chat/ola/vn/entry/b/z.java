package chat.ola.vn.entry.b;

import android.content.Context;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;

/* JADX INFO: loaded from: classes.dex */
public class z extends j {
    private Context i;
    private OlaRatioImageView j;
    private OlaCachedImageView k;
    private TextView l;
    private TextView m;
    private ImageView n;

    /*  JADX ERROR: JadxRuntimeException in pass: RegionMakerVisitor
        jadx.core.utils.exceptions.JadxRuntimeException: Can't find top splitter block for handler:B:23:0x00b0
        	at jadx.core.utils.BlockUtils.getTopSplitterForHandler(BlockUtils.java:1182)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.collectHandlerRegions(ExcHandlersRegionMaker.java:53)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.process(ExcHandlersRegionMaker.java:38)
        	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:27)
        */
    @Override // chat.ola.vn.entry.b.j
    public void a() {
        /*
            Method dump skipped, instruction units count: 226
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entry.b.z.a():void");
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(View view) {
        super.a(view);
        this.i = view.getContext();
        this.j = (OlaRatioImageView) view.findViewById(R.id.imgHistoryStoryCover);
        this.k = (OlaCachedImageView) view.findViewById(R.id.imgHistoryStorySymbol);
        this.l = (TextView) view.findViewById(R.id.txtMeHistoryStoryTitle);
        this.m = (TextView) view.findViewById(R.id.txtMeHistoryStorySubTitle);
        this.n = (ImageView) view.findViewById(R.id.btnMeHistoryStoryClose);
    }

    @Override // chat.ola.vn.entry.b.j
    public Context d() {
        return this.i;
    }
}
