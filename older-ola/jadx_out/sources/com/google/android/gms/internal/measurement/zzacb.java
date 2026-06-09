package com.google.android.gms.internal.measurement;

import java.nio.BufferOverflowException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.ReadOnlyBufferException;

/* JADX INFO: loaded from: classes2.dex */
public final class zzacb {
    private final ByteBuffer zzbzc;

    private zzacb(ByteBuffer byteBuffer) {
        this.zzbzc = byteBuffer;
        this.zzbzc.order(ByteOrder.LITTLE_ENDIAN);
    }

    private zzacb(byte[] bArr, int i, int i2) {
        this(ByteBuffer.wrap(bArr, i, i2));
    }

    private static int zza(CharSequence charSequence) {
        int length = charSequence.length();
        int i = 0;
        int i2 = 0;
        while (i2 < length && charSequence.charAt(i2) < 128) {
            i2++;
        }
        int i3 = length;
        while (true) {
            if (i2 >= length) {
                break;
            }
            char cCharAt = charSequence.charAt(i2);
            if (cCharAt < 2048) {
                i3 += (127 - cCharAt) >>> 31;
                i2++;
            } else {
                int length2 = charSequence.length();
                while (i2 < length2) {
                    char cCharAt2 = charSequence.charAt(i2);
                    if (cCharAt2 < 2048) {
                        i += (127 - cCharAt2) >>> 31;
                    } else {
                        i += 2;
                        if (55296 <= cCharAt2 && cCharAt2 <= 57343) {
                            if (Character.codePointAt(charSequence, i2) < 65536) {
                                StringBuilder sb = new StringBuilder(39);
                                sb.append("Unpaired surrogate at index ");
                                sb.append(i2);
                                throw new IllegalArgumentException(sb.toString());
                            }
                            i2++;
                        }
                    }
                    i2++;
                }
                i3 += i;
            }
        }
        if (i3 >= length) {
            return i3;
        }
        StringBuilder sb2 = new StringBuilder(54);
        sb2.append("UTF-8 length does not fit in int: ");
        sb2.append(((long) i3) + 4294967296L);
        throw new IllegalArgumentException(sb2.toString());
    }

    private static void zza(CharSequence charSequence, ByteBuffer byteBuffer) {
        int i;
        int i2;
        char cCharAt;
        int i3;
        if (byteBuffer.isReadOnly()) {
            throw new ReadOnlyBufferException();
        }
        int i4 = 0;
        if (!byteBuffer.hasArray()) {
            int length = charSequence.length();
            while (i4 < length) {
                char cCharAt2 = charSequence.charAt(i4);
                int i5 = cCharAt2;
                if (cCharAt2 >= 128) {
                    if (cCharAt2 < 2048) {
                        i3 = (cCharAt2 >>> 6) | 960;
                    } else {
                        if (cCharAt2 >= 55296 && 57343 >= cCharAt2) {
                            int i6 = i4 + 1;
                            if (i6 != charSequence.length()) {
                                char cCharAt3 = charSequence.charAt(i6);
                                if (Character.isSurrogatePair(cCharAt2, cCharAt3)) {
                                    int codePoint = Character.toCodePoint(cCharAt2, cCharAt3);
                                    byteBuffer.put((byte) ((codePoint >>> 18) | 240));
                                    byteBuffer.put((byte) (((codePoint >>> 12) & 63) | 128));
                                    byteBuffer.put((byte) (((codePoint >>> 6) & 63) | 128));
                                    byteBuffer.put((byte) ((codePoint & 63) | 128));
                                    i4 = i6;
                                } else {
                                    i4 = i6;
                                }
                            }
                            StringBuilder sb = new StringBuilder(39);
                            sb.append("Unpaired surrogate at index ");
                            sb.append(i4 - 1);
                            throw new IllegalArgumentException(sb.toString());
                        }
                        byteBuffer.put((byte) ((cCharAt2 >>> '\f') | 480));
                        i3 = ((cCharAt2 >>> 6) & 63) | 128;
                    }
                    byteBuffer.put((byte) i3);
                    i5 = (cCharAt2 & '?') | 128;
                    byteBuffer.put((byte) i5);
                } else {
                    byteBuffer.put((byte) i5);
                }
                i4++;
            }
            return;
        }
        try {
            byte[] bArrArray = byteBuffer.array();
            int iArrayOffset = byteBuffer.arrayOffset() + byteBuffer.position();
            int iRemaining = byteBuffer.remaining();
            int length2 = charSequence.length();
            int i7 = iRemaining + iArrayOffset;
            while (i4 < length2) {
                int i8 = i4 + iArrayOffset;
                if (i8 >= i7 || (cCharAt = charSequence.charAt(i4)) >= 128) {
                    break;
                }
                bArrArray[i8] = (byte) cCharAt;
                i4++;
            }
            if (i4 == length2) {
                i = iArrayOffset + length2;
            } else {
                i = iArrayOffset + i4;
                while (i4 < length2) {
                    char cCharAt4 = charSequence.charAt(i4);
                    if (cCharAt4 >= 128 || i >= i7) {
                        if (cCharAt4 < 2048 && i <= i7 - 2) {
                            int i9 = i + 1;
                            bArrArray[i] = (byte) ((cCharAt4 >>> 6) | 960);
                            i = i9 + 1;
                            bArrArray[i9] = (byte) ((cCharAt4 & '?') | 128);
                        } else {
                            if ((cCharAt4 >= 55296 && 57343 >= cCharAt4) || i > i7 - 3) {
                                if (i > i7 - 4) {
                                    StringBuilder sb2 = new StringBuilder(37);
                                    sb2.append("Failed writing ");
                                    sb2.append(cCharAt4);
                                    sb2.append(" at index ");
                                    sb2.append(i);
                                    throw new ArrayIndexOutOfBoundsException(sb2.toString());
                                }
                                int i10 = i4 + 1;
                                if (i10 != charSequence.length()) {
                                    char cCharAt5 = charSequence.charAt(i10);
                                    if (Character.isSurrogatePair(cCharAt4, cCharAt5)) {
                                        int codePoint2 = Character.toCodePoint(cCharAt4, cCharAt5);
                                        int i11 = i + 1;
                                        bArrArray[i] = (byte) ((codePoint2 >>> 18) | 240);
                                        int i12 = i11 + 1;
                                        bArrArray[i11] = (byte) (((codePoint2 >>> 12) & 63) | 128);
                                        int i13 = i12 + 1;
                                        bArrArray[i12] = (byte) (((codePoint2 >>> 6) & 63) | 128);
                                        i = i13 + 1;
                                        bArrArray[i13] = (byte) ((codePoint2 & 63) | 128);
                                        i4 = i10;
                                    } else {
                                        i4 = i10;
                                    }
                                }
                                StringBuilder sb3 = new StringBuilder(39);
                                sb3.append("Unpaired surrogate at index ");
                                sb3.append(i4 - 1);
                                throw new IllegalArgumentException(sb3.toString());
                            }
                            int i14 = i + 1;
                            bArrArray[i] = (byte) ((cCharAt4 >>> '\f') | 480);
                            int i15 = i14 + 1;
                            bArrArray[i14] = (byte) (((cCharAt4 >>> 6) & 63) | 128);
                            i2 = i15 + 1;
                            bArrArray[i15] = (byte) ((cCharAt4 & '?') | 128);
                        }
                        i4++;
                    } else {
                        i2 = i + 1;
                        bArrArray[i] = (byte) cCharAt4;
                    }
                    i = i2;
                    i4++;
                }
            }
            byteBuffer.position(i - byteBuffer.arrayOffset());
        } catch (ArrayIndexOutOfBoundsException e) {
            BufferOverflowException bufferOverflowException = new BufferOverflowException();
            bufferOverflowException.initCause(e);
            throw bufferOverflowException;
        }
    }

    public static int zzao(int i) {
        if (i >= 0) {
            return zzas(i);
        }
        return 10;
    }

    private final void zzap(int i) throws zzacc {
        byte b = (byte) i;
        if (!this.zzbzc.hasRemaining()) {
            throw new zzacc(this.zzbzc.position(), this.zzbzc.limit());
        }
        this.zzbzc.put(b);
    }

    public static int zzaq(int i) {
        return zzas(i << 3);
    }

    public static int zzas(int i) {
        if ((i & (-128)) == 0) {
            return 1;
        }
        if ((i & (-16384)) == 0) {
            return 2;
        }
        if (((-2097152) & i) == 0) {
            return 3;
        }
        return (i & (-268435456)) == 0 ? 4 : 5;
    }

    private final void zzas(long j) throws zzacc {
        while ((j & (-128)) != 0) {
            zzap((((int) j) & 127) | 128);
            j >>>= 7;
        }
        zzap((int) j);
    }

    public static int zzat(long j) {
        if ((j & (-128)) == 0) {
            return 1;
        }
        if ((j & (-16384)) == 0) {
            return 2;
        }
        if ((j & (-2097152)) == 0) {
            return 3;
        }
        if ((j & (-268435456)) == 0) {
            return 4;
        }
        if ((j & (-34359738368L)) == 0) {
            return 5;
        }
        if ((j & (-4398046511104L)) == 0) {
            return 6;
        }
        if ((j & (-562949953421312L)) == 0) {
            return 7;
        }
        if ((j & (-72057594037927936L)) == 0) {
            return 8;
        }
        return (j & Long.MIN_VALUE) == 0 ? 9 : 10;
    }

    public static int zzb(int i, zzacj zzacjVar) {
        int iZzaq = zzaq(i);
        int iZzwb = zzacjVar.zzwb();
        return iZzaq + zzas(iZzwb) + iZzwb;
    }

    public static zzacb zzb(byte[] bArr, int i, int i2) {
        return new zzacb(bArr, 0, i2);
    }

    public static int zzc(int i, long j) {
        return zzaq(i) + zzat(j);
    }

    public static int zzc(int i, String str) {
        return zzaq(i) + zzfr(str);
    }

    public static int zzf(int i, int i2) {
        return zzaq(i) + zzao(i2);
    }

    public static int zzfr(String str) {
        int iZza = zza(str);
        return zzas(iZza) + iZza;
    }

    public static zzacb zzj(byte[] bArr) {
        return zzb(bArr, 0, bArr.length);
    }

    public final void zza(int i, double d) throws zzacc {
        zzg(i, 1);
        long jDoubleToLongBits = Double.doubleToLongBits(d);
        if (this.zzbzc.remaining() < 8) {
            throw new zzacc(this.zzbzc.position(), this.zzbzc.limit());
        }
        this.zzbzc.putLong(jDoubleToLongBits);
    }

    public final void zza(int i, float f) throws zzacc {
        zzg(i, 5);
        int iFloatToIntBits = Float.floatToIntBits(f);
        if (this.zzbzc.remaining() < 4) {
            throw new zzacc(this.zzbzc.position(), this.zzbzc.limit());
        }
        this.zzbzc.putInt(iFloatToIntBits);
    }

    public final void zza(int i, long j) throws zzacc {
        zzg(i, 0);
        zzas(j);
    }

    public final void zza(int i, zzacj zzacjVar) throws zzacc {
        zzg(i, 2);
        zzb(zzacjVar);
    }

    public final void zza(int i, boolean z) throws zzacc {
        zzg(i, 0);
        byte b = z ? (byte) 1 : (byte) 0;
        if (!this.zzbzc.hasRemaining()) {
            throw new zzacc(this.zzbzc.position(), this.zzbzc.limit());
        }
        this.zzbzc.put(b);
    }

    public final void zzar(int i) throws zzacc {
        while ((i & (-128)) != 0) {
            zzap((i & 127) | 128);
            i >>>= 7;
        }
        zzap(i);
    }

    public final void zzb(int i, long j) throws zzacc {
        zzg(i, 0);
        zzas(j);
    }

    public final void zzb(int i, String str) throws zzacc {
        zzg(i, 2);
        try {
            int iZzas = zzas(str.length());
            if (iZzas != zzas(str.length() * 3)) {
                zzar(zza(str));
                zza(str, this.zzbzc);
                return;
            }
            int iPosition = this.zzbzc.position();
            if (this.zzbzc.remaining() < iZzas) {
                throw new zzacc(iPosition + iZzas, this.zzbzc.limit());
            }
            this.zzbzc.position(iPosition + iZzas);
            zza(str, this.zzbzc);
            int iPosition2 = this.zzbzc.position();
            this.zzbzc.position(iPosition);
            zzar((iPosition2 - iPosition) - iZzas);
            this.zzbzc.position(iPosition2);
        } catch (BufferOverflowException e) {
            zzacc zzaccVar = new zzacc(this.zzbzc.position(), this.zzbzc.limit());
            zzaccVar.initCause(e);
            throw zzaccVar;
        }
    }

    public final void zzb(zzacj zzacjVar) throws zzacc {
        zzar(zzacjVar.zzwa());
        zzacjVar.zza(this);
    }

    public final void zze(int i, int i2) throws zzacc {
        zzg(i, 0);
        if (i2 >= 0) {
            zzar(i2);
        } else {
            zzas(i2);
        }
    }

    public final void zzg(int i, int i2) throws zzacc {
        zzar((i << 3) | i2);
    }

    public final void zzk(byte[] bArr) throws zzacc {
        int length = bArr.length;
        if (this.zzbzc.remaining() < length) {
            throw new zzacc(this.zzbzc.position(), this.zzbzc.limit());
        }
        this.zzbzc.put(bArr, 0, length);
    }

    public final void zzvt() {
        if (this.zzbzc.remaining() != 0) {
            throw new IllegalStateException(String.format("Did not write as much data as expected, %s bytes remaining.", Integer.valueOf(this.zzbzc.remaining())));
        }
    }
}
