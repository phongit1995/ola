package chat.ola.vn.pickercontacts;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class d extends e {
    private TextView d;

    public d(View view) {
        super(view);
        try {
            this.d = (TextView) view.findViewById(R.id.txtHeader);
            view.setTag(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.pickercontacts.e
    public void a(c cVar) {
        this.a = cVar;
        this.d.setText(cVar.a());
    }
}
