package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.Calendar;

/* JADX INFO: loaded from: classes.dex */
public class l extends j<chat.ola.vn.message.f> {
    protected LayoutInflater a;
    protected View.OnClickListener b;

    public class a {
        protected OlaCachedImageView a;
        protected TextView b;
        protected TextView c;
        protected TextView d;
        protected View e;
        private chat.ola.vn.message.f g;
        private View h;

        protected a(View view) {
            try {
                this.a = (OlaCachedImageView) view.findViewById(R.id.profileImageView);
                this.b = (TextView) view.findViewById(R.id.contactIdTextView);
                this.c = (TextView) view.findViewById(R.id.ageTextView);
                this.d = (TextView) view.findViewById(R.id.happyBirthdayMessageEditText);
                this.e = view.findViewById(R.id.birthdayContactViewLayout);
                this.h = view.findViewById(R.id.kissImageView);
            } catch (Throwable unused) {
            }
        }

        protected void a(chat.ola.vn.message.f fVar) {
            try {
                this.g = fVar;
                if (this.g == null) {
                    this.a.setImageResource(R.drawable.ic_contact_photo);
                    return;
                }
                if (l.this.b != null) {
                    this.e.setTag(this.g);
                    this.e.setOnClickListener(l.this.b);
                    this.h.setTag(this.g);
                    this.h.setOnClickListener(l.this.b);
                    this.d.setTag(this.g);
                    this.d.setOnClickListener(l.this.b);
                }
                if (this.a != null) {
                    chat.ola.vn.c.t.a().a(this.g.j(), false, this.a);
                }
                this.d.setText(OlaApplication.a(R.string.message_write_me_message_to) + " " + this.g.j());
                this.b.setText(this.g.L());
                if (0 != this.g.f()) {
                    this.c.setVisibility(0);
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(this.g.f());
                    int i = calendar.get(1);
                    calendar.setTimeInMillis(System.currentTimeMillis());
                    int i2 = calendar.get(1) - i;
                    if (i2 > 0 && i2 < 100) {
                        this.c.setText(i2 + " years old");
                        return;
                    }
                } else {
                    this.c.setText("");
                }
                this.c.setVisibility(8);
            } catch (Throwable unused) {
            }
        }
    }

    public l(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        View viewInflate;
        a aVar;
        try {
            chat.ola.vn.message.f item = getItem(i);
            if (view == null) {
                viewInflate = this.a.inflate(R.layout.birthday_cheer_contact_item_layout, (ViewGroup) null);
                try {
                    aVar = new a(viewInflate);
                    viewInflate.setTag(aVar);
                } catch (Throwable th) {
                    th = th;
                    th.printStackTrace();
                    return viewInflate;
                }
            } else {
                try {
                    viewInflate = view;
                    aVar = (a) view.getTag();
                } catch (Throwable th2) {
                    a aVar2 = new a(view);
                    view.setTag(aVar2);
                    th2.printStackTrace();
                    viewInflate = view;
                    aVar = aVar2;
                }
            }
            aVar.a(item);
            return viewInflate;
        } catch (Throwable th3) {
            th = th3;
            viewInflate = view;
            th.printStackTrace();
            return viewInflate;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.message.f getItem(int i) {
        try {
            return chat.ola.vn.h.t.a(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return chat.ola.vn.h.t.d();
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
