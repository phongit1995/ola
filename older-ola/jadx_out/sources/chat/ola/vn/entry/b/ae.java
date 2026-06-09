package chat.ola.vn.entry.b;

import android.content.DialogInterface;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class ae extends f implements View.OnClickListener {
    private ImageView t;
    private TextView u;
    private TextView v;
    private TextView w;
    private TextView x;
    private View y;
    private chat.ola.vn.message.q z;

    public ae(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (ImageView) view.findViewById(R.id.vipIconImageView);
        this.u = (TextView) view.findViewById(R.id.vipTitleTextView);
        this.v = (TextView) view.findViewById(R.id.vipDurationTextView);
        this.w = (TextView) view.findViewById(R.id.kenAmountTextView);
        this.x = (TextView) view.findViewById(R.id.statusTextView);
        this.y = view.findViewById(R.id.responsButtonViewLayout);
        view.findViewById(R.id.noButton).setOnClickListener(this);
        view.findViewById(R.id.okButton).setOnClickListener(this);
        try {
            this.i.setVisibility(8);
        } catch (Throwable unused) {
        }
    }

    private void g() {
        TextView textView;
        String str;
        try {
            if (this.z.a() != null) {
                this.t.setImageBitmap(chat.ola.vn.j.a().a(this.z.a().b()));
                this.u.setText(this.z.a().d());
            }
            if (this.z.D() > 1) {
                textView = this.v;
                str = chat.ola.vn.util.m.a(this.z.D()) + " " + OlaApplication.a(R.string.string_days).toLowerCase(Locale.US);
            } else {
                textView = this.v;
                str = chat.ola.vn.util.m.a(this.z.D()) + " " + OlaApplication.a(R.string.string_day).toLowerCase(Locale.US);
            }
            textView.setText(str);
            this.w.setText(chat.ola.vn.util.m.a(this.z.C()) + " KEN");
            if (System.currentTimeMillis() - this.z.m() >= 300000 && this.z.E() == 1) {
                this.y.setVisibility(8);
                this.z.c((byte) 0);
                this.x.setTextColor(chat.ola.vn.f.k);
                this.x.setText(R.string.message_transaction_timeout);
            }
            switch (this.z.E()) {
                case 0:
                    this.y.setVisibility(8);
                    this.x.setTextColor(chat.ola.vn.f.k);
                    if (!chat.ola.vn.util.m.a(this.z.F())) {
                        this.x.setText(OlaApplication.a(R.string.message_fail) + ": " + this.z.F());
                    } else {
                        this.x.setText(R.string.message_fail);
                    }
                    break;
                case 1:
                    this.y.setVisibility(0);
                    this.x.setTextColor(chat.ola.vn.f.y);
                    this.x.setText(R.string.message_watting_answer);
                    break;
                case 2:
                    this.y.setVisibility(8);
                    this.x.setTextColor(chat.ola.vn.f.z);
                    this.x.setText(R.string.string_denied);
                    break;
                case 3:
                    this.y.setVisibility(8);
                    this.x.setTextColor(chat.ola.vn.f.L);
                    this.x.setText(R.string.string_transaction_finished);
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        this.z.c((byte) 3);
        g();
        final String strJ = this.z.j();
        String strG = this.z.G();
        if (chat.ola.vn.util.m.a(strG)) {
            OlaApplication.b.t(strJ);
        } else {
            OlaApplication.b.l(strG, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.entry.b.ae.2
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 75;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    chat.ola.vn.message.q qVar;
                    try {
                        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(strJ, (short) 0);
                        if (fVarD == null || (qVar = (chat.ola.vn.message.q) fVarD.o("received-tradding-vip")) == null) {
                            return;
                        }
                        qVar.a(str);
                        qVar.c((byte) 0);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                }
            }));
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        try {
            super.a(dVar, dVar2, dVar3);
            this.z = (chat.ola.vn.message.q) dVar;
            g();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id != R.id.noButton) {
                if (id != R.id.okButton) {
                    return;
                }
                if (this.z.C() > 0) {
                    chat.ola.vn.i.i.a(chat.ola.vn.c.c(), (String) null, 0, R.string.message_retype_the_price, R.string.message_retype_the_price, R.string.string_cancel, R.string.string_ok, (List<String>) null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.entry.b.ae.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 1) {
                                try {
                                    String strC = ((chat.ola.vn.i.p) dialogInterface).c();
                                    if ((chat.ola.vn.util.m.a(strC) ? 0L : Long.parseLong(strC)) != ae.this.z.C()) {
                                        chat.ola.vn.util.j.d(OlaApplication.a(), R.string.message_please_enter_correct_the_vip_price);
                                    } else {
                                        ae.this.h();
                                    }
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    }).b(8192);
                    return;
                } else {
                    h();
                    return;
                }
            }
            this.z.c((byte) 2);
            g();
            String strJ = this.z.j();
            String strG = this.z.G();
            if (chat.ola.vn.util.m.a(strG)) {
                OlaApplication.b.u(strJ);
            } else {
                OlaApplication.b.k(strG, (short) 0);
            }
        } catch (Throwable unused) {
        }
    }
}
