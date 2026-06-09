package chat.ola.vn.g;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class l extends h {
    public TextView e;
    protected CharSequence f;

    public l(CharSequence charSequence, View view) {
        super(view);
        this.f = charSequence;
        this.e = (TextView) view.findViewById(R.id.labelTextView);
    }

    public void a(CharSequence charSequence) {
        this.f = charSequence;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // chat.ola.vn.g.h
    public void b(int i) {
        TextView textView;
        CharSequence charSequence;
        if (chat.ola.vn.util.m.b(this.f)) {
            textView = this.e;
            charSequence = "";
        } else {
            textView = this.e;
            charSequence = this.f;
        }
        textView.setText(charSequence);
    }
}
