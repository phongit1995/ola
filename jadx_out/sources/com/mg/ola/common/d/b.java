package com.mg.ola.common.d;

import android.media.ExifInterface;

/* JADX INFO: loaded from: classes2.dex */
public class b {
    public static int a(String str) {
        ExifInterface exifInterface = null;
        try {
            exifInterface = new ExifInterface(str);
        } catch (Throwable unused) {
        }
        if (exifInterface == null) {
            return 0;
        }
        try {
            int attributeInt = exifInterface.getAttributeInt("Orientation", -1);
            if (attributeInt == -1) {
                return 0;
            }
            if (attributeInt == 3) {
                return 180;
            }
            if (attributeInt != 6) {
                return attributeInt != 8 ? 0 : 270;
            }
            return 90;
        } catch (Throwable unused2) {
            return 0;
        }
    }
}
