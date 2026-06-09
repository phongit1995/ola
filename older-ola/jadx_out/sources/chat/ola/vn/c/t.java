package chat.ola.vn.c;

import android.annotation.TargetApi;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.support.v7.widget.helper.ItemTouchHelper;
import android.util.Base64;
import android.view.View;
import android.widget.ImageView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import com.mg.ola.common.widget.image.viewer.PhotoView;
import java.io.File;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.Executor;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class t {
    public static Integer a = 0;
    public static t b;
    private chat.ola.vn.c.b c;
    private chat.ola.vn.c.b d;
    private File e;
    private List<b> f;
    private Executor g;
    private int h = 0;

    class a {
        w a;
        String b;
        String c;
        String d;

        a() {
        }
    }

    class b {
        AsyncTask<a, Void, Bitmap> a;
        a b;

        b() {
        }
    }

    private t() {
        chat.ola.vn.c.b jVar;
        this.g = null;
        long jMaxMemory = Runtime.getRuntime().maxMemory();
        int i = (int) (jMaxMemory / 15);
        int i2 = (int) (jMaxMemory / 30);
        int i3 = 10485760;
        if (i <= 10485760) {
            i3 = 1572864;
            if (i >= 1572864) {
                i3 = i;
            }
        }
        if (i2 > 3145728) {
            i2 = 3145728;
        } else if (i2 < 524288) {
            i2 = 524288;
        }
        this.f = new LinkedList();
        if (com.mg.ola.common.d.g.d()) {
            this.c = new m(i3, true);
            jVar = new m(i2, true);
        } else {
            this.c = new j(i3, true);
            jVar = new j(i2, true);
        }
        this.d = jVar;
        File fileF = chat.ola.vn.d.f();
        if (fileF.exists()) {
            this.e = new File(fileF.getAbsoluteFile(), ".cached");
            if (!this.e.exists()) {
                this.e.mkdir();
            }
        }
        if (com.mg.ola.common.d.g.c()) {
            this.g = new ThreadPoolExecutor(1, 2, 60000L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue(20), new ThreadFactory() { // from class: chat.ola.vn.c.t.1
                @Override // java.util.concurrent.ThreadFactory
                public Thread newThread(Runnable runnable) {
                    Thread thread = new Thread(runnable);
                    thread.setName(OlaApplication.a + " CacherTask-" + t.this.h);
                    t.b(t.this);
                    return thread;
                }
            });
        }
    }

    public static t a() {
        if (b == null) {
            b = new t();
        }
        return b;
    }

    public static void a(OlaCachedImageView olaCachedImageView, String str, boolean z) {
        try {
            String strB = chat.ola.vn.pickercontacts.g.b(str);
            int i = f.d[strB.charAt(0)];
            String strA = chat.ola.vn.pickercontacts.a.a(Character.valueOf(strB.charAt(0)));
            Bitmap bitmapB = a().b(strA);
            if (bitmapB == null) {
                bitmapB = f.b(strB, i, false);
                a().a(strA, bitmapB);
            }
            if (z) {
                bitmapB = f.a(bitmapB);
            }
            olaCachedImageView.a(bitmapB, null);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @TargetApi(11)
    private void a(String str, int i, OlaCachedImageView olaCachedImageView, View view, final boolean z) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        String strK = chat.ola.vn.util.m.k(str);
        int iC = f.c(i);
        String str2 = ".ccover." + iC + "." + strK.toLowerCase(Locale.US);
        if (olaCachedImageView.a(str2) && !z) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        olaCachedImageView.setLoadingUrl(str2);
        olaCachedImageView.a(null, null);
        k kVar = new k(strK, olaCachedImageView, view, iC);
        try {
            AsyncTask<a, Void, Bitmap> asyncTask = new AsyncTask<a, Void, Bitmap>() { // from class: chat.ola.vn.c.t.7
                a a;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Bitmap doInBackground(a... aVarArr) {
                    try {
                        synchronized (t.a) {
                            t.a = Integer.valueOf(t.a.intValue() + 1);
                        }
                        this.a = aVarArr[0];
                    } catch (Throwable unused) {
                    }
                    if (z) {
                        return null;
                    }
                    chat.ola.vn.c.a aVarA = t.this.d.a(this.a.c);
                    if (aVarA != null) {
                        aVarA.c = System.currentTimeMillis();
                        return aVarA.a;
                    }
                    return null;
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Bitmap bitmap) {
                    synchronized (t.a) {
                        t.a = Integer.valueOf(t.a.intValue() - 1);
                        if (t.a.intValue() <= 0) {
                            t.a = 0;
                        } else if (t.a.intValue() < 5) {
                            try {
                                if (t.this.f.size() > 0) {
                                    b bVar = (b) t.this.f.remove(0);
                                    bVar.a.execute(bVar.b);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    if (this.a.a != null) {
                        if (bitmap != null) {
                            this.a.a.e(this.a.c, bitmap);
                        } else {
                            this.a.a.e(this.a.c);
                        }
                    }
                }
            };
            a aVar = new a();
            aVar.a = kVar;
            aVar.c = str2;
            aVar.d = strK;
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(this.g, aVar);
                return;
            }
            if (a.intValue() < 5) {
                asyncTask.execute(aVar);
                return;
            }
            try {
                b bVar = new b();
                bVar.a = asyncTask;
                bVar.b = aVar;
                this.f.add(bVar);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
        }
    }

    @TargetApi(11)
    private void a(String str, int i, OlaCachedImageView olaCachedImageView, View view, final boolean z, boolean z2) {
        try {
            if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
                return;
            }
            int iC = f.c(i);
            String str2 = ".cover." + iC + "." + str.toLowerCase(Locale.US);
            if (olaCachedImageView.a(str2)) {
                olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                return;
            }
            olaCachedImageView.setLoadingUrl(str2);
            olaCachedImageView.a(null, null);
            u uVar = new u(str, olaCachedImageView, view, iC, z2);
            AsyncTask<a, Void, Bitmap> asyncTask = new AsyncTask<a, Void, Bitmap>() { // from class: chat.ola.vn.c.t.4
                a a;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Bitmap doInBackground(a... aVarArr) {
                    chat.ola.vn.c.a aVarA;
                    try {
                        synchronized (t.a) {
                            t.a = Integer.valueOf(t.a.intValue() + 1);
                        }
                        this.a = aVarArr[0];
                        String str3 = this.a.c;
                        if (!z && (aVarA = t.this.d.a(str3)) != null) {
                            aVarA.c = System.currentTimeMillis();
                            return aVarA.a;
                        }
                    } catch (Throwable unused) {
                    }
                    return null;
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Bitmap bitmap) {
                    synchronized (t.a) {
                        t.a = Integer.valueOf(t.a.intValue() - 1);
                        if (t.a.intValue() <= 0) {
                            t.a = 0;
                        } else if (t.a.intValue() < 5) {
                            try {
                                if (t.this.f.size() > 0) {
                                    b bVar = (b) t.this.f.remove(0);
                                    bVar.a.execute(bVar.b);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    if (this.a.a != null) {
                        if (bitmap != null) {
                            this.a.a.d(this.a.c, bitmap);
                        } else {
                            this.a.a.d(this.a.c);
                        }
                    }
                }
            };
            a aVar = new a();
            aVar.a = uVar;
            aVar.c = str2;
            aVar.d = str;
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(this.g, aVar);
                return;
            }
            if (a.intValue() < 5) {
                asyncTask.execute(aVar);
                return;
            }
            try {
                b bVar = new b();
                bVar.a = asyncTask;
                bVar.b = aVar;
                this.f.add(bVar);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
        }
    }

    @TargetApi(11)
    private void a(String str, int i, boolean z, OlaCachedImageView olaCachedImageView, int i2, final boolean z2) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        String strK = chat.ola.vn.util.m.k(str);
        int iB = f.b(i);
        String str2 = ".covatar." + iB + "." + strK.toLowerCase(Locale.US);
        if (olaCachedImageView.a(str2) && !z2) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        olaCachedImageView.setLoadingUrl(str2);
        if (i2 > 0) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.setImageResource(i2);
        } else {
            olaCachedImageView.a(null, null);
        }
        l lVar = new l(strK, olaCachedImageView, null, iB, z);
        try {
            AsyncTask<a, Void, Bitmap> asyncTask = new AsyncTask<a, Void, Bitmap>() { // from class: chat.ola.vn.c.t.6
                a a;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Bitmap doInBackground(a... aVarArr) {
                    try {
                        synchronized (t.a) {
                            t.a = Integer.valueOf(t.a.intValue() + 1);
                        }
                        this.a = aVarArr[0];
                    } catch (Throwable unused) {
                    }
                    if (z2) {
                        return null;
                    }
                    chat.ola.vn.c.a aVarA = t.this.d.a(this.a.c);
                    if (aVarA != null) {
                        aVarA.c = System.currentTimeMillis();
                        return aVarA.a;
                    }
                    return null;
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Bitmap bitmap) {
                    synchronized (t.a) {
                        t.a = Integer.valueOf(t.a.intValue() - 1);
                        if (t.a.intValue() <= 0) {
                            t.a = 0;
                        } else if (t.a.intValue() < 5) {
                            try {
                                if (t.this.f.size() > 0) {
                                    b bVar = (b) t.this.f.remove(0);
                                    bVar.a.execute(bVar.b);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    if (this.a.a != null) {
                        if (bitmap != null) {
                            this.a.a.b(this.a.c, bitmap);
                        } else {
                            this.a.a.b(this.a.c);
                        }
                    }
                }
            };
            a aVar = new a();
            aVar.a = lVar;
            aVar.c = str2;
            aVar.d = strK;
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(this.g, aVar);
                return;
            }
            if (a.intValue() < 5) {
                asyncTask.execute(aVar);
                return;
            }
            try {
                b bVar = new b();
                bVar.a = asyncTask;
                bVar.b = aVar;
                this.f.add(bVar);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
        }
    }

    private void a(String str, int i, boolean z, OlaCachedImageView olaCachedImageView, boolean z2) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        int iB = f.b(i);
        String str2 = ".ovatar." + iB + "." + str.toLowerCase(Locale.US);
        if (olaCachedImageView.a(str2) && !z2) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        olaCachedImageView.setLoadingUrl(str2);
        olaCachedImageView.a(null, null);
        a(str, z2, str2, new v(str, olaCachedImageView, null, iB, z));
    }

    private void a(String str, OlaCachedImageView olaCachedImageView, Bitmap bitmap, int i, boolean z) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        int iB = f.b(i);
        String str2 = ".ovatar." + iB + "." + str.toLowerCase(Locale.US);
        if (olaCachedImageView.a(str2) && !z) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        olaCachedImageView.setLoadingUrl(str2);
        if (bitmap != null) {
            olaCachedImageView.a(bitmap, null);
        } else {
            olaCachedImageView.a(null, null);
        }
        v vVar = new v(str, olaCachedImageView, null, iB, false);
        vVar.a(true);
        a(str, z, str2, vVar);
    }

    private void a(String str, OlaCachedImageView olaCachedImageView, View view, Bitmap bitmap, int i, int i2, int i3, int i4, boolean z) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        if (olaCachedImageView.a(str)) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        olaCachedImageView.a(null, null);
        if (bitmap != null) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.a(bitmap, null);
        } else if (i != 0) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.setImageResource(i);
        }
        olaCachedImageView.setLoadingUrl(str);
        a(str, new n(olaCachedImageView, view, i2, i3, i4, z));
    }

    private void a(String str, OlaCachedImageView olaCachedImageView, View view, Bitmap bitmap, int i, int i2, boolean z, boolean z2) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        String strB = b(str, z);
        if (olaCachedImageView.a(strB)) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        olaCachedImageView.a(null, null);
        if (bitmap != null) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.a(bitmap, null);
        } else if (i != 0) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.setImageResource(i);
        }
        olaCachedImageView.setLoadingUrl(strB);
        a(str, strB, new p(olaCachedImageView, view, str, i2, z2));
    }

    private void a(String str, OlaCachedImageView olaCachedImageView, ImageView.ScaleType scaleType, View view, Bitmap bitmap, int i, int i2, boolean z) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        try {
            int[] iArrB = chat.ola.vn.entity.i.b(str);
            ((OlaRatioImageView) olaCachedImageView).setRatio(((double) iArrB[0]) / ((double) iArrB[1]));
        } catch (Throwable unused) {
        }
        String str2 = str + "_" + f.a(i2);
        if (olaCachedImageView.a(str2)) {
            if (view != null) {
                view.setVisibility(8);
            }
            olaCachedImageView.setScaleType(scaleType);
            return;
        }
        olaCachedImageView.a(null, null);
        if (bitmap != null) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.a(bitmap, null);
        } else if (i != 0) {
            olaCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            olaCachedImageView.setImageResource(i);
        }
        olaCachedImageView.setLoadingUrl(str2);
        a(str2, new r(str, olaCachedImageView, scaleType, view, i2, z));
    }

    private void a(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view, Bitmap bitmap, int i, int i2, int i3, int i4, boolean z) {
        if (chat.ola.vn.util.m.a(str) || photoView == null) {
            return;
        }
        if (photoView.a(str)) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        photoView.a(null, null);
        if (bitmap != null) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            photoView.a(bitmap, null);
        } else if (i != 0) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            photoView.setImageResource(i);
        }
        photoView.setLoadingUrl(str);
        a(str, new o(photoView, scaleType, view, i2, i3, i4, z));
    }

    private void a(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view, Bitmap bitmap, int i, int i2, boolean z) {
        if (chat.ola.vn.util.m.a(str) || photoView == null) {
            return;
        }
        String str2 = str + "_" + f.a(i2);
        if (photoView.a(str2)) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        photoView.a(null, null);
        if (bitmap != null) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            photoView.a(bitmap, null);
        } else if (i != 0) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            photoView.setImageResource(i);
        }
        photoView.setLoadingUrl(str2);
        a(str2, new s(str, photoView, scaleType, view, i2, z));
    }

    @TargetApi(11)
    private void a(String str, final boolean z, String str2, v vVar) {
        try {
            AsyncTask<a, Void, Bitmap> asyncTask = new AsyncTask<a, Void, Bitmap>() { // from class: chat.ola.vn.c.t.5
                a a;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Bitmap doInBackground(a... aVarArr) {
                    try {
                        synchronized (t.a) {
                            t.a = Integer.valueOf(t.a.intValue() + 1);
                        }
                        this.a = aVarArr[0];
                    } catch (Throwable unused) {
                    }
                    if (z) {
                        return null;
                    }
                    chat.ola.vn.c.a aVarA = t.this.d.a(this.a.c);
                    if (aVarA != null) {
                        aVarA.c = System.currentTimeMillis();
                        return aVarA.a;
                    }
                    return null;
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Bitmap bitmap) {
                    synchronized (t.a) {
                        t.a = Integer.valueOf(t.a.intValue() - 1);
                        if (t.a.intValue() <= 0) {
                            t.a = 0;
                        } else if (t.a.intValue() < 5) {
                            try {
                                if (t.this.f.size() > 0) {
                                    b bVar = (b) t.this.f.remove(0);
                                    bVar.a.execute(bVar.b);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    if (this.a.a != null) {
                        if (bitmap != null) {
                            this.a.a.a(this.a.c, bitmap);
                        } else {
                            this.a.a.a(this.a.c);
                        }
                    }
                }
            };
            a aVar = new a();
            aVar.a = vVar;
            aVar.c = str2;
            aVar.d = str;
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(this.g, aVar);
                return;
            }
            if (a.intValue() < 5) {
                asyncTask.execute(aVar);
                return;
            }
            try {
                b bVar = new b();
                bVar.a = asyncTask;
                bVar.b = aVar;
                this.f.add(bVar);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
        }
    }

    static /* synthetic */ int b(t tVar) {
        int i = tVar.h + 1;
        tVar.h = i;
        return i;
    }

    public static String b(String str, boolean z) {
        String strEncodeToString = Base64.encodeToString(str.getBytes(), 3);
        if (!z) {
            return strEncodeToString;
        }
        return ".thumb." + strEncodeToString;
    }

    private void b(String str, OlaCachedImageView olaCachedImageView, Bitmap bitmap, int i) {
        if (chat.ola.vn.util.m.a(str) || olaCachedImageView == null) {
            return;
        }
        String str2 = str + "_" + f.a(i);
        if (olaCachedImageView.a(str2)) {
            return;
        }
        olaCachedImageView.a(bitmap, null);
        olaCachedImageView.setLoadingUrl(str2);
        a(str2, new h(str, olaCachedImageView, i));
    }

    public Bitmap a(String str, boolean z) {
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        try {
            return b(b(str, z));
        } catch (Throwable unused) {
            return null;
        }
    }

    public chat.ola.vn.c.a a(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        chat.ola.vn.c.a aVarA = this.c.a(str);
        if (aVarA != null && aVarA.d) {
            aVarA.c = System.currentTimeMillis();
            return aVarA;
        }
        try {
            File file = new File(this.e.getAbsoluteFile(), ".best");
            if (file.exists()) {
                File file2 = new File(file.getAbsoluteFile(), str);
                if (file2.exists()) {
                    try {
                        Bitmap bitmapDecodeFile = BitmapFactory.decodeFile(file2.getAbsolutePath());
                        if (bitmapDecodeFile != null) {
                            return a(str, bitmapDecodeFile, true);
                        }
                        if (bitmapDecodeFile == null) {
                            b();
                            return aVarA;
                        }
                    } catch (Throwable unused) {
                        b();
                    }
                }
            }
        } catch (Throwable unused2) {
        }
        return aVarA;
    }

    public chat.ola.vn.c.a a(String str, Bitmap bitmap) {
        return a(str, bitmap, false);
    }

    public chat.ola.vn.c.a a(String str, Bitmap bitmap, boolean z) {
        if (str == null || bitmap == null) {
            return null;
        }
        chat.ola.vn.c.a aVar = new chat.ola.vn.c.a();
        aVar.c = System.currentTimeMillis();
        aVar.a = bitmap;
        aVar.b = str;
        aVar.d = z;
        this.c.a(str, aVar);
        return aVar;
    }

    @TargetApi(11)
    public void a(String str, w wVar) {
        try {
            AsyncTask<a, Void, Bitmap> asyncTask = new AsyncTask<a, Void, Bitmap>() { // from class: chat.ola.vn.c.t.3
                a a;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Bitmap doInBackground(a... aVarArr) {
                    try {
                        synchronized (t.a) {
                            t.a = Integer.valueOf(t.a.intValue() + 1);
                        }
                        this.a = aVarArr[0];
                        chat.ola.vn.c.a aVarA = t.this.c.a(this.a.c);
                        if (aVarA == null) {
                            return null;
                        }
                        aVarA.c = System.currentTimeMillis();
                        return aVarA.a;
                    } catch (Throwable unused) {
                        return null;
                    }
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Bitmap bitmap) {
                    synchronized (t.a) {
                        t.a = Integer.valueOf(t.a.intValue() - 1);
                        if (t.a.intValue() <= 0) {
                            t.a = 0;
                        } else if (t.a.intValue() < 5) {
                            try {
                                if (t.this.f.size() > 0) {
                                    b bVar = (b) t.this.f.remove(0);
                                    bVar.a.execute(bVar.b);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    if (this.a.a != null) {
                        if (bitmap != null) {
                            this.a.a.c(this.a.c, bitmap);
                        } else {
                            this.a.a.c(this.a.c);
                        }
                    }
                }
            };
            a aVar = new a();
            aVar.a = wVar;
            aVar.c = str;
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(this.g, aVar);
                return;
            }
            if (a.intValue() < 5) {
                asyncTask.execute(aVar);
                return;
            }
            try {
                b bVar = new b();
                bVar.a = asyncTask;
                bVar.b = aVar;
                this.f.add(bVar);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
        }
    }

    public void a(String str, OlaCachedImageView olaCachedImageView) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, 0, false, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, int i) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, i, true, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, int i, int i2) {
        a(str, olaCachedImageView, ImageView.ScaleType.CENTER_CROP, (View) null, (Bitmap) null, i, i2, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, int i, int i2, boolean z) {
        a(str, olaCachedImageView, ImageView.ScaleType.CENTER_CROP, (View) null, (Bitmap) null, i, i2, z);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, int i, boolean z) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, i, 0, true, z);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, Bitmap bitmap) {
        a(str, olaCachedImageView, bitmap, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, Bitmap bitmap, int i) {
        b(str, olaCachedImageView, bitmap, i);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, View view) {
        a(str, olaCachedImageView, view, (Bitmap) null, 0, 0, true, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, View view, int i) {
        int iMax = Math.max(chat.ola.vn.e.c, chat.ola.vn.e.d) * 2;
        if (chat.ola.vn.h.I) {
            iMax = Math.max(Math.max(chat.ola.vn.e.c, chat.ola.vn.e.d), 1920);
        }
        a(str, olaCachedImageView, ImageView.ScaleType.CENTER_CROP, view, (Bitmap) null, i, iMax, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, View view, int i, int i2) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, 0, i, i2, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, ImageView.ScaleType scaleType, View view, int i) {
        a(str, olaCachedImageView, scaleType, view, (Bitmap) null, 0, i, false);
    }

    public void a(String str, OlaCachedImageView olaCachedImageView, boolean z) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, 0, z, false);
    }

    public void a(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view) {
        a(str, photoView, scaleType, view, 0);
    }

    public void a(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view, int i) {
        a(str, photoView, scaleType, view, (Bitmap) null, i, 0, false, false);
    }

    public void a(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view, int i, int i2) {
        a(str, photoView, scaleType, view, null, 0, 0, i, i2, false);
    }

    public void a(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view, Bitmap bitmap, int i, int i2, boolean z, boolean z2) {
        if (chat.ola.vn.util.m.a(str) || photoView == null) {
            return;
        }
        String strB = b(str, z);
        if (photoView.a(strB)) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            return;
        }
        photoView.a(null, null);
        if (bitmap != null) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            photoView.a(bitmap, null);
        } else if (i != 0) {
            photoView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            photoView.setImageResource(i);
        }
        photoView.setLoadingUrl(strB);
        a(str, strB, new q(photoView, scaleType, view, str, i2, z2));
    }

    public void a(String str, String str2) {
        chat.ola.vn.c.a aVarB = this.c.b(str);
        if (aVarB != null) {
            aVarB.b = str2;
            aVarB.c = System.currentTimeMillis();
            this.c.a(str2, aVarB);
        }
    }

    @TargetApi(11)
    public void a(String str, String str2, c cVar) {
        try {
            AsyncTask<a, Void, Bitmap> asyncTask = new AsyncTask<a, Void, Bitmap>() { // from class: chat.ola.vn.c.t.2
                a a;

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Bitmap doInBackground(a... aVarArr) {
                    try {
                        synchronized (t.a) {
                            t.a = Integer.valueOf(t.a.intValue() + 1);
                        }
                        this.a = aVarArr[0];
                        return t.this.b(this.a.c);
                    } catch (Throwable unused) {
                        return null;
                    }
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Bitmap bitmap) {
                    synchronized (t.a) {
                        t.a = Integer.valueOf(t.a.intValue() - 1);
                        if (t.a.intValue() <= 0) {
                            t.a = 0;
                        } else if (t.a.intValue() < 5) {
                            try {
                                if (t.this.f.size() > 0) {
                                    b bVar = (b) t.this.f.remove(0);
                                    bVar.a.execute(bVar.b);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    if (this.a.a != null) {
                        if (bitmap != null) {
                            this.a.a.f(this.a.c, bitmap);
                        } else {
                            this.a.a.f(this.a.c);
                        }
                    }
                }
            };
            a aVar = new a();
            aVar.a = cVar;
            aVar.c = str2;
            aVar.b = str;
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(this.g, aVar);
                return;
            }
            if (a.intValue() < 5) {
                asyncTask.execute(aVar);
                return;
            }
            try {
                b bVar = new b();
                bVar.a = asyncTask;
                bVar.b = aVar;
                this.f.add(bVar);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
        }
    }

    public void a(String str, boolean z, OlaCachedImageView olaCachedImageView) {
        a(str, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, z, olaCachedImageView, false);
    }

    public void a(String str, boolean z, OlaCachedImageView olaCachedImageView, boolean z2) {
        a(str, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, z, olaCachedImageView, z2);
    }

    public void a(boolean z) {
        try {
            this.c.a();
            if (z) {
                OlaNetworkService.a();
            }
        } catch (Throwable unused) {
        }
    }

    public Bitmap b(String str) {
        chat.ola.vn.c.a aVarA;
        if (chat.ola.vn.util.m.a(str) || (aVarA = this.c.a(str)) == null) {
            return null;
        }
        aVarA.c = System.currentTimeMillis();
        return aVarA.a;
    }

    public chat.ola.vn.c.a b(String str, Bitmap bitmap) {
        if (str == null || bitmap == null) {
            return null;
        }
        chat.ola.vn.c.a aVar = new chat.ola.vn.c.a();
        aVar.c = System.currentTimeMillis();
        aVar.a = bitmap;
        aVar.b = str;
        aVar.d = false;
        this.d.a(str, aVar);
        return aVar;
    }

    public void b() {
        a(false);
    }

    public void b(String str, OlaCachedImageView olaCachedImageView) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, 0, false, false);
    }

    public void b(String str, OlaCachedImageView olaCachedImageView, int i) {
        a(str, olaCachedImageView, ImageView.ScaleType.CENTER_CROP, (View) null, (Bitmap) null, 0, i, false);
    }

    public void b(String str, OlaCachedImageView olaCachedImageView, View view) {
        a(str, olaCachedImageView, view, (Bitmap) null, 0, 0, false, false);
    }

    public void b(String str, OlaCachedImageView olaCachedImageView, View view, int i) {
        a(str, olaCachedImageView, ImageView.ScaleType.CENTER_CROP, view, i);
    }

    public void b(String str, OlaCachedImageView olaCachedImageView, boolean z) {
        a(str, 720, olaCachedImageView, (View) null, z, false);
    }

    public void b(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view) {
        b(str, photoView, scaleType, view, 0);
    }

    public void b(String str, PhotoView photoView, ImageView.ScaleType scaleType, View view, int i) {
        int iMax = Math.max(chat.ola.vn.e.c, chat.ola.vn.e.d) * 2;
        if (chat.ola.vn.h.I) {
            iMax = Math.max(Math.max(chat.ola.vn.e.c, chat.ola.vn.e.d), 1920);
        }
        a(str, photoView, scaleType, view, (Bitmap) null, i, iMax, false);
    }

    public void b(String str, boolean z, OlaCachedImageView olaCachedImageView) {
        a(str, 100, z, olaCachedImageView, false);
    }

    public void b(boolean z) {
        try {
            this.d.a();
            if (z) {
                OlaNetworkService.b();
            }
        } catch (Throwable unused) {
        }
    }

    public Bitmap c(String str) {
        try {
            if (chat.ola.vn.util.m.a(str)) {
                return null;
            }
            chat.ola.vn.c.a aVarA = this.d.a(".ovatar.100." + str);
            if (aVarA != null) {
                aVarA.c = System.currentTimeMillis();
                return aVarA.a;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public void c() {
        b(false);
    }

    public void c(String str, OlaCachedImageView olaCachedImageView) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, 0, true, false);
    }

    public void c(String str, OlaCachedImageView olaCachedImageView, int i) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, i, 2, 0, 0, false);
    }

    public void c(String str, OlaCachedImageView olaCachedImageView, View view) {
        a(str, olaCachedImageView, view, 0);
    }

    public void c(String str, OlaCachedImageView olaCachedImageView, boolean z) {
        a(str, 720, olaCachedImageView, (View) null, z, true);
    }

    public Bitmap d(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        chat.ola.vn.c.a aVarA = this.c.a(".cover." + str);
        if (aVarA == null) {
            return null;
        }
        aVarA.c = System.currentTimeMillis();
        return aVarA.a;
    }

    public void d(String str, OlaCachedImageView olaCachedImageView) {
        a(str, olaCachedImageView, (View) null, 0);
    }

    public void d(String str, OlaCachedImageView olaCachedImageView, boolean z) {
        a(str, 720, olaCachedImageView, (View) null, z);
    }

    public void e(String str, OlaCachedImageView olaCachedImageView) {
        a(str, olaCachedImageView, (View) null, (Bitmap) null, 0, 1, 0, 0, false);
    }

    public void e(String str, OlaCachedImageView olaCachedImageView, boolean z) {
        a(str, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, false, olaCachedImageView, 0, z);
    }

    public void f(String str, OlaCachedImageView olaCachedImageView) {
        a(str, 50, true, olaCachedImageView, false);
    }

    public void g(String str, OlaCachedImageView olaCachedImageView) {
        a(str, 100, true, olaCachedImageView, false);
    }

    public void h(String str, OlaCachedImageView olaCachedImageView) {
        a(str, 480, olaCachedImageView, (View) null, false, true);
    }

    public void i(String str, OlaCachedImageView olaCachedImageView) {
        e(str, olaCachedImageView, false);
    }

    public void j(String str, OlaCachedImageView olaCachedImageView) {
        a(str, 100, false, olaCachedImageView, 0, false);
    }

    public void k(String str, OlaCachedImageView olaCachedImageView) {
        a(str, 50, true, olaCachedImageView, R.drawable.ic_menu_clan, false);
    }
}
