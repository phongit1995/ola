package com.google.android.gms.internal.measurement;

/* JADX WARN: Enum visitor error
jadx.core.utils.exceptions.JadxRuntimeException: Init of enum field 'zzbxy' uses external variables
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
public class zzabu {
    public static final zzabu zzbxq = new zzabu("DOUBLE", 0, zzabz.DOUBLE, 1);
    public static final zzabu zzbxr = new zzabu("FLOAT", 1, zzabz.FLOAT, 5);
    public static final zzabu zzbxs = new zzabu("INT64", 2, zzabz.LONG, 0);
    public static final zzabu zzbxt = new zzabu("UINT64", 3, zzabz.LONG, 0);
    public static final zzabu zzbxu = new zzabu("INT32", 4, zzabz.INT, 0);
    public static final zzabu zzbxv = new zzabu("FIXED64", 5, zzabz.LONG, 1);
    public static final zzabu zzbxw = new zzabu("FIXED32", 6, zzabz.INT, 5);
    public static final zzabu zzbxx = new zzabu("BOOL", 7, zzabz.BOOLEAN, 0);
    public static final zzabu zzbxy;
    public static final zzabu zzbxz;
    public static final zzabu zzbya;
    public static final zzabu zzbyb;
    public static final zzabu zzbyc;
    public static final zzabu zzbyd;
    public static final zzabu zzbye;
    public static final zzabu zzbyf;
    public static final zzabu zzbyg;
    public static final zzabu zzbyh;
    private static final /* synthetic */ zzabu[] zzbyk;
    private final zzabz zzbyi;
    private final int zzbyj;

    static {
        final int i = 2;
        final int i2 = 3;
        final String str = "STRING";
        final zzabz zzabzVar = zzabz.STRING;
        final int i3 = 8;
        zzbxy = new zzabu(str, i3, zzabzVar, i) { // from class: com.google.android.gms.internal.measurement.zzabv
            {
                int i4 = 8;
                int i5 = 2;
                zzabt zzabtVar = null;
            }
        };
        final String str2 = "GROUP";
        final zzabz zzabzVar2 = zzabz.MESSAGE;
        final int i4 = 9;
        zzbxz = new zzabu(str2, i4, zzabzVar2, i2) { // from class: com.google.android.gms.internal.measurement.zzabw
            {
                int i5 = 9;
                int i6 = 3;
                zzabt zzabtVar = null;
            }
        };
        final String str3 = "MESSAGE";
        final zzabz zzabzVar3 = zzabz.MESSAGE;
        final int i5 = 10;
        zzbya = new zzabu(str3, i5, zzabzVar3, i) { // from class: com.google.android.gms.internal.measurement.zzabx
            {
                int i6 = 10;
                int i7 = 2;
                zzabt zzabtVar = null;
            }
        };
        final String str4 = "BYTES";
        final zzabz zzabzVar4 = zzabz.BYTE_STRING;
        final int i6 = 11;
        zzbyb = new zzabu(str4, i6, zzabzVar4, i) { // from class: com.google.android.gms.internal.measurement.zzaby
            {
                int i7 = 11;
                int i8 = 2;
                zzabt zzabtVar = null;
            }
        };
        zzbyc = new zzabu("UINT32", 12, zzabz.INT, 0);
        zzbyd = new zzabu("ENUM", 13, zzabz.ENUM, 0);
        zzbye = new zzabu("SFIXED32", 14, zzabz.INT, 5);
        zzbyf = new zzabu("SFIXED64", 15, zzabz.LONG, 1);
        zzbyg = new zzabu("SINT32", 16, zzabz.INT, 0);
        zzbyh = new zzabu("SINT64", 17, zzabz.LONG, 0);
        zzbyk = new zzabu[]{zzbxq, zzbxr, zzbxs, zzbxt, zzbxu, zzbxv, zzbxw, zzbxx, zzbxy, zzbxz, zzbya, zzbyb, zzbyc, zzbyd, zzbye, zzbyf, zzbyg, zzbyh};
    }

    private zzabu(String str, int i, zzabz zzabzVar, int i2) {
        this.zzbyi = zzabzVar;
        this.zzbyj = i2;
    }

    /* synthetic */ zzabu(String str, int i, zzabz zzabzVar, int i2, zzabt zzabtVar) {
        this(str, i, zzabzVar, i2);
    }

    public static zzabu[] values() {
        return (zzabu[]) zzbyk.clone();
    }

    public final zzabz zzvk() {
        return this.zzbyi;
    }
}
