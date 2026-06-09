package chat.ola.vn.entry.b;

import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class ag extends f implements View.OnClickListener {
    private OlaCachedImageView t;
    private View u;
    private View v;

    public ag(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (OlaCachedImageView) view.findViewById(R.id.stickerImageView);
        this.u = view.findViewById(R.id.stickerProgressBar);
        this.v = view.findViewById(R.id.addStickerImageView);
        this.v.setOnClickListener(this);
        try {
            this.i.setVisibility(8);
            this.e = 0;
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        try {
            super.a(dVar, dVar2, dVar3);
            a((chat.ola.vn.message.w) dVar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(chat.ola.vn.message.w wVar) {
        OlaCachedImageView olaCachedImageView;
        int i;
        if (wVar == null) {
            return;
        }
        try {
            chat.ola.vn.entity.w wVarA = wVar.a();
            String strA = wVarA.a();
            if (!chat.ola.vn.util.m.a(strA)) {
                if (chat.ola.vn.util.m.b(strA, "(y)")) {
                    this.u.setVisibility(8);
                    this.v.setVisibility(8);
                    olaCachedImageView = this.t;
                    i = R.drawable.sticker_like;
                } else {
                    if (!chat.ola.vn.util.m.b(strA, ":-*") && !chat.ola.vn.util.m.b(strA, ":*") && !chat.ola.vn.util.m.b(strA, "💋")) {
                        this.u.setVisibility(0);
                        chat.ola.vn.c.t.a().a(strA, this.t, ImageView.ScaleType.FIT_CENTER, this.u, 480);
                        this.t.setScaleType(ImageView.ScaleType.FIT_CENTER);
                        if (wVar.d() == 1 && !chat.ola.vn.view.i.b(wVarA)) {
                            this.v.setTag(wVarA);
                            this.v.setVisibility(0);
                            return;
                        }
                    }
                    this.u.setVisibility(8);
                    this.v.setVisibility(8);
                    olaCachedImageView = this.t;
                    i = R.drawable.sticker_kiss;
                }
                olaCachedImageView.setImageResource(i);
                return;
            }
            try {
                this.u.setVisibility(8);
                if (wVarA.c() > 0) {
                    this.t.setVisibility(0);
                    this.t.setImageResource(chat.ola.vn.util.c.a(wVarA.c()));
                } else {
                    this.t.setVisibility(8);
                }
            } catch (Throwable unused) {
            }
            this.v.setVisibility(8);
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.entry.b.f
    protected void e() {
        super.e();
        this.k.setBackgroundResource(0);
        this.k.setPadding(this.e, this.e, this.e, this.e);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.addStickerImageView) {
                return;
            }
            try {
                if (chat.ola.vn.c.x.e()) {
                    chat.ola.vn.util.n.a(chat.ola.vn.c.c(), chat.ola.vn.util.c.a.z);
                }
            } catch (Throwable unused) {
            }
            chat.ola.vn.view.i.a((chat.ola.vn.entity.w) view.getTag());
            try {
                Animation animationLoadAnimation = AnimationUtils.loadAnimation(chat.ola.vn.c.c(), R.anim.fade_out);
                animationLoadAnimation.setDuration(500L);
                this.v.startAnimation(animationLoadAnimation);
            } catch (Throwable unused2) {
            }
            this.v.setVisibility(4);
            chat.ola.vn.util.j.d(chat.ola.vn.c.c(), R.string.message_add_new_sticker_to_recent_list);
        } catch (Throwable unused3) {
        }
    }
}
