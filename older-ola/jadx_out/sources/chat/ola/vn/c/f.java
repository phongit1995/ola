package chat.ola.vn.c;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.support.v7.widget.helper.ItemTouchHelper;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class f {
    public static long a;
    public static long b;
    public static int c;
    public static int[] d = new int[91];
    private static Rect v;
    private static Integer w;
    private static Integer x;
    String f;
    String g;
    String h;
    String i;
    String j;
    String k;
    String l;
    int m;
    Bitmap q;
    g r;
    List<g> s;
    private int u;
    int e = 0;
    boolean n = false;
    boolean o = false;
    boolean p = false;
    boolean t = false;

    static {
        for (int i = 0; i < d.length; i++) {
            switch (i) {
                case 48:
                    d[i] = -15395563;
                    break;
                case 49:
                    d[i] = -1866345;
                    break;
                case 50:
                    d[i] = -12095047;
                    break;
                case 51:
                    d[i] = -5121877;
                    break;
                case 52:
                    d[i] = -16744851;
                    break;
                case 53:
                    d[i] = -16743220;
                    break;
                case 54:
                    d[i] = -3750202;
                    break;
                case 55:
                    d[i] = -9079435;
                    break;
                case 56:
                    d[i] = -11776948;
                    break;
                case 57:
                    d[i] = -13619152;
                    break;
                default:
                    switch (i) {
                        case 65:
                            d[i] = -13336536;
                            break;
                        case 66:
                            d[i] = -10266063;
                            break;
                        case 67:
                            d[i] = -273261;
                            break;
                        case 68:
                            d[i] = -1044870;
                            break;
                        case 69:
                            d[i] = -6451489;
                            break;
                        case 70:
                            d[i] = -5914161;
                            break;
                        case 71:
                            d[i] = -6037982;
                            break;
                        case 72:
                            d[i] = -4220807;
                            break;
                        case 73:
                            d[i] = -279144;
                            break;
                        case 74:
                            d[i] = -6788916;
                            break;
                        case 75:
                            d[i] = -9325629;
                            break;
                        case 76:
                            d[i] = -11163070;
                            break;
                        case 77:
                            d[i] = -7508137;
                            break;
                        case 78:
                            d[i] = -269312;
                            break;
                        case 79:
                            d[i] = -695277;
                            break;
                        case 80:
                            d[i] = -896115;
                            break;
                        case 81:
                            d[i] = -9841442;
                            break;
                        case 82:
                            d[i] = -13488811;
                            break;
                        case 83:
                            d[i] = -16743220;
                            break;
                        case 84:
                            d[i] = -9613246;
                            break;
                        case 85:
                            d[i] = -11193825;
                            break;
                        case 86:
                            d[i] = -16736962;
                            break;
                        case 87:
                            d[i] = -11706257;
                            break;
                        case 88:
                            d[i] = -6136552;
                            break;
                        case 89:
                            d[i] = -5187669;
                            break;
                        case 90:
                            d[i] = -3626963;
                            break;
                        default:
                            d[i] = -6037982;
                            break;
                    }
                    break;
            }
        }
    }

    public static int a(int i) {
        if (i <= 0) {
            return 1280;
        }
        if (i <= 120) {
            return 120;
        }
        if (i <= 240) {
            return i + (-120) < 240 - i ? 120 : 240;
        }
        if (i <= 320) {
            return i + (-240) < 320 - i ? 240 : 320;
        }
        if (i <= 480) {
            return i + (-320) < 480 - i ? 320 : 480;
        }
        if (i <= 520) {
            return i + (-480) < 520 - i ? 480 : 520;
        }
        if (i <= 720) {
            return i + (-520) < 720 - i ? 520 : 720;
        }
        return 1280;
    }

    private static Bitmap a(Context context, Bitmap bitmap) {
        return bitmap;
    }

    private static Bitmap a(Context context, Bitmap bitmap, boolean z) {
        try {
            Bitmap bitmapB = t.a().b(".covatar..ovatarTubeBorderBitmap");
            if (bitmapB == null) {
                bitmapB = BitmapFactory.decodeResource(context.getResources(), R.drawable.border_tube_avatar);
                t.a().a(".covatar..ovatarTubeBorderBitmap", bitmapB);
            }
            if (bitmapB == null) {
                return bitmap;
            }
            if (w == null) {
                w = Integer.valueOf(bitmapB.getWidth());
                x = Integer.valueOf(bitmapB.getHeight());
            }
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(w.intValue(), x.intValue(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            canvas.drawARGB(0, 0, 0, 0);
            paint.setColor(-12434878);
            canvas.drawBitmap(bitmapB, 0.0f, 0.0f, (Paint) null);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
            if (z) {
                canvas.drawBitmap(bitmap, new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()), new Rect(0, 0, w.intValue() - 0, w.intValue() - 0), paint);
                return bitmapCreateBitmap;
            }
            int iIntValue = (w.intValue() - bitmap.getWidth()) / 2;
            int iIntValue2 = (x.intValue() - bitmap.getHeight()) / 2;
            canvas.drawBitmap(bitmap, new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()), new Rect(iIntValue, iIntValue2, w.intValue() - iIntValue, w.intValue() - iIntValue2), (Paint) null);
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return bitmap;
        }
    }

    public static Bitmap a(Bitmap bitmap) {
        return a(bitmap, true);
    }

    public static Bitmap a(Bitmap bitmap, boolean z) {
        try {
            Context contextA = OlaApplication.a();
            if (!z) {
                return a(contextA, bitmap);
            }
            switch (x.m) {
                case 0:
                    return a(contextA, bitmap);
                case 1:
                    return d(contextA, bitmap);
                case 2:
                    return b(contextA, bitmap);
                case 3:
                    return c(contextA, bitmap);
                default:
                    return bitmap;
            }
        } catch (Throwable unused) {
            return bitmap;
        }
    }

    public static f a(String str) {
        return e(str, 50);
    }

    public static f a(String str, int i, int i2) {
        f fVar = new f();
        fVar.l(str);
        fVar.e(2);
        fVar.d(i);
        fVar.j(str);
        fVar.a(false);
        return fVar;
    }

    public static f a(String str, int i, boolean z) {
        f fVar = new f();
        fVar.j = str;
        fVar.o = !z;
        fVar.d(i);
        fVar.e(6);
        try {
            fVar.j(t.b(str, z));
            fVar.a(true);
            return fVar;
        } catch (Throwable unused) {
            fVar.a(false);
            return fVar;
        }
    }

    public static f a(String str, String str2, int i, int i2, int i3) {
        f fVar = new f();
        fVar.e(7);
        fVar.m(str);
        fVar.n(str2);
        fVar.f(i3);
        fVar.j(".thumb." + str + "x" + str2);
        fVar.d(i);
        fVar.a(true);
        return fVar;
    }

    static String a(String str, int i) {
        return "http://props.kaspee.com/photo/" + str + "-cover-" + i + ".jpg?t=" + System.currentTimeMillis();
    }

    public static void a(Context context, OlaCachedImageView olaCachedImageView, String str, int i, boolean z) {
        try {
            if (chat.ola.vn.util.m.a(str)) {
                olaCachedImageView.setImageResource(i);
            } else if (o(str)) {
                t.a().a(str, olaCachedImageView, i, z);
            } else {
                t.a().a(str, olaCachedImageView, i, context.getResources().getDimensionPixelSize(R.dimen.metric_72dp), z);
            }
        } catch (Throwable unused) {
        }
    }

    public static int b(int i) {
        if (i <= 0) {
            return 1280;
        }
        if (i <= 50) {
            return 50;
        }
        if (i <= 100) {
            return i + (-50) < 100 - i ? 50 : 100;
        }
        if (i > 200) {
            return 1280;
        }
        if (i - 100 < 200 - i) {
            return 100;
        }
        return ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION;
    }

    private static Bitmap b(Context context, Bitmap bitmap) {
        return a(context, bitmap, true);
    }

    private static Bitmap b(Context context, Bitmap bitmap, boolean z) {
        try {
            Bitmap bitmapB = t.a().b(".covatar..ovatarHeartBorderBitmap");
            if (bitmapB == null) {
                bitmapB = BitmapFactory.decodeResource(context.getResources(), R.drawable.border_heart_avatar);
                t.a().a(".covatar..ovatarHeartBorderBitmap", bitmapB);
            }
            if (bitmapB == null) {
                return bitmap;
            }
            if (w == null) {
                w = Integer.valueOf(bitmapB.getWidth());
                x = Integer.valueOf(bitmapB.getHeight());
            }
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(w.intValue(), x.intValue(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            canvas.drawARGB(0, 0, 0, 0);
            paint.setColor(-12434878);
            canvas.drawBitmap(bitmapB, 0.0f, 0.0f, (Paint) null);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
            if (z) {
                canvas.drawBitmap(bitmap, new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()), new Rect(0, 0, w.intValue() - 0, w.intValue() - 0), paint);
                return bitmapCreateBitmap;
            }
            int iIntValue = (w.intValue() - bitmap.getWidth()) / 2;
            int iIntValue2 = (x.intValue() - bitmap.getHeight()) / 2;
            canvas.drawBitmap(bitmap, new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()), new Rect(iIntValue, iIntValue2, w.intValue() - iIntValue, w.intValue() - iIntValue2), (Paint) null);
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return bitmap;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x0018 A[Catch: Throwable -> 0x001d, TRY_LEAVE, TryCatch #0 {Throwable -> 0x001d, blocks: (B:4:0x0003, B:5:0x0005, B:7:0x0009, B:8:0x000e, B:9:0x0013, B:10:0x0018), top: B:17:0x0003 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static android.graphics.Bitmap b(java.lang.String r2, int r3, boolean r4) {
        /*
            r0 = 0
            if (r4 == 0) goto L18
            byte r1 = chat.ola.vn.c.x.m     // Catch: java.lang.Throwable -> L1d
            switch(r1) {
                case 0: goto L18;
                case 1: goto L13;
                case 2: goto Le;
                case 3: goto L9;
                default: goto L8;
            }     // Catch: java.lang.Throwable -> L1d
        L8:
            goto L1d
        L9:
            android.graphics.Bitmap r2 = n(r2, r3)     // Catch: java.lang.Throwable -> L1d
            goto L1c
        Le:
            android.graphics.Bitmap r2 = m(r2, r3)     // Catch: java.lang.Throwable -> L1d
            goto L1c
        L13:
            android.graphics.Bitmap r2 = l(r2, r3)     // Catch: java.lang.Throwable -> L1d
            goto L1c
        L18:
            android.graphics.Bitmap r2 = k(r2, r3)     // Catch: java.lang.Throwable -> L1d
        L1c:
            r0 = r2
        L1d:
            if (r0 == 0) goto L20
            return r0
        L20:
            android.content.Context r2 = chat.ola.vn.OlaApplication.a()
            android.content.res.Resources r2 = r2.getResources()
            r3 = 2131232421(0x7f0806a5, float:1.808095E38)
            android.graphics.Bitmap r2 = android.graphics.BitmapFactory.decodeResource(r2, r3)
            android.graphics.Bitmap r2 = a(r2, r4)
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.c.f.b(java.lang.String, int, boolean):android.graphics.Bitmap");
    }

    public static f b(String str) {
        return e(str, 100);
    }

    static String b(String str, int i) {
        return "http://props.kaspee.com/photo/" + str + "-avatar-" + b(i) + ".jpg?t=" + System.currentTimeMillis();
    }

    public static int c(int i) {
        if (i <= 0) {
            return 1280;
        }
        if (i <= 320) {
            return 320;
        }
        if (i <= 480) {
            return i + (-320) < 480 - i ? 320 : 480;
        }
        if (i <= 720) {
            return i + (-480) < 720 - i ? 480 : 720;
        }
        return 1280;
    }

    private static Bitmap c(Context context, Bitmap bitmap) {
        return b(context, bitmap, true);
    }

    private static Bitmap c(Context context, Bitmap bitmap, boolean z) {
        try {
            if (w == null) {
                Bitmap bitmapB = t.a().b(".covatar..ovatarRoundRectBorderBitmap");
                if (bitmapB != null) {
                    w = Integer.valueOf(bitmapB.getWidth());
                    x = Integer.valueOf(bitmapB.getHeight());
                } else {
                    Bitmap bitmapDecodeResource = BitmapFactory.decodeResource(context.getResources(), R.drawable.border_avatar);
                    w = Integer.valueOf(bitmapDecodeResource.getWidth());
                    x = Integer.valueOf(bitmapDecodeResource.getHeight());
                    t.a().a(".covatar..ovatarRoundRectBorderBitmap", bitmapDecodeResource);
                }
            }
            if (v == null) {
                Drawable drawable = context.getResources().getDrawable(R.drawable.border_avatar);
                v = new Rect();
                drawable.getPadding(v);
                v.right = w.intValue() - v.right;
                v.bottom = x.intValue() - v.bottom;
            }
            int iIntValue = w.intValue() - v.width();
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(w.intValue(), x.intValue(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            canvas.drawARGB(0, 0, 0, 0);
            paint.setColor(-12434878);
            canvas.drawCircle(w.intValue() / 2.0f, w.intValue() / 2.0f, (w.intValue() - iIntValue) / 2, paint);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
            if (z) {
                canvas.drawBitmap(bitmap, new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()), new Rect(iIntValue / 2, iIntValue / 2, w.intValue() - (iIntValue / 2), w.intValue() - (iIntValue / 2)), paint);
                return bitmapCreateBitmap;
            }
            int iIntValue2 = (w.intValue() - bitmap.getWidth()) / 2;
            int iIntValue3 = (x.intValue() - bitmap.getHeight()) / 2;
            canvas.drawBitmap(bitmap, new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight()), new Rect(iIntValue2, iIntValue3, w.intValue() - iIntValue2, w.intValue() - iIntValue3), (Paint) null);
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return bitmap;
        }
    }

    public static f c(String str) {
        return e(str, 0);
    }

    static String c(String str, int i) {
        return "http://props.kaspee.com/clan/photo/" + str + "-avatar-" + a(i) + ".jpg?t=" + System.currentTimeMillis();
    }

    private static Bitmap d(Context context, Bitmap bitmap) {
        return c(context, bitmap, true);
    }

    public static f d(String str) {
        return h(str, 0);
    }

    static String d(String str, int i) {
        return "http://props.kaspee.com/clan/photo/" + str + "-cover-" + a(i) + ".jpg?t=" + System.currentTimeMillis();
    }

    public static f e(String str) {
        return f(str, 0);
    }

    public static f e(String str, int i) {
        int iB = b(i);
        f fVar = new f();
        if (!chat.ola.vn.util.m.a(str)) {
            fVar.k(str);
            fVar.j(".ovatar." + iB + "." + str.toLowerCase(Locale.US));
        }
        fVar.e(1);
        fVar.d(iB);
        fVar.a(true);
        return fVar;
    }

    public static f f(String str) {
        return i(str, 0);
    }

    public static f f(String str, int i) {
        f fVar = new f();
        if (!chat.ola.vn.util.m.a(str)) {
            String strK = chat.ola.vn.util.m.k(str);
            fVar.k(strK);
            fVar.j(".covatar." + i + "." + strK.toLowerCase());
        }
        fVar.e(9);
        fVar.d(i);
        fVar.a(true);
        return fVar;
    }

    public static f g(String str) {
        f fVar = new f();
        fVar.l(str);
        fVar.e(4);
        fVar.j(str);
        fVar.a(false);
        fVar.d(0);
        return fVar;
    }

    public static f g(String str, int i) {
        f fVar = new f();
        fVar.i(str);
        fVar.e(0);
        fVar.d(i);
        fVar.j(str + "_" + fVar.d());
        fVar.a(true);
        return fVar;
    }

    public static f h(String str) {
        f fVar = new f();
        fVar.l(str);
        fVar.e(5);
        fVar.j(str);
        fVar.a(true);
        return fVar;
    }

    public static f h(String str, int i) {
        f fVar = new f();
        fVar.k(str);
        fVar.e(3);
        fVar.j(".cover." + str);
        fVar.d(i);
        fVar.a(true);
        return fVar;
    }

    public static f i(String str, int i) {
        f fVar = new f();
        fVar.k(str);
        fVar.e(10);
        fVar.j(".ccover." + str);
        fVar.d(i);
        fVar.a(true);
        return fVar;
    }

    public static Bitmap j(String str, int i) {
        return b(str, i, true);
    }

    private static Bitmap k(String str, int i) {
        try {
            Context contextA = OlaApplication.a();
            Bitmap bitmapB = t.a().b(".covatar..ovatarRoundRectBorderBitmap");
            if (bitmapB == null) {
                bitmapB = BitmapFactory.decodeResource(contextA.getResources(), R.drawable.border_avatar);
                t.a().a(".covatar..ovatarRoundRectBorderBitmap", bitmapB);
            }
            if (bitmapB == null) {
                return null;
            }
            if (w == null) {
                w = Integer.valueOf(bitmapB.getWidth());
                x = Integer.valueOf(bitmapB.getHeight());
            }
            if (v == null) {
                Drawable drawable = contextA.getResources().getDrawable(R.drawable.border_avatar);
                v = new Rect();
                drawable.getPadding(v);
                v.right = w.intValue() - v.right;
                v.bottom = x.intValue() - v.bottom;
            }
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(bitmapB.getWidth(), bitmapB.getHeight(), bitmapB.getConfig());
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            canvas.drawBitmap(bitmapB, 0.0f, 0.0f, (Paint) null);
            int dimensionPixelSize = contextA.getResources().getDimensionPixelSize(R.dimen.ovatar_size);
            if (!chat.ola.vn.util.m.c(str)) {
                Paint paint = new Paint();
                paint.setAntiAlias(true);
                paint.setColor(i);
                canvas.drawRect(new Rect(0, 0, w.intValue(), x.intValue()), paint);
                paint.setStyle(Paint.Style.FILL);
                paint.setStrokeWidth(3.0f);
                paint.setColor(-1);
                paint.getTextBounds(str, 0, str.length(), new Rect());
                paint.setTextSize(dimensionPixelSize);
                paint.setTextAlign(Paint.Align.CENTER);
                canvas.drawText(str, canvas.getWidth() / 2, (int) ((canvas.getHeight() / 2) - ((paint.descent() + paint.ascent()) / 2.0f)), paint);
            }
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return null;
        }
    }

    private static Bitmap l(String str, int i) {
        try {
            Context contextA = OlaApplication.a();
            if (w == null) {
                Bitmap bitmapB = t.a().b(".covatar..ovatarRoundRectBorderBitmap");
                if (bitmapB != null) {
                    w = Integer.valueOf(bitmapB.getWidth());
                    x = Integer.valueOf(bitmapB.getHeight());
                } else {
                    Bitmap bitmapDecodeResource = BitmapFactory.decodeResource(contextA.getResources(), R.drawable.border_avatar);
                    w = Integer.valueOf(bitmapDecodeResource.getWidth());
                    x = Integer.valueOf(bitmapDecodeResource.getHeight());
                    t.a().a(".covatar..ovatarRoundRectBorderBitmap", bitmapDecodeResource);
                }
            }
            if (v == null) {
                Drawable drawable = contextA.getResources().getDrawable(R.drawable.border_avatar);
                v = new Rect();
                drawable.getPadding(v);
                v.right = w.intValue() - v.right;
                v.bottom = x.intValue() - v.bottom;
            }
            int iIntValue = w.intValue() - v.width();
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(w.intValue(), x.intValue(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            canvas.drawARGB(0, 0, 0, 0);
            paint.setColor(i);
            canvas.drawCircle(w.intValue() / 2.0f, w.intValue() / 2.0f, (w.intValue() - iIntValue) / 2, paint);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
            int dimensionPixelSize = contextA.getResources().getDimensionPixelSize(R.dimen.ovatar_size);
            if (!chat.ola.vn.util.m.c(str)) {
                paint.setAntiAlias(true);
                canvas.drawRect(new Rect(0, 0, w.intValue(), x.intValue()), paint);
                paint.setStyle(Paint.Style.FILL);
                paint.setStrokeWidth(3.0f);
                paint.setColor(-1);
                paint.getTextBounds(str, 0, str.length(), new Rect());
                paint.setTextSize(dimensionPixelSize);
                paint.setTextAlign(Paint.Align.CENTER);
                canvas.drawText(str, canvas.getWidth() / 2, (int) ((canvas.getHeight() / 2) - ((paint.descent() + paint.ascent()) / 2.0f)), paint);
            }
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return null;
        }
    }

    private static Bitmap m(String str, int i) {
        try {
            Context contextA = OlaApplication.a();
            Bitmap bitmapB = t.a().b(".covatar..ovatarTubeBorderBitmap");
            if (bitmapB == null) {
                bitmapB = BitmapFactory.decodeResource(contextA.getResources(), R.drawable.border_tube_avatar);
                t.a().a(".covatar..ovatarTubeBorderBitmap", bitmapB);
            }
            if (bitmapB == null) {
                return null;
            }
            if (w == null) {
                w = Integer.valueOf(bitmapB.getWidth());
                x = Integer.valueOf(bitmapB.getHeight());
            }
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(w.intValue(), x.intValue(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            canvas.drawARGB(0, 0, 0, 0);
            canvas.drawBitmap(bitmapB, 0.0f, 0.0f, (Paint) null);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
            int dimensionPixelSize = contextA.getResources().getDimensionPixelSize(R.dimen.ovatar_size);
            if (!chat.ola.vn.util.m.c(str)) {
                paint.setColor(i);
                canvas.drawRect(new Rect(0, 0, bitmapB.getWidth(), bitmapB.getHeight()), paint);
                paint.setStyle(Paint.Style.FILL);
                paint.setStrokeWidth(3.0f);
                paint.setColor(-1);
                paint.getTextBounds(str, 0, str.length(), new Rect());
                paint.setTextSize(dimensionPixelSize);
                paint.setTextAlign(Paint.Align.CENTER);
                canvas.drawText(str, canvas.getWidth() / 2, (int) ((canvas.getHeight() / 2) - ((paint.descent() + paint.ascent()) / 2.0f)), paint);
            }
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return null;
        }
    }

    private static Bitmap n(String str, int i) {
        try {
            Context contextA = OlaApplication.a();
            Bitmap bitmapB = t.a().b(".covatar..ovatarHeartBorderBitmap");
            if (bitmapB == null) {
                bitmapB = BitmapFactory.decodeResource(contextA.getResources(), R.drawable.border_heart_avatar);
                t.a().a(".covatar..ovatarHeartBorderBitmap", bitmapB);
            }
            if (bitmapB == null) {
                return null;
            }
            if (w == null) {
                w = Integer.valueOf(bitmapB.getWidth());
                x = Integer.valueOf(bitmapB.getHeight());
            }
            Bitmap bitmapCreateBitmap = Bitmap.createBitmap(w.intValue(), x.intValue(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmapCreateBitmap);
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            canvas.drawARGB(0, 0, 0, 0);
            paint.setColor(i);
            canvas.drawBitmap(bitmapB, 0.0f, 0.0f, (Paint) null);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
            int dimensionPixelSize = contextA.getResources().getDimensionPixelSize(R.dimen.ovatar_size);
            if (!chat.ola.vn.util.m.c(str)) {
                paint.setAntiAlias(true);
                canvas.drawRect(new Rect(0, 0, w.intValue(), x.intValue()), paint);
                paint.setStyle(Paint.Style.FILL);
                paint.setStrokeWidth(3.0f);
                paint.setColor(-1);
                paint.getTextBounds(str, 0, str.length(), new Rect());
                paint.setTextSize(dimensionPixelSize);
                paint.setTextAlign(Paint.Align.CENTER);
                canvas.drawText(str, canvas.getWidth() / 2, (int) ((canvas.getHeight() / 2) - ((paint.descent() + paint.ascent()) / 2.0f)), paint);
            }
            return bitmapCreateBitmap;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static boolean o(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                return false;
            }
            String lowerCase = str.toLowerCase();
            if (lowerCase.contains("https://")) {
                return true;
            }
            return lowerCase.contains("http://");
        } catch (Throwable unused) {
            return false;
        }
    }

    public void a(g gVar) {
        this.r = gVar;
    }

    public void a(boolean z) {
        this.n = z;
    }

    public boolean a() {
        return this.p;
    }

    public String b() {
        switch (this.e) {
            case 0:
                return "http://web.kaspee.com/view?c=" + this.f + "&w=" + this.u;
            case 1:
                return b(this.g, this.u);
            case 3:
                return a(this.g, this.u);
            case 9:
                return c(this.g, this.u);
            case 10:
                return d(this.g, this.u);
            default:
                if (chat.ola.vn.util.m.a(this.j)) {
                    return null;
                }
                return this.j;
        }
    }

    public Bitmap c() {
        return this.q;
    }

    public int d() {
        return this.u;
    }

    public void d(int i) {
        this.u = a(i);
    }

    public String e() {
        return chat.ola.vn.util.m.a(this.h) ? this.f : this.h;
    }

    public void e(int i) {
        this.e = i;
    }

    public String f() {
        return this.g;
    }

    public void f(int i) {
        this.m = i;
    }

    public String g() {
        return this.i;
    }

    public String h() {
        return this.j;
    }

    public void i(String str) {
        this.f = str;
    }

    public void j(String str) {
        this.h = str;
    }

    public void k(String str) {
        this.g = str;
    }

    public void l(String str) {
        this.i = str;
    }

    public void m(String str) {
        this.k = str;
    }

    public void n(String str) {
        this.l = str;
    }
}
