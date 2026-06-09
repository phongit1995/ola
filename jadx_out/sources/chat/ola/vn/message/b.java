package chat.ola.vn.message;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class b extends chat.ola.vn.b.j<f> {
    protected LayoutInflater a;
    protected View.OnClickListener b;
    private List<f> c;

    public class a {
        protected OlaCachedImageView a;
        protected TextView b;
        protected Button c;
        protected View d;
        private f f;

        protected a(View view) {
            try {
                this.a = (OlaCachedImageView) view.findViewById(R.id.profileImageView);
                this.b = (TextView) view.findViewById(R.id.contactIdTextView);
                this.c = (Button) view.findViewById(R.id.unblockedButton);
                this.d = view.findViewById(R.id.visitorContactViewLayout);
            } catch (Throwable unused) {
            }
        }

        protected void a() {
            try {
                if (this.f == null) {
                    this.c.setVisibility(8);
                    this.a.setImageResource(R.drawable.ic_contact_photo);
                    return;
                }
                if (b.this.b != null) {
                    this.c.setTag(this.f);
                    this.d.setTag(this.f);
                    this.c.setOnClickListener(b.this.b);
                    this.d.setOnClickListener(b.this.b);
                }
                if (this.a != null) {
                    chat.ola.vn.c.t.a().a(this.f.j(), false, this.a);
                }
                this.b.setText(this.f.L());
            } catch (Throwable unused) {
            }
        }

        public void a(f fVar) {
            this.f = fVar;
        }
    }

    public b(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v3 */
    /* JADX WARN: Type inference failed for: r5v4, types: [chat.ola.vn.message.b$a] */
    /* JADX WARN: Type inference failed for: r5v6 */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v11, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v12 */
    /* JADX WARN: Type inference failed for: r6v2, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v5 */
    /* JADX WARN: Type inference failed for: r6v7 */
    /* JADX WARN: Type inference failed for: r6v8 */
    /* JADX WARN: Type inference failed for: r6v9, types: [android.view.View] */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.blocked_contact_layout, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate.setTag(aVar);
                    view = aVar;
                    Inflate = Inflate;
                } catch (Throwable th) {
                    th = th;
                    th.printStackTrace();
                    return Inflate;
                }
            } else {
                try {
                    Inflate = view;
                    view = (a) view.getTag();
                } catch (Throwable th2) {
                    a aVar2 = new a(view);
                    view.setTag(aVar2);
                    th2.printStackTrace();
                    Inflate = view;
                    view = aVar2;
                }
            }
            view.a(this.c.get(i));
            view.a();
            return Inflate;
        } catch (Throwable th3) {
            th = th3;
            Inflate = view;
            th.printStackTrace();
            return Inflate;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public f getItem(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(List<f> list) {
        try {
            this.c = list;
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return 0;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 1;
    }
}
