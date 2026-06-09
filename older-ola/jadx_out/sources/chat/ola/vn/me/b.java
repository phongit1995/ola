package chat.ola.vn.me;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c.t;
import chat.ola.vn.entry.g;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class b extends j<g> {
    private LayoutInflater a;

    private class a {
        OlaCachedImageView a;
        TextView b;
        String c;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgMenuIcon);
            this.b = (TextView) view.findViewById(R.id.txtMenuTitle);
            view.setTag(this);
        }

        private void a(String str) {
            if (str == null) {
                return;
            }
            this.c = str;
            try {
                if (this.a.a(this.c)) {
                    return;
                }
                this.a.setScaleType(ImageView.ScaleType.CENTER_CROP);
                t.a().f(this.c, this.a);
            } catch (Throwable unused) {
                this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                this.a.setImageResource(R.drawable.ic_contact_photo);
            }
        }

        private void b(String str) {
            try {
                this.c = m.k(str);
                t.a().k(this.c, this.a);
            } catch (Throwable unused) {
            }
        }

        public void a(g gVar) {
            this.c = null;
            try {
                String strA = gVar.a();
                if (strA.startsWith("#")) {
                    this.b.setText(gVar.b());
                    b(strA);
                } else {
                    this.b.setText(gVar.b());
                    a(strA);
                }
            } catch (Throwable unused) {
            }
        }
    }

    public b(Context context) {
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.me.b$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.slider_menu_item, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate = Inflate;
                    view = aVar;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                view = (a) view.getTag();
            }
            view.a(getItem(i));
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public g getItem(int i) {
        try {
            return h.w.a(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return h.w.b();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }
}
