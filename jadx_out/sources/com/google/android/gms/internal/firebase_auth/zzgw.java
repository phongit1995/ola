package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgw {
    private static final int zzyb = 11;
    private static final int zzyc = 12;
    private static final int zzyd = 16;
    private static final int zzye = 26;
    public static final int[] zzti = new int[0];
    private static final long[] zzyf = new long[0];
    private static final float[] zzyg = new float[0];
    private static final double[] zzyh = new double[0];
    private static final boolean[] zzyi = new boolean[0];
    public static final String[] EMPTY_STRING_ARRAY = new String[0];
    private static final byte[][] zzyj = new byte[0][];
    public static final byte[] zzyk = new byte[0];

    public static final int zzb(zzgk zzgkVar, int i) throws zzgs {
        int position = zzgkVar.getPosition();
        zzgkVar.zzn(i);
        int i2 = 1;
        while (zzgkVar.zzcc() == i) {
            zzgkVar.zzn(i);
            i2++;
        }
        zzgkVar.zzs(position, i);
        return i2;
    }
}
