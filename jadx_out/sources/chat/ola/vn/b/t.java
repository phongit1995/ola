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
public class t extends j<chat.ola.vn.h.a> {
    private LayoutInflater a;
    private View.OnClickListener b;
    private List<chat.ola.vn.h.a> c;

    private class a {
        OlaCachedImageView a;
        ImageView b;
        TextView c;
        chat.ola.vn.h.a d;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgIcon);
            this.b = (ImageView) view.findViewById(R.id.imgAccountRemoveAction);
            this.c = (TextView) view.findViewById(R.id.txtAccountName);
        }

        public void a(chat.ola.vn.h.a aVar) {
            this.d = aVar;
            if (this.d == null) {
                return;
            }
            if (t.this.b != null) {
                View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.b.t.a.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(a.this.d);
                        t.this.b.onClick(view);
                    }
                };
                this.a.setOnClickListener(onClickListener);
                this.c.setOnClickListener(onClickListener);
                this.b.setOnClickListener(onClickListener);
            }
            chat.ola.vn.c.t.a().a(this.d.a.name, false, this.a);
            this.c.setText(this.d.a.name);
        }
    }

    public t(Context context) {
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.t$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.user_account_icon, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate.setTag(aVar);
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
    public chat.ola.vn.h.a getItem(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(List<chat.ola.vn.h.a> list) {
        this.c = list;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }
}
