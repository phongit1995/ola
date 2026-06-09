package chat.ola.vn.w;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class s {
    public int a;
    public int b;
    public bq[] c;

    private byte a(byte[] bArr, byte b) {
        return bArr == null ? b : bArr[0];
    }

    private int a(byte[] bArr, int i) {
        return bArr == null ? i : bArr.length == 1 ? chat.ola.vn.util.e.a(bArr[0]) : bArr.length == 2 ? chat.ola.vn.util.e.a(bArr) : bArr.length == 3 ? chat.ola.vn.util.e.b(bArr) : chat.ola.vn.util.e.c(bArr);
    }

    private long a(byte[] bArr, long j) {
        return bArr == null ? j : chat.ola.vn.util.e.d(bArr);
    }

    public static List<chat.ola.vn.message.f> a(s sVar, String str) {
        ArrayList arrayList;
        short sA;
        short sA2;
        short sA3;
        short s = 7;
        int iC = sVar.c((short) 7);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iA = sVar.a((short) 7, 0);
            int i = 0;
            while (i < iC) {
                int iA2 = sVar.a(s, iA);
                String lowerCase = sVar.c(iA).toLowerCase(Locale.US);
                chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(lowerCase, (short) 0);
                String strB = sVar.b((short) 22, iA, iA2);
                sVar.b((short) 86, iA, iA2);
                if (strB != null) {
                    lowerCase = strB;
                }
                fVar.b(lowerCase);
                int i2 = iA;
                long jA = sVar.a((short) 58, i2, iA2, 0L);
                long jA2 = sVar.a((short) 130, i2, iA2, 0L);
                int iA3 = sVar.a((short) 12, iA, iA2);
                if (iA3 >= 0) {
                    sA = sVar.a(iA3, (short) 0);
                    sA2 = sVar.a((short) 45, iA, iA2, (short) 0);
                    sA3 = sVar.a((short) 38, iA, iA2, (short) -1);
                } else {
                    sA = 0;
                    sA2 = 0;
                    sA3 = -1;
                }
                String strB2 = sVar.b((short) 13, iA, iA2);
                String strB3 = sVar.b((short) 86, iA, iA2);
                fVar.e(sA2);
                fVar.f(strB3);
                fVar.c(sA3);
                fVar.b(sA);
                fVar.e(strB2);
                fVar.c(jA);
                if (jA2 > 0) {
                    fVar.N = System.currentTimeMillis() - jA2;
                }
                arrayList.add(fVar);
                i++;
                iA = iA2;
                s = 7;
            }
        } else {
            arrayList = null;
        }
        Collections.sort(arrayList, new chat.ola.vn.e.f());
        return arrayList;
    }

    public byte a(int i, byte b) {
        return a(b(i), b);
    }

    public byte a(int i, short s) {
        return a(i, (byte) s);
    }

    public byte a(short s, int i, int i2, byte b) {
        int iA = a(s, i, i2);
        return iA >= 0 ? a(iA, b) : b;
    }

    public byte a(short s, int i, int i2, short s2) {
        return a(s, i, i2, (byte) s2);
    }

    public int a() {
        if (this.c == null) {
            return 0;
        }
        return this.c.length;
    }

    public int a(int i, int i2) {
        return a(b(i), i2);
    }

    public int a(short s, int i) {
        if (this.c == null) {
            return -1;
        }
        if (i < 0) {
            i = -1;
        } else if (i >= this.c.length) {
            i = this.c.length - 1;
        }
        do {
            i++;
            if (i >= this.c.length) {
                return -1;
            }
        } while (this.c[i].a != s);
        return i;
    }

    public int a(short s, int i, int i2) {
        if (this.c == null) {
            return -1;
        }
        if (i < 0) {
            i = -1;
        } else if (i >= this.c.length) {
            i = this.c.length - 1;
        }
        if (i2 < 0) {
            i2 = this.c.length;
        }
        int i3 = i + 1;
        if (i3 >= i2) {
            return -1;
        }
        while (i3 < this.c.length && i3 < i2) {
            if (this.c[i3].a == s) {
                return i3;
            }
            i3++;
        }
        return -1;
    }

    public int a(short s, int i, int i2, int i3) {
        int iA = a(s, i, i2);
        return iA >= 0 ? a(iA, i3) : i3;
    }

    public long a(int i, long j) {
        return a(b(i), j);
    }

    public long a(short s, int i, int i2, long j) {
        int iA = a(s, i, i2);
        return iA >= 0 ? a(iA, j) : j;
    }

    public Short a(int i) {
        if (this.c == null || i < 0 || i >= this.c.length) {
            return null;
        }
        return Short.valueOf(this.c[i].a);
    }

    public void a(short s, byte[] bArr) {
        if (this.c == null) {
            this.c = new bq[1];
            this.c[0] = new bq();
            this.c[0].a = s;
            this.c[0].b = bArr;
            return;
        }
        bq[] bqVarArr = new bq[this.c.length + 1];
        bqVarArr[0] = new bq();
        bqVarArr[0].a = s;
        bqVarArr[0].b = bArr;
        System.arraycopy(this.c, 0, bqVarArr, 1, this.c.length);
        this.c = bqVarArr;
    }

    public byte[] a(short s) {
        if (this.c == null) {
            return null;
        }
        for (int i = 0; i < this.c.length; i++) {
            if (this.c[i].a == s) {
                return this.c[i].b;
            }
        }
        return null;
    }

    public int b(short s, int i) {
        if (this.c == null) {
            return -1;
        }
        for (int i2 = 0; i2 < this.c.length; i2++) {
            if (this.c[i2].a == s) {
                if (i == 0) {
                    return i2;
                }
                i--;
            }
        }
        return -1;
    }

    public String b(short s) {
        return chat.ola.vn.util.o.a(a(s));
    }

    public String b(short s, int i, int i2) {
        int iA = a(s, i, i2);
        if (iA >= 0) {
            return c(iA);
        }
        return null;
    }

    public byte[] b(int i) {
        if (this.c == null || i < 0 || i >= this.c.length) {
            return null;
        }
        return this.c[i].b;
    }

    public int c(short s) {
        if (this.c == null) {
            return 0;
        }
        int i = 0;
        for (int i2 = 0; i2 < this.c.length; i2++) {
            if (this.c[i2].a == s) {
                i++;
            }
        }
        return i;
    }

    public String c(int i) {
        return chat.ola.vn.util.o.a(b(i));
    }

    public boolean d(short s) {
        if (this.c == null) {
            return false;
        }
        for (int i = 0; i < this.c.length; i++) {
            if (this.c[i].a == s) {
                return true;
            }
        }
        return false;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("");
        sb.append("[Service]: ");
        sb.append(this.b);
        sb.append(" [Length]: ");
        sb.append(this.a);
        sb.append(" [Number Of Keys]: ");
        sb.append(this.c != null ? String.valueOf(this.c.length) : "Null");
        String string = sb.toString();
        if (this.c != null) {
            string = string + "\n";
            for (int i = 0; i < this.c.length; i++) {
                string = string + " [Key]: " + ((int) this.c[i].a) + " [Value length]: " + this.c[i].b.length;
            }
        }
        return string;
    }
}
