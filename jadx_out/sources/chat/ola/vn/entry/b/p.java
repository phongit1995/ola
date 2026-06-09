package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class p extends l {
    private View a;
    private OlaCachedImageView e;
    private TextView f;
    private TextView g;
    private View h;
    private chat.ola.vn.entry.c i;

    public p(View view) {
        super(view);
        this.a = view.findViewById(R.id.newsYoutubeThumbnailPlayIcon);
        this.e = (OlaCachedImageView) view.findViewById(R.id.imgNewsYoutubeThumbnail);
        this.h = view.findViewById(R.id.newsYoutubeInfo);
        this.f = (TextView) view.findViewById(R.id.newsYoutubeTitle);
        this.g = (TextView) view.findViewById(R.id.newsYoutubeDuration);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void a() {
        TextView textView;
        String strG;
        chat.ola.vn.c.t.a().a(this.i.d().toString(), this.e);
        if (this.i.f() != null) {
            this.h.setVisibility(0);
            this.f.setText(this.i.f());
            textView = this.g;
            strG = this.i.g();
        } else {
            this.h.setVisibility(8);
            this.f.setText("");
            textView = this.g;
            strG = "";
        }
        textView.setText(strG);
    }

    @Override // chat.ola.vn.entry.b.l
    public void a(chat.ola.vn.entry.c cVar, int i) {
        this.i = cVar;
        this.e.setTag(cVar);
        this.h.setTag(cVar);
        this.e.setOnClickListener(this.b);
        this.h.setOnClickListener(this.b);
        a();
    }
}
