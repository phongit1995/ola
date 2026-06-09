package com.google.android.gms.internal.firebase_auth;

import java.nio.BufferOverflowException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.ReadOnlyBufferException;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgl {
    private final ByteBuffer zznk;
    private zzci zzxp;
    private int zzxq;

    private zzgl(ByteBuffer byteBuffer) {
        this.zznk = byteBuffer;
        this.zznk.order(ByteOrder.LITTLE_ENDIAN);
    }

    private zzgl(byte[] bArr, int i, int i2) {
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

    public static int zzaa(int i) {
        return zzai(i << 3);
    }

    public static int zzab(int i) {
        if (i >= 0) {
            return zzai(i);
        }
        return 10;
    }

    public static int zzai(int i) {
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

    public static int zzam(String str) {
        int iZza = zza(str);
        return zzai(iZza) + iZza;
    }

    private final void zzaz(int i) throws zzgm {
        byte b = (byte) i;
        if (!this.zznk.hasRemaining()) {
            throw new zzgm(this.zznk.position(), this.zznk.limit());
        }
        this.zznk.put(b);
    }

    public static int zzb(int i, zzgt zzgtVar) {
        int iZzaa = zzaa(i);
        int iZzdq = zzgtVar.zzdq();
        return iZzaa + zzai(iZzdq) + iZzdq;
    }

    public static int zzb(int i, String str) {
        return zzaa(i) + zzam(str);
    }

    public static int zzb(int i, byte[] bArr) {
        return zzaa(i) + zzai(bArr.length) + bArr.length;
    }

    private final void zzb(int i, int i2) throws zzgm {
        zzba((i << 3) | i2);
    }

    public static int zzd(int i, long j) {
        return zzaa(i) + zzn(j);
    }

    private static void zzd(CharSequence charSequence, ByteBuffer byteBuffer) {
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

    public static int zze(int i, long j) {
        return zzaa(i) + zzn(j);
    }

    public static zzgl zzf(byte[] bArr) {
        return zzj(bArr, 0, bArr.length);
    }

    public static int zzg(int i, int i2) {
        return zzaa(i) + zzab(i2);
    }

    public static zzgl zzj(byte[] bArr, int i, int i2) {
        return new zzgl(bArr, 0, i2);
    }

    private final void zzm(long j) throws zzgm {
        while ((j & (-128)) != 0) {
            zzaz((((int) j) & 127) | 128);
            j >>>= 7;
        }
        zzaz((int) j);
    }

    private static int zzn(long j) {
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

    public final void zza(int i, long j) throws zzgm {
        zzb(i, 0);
        zzm(j);
    }

    public final void zza(int i, zzgt zzgtVar) throws zzgm {
        zzb(i, 2);
        if (zzgtVar.zzya < 0) {
            zzgtVar.zzdq();
        }
        zzba(zzgtVar.zzya);
        zzgtVar.zza(this);
    }

    public final void zza(int i, String str) throws zzgm {
        zzb(i, 2);
        try {
            int iZzai = zzai(str.length());
            if (iZzai != zzai(str.length() * 3)) {
                zzba(zza(str));
                zzd(str, this.zznk);
                return;
            }
            int iPosition = this.zznk.position();
            if (this.zznk.remaining() < iZzai) {
                throw new zzgm(iPosition + iZzai, this.zznk.limit());
            }
            this.zznk.position(iPosition + iZzai);
            zzd(str, this.zznk);
            int iPosition2 = this.zznk.position();
            this.zznk.position(iPosition);
            zzba((iPosition2 - iPosition) - iZzai);
            this.zznk.position(iPosition2);
        } catch (BufferOverflowException e) {
            zzgm zzgmVar = new zzgm(this.zznk.position(), this.zznk.limit());
            zzgmVar.initCause(e);
            throw zzgmVar;
        }
    }

    public final void zza(int i, byte[] bArr) throws zzgm {
        zzb(i, 2);
        zzba(bArr.length);
        zzg(bArr);
    }

    public final void zzb(int i, boolean z) throws zzgm {
        zzb(i, 0);
        byte b = z ? (byte) 1 : (byte) 0;
        if (!this.zznk.hasRemaining()) {
            throw new zzgm(this.zznk.position(), this.zznk.limit());
        }
        this.zznk.put(b);
    }

    public final void zzba(int i) throws zzgm {
        while ((i & (-128)) != 0) {
            zzaz((i & 127) | 128);
            i >>>= 7;
        }
        zzaz(i);
    }

    public final void zzc(int i, int i2) throws zzgm {
        zzb(i, 0);
        if (i2 >= 0) {
            zzba(i2);
        } else {
            zzm(i2);
        }
    }

    public final void zze(int i, zzeh zzehVar) {
        if (this.zzxp != null) {
            if (this.zzxq != this.zznk.position()) {
                this.zzxp.write(this.zznk.array(), this.zzxq, this.zznk.position() - this.zzxq);
            }
            zzci zzciVar = this.zzxp;
            zzciVar.zza(13, zzehVar);
            zzciVar.flush();
            this.zzxq = this.zznk.position();
        }
        this.zzxp = zzci.zza(this.zznk);
        this.zzxq = this.zznk.position();
        zzci zzciVar2 = this.zzxp;
        zzciVar2.zza(13, zzehVar);
        zzciVar2.flush();
        this.zzxq = this.zznk.position();
    }

    public final void zzg(byte[] bArr) throws zzgm {
        int length = bArr.length;
        if (this.zznk.remaining() < length) {
            throw new zzgm(this.zznk.position(), this.zznk.limit());
        }
        this.zznk.put(bArr, 0, length);
    }

    public final void zzgm() {
        if (this.zznk.remaining() != 0) {
            throw new IllegalStateException(String.format("Did not write as much data as expected, %s bytes remaining.", Integer.valueOf(this.zznk.remaining())));
        }
    }

    public final void zzi(int i, long j) throws zzgm {
        zzb(i, 0);
        zzm(j);
    }
}
