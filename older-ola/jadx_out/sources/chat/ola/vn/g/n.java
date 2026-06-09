package chat.ola.vn.g;

import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class n extends h {
    private OlaCachedImageView e;
    private OlaCachedImageView f;
    private OlaCachedImageView g;
    private TextView h;
    private Animation i;

    public n(View view) {
        super(view);
        this.e = (OlaCachedImageView) view.findViewById(R.id.profilePicImageView1);
        this.f = (OlaCachedImageView) view.findViewById(R.id.profilePicImageView2);
        this.g = (OlaCachedImageView) view.findViewById(R.id.profilePicImageView3);
        this.h = (TextView) view.findViewById(R.id.numberPhoneFriendTextView);
        try {
            this.i = AnimationUtils.loadAnimation(OlaApplication.a(), R.anim.notify_animation);
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.message.f fVar, OlaCachedImageView olaCachedImageView) {
        if (fVar == null) {
            return;
        }
        t.a().g(fVar.j(), olaCachedImageView);
    }

    private void c() {
        OlaCachedImageView olaCachedImageView;
        this.e.setVisibility(8);
        this.f.setVisibility(8);
        this.g.setVisibility(8);
        for (int i = 0; i < 3; i++) {
            try {
                chat.ola.vn.message.f fVarE = chat.ola.vn.h.t.e(i);
                if (fVarE != null) {
                    switch (i) {
                        case 0:
                            this.e.setVisibility(0);
                            olaCachedImageView = this.e;
                            break;
                        case 1:
                            this.f.setVisibility(0);
                            olaCachedImageView = this.f;
                            break;
                        case 2:
                            this.g.setVisibility(0);
                            olaCachedImageView = this.g;
                            break;
                        default:
                            return;
                    }
                    a(fVarE, olaCachedImageView);
                }
            } catch (Throwable unused) {
                return;
            }
        }
    }

    @Override // chat.ola.vn.g.h
    public void b(int i) {
        TextView textView;
        int i2;
        c();
        int iW = chat.ola.vn.h.t.w();
        if (iW > 0) {
            this.h.setText("" + iW);
            if (this.i != null) {
                this.h.startAnimation(this.i);
            }
            textView = this.h;
            i2 = 0;
        } else {
            textView = this.h;
            i2 = 8;
        }
        textView.setVisibility(i2);
    }
}
