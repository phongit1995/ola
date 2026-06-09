package chat.ola.vn.entity;

import java.util.Calendar;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class i {
    protected long l;
    protected long n;
    protected int o;
    protected int p;
    protected int q;
    protected short r;
    protected boolean t;
    private int w;
    private static final char[] v = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    static final char[] a = {'a', 'b', 'c', 'd', 'L', 'M', 'N', 'e', 'G', 'H', 's', 'y', 'z', 'A', 'n', 'o', 'J', 'K', 'S', 'T', '2', 'f', 'P', '4', '5', 'p', 'q', 'r', '7', '6', 'v', 'w', '0', '8', 'B', 'C', 'g', 'h', 'i', 'Q', 'R', 't', 'u', 'D', 'U', 'V', 'X', 'm', '1', 'E', 'F', 'x', 'Y', 'Z', '3', 'O', 'W', 'I', 'j', 'k', 'l', '9'};
    protected String b = null;
    protected String c = null;
    protected String d = null;
    protected String e = null;
    protected String f = null;
    protected String g = null;
    protected String h = null;
    protected String i = null;
    protected Long j = null;
    protected Long k = null;
    protected char s = 'u';
    protected List<i> u = null;
    protected long m = 0;

    public i() {
        this.t = false;
        this.w = -1;
        this.t = false;
        this.w = -1;
    }

    private static final long a(char[] cArr, String str) {
        long j = 0;
        long length = 1;
        for (int length2 = str.length() - 1; length2 >= 0; length2--) {
            char cCharAt = str.charAt(length2);
            for (int length3 = cArr.length - 1; length3 >= 0; length3--) {
                if (cCharAt == cArr[length3]) {
                    j += ((long) length3) * length;
                }
            }
            length *= (long) cArr.length;
        }
        return j;
    }

    public static String a(i iVar, boolean z) {
        StringBuilder sb;
        String strD;
        switch (iVar.f()) {
            case 1:
                sb = new StringBuilder();
                sb.append("http://web.kaspee.com/view?c=");
                sb.append(iVar.d());
                strD = "&w=0";
                sb.append(strD);
                return sb.toString();
            case 2:
                sb = new StringBuilder();
                break;
            case 3:
                sb = new StringBuilder();
                break;
            default:
                return null;
        }
        sb.append("http://web.kaspee.com/view?c=");
        strD = iVar.d();
        sb.append(strD);
        return sb.toString();
    }

    public static int[] b(String str) {
        int iH = chat.ola.vn.e.c;
        int iH2 = chat.ola.vn.e.c;
        if (e(str) == '4') {
            String strA = chat.ola.vn.util.m.a(str, 7, 2);
            String strA2 = chat.ola.vn.util.m.a(str, 9, 2);
            iH = (int) h(strA);
            iH2 = (int) h(strA2);
        }
        return new int[]{iH, iH2};
    }

    public static Long d(String str) {
        Long lG;
        try {
            char cE = e(str);
            if (cE != '3') {
                if (cE != '4' || (lG = g(str)) == null) {
                    return null;
                }
                return Long.valueOf(lG.longValue() + 1325350800000L);
            }
            String strN = n(str);
            if (strN == null) {
                return null;
            }
            char[] charArray = strN.toCharArray();
            if (charArray.length != 6) {
                return null;
            }
            Calendar calendar = Calendar.getInstance();
            int i = 0;
            int i2 = 0;
            int i3 = 0;
            for (int i4 = 0; i4 < v.length; i4++) {
                if (charArray[0] == v[i4]) {
                    calendar.set(11, i4);
                    i++;
                }
                if (charArray[1] == v[i4]) {
                    calendar.set(12, i4);
                    i++;
                }
                if (charArray[2] == v[i4]) {
                    calendar.set(5, i4);
                    i++;
                }
                if (charArray[3] == v[i4]) {
                    calendar.set(2, i4 - 1);
                    i++;
                }
                if (charArray[4] == v[i4]) {
                    i++;
                    i3 = i4;
                }
                if (charArray[5] == v[i4]) {
                    i++;
                    i2 = i4;
                }
                if (i == 6) {
                    break;
                }
            }
            calendar.set(1, (i3 * 62) + i2);
            return Long.valueOf(calendar.getTimeInMillis());
        } catch (Throwable unused) {
            return null;
        }
    }

    public static final char e(String str) {
        return str.charAt(0);
    }

    public static final String f(String str) {
        if (e(str) == '4') {
            return str.substring(13);
        }
        return null;
    }

    public static final Long g(String str) {
        String strF;
        if (e(str) != '4' || (strF = f(str)) == null) {
            return null;
        }
        return Long.valueOf(h(strF) / 10);
    }

    public static final long h(String str) {
        return a(a, str);
    }

    public static char i(String str) {
        try {
            char cCharAt = str.charAt(1);
            if (cCharAt == 'F') {
                return (char) 4;
            }
            if (cCharAt == 'P') {
                return (char) 1;
            }
            if (cCharAt != 'S') {
                return cCharAt != 'V' ? (char) 0 : (char) 2;
            }
            return (char) 3;
        } catch (Throwable unused) {
            return (char) 0;
        }
    }

    public static String k(String str) {
        return "http://web.kaspee.com/view?c=" + str + "&w=1280";
    }

    public static String l(String str) {
        return "http://web.kaspee.com/view?c=" + str;
    }

    private static String n(String str) {
        if (str.charAt(0) >= '3') {
            return chat.ola.vn.util.m.a(str, 7, 6);
        }
        return null;
    }

    public int a() {
        return this.w;
    }

    public void a(int i) {
        this.w = i;
    }

    public void a(long j) {
        this.l = j;
    }

    public void a(Long l) {
        this.k = l;
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:27:0x0048. Please report as an issue. */
    /* JADX WARN: Removed duplicated region for block: B:39:0x006a A[Catch: Throwable -> 0x0080, TryCatch #1 {Throwable -> 0x0080, blocks: (B:4:0x0004, B:6:0x0009, B:14:0x0023, B:37:0x0061, B:39:0x006a, B:40:0x0072, B:15:0x0026, B:25:0x0040, B:36:0x005b, B:35:0x0059), top: B:45:0x0002 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(java.lang.String r6) {
        /*
            r5 = this;
            r0 = 0
            r1 = 0
            if (r6 != 0) goto L9
            r5.r = r1     // Catch: java.lang.Throwable -> L80
            r5.b = r0     // Catch: java.lang.Throwable -> L80
            return
        L9:
            r5.b = r6     // Catch: java.lang.Throwable -> L80
            java.lang.String r6 = r5.b     // Catch: java.lang.Throwable -> L80
            r2 = 1
            char r6 = r6.charAt(r2)     // Catch: java.lang.Throwable -> L80
            r3 = 70
            if (r6 == r3) goto L58
            r3 = 80
            if (r6 == r3) goto L5b
            r3 = 83
            r4 = 2
            if (r6 == r3) goto L3f
            r3 = 86
            if (r6 == r3) goto L26
            r5.r = r1     // Catch: java.lang.Throwable -> L80
            goto L61
        L26:
            r5.r = r4     // Catch: java.lang.Throwable -> L80
            java.lang.String r6 = r5.b     // Catch: java.lang.Throwable -> L61
            char r6 = r6.charAt(r4)     // Catch: java.lang.Throwable -> L61
            switch(r6) {
                case 109: goto L3c;
                case 110: goto L39;
                case 111: goto L31;
                case 112: goto L34;
                default: goto L31;
            }     // Catch: java.lang.Throwable -> L61
        L31:
            r5.h = r0     // Catch: java.lang.Throwable -> L61
            goto L61
        L34:
            java.lang.String r6 = "avi"
        L36:
            r5.h = r6     // Catch: java.lang.Throwable -> L61
            goto L61
        L39:
            java.lang.String r6 = "mp4"
            goto L36
        L3c:
            java.lang.String r6 = "3gp"
            goto L36
        L3f:
            r6 = 3
            r5.r = r6     // Catch: java.lang.Throwable -> L80
            java.lang.String r6 = r5.b     // Catch: java.lang.Throwable -> L61
            char r6 = r6.charAt(r4)     // Catch: java.lang.Throwable -> L61
            switch(r6) {
                case 97: goto L55;
                case 98: goto L52;
                case 99: goto L4f;
                case 100: goto L4c;
                default: goto L4b;
            }     // Catch: java.lang.Throwable -> L61
        L4b:
            goto L31
        L4c:
            java.lang.String r6 = "mp3"
            goto L36
        L4f:
            java.lang.String r6 = "wav"
            goto L36
        L52:
            java.lang.String r6 = "mid"
            goto L36
        L55:
            java.lang.String r6 = "amr"
            goto L36
        L58:
            r6 = 4
            r5.r = r6     // Catch: java.lang.Throwable -> L80
        L5b:
            r5.r = r2     // Catch: java.lang.Throwable -> L80
            java.lang.String r6 = "jpg"
            r5.h = r6     // Catch: java.lang.Throwable -> L80
        L61:
            java.lang.String r6 = r5.b     // Catch: java.lang.Throwable -> L80
            int r6 = r6.length()     // Catch: java.lang.Throwable -> L80
            r0 = 6
            if (r6 <= r0) goto L72
            java.lang.String r6 = r5.b     // Catch: java.lang.Throwable -> L80
            char r6 = r6.charAt(r0)     // Catch: java.lang.Throwable -> L80
            r5.s = r6     // Catch: java.lang.Throwable -> L80
        L72:
            java.lang.String r6 = r5.b     // Catch: java.lang.Throwable -> L80
            int[] r6 = b(r6)     // Catch: java.lang.Throwable -> L80
            r0 = r6[r1]     // Catch: java.lang.Throwable -> L80
            r5.p = r0     // Catch: java.lang.Throwable -> L80
            r6 = r6[r2]     // Catch: java.lang.Throwable -> L80
            r5.q = r6     // Catch: java.lang.Throwable -> L80
        L80:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entity.i.a(java.lang.String):void");
    }

    public void a(List<i> list) {
        this.u = list;
    }

    public void a(short s) {
        this.r = s;
    }

    public void b(int i) {
        this.o = i;
    }

    public void b(long j) {
        this.n = j;
    }

    public boolean b() {
        return this.w >= 0;
    }

    public long c() {
        return this.l;
    }

    public void c(String str) {
        this.e = str;
    }

    public String d() {
        return this.b;
    }

    public char e() {
        return this.s;
    }

    public short f() {
        return this.r;
    }

    public Long g() {
        if (this.k == null && this.b != null) {
            this.k = d(this.b);
        }
        return this.k;
    }

    public String h() {
        return this.g;
    }

    public String i() {
        return this.h;
    }

    public String j() {
        return this.c;
    }

    public void j(String str) {
        this.g = str;
    }

    public List<i> k() {
        return this.u;
    }

    public long l() {
        return this.n;
    }

    public String m() {
        return this.i;
    }

    public void m(String str) {
        this.i = str;
    }
}
