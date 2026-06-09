package chat.ola.vn.entry.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import com.mg.ola.common.widget.OlaTextView;

/* JADX INFO: loaded from: classes.dex */
public abstract class l {
    protected View.OnClickListener b;
    protected View.OnLongClickListener c;
    protected float d;

    public l(View view) {
        view.setTag(this);
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:4:0x0010. Please report as an issue. */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r4v0, types: [android.content.Context] */
    /* JADX WARN: Type inference failed for: r4v1 */
    /* JADX WARN: Type inference failed for: r4v10 */
    /* JADX WARN: Type inference failed for: r4v14 */
    /* JADX WARN: Type inference failed for: r4v19 */
    /* JADX WARN: Type inference failed for: r4v2 */
    /* JADX WARN: Type inference failed for: r4v22 */
    /* JADX WARN: Type inference failed for: r4v23 */
    /* JADX WARN: Type inference failed for: r4v24 */
    /* JADX WARN: Type inference failed for: r4v25 */
    /* JADX WARN: Type inference failed for: r4v26 */
    /* JADX WARN: Type inference failed for: r4v27 */
    /* JADX WARN: Type inference failed for: r4v28 */
    /* JADX WARN: Type inference failed for: r4v29 */
    /* JADX WARN: Type inference failed for: r4v3, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r4v4 */
    public static View a(Context context, LayoutInflater layoutInflater, chat.ola.vn.entry.c cVar, int i) {
        chat.ola.vn.q.a aVarA = null;
        try {
            int dimensionPixelSize = context.getResources().getDimensionPixelSize(R.dimen.metric_8dp);
            try {
                switch (i) {
                    case 0:
                        View viewInflate = layoutInflater.inflate(R.layout.news_thumbnail_layout, (ViewGroup) null);
                        viewInflate.setPadding(dimensionPixelSize, dimensionPixelSize, dimensionPixelSize, 0);
                        new o(viewInflate);
                        context = viewInflate;
                        break;
                    case 1:
                        View viewInflate2 = layoutInflater.inflate(R.layout.news_youtube_content_item, (ViewGroup) null);
                        new q(viewInflate2);
                        context = viewInflate2;
                        break;
                    case 2:
                        View viewInflate3 = layoutInflater.inflate(R.layout.news_youtube_content_item, (ViewGroup) null);
                        viewInflate3.setPadding(dimensionPixelSize, dimensionPixelSize, dimensionPixelSize, 0);
                        new p(viewInflate3);
                        context = viewInflate3;
                        break;
                    case 3:
                        OlaTextView olaTextView = new OlaTextView(context);
                        try {
                            olaTextView.setPadding(dimensionPixelSize, dimensionPixelSize, dimensionPixelSize, 0);
                            aVarA = chat.ola.vn.q.a.a();
                            olaTextView.setOlaSpanClickListener(aVarA);
                            new k(olaTextView);
                            context = olaTextView;
                        } catch (Throwable th) {
                            th = th;
                            context = olaTextView;
                            th.printStackTrace();
                        }
                        break;
                    case 4:
                        View viewInflate4 = layoutInflater.inflate(R.layout.news_content_page_info_layout, (ViewGroup) null);
                        new m(viewInflate4);
                        context = viewInflate4;
                        break;
                    case 5:
                        View viewInflate5 = layoutInflater.inflate(R.layout.news_admob_native_rss_content_item, (ViewGroup) null);
                        chat.ola.vn.util.a.c(viewInflate5, layoutInflater);
                        viewInflate5.setPadding(dimensionPixelSize, dimensionPixelSize, dimensionPixelSize, 0);
                        context = viewInflate5;
                        break;
                    case 6:
                        View viewInflate6 = layoutInflater.inflate(R.layout.news_related_article_item, (ViewGroup) null);
                        viewInflate6.setPadding(dimensionPixelSize, dimensionPixelSize, dimensionPixelSize, 0);
                        new n(viewInflate6);
                        context = viewInflate6;
                        break;
                    default:
                        context = 0;
                        break;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (Throwable th3) {
            th = th3;
            context = aVarA;
        }
        context.setBackgroundColor(chat.ola.vn.f.g);
        return context;
    }

    public void a(float f) {
        this.d = f;
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.c = onLongClickListener;
    }

    public abstract void a(chat.ola.vn.entry.c cVar, int i);
}
