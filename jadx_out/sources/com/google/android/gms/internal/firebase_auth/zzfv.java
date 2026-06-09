package com.google.android.gms.internal.firebase_auth;

import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.lang.reflect.Field;
import java.nio.Buffer;
import java.nio.ByteBuffer;
import java.security.AccessController;
import java.util.logging.Level;
import java.util.logging.Logger;
import libcore.io.Memory;
import sun.misc.Unsafe;

/* JADX INFO: loaded from: classes2.dex */
final class zzfv {
    private static final boolean zznf;
    private static final zzd zzvl;
    private static final boolean zzvm;
    private static final long zzvn;
    private static final long zzvo;
    private static final long zzvp;
    private static final long zzvq;
    private static final long zzvr;
    private static final long zzvs;
    private static final long zzvt;
    private static final long zzvu;
    private static final long zzvv;
    private static final long zzvw;
    private static final long zzvx;
    private static final long zzvy;
    private static final long zzvz;
    private static final long zzwa;
    private static final long zzwb;
    private static final boolean zzwc;
    private static final Logger logger = Logger.getLogger(zzfv.class.getName());
    private static final Unsafe zztj = zzge();
    private static final Class<?> zzme = zzbr.zzbv();
    private static final boolean zzvj = zzj(Long.TYPE);
    private static final boolean zzvk = zzj(Integer.TYPE);

    static final class zza extends zzd {
        zza(Unsafe unsafe) {
            super(unsafe);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(long j, byte b) {
            Memory.pokeByte((int) (j & (-1)), b);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, double d) {
            zza(obj, j, Double.doubleToLongBits(d));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, float f) {
            zzb(obj, j, Float.floatToIntBits(f));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, boolean z) {
            if (zzfv.zzwc) {
                zzfv.zzb(obj, j, z);
            } else {
                zzfv.zzc(obj, j, z);
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(byte[] bArr, long j, long j2, long j3) {
            Memory.pokeByteArray((int) (j2 & (-1)), bArr, (int) j, (int) j3);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zze(Object obj, long j, byte b) {
            if (zzfv.zzwc) {
                zzfv.zza(obj, j, b);
            } else {
                zzfv.zzb(obj, j, b);
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final boolean zzm(Object obj, long j) {
            return zzfv.zzwc ? zzfv.zzs(obj, j) : zzfv.zzt(obj, j);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final float zzn(Object obj, long j) {
            return Float.intBitsToFloat(zzk(obj, j));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final double zzo(Object obj, long j) {
            return Double.longBitsToDouble(zzl(obj, j));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final byte zzy(Object obj, long j) {
            return zzfv.zzwc ? zzfv.zzq(obj, j) : zzfv.zzr(obj, j);
        }
    }

    static final class zzb extends zzd {
        zzb(Unsafe unsafe) {
            super(unsafe);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(long j, byte b) {
            Memory.pokeByte(j, b);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, double d) {
            zza(obj, j, Double.doubleToLongBits(d));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, float f) {
            zzb(obj, j, Float.floatToIntBits(f));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, boolean z) {
            if (zzfv.zzwc) {
                zzfv.zzb(obj, j, z);
            } else {
                zzfv.zzc(obj, j, z);
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(byte[] bArr, long j, long j2, long j3) {
            Memory.pokeByteArray(j2, bArr, (int) j, (int) j3);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zze(Object obj, long j, byte b) {
            if (zzfv.zzwc) {
                zzfv.zza(obj, j, b);
            } else {
                zzfv.zzb(obj, j, b);
            }
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final boolean zzm(Object obj, long j) {
            return zzfv.zzwc ? zzfv.zzs(obj, j) : zzfv.zzt(obj, j);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final float zzn(Object obj, long j) {
            return Float.intBitsToFloat(zzk(obj, j));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final double zzo(Object obj, long j) {
            return Double.longBitsToDouble(zzl(obj, j));
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final byte zzy(Object obj, long j) {
            return zzfv.zzwc ? zzfv.zzq(obj, j) : zzfv.zzr(obj, j);
        }
    }

    static final class zzc extends zzd {
        zzc(Unsafe unsafe) {
            super(unsafe);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(long j, byte b) {
            this.zzwd.putByte(j, b);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, double d) {
            this.zzwd.putDouble(obj, j, d);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, float f) {
            this.zzwd.putFloat(obj, j, f);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(Object obj, long j, boolean z) {
            this.zzwd.putBoolean(obj, j, z);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zza(byte[] bArr, long j, long j2, long j3) {
            this.zzwd.copyMemory(bArr, zzfv.zzvn + j, (Object) null, j2, j3);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final void zze(Object obj, long j, byte b) {
            this.zzwd.putByte(obj, j, b);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final boolean zzm(Object obj, long j) {
            return this.zzwd.getBoolean(obj, j);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final float zzn(Object obj, long j) {
            return this.zzwd.getFloat(obj, j);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final double zzo(Object obj, long j) {
            return this.zzwd.getDouble(obj, j);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzfv.zzd
        public final byte zzy(Object obj, long j) {
            return this.zzwd.getByte(obj, j);
        }
    }

    static abstract class zzd {
        Unsafe zzwd;

        zzd(Unsafe unsafe) {
            this.zzwd = unsafe;
        }

        public abstract void zza(long j, byte b);

        public abstract void zza(Object obj, long j, double d);

        public abstract void zza(Object obj, long j, float f);

        public final void zza(Object obj, long j, long j2) {
            this.zzwd.putLong(obj, j, j2);
        }

        public abstract void zza(Object obj, long j, boolean z);

        public abstract void zza(byte[] bArr, long j, long j2, long j3);

        public final void zzb(Object obj, long j, int i) {
            this.zzwd.putInt(obj, j, i);
        }

        public abstract void zze(Object obj, long j, byte b);

        public final int zzk(Object obj, long j) {
            return this.zzwd.getInt(obj, j);
        }

        public final long zzl(Object obj, long j) {
            return this.zzwd.getLong(obj, j);
        }

        public abstract boolean zzm(Object obj, long j);

        public abstract float zzn(Object obj, long j);

        public abstract double zzo(Object obj, long j);

        public abstract byte zzy(Object obj, long j);
    }

    /* JADX WARN: Removed duplicated region for block: B:4:0x002d  */
    static {
        /*
            Method dump skipped, instruction units count: 265
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzfv.<clinit>():void");
    }

    private zzfv() {
    }

    static byte zza(byte[] bArr, long j) {
        return zzvl.zzy(bArr, zzvn + j);
    }

    private static long zza(Field field) {
        if (field == null || zzvl == null) {
            return -1L;
        }
        return zzvl.zzwd.objectFieldOffset(field);
    }

    static void zza(long j, byte b) {
        zzvl.zza(j, b);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zza(Object obj, long j, byte b) {
        long j2 = j & (-4);
        int i = ((((int) j) ^ (-1)) & 3) << 3;
        zzb(obj, j2, ((255 & b) << i) | (zzk(obj, j2) & ((255 << i) ^ (-1))));
    }

    static void zza(Object obj, long j, double d) {
        zzvl.zza(obj, j, d);
    }

    static void zza(Object obj, long j, float f) {
        zzvl.zza(obj, j, f);
    }

    static void zza(Object obj, long j, long j2) {
        zzvl.zza(obj, j, j2);
    }

    static void zza(Object obj, long j, Object obj2) {
        zzvl.zzwd.putObject(obj, j, obj2);
    }

    static void zza(Object obj, long j, boolean z) {
        zzvl.zza(obj, j, z);
    }

    static void zza(byte[] bArr, long j, byte b) {
        zzvl.zze(bArr, zzvn + j, b);
    }

    static void zza(byte[] bArr, long j, long j2, long j3) {
        zzvl.zza(bArr, j, j2, j3);
    }

    static long zzb(ByteBuffer byteBuffer) {
        return zzvl.zzl(byteBuffer, zzwa);
    }

    private static Field zzb(Class<?> cls, String str) {
        try {
            Field declaredField = cls.getDeclaredField(str);
            declaredField.setAccessible(true);
            return declaredField;
        } catch (Throwable unused) {
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zzb(Object obj, long j, byte b) {
        long j2 = j & (-4);
        int i = (((int) j) & 3) << 3;
        zzb(obj, j2, ((255 & b) << i) | (zzk(obj, j2) & ((255 << i) ^ (-1))));
    }

    static void zzb(Object obj, long j, int i) {
        zzvl.zzb(obj, j, i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zzb(Object obj, long j, boolean z) {
        zza(obj, j, z ? (byte) 1 : (byte) 0);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zzc(Object obj, long j, boolean z) {
        zzb(obj, j, z ? (byte) 1 : (byte) 0);
    }

    static boolean zzgc() {
        return zznf;
    }

    static boolean zzgd() {
        return zzvm;
    }

    static Unsafe zzge() {
        try {
            return (Unsafe) AccessController.doPrivileged(new zzfw());
        } catch (Throwable unused) {
            return null;
        }
    }

    private static boolean zzgf() {
        if (zztj == null) {
            return false;
        }
        try {
            Class<?> cls = zztj.getClass();
            cls.getMethod("objectFieldOffset", Field.class);
            cls.getMethod("arrayBaseOffset", Class.class);
            cls.getMethod("arrayIndexScale", Class.class);
            cls.getMethod("getInt", Object.class, Long.TYPE);
            cls.getMethod("putInt", Object.class, Long.TYPE, Integer.TYPE);
            cls.getMethod("getLong", Object.class, Long.TYPE);
            cls.getMethod("putLong", Object.class, Long.TYPE, Long.TYPE);
            cls.getMethod("getObject", Object.class, Long.TYPE);
            cls.getMethod("putObject", Object.class, Long.TYPE, Object.class);
            if (zzbr.zzbu()) {
                return true;
            }
            cls.getMethod("getByte", Object.class, Long.TYPE);
            cls.getMethod("putByte", Object.class, Long.TYPE, Byte.TYPE);
            cls.getMethod("getBoolean", Object.class, Long.TYPE);
            cls.getMethod("putBoolean", Object.class, Long.TYPE, Boolean.TYPE);
            cls.getMethod("getFloat", Object.class, Long.TYPE);
            cls.getMethod("putFloat", Object.class, Long.TYPE, Float.TYPE);
            cls.getMethod("getDouble", Object.class, Long.TYPE);
            cls.getMethod("putDouble", Object.class, Long.TYPE, Double.TYPE);
            return true;
        } catch (Throwable th) {
            Logger logger2 = logger;
            Level level = Level.WARNING;
            String strValueOf = String.valueOf(th);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 71);
            sb.append("platform method missing - proto runtime falling back to safer methods: ");
            sb.append(strValueOf);
            logger2.logp(level, "com.google.protobuf.UnsafeUtil", "supportsUnsafeArrayOperations", sb.toString());
            return false;
        }
    }

    private static boolean zzgg() {
        if (zztj == null) {
            return false;
        }
        try {
            Class<?> cls = zztj.getClass();
            cls.getMethod("objectFieldOffset", Field.class);
            cls.getMethod("getLong", Object.class, Long.TYPE);
            if (zzgh() == null) {
                return false;
            }
            if (zzbr.zzbu()) {
                return true;
            }
            cls.getMethod("getByte", Long.TYPE);
            cls.getMethod("putByte", Long.TYPE, Byte.TYPE);
            cls.getMethod("getInt", Long.TYPE);
            cls.getMethod("putInt", Long.TYPE, Integer.TYPE);
            cls.getMethod("getLong", Long.TYPE);
            cls.getMethod("putLong", Long.TYPE, Long.TYPE);
            cls.getMethod("copyMemory", Long.TYPE, Long.TYPE, Long.TYPE);
            cls.getMethod("copyMemory", Object.class, Long.TYPE, Object.class, Long.TYPE, Long.TYPE);
            return true;
        } catch (Throwable th) {
            Logger logger2 = logger;
            Level level = Level.WARNING;
            String strValueOf = String.valueOf(th);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 71);
            sb.append("platform method missing - proto runtime falling back to safer methods: ");
            sb.append(strValueOf);
            logger2.logp(level, "com.google.protobuf.UnsafeUtil", "supportsUnsafeByteBufferOperations", sb.toString());
            return false;
        }
    }

    private static Field zzgh() {
        Field fieldZzb;
        if (zzbr.zzbu() && (fieldZzb = zzb(Buffer.class, "effectiveDirectAddress")) != null) {
            return fieldZzb;
        }
        Field fieldZzb2 = zzb(Buffer.class, AccountKitGraphConstants.EMAIL_ADDRESS_KEY);
        if (fieldZzb2 == null || fieldZzb2.getType() != Long.TYPE) {
            return null;
        }
        return fieldZzb2;
    }

    private static int zzh(Class<?> cls) {
        if (zznf) {
            return zzvl.zzwd.arrayBaseOffset(cls);
        }
        return -1;
    }

    private static int zzi(Class<?> cls) {
        if (zznf) {
            return zzvl.zzwd.arrayIndexScale(cls);
        }
        return -1;
    }

    private static boolean zzj(Class<?> cls) {
        if (!zzbr.zzbu()) {
            return false;
        }
        try {
            Class<?> cls2 = zzme;
            cls2.getMethod("peekLong", cls, Boolean.TYPE);
            cls2.getMethod("pokeLong", cls, Long.TYPE, Boolean.TYPE);
            cls2.getMethod("pokeInt", cls, Integer.TYPE, Boolean.TYPE);
            cls2.getMethod("peekInt", cls, Boolean.TYPE);
            cls2.getMethod("pokeByte", cls, Byte.TYPE);
            cls2.getMethod("peekByte", cls);
            cls2.getMethod("pokeByteArray", cls, byte[].class, Integer.TYPE, Integer.TYPE);
            cls2.getMethod("peekByteArray", cls, byte[].class, Integer.TYPE, Integer.TYPE);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    static int zzk(Object obj, long j) {
        return zzvl.zzk(obj, j);
    }

    static long zzl(Object obj, long j) {
        return zzvl.zzl(obj, j);
    }

    static boolean zzm(Object obj, long j) {
        return zzvl.zzm(obj, j);
    }

    static float zzn(Object obj, long j) {
        return zzvl.zzn(obj, j);
    }

    static double zzo(Object obj, long j) {
        return zzvl.zzo(obj, j);
    }

    static Object zzp(Object obj, long j) {
        return zzvl.zzwd.getObject(obj, j);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static byte zzq(Object obj, long j) {
        return (byte) (zzk(obj, j & (-4)) >>> ((int) (((j ^ (-1)) & 3) << 3)));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static byte zzr(Object obj, long j) {
        return (byte) (zzk(obj, j & (-4)) >>> ((int) ((j & 3) << 3)));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean zzs(Object obj, long j) {
        return zzq(obj, j) != 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean zzt(Object obj, long j) {
        return zzr(obj, j) != 0;
    }
}
