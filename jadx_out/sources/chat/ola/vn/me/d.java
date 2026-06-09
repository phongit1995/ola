package chat.ola.vn.me;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c.t;
import chat.ola.vn.message.f;
import chat.ola.vn.view.OlaCachedImageView;
import com.mg.ola.common.d.i;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class d extends j<f> {
    protected LayoutInflater a;
    protected View.OnClickListener b;
    private List<f> c;

    public class a {
        protected OlaCachedImageView a;
        protected TextView b;
        protected TextView c;
        protected Button d;
        protected View e;
        private f g;

        protected a(View view) {
            try {
                this.a = (OlaCachedImageView) view.findViewById(R.id.profileImageView);
                this.b = (TextView) view.findViewById(R.id.contactIdTextView);
                this.c = (TextView) view.findViewById(R.id.visitTimeTextView);
                this.d = (Button) view.findViewById(R.id.addFriendButton);
                this.e = view.findViewById(R.id.visitorContactViewLayout);
            } catch (Throwable unused) {
            }
        }

        private void b() {
            Button button;
            int i;
            try {
                if (this.g.G) {
                    this.d.setBackgroundResource(R.drawable.btn_default_button_selector);
                    this.d.setText(R.string.string_already_friend);
                    this.d.setTextColor(chat.ola.vn.f.z);
                    button = this.d;
                    i = R.drawable.ic_checked;
                } else {
                    this.d.setBackgroundResource(R.drawable.btn_green_button_selector);
                    this.d.setText(R.string.string_make_friend);
                    this.d.setTextColor(chat.ola.vn.f.C);
                    button = this.d;
                    i = R.drawable.ic_action_add_small;
                }
                button.setCompoundDrawablesWithIntrinsicBounds(i, 0, 0, 0);
            } catch (Throwable unused) {
            }
        }

        protected void a() {
            try {
                if (this.g == null) {
                    this.d.setVisibility(8);
                    this.c.setVisibility(8);
                    this.a.setImageResource(R.drawable.ic_contact_photo);
                    return;
                }
                if (d.this.b != null) {
                    this.d.setTag(this.g);
                    this.e.setTag(this.g);
                    this.d.setOnClickListener(d.this.b);
                    this.e.setOnClickListener(d.this.b);
                }
                b();
                if (this.a != null) {
                    t.a().b(this.g.j(), false, this.a);
                }
                this.b.setText(this.g.L());
                if (this.g.q != null) {
                    this.c.setVisibility(0);
                    this.c.setText(i.a(this.g.q.longValue(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b()));
                } else {
                    this.c.setText("");
                    this.c.setVisibility(8);
                }
            } catch (Throwable unused) {
            }
        }

        public void a(f fVar) {
            this.g = fVar;
        }
    }

    public d(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v3 */
    /* JADX WARN: Type inference failed for: r5v4, types: [chat.ola.vn.me.d$a] */
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
                Inflate = this.a.inflate(R.layout.me_visitor_item_layout, (ViewGroup) null);
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
            this.c = new ArrayList(list);
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
