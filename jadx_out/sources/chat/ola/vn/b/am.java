package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class am extends j<chat.ola.vn.entity.e> {
    private List<chat.ola.vn.entity.e> a;
    private LayoutInflater b;

    private class a {
        OlaCachedImageView a;
        TextView b;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgMenuIcon);
            this.a.setScaleType(ImageView.ScaleType.FIT_CENTER);
            this.b = (TextView) view.findViewById(R.id.txtMenuTitle);
            view.setTag(this);
        }

        private void a(OlaCachedImageView olaCachedImageView, String str) {
            if (chat.ola.vn.util.m.a(str)) {
                this.a.setImageResource(R.drawable.ic_indicate_like);
            } else {
                chat.ola.vn.c.t.a().c(str, olaCachedImageView);
            }
        }

        public void a(chat.ola.vn.entity.e eVar) {
            this.b.setText(eVar.z());
            a(this.a, eVar.e());
        }
    }

    public am(Context context) {
        super(context);
        this.b = LayoutInflater.from(context);
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.am$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.b.inflate(R.layout.slider_menu_item, (ViewGroup) null);
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
            if (view != 0) {
                view.a(getItem(i));
            }
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.e getItem(int i) {
        if (this.a == null) {
            return null;
        }
        return this.a.get(i);
    }

    public void a(List<chat.ola.vn.entity.e> list) {
        this.a = list;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        if (this.a == null) {
            return 0;
        }
        return this.a.size();
    }

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        super.notifyDataSetChanged();
    }
}
