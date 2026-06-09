package chat.ola.vn.tutorial;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.c.t;
import chat.ola.vn.f;
import chat.ola.vn.h;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class d extends c implements View.OnClickListener, OlaCropImageActivity.a {
    private static boolean a = false;
    private OlaCachedImageView b;
    private Button c;
    private Button d;

    private void v() {
        try {
            OlaTutorialActivity olaTutorialActivityJ = j();
            if (olaTutorialActivityJ != null) {
                olaTutorialActivityJ.B();
            }
        } catch (Throwable unused) {
        }
    }

    private void x() {
        try {
            boolean z = chat.ola.vn.r.a.e.e;
            if (z) {
                this.b.a(null, null);
            }
            t.a().a(h.a(), false, this.b, z);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void D() {
        try {
            OlaTutorialActivity.g = (byte) 1;
            this.c.setText(R.string.string_next);
            this.c.setBackgroundResource(R.drawable.btn_green_button_selector);
            this.d.setBackgroundResource(R.drawable.btn_default_button_selector);
            this.c.setTextColor(f.C);
            this.d.setTextColor(f.y);
            chat.ola.vn.r.a.e.e = true;
            x();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void E() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void F() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void G() {
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        x();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void b_() {
    }

    @Override // chat.ola.vn.tutorial.c
    public c c() {
        try {
            return h.t.A() > 0 ? (e) Fragment.instantiate(getActivity(), e.class.getName()) : (b) Fragment.instantiate(getActivity(), b.class.getName());
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
            return OlaApplication.a(R.string.string_tutorial_newbie_setup_avatar_title);
        } catch (Throwable unused) {
            return "";
        }
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void f(String str) {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnGalleryImage || id == R.id.imgOvatarThumbnail) {
                a = true;
                this.c.setVisibility(0);
                OlaCropImageActivity.c(getActivity(), this);
            } else {
                if (id != R.id.skipButton) {
                    return;
                }
                v();
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        Button button;
        int i;
        View viewInflate = layoutInflater.inflate(R.layout.tutorial_setup_ovatar_layout, (ViewGroup) null);
        this.b = (OlaCachedImageView) viewInflate.findViewById(R.id.imgOvatarThumbnail);
        this.b.setOnClickListener(this);
        this.d = (Button) viewInflate.findViewById(R.id.btnGalleryImage);
        this.d.setOnClickListener(this);
        this.c = (Button) viewInflate.findViewById(R.id.skipButton);
        this.c.setOnClickListener(this);
        if (a) {
            button = this.c;
            i = 0;
        } else {
            button = this.c;
            i = 8;
        }
        button.setVisibility(i);
        return viewInflate;
    }
}
