package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class aj {
    public CheckBox a;
    public OlaCachedImageView b;
    public TextView c;
    public TextView d;
    public chat.ola.vn.message.f e;
    public chat.ola.vn.entity.x f;
    public boolean g = true;

    public aj(View view) {
        this.b = (OlaCachedImageView) view.findViewById(R.id.imgItemIcon);
        this.c = (TextView) view.findViewById(R.id.txtItemTitle);
        this.d = (TextView) view.findViewById(R.id.txtItemSubTitle);
        this.a = (CheckBox) view.findViewById(R.id.ckbItemSelect);
    }

    /* JADX WARN: Removed duplicated region for block: B:34:0x00a3 A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:35:0x00a4 A[Catch: Throwable -> 0x004d, TryCatch #0 {Throwable -> 0x004d, blocks: (B:9:0x002b, B:12:0x0030, B:14:0x0038, B:16:0x0047, B:17:0x0049, B:32:0x009f, B:35:0x00a4, B:37:0x00b0, B:39:0x00c6), top: B:42:0x000a }] */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(chat.ola.vn.entity.x r6) {
        /*
            Method dump skipped, instruction units count: 210
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entry.b.aj.a(chat.ola.vn.entity.x):void");
    }

    public void a(chat.ola.vn.message.f fVar) {
        if (fVar == null) {
            return;
        }
        this.e = fVar;
        this.c.setText(this.e.b());
        this.d.setText(this.e.j());
        if (this.e.k() != 2) {
            chat.ola.vn.c.t.a().f(this.e.j(), this.b);
        } else {
            this.b.setImageResource(R.drawable.ic_chatgroup_vip);
            this.d.setText(R.string.string_chat_group);
        }
    }

    public void a(boolean z) {
        this.g = z;
    }
}
