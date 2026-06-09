package chat.ola.vn.balloon;

import android.R;
import android.content.res.Configuration;
import android.graphics.Rect;
import android.os.Handler;
import android.view.View;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.RelativeLayout;

/* JADX INFO: loaded from: classes.dex */
public class d extends RelativeLayout implements a {
    Handler a;
    public WindowManager.LayoutParams b;
    RelativeLayout.LayoutParams c;
    protected Rect d;
    OlaBalloonService e;
    private int f;
    private int g;
    private View h;
    private ImageView i;

    public d(OlaBalloonService olaBalloonService) {
        super(olaBalloonService);
        try {
            this.e = olaBalloonService;
            try {
                this.f = this.e.e() / 6;
            } catch (Throwable unused) {
                this.f = chat.ola.vn.e.d / 6;
            }
            this.g = getResources().getConfiguration().orientation;
            this.b = new WindowManager.LayoutParams(getBalloonWidth(), getBalloonHeight(), 2003, 40, -3);
            this.b.gravity = 51;
            this.b.width = -1;
            this.b.height = this.f;
            this.b.windowAnimations = R.style.Animation;
            setBackgroundColor(0);
            this.h = new View(olaBalloonService);
            this.h.setBackgroundResource(chat.ola.vn.R.drawable.bg_balloon_teminator);
            addView(this.h, new RelativeLayout.LayoutParams(-1, -1));
            this.i = new ImageView(olaBalloonService);
            this.i.setBackgroundResource(chat.ola.vn.R.drawable.ic_balloon_delete);
            this.c = new RelativeLayout.LayoutParams(-2, -2);
            this.c.addRule(13);
            this.i.setVisibility(4);
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.balloon.a
    public void a() {
        try {
            if (this.e != null) {
                this.e.a(this, this.b);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.balloon.a
    public void b() {
    }

    @Override // chat.ola.vn.balloon.a
    public boolean c() {
        return false;
    }

    @Override // chat.ola.vn.balloon.a
    public boolean d() {
        return false;
    }

    public void e() {
        try {
            if (getVisibility() == 0) {
                return;
            }
            this.g = getResources().getConfiguration().orientation;
            this.b.y = getWindowHeight() - getBalloonHeight();
            a();
            setVisibility(0);
            Animation animationLoadAnimation = AnimationUtils.loadAnimation(getContext(), chat.ola.vn.R.anim.slide_in_from_bottom);
            animationLoadAnimation.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.balloon.d.1
                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationEnd(Animation animation) {
                    try {
                        d.this.i.setVisibility(0);
                        d.this.addView(d.this.i, d.this.c);
                        Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(d.this.getContext(), chat.ola.vn.R.anim.slide_in_from_bottom);
                        animationLoadAnimation2.setDuration(300L);
                        animationLoadAnimation2.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.balloon.d.1.1
                            @Override // android.view.animation.Animation.AnimationListener
                            public void onAnimationEnd(Animation animation2) {
                            }

                            @Override // android.view.animation.Animation.AnimationListener
                            public void onAnimationRepeat(Animation animation2) {
                            }

                            @Override // android.view.animation.Animation.AnimationListener
                            public void onAnimationStart(Animation animation2) {
                            }
                        });
                        d.this.i.startAnimation(animationLoadAnimation2);
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationRepeat(Animation animation) {
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationStart(Animation animation) {
                }
            });
            this.h.startAnimation(animationLoadAnimation);
        } catch (Throwable unused) {
        }
    }

    public void f() {
        try {
            Animation animationLoadAnimation = AnimationUtils.loadAnimation(getContext(), chat.ola.vn.R.anim.slide_out_to_bottom);
            animationLoadAnimation.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.balloon.d.2
                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationEnd(Animation animation) {
                    try {
                        d.this.removeView(d.this.i);
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationRepeat(Animation animation) {
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationStart(Animation animation) {
                }
            });
            this.i.startAnimation(animationLoadAnimation);
            Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(getContext(), chat.ola.vn.R.anim.slide_out_to_bottom);
            animationLoadAnimation2.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.balloon.d.3
                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationEnd(Animation animation) {
                    d.this.setVisibility(8);
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationRepeat(Animation animation) {
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationStart(Animation animation) {
                }
            });
            this.h.startAnimation(animationLoadAnimation2);
        } catch (Throwable unused) {
        }
    }

    public Rect getBalloonBound() {
        try {
            if (this.d == null) {
                this.d = new Rect(this.b.x, this.b.y, this.b.x + getBalloonWidth(), this.b.y + getBalloonHeight());
            } else {
                this.d.set(this.b.x, this.b.y, this.b.x + getBalloonWidth(), this.b.y + getBalloonHeight());
            }
        } catch (Throwable unused) {
            this.d = new Rect(0, 0, 0, 0);
        }
        return this.d;
    }

    @Override // chat.ola.vn.balloon.a
    public Handler getBalloonHandler() {
        if (this.a == null) {
            this.a = getHandler();
        }
        return this.a;
    }

    @Override // chat.ola.vn.balloon.a
    public int getBalloonHeight() {
        return this.f;
    }

    @Override // chat.ola.vn.balloon.a
    public WindowManager.LayoutParams getBalloonLayoutParameter() {
        return this.b;
    }

    @Override // chat.ola.vn.balloon.a
    public int getBalloonWidth() {
        try {
            return this.g == 2 ? this.e.e() + chat.ola.vn.e.e : this.e.d();
        } catch (Throwable unused) {
            return chat.ola.vn.e.c;
        }
    }

    @Override // chat.ola.vn.balloon.a
    public int getCurrentPositionX() {
        try {
            return this.b.x;
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.balloon.a
    public int getCurrentPositionY() {
        try {
            return this.b.y;
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.balloon.a
    public int getWindowHeight() {
        try {
            return this.g == 2 ? this.e.d() - chat.ola.vn.e.e : this.e.e();
        } catch (Throwable unused) {
            return chat.ola.vn.e.d;
        }
    }

    @Override // chat.ola.vn.balloon.a
    public int getWindowWidth() {
        try {
            return this.g == 2 ? this.e.e() + chat.ola.vn.e.e : this.e.d();
        } catch (Throwable unused) {
            return chat.ola.vn.e.c;
        }
    }

    @Override // android.view.View
    protected void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        this.g = getResources().getConfiguration().orientation;
    }
}
