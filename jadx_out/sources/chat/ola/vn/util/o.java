package chat.ola.vn.util;

import android.annotation.SuppressLint;
import android.content.ClipData;
import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.support.v4.app.NotificationCompat;
import android.text.ClipboardManager;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.webkit.MimeTypeMap;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.w.bq;
import chat.ola.vn.w.s;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.share.internal.MessengerShareContentUtility;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"NewApi", "DefaultLocale"})
public class o {
    public static int a(Bitmap bitmap) {
        if (bitmap == null) {
            return 0;
        }
        return Build.VERSION.SDK_INT < 12 ? bitmap.getRowBytes() * bitmap.getHeight() : bitmap.getByteCount();
    }

    private static int a(InputStream inputStream, byte[] bArr) throws IOException {
        int i = 0;
        while (i < bArr.length) {
            int i2 = inputStream.read(bArr, i, bArr.length - i);
            if (i2 < 0) {
                return -1;
            }
            i += i2;
        }
        return i;
    }

    public static s a(InputStream inputStream) {
        byte[] bArr;
        try {
            s sVar = new s();
            ArrayList arrayList = new ArrayList();
            while (true) {
                byte[] bArr2 = new byte[5];
                if (a(inputStream, bArr2) <= 0) {
                    break;
                }
                try {
                    short sA = (short) e.a(bArr2[0]);
                    int iA = e.a(bArr2[1], bArr2[2], bArr2[3], bArr2[4]);
                    if (iA > 0) {
                        bArr = new byte[iA];
                        if (a(inputStream, bArr) < 0) {
                            break;
                        }
                    } else {
                        bArr = null;
                    }
                    bq bqVar = new bq();
                    bqVar.a = sA;
                    bqVar.b = bArr;
                    arrayList.add(bqVar);
                } catch (Throwable unused) {
                }
            }
            sVar.c = (bq[]) arrayList.toArray(new bq[0]);
            return sVar;
        } catch (Throwable unused2) {
            return null;
        }
    }

    public static String a(long j) {
        return String.format("%,d", Long.valueOf(j));
    }

    public static String a(ContentResolver contentResolver, Uri uri) {
        if (contentResolver == null || uri == null) {
            return null;
        }
        if (uri.getScheme().startsWith("file")) {
            return uri.getPath();
        }
        Cursor cursorQuery = contentResolver.query(uri, new String[]{"_data"}, null, null, null);
        if (cursorQuery == null || !cursorQuery.moveToFirst()) {
            return null;
        }
        return cursorQuery.getString(0);
    }

    @SuppressLint({"NewApi", "ServiceCast"})
    public static String a(Context context) {
        try {
            if (!com.mg.ola.common.d.g.c()) {
                return ((ClipboardManager) context.getSystemService("clipboard")).getText().toString();
            }
            ClipData primaryClip = ((android.content.ClipboardManager) context.getSystemService("clipboard")).getPrimaryClip();
            if (primaryClip != null) {
                return primaryClip.getItemAt(0).getText().toString();
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String a(String str) {
        if (m.a(str)) {
            return null;
        }
        String strC = c(str);
        String strB = b(str);
        if (!m.a(strC) && !m.a(strB)) {
            return "+" + strC + strB;
        }
        if (!str.startsWith("+")) {
            return "+" + str;
        }
        return str;
    }

    public static String a(String str, long j) {
        StringBuilder sb;
        StringBuilder sb2;
        if (!m.a(str)) {
            try {
                String string = "" + j;
                if (string.length() > 4) {
                    string = string.substring(string.length() - 4);
                } else {
                    if (string.length() == 1) {
                        sb = new StringBuilder();
                        sb.append("000");
                    } else if (string.length() == 2) {
                        sb = new StringBuilder();
                        sb.append("00");
                    } else if (string.length() == 3) {
                        sb = new StringBuilder();
                        sb.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                    }
                    sb.append(string);
                    string = sb.toString();
                }
                String strG = com.mg.ola.common.d.d.g(str);
                String strA = com.mg.ola.common.d.d.a(str);
                String strF = com.mg.ola.common.d.d.f(str);
                if (m.c(strA)) {
                    strA = "";
                }
                if (m.c(strF)) {
                    strF = "";
                }
                String str2 = strA + string;
                String strA2 = chat.ola.vn.j.a.a(str2);
                if (!m.c(strA2) && strA2.length() > 4) {
                    String strSubstring = strA2.substring(strA2.length() - 4);
                    if (m.a(strF)) {
                        sb2 = new StringBuilder();
                        sb2.append(str2);
                        sb2.append(strSubstring);
                    } else {
                        sb2 = new StringBuilder();
                        sb2.append(str2);
                        sb2.append(strSubstring);
                        sb2.append(".");
                        sb2.append(strF);
                    }
                    String string2 = sb2.toString();
                    if (m.a(strG)) {
                        return string2;
                    }
                    return strG + string2;
                }
            } catch (Throwable unused) {
            }
        }
        return str;
    }

    public static String a(byte[] bArr) {
        if (bArr == null) {
            return null;
        }
        try {
            return new String(bArr, 0, bArr.length);
        } catch (Throwable unused) {
            return new String(bArr);
        }
    }

    public static String a(byte[] bArr, int i, int i2) {
        if (bArr == null) {
            return null;
        }
        try {
            return new String(bArr, i, i2);
        } catch (Throwable unused) {
            return new String(bArr);
        }
    }

    public static void a(Context context, View view, boolean z) {
        if (context == null || view == null) {
            return;
        }
        try {
            InputMethodManager inputMethodManager = (InputMethodManager) context.getSystemService("input_method");
            if (z) {
                inputMethodManager.showSoftInput(view, 2);
            } else {
                inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str) {
        a(context, str, true);
    }

    @SuppressLint({"NewApi", "ServiceCast"})
    public static void a(Context context, String str, boolean z) {
        try {
            if (com.mg.ola.common.d.g.c()) {
                ((android.content.ClipboardManager) context.getSystemService("clipboard")).setPrimaryClip(ClipData.newPlainText(OlaApplication.a, str));
            } else {
                ((ClipboardManager) context.getSystemService("clipboard")).setText(str);
            }
            if (!z || m.c(str)) {
                return;
            }
            j.b(context, R.string.message_copy_to_clipboard, "\"" + str + "\"");
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r3v13 */
    /* JADX WARN: Type inference failed for: r3v2 */
    /* JADX WARN: Type inference failed for: r3v7 */
    public static chat.ola.vn.entity.d[] a(String str, String str2) {
        chat.ola.vn.entity.d dVar;
        String[] strArrE = m.e(str, "^");
        if (strArrE == null || strArrE.length == 0) {
            return null;
        }
        chat.ola.vn.entity.d[] dVarArr = new chat.ola.vn.entity.d[strArrE.length];
        boolean z = false;
        int i = 0;
        int i2 = 0;
        while (i < strArrE.length) {
            int i3 = 2;
            String[] strArrA = m.a(strArrE[i], "|", 2, z);
            String[] strArrA2 = m.a(strArrA[z ? 1 : 0], ":", 3, z);
            String str3 = strArrA2[z ? 1 : 0];
            String str4 = strArrA2.length == 3 ? strArrA2[1] : null;
            String str5 = strArrA2.length == 3 ? strArrA2[2] : strArrA2[1];
            int iIndexOf = str5.indexOf(32);
            String strSubstring = iIndexOf < 0 ? str5 : str5.substring(iIndexOf + 1);
            String strSubstring2 = iIndexOf <= 0 ? "" : str5.substring(z ? 1 : 0, iIndexOf);
            if (str3.toLowerCase().equals("wap".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("wap");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("webapp".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("webapp");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("viewme".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("viewme");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("like".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("like");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("likeadme".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("likeadme");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("postme".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("postme");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("viewmedia".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("viewmedia");
                chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
                iVar.a(strSubstring);
                dVarArr[i2].a(iVar);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("xt".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("xt");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("app".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("app");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("dpk".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("dpk");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("rss".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("rss");
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("vip".toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d("vip");
                if (strSubstring2 == null || strSubstring2.length() == 0) {
                    strSubstring2 = str2;
                }
                dVarArr[i2].b(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals(NotificationCompat.CATEGORY_CALL.toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d(NotificationCompat.CATEGORY_CALL);
                dVarArr[i2].c(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVar = dVarArr[i2];
            } else if (str3.toLowerCase().equals("sms".toLowerCase()) || str3.toLowerCase().equals(NotificationCompat.CATEGORY_MESSAGE.toLowerCase())) {
                dVarArr[i2] = new chat.ola.vn.entity.d(str3);
                dVarArr[i2].d(strSubstring2);
                dVarArr[i2].e(strSubstring);
                dVarArr[i2].f(str4);
                String[] strArrE2 = m.e(strArrA[1], "#");
                String str6 = strArrE2[z ? 1 : 0];
                if (strArrE2.length > 1) {
                    chat.ola.vn.f.b[] bVarArr = new chat.ola.vn.f.b[strArrE2.length - 1];
                    int i4 = 1;
                    ?? r3 = z;
                    while (i4 < strArrE2.length) {
                        String[] strArrE3 = m.e(strArrE2[i4], "|");
                        String str7 = strArrE3[r3];
                        int i5 = Integer.parseInt(strArrE3[1]);
                        int i6 = i4 - 1;
                        bVarArr[i6] = new chat.ola.vn.f.b();
                        bVarArr[i6].a = i5;
                        bVarArr[i6].b = str7;
                        if (i5 == 10) {
                            if (strArrE3.length > i3) {
                                bVarArr[i6].c = strArrE3[i3];
                            } else {
                                bVarArr[i6].c = str2;
                            }
                        } else if ((i5 == 4 || i5 == 5 || i5 == 6) && strArrE3.length > i3) {
                            String[] strArr = new String[(strArrE3.length - i3) / i3];
                            String[] strArr2 = new String[(strArrE3.length - i3) / i3];
                            int i7 = 0;
                            while (i3 < strArrE3.length) {
                                strArr[i7] = strArrE3[i3];
                                int i8 = i3 + 1;
                                strArr2[i7] = strArrE3[i8];
                                i7++;
                                i3 = i8 + 1;
                            }
                            bVarArr[i6].d = strArr;
                            bVarArr[i6].e = strArr2;
                        }
                        i4++;
                        r3 = 0;
                        i3 = 2;
                    }
                    dVarArr[i2].a(bVarArr);
                }
                dVarArr[i2].g(str6);
                i2++;
                i++;
                z = false;
            } else {
                if (str3.toLowerCase().equals("viewproposalrequest".toLowerCase())) {
                    dVarArr[i2] = new chat.ola.vn.entity.d("viewproposalrequest");
                    dVarArr[i2].b(strSubstring2);
                    dVarArr[i2].e(strSubstring);
                    dVar = dVarArr[i2];
                }
                i++;
                z = false;
            }
            dVar.f(str4);
            i2++;
            i++;
            z = false;
        }
        if (dVarArr == null || i2 >= dVarArr.length) {
            return dVarArr;
        }
        chat.ola.vn.entity.d[] dVarArr2 = new chat.ola.vn.entity.d[i2];
        System.arraycopy(dVarArr, 0, dVarArr2, 0, i2);
        return dVarArr2;
    }

    public static s b(byte[] bArr) {
        s sVarA;
        try {
            sVarA = a(new ByteArrayInputStream(bArr));
        } catch (Throwable unused) {
            sVarA = null;
        }
        return sVarA == null ? new s() : sVarA;
    }

    public static String b(String str) {
        if (str == null) {
            return null;
        }
        try {
            String strC = c(str);
            String strReplace = str.replace("+", "");
            try {
                str = strReplace.replace(" ", "");
                return str.substring(strC.length());
            } catch (Throwable unused) {
                return strReplace;
            }
        } catch (Throwable unused2) {
            return str;
        }
    }

    public static boolean b(String str, long j) {
        if (!m.a(str)) {
            String str2 = "" + j;
            if (str2.length() > 4) {
                str2.substring(str2.length() - 4);
            }
            String strA = com.mg.ola.common.d.d.a(str);
            if (m.c(strA) || strA.length() < 8) {
                return false;
            }
            String strA2 = a(strA.substring(0, strA.length() - 8), j);
            if (!m.a(strA2)) {
                return com.mg.ola.common.d.d.a(str).equals(strA2);
            }
        }
        return false;
    }

    public static boolean b(String str, String str2) {
        if (m.a(str) || m.a(str2)) {
            return false;
        }
        try {
            String strReplace = str.replace(" ", "");
            String strReplace2 = str2.replace(" ", "");
            do {
                if (strReplace.charAt(0) != '+' && strReplace.charAt(0) != '0') {
                    break;
                }
                strReplace = strReplace.substring(1);
            } while (strReplace.length() != 0);
            do {
                if (strReplace2.charAt(0) != '+' && strReplace2.charAt(0) != '0') {
                    break;
                }
                strReplace2 = strReplace2.substring(1);
            } while (strReplace2.length() != 0);
            return strReplace.length() == strReplace2.length() ? strReplace.equals(strReplace2) : strReplace.length() >= strReplace2.length() ? strReplace.endsWith(strReplace2) : strReplace2.endsWith(strReplace);
        } catch (Throwable unused) {
            return false;
        }
    }

    public static String c(String str) {
        if (str == null) {
            return null;
        }
        try {
            if (!str.startsWith("+")) {
                str = "+" + str;
            }
            PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.getInstance();
            String str2 = phoneNumberUtil.format(phoneNumberUtil.parse(str, ""), PhoneNumberUtil.PhoneNumberFormat.INTERNATIONAL);
            return str2.substring(0, str2.indexOf(32)).replace('+', ' ').trim();
        } catch (Throwable unused) {
            return "";
        }
    }

    public static boolean c(String str, String str2) throws Throwable {
        BufferedInputStream bufferedInputStream;
        HttpURLConnection httpURLConnection;
        FileOutputStream fileOutputStream;
        HttpURLConnection httpURLConnection2 = null;
        bufferedInputStream = null;
        BufferedInputStream bufferedInputStream2 = null;
        try {
            httpURLConnection = (HttpURLConnection) new URL(str).openConnection();
        } catch (Throwable th) {
            th = th;
            bufferedInputStream = null;
        }
        try {
            httpURLConnection.setConnectTimeout(5000);
            httpURLConnection.setReadTimeout(15000);
            httpURLConnection.connect();
            fileOutputStream = new FileOutputStream(new File(str2));
            bufferedInputStream = new BufferedInputStream(httpURLConnection.getInputStream());
        } catch (Throwable th2) {
            th = th2;
            try {
                httpURLConnection.disconnect();
            } catch (Throwable unused) {
            }
            try {
                bufferedInputStream2.close();
                throw th;
            } catch (Throwable unused2) {
                throw th;
            }
        }
        try {
            byte[] bArr = new byte[1024];
            while (true) {
                int i = bufferedInputStream.read(bArr);
                if (i <= 0) {
                    break;
                }
                fileOutputStream.write(bArr, 0, i);
            }
            fileOutputStream.close();
            try {
                httpURLConnection.disconnect();
            } catch (Throwable unused3) {
            }
            try {
                bufferedInputStream.close();
            } catch (Throwable unused4) {
            }
            return true;
        } catch (Throwable th3) {
            th = th3;
            httpURLConnection2 = httpURLConnection;
            try {
                th.printStackTrace();
                try {
                    httpURLConnection2.disconnect();
                } catch (Throwable unused5) {
                }
                try {
                    bufferedInputStream.close();
                } catch (Throwable unused6) {
                }
                return false;
            } catch (Throwable th4) {
                th = th4;
                httpURLConnection = httpURLConnection2;
                bufferedInputStream2 = bufferedInputStream;
                httpURLConnection.disconnect();
                bufferedInputStream2.close();
                throw th;
            }
        }
    }

    public static short d(String str) {
        if (m.a(str)) {
            return (short) 0;
        }
        String strE = e(str.toLowerCase());
        if (m.a(strE)) {
            return (short) 0;
        }
        if (strE.toLowerCase().contains(MessengerShareContentUtility.MEDIA_IMAGE)) {
            return (short) 1;
        }
        if (strE.toLowerCase().contains("audio")) {
            return (short) 3;
        }
        return strE.toLowerCase().contains("video") ? (short) 2 : (short) 0;
    }

    public static String e(String str) {
        String strF = com.mg.ola.common.d.d.f(str);
        if (strF != null) {
            return MimeTypeMap.getSingleton().getMimeTypeFromExtension(strF);
        }
        return null;
    }

    public static String f(String str) {
        return com.mg.ola.common.d.d.f(str);
    }

    public static short g(String str) {
        try {
            char cCharAt = str.charAt(1);
            if (cCharAt == 'P') {
                return (short) 1;
            }
            if (cCharAt != 'S') {
                return cCharAt != 'V' ? (short) 0 : (short) 2;
            }
            return (short) 3;
        } catch (Throwable th) {
            th.printStackTrace();
            return (short) 0;
        }
    }
}
