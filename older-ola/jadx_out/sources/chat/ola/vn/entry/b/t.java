package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;

/* JADX INFO: loaded from: classes.dex */
public class t extends f implements View.OnClickListener {
    private TextView t;

    public t(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (TextView) view.findViewById(R.id.kenAmountTextView);
        this.t.setOnClickListener(this);
        try {
            this.i.setVisibility(8);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        TextView textView;
        int i;
        try {
            if (dVar.q() != 3) {
                chat.ola.vn.util.j.c(OlaApplication.a(), OlaApplication.a(R.string.message_balance_current_format, chat.ola.vn.util.o.a(chat.ola.vn.h.o)));
                dVar.a((byte) 3);
            }
        } catch (Throwable unused) {
        }
        try {
            super.a(dVar, dVar2, dVar3);
            chat.ola.vn.message.j jVar = (chat.ola.vn.message.j) dVar;
            if (jVar.d() == 1) {
                textView = this.t;
                i = chat.ola.vn.f.y;
            } else {
                textView = this.t;
                i = chat.ola.vn.f.C;
            }
            textView.setTextColor(i);
            this.t.setText(chat.ola.vn.util.m.a(jVar.a()) + " KEN");
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            OlaBottomTabActivity.a(chat.ola.vn.c.c(), 10);
        } catch (Throwable unused) {
        }
    }
}
