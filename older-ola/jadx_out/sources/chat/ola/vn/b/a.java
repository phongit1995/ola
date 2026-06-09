package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class a extends j<chat.ola.vn.entity.l> {
    protected LayoutInflater a;
    protected List<chat.ola.vn.entity.l> b;

    /* JADX INFO: renamed from: chat.ola.vn.b.a$a, reason: collision with other inner class name */
    private class C0021a {
        protected OlaCachedImageView a;
        protected TextView b;
        protected TextView c;
        protected View d;

        protected C0021a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.albumThumbImageView);
            this.b = (TextView) view.findViewById(R.id.albumNameTextView);
            this.c = (TextView) view.findViewById(R.id.albumCountTextView);
            this.d = view.findViewById(R.id.checkIndicatorImageView);
        }

        protected void a(chat.ola.vn.entity.l lVar) {
            try {
                if (chat.ola.vn.util.m.a(lVar.c)) {
                    if (chat.ola.vn.util.m.a(lVar.d)) {
                        this.a.a(null, null);
                    } else {
                        chat.ola.vn.c.t.a().e(lVar.d, this.a);
                    }
                } else if (lVar.c.toLowerCase(Locale.US).startsWith("http")) {
                    chat.ola.vn.c.t.a().a(lVar.c, this.a, 0, false);
                } else {
                    chat.ola.vn.c.t.a().a(lVar.c, this.a, 0, chat.ola.vn.e.c / 5);
                }
                if (lVar.k) {
                    this.d.setVisibility(0);
                } else {
                    this.d.setVisibility(8);
                }
                this.b.setText(lVar.a);
                this.c.setText(chat.ola.vn.util.m.a(lVar.g));
            } catch (Throwable unused) {
            }
        }
    }

    public a(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0 */
    /* JADX WARN: Type inference failed for: r0v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v8, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v9 */
    /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v2 */
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.a$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.album_detail_layout, (ViewGroup) null);
                try {
                    C0021a c0021a = new C0021a(Inflate);
                    Inflate.setTag(c0021a);
                    Inflate = Inflate;
                    view = c0021a;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                view = (C0021a) view.getTag();
            }
            view.a(getItem(i));
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.l getItem(int i) {
        try {
            return this.b.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public List<chat.ola.vn.entity.l> a() {
        return this.b;
    }

    public void a(List<chat.ola.vn.entity.l> list) {
        try {
            this.b = new ArrayList(list);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.b.size();
        } catch (Throwable unused) {
            return 0;
        }
    }
}
