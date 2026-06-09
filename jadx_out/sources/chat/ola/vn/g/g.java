package chat.ola.vn.g;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaSuggestedFriendListActivity;

/* JADX INFO: loaded from: classes.dex */
public class g extends a {
    public g() {
        this.a = 1;
    }

    @Override // chat.ola.vn.g.a
    public View a(LayoutInflater layoutInflater) {
        return layoutInflater.inflate(R.layout.contact_suggest_friend_layout, (ViewGroup) null);
    }

    @Override // chat.ola.vn.g.a
    public h a(View view, h hVar) {
        try {
            hVar.b = this.c;
            hVar.a = this.b;
            return hVar;
        } catch (Throwable unused) {
            n nVar = new n(view);
            nVar.b = this.c;
            nVar.a = this.b;
            return nVar;
        }
    }

    @Override // chat.ola.vn.g.a
    public void b(Context context, View view, int i, long j) {
        OlaSuggestedFriendListActivity.a(context);
    }
}
