package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class an extends j<chat.ola.vn.entity.af> {
    private List<chat.ola.vn.entity.af> a;
    private LayoutInflater b;

    private class a {
        ImageView a;
        TextView b;

        public a(View view) {
            this.a = (ImageView) view.findViewById(R.id.imgMenuIcon);
            this.b = (TextView) view.findViewById(R.id.txtMenuTitle);
            view.setTag(this);
        }

        public void a(chat.ola.vn.entity.af afVar) {
            this.b.setText(afVar.a());
            this.a.setVisibility(0);
            if (afVar.c() == 0) {
                this.a.setImageResource(R.drawable.ic_indicate_like);
            } else {
                this.a.setImageResource(afVar.c());
            }
        }
    }

    public an(Context context) {
        super(context);
        this.b = LayoutInflater.from(context);
        this.a = chat.ola.vn.h.u.b();
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.an$a] */
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
    public chat.ola.vn.entity.af getItem(int i) {
        if (this.a == null) {
            return null;
        }
        return this.a.get(i);
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
        this.a = chat.ola.vn.h.u.b();
        super.notifyDataSetChanged();
    }
}
