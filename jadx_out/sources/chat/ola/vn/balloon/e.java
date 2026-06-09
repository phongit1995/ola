package chat.ola.vn.balloon;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.support.v7.widget.helper.ItemTouchHelper;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBalloonChatViewActivity;
import chat.ola.vn.c.t;
import chat.ola.vn.view.OlaCachedImageView;
import com.mg.ola.common.d.g;

/* JADX INFO: loaded from: classes.dex */
public class e extends b implements c, chat.ola.vn.p.e {
    private static int y;
    private static int z;
    private boolean A;
    public chat.ola.vn.message.f s;
    OlaCachedImageView t;
    public f u;
    private Handler v;
    private Runnable w;
    private TextView x;

    public e(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.A = false;
    }

    public e(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.A = false;
    }

    @TargetApi(11)
    public e(OlaBalloonService olaBalloonService) {
        super(olaBalloonService, 0, 0);
        this.A = false;
        if (y == 0) {
            Bitmap bitmapDecodeResource = BitmapFactory.decodeResource(olaBalloonService.getResources(), R.drawable.bg_border_chat_balloon);
            y = bitmapDecodeResource.getWidth();
            z = bitmapDecodeResource.getHeight();
        }
        this.d = y;
        this.e = z;
        this.b.width = this.d;
        this.b.height = this.e;
        this.t = new OlaCachedImageView(olaBalloonService);
        this.t.setScaleType(ImageView.ScaleType.FIT_CENTER);
        this.t.setBackgroundColor(0);
        if (g.c()) {
            this.t.setAlpha(0.85f);
        }
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(this.d, this.e);
        layoutParams.leftMargin = 0;
        layoutParams.topMargin = 0;
        layoutParams.gravity = 17;
        addView(this.t, layoutParams);
        this.x = new TextView(olaBalloonService);
        this.x.setTextSize(getResources().getDimensionPixelSize(R.dimen.text_size_caption));
        this.x.setTextColor(-1);
        this.x.setVisibility(8);
        this.x.setBackgroundResource(R.drawable.bg_balloon_uread_notify);
        this.x.setGravity(17);
        this.x.setTextAppearance(olaBalloonService, R.style.defaultStyle_contact_text_unread);
        RelativeLayout.LayoutParams layoutParams2 = new RelativeLayout.LayoutParams(-2, -2);
        layoutParams2.addRule(10);
        layoutParams2.addRule(11);
        addView(this.x, layoutParams2);
        setOlaBalloonListener(this);
        setOlaBalloonAnimationListener(this);
    }

    private void f() {
        if (this.v == null) {
            this.v = getHandler();
            if (this.v == null) {
                this.v = new Handler();
            }
        }
        if (this.w == null) {
            this.w = new Runnable() { // from class: chat.ola.vn.balloon.e.1
                @Override // java.lang.Runnable
                public void run() {
                    e.this.g();
                    if (e.this.q != null) {
                        e.this.a = (byte) 1;
                        if (e.this.n < 0 || e.this.o < 0) {
                            return;
                        }
                        e.this.q.a(e.this, e.this.b, e.this.n, e.this.o);
                        e.this.n = -1;
                        e.this.o = -1;
                    }
                }
            };
        }
        if (this.v != null) {
            this.v.removeCallbacks(this.w);
            this.v.postDelayed(this.w, 3000L);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g() {
        try {
            this.v.removeCallbacks(this.w);
        } catch (Throwable unused) {
        }
        try {
            if (this.u != null) {
                this.u.setVisibility(8);
                if (this.q != null) {
                    this.q.a(this.u);
                }
                this.u = null;
            }
        } catch (Throwable unused2) {
        }
    }

    private void h() {
        if (this.s != null) {
            this.q.c(this.s);
            setNotify(0);
        }
    }

    @Override // chat.ola.vn.balloon.c
    public void a(b bVar) {
        try {
            if (this.A) {
                this.A = false;
                h();
                this.q.a((View) this);
            } else if (this.u != null) {
                f();
                this.u.setVisibility(0);
                this.u.a.x = this.b.x + getBalloonWidth();
                this.u.a.y = this.b.y;
                if (this.q != null) {
                    this.q.b(this.u, this.u.a);
                }
            }
        } catch (Throwable unused) {
        }
    }

    public void a(chat.ola.vn.message.d dVar, boolean z2) {
        try {
            if (getVisibility() == 0) {
                if (this.s != null) {
                    setNotify(this.s.z());
                } else {
                    setNotify(0);
                }
            }
            g();
            if (this.u == null) {
                if (!z2) {
                    return;
                } else {
                    this.u = new f(getContext(), this);
                }
            } else if (!z2) {
                return;
            }
            this.u.setMessage(dVar);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.balloon.b, chat.ola.vn.balloon.a
    public void b() {
        if (this.a == 1 && this.u != null && this.u.getVisibility() != 0) {
            this.u.setVisibility(0);
            this.u.a.x = this.b.x + getBalloonWidth();
            this.u.a.y = this.b.y;
            if (this.q != null) {
                this.q.a(this.u, this.u.a);
            }
            f();
        }
        super.b();
    }

    @Override // chat.ola.vn.p.e
    public void b(b bVar) {
        try {
            if (this.s == null || this.a != 0) {
                return;
            }
            this.r = System.currentTimeMillis();
            if (this.q != null) {
                this.A = true;
                this.a = (byte) 1;
                this.n = this.b.x;
                this.o = this.b.y;
                this.q.a(this, this.b, 0, 0, 200L);
                this.s.a(0);
                this.s.A();
                g();
                for (e eVar : this.q.b) {
                    if (!eVar.equals(this)) {
                        this.q.a((View) eVar);
                    }
                }
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.balloon.b
    public boolean e() {
        this.q.a(this);
        if (this.s == null) {
            return true;
        }
        this.s.a(Long.valueOf(System.currentTimeMillis()));
        return true;
    }

    public chat.ola.vn.message.f getContact() {
        return this.s;
    }

    @Override // chat.ola.vn.balloon.a
    public int getCurrentPositionX() {
        return this.b.x;
    }

    @Override // chat.ola.vn.balloon.a
    public int getCurrentPositionY() {
        return this.b.y;
    }

    @Override // chat.ola.vn.balloon.b, android.view.View
    @SuppressLint({"ClickableViewAccessibility"})
    public boolean onTouchEvent(MotionEvent motionEvent) {
        try {
            if (motionEvent.getAction() == 0) {
                g();
            }
        } catch (Throwable unused) {
        }
        return super.onTouchEvent(motionEvent);
    }

    @TargetApi(11)
    public void setContact(chat.ola.vn.message.f fVar) {
        this.s = fVar;
        if (fVar.k() != 2) {
            t.a().a(fVar.j(), this.t, OlaBalloonChatViewActivity.b(getContext()));
            return;
        }
        if (fVar.o() != null) {
            t.a().a(fVar.o(), this.t, OlaBalloonChatViewActivity.a(getContext()), ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
            return;
        }
        this.t.a(OlaBalloonChatViewActivity.a(getContext()), null);
        if (g.c()) {
            this.t.setAlpha(0.85f);
        }
        a();
    }

    public void setNotify(int i) {
        if (i == 0) {
            this.x.setVisibility(8);
            return;
        }
        this.x.setVisibility(0);
        this.x.setText(i + "");
    }

    @Override // android.view.View
    public void setVisibility(int i) {
        super.setVisibility(i);
        if (i == 0) {
            setNotify(this.s != null ? this.s.z() : 0);
        } else if (this.u != null) {
            this.u.setVisibility(8);
            this.u = null;
        }
    }
}
