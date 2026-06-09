package chat.ola.vn.g;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import com.facebook.share.model.AppInviteContent;
import com.facebook.share.widget.AppInviteDialog;

/* JADX INFO: loaded from: classes.dex */
public class c extends a {
    public c() {
        this.a = 2;
    }

    @Override // chat.ola.vn.g.a
    public View a(LayoutInflater layoutInflater) {
        return layoutInflater.inflate(R.layout.contact_invite_fb_friend_layout, (ViewGroup) null);
    }

    @Override // chat.ola.vn.g.a
    public h a(View view, h hVar) {
        try {
            hVar.b = this.c;
            hVar.a = this.b;
            return hVar;
        } catch (Throwable unused) {
            j jVar = new j(view);
            jVar.b = this.c;
            jVar.a = this.b;
            return jVar;
        }
    }

    @Override // chat.ola.vn.g.a
    public void b(Context context, View view, int i, long j) {
        try {
            if (AppInviteDialog.canShow()) {
                AppInviteDialog.show(chat.ola.vn.c.c(), new AppInviteContent.Builder().setApplinkUrl("https://fb.me/1199434326766314").setPreviewImageUrl("http://s1.cdn.kaspee.com/ola/preview.jpg").build());
            }
        } catch (Throwable unused) {
        }
    }
}
