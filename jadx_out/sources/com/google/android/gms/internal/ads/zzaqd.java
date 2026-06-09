package com.google.android.gms.internal.ads;

import android.text.TextUtils;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzaqd implements com.google.android.gms.ads.internal.gmsg.zzv<zzapw> {
    @Override // com.google.android.gms.ads.internal.gmsg.zzv
    public final /* synthetic */ void zza(zzapw zzapwVar, Map map) {
        zzapw zzapwVar2 = zzapwVar;
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbae)).booleanValue()) {
            zzarl zzarlVarZztm = zzapwVar2.zztm();
            if (zzarlVarZztm == null) {
                try {
                    zzarl zzarlVar = new zzarl(zzapwVar2, Float.parseFloat((String) map.get("duration")), "1".equals(map.get("customControlsAllowed")), "1".equals(map.get("clickToExpandAllowed")));
                    zzapwVar2.zza(zzarlVar);
                    zzarlVarZztm = zzarlVar;
                } catch (NullPointerException | NumberFormatException e) {
                    zzakb.zzb("Unable to parse videoMeta message.", e);
                    com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "VideoMetaGmsgHandler.onGmsg");
                    return;
                }
            }
            boolean zEquals = "1".equals(map.get("muted"));
            float f = Float.parseFloat((String) map.get("currentTime"));
            int i = Integer.parseInt((String) map.get("playbackState"));
            if (i < 0 || 3 < i) {
                i = 0;
            }
            String str = (String) map.get("aspectRatio");
            float f2 = TextUtils.isEmpty(str) ? 0.0f : Float.parseFloat(str);
            if (zzakb.isLoggable(3)) {
                StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 79);
                sb.append("Video Meta GMSG: isMuted : ");
                sb.append(zEquals);
                sb.append(" , playbackState : ");
                sb.append(i);
                sb.append(" , aspectRatio : ");
                sb.append(str);
                zzakb.zzck(sb.toString());
            }
            zzarlVarZztm.zza(f, i, zEquals, f2);
        }
    }
}
