package com.google.android.gms.internal.firebase_auth;

/* JADX WARN: Enum visitor error
jadx.core.utils.exceptions.JadxRuntimeException: Init of enum field 'zzwn' uses external variables
	at jadx.core.dex.visitors.EnumVisitor.createEnumFieldByConstructor(EnumVisitor.java:451)
	at jadx.core.dex.visitors.EnumVisitor.processEnumFieldByField(EnumVisitor.java:372)
	at jadx.core.dex.visitors.EnumVisitor.processEnumFieldByWrappedInsn(EnumVisitor.java:337)
	at jadx.core.dex.visitors.EnumVisitor.extractEnumFieldsFromFilledArray(EnumVisitor.java:322)
	at jadx.core.dex.visitors.EnumVisitor.extractEnumFieldsFromInsn(EnumVisitor.java:262)
	at jadx.core.dex.visitors.EnumVisitor.convertToEnum(EnumVisitor.java:151)
	at jadx.core.dex.visitors.EnumVisitor.visit(EnumVisitor.java:100)
 */
/* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
/* JADX INFO: loaded from: classes2.dex */
public class zzgd {
    public static final zzgd zzwf = new zzgd("DOUBLE", 0, zzgi.DOUBLE, 1);
    public static final zzgd zzwg = new zzgd("FLOAT", 1, zzgi.FLOAT, 5);
    public static final zzgd zzwh = new zzgd("INT64", 2, zzgi.LONG, 0);
    public static final zzgd zzwi = new zzgd("UINT64", 3, zzgi.LONG, 0);
    public static final zzgd zzwj = new zzgd("INT32", 4, zzgi.INT, 0);
    public static final zzgd zzwk = new zzgd("FIXED64", 5, zzgi.LONG, 1);
    public static final zzgd zzwl = new zzgd("FIXED32", 6, zzgi.INT, 5);
    public static final zzgd zzwm = new zzgd("BOOL", 7, zzgi.BOOLEAN, 0);
    public static final zzgd zzwn;
    public static final zzgd zzwo;
    public static final zzgd zzwp;
    public static final zzgd zzwq;
    public static final zzgd zzwr;
    public static final zzgd zzws;
    public static final zzgd zzwt;
    public static final zzgd zzwu;
    public static final zzgd zzwv;
    public static final zzgd zzww;
    private static final /* synthetic */ zzgd[] zzwz;
    private final zzgi zzwx;
    private final int zzwy;

    static {
        final int i = 2;
        final int i2 = 3;
        final String str = "STRING";
        final zzgi zzgiVar = zzgi.STRING;
        final int i3 = 8;
        zzwn = new zzgd(str, i3, zzgiVar, i) { // from class: com.google.android.gms.internal.firebase_auth.zzge
            {
                int i4 = 8;
                int i5 = 2;
                zzgc zzgcVar = null;
            }
        };
        final String str2 = "GROUP";
        final zzgi zzgiVar2 = zzgi.MESSAGE;
        final int i4 = 9;
        zzwo = new zzgd(str2, i4, zzgiVar2, i2) { // from class: com.google.android.gms.internal.firebase_auth.zzgf
            {
                int i5 = 9;
                int i6 = 3;
                zzgc zzgcVar = null;
            }
        };
        final String str3 = "MESSAGE";
        final zzgi zzgiVar3 = zzgi.MESSAGE;
        final int i5 = 10;
        zzwp = new zzgd(str3, i5, zzgiVar3, i) { // from class: com.google.android.gms.internal.firebase_auth.zzgg
            {
                int i6 = 10;
                int i7 = 2;
                zzgc zzgcVar = null;
            }
        };
        final String str4 = "BYTES";
        final zzgi zzgiVar4 = zzgi.BYTE_STRING;
        final int i6 = 11;
        zzwq = new zzgd(str4, i6, zzgiVar4, i) { // from class: com.google.android.gms.internal.firebase_auth.zzgh
            {
                int i7 = 11;
                int i8 = 2;
                zzgc zzgcVar = null;
            }
        };
        zzwr = new zzgd("UINT32", 12, zzgi.INT, 0);
        zzws = new zzgd("ENUM", 13, zzgi.ENUM, 0);
        zzwt = new zzgd("SFIXED32", 14, zzgi.INT, 5);
        zzwu = new zzgd("SFIXED64", 15, zzgi.LONG, 1);
        zzwv = new zzgd("SINT32", 16, zzgi.INT, 0);
        zzww = new zzgd("SINT64", 17, zzgi.LONG, 0);
        zzwz = new zzgd[]{zzwf, zzwg, zzwh, zzwi, zzwj, zzwk, zzwl, zzwm, zzwn, zzwo, zzwp, zzwq, zzwr, zzws, zzwt, zzwu, zzwv, zzww};
    }

    private zzgd(String str, int i, zzgi zzgiVar, int i2) {
        this.zzwx = zzgiVar;
        this.zzwy = i2;
    }

    /* synthetic */ zzgd(String str, int i, zzgi zzgiVar, int i2, zzgc zzgcVar) {
        this(str, i, zzgiVar, i2);
    }

    public static zzgd[] values() {
        return (zzgd[]) zzwz.clone();
    }

    public final zzgi zzgj() {
        return this.zzwx;
    }

    public final int zzgk() {
        return this.zzwy;
    }
}
