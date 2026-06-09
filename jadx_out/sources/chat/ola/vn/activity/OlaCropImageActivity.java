package chat.ola.vn.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.c.f;
import chat.ola.vn.c.g;
import chat.ola.vn.c.t;
import chat.ola.vn.d;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.r.a.e;
import chat.ola.vn.u.o;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import com.facebook.places.model.PlaceFields;
import java.io.File;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class OlaCropImageActivity extends c {
    private static int e = 1;
    private static int f = C();
    private static int g = C();
    private static Uri h = null;
    private static boolean i = false;
    private static b j;

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaCropImageActivity$11, reason: invalid class name */
    static class AnonymousClass11 implements b {
        ProgressDialog a;
        final /* synthetic */ Context b;
        final /* synthetic */ a c;

        AnonymousClass11(Context context, a aVar) {
            this.b = context;
            this.c = aVar;
            this.a = i.a(this.b, 0, 100, this.b.getString(R.string.string_upload), this.b.getString(R.string.message_uploading_in_progress));
        }

        @Override // chat.ola.vn.activity.OlaCropImageActivity.b
        public void a(final String str) {
            this.a.show();
            chat.ola.vn.u.b.a().a(str, "jpg", null, new o() { // from class: chat.ola.vn.activity.OlaCropImageActivity.11.1
                private void b(String str2) {
                    try {
                        AnonymousClass11.this.a.dismiss();
                        if (m.a(str2)) {
                            str2 = AnonymousClass11.this.b.getString(R.string.message_upload_fail);
                        }
                        i.b(AnonymousClass11.this.b, AnonymousClass11.this.b.getString(R.string.dialog_title_fail), str2);
                        if (AnonymousClass11.this.c != null) {
                            AnonymousClass11.this.c.F();
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(int i, int i2) {
                    AnonymousClass11.this.a.setMax(i2);
                    AnonymousClass11.this.a.setProgress(i);
                }

                @Override // chat.ola.vn.u.o
                public void a(chat.ola.vn.entity.i iVar) {
                    try {
                        OlaApplication.b.b(new String[]{"avatar"}, new String[]{iVar.d()});
                        OlaApplication.b.a(OlaApplication.a(R.string.message_change_ovatar_post_me), iVar.d(), (short) 0, (short) 2, (String) null, (String) null, (short) 0);
                        com.mg.ola.common.d.c.c(new File(str));
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.11.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    AnonymousClass11.this.a.dismiss();
                                    e.e = true;
                                    try {
                                        t.a().b(true);
                                    } catch (Throwable unused) {
                                    }
                                    try {
                                        j.b(AnonymousClass11.this.b, R.string.message_change_avatar_success);
                                    } catch (Throwable unused2) {
                                    }
                                    if (AnonymousClass11.this.c != null) {
                                        AnonymousClass11.this.c.D();
                                    }
                                } catch (Throwable unused3) {
                                }
                            }
                        }, 1000L);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2) {
                    b(null);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i) {
                    b(AnonymousClass11.this.b.getString(R.string.message_photo_size_too_large));
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void b(String str2, String str3) {
                    b(str3);
                }
            });
        }
    }

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaCropImageActivity$12, reason: invalid class name */
    static class AnonymousClass12 implements b {
        ProgressDialog a;
        final /* synthetic */ Context b;
        final /* synthetic */ a c;

        AnonymousClass12(Context context, a aVar) {
            this.b = context;
            this.c = aVar;
            this.a = i.a(this.b, 0, 100, this.b.getString(R.string.string_upload), this.b.getString(R.string.message_uploading_in_progress));
        }

        @Override // chat.ola.vn.activity.OlaCropImageActivity.b
        public void a(final String str) {
            this.a.show();
            chat.ola.vn.u.b.a().a(str, "jpg", null, new o() { // from class: chat.ola.vn.activity.OlaCropImageActivity.12.1
                private void b(String str2) {
                    try {
                        AnonymousClass12.this.a.dismiss();
                        if (m.a(str2)) {
                            str2 = AnonymousClass12.this.b.getString(R.string.message_upload_fail);
                        }
                        i.b(AnonymousClass12.this.b, AnonymousClass12.this.b.getString(R.string.dialog_title_fail), str2);
                        if (AnonymousClass12.this.c != null) {
                            AnonymousClass12.this.c.F();
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(int i, int i2) {
                    AnonymousClass12.this.a.setMax(i2);
                    AnonymousClass12.this.a.setProgress(i);
                }

                @Override // chat.ola.vn.u.o
                public void a(chat.ola.vn.entity.i iVar) {
                    try {
                        OlaApplication.b.b(new String[]{PlaceFields.COVER}, new String[]{iVar.d()});
                        OlaApplication.b.a(OlaApplication.a(R.string.message_change_cover_post_me), iVar.d(), (short) 0, (short) 2, (String) null, (String) null, (short) 0);
                        com.mg.ola.common.d.c.c(new File(str));
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.12.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    AnonymousClass12.this.a.dismiss();
                                    e.e = true;
                                    try {
                                        t.a().b(true);
                                    } catch (Throwable unused) {
                                    }
                                    try {
                                        j.b(AnonymousClass12.this.b, R.string.message_change_cover_success);
                                    } catch (Throwable unused2) {
                                    }
                                    if (AnonymousClass12.this.c != null) {
                                        AnonymousClass12.this.c.E();
                                    }
                                } catch (Throwable unused3) {
                                }
                            }
                        }, 1000L);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2) {
                    b(null);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i) {
                    b(AnonymousClass12.this.b.getString(R.string.message_photo_size_too_large));
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void b(String str2, String str3) {
                    b(str3);
                }
            });
        }
    }

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaCropImageActivity$13, reason: invalid class name */
    static class AnonymousClass13 implements b {
        ProgressDialog a;
        final /* synthetic */ Context b;
        final /* synthetic */ String c;
        final /* synthetic */ a d;

        AnonymousClass13(Context context, String str, a aVar) {
            this.b = context;
            this.c = str;
            this.d = aVar;
            this.a = i.a(this.b, 0, 100, this.b.getString(R.string.string_upload), this.b.getString(R.string.message_uploading_in_progress));
        }

        @Override // chat.ola.vn.activity.OlaCropImageActivity.b
        public void a(final String str) {
            this.a.show();
            chat.ola.vn.u.b.a().a(str, "jpg", null, new o() { // from class: chat.ola.vn.activity.OlaCropImageActivity.13.1
                private void b(String str2) {
                    try {
                        AnonymousClass13.this.a.dismiss();
                        if (m.a(str2)) {
                            str2 = AnonymousClass13.this.b.getString(R.string.message_upload_fail);
                        }
                        i.b(AnonymousClass13.this.b, AnonymousClass13.this.b.getString(R.string.dialog_title_fail), str2);
                        if (AnonymousClass13.this.d != null) {
                            AnonymousClass13.this.d.F();
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(int i, int i2) {
                    AnonymousClass13.this.a.setMax(i2);
                    AnonymousClass13.this.a.setProgress(i);
                }

                @Override // chat.ola.vn.u.o
                public void a(chat.ola.vn.entity.i iVar) {
                    try {
                        OlaApplication.b.a(AnonymousClass13.this.c, new String[]{"avatar"}, new String[]{iVar.d()});
                        OlaApplication.b.a(OlaApplication.a(R.string.message_change_clan_ovatar_post_me_format, "#" + AnonymousClass13.this.c), iVar.d(), (short) 0, (short) 2, (String) null, (String) null, (short) 0);
                        com.mg.ola.common.d.c.c(new File(str));
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.13.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    AnonymousClass13.this.a.dismiss();
                                    e.e = true;
                                    try {
                                        t.a().b(true);
                                    } catch (Throwable unused) {
                                    }
                                    try {
                                        j.a(AnonymousClass13.this.b, AnonymousClass13.this.b.getString(R.string.message_change_clan_avatar_success_format, "#" + AnonymousClass13.this.c));
                                    } catch (Throwable unused2) {
                                    }
                                    if (AnonymousClass13.this.d != null) {
                                        AnonymousClass13.this.d.D();
                                    }
                                } catch (Throwable unused3) {
                                }
                            }
                        }, 5000L);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2) {
                    b(null);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i) {
                    b(AnonymousClass13.this.b.getString(R.string.message_photo_size_too_large));
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void b(String str2, String str3) {
                    b(str3);
                }
            });
        }
    }

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaCropImageActivity$2, reason: invalid class name */
    static class AnonymousClass2 implements b {
        ProgressDialog a;
        final /* synthetic */ Context b;
        final /* synthetic */ String c;
        final /* synthetic */ a d;

        AnonymousClass2(Context context, String str, a aVar) {
            this.b = context;
            this.c = str;
            this.d = aVar;
            this.a = i.a(this.b, 0, 100, this.b.getString(R.string.string_upload), this.b.getString(R.string.message_uploading_in_progress));
        }

        @Override // chat.ola.vn.activity.OlaCropImageActivity.b
        public void a(final String str) {
            this.a.show();
            chat.ola.vn.u.b.a().a(str, "jpg", null, new o() { // from class: chat.ola.vn.activity.OlaCropImageActivity.2.1
                private void b(String str2) {
                    try {
                        AnonymousClass2.this.a.dismiss();
                        if (m.a(str2)) {
                            str2 = AnonymousClass2.this.b.getString(R.string.message_upload_fail);
                        }
                        i.b(AnonymousClass2.this.b, AnonymousClass2.this.b.getString(R.string.dialog_title_fail), str2);
                        if (AnonymousClass2.this.d != null) {
                            AnonymousClass2.this.d.F();
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(int i, int i2) {
                    AnonymousClass2.this.a.setMax(i2);
                    AnonymousClass2.this.a.setProgress(i);
                }

                @Override // chat.ola.vn.u.o
                public void a(chat.ola.vn.entity.i iVar) {
                    try {
                        OlaApplication.b.a(AnonymousClass2.this.c, new String[]{PlaceFields.COVER}, new String[]{iVar.d()});
                        OlaApplication.b.a(OlaApplication.a(R.string.message_change_clan_cover_post_me_format, "#" + AnonymousClass2.this.c), iVar.d(), (short) 0, (short) 2, (String) null, (String) null, (short) 0);
                        com.mg.ola.common.d.c.c(new File(str));
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.2.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    AnonymousClass2.this.a.dismiss();
                                    e.e = true;
                                    try {
                                        t.a().b(true);
                                    } catch (Throwable unused) {
                                    }
                                    try {
                                        j.a(AnonymousClass2.this.b, AnonymousClass2.this.b.getString(R.string.message_change_clan_cover_success_format, "#" + AnonymousClass2.this.c));
                                    } catch (Throwable unused2) {
                                    }
                                    if (AnonymousClass2.this.d != null) {
                                        AnonymousClass2.this.d.E();
                                    }
                                } catch (Throwable unused3) {
                                }
                            }
                        }, 5000L);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2) {
                    b(null);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i) {
                    b(AnonymousClass2.this.b.getString(R.string.message_photo_size_too_large));
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, int i, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void a(String str2, String str3) {
                    b(str3);
                }

                @Override // chat.ola.vn.u.o
                public void b(String str2, String str3) {
                    b(str3);
                }
            });
        }
    }

    public interface a {
        void D();

        void E();

        void F();

        void G();

        void b_();

        void f(String str);
    }

    public interface b {
        void a(String str);
    }

    private void B() {
        Intent intent = new Intent(this, (Class<?>) OlaImageCropToolActivity.class);
        intent.setData(h);
        intent.putExtra("outputX", f);
        intent.putExtra("outputY", g);
        intent.putExtra("aspectX", f);
        intent.putExtra("aspectY", g);
        intent.putExtra("scale", true);
        intent.putExtra("return-data", true);
        intent.putExtra("outputFormat", Bitmap.CompressFormat.JPEG.toString());
        startActivityForResult(intent, 3);
    }

    private static int C() {
        return Math.min(1280, chat.ola.vn.e.c);
    }

    public static void a(Context context) {
        e(context, null, null);
    }

    public static void a(Context context, a aVar) {
        f(context, null, aVar);
    }

    public static void a(Context context, String str) {
        d(context, chat.ola.vn.entity.i.k(str), null);
    }

    private static void a(final Context context, String str, final int i2, final int i3, b bVar) {
        try {
            j = bVar;
            if (m.a(str)) {
                ArrayList arrayList = new ArrayList();
                arrayList.add(context.getString(R.string.string_take_from_camera));
                arrayList.add(context.getString(R.string.string_select_from_gallery));
                chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
                mVar.setTitle(R.string.string_select_photo);
                mVar.a(arrayList);
                mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaCropImageActivity.5
                    @Override // android.widget.AdapterView.OnItemClickListener
                    public void onItemClick(AdapterView<?> adapterView, View view, int i4, long j2) {
                        Context context2;
                        int i5;
                        int i6;
                        int i7;
                        try {
                            switch (i4) {
                                case 0:
                                    context2 = context;
                                    i5 = i2;
                                    i6 = i3;
                                    i7 = 1;
                                    break;
                                case 1:
                                    context2 = context;
                                    i5 = i2;
                                    i6 = i3;
                                    i7 = 2;
                                    break;
                                default:
                                    return;
                            }
                            OlaCropImageActivity.b(context2, (Uri) null, i5, i6, i7);
                        } catch (Throwable unused) {
                        }
                    }
                });
                mVar.show();
                return;
            }
            File file = new File(str);
            if (file.exists()) {
                File file2 = new File(d.m(), ".crop." + System.currentTimeMillis() + ".tmp");
                if (!file2.exists()) {
                    file2.createNewFile();
                }
                try {
                    com.mg.ola.common.d.c.a(file, file2);
                    d.g(file2.getAbsolutePath());
                    h = Uri.fromFile(file2);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                b(context, h, i2, i3, 2);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, a aVar) {
        b(context, m.k(str), (String) null, chat.ola.vn.e.c, aVar);
    }

    private static void a(Context context, String str, String str2, int i2, a aVar) {
        a(context, str2, i2, i2, new AnonymousClass13(context, str, aVar));
    }

    public static void b(Context context) {
        f(context, null, chat.ola.vn.e.c, null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void b(Context context, Uri uri, int i2, int i3, int i4) {
        try {
            h = uri;
            i = true;
            e = i4;
            f = i2;
            g = i3;
            context.startActivity(new Intent(context, (Class<?>) OlaCropImageActivity.class));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void b(Context context, a aVar) {
        f(context, null, chat.ola.vn.e.c, aVar);
    }

    public static void b(Context context, String str) {
        d(context, str, null);
    }

    public static void b(Context context, String str, a aVar) {
        a(context, m.k(str), (String) null, C(), aVar);
    }

    private static void b(Context context, String str, String str2, int i2, a aVar) {
        a(context, str2, i2, (i2 * 9) / 16, new AnonymousClass2(context, str, aVar));
    }

    public static void c(Context context) {
        e(context, (String) null, C(), (a) null);
    }

    public static void c(Context context, a aVar) {
        e(context, (String) null, C(), aVar);
    }

    public static void c(Context context, String str) {
        e(context, str, null);
    }

    private static void c(final Context context, final String str, final int i2, final a aVar) {
        final chat.ola.vn.i.c cVarA = i.a(context, R.string.message_downloading_in_progress, 180000L, new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.1
            @Override // java.lang.Runnable
            public void run() {
                aVar.G();
            }
        });
        f fVarA = f.a(str, i2, false);
        fVarA.a(new g() { // from class: chat.ola.vn.activity.OlaCropImageActivity.6
            @Override // chat.ola.vn.c.g
            public void a(f fVar) {
                try {
                    if (m.b(str, fVar.h())) {
                        cVarA.dismiss();
                        File file = new File(d.m(), ".crop." + System.currentTimeMillis() + ".tmp");
                        com.mg.ola.common.d.c.a(fVar.c(), file);
                        OlaCropImageActivity.f(context, file.getAbsolutePath(), i2, aVar);
                    }
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.c.g
            public void b(f fVar) {
                try {
                    if (m.b(str, fVar.h())) {
                        cVarA.dismiss();
                        aVar.G();
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        try {
            new chat.ola.vn.c.e().a(fVarA);
            cVarA.show();
        } catch (Throwable unused) {
            aVar.G();
        }
    }

    public static void d(Context context, String str) {
        int iMin = chat.ola.vn.e.c;
        int[] iArrB = chat.ola.vn.entity.i.b(str);
        try {
            iMin = Math.min(iArrB[0], iArrB[1]);
        } catch (Throwable unused) {
        }
        c(context, chat.ola.vn.entity.i.k(str), iMin, (a) null);
    }

    private static void d(final Context context, final String str, final int i2, final a aVar) {
        final chat.ola.vn.i.c cVarA = i.a(context, R.string.message_downloading_in_progress, 180000L, new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.9
            @Override // java.lang.Runnable
            public void run() {
                aVar.F();
            }
        });
        f fVarA = f.a(str, i2, false);
        fVarA.a(new g() { // from class: chat.ola.vn.activity.OlaCropImageActivity.10
            @Override // chat.ola.vn.c.g
            public void a(f fVar) {
                try {
                    if (m.b(str, fVar.h())) {
                        cVarA.dismiss();
                        File file = new File(d.m(), ".crop." + System.currentTimeMillis() + ".tmp");
                        com.mg.ola.common.d.c.a(fVar.c(), file);
                        OlaCropImageActivity.e(context, file.getAbsolutePath(), i2, aVar);
                    }
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.c.g
            public void b(f fVar) {
                try {
                    if (m.b(str, fVar.h())) {
                        cVarA.dismiss();
                        aVar.F();
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        try {
            new chat.ola.vn.c.e().a(fVarA);
            cVarA.show();
        } catch (Throwable unused) {
            aVar.F();
        }
    }

    private static void d(final Context context, final String str, final a aVar) {
        final chat.ola.vn.i.c cVarA = i.a(context, R.string.message_downloading_in_progress, 180000L, new Runnable() { // from class: chat.ola.vn.activity.OlaCropImageActivity.7
            @Override // java.lang.Runnable
            public void run() {
                aVar.G();
            }
        });
        f fVarA = f.a(str, chat.ola.vn.e.c, false);
        fVarA.a(new g() { // from class: chat.ola.vn.activity.OlaCropImageActivity.8
            @Override // chat.ola.vn.c.g
            public void a(f fVar) {
                try {
                    if (m.b(str, fVar.h())) {
                        cVarA.dismiss();
                        File file = new File(d.m(), ".crop." + System.currentTimeMillis() + ".tmp");
                        com.mg.ola.common.d.c.a(fVar.c(), file);
                        OlaCropImageActivity.e(context, file.getAbsolutePath(), aVar);
                    }
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.c.g
            public void b(f fVar) {
                try {
                    if (m.b(str, fVar.h())) {
                        cVarA.dismiss();
                        aVar.G();
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        try {
            new chat.ola.vn.c.e().a(fVarA);
            cVarA.show();
        } catch (Throwable unused) {
            aVar.G();
        }
    }

    public static void e(Context context, String str) {
        c(context, str, chat.ola.vn.e.c, (a) null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void e(Context context, String str, int i2, a aVar) {
        a(context, str, i2, i2, new AnonymousClass11(context, aVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void e(final Context context, String str, final a aVar) {
        a(context, str, chat.ola.vn.e.c, chat.ola.vn.e.d, new b() { // from class: chat.ola.vn.activity.OlaCropImageActivity.3
            /* JADX WARN: Type inference failed for: r1v2, types: [chat.ola.vn.activity.OlaCropImageActivity$3$1] */
            @Override // chat.ola.vn.activity.OlaCropImageActivity.b
            public void a(final String str2) {
                try {
                    final ProgressDialog progressDialogA = i.a(context, (CharSequence) context.getString(R.string.string_please_wait), (CharSequence) context.getString(R.string.message_changing_app_background));
                    new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.activity.OlaCropImageActivity.3.1
                        /* JADX INFO: Access modifiers changed from: protected */
                        @Override // android.os.AsyncTask
                        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                        public Void doInBackground(Void... voidArr) {
                            try {
                                Bitmap bitmapDecodeFile = BitmapFactory.decodeFile(str2);
                                if (bitmapDecodeFile == null) {
                                    return null;
                                }
                                chat.ola.vn.h.b.a(h.a(), chat.ola.vn.badger.e.a(bitmapDecodeFile));
                                OlaBottomTabActivity.e = new BitmapDrawable(OlaApplication.b(), bitmapDecodeFile);
                                OlaBottomTabActivity.f = true;
                                return null;
                            } catch (Throwable th) {
                                th.printStackTrace();
                                return null;
                            }
                        }

                        /* JADX INFO: Access modifiers changed from: protected */
                        @Override // android.os.AsyncTask
                        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                        public void onPostExecute(Void r2) {
                            try {
                                j.b(context, R.string.message_change_app_background_success);
                                if (aVar != null) {
                                    aVar.b_();
                                }
                                progressDialogA.dismiss();
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // android.os.AsyncTask
                        protected void onPreExecute() {
                            try {
                                progressDialogA.show();
                            } catch (Throwable unused) {
                            }
                        }
                    }.execute(new Void[0]);
                } catch (Throwable unused) {
                }
            }
        });
    }

    public static void f(Context context, String str) {
        f(context, str, chat.ola.vn.e.c, null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void f(Context context, String str, int i2, a aVar) {
        a(context, str, i2, (i2 * 9) / 16, new AnonymousClass12(context, aVar));
    }

    private static void f(Context context, String str, final a aVar) {
        a(context, str, chat.ola.vn.e.c, chat.ola.vn.e.d, new b() { // from class: chat.ola.vn.activity.OlaCropImageActivity.4
            @Override // chat.ola.vn.activity.OlaCropImageActivity.b
            public void a(String str2) {
                try {
                    if (aVar != null) {
                        aVar.f(str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    public static void g(Context context, String str) {
        d(context, str, C(), (a) null);
    }

    public static void h(Context context, String str) {
        e(context, str, C(), (a) null);
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i2, int i3, Intent intent) {
        try {
            if (i3 == -1) {
                if (i2 == 1) {
                    B();
                    return;
                }
                if (i2 == 2) {
                    try {
                        Uri data = intent.getData();
                        if (data == null) {
                            finish();
                            return;
                        }
                        h = Uri.fromFile(com.mg.ola.common.d.c.a(this, data, new File(d.m(), ".crop." + System.currentTimeMillis() + ".tmp").getAbsolutePath()));
                        B();
                        return;
                    } catch (Throwable unused) {
                    }
                } else {
                    if (i2 != 3) {
                        return;
                    }
                    try {
                        String stringExtra = intent.getStringExtra("outputPath");
                        File file = !m.a(stringExtra) ? new File(stringExtra) : new File(h.getPath());
                        if (j != null) {
                            j.a(file.getAbsolutePath());
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            }
            finish();
        } catch (Throwable unused2) {
            finish();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_crop_photo_layout);
        if (i) {
            i = false;
            if (h != null) {
                B();
            }
            switch (e) {
                case 1:
                    Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
                    File file = new File(d.a(System.currentTimeMillis()));
                    if (file.exists()) {
                        file.delete();
                    }
                    h = Uri.fromFile(file);
                    intent.putExtra("output", h);
                    intent.putExtra("return-data", true);
                    startActivityForResult(intent, 1);
                    break;
                case 2:
                    Intent intent2 = new Intent();
                    intent2.setType("image/*");
                    intent2.setAction("android.intent.action.GET_CONTENT");
                    startActivityForResult(Intent.createChooser(intent2, getString(R.string.string_select_photo)), 2);
                    break;
            }
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
    }
}
