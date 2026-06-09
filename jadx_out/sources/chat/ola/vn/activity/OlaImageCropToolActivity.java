package chat.ola.vn.activity;

import android.annotation.TargetApi;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Region;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.view.ViewCompat;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.i.i;
import chat.ola.vn.util.m;
import chat.ola.vn.view.CropImageView;
import chat.ola.vn.view.HighlightView;
import com.mg.ola.common.a.a;
import com.mg.ola.common.d.f;
import com.mg.ola.common.d.g;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class OlaImageCropToolActivity extends c implements View.OnClickListener {
    boolean e;
    private CropImageView h;
    private Bitmap i;
    private HighlightView j;
    private Uri p;
    private Runnable q;
    private ProgressDialog r;
    private String k = null;
    boolean f = false;
    private int l = 0;
    private int m = 0;
    private int n = 1;
    private int o = 1;
    Runnable g = new Runnable() { // from class: chat.ola.vn.activity.OlaImageCropToolActivity.3
        Matrix a;

        /* JADX INFO: Access modifiers changed from: private */
        public void a() {
            int i;
            if (OlaImageCropToolActivity.this.i == null) {
                return;
            }
            HighlightView highlightView = new HighlightView(OlaImageCropToolActivity.this.h);
            int width = OlaImageCropToolActivity.this.i.getWidth();
            int height = OlaImageCropToolActivity.this.i.getHeight();
            Rect rect = new Rect(0, 0, width, height);
            int iMin = (Math.min(width, height) * 4) / 5;
            if (OlaImageCropToolActivity.this.n == 0 || OlaImageCropToolActivity.this.o == 0) {
                i = iMin;
            } else if (OlaImageCropToolActivity.this.n > OlaImageCropToolActivity.this.o) {
                i = (OlaImageCropToolActivity.this.o * iMin) / OlaImageCropToolActivity.this.n;
            } else {
                i = iMin;
                iMin = (OlaImageCropToolActivity.this.n * iMin) / OlaImageCropToolActivity.this.o;
            }
            highlightView.a(this.a, rect, new RectF((width - iMin) / 2, (height - i) / 2, r1 + iMin, r2 + i), OlaImageCropToolActivity.this.f, (OlaImageCropToolActivity.this.n == 0 || OlaImageCropToolActivity.this.o == 0) ? false : true);
            OlaImageCropToolActivity.this.h.a.clear();
            OlaImageCropToolActivity.this.h.a(highlightView);
        }

        @Override // java.lang.Runnable
        public void run() {
            this.a = OlaImageCropToolActivity.this.h.getImageMatrix();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaImageCropToolActivity.3.1
                @Override // java.lang.Runnable
                public void run() {
                    a();
                    OlaImageCropToolActivity.this.h.invalidate();
                    if (OlaImageCropToolActivity.this.h.a.size() == 1) {
                        OlaImageCropToolActivity.this.j = OlaImageCropToolActivity.this.h.a.get(0);
                        OlaImageCropToolActivity.this.j.a(true);
                    }
                }
            });
        }
    };

    private void B() {
        if (this.i == null) {
            return;
        }
        if (this.l != 0 && this.m != 0) {
            HighlightView highlightView = new HighlightView(this.h);
            Rect rect = new Rect(0, 0, this.i.getWidth(), this.i.getHeight());
            RectF rectF = new RectF();
            int iWidth = (rect.width() - this.i.getWidth()) / 2;
            int iHeight = (rect.height() - this.i.getHeight()) / 2;
            rectF.left = iWidth;
            rectF.top = iHeight;
            rectF.right = this.i.getWidth() + iHeight;
            rectF.bottom = iHeight + this.i.getHeight();
            highlightView.a(this.h.getImageMatrix(), rect, rectF, true, true);
            this.h.a.clear();
            this.h.a(highlightView);
            this.h.invalidate();
        }
        this.g.run();
    }

    /* JADX INFO: Access modifiers changed from: private */
    @TargetApi(11)
    public Bitmap C() {
        Bitmap bitmapA;
        if (this.j == null || this.e || this.i == null) {
            return null;
        }
        this.e = true;
        Rect rectB = this.j.b();
        int iWidth = rectB.width();
        int iHeight = rectB.height();
        Bitmap bitmapCreateBitmap = Bitmap.createBitmap(iWidth, iHeight, this.f ? Bitmap.Config.ARGB_8888 : Bitmap.Config.RGB_565);
        new Canvas(bitmapCreateBitmap).drawBitmap(this.i, rectB, new Rect(0, 0, iWidth, iHeight), (Paint) null);
        if (this.f) {
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Path path = new Path();
            float f = iWidth / 2.0f;
            path.addCircle(f, iHeight / 2.0f, f, Path.Direction.CW);
            if (!g.c() || !canvas.isHardwareAccelerated()) {
                canvas.clipPath(path, Region.Op.DIFFERENCE);
            }
            canvas.drawColor(0, PorterDuff.Mode.CLEAR);
        }
        if (iWidth == this.l && iHeight == this.m) {
            bitmapA = bitmapCreateBitmap;
        } else {
            bitmapA = f.a(new Matrix(), bitmapCreateBitmap, this.l, this.m, true);
            if (bitmapCreateBitmap != bitmapA) {
                try {
                    bitmapCreateBitmap.recycle();
                } catch (Throwable unused) {
                }
            }
        }
        this.e = false;
        return bitmapA;
    }

    private void a(Intent intent) {
        try {
            this.p = intent.getData();
            this.l = intent.getIntExtra("outputX", 0);
            this.m = intent.getIntExtra("outputY", 0);
            this.n = intent.getIntExtra("aspectX", 1);
            this.o = intent.getIntExtra("aspectY", 1);
            String path = this.p.getPath();
            if (this.l == 0) {
                this.l = 720;
            }
            if (this.m == 0) {
                this.m = 720;
            }
            this.i = f.a(path, this.l, this.m);
            if (this.l == 0) {
                this.l = this.i.getWidth();
            }
            if (this.m == 0) {
                this.m = this.i.getHeight();
            }
            this.h.a(this.i, true);
            B();
        } catch (Throwable unused) {
            finish();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        try {
            if (this.q == null) {
                this.q = new Runnable() { // from class: chat.ola.vn.activity.OlaImageCropToolActivity.2
                    @Override // java.lang.Runnable
                    public void run() {
                        OlaImageCropToolActivity.this.c(false);
                    }
                };
            }
            OlaApplication.c(this.q);
            if (!z) {
                this.r.dismiss();
                return;
            }
            OlaApplication.a(this.q, 30000L);
            if (this.r == null) {
                this.r = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_cropping_picture));
            }
            this.r.show();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        setResult(0, new Intent());
        finish();
    }

    /* JADX WARN: Type inference failed for: r4v2, types: [chat.ola.vn.activity.OlaImageCropToolActivity$1] */
    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnAccept) {
                c(true);
                new AsyncTask<Void, Void, String>() { // from class: chat.ola.vn.activity.OlaImageCropToolActivity.1
                    /* JADX INFO: Access modifiers changed from: protected */
                    @Override // android.os.AsyncTask
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public String doInBackground(Void... voidArr) {
                        try {
                            Bitmap bitmapC = OlaImageCropToolActivity.this.C();
                            File file = new File(OlaImageCropToolActivity.this.p.getPath());
                            if (file.exists()) {
                                file.delete();
                            }
                            if (m.b(OlaImageCropToolActivity.this.k, Bitmap.CompressFormat.PNG.toString())) {
                                com.mg.ola.common.d.c.b(bitmapC, file);
                            } else {
                                com.mg.ola.common.d.c.a(bitmapC, file);
                            }
                            return file.getAbsolutePath();
                        } catch (Throwable unused) {
                            return null;
                        }
                    }

                    /* JADX INFO: Access modifiers changed from: protected */
                    @Override // android.os.AsyncTask
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public void onPostExecute(String str) {
                        try {
                            OlaImageCropToolActivity.this.c(false);
                            if (m.a(str)) {
                                Intent intent = new Intent();
                                intent.putExtra("outputPath", OlaImageCropToolActivity.this.p.getPath());
                                OlaImageCropToolActivity.this.setResult(-1, intent);
                            } else {
                                Intent intent2 = new Intent();
                                intent2.putExtra("outputPath", str);
                                OlaImageCropToolActivity.this.setResult(-1, intent2);
                            }
                            OlaImageCropToolActivity.this.finish();
                        } catch (Throwable unused) {
                        }
                    }
                }.execute(new Void[0]);
                return;
            }
            if (id == R.id.btnBack) {
                setResult(0, new Intent());
                finish();
            } else if (id == R.id.btnRotate && this.i != null) {
                this.i = f.a(this.i, 90);
                this.h.a(new a(this.i), true);
                this.g.run();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        getWindow().setBackgroundDrawable(new ColorDrawable(ViewCompat.MEASURED_STATE_MASK));
        setContentView(R.layout.edit_crop_image_layout);
        this.h = (CropImageView) findViewById(R.id.editImageCrop);
        findViewById(R.id.btnRotate).setOnClickListener(this);
        findViewById(R.id.btnBack).setOnClickListener(this);
        findViewById(R.id.btnAccept).setOnClickListener(this);
        Intent intent = getIntent();
        if (intent != null) {
            a(intent);
        }
    }
}
