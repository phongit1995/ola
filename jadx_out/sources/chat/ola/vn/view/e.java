package chat.ola.vn.view;

import android.animation.Animator;
import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Matrix;
import android.graphics.SurfaceTexture;
import android.hardware.Camera;
import android.os.AsyncTask;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Pair;
import android.view.Display;
import android.view.TextureView;
import android.view.View;
import android.view.ViewStub;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.x;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"NewApi"})
public class e extends d implements Camera.PictureCallback, TextureView.SurfaceTextureListener, View.OnClickListener, View.OnLongClickListener {
    private TextureView a;
    private ViewStub b;
    private Camera c;
    private int d;
    private TextView e;
    private TextView f;
    private View g;
    private ImageButton h;
    private ImageView i;
    private View j;
    private TextView k;
    private int l;
    private int m;
    private int n;
    private int o;
    private a p;
    private boolean q;
    private boolean r;
    private boolean s;
    private Short t;
    private View u;

    public interface a {
        boolean I();

        boolean J();

        boolean K();

        void a_(String str);

        void h(String str, short s);
    }

    private class b extends AsyncTask<byte[], Void, String> {
        private b() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Removed duplicated region for block: B:46:0x00e0  */
        /* JADX WARN: Removed duplicated region for block: B:48:0x00e6 A[Catch: Throwable -> 0x00fd, TryCatch #1 {Throwable -> 0x00fd, blocks: (B:29:0x009b, B:37:0x00c7, B:47:0x00e2, B:49:0x00eb, B:48:0x00e6), top: B:88:0x009b }] */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public java.lang.String doInBackground(byte[]... r19) {
            /*
                Method dump skipped, instruction units count: 431
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.e.b.doInBackground(byte[][]):java.lang.String");
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onPostExecute(String str) {
            try {
                if (m.a(str)) {
                    return;
                }
                if (e.this.t == null) {
                    e.this.p.a_(str);
                } else {
                    e.this.p.h(str, e.this.t.shortValue());
                }
                try {
                    if (x.e()) {
                        n.a(chat.ola.vn.c.c(), chat.ola.vn.util.c.a.x);
                    }
                } catch (Throwable unused) {
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    public e(Context context) {
        super(context);
        this.q = false;
        this.r = true;
        this.s = false;
        this.t = null;
        a(context);
    }

    public e(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.q = false;
        this.r = true;
        this.s = false;
        this.t = null;
        a(context);
    }

    public e(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.q = false;
        this.r = true;
        this.s = false;
        this.t = null;
        a(context);
    }

    private static Pair<Integer, Integer> a(List<Camera.Size> list) {
        int i = 0;
        int i2 = 0;
        for (Camera.Size size : list) {
            if (size.width * size.height > i * i2) {
                i = size.width;
                i2 = size.height;
            }
        }
        return new Pair<>(Integer.valueOf(i), Integer.valueOf(i2));
    }

    private void a(int i, int i2) {
        float f;
        float f2 = i;
        float f3 = i2;
        Display defaultDisplay = chat.ola.vn.c.c().getWindowManager().getDefaultDisplay();
        boolean z = false;
        if (defaultDisplay.getRotation() == 0 || defaultDisplay.getRotation() == 2) {
            z = true;
        } else if (defaultDisplay.getRotation() != 1) {
            defaultDisplay.getRotation();
        }
        float f4 = this.l;
        float f5 = this.m;
        if (z) {
            f4 = this.m;
            f5 = this.l;
        }
        if (f4 >= f2 && f5 >= f3) {
            f = f4 / f2;
            f = f5 / f3;
        } else if (f4 <= f2 && f5 <= f3) {
            f = f3 / f5;
            f = f2 / f4;
        } else if (f2 >= f4) {
            f = (f2 / f4) / (f3 / f5);
        } else {
            f = f3 >= f5 ? (f3 / f5) / (f2 / f4) : 1.0f;
            f = 1.0f;
        }
        Matrix matrix = new Matrix();
        matrix.setScale(f, f, (int) (f2 / 2.0f), (int) (f3 / 2.0f));
        this.a.setTransform(matrix);
    }

    private void a(Context context) {
        TextView textView;
        String str;
        inflate(context, R.layout.ola_attachment_camera_tab_layout, this);
        try {
            this.b = (ViewStub) findViewById(R.id.cameraViewStub);
            this.e = (TextView) findViewById(R.id.errorTextView);
            this.f = (TextView) findViewById(R.id.sendCameraTextView);
            this.h = (ImageButton) findViewById(R.id.expandCameraTextView);
            this.g = findViewById(R.id.phoneCameraHintTextView);
            this.i = (ImageView) findViewById(R.id.switchCameraTextView);
            this.j = findViewById(R.id.shuttleEffectView);
            this.k = (TextView) findViewById(R.id.snapTimerSecondTextView);
            if (this.t == null) {
                textView = this.k;
                str = "∞";
            } else {
                textView = this.k;
                str = "" + this.t;
            }
            textView.setText(str);
            this.h.setOnClickListener(this);
            this.h.setOnLongClickListener(this);
            this.i.setOnClickListener(this);
            this.f.setOnClickListener(this);
            this.u = findViewById(R.id.snapTimerFrameLayout);
            this.u.setOnClickListener(this);
            this.f.setVisibility(8);
            this.h.setVisibility(8);
            this.i.setVisibility(8);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(SurfaceTexture surfaceTexture, int i, int i2) {
        try {
            Camera.Parameters parameters = this.c.getParameters();
            Pair<Integer, Integer> pairA = a(parameters.getSupportedPreviewSizes());
            parameters.setPreviewSize(((Integer) pairA.first).intValue(), ((Integer) pairA.second).intValue());
            this.l = ((Integer) pairA.first).intValue();
            this.m = ((Integer) pairA.second).intValue();
            this.c.setParameters(parameters);
            a(i, i2);
            this.c.setPreviewTexture(surfaceTexture);
            this.c.startPreview();
            this.e.setVisibility(8);
            this.f.setVisibility(0);
            this.h.setVisibility(0);
            if (Camera.getNumberOfCameras() > 1) {
                this.i.setVisibility(0);
            } else {
                this.i.setVisibility(8);
            }
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.e.4
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        e.this.g.startAnimation(AnimationUtils.loadAnimation(e.this.getContext(), R.anim.fade_out));
                    } catch (Throwable unused) {
                    }
                    try {
                        e.this.g.setVisibility(8);
                    } catch (Throwable unused2) {
                    }
                }
            }, 5000L);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f() {
        try {
            if (this.c != null) {
                return;
            }
            int numberOfCameras = Camera.getNumberOfCameras();
            this.d = 1;
            try {
                this.c = Camera.open(this.d);
            } catch (Throwable unused) {
            }
            if (this.c == null) {
                for (int i = 0; i < numberOfCameras; i++) {
                    try {
                        this.c = Camera.open(i);
                        if (this.c != null) {
                            this.d = i;
                            break;
                        }
                        continue;
                    } catch (Throwable unused2) {
                    }
                }
            }
            if (this.c != null) {
                this.c.setDisplayOrientation(chat.ola.vn.util.a.a.a(chat.ola.vn.util.a.a.a(chat.ola.vn.c.c()), this.d));
            } else {
                this.e.setText(R.string.message_camera_capture_error);
            }
        } catch (Throwable th) {
            this.e.setText(R.string.message_camera_capture_error);
            th.printStackTrace();
        }
    }

    private void g() {
        try {
            ArrayList arrayList = new ArrayList();
            arrayList.add("∞");
            arrayList.add("3 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("4 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("5 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("6 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("7 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("8 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("9 " + OlaApplication.a(R.string.string_time_second_plural));
            arrayList.add("10 " + OlaApplication.a(R.string.string_time_second_plural));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(chat.ola.vn.c.c());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.view.e.3
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    e eVar;
                    short s;
                    TextView textView;
                    String str;
                    try {
                        switch (i) {
                            case 0:
                                e.this.t = null;
                                break;
                            case 1:
                                eVar = e.this;
                                s = (short) 3;
                                eVar.t = s;
                                break;
                            case 2:
                                eVar = e.this;
                                s = (short) 4;
                                eVar.t = s;
                                break;
                            case 3:
                                eVar = e.this;
                                s = (short) 5;
                                eVar.t = s;
                                break;
                            case 4:
                                eVar = e.this;
                                s = (short) 6;
                                eVar.t = s;
                                break;
                            case 5:
                                eVar = e.this;
                                s = (short) 7;
                                eVar.t = s;
                                break;
                            case 6:
                                eVar = e.this;
                                s = (short) 8;
                                eVar.t = s;
                                break;
                            case 7:
                                eVar = e.this;
                                s = (short) 9;
                                eVar.t = s;
                                break;
                            default:
                                eVar = e.this;
                                s = (short) 10;
                                eVar.t = s;
                                break;
                        }
                        if (e.this.t == null) {
                            textView = e.this.k;
                            str = "∞";
                        } else {
                            textView = e.this.k;
                            str = "" + e.this.t;
                        }
                        textView.setText(str);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private void h() {
        if (this.s) {
            return;
        }
        try {
            int numberOfCameras = Camera.getNumberOfCameras();
            if (numberOfCameras <= 1) {
                return;
            }
            this.f.setVisibility(8);
            this.h.setVisibility(8);
            this.i.setVisibility(8);
            this.s = true;
            this.c.stopPreview();
            this.c.release();
            this.c = null;
            if (this.d == 1) {
                this.d = 0;
            } else {
                this.d = 1;
            }
            try {
                this.c = Camera.open(this.d);
            } catch (Throwable unused) {
            }
            if (this.c == null) {
                for (int i = 0; i < numberOfCameras; i++) {
                    try {
                        this.c = Camera.open(i);
                        if (this.c != null) {
                            this.d = i;
                            break;
                        }
                        continue;
                    } catch (Throwable unused2) {
                    }
                }
            }
            if (this.c != null) {
                this.c.setDisplayOrientation(chat.ola.vn.util.a.a.a(chat.ola.vn.util.a.a.a(chat.ola.vn.c.c()), this.d));
            } else {
                this.e.setText(R.string.message_camera_capture_error);
            }
            a(this.a.getSurfaceTexture(), this.n, this.o);
            this.s = false;
        } catch (Throwable th) {
            this.e.setText(R.string.message_camera_capture_error);
            th.printStackTrace();
        }
    }

    public void b() {
        this.u.setVisibility(8);
    }

    public boolean c() {
        return this.q;
    }

    public void d() {
        this.h.setSelected(true);
        if (this.p.J()) {
            this.q = true;
        }
    }

    public void e() {
        this.h.setSelected(false);
        if (this.p.K()) {
            this.q = false;
        }
    }

    public a getOlaCameraListener() {
        return this.p;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.expandCameraTextView) {
                if (this.q) {
                    e();
                    return;
                } else {
                    d();
                    return;
                }
            }
            if (id != R.id.sendCameraTextView) {
                if (id == R.id.snapTimerFrameLayout) {
                    g();
                    return;
                } else {
                    if (id != R.id.switchCameraTextView) {
                        return;
                    }
                    h();
                    return;
                }
            }
            if (this.r) {
                try {
                    if (x.e()) {
                        n.a(chat.ola.vn.c.c(), chat.ola.vn.util.c.a.w);
                    }
                } catch (Throwable unused) {
                }
                this.r = false;
                this.j.setAlpha(1.0f);
                this.j.setVisibility(0);
                this.j.animate().alpha(0.0f).setDuration(300L).setListener(new Animator.AnimatorListener() { // from class: chat.ola.vn.view.e.2
                    @Override // android.animation.Animator.AnimatorListener
                    public void onAnimationCancel(Animator animator) {
                    }

                    @Override // android.animation.Animator.AnimatorListener
                    public void onAnimationEnd(Animator animator) {
                        try {
                            e.this.j.setVisibility(8);
                            if (e.this.c()) {
                                e.this.e();
                            }
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // android.animation.Animator.AnimatorListener
                    public void onAnimationRepeat(Animator animator) {
                    }

                    @Override // android.animation.Animator.AnimatorListener
                    public void onAnimationStart(Animator animator) {
                    }
                });
                this.c.takePicture(null, null, this);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            if (view.getId() != R.id.expandCameraTextView) {
                return false;
            }
            return this.p.I();
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.hardware.Camera.PictureCallback
    public void onPictureTaken(byte[] bArr, Camera camera) {
        try {
            new b().execute(bArr);
        } catch (Throwable th) {
            th.printStackTrace();
        }
        try {
            this.c.startPreview();
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.e.1
            @Override // java.lang.Runnable
            public void run() {
                e.this.f();
                if (e.this.a == null) {
                    e.this.b.setLayoutResource(R.layout.ola_attachment_camera_textureview_layout);
                    e.this.b.inflate();
                    e.this.a = (TextureView) e.this.findViewById(R.id.cameraTextureView);
                    e.this.a.setSurfaceTextureListener(e.this);
                }
            }
        }, 800L);
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public void onSurfaceTextureAvailable(SurfaceTexture surfaceTexture, int i, int i2) {
        try {
            this.n = i;
            this.o = i2;
            a(surfaceTexture, this.n, this.o);
        } catch (Throwable th) {
            this.e.setText(R.string.message_camera_capture_error);
            th.printStackTrace();
        }
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public boolean onSurfaceTextureDestroyed(SurfaceTexture surfaceTexture) {
        try {
            try {
                Log.d("OlaChat", "********MAKE SURE RELEASE CAMERA************");
                this.c.stopPreview();
                this.c.release();
                return true;
            } catch (Throwable th) {
                th.printStackTrace();
                this.c = null;
                return false;
            }
        } finally {
            this.c = null;
        }
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public void onSurfaceTextureSizeChanged(SurfaceTexture surfaceTexture, int i, int i2) {
        this.n = i;
        this.o = i2;
        a(i, i2);
    }

    @Override // android.view.TextureView.SurfaceTextureListener
    public void onSurfaceTextureUpdated(SurfaceTexture surfaceTexture) {
    }

    public void setOlaCameraListener(a aVar) {
        this.p = aVar;
    }
}
