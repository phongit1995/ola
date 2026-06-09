package chat.ola.vn.b;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class x extends j<chat.ola.vn.entity.j> {
    private LayoutInflater a;
    private View.OnClickListener b;

    private class a {
        OlaCachedImageView a;
        TextView b;
        TextView c;
        TextView d;
        ImageView e;
        View f;
        Button g;
        Button h;
        chat.ola.vn.entity.j i;

        a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgIcon);
            this.b = (TextView) view.findViewById(R.id.txtTitle);
            this.c = (TextView) view.findViewById(R.id.txtSender);
            this.d = (TextView) view.findViewById(R.id.txtTimeLable);
            this.e = (ImageView) view.findViewById(R.id.iconImageView);
            this.f = view.findViewById(R.id.notificationButtonLayout);
            this.g = (Button) view.findViewById(R.id.notificationButton1);
            this.h = (Button) view.findViewById(R.id.notificationButton2);
            view.setTag(this);
        }

        public void a(chat.ola.vn.entity.j jVar) {
            ImageView imageView;
            int i;
            this.i = jVar;
            if (this.i == null) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (chat.ola.vn.util.m.a(this.i.b)) {
                this.c.setVisibility(8);
            } else {
                this.c.setVisibility(0);
                chat.ola.vn.message.f fVarE = chat.ola.vn.h.t.e(this.i.b, (short) 0);
                if (fVarE != null) {
                    this.c.setText(fVarE.L());
                } else {
                    this.c.setText(this.i.b);
                }
            }
            if (this.i.i != null) {
                Bitmap bitmapDecodeByteArray = BitmapFactory.decodeByteArray(this.i.i, 0, this.i.i.length);
                if (bitmapDecodeByteArray != null) {
                    this.a.a(bitmapDecodeByteArray, null);
                    this.a.setVisibility(0);
                } else {
                    this.a.setVisibility(8);
                }
            } else if (chat.ola.vn.util.m.a(this.i.b)) {
                this.a.setImageResource(R.drawable.ic_contact_photo);
            } else {
                this.a.setVisibility(0);
                chat.ola.vn.c.t.a().g(this.i.b, this.a);
            }
            this.a.setTag(this.i);
            this.b.setTag(this.i);
            this.g.setTag(this.i);
            this.h.setTag(this.i);
            this.a.setOnClickListener(x.this.b);
            this.g.setOnClickListener(x.this.b);
            this.h.setOnClickListener(x.this.b);
            this.b.setText(chat.ola.vn.util.i.a(this.b, chat.ola.vn.q.a.a(), this.i.e));
            this.d.setText(com.mg.ola.common.d.i.a(jCurrentTimeMillis - this.i.h, chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b()));
            this.f.setVisibility(8);
            this.g.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
            this.e.setVisibility(0);
            if (chat.ola.vn.util.m.b(this.i.f, "3")) {
                this.e.setImageResource(R.drawable.ic_notification_add_friend);
                if (chat.ola.vn.h.t.c(this.i.b)) {
                    return;
                }
                this.f.setVisibility(0);
                this.h.setVisibility(8);
                this.g.setText(R.string.string_make_friend);
                this.g.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_action_add_small, 0, 0, 0);
                return;
            }
            if (chat.ola.vn.util.m.b(this.i.f, "1")) {
                imageView = this.e;
                i = R.drawable.ic_notification_mention;
            } else if (chat.ola.vn.util.m.b(this.i.f, "1.4")) {
                imageView = this.e;
                i = R.drawable.ic_notification_like;
            } else {
                if (!chat.ola.vn.util.m.b(this.i.f, "3.1")) {
                    if (chat.ola.vn.util.m.b(this.i.f, "2")) {
                        if (chat.ola.vn.util.m.b(this.i.g, "proposal")) {
                            this.f.setVisibility(0);
                            imageView = this.e;
                            i = R.drawable.ic_notification_heart;
                        } else if (chat.ola.vn.util.m.b(this.i.g, "divorce")) {
                            imageView = this.e;
                            i = R.drawable.ic_notification_broken_heart;
                        }
                    }
                    this.e.setVisibility(8);
                    return;
                }
                imageView = this.e;
                i = R.drawable.ic_notification_photo;
            }
            imageView.setImageResource(i);
        }
    }

    public x(Context context) {
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.x$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.notify_item_layout, (ViewGroup) null);
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
    public chat.ola.vn.entity.j getItem(int i) {
        return chat.ola.vn.m.k.a.get(i);
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        if (chat.ola.vn.m.k.a == null) {
            return 0;
        }
        return chat.ola.vn.m.k.a.size();
    }
}
