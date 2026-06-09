package com.mg.ola.common.d;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;

/* JADX INFO: loaded from: classes2.dex */
public class f {
    public static int a(BitmapFactory.Options options, int i, int i2) {
        float f;
        float f2;
        int i3 = options.outHeight;
        int i4 = options.outWidth;
        if (i3 <= i2 && i4 <= i) {
            return 1;
        }
        if (i4 > i3) {
            f = i3;
            f2 = i2;
        } else {
            f = i4;
            f2 = i;
        }
        int iRound = Math.round(f / f2);
        while ((i4 * i3) / (iRound * iRound) > i * i2 * 2) {
            iRound++;
        }
        return iRound;
    }

    public static Bitmap a(Bitmap bitmap, int i) {
        if (i != 0 && bitmap != null) {
            Matrix matrix = new Matrix();
            matrix.setRotate(i, bitmap.getWidth() / 2.0f, bitmap.getHeight() / 2.0f);
            try {
                Bitmap bitmapCreateBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
                if (bitmapCreateBitmap != null) {
                    bitmap.recycle();
                    return bitmapCreateBitmap;
                }
            } catch (OutOfMemoryError unused) {
            }
        }
        return bitmap;
    }

    /* JADX WARN: Removed duplicated region for block: B:26:0x009b  */
    /* JADX WARN: Removed duplicated region for block: B:27:0x00ac  */
    /* JADX WARN: Removed duplicated region for block: B:30:0x00c9  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static android.graphics.Bitmap a(android.graphics.Matrix r13, android.graphics.Bitmap r14, int r15, int r16, boolean r17) {
        /*
            Method dump skipped, instruction units count: 205
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.mg.ola.common.d.f.a(android.graphics.Matrix, android.graphics.Bitmap, int, int, boolean):android.graphics.Bitmap");
    }

    public static Bitmap a(String str, int i, int i2) {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(str, options);
        options.inSampleSize = a(options, i, i2);
        options.inJustDecodeBounds = false;
        return BitmapFactory.decodeFile(str, options);
    }

    public static int[] a(String str) {
        if (str == null) {
            return null;
        }
        try {
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inJustDecodeBounds = true;
            BitmapFactory.decodeFile(str, options);
            return new int[]{options.outWidth, options.outHeight};
        } catch (Throwable unused) {
            return new int[]{0, 0};
        }
    }
}
