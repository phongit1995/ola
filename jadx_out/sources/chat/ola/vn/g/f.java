package chat.ola.vn.g;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class f extends a {
    public f() {
        this.a = 0;
    }

    @Override // chat.ola.vn.g.a
    public View a(LayoutInflater layoutInflater) {
        return layoutInflater.inflate(R.layout.contact_status_panel_layout, (ViewGroup) null);
    }

    @Override // chat.ola.vn.g.a
    public h a(View view, h hVar) {
        return hVar == null ? new m(view) : hVar;
    }
}
