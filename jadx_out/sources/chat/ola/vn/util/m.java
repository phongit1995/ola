package chat.ola.vn.util;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Base64;
import android.util.Patterns;
import chat.ola.vn.R;
import com.facebook.appevents.AppEventsConstants;
import java.net.URL;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class m {
    private static String d = "áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴĐ";
    private static String e = "aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyydAAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD";
    static final Pattern a = Pattern.compile("[a-z][a-z0-9._]*[a-z0-9]");
    private static SecureRandom f = new SecureRandom();
    public static Date b = new Date();
    public static Calendar c = Calendar.getInstance();

    private static int a(CharSequence charSequence, CharSequence charSequence2) {
        int iIndexOf = 0;
        int i = 0;
        while (iIndexOf != -1) {
            try {
                iIndexOf = charSequence.toString().indexOf(charSequence2.toString(), iIndexOf);
                if (iIndexOf != -1) {
                    i++;
                    iIndexOf += charSequence2.length();
                }
            } catch (Throwable unused) {
                return 0;
            }
        }
        return i;
    }

    public static String a(int i) {
        return a(9, i);
    }

    public static String a(int i, int i2) {
        if (i2 <= 0 || i2 <= i) {
            return "" + i2;
        }
        return i + "+";
    }

    public static String a(long j) {
        return a(j, ",");
    }

    public static String a(long j, String str) {
        StringBuilder sb;
        StringBuilder sb2;
        String str2;
        if (j < 1000) {
            sb = new StringBuilder();
            sb.append(j);
            sb.append("");
        } else {
            String string = "";
            while (j >= 1000) {
                long j2 = j % 1000;
                if (j2 < 10) {
                    sb2 = new StringBuilder();
                    sb2.append(str);
                    str2 = "00";
                } else if (j2 < 100) {
                    sb2 = new StringBuilder();
                    sb2.append(str);
                    str2 = AppEventsConstants.EVENT_PARAM_VALUE_NO;
                } else {
                    sb2 = new StringBuilder();
                    sb2.append(str);
                    sb2.append(j2);
                    sb2.append(string);
                    string = sb2.toString();
                    j /= 1000;
                }
                sb2.append(str2);
                sb2.append(j2);
                sb2.append(string);
                string = sb2.toString();
                j /= 1000;
            }
            sb = new StringBuilder();
            sb.append(j);
            sb.append(string);
        }
        return sb.toString();
    }

    public static final String a(Context context, int i) {
        try {
            switch (i) {
                case 0:
                    return context.getString(R.string.message_clan_privacy_free_post);
                case 1:
                    return context.getString(R.string.message_clan_privacy_free_join);
                case 2:
                    return context.getString(R.string.message_clan_privacy_verified_post);
                case 3:
                    return context.getString(R.string.message_clan_privacy_close);
                case 4:
                    return context.getString(R.string.message_clan_privacy_verified_view_and_post);
                default:
                    return "";
            }
        } catch (Throwable unused) {
            return "";
        }
    }

    public static String a(String str, int i, int i2) {
        if (str == null) {
            return null;
        }
        if (i2 < 0 || i > str.length()) {
            return "";
        }
        if (i < 0) {
            i = 0;
        }
        int i3 = i2 + i;
        return str.length() <= i3 ? str.substring(i) : str.substring(i, i3);
    }

    public static String a(String str, short s) {
        try {
            if (s == 2 || s == 4) {
                if (a(str)) {
                    return null;
                }
                return str.trim().replaceAll("^[@]+", "");
            }
            if (a(str)) {
                return null;
            }
            return str.toLowerCase().trim().replaceAll("^[@]+", "");
        } catch (Throwable unused) {
            return str;
        }
    }

    public static String a(byte[] bArr) {
        if (bArr == null) {
            return null;
        }
        return a(bArr, 0, bArr.length);
    }

    public static String a(byte[] bArr, int i, int i2) {
        return a(bArr, i, i2, (String) null);
    }

    public static String a(byte[] bArr, int i, int i2, String str) {
        if (bArr == null) {
            return null;
        }
        if (i2 <= 0) {
            return "";
        }
        if (str != null) {
            try {
                return new String(bArr, i, i2, str);
            } catch (Throwable unused) {
            }
        }
        return new String(bArr, i, i2);
    }

    public static boolean a(CharSequence charSequence) {
        return a(charSequence, 6);
    }

    public static boolean a(CharSequence charSequence, int i) {
        if (charSequence != null) {
            try {
                if (!a(charSequence.toString()) && a.matcher(charSequence).matches() && a((CharSequence) charSequence.toString(), (CharSequence) ".") <= 1 && charSequence.toString().replace(".", "_").indexOf("__") <= -1) {
                    return charSequence.length() >= i;
                }
                return false;
            } catch (Exception unused) {
            }
        }
        return false;
    }

    public static boolean a(String str) {
        String strTrim;
        return str == null || (strTrim = str.trim()) == null || strTrim.length() == 0;
    }

    public static boolean a(String str, String str2) {
        return ((str == null && str2 == null) || str == null || str2 == null || !str.equals(str2)) ? false : true;
    }

    public static String[] a(String str, String str2, int i, boolean z) {
        if (i == 0 || str == null) {
            return null;
        }
        if (str2 == null) {
            return new String[]{str};
        }
        ArrayList arrayList = new ArrayList();
        int length = str2.length();
        int iIndexOf = z ? str.toLowerCase().indexOf(str2.toLowerCase()) : str.indexOf(str2);
        if (iIndexOf < 0) {
            return new String[]{str};
        }
        while (iIndexOf >= 0) {
            if (i == 1) {
                if (!c(str)) {
                    arrayList.add(str);
                }
                return a(arrayList);
            }
            if (iIndexOf > 0) {
                arrayList.add(str.substring(0, iIndexOf));
                if (i > 0) {
                    i--;
                }
            }
            str = str.substring(iIndexOf + length);
            iIndexOf = z ? str.toLowerCase().indexOf(str2.toLowerCase()) : str.indexOf(str2);
        }
        if (!a(str)) {
            arrayList.add(str);
        }
        return a(arrayList);
    }

    public static String[] a(List<String> list) {
        if (list == null || list.size() == 0) {
            return null;
        }
        int size = list.size();
        String[] strArr = new String[size];
        for (int i = 0; i < size; i++) {
            strArr[i] = list.get(i);
        }
        return strArr;
    }

    public static String b(String str) {
        if (str == null) {
            return null;
        }
        return str.trim();
    }

    public static boolean b(CharSequence charSequence) {
        try {
            return a(charSequence.toString());
        } catch (Throwable unused) {
            return true;
        }
    }

    public static boolean b(String str, String str2) {
        return ((str == null && str2 == null) || str == null || str2 == null || !str.equalsIgnoreCase(str2)) ? false : true;
    }

    public static boolean c(CharSequence charSequence) {
        try {
            return c(charSequence.toString());
        } catch (Throwable unused) {
            return true;
        }
    }

    public static boolean c(String str) {
        return str == null || str.length() == 0;
    }

    public static boolean c(String str, String str2) {
        if (str == null && str2 == null) {
            return true;
        }
        return (str == null || str2 == null || !str.equals(str2)) ? false : true;
    }

    public static boolean d(String str, String str2) {
        if (str == null && str2 == null) {
            return true;
        }
        return (str == null || str2 == null || !str.equalsIgnoreCase(str2)) ? false : true;
    }

    public static byte[] d(String str) {
        return f(str, null);
    }

    public static String e(String str) {
        try {
            URL url = new URL(str);
            String lowerCase = url.getHost().toLowerCase();
            if (!lowerCase.equals("youtube.com") && !lowerCase.equals("youtu.be") && !lowerCase.endsWith(".youtube.com") && !lowerCase.endsWith(".youtu.be")) {
                return null;
            }
            String str2 = str + "&";
            int iIndexOf = str2.indexOf("v=");
            if (iIndexOf > -1) {
                int i = iIndexOf + 2;
                String strSubstring = str2.substring(i, str2.indexOf("&", i));
                if (a(strSubstring)) {
                    return null;
                }
                return strSubstring;
            }
            String path = url.getPath();
            if (a(path)) {
                return null;
            }
            String[] strArrSplit = path.split("/");
            if (strArrSplit.length > 1) {
                return strArrSplit[strArrSplit.length - 1];
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String[] e(String str, String str2) {
        return a(str, str2, -1, false);
    }

    public static String f(String str) {
        try {
            if (!b(new URL(str).getHost().toLowerCase(), "play.google.com")) {
                return null;
            }
            String str2 = str + "&";
            int iIndexOf = str2.indexOf("id=");
            if (iIndexOf <= 0) {
                return null;
            }
            int i = iIndexOf + 3;
            String strSubstring = str2.substring(i, str2.indexOf("&", i));
            if (a(strSubstring)) {
                return null;
            }
            return strSubstring;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static byte[] f(String str, String str2) {
        if (c(str)) {
            return null;
        }
        return str2 == null ? str.getBytes() : str.getBytes(str2);
    }

    public static String g(String str) {
        try {
            URL url = new URL(str);
            if (!url.getHost().toLowerCase().equals("mall.ola.vn")) {
                return null;
            }
            try {
                String str2 = str + "&";
                int iIndexOf = str2.indexOf("id=");
                if (iIndexOf > -1) {
                    int i = iIndexOf + 3;
                    String strSubstring = str2.substring(i, str2.indexOf("&", i));
                    return !a(strSubstring) ? strSubstring : "";
                }
                String path = url.getPath();
                if (a(path)) {
                    return "";
                }
                return path.split("/")[r3.length - 1];
            } catch (Throwable unused) {
                return "";
            }
        } catch (Throwable unused2) {
            return null;
        }
    }

    public static String g(String str, String str2) {
        while (str2.startsWith(AppEventsConstants.EVENT_PARAM_VALUE_NO)) {
            try {
                str2 = str2.substring(1);
            } catch (Throwable unused) {
                return null;
            }
        }
        if (str2.startsWith("+") || a(str)) {
            return str2;
        }
        return str + str2;
    }

    public static String h(String str) {
        if (str == null) {
            return null;
        }
        int length = str.length();
        char[] cArr = new char[length];
        for (int i = 0; i < length; i++) {
            int iIndexOf = d.indexOf(str.charAt(i));
            if (iIndexOf > -1) {
                cArr[i] = e.charAt(iIndexOf);
            } else {
                cArr[i] = str.charAt(i);
            }
        }
        return new String(cArr);
    }

    public static String i(String str) {
        try {
            String[] strArrSplit = new URL(str).getPath().split("/");
            int i = 0;
            String str2 = strArrSplit[0];
            while (a(str2)) {
                i++;
                try {
                    str2 = strArrSplit[i];
                } catch (Throwable unused) {
                }
            }
            if (b("html", str2) || b("json", str2)) {
                return strArrSplit[i + 1];
            }
            return null;
        } catch (Throwable unused2) {
            return null;
        }
    }

    public static String j(String str) {
        return a(str, (short) 0);
    }

    public static String k(String str) {
        try {
            if (a(str)) {
                return null;
            }
            return str.toLowerCase().trim().replaceAll("^[#]+", "");
        } catch (Throwable unused) {
            return str;
        }
    }

    public static String l(String str) {
        try {
            if (a(str)) {
                return null;
            }
            if (!str.toLowerCase().startsWith("rss://")) {
                return str;
            }
            if (str.length() > 6) {
                return str.substring(6);
            }
            return null;
        } catch (Throwable unused) {
            return str;
        }
    }

    public static String m(String str) {
        return d(str, "8055") ? "1,000 VNĐ" : d(str, "8155") ? "1,500 VNĐ" : d(str, "8255") ? "2,000 VNĐ" : d(str, "8355") ? "3,000 VNĐ" : d(str, "8455") ? "4,000 VNĐ" : d(str, "8555") ? "5,000 VNĐ" : d(str, "8655") ? "10,000 VNĐ" : d(str, "8755") ? "15,000 VNĐ" : "";
    }

    public static boolean n(String str) {
        try {
            if (a(chat.ola.vn.h.e) || a(str)) {
                return false;
            }
            return Pattern.compile(chat.ola.vn.h.e, 66).matcher(str).find();
        } catch (Throwable unused) {
            return false;
        }
    }

    public static boolean o(String str) {
        try {
            if (a(str)) {
                return false;
            }
            return str.toLowerCase().contains(chat.ola.vn.h.b().toLowerCase());
        } catch (Throwable unused) {
            return false;
        }
    }

    public static String p(String str) {
        try {
            return Base64.encodeToString(str.getBytes("UTF-8"), 10);
        } catch (Throwable unused) {
            return Base64.encodeToString(str.getBytes(), 10);
        }
    }

    public static String q(String str) {
        try {
            return Base64.encodeToString(str.getBytes("UTF-8"), 11);
        } catch (Throwable unused) {
            return Base64.encodeToString(str.getBytes(), 11);
        }
    }

    public static String r(String str) {
        char cCharAt;
        StringBuilder sb;
        String str2;
        StringBuilder sb2;
        char cCharAt2;
        try {
            String lowerCase = h(str).toLowerCase();
            int length = lowerCase.length();
            String strSubstring = "";
            boolean z = false;
            for (int i = 0; i < length; i++) {
                char cCharAt3 = lowerCase.charAt(i);
                if ((cCharAt3 < 'a' || cCharAt3 > 'z') && ((cCharAt3 < 'A' || cCharAt3 > 'Z') && (cCharAt3 < '0' || cCharAt3 > '9'))) {
                    if (cCharAt3 != '.' || z) {
                        if (cCharAt3 == '_') {
                            if (strSubstring.length() > 0 && (cCharAt2 = strSubstring.charAt(strSubstring.length() - 1)) != '.' && cCharAt2 != '_') {
                                sb = new StringBuilder();
                                sb.append(strSubstring);
                                sb.append(cCharAt3);
                                str2 = "";
                            }
                        } else if (z) {
                            if (strSubstring.length() > 0 && (cCharAt = strSubstring.charAt(strSubstring.length() - 1)) != '.' && cCharAt != '_') {
                                sb = new StringBuilder();
                                sb.append(strSubstring);
                                str2 = "_";
                            }
                        } else if (strSubstring.length() > 0) {
                            sb2 = new StringBuilder();
                            sb2.append(strSubstring);
                            sb2.append(".");
                            strSubstring = sb2.toString();
                            z = true;
                        }
                    } else if (strSubstring.length() > 0) {
                        sb2 = new StringBuilder();
                        sb2.append(strSubstring);
                        sb2.append(cCharAt3);
                        sb2.append("");
                        strSubstring = sb2.toString();
                        z = true;
                    }
                } else {
                    sb = new StringBuilder();
                    sb.append(strSubstring);
                    sb.append(cCharAt3);
                    str2 = "";
                }
                sb.append(str2);
                strSubstring = sb.toString();
            }
            while (true) {
                if (strSubstring.charAt(strSubstring.length() - 1) != '.' && strSubstring.charAt(strSubstring.length() - 1) != '_') {
                    return strSubstring;
                }
                strSubstring = strSubstring.substring(0, strSubstring.length() - 1);
            }
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String s(String str) {
        try {
            return str.replace('_', '-');
        } catch (Throwable unused) {
            return str;
        }
    }

    public static boolean t(String str) {
        try {
            Matcher matcher = Patterns.PHONE.matcher(str);
            if (matcher.find() && matcher.start() == 0) {
                return matcher.end() == str.length();
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }
}
