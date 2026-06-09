package chat.ola.vn.g;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatGroupListActivity;

/* JADX INFO: loaded from: classes.dex */
public class b extends a {
    public b() {
        this.a = 3;
    }

    @Override // chat.ola.vn.g.a
    public View a(LayoutInflater layoutInflater) {
        return layoutInflater.inflate(R.layout.contact_chatgroup_layout, (ViewGroup) null);
    }

    @Override // chat.ola.vn.g.a
    public h a(View view, h hVar) {
        try {
            hVar.b = this.c;
            hVar.a = this.b;
            return hVar;
        } catch (Throwable unused) {
            i iVar = new i(view);
            iVar.b = this.c;
            iVar.a = this.b;
            return iVar;
        }
    }

    @Override // chat.ola.vn.g.a
    public void b(Context context, View view, int i, long j) {
        OlaChatGroupListActivity.a(context);
    }
}
