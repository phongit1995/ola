package chat.ola.vn.g;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class i extends h {
    private TextView e;

    public i(View view) {
        super(view);
        this.e = null;
        this.e = (TextView) view.findViewById(R.id.chatGroupDescriptionTextView);
    }

    @Override // chat.ola.vn.g.h
    public void b(int i) {
        int iE = chat.ola.vn.h.t.E();
        if (iE > 0) {
            this.e.setText(OlaApplication.a(R.string.string_chat_group_description_count, Integer.valueOf(iE)));
        } else {
            this.e.setText(R.string.string_chat_group_description);
        }
    }
}
