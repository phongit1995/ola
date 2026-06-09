package chat.ola.vn.entry.b;

import android.content.Context;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;

/* JADX INFO: loaded from: classes.dex */
public class s extends f implements View.OnClickListener {
    private chat.ola.vn.message.c t;
    private chat.ola.vn.i.c u;

    public s(View view, int i) {
        super(view);
        this.u = null;
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        view.findViewById(R.id.noButton).setOnClickListener(this);
        view.findViewById(R.id.okButton).setOnClickListener(this);
        try {
            this.i.setVisibility(8);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        try {
            super.a(dVar, dVar2, dVar3);
            this.t = (chat.ola.vn.message.c) dVar;
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        chat.ola.vn.message.f fVarF;
        chat.ola.vn.message.c cVar;
        try {
            int id = view.getId();
            if (id == R.id.noButton) {
                String strA = this.t.a();
                if (chat.ola.vn.util.m.a(strA)) {
                    return;
                }
                OlaApplication.b.i(strA, (short) 0);
                fVarF = this.t.f();
                cVar = this.t;
            } else {
                if (id != R.id.okButton) {
                    return;
                }
                String strA2 = this.t.a();
                if (chat.ola.vn.util.m.a(strA2)) {
                    return;
                }
                if (this.u == null) {
                    this.u = new chat.ola.vn.i.c(chat.ola.vn.c.c());
                    this.u.a(R.string.message_join_chatgroup);
                }
                this.u.a(30000L, null);
                OlaApplication.b.h(strA2, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.entry.b.s.1
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 20;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        try {
                            s.this.u.a();
                            chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.dialog_title_fail, R.string.message_fail_create_chat_group);
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        try {
                            s.this.u.a();
                            String str = (String) objArr[1];
                            OlaChatViewActivity.a((Context) chat.ola.vn.c.c(), OlaApplication.b, str, (short) 2);
                            OlaApplication.b.y(str, (short) 2);
                        } catch (Throwable unused) {
                        }
                    }
                }));
                fVarF = this.t.f();
                cVar = this.t;
            }
            fVarF.l(cVar.p());
        } catch (Throwable unused) {
        }
    }
}
