package chat.ola.vn.pickercontacts;

import android.graphics.Bitmap;
import android.util.Patterns;
import android.widget.ImageView;
import chat.ola.vn.c.t;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.regex.Matcher;

/* JADX INFO: loaded from: classes.dex */
public class g {
    public static String a = "";

    public static void a(ImageView imageView, String str) {
        try {
            String strB = b(str);
            int i = chat.ola.vn.c.f.d[strB.charAt(0)];
            String strA = a.a(Character.valueOf(strB.charAt(0)));
            Bitmap bitmapB = t.a().b(strA);
            if (bitmapB == null) {
                bitmapB = chat.ola.vn.c.f.j(strB, i);
                t.a().a(strA, bitmapB);
            }
            imageView.setImageBitmap(bitmapB);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void a(OlaCachedImageView olaCachedImageView, String str, long j) {
        try {
            if (olaCachedImageView.a(j + "")) {
                return;
            }
            Bitmap bitmapB = t.a().b(a.a(j + ""));
            if (bitmapB != null) {
                olaCachedImageView.a(bitmapB, j + "");
                return;
            }
            a(olaCachedImageView, str);
            if (j > 0) {
                new b().execute(new f(olaCachedImageView, j + ""));
            }
        } catch (Throwable unused) {
        }
    }

    public static boolean a(String str) {
        try {
            Matcher matcher = Patterns.PHONE.matcher(str);
            if (matcher.find() && matcher.start() == 0) {
                return matcher.end() == str.length();
            }
            return false;
        } catch (Throwable th) {
            th.printStackTrace();
            return false;
        }
    }

    public static String b(String str) {
        String str2;
        String strH = null;
        try {
            boolean zA = a(str);
            if (!m.c(str)) {
                String strTrim = str.trim();
                if (zA) {
                    str2 = strTrim.charAt(str.length() - 1) + "";
                } else {
                    str2 = strTrim.charAt(0) + "";
                }
                strH = m.h(str2);
            }
            return strH.toUpperCase();
        } catch (Throwable th) {
            th.printStackTrace();
            return strH;
        }
    }
}
