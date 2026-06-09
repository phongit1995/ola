package chat.ola.vn.entry.b.b;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.h;
import chat.ola.vn.message.d;
import chat.ola.vn.message.f;

/* JADX INFO: loaded from: classes.dex */
public class b extends a {
    private TextView c;
    private TextView d;

    public b(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.entry.b.b.a
    protected View a() {
        View viewInflate = this.b.inflate(R.layout.chat_balloon_text_message_item, (ViewGroup) null);
        this.c = (TextView) viewInflate.findViewById(R.id.messageTextContentTextview);
        this.d = (TextView) viewInflate.findViewById(R.id.messageSenderTextview);
        return viewInflate;
    }

    @Override // chat.ola.vn.entry.b.b.a
    public void a(f fVar, d dVar) {
        this.c.setText(dVar.l());
        if (fVar.k() == 2) {
            this.d.setVisibility(0);
            f fVarD = h.t.d(dVar.i(), (short) 0);
            if (fVarD != null) {
                this.d.setText(fVarD.L());
            } else {
                this.d.setText(dVar.i());
            }
            this.d.append(" (" + fVar.b() + ")");
        }
        if (fVar.k() != 0) {
            this.d.setVisibility(8);
            return;
        }
        this.d.setVisibility(0);
        f fVarD2 = h.t.d(fVar.j(), (short) 0);
        if (fVarD2 != null) {
            this.d.setText(fVarD2.L());
        } else {
            this.d.setText(fVar.j());
        }
    }
}
