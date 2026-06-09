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
public abstract class aa<T> extends j<T> {
    private LayoutInflater a;
    private List<T> b;

    protected class a {
        ImageView a;
        TextView b;

        public a(View view) {
            this.a = (ImageView) view.findViewById(R.id.imgItemIcon);
            this.b = (TextView) view.findViewById(R.id.txtItemTitle);
            view.setTag(this);
        }
    }

    public aa(Context context, List<T> list) {
        super(context);
        this.a = LayoutInflater.from(context);
        this.b = list;
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
    /* JADX WARN: Type inference failed for: r6v4 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        a aVar;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.iconable_text_list_item, (ViewGroup) null);
                try {
                    aVar = new a(Inflate);
                    Inflate = Inflate;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                aVar = (a) view.getTag();
            }
            aVar.b.setText(a(getItem(i)));
            ImageView imageView = aVar.a;
            view = 8;
            imageView.setVisibility(8);
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    public abstract CharSequence a(T t);

    public void a(List<T> list) {
        this.b = list;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.b.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Adapter
    public T getItem(int i) {
        try {
            return this.b.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }
}
