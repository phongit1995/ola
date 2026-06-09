package chat.ola.vn.pickercontacts;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class e {
    protected c a;
    protected View.OnClickListener b;
    protected View.OnLongClickListener c;
    private OlaCachedImageView d;
    private View e;
    private TextView f;
    private TextView g;
    private ImageView h;

    public e(View view) {
        try {
            this.d = (OlaCachedImageView) view.findViewById(R.id.imAvatar);
            this.f = (TextView) view.findViewById(R.id.txtContactName);
            this.g = (TextView) view.findViewById(R.id.txtPhoneNumber);
            this.e = view.findViewById(R.id.relativeContactItem);
            this.h = (ImageView) view.findViewById(R.id.checkBoxItem);
            view.setTag(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public short a() {
        try {
            return this.a.d();
        } catch (Throwable unused) {
            return c.b;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.c = onLongClickListener;
    }

    public void a(c cVar) {
        try {
            this.a = cVar;
            this.f.setText(cVar.a());
            this.g.setText(cVar.f());
            g.a(this.d, cVar.a(), cVar.c());
            this.e.setOnClickListener(this.b);
            this.e.setOnLongClickListener(this.c);
            this.e.setTag(cVar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(boolean z) {
        ImageView imageView;
        int i;
        try {
            if (this.h != null) {
                if (z) {
                    imageView = this.h;
                    i = R.drawable.btn_checkbox_check;
                } else {
                    imageView = this.h;
                    i = R.drawable.btn_checkbox_uncheck;
                }
                imageView.setBackgroundResource(i);
            }
        } catch (Throwable unused) {
        }
    }
}
