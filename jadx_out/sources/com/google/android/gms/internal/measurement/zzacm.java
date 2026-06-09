package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
public final class zzacm {
    private static final int zzbzp = 11;
    private static final int zzbzq = 12;
    private static final int zzbzr = 16;
    private static final int zzbzs = 26;
    public static final int[] zzbvp = new int[0];
    public static final long[] zzbzt = new long[0];
    private static final float[] zzbzu = new float[0];
    private static final double[] zzbzv = new double[0];
    private static final boolean[] zzbzw = new boolean[0];
    public static final String[] zzbzx = new String[0];
    private static final byte[][] zzbzy = new byte[0][];
    public static final byte[] zzbzz = new byte[0];

    public static final int zzb(zzaca zzacaVar, int i) throws zzaci {
        int position = zzacaVar.getPosition();
        zzacaVar.zzak(i);
        int i2 = 1;
        while (zzacaVar.zzvl() == i) {
            zzacaVar.zzak(i);
            i2++;
        }
        zzacaVar.zzd(position, i);
        return i2;
    }
}
