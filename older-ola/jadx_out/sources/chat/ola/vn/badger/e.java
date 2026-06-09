package chat.ola.vn.badger;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.support.v4.internal.view.SupportMenu;
import java.io.ByteArrayOutputStream;

/* JADX INFO: loaded from: classes.dex */
public class e {
    public static Bitmap a(Drawable drawable) {
        Bitmap bitmapCreateBitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), drawable.getOpacity() != -1 ? Bitmap.Config.ARGB_8888 : Bitmap.Config.RGB_565);
        Canvas canvas = new Canvas(bitmapCreateBitmap);
        drawable.setBounds(0, 0, drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight());
        drawable.draw(canvas);
        return bitmapCreateBitmap;
    }

    public static byte[] a(Context context, int i) throws ShortcutBadgeException {
        String strValueOf = String.valueOf(i);
        Bitmap bitmapA = null;
        for (PackageInfo packageInfo : context.getPackageManager().getInstalledPackages(0)) {
            if (context.getPackageName().equals(packageInfo.packageName)) {
                bitmapA = a(packageInfo.applicationInfo.loadIcon(context.getPackageManager()));
            }
        }
        if (bitmapA == null) {
            throw new ShortcutBadgeException("count not load the app Icon");
        }
        if (i == 0) {
            return a(bitmapA);
        }
        float f = context.getResources().getDisplayMetrics().density;
        Bitmap.Config config = bitmapA.getConfig();
        if (config == null) {
            config = Bitmap.Config.ARGB_8888;
        }
        Bitmap bitmapCopy = bitmapA.copy(config, true);
        float width = bitmapCopy.getWidth();
        float height = bitmapCopy.getHeight();
        if (width <= height) {
            width = height;
        }
        float f2 = width / 4.0f;
        float width2 = bitmapCopy.getWidth() - f2;
        Paint paint = new Paint();
        paint.setColor(SupportMenu.CATEGORY_MASK);
        Paint paint2 = new Paint();
        paint2.setColor(-1);
        Canvas canvas = new Canvas(bitmapCopy);
        canvas.drawCircle(width2, f2, f2, paint2);
        canvas.drawCircle(width2, f2, (6.0f * f2) / 7.0f, paint);
        Paint paint3 = new Paint(1);
        paint3.setColor(-1);
        double d = f2;
        int i2 = (int) (0.7d * d);
        if (strValueOf.length() > 1) {
            i2 = (int) (d * 0.5d);
        }
        paint3.setTextSize((int) (i2 * f));
        paint3.setFakeBoldText(true);
        Rect rect = new Rect();
        paint3.getTextBounds(strValueOf, 0, strValueOf.length(), rect);
        float fWidth = rect.width() / 2;
        if (strValueOf.endsWith("1")) {
            fWidth = (float) (((double) fWidth) * 1.25d);
        }
        canvas.drawText(strValueOf, width2 - fWidth, f2 + (rect.height() / 2), paint3);
        return a(bitmapCopy);
    }

    public static byte[] a(Bitmap bitmap) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }
}
