package chat.ola.vn.x;

/* JADX INFO: loaded from: classes.dex */
public class c {
    public String b;
    public short d;
    public short e;
    public byte f;
    public byte g;
    public String a = null;
    public int c = 0;

    public c(byte b, byte b2, short s, short s2, String str) {
        this.b = null;
        this.g = b;
        this.f = b2;
        this.d = s;
        this.e = s2;
        this.b = str;
    }

    public String toString() {
        String str = "LOW";
        switch (this.f) {
            case 1:
                str = "MEDIUM";
                break;
            case 2:
                str = "HIGH";
                break;
        }
        String str2 = "3GP";
        switch (this.g) {
            case 0:
                str2 = "3GP";
                break;
            case 1:
                str2 = "FLV";
                break;
            case 2:
                str2 = "WEBM";
                break;
            case 3:
                str2 = "MP4";
                break;
        }
        return "[" + str + "-" + str2 + " " + ((int) this.d) + "x" + ((int) this.e) + "]\n[Title: " + this.a + "]\n[Duration: " + this.c + "]\n[Url: " + this.b + "]";
    }
}
