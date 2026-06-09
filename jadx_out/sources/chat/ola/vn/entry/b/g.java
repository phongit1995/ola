package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class g extends b {
    private TextView f;

    public g(View view) {
        super(view);
        this.f = (TextView) view.findViewById(R.id.messageTimeText);
    }

    @Override // chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        this.f.setText(com.mg.ola.common.d.i.b(dVar.m(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a()));
    }
}
