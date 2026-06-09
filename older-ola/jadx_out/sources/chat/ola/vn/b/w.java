package chat.ola.vn.b;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class w extends j<chat.ola.vn.message.f> {
    private View.OnClickListener a;
    private View.OnLongClickListener b;
    private List<chat.ola.vn.message.f> c;

    private class a implements View.OnClickListener {
        OlaCachedImageView a;
        TextView b;
        View c;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.profilePictureImageView);
            this.b = (TextView) view.findViewById(R.id.contactIdTextView);
            this.c = view.findViewById(R.id.addContactImageView);
        }

        public void a(final chat.ola.vn.message.f fVar) {
            if (w.this.a != null) {
                View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.b.w.a.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(fVar);
                        w.this.a.onClick(view);
                    }
                };
                this.a.setOnClickListener(onClickListener);
                this.b.setOnClickListener(onClickListener);
                this.a.setTag(fVar);
                this.a.setOnLongClickListener(w.this.b);
                this.b.setTag(fVar);
                this.b.setOnLongClickListener(w.this.b);
                this.c.setTag(fVar);
                this.c.setOnClickListener(this);
            }
            this.b.setText(fVar.L());
            if (fVar.j().startsWith("#")) {
                this.c.setVisibility(8);
                chat.ola.vn.c.t.a().i(chat.ola.vn.util.m.k(fVar.j()), this.a);
                return;
            }
            try {
                if (chat.ola.vn.h.t.e(fVar.j(), (short) 0) == null) {
                    this.c.setVisibility(0);
                } else {
                    this.c.setVisibility(8);
                }
            } catch (Throwable unused) {
                this.c.setVisibility(8);
            }
            chat.ola.vn.c.t.a().a(fVar.j(), false, this.a);
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                if (view.getId() != R.id.addContactImageView) {
                    return;
                }
                chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) view.getTag();
                if (fVar.j().startsWith("#")) {
                    return;
                }
                if (chat.ola.vn.h.t.d(fVar.j()) == null) {
                    OlaApplication.b.a(fVar);
                    chat.ola.vn.h.t.e(fVar);
                    if (chat.ola.vn.util.m.a(fVar.p())) {
                        chat.ola.vn.h.t.a(fVar.j());
                    } else {
                        chat.ola.vn.h.t.a(fVar.j(), fVar.p());
                    }
                }
                view.setVisibility(8);
                w.this.c.remove(fVar);
                w.this.notifyDataSetChanged();
            } catch (Throwable unused) {
            }
        }
    }

    public w(Context context) {
        super(context);
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.w$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.e.inflate(R.layout.suggested_friend_item, (ViewGroup) null);
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
    public chat.ola.vn.message.f getItem(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.a = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.b = onLongClickListener;
    }

    public void a(List<chat.ola.vn.message.f> list) {
        if (list == null) {
            return;
        }
        this.c = list;
        notifyDataSetChanged();
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
