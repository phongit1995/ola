package com.google.android.gms.internal.ads;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.facebook.share.internal.ShareConstants;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzapx {
    private final Context mContext;
    private final String zzchp;

    @Nullable
    private final zznx zzcxo;
    private boolean zzcxs;

    @Nullable
    private final zznv zzdad;
    private final long[] zzdaf;
    private final String[] zzdag;
    private zzapg zzdal;
    private boolean zzdam;
    private boolean zzdan;
    private final zzang zzzw;
    private final zzalp zzdae = new zzals().zza("min_1", Double.MIN_VALUE, 1.0d).zza("1_5", 1.0d, 5.0d).zza("5_10", 5.0d, 10.0d).zza("10_20", 10.0d, 20.0d).zza("20_30", 20.0d, 30.0d).zza("30_max", 30.0d, Double.MAX_VALUE).zzrz();
    private boolean zzdah = false;
    private boolean zzdai = false;
    private boolean zzdaj = false;
    private boolean zzdak = false;
    private long zzdao = -1;

    public zzapx(Context context, zzang zzangVar, String str, @Nullable zznx zznxVar, @Nullable zznv zznvVar) {
        this.mContext = context;
        this.zzzw = zzangVar;
        this.zzchp = str;
        this.zzcxo = zznxVar;
        this.zzdad = zznvVar;
        String str2 = (String) zzkb.zzik().zzd(zznk.zzave);
        if (str2 == null) {
            this.zzdag = new String[0];
            this.zzdaf = new long[0];
            return;
        }
        String[] strArrSplit = TextUtils.split(str2, ",");
        this.zzdag = new String[strArrSplit.length];
        this.zzdaf = new long[strArrSplit.length];
        for (int i = 0; i < strArrSplit.length; i++) {
            try {
                this.zzdaf[i] = Long.parseLong(strArrSplit[i]);
            } catch (NumberFormatException e) {
                zzakb.zzc("Unable to parse frame hash target time number.", e);
                this.zzdaf[i] = -1;
            }
        }
    }

    public final void onStop() {
        if (!((Boolean) zzkb.zzik().zzd(zznk.zzavd)).booleanValue() || this.zzdam) {
            return;
        }
        Bundle bundle = new Bundle();
        bundle.putString("type", "native-player-metrics");
        bundle.putString(ShareConstants.WEB_DIALOG_RESULT_PARAM_REQUEST_ID, this.zzchp);
        bundle.putString("player", this.zzdal.zzsp());
        for (zzalr zzalrVar : this.zzdae.zzry()) {
            String strValueOf = String.valueOf("fps_c_");
            String strValueOf2 = String.valueOf(zzalrVar.name);
            bundle.putString(strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf), Integer.toString(zzalrVar.count));
            String strValueOf3 = String.valueOf("fps_p_");
            String strValueOf4 = String.valueOf(zzalrVar.name);
            bundle.putString(strValueOf4.length() != 0 ? strValueOf3.concat(strValueOf4) : new String(strValueOf3), Double.toString(zzalrVar.zzctb));
        }
        for (int i = 0; i < this.zzdaf.length; i++) {
            String str = this.zzdag[i];
            if (str != null) {
                String strValueOf5 = String.valueOf(Long.valueOf(this.zzdaf[i]));
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf5).length() + 3);
                sb.append("fh_");
                sb.append(strValueOf5);
                bundle.putString(sb.toString(), str);
            }
        }
        com.google.android.gms.ads.internal.zzbv.zzek().zza(this.mContext, this.zzzw.zzcw, "gmob-apps", bundle, true);
        this.zzdam = true;
    }

    public final void zzb(zzapg zzapgVar) {
        zznq.zza(this.zzcxo, this.zzdad, "vpc2");
        this.zzdah = true;
        if (this.zzcxo != null) {
            this.zzcxo.zze("vpn", zzapgVar.zzsp());
        }
        this.zzdal = zzapgVar;
    }

    public final void zzc(zzapg zzapgVar) {
        if (this.zzdaj && !this.zzdak) {
            if (zzakb.zzqp() && !this.zzdak) {
                zzakb.v("VideoMetricsMixin first frame");
            }
            zznq.zza(this.zzcxo, this.zzdad, "vff2");
            this.zzdak = true;
        }
        long jNanoTime = com.google.android.gms.ads.internal.zzbv.zzer().nanoTime();
        if (this.zzcxs && this.zzdan && this.zzdao != -1) {
            this.zzdae.zza(TimeUnit.SECONDS.toNanos(1L) / (jNanoTime - this.zzdao));
        }
        this.zzdan = this.zzcxs;
        this.zzdao = jNanoTime;
        long jLongValue = ((Long) zzkb.zzik().zzd(zznk.zzavf)).longValue();
        long currentPosition = zzapgVar.getCurrentPosition();
        for (int i = 0; i < this.zzdag.length; i++) {
            if (this.zzdag[i] == null && jLongValue > Math.abs(currentPosition - this.zzdaf[i])) {
                String[] strArr = this.zzdag;
                int i2 = 8;
                Bitmap bitmap = zzapgVar.getBitmap(8, 8);
                long j = 63;
                int i3 = 0;
                long j2 = 0;
                while (i3 < i2) {
                    long j3 = j;
                    int i4 = 0;
                    while (i4 < i2) {
                        int pixel = bitmap.getPixel(i4, i3);
                        long j4 = j2 | (((Color.blue(pixel) + Color.red(pixel)) + Color.green(pixel) > 128 ? 1L : 0L) << ((int) j3));
                        i4++;
                        j3--;
                        j2 = j4;
                        i2 = 8;
                    }
                    i3++;
                    j = j3;
                    i2 = 8;
                }
                strArr[i] = String.format("%016X", Long.valueOf(j2));
                return;
            }
        }
    }

    public final void zzsv() {
        if (!this.zzdah || this.zzdai) {
            return;
        }
        zznq.zza(this.zzcxo, this.zzdad, "vfr2");
        this.zzdai = true;
    }

    public final void zztt() {
        this.zzcxs = true;
        if (!this.zzdai || this.zzdaj) {
            return;
        }
        zznq.zza(this.zzcxo, this.zzdad, "vfp2");
        this.zzdaj = true;
    }

    public final void zztu() {
        this.zzcxs = false;
    }
}
