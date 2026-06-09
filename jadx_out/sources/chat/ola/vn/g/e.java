package chat.ola.vn.g;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class e extends a {
    private CharSequence d;

    public e(CharSequence charSequence) {
        this.a = 4;
        this.d = charSequence;
    }

    @Override // chat.ola.vn.g.a
    public View a(LayoutInflater layoutInflater) {
        return layoutInflater.inflate(R.layout.list_view_section_item_layout, (ViewGroup) null);
    }

    @Override // chat.ola.vn.g.a
    public h a(View view, h hVar) {
        try {
            ((l) hVar).a(this.d);
            return hVar;
        } catch (Throwable unused) {
            return new l(this.d, view);
        }
    }
}
