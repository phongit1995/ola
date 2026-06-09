package chat.ola.vn.view;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.MotionEvent;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class CropImageView extends c {
    public ArrayList<HighlightView> a;
    HighlightView b;
    float c;
    float d;
    int e;
    public boolean f;
    private Runnable r;

    public CropImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = new ArrayList<>();
        this.b = null;
        a();
    }

    private void a(MotionEvent motionEvent) {
        int i = 0;
        for (int i2 = 0; i2 < this.a.size(); i2++) {
            HighlightView highlightView = this.a.get(i2);
            highlightView.a(false);
            highlightView.c();
        }
        while (true) {
            if (i >= this.a.size()) {
                break;
            }
            HighlightView highlightView2 = this.a.get(i);
            if (highlightView2.a(motionEvent.getX(), motionEvent.getY()) == 1) {
                i++;
            } else if (!highlightView2.a()) {
                highlightView2.a(true);
                highlightView2.c();
            }
        }
        invalidate();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(HighlightView highlightView) {
        Rect rect = highlightView.d;
        int iMax = Math.max(0, getLeft() - rect.left);
        int iMin = Math.min(0, getRight() - rect.right);
        int iMax2 = Math.max(0, getTop() - rect.top);
        int iMin2 = Math.min(0, getBottom() - rect.bottom);
        if (iMax == 0) {
            iMax = iMin;
        }
        if (iMax2 != 0) {
            iMin2 = iMax2;
        }
        if (iMax == 0 && iMin2 == 0) {
            return;
        }
        b(iMax, iMin2);
    }

    private void c(final HighlightView highlightView) {
        Rect rect = highlightView.d;
        float fMax = Math.max(1.0f, Math.min((getWidth() / rect.width()) * 0.6f, (getHeight() / rect.height()) * 0.6f) * getScale());
        if (Math.abs(fMax - getScale()) / fMax > 0.1d) {
            float[] fArr = {highlightView.e.centerX(), highlightView.e.centerY()};
            getImageMatrix().mapPoints(fArr);
            a(fMax, fArr[0], fArr[1], 300.0f, new Runnable() { // from class: chat.ola.vn.view.CropImageView.2
                @Override // java.lang.Runnable
                public void run() {
                    CropImageView.this.b(highlightView);
                }
            });
        }
    }

    @Override // chat.ola.vn.view.c
    @SuppressLint({"NewApi"})
    protected void a() {
        super.a();
        if (com.mg.ola.common.d.g.c()) {
            post(new Runnable() { // from class: chat.ola.vn.view.CropImageView.1
                @Override // java.lang.Runnable
                public void run() {
                    CropImageView.this.setLayerType(1, null);
                }
            });
        }
    }

    @Override // chat.ola.vn.view.c
    protected void a(float f, float f2) {
        super.a(f, f2);
        for (int i = 0; i < this.a.size(); i++) {
            HighlightView highlightView = this.a.get(i);
            highlightView.f.postTranslate(f, f2);
            highlightView.c();
        }
    }

    @Override // chat.ola.vn.view.c
    protected void a(float f, float f2, float f3) {
        super.a(f, f2, f3);
        for (HighlightView highlightView : this.a) {
            highlightView.f.set(getImageMatrix());
            highlightView.c();
        }
    }

    public void a(HighlightView highlightView) {
        this.a.add(highlightView);
        invalidate();
    }

    @Override // android.widget.ImageView, android.view.View
    @TargetApi(11)
    protected void onDraw(Canvas canvas) {
        try {
            super.onDraw(canvas);
            if (com.mg.ola.common.d.g.c()) {
                if (this.r == null) {
                    this.r = new Runnable() { // from class: chat.ola.vn.view.CropImageView.3
                        @Override // java.lang.Runnable
                        public void run() {
                            CropImageView cropImageView;
                            int i;
                            try {
                                if (CropImageView.this.isHardwareAccelerated()) {
                                    cropImageView = CropImageView.this;
                                    i = 2;
                                } else {
                                    cropImageView = CropImageView.this;
                                    i = 1;
                                }
                                cropImageView.setLayerType(i, null);
                            } catch (Throwable unused) {
                            }
                        }
                    };
                }
                post(this.r);
            }
            for (int i = 0; i < this.a.size(); i++) {
                this.a.get(i).a(canvas);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.c, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        if (this.i.b() != null) {
            for (HighlightView highlightView : this.a) {
                highlightView.f.set(getImageMatrix());
                highlightView.c();
                if (highlightView.b) {
                    c(highlightView);
                }
            }
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:34:0x0093  */
    /* JADX WARN: Removed duplicated region for block: B:48:0x00df  */
    /* JADX WARN: Removed duplicated region for block: B:50:0x00e9 A[FALL_THROUGH] */
    /*  JADX ERROR: UnsupportedOperationException in pass: RegionMakerVisitor
        java.lang.UnsupportedOperationException
        	at java.base/java.util.Collections$UnmodifiableCollection.add(Collections.java:1067)
        	at jadx.core.dex.visitors.regions.maker.SwitchRegionMaker$1.leaveRegion(SwitchRegionMaker.java:390)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverseInternal(DepthRegionTraversal.java:70)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.lambda$traverseInternal$0(DepthRegionTraversal.java:68)
        	at java.base/java.util.ArrayList.forEach(ArrayList.java:1511)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverseInternal(DepthRegionTraversal.java:68)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverse(DepthRegionTraversal.java:23)
        	at jadx.core.dex.visitors.regions.maker.SwitchRegionMaker.insertBreaksForCase(SwitchRegionMaker.java:370)
        	at jadx.core.dex.visitors.regions.maker.SwitchRegionMaker.insertBreaks(SwitchRegionMaker.java:85)
        	at jadx.core.dex.visitors.regions.PostProcessRegions.leaveRegion(PostProcessRegions.java:33)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverseInternal(DepthRegionTraversal.java:70)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.lambda$traverseInternal$0(DepthRegionTraversal.java:68)
        	at java.base/java.util.ArrayList.forEach(ArrayList.java:1511)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverseInternal(DepthRegionTraversal.java:68)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverse(DepthRegionTraversal.java:19)
        	at jadx.core.dex.visitors.regions.PostProcessRegions.process(PostProcessRegions.java:23)
        	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:31)
        */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onTouchEvent(android.view.MotionEvent r7) {
        /*
            Method dump skipped, instruction units count: 256
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.CropImageView.onTouchEvent(android.view.MotionEvent):boolean");
    }
}
