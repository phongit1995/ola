package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import chat.ola.vn.R;
import com.mg.ola.a.a.b.n;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"NewApi"})
public class OlaAttachmentVoiceButton extends FrameLayout {
    a a;
    private int b;
    private int c;
    private int d;
    private Rect e;
    private boolean f;
    private n g;

    interface a {
        void b();

        void c();

        void d();

        void e();

        void n_();
    }

    public OlaAttachmentVoiceButton(Context context) {
        super(context);
        this.e = null;
        this.f = false;
        a();
    }

    public OlaAttachmentVoiceButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.e = null;
        this.f = false;
        a();
    }

    public OlaAttachmentVoiceButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.e = null;
        this.f = false;
        a();
    }

    private void a() {
        try {
            this.b = getResources().getDimensionPixelSize(R.dimen.metric_100dp);
            this.c = getResources().getDimensionPixelSize(R.dimen.metric_80dp);
            this.d = getResources().getDimensionPixelSize(R.dimen.metric_32dp);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void b() {
        final ViewGroup.LayoutParams layoutParams = getLayoutParams();
        final int height = getHeight();
        float f = height;
        float f2 = (this.c - this.d) / f;
        final float f3 = (this.c - (this.d / 2)) / f;
        float scaleX = f / this.b;
        if (com.mg.ola.common.d.g.c()) {
            scaleX = getScaleX();
        }
        if (this.g != null) {
            this.g.c();
        }
        this.g = n.b(scaleX, f2).a(150L);
        this.g.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.view.OlaAttachmentVoiceButton.1
            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            public void a(com.mg.ola.a.a.b.a aVar) {
            }
        });
        this.g.a(new n.b() { // from class: chat.ola.vn.view.OlaAttachmentVoiceButton.2
            @Override // com.mg.ola.a.a.b.n.b
            @SuppressLint({"NewApi"})
            public void a(n nVar) {
                Float fValueOf = (Float) nVar.l();
                if (fValueOf.floatValue() <= f3) {
                    fValueOf = Float.valueOf(f3 + (f3 - fValueOf.floatValue()));
                }
                if (com.mg.ola.common.d.g.c()) {
                    OlaAttachmentVoiceButton.this.setScaleX(fValueOf.floatValue());
                    OlaAttachmentVoiceButton.this.setScaleY(fValueOf.floatValue());
                    return;
                }
                layoutParams.height = (int) (fValueOf.floatValue() * height);
                layoutParams.width = (int) (fValueOf.floatValue() * height);
                OlaAttachmentVoiceButton.this.setLayoutParams(layoutParams);
            }
        });
        this.g.a();
    }

    @SuppressLint({"NewApi"})
    private void c() {
        final ViewGroup.LayoutParams layoutParams = getLayoutParams();
        final int height = getHeight();
        float f = height;
        float f2 = (this.b + this.d) / f;
        final float f3 = (this.b + (this.d / 2)) / f;
        float scaleX = f / this.b;
        if (com.mg.ola.common.d.g.c()) {
            scaleX = getScaleX();
        }
        if (this.g != null) {
            this.g.c();
        }
        this.g = n.b(scaleX, f2).a(150L);
        this.g.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.view.OlaAttachmentVoiceButton.3
            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            @SuppressLint({"NewApi"})
            public void a(com.mg.ola.a.a.b.a aVar) {
                if (com.mg.ola.common.d.g.c()) {
                    OlaAttachmentVoiceButton.this.setScaleX(1.0f);
                    OlaAttachmentVoiceButton.this.setScaleY(1.0f);
                    return;
                }
                layoutParams.height = OlaAttachmentVoiceButton.this.b;
                layoutParams.width = OlaAttachmentVoiceButton.this.b;
                OlaAttachmentVoiceButton.this.setLayoutParams(layoutParams);
            }
        });
        this.g.a(new n.b() { // from class: chat.ola.vn.view.OlaAttachmentVoiceButton.4
            @Override // com.mg.ola.a.a.b.n.b
            @SuppressLint({"NewApi"})
            public void a(n nVar) {
                Float fValueOf = (Float) nVar.l();
                if (fValueOf.floatValue() >= f3) {
                    fValueOf = Float.valueOf(f3 - (fValueOf.floatValue() - f3));
                }
                if (com.mg.ola.common.d.g.c()) {
                    OlaAttachmentVoiceButton.this.setScaleX(fValueOf.floatValue());
                    OlaAttachmentVoiceButton.this.setScaleY(fValueOf.floatValue());
                    return;
                }
                layoutParams.height = (int) (height * fValueOf.floatValue());
                layoutParams.width = (int) (height * fValueOf.floatValue());
                OlaAttachmentVoiceButton.this.setLayoutParams(layoutParams);
            }
        });
        this.g.a();
    }

    private void d() {
        final ViewGroup.LayoutParams layoutParams = getLayoutParams();
        final int height = getHeight();
        float f = height;
        float f2 = (this.b + this.d) / f;
        final float f3 = (this.b + (this.d / 2)) / f;
        float scaleX = f / this.b;
        if (com.mg.ola.common.d.g.c()) {
            scaleX = getScaleX();
        }
        if (this.g != null) {
            this.g.c();
        }
        this.g = n.b(scaleX, f2).a(150L);
        this.g.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.view.OlaAttachmentVoiceButton.5
            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            @SuppressLint({"NewApi"})
            public void a(com.mg.ola.a.a.b.a aVar) {
                if (com.mg.ola.common.d.g.c()) {
                    OlaAttachmentVoiceButton.this.setScaleX(1.0f);
                    OlaAttachmentVoiceButton.this.setScaleY(1.0f);
                    return;
                }
                layoutParams.height = OlaAttachmentVoiceButton.this.b;
                layoutParams.width = OlaAttachmentVoiceButton.this.b;
                OlaAttachmentVoiceButton.this.setLayoutParams(layoutParams);
            }
        });
        this.g.a(new n.b() { // from class: chat.ola.vn.view.OlaAttachmentVoiceButton.6
            @Override // com.mg.ola.a.a.b.n.b
            @SuppressLint({"NewApi"})
            public void a(n nVar) {
                Float fValueOf = (Float) nVar.l();
                if (fValueOf.floatValue() >= f3) {
                    fValueOf = Float.valueOf(f3 - (fValueOf.floatValue() - f3));
                }
                if (com.mg.ola.common.d.g.c()) {
                    OlaAttachmentVoiceButton.this.setScaleX(fValueOf.floatValue());
                    OlaAttachmentVoiceButton.this.setScaleY(fValueOf.floatValue());
                    return;
                }
                layoutParams.height = (int) (height * fValueOf.floatValue());
                layoutParams.width = (int) (height * fValueOf.floatValue());
                OlaAttachmentVoiceButton.this.setLayoutParams(layoutParams);
            }
        });
        this.g.a();
    }

    @Override // android.view.View
    @SuppressLint({"ClickableViewAccessibility"})
    public boolean onTouchEvent(MotionEvent motionEvent) {
        switch (motionEvent.getActionMasked()) {
            case 0:
            case 5:
                try {
                    b();
                    if (this.a != null) {
                        try {
                            this.a.n_();
                            break;
                        } catch (Throwable unused) {
                        }
                    }
                    this.e = new Rect(getLeft(), getTop(), getRight(), getBottom());
                    this.f = true;
                    break;
                } catch (Exception unused2) {
                }
                return true;
            case 1:
            case 3:
            case 6:
                try {
                    if (this.e != null) {
                        if (this.e.contains(Math.round(getLeft() + motionEvent.getX()), Math.round(getTop() + motionEvent.getY()))) {
                            this.f = false;
                            c();
                            this.e = null;
                            if (this.a != null) {
                                this.a.b();
                                return true;
                            }
                        } else {
                            this.f = false;
                            c();
                            this.e = null;
                            if (this.a != null) {
                                this.a.e();
                            }
                        }
                    }
                } catch (Exception unused3) {
                }
                return true;
            case 2:
                try {
                    if (this.e != null) {
                        if (this.e.contains(Math.round(getLeft() + motionEvent.getX()), Math.round(getTop() + motionEvent.getY()))) {
                            if (!this.f) {
                                this.f = true;
                                b();
                                if (this.a != null) {
                                    this.a.c();
                                    return true;
                                }
                            }
                        } else if (this.f) {
                            this.f = false;
                            d();
                            if (this.a != null) {
                                this.a.d();
                            }
                        }
                    }
                } catch (Throwable unused4) {
                }
                return true;
            case 4:
            default:
                return super.onTouchEvent(motionEvent);
        }
    }
}
