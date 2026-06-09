package chat.ola.vn.m;

import android.os.Bundle;
import android.view.View;
import chat.ola.vn.activity.OlaBottomTabActivity;

/* JADX INFO: loaded from: classes.dex */
public abstract class a extends f implements View.OnClickListener, chat.ola.vn.f.a {
    public OlaBottomTabActivity a() {
        if (getActivity() == null) {
            return null;
        }
        return (OlaBottomTabActivity) getActivity();
    }

    @Override // chat.ola.vn.m.f
    protected void a(Bundle bundle) {
    }
}
