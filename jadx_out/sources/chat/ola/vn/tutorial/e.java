package chat.ola.vn.tutorial;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ac;
import chat.ola.vn.h;
import chat.ola.vn.message.f;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class e extends c implements View.OnClickListener {
    private ListView a = null;
    private ac b = null;

    private void v() {
        try {
            OlaTutorialActivity olaTutorialActivityJ = j();
            if (olaTutorialActivityJ != null) {
                olaTutorialActivityJ.B();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        try {
            if (this.b == null) {
                this.b = new ac(j());
                this.b.a(false);
                this.b.a(this);
                this.a.setAdapter((ListAdapter) this.b);
            }
            this.b.a(h.t.x());
            this.b.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.tutorial.c
    public c c() {
        try {
            return (b) Fragment.instantiate(getActivity(), b.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.tutorial.c
    public String d() {
        try {
            return OlaApplication.a(R.string.string_skip);
        } catch (Throwable unused) {
            return "";
        }
    }

    @Override // chat.ola.vn.tutorial.c
    public void e() {
        v();
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        try {
            return OlaApplication.a(R.string.string_may_be_you_want_to_make_friend);
        } catch (Throwable unused) {
            return "";
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.addFriendButton) {
                return;
            }
            List<f> listX = h.t.x();
            if (listX != null && listX.size() > 0) {
                String[] strArr = new String[listX.size()];
                String[] strArr2 = new String[listX.size()];
                for (int i = 0; i < strArr.length; i++) {
                    f fVar = listX.get(i);
                    strArr[i] = fVar.j();
                    strArr2[i] = fVar.b();
                }
                OlaApplication.b.a(strArr, strArr2);
            }
            v();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.tutorial_suggested_friend_layout, (ViewGroup) null);
        viewInflate.findViewById(R.id.addFriendButton).setOnClickListener(this);
        this.a = (ListView) viewInflate.findViewById(R.id.suggestedFriendListView);
        return viewInflate;
    }
}
