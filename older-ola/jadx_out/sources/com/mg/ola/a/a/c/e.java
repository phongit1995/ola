package com.mg.ola.a.a.c;

import android.animation.Animator;
import android.annotation.TargetApi;
import android.view.View;
import android.view.ViewPropertyAnimator;
import com.mg.ola.a.a.b.a;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes2.dex */
@TargetApi(14)
class e extends c {
    private final WeakReference<ViewPropertyAnimator> a;

    e(View view) {
        this.a = new WeakReference<>(view.animate());
    }

    @Override // com.mg.ola.a.a.c.c
    public c a(float f) {
        ViewPropertyAnimator viewPropertyAnimator = this.a.get();
        if (viewPropertyAnimator != null) {
            viewPropertyAnimator.translationX(f);
        }
        return this;
    }

    @Override // com.mg.ola.a.a.c.c
    public c a(long j) {
        ViewPropertyAnimator viewPropertyAnimator = this.a.get();
        if (viewPropertyAnimator != null) {
            viewPropertyAnimator.setDuration(j);
        }
        return this;
    }

    @Override // com.mg.ola.a.a.c.c
    public c a(final a.InterfaceC0079a interfaceC0079a) {
        ViewPropertyAnimator viewPropertyAnimator = this.a.get();
        if (viewPropertyAnimator != null) {
            if (interfaceC0079a == null) {
                viewPropertyAnimator.setListener(null);
                return this;
            }
            viewPropertyAnimator.setListener(new Animator.AnimatorListener() { // from class: com.mg.ola.a.a.c.e.1
                @Override // android.animation.Animator.AnimatorListener
                public void onAnimationCancel(Animator animator) {
                    interfaceC0079a.b(null);
                }

                @Override // android.animation.Animator.AnimatorListener
                public void onAnimationEnd(Animator animator) {
                    interfaceC0079a.a(null);
                }

                @Override // android.animation.Animator.AnimatorListener
                public void onAnimationRepeat(Animator animator) {
                    interfaceC0079a.d(null);
                }

                @Override // android.animation.Animator.AnimatorListener
                public void onAnimationStart(Animator animator) {
                    interfaceC0079a.c(null);
                }
            });
        }
        return this;
    }

    @Override // com.mg.ola.a.a.c.c
    public c b(float f) {
        ViewPropertyAnimator viewPropertyAnimator = this.a.get();
        if (viewPropertyAnimator != null) {
            viewPropertyAnimator.alpha(f);
        }
        return this;
    }
}
