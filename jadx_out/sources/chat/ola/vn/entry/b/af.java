package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class af extends f {
    private ImageView t;
    private TextView u;
    private TextView v;
    private TextView w;
    private TextView x;

    public af(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (ImageView) view.findViewById(R.id.vipIconImageView);
        this.u = (TextView) view.findViewById(R.id.vipTitleTextView);
        this.v = (TextView) view.findViewById(R.id.vipDurationTextView);
        this.w = (TextView) view.findViewById(R.id.kenAmountTextView);
        this.x = (TextView) view.findViewById(R.id.statusTextView);
        try {
            this.i.setVisibility(8);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        TextView textView;
        String str;
        try {
            super.a(dVar, dVar2, dVar3);
            chat.ola.vn.message.s sVar = (chat.ola.vn.message.s) dVar;
            if (sVar.a() != null) {
                this.t.setImageBitmap(chat.ola.vn.j.a().a(sVar.a().b()));
                this.u.setText(sVar.a().d());
            }
            if (sVar.D() > 1) {
                textView = this.v;
                str = chat.ola.vn.util.m.a(sVar.D()) + " " + OlaApplication.a(R.string.string_days).toLowerCase(Locale.US);
            } else {
                textView = this.v;
                str = chat.ola.vn.util.m.a(sVar.D()) + " " + OlaApplication.a(R.string.string_day).toLowerCase(Locale.US);
            }
            textView.setText(str);
            this.w.setText(chat.ola.vn.util.m.a(sVar.C()) + " KEN");
            switch (sVar.E()) {
                case 0:
                    this.x.setTextColor(chat.ola.vn.f.k);
                    if (!chat.ola.vn.util.m.a(sVar.F())) {
                        this.x.setText(OlaApplication.a(R.string.message_fail) + ": " + sVar.F());
                    } else {
                        this.x.setText(R.string.message_fail);
                    }
                    break;
                case 1:
                    this.x.setTextColor(chat.ola.vn.f.C);
                    this.x.setText(R.string.message_watting_answer);
                    break;
                case 2:
                    this.x.setTextColor(chat.ola.vn.f.D);
                    this.x.setText(R.string.string_denied);
                    break;
                case 3:
                    this.x.setTextColor(chat.ola.vn.f.L);
                    this.x.setText(R.string.string_transaction_finished);
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
