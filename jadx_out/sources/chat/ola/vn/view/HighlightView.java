package chat.ola.vn.view;

import android.annotation.TargetApi;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Region;
import android.graphics.drawable.Drawable;
import android.support.v4.view.ViewCompat;
import android.view.View;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class HighlightView {
    View a;
    boolean b;
    boolean c;
    Rect d;
    RectF e;
    Matrix f;
    private RectF h;
    private float j;
    private Drawable l;
    private Drawable m;
    private Drawable n;
    private ModifyMode g = ModifyMode.None;
    private boolean i = false;
    private boolean k = false;
    private final Paint o = new Paint();
    private final Paint p = new Paint();
    private final Paint q = new Paint();

    enum ModifyMode {
        None,
        Move,
        Grow
    }

    public HighlightView(View view) {
        this.a = view;
    }

    private void b(float f, float f2) {
        Rect rect = new Rect(this.d);
        this.e.offset(f, f2);
        this.e.offset(Math.max(0.0f, this.h.left - this.e.left), Math.max(0.0f, this.h.top - this.e.top));
        this.e.offset(Math.min(0.0f, this.h.right - this.e.right), Math.min(0.0f, this.h.bottom - this.e.bottom));
        this.d = e();
        rect.union(this.d);
        rect.inset(-10, -10);
        this.a.invalidate(rect);
    }

    /* JADX WARN: Removed duplicated region for block: B:42:0x00d6  */
    /* JADX WARN: Removed duplicated region for block: B:44:0x00e1  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void c(float r6, float r7) {
        /*
            Method dump skipped, instruction units count: 261
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.HighlightView.c(float, float):void");
    }

    private void d() {
        Resources resources = this.a.getResources();
        this.l = resources.getDrawable(R.drawable.ic_crop_image_pointer);
        this.m = resources.getDrawable(R.drawable.ic_crop_image_pointer);
        this.n = resources.getDrawable(R.drawable.ic_crop_image_pointer);
    }

    private Rect e() {
        RectF rectF = new RectF(this.e.left, this.e.top, this.e.right, this.e.bottom);
        this.f.mapRect(rectF);
        return new Rect(Math.round(rectF.left), Math.round(rectF.top), Math.round(rectF.right), Math.round(rectF.bottom));
    }

    public int a(float f, float f2) {
        Rect rectE = e();
        int intrinsicWidth = this.l.getIntrinsicWidth() * 2;
        Rect rect = new Rect(rectE.left - intrinsicWidth, rectE.top - intrinsicWidth, rectE.right + intrinsicWidth, rectE.bottom + intrinsicWidth);
        if (this.k) {
            float fCenterX = f - rectE.centerX();
            float fCenterY = f2 - rectE.centerY();
            int iSqrt = (int) Math.sqrt((fCenterX * fCenterX) + (fCenterY * fCenterY));
            int iWidth = this.d.width() / 2;
            return Math.abs(iSqrt - iWidth) <= intrinsicWidth ? Math.abs(fCenterY) > Math.abs(fCenterX) ? fCenterY < 0.0f ? 8 : 16 : fCenterX < 0.0f ? 2 : 4 : iSqrt < iWidth ? 32 : 1;
        }
        boolean z = false;
        boolean z2 = f2 >= ((float) (rectE.centerY() - intrinsicWidth)) && f2 < ((float) (rectE.centerY() + intrinsicWidth));
        if (f >= rectE.centerX() - intrinsicWidth && f < rectE.centerX() + intrinsicWidth) {
            z = true;
        }
        float f3 = intrinsicWidth;
        int i = (Math.abs(((float) rectE.left) - f) >= f3 || !z2) ? 1 : 3;
        if (Math.abs(rectE.right - f) < f3 && z2) {
            i |= 4;
        }
        if (Math.abs(rectE.top - f2) < f3 && z) {
            i |= 8;
        }
        int i2 = (Math.abs(((float) rectE.bottom) - f2) >= f3 || !z) ? i : i | 16;
        if (i2 == 1 && rect.contains((int) f, (int) f2)) {
            return 32;
        }
        return i2;
    }

    void a(int i, float f, float f2) {
        Rect rectE = e();
        if (i == 1) {
            return;
        }
        if (i == 32) {
            b(f * (this.e.width() / rectE.width()), f2 * (this.e.height() / rectE.height()));
            return;
        }
        if ((i & 6) == 0) {
            f = 0.0f;
        }
        if ((i & 24) == 0) {
            f2 = 0.0f;
        }
        c(((i & 2) != 0 ? -1 : 1) * f * (this.e.width() / rectE.width()), ((i & 8) != 0 ? -1 : 1) * f2 * (this.e.height() / rectE.height()));
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @TargetApi(11)
    protected void a(Canvas canvas) {
        Drawable drawable;
        if (this.c) {
            return;
        }
        canvas.save();
        Path path = new Path();
        if (!a()) {
            this.q.setColor(ViewCompat.MEASURED_STATE_MASK);
            canvas.drawRect(this.d, this.q);
            return;
        }
        Rect rect = new Rect();
        this.a.getDrawingRect(rect);
        if (this.k) {
            float fWidth = this.d.width() / 2.0f;
            path.addCircle(this.d.left + fWidth, this.d.top + (this.d.height() / 2.0f), fWidth, Path.Direction.CW);
        } else {
            path.addRect(new RectF(this.d), Path.Direction.CW);
        }
        this.q.setColor(chat.ola.vn.f.H);
        if (!com.mg.ola.common.d.g.c() || !canvas.isHardwareAccelerated()) {
            canvas.clipPath(path, Region.Op.DIFFERENCE);
        }
        canvas.drawRect(rect, a() ? this.o : this.p);
        canvas.restore();
        canvas.drawPath(path, this.q);
        if (this.k) {
            int intrinsicWidth = this.n.getIntrinsicWidth();
            int intrinsicHeight = this.n.getIntrinsicHeight();
            int iRound = (int) Math.round(Math.cos(0.7853981633974483d) * (((double) this.d.width()) / 2.0d));
            int iWidth = ((this.d.left + (this.d.width() / 2)) + iRound) - (intrinsicWidth / 2);
            int iHeight = ((this.d.top + (this.d.height() / 2)) - iRound) - (intrinsicHeight / 2);
            this.n.setBounds(iWidth, iHeight, this.n.getIntrinsicWidth() + iWidth, this.n.getIntrinsicHeight() + iHeight);
            drawable = this.n;
        } else {
            int i = this.d.left + 1;
            int i2 = this.d.right + 1;
            int i3 = this.d.top;
            int i4 = this.d.bottom;
            int intrinsicWidth2 = this.l.getIntrinsicWidth() / 2;
            int intrinsicHeight2 = this.l.getIntrinsicHeight() / 2;
            int intrinsicHeight3 = this.m.getIntrinsicHeight();
            int intrinsicWidth3 = this.m.getIntrinsicWidth() / 2;
            int i5 = this.d.left + ((this.d.right - this.d.left) / 2);
            int i6 = this.d.top + ((this.d.bottom - this.d.top) / 2);
            int i7 = i6 - intrinsicHeight2;
            int i8 = i6 + intrinsicHeight2;
            this.l.setBounds(i - intrinsicWidth2, i7, i + intrinsicWidth2, i8);
            this.l.draw(canvas);
            this.l.setBounds(i2 - intrinsicWidth2, i7, i2 + intrinsicWidth2, i8);
            this.l.draw(canvas);
            int i9 = intrinsicHeight3 / 2;
            int i10 = i3 - i9;
            int i11 = i5 - intrinsicWidth3;
            int i12 = i5 + intrinsicWidth3;
            this.m.setBounds(i11, i10, i12, i10 + intrinsicHeight3);
            this.m.draw(canvas);
            int i13 = i4 - i9;
            this.m.setBounds(i11, i13, i12, intrinsicHeight3 + i13);
            drawable = this.m;
        }
        drawable.draw(canvas);
    }

    public void a(Matrix matrix, Rect rect, RectF rectF, boolean z, boolean z2) {
        if (z) {
            z2 = true;
        }
        this.f = new Matrix(matrix);
        this.e = rectF;
        this.h = new RectF(rect);
        this.i = z2;
        this.k = z;
        this.j = this.e.width() / this.e.height();
        this.d = e();
        this.o.setARGB(0, 50, 50, 50);
        this.p.setARGB(125, 50, 50, 50);
        this.q.setStrokeWidth(3.0f);
        this.q.setStyle(Paint.Style.STROKE);
        this.q.setAntiAlias(true);
        this.g = ModifyMode.None;
        d();
    }

    public void a(ModifyMode modifyMode) {
        if (modifyMode != this.g) {
            this.g = modifyMode;
            this.a.invalidate();
        }
    }

    public void a(boolean z) {
        this.b = z;
    }

    public boolean a() {
        return this.b;
    }

    public Rect b() {
        return new Rect((int) this.e.left, (int) this.e.top, (int) this.e.right, (int) this.e.bottom);
    }

    public void b(boolean z) {
        this.c = z;
    }

    public void c() {
        this.d = e();
    }
}
