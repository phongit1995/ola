package com.google.android.gms.internal.ads;

import android.content.Context;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzahx extends zzajx implements zzahw {
    private final Context mContext;
    private final Object mLock;
    private final zzaji zzbze;
    private final long zzclp;
    private final ArrayList<zzahn> zzcmd;
    private final List<zzahq> zzcme;
    private final HashSet<String> zzcmf;
    private final zzago zzcmg;

    public zzahx(Context context, zzaji zzajiVar, zzago zzagoVar) {
        this(context, zzajiVar, zzagoVar, ((Long) zzkb.zzik().zzd(zznk.zzaye)).longValue());
    }

    @VisibleForTesting
    private zzahx(Context context, zzaji zzajiVar, zzago zzagoVar, long j) {
        this.zzcmd = new ArrayList<>();
        this.zzcme = new ArrayList();
        this.zzcmf = new HashSet<>();
        this.mLock = new Object();
        this.mContext = context;
        this.zzbze = zzajiVar;
        this.zzcmg = zzagoVar;
        this.zzclp = j;
    }

    private final zzajh zza(int i, @Nullable String str, @Nullable zzwx zzwxVar) {
        zzjn zzjnVar;
        boolean z;
        String str2;
        long j;
        String strSubstring;
        long j2;
        int i2;
        zzjj zzjjVar = this.zzbze.zzcgs.zzccv;
        List<String> list = this.zzbze.zzcos.zzbsn;
        List<String> list2 = this.zzbze.zzcos.zzbso;
        List<String> list3 = this.zzbze.zzcos.zzces;
        int i3 = this.zzbze.zzcos.orientation;
        long j3 = this.zzbze.zzcos.zzbsu;
        String str3 = this.zzbze.zzcgs.zzccy;
        boolean z2 = this.zzbze.zzcos.zzceq;
        zzwy zzwyVar = this.zzbze.zzcod;
        long j4 = this.zzbze.zzcos.zzcer;
        zzjn zzjnVar2 = this.zzbze.zzacv;
        long j5 = this.zzbze.zzcos.zzcep;
        long j6 = this.zzbze.zzcoh;
        long j7 = this.zzbze.zzcos.zzceu;
        String str4 = this.zzbze.zzcos.zzcev;
        JSONObject jSONObject = this.zzbze.zzcob;
        zzaig zzaigVar = this.zzbze.zzcos.zzcfe;
        List<String> list4 = this.zzbze.zzcos.zzcff;
        List<String> list5 = this.zzbze.zzcos.zzcfg;
        boolean z3 = this.zzbze.zzcos.zzcfh;
        zzael zzaelVar = this.zzbze.zzcos.zzcfi;
        StringBuilder sb = new StringBuilder("");
        if (this.zzcme == null) {
            strSubstring = sb.toString();
            zzjnVar = zzjnVar2;
            z = z2;
            str2 = str4;
            j = j7;
        } else {
            Iterator<zzahq> it2 = this.zzcme.iterator();
            while (true) {
                zzjnVar = zzjnVar2;
                if (it2.hasNext()) {
                    zzahq next = it2.next();
                    if (next != null) {
                        Iterator<zzahq> it3 = it2;
                        if (TextUtils.isEmpty(next.zzbru)) {
                            zzjnVar2 = zzjnVar;
                            it2 = it3;
                        } else {
                            String str5 = next.zzbru;
                            String str6 = str4;
                            switch (next.errorCode) {
                                case 3:
                                    j2 = j7;
                                    i2 = 1;
                                    break;
                                case 4:
                                    j2 = j7;
                                    i2 = 2;
                                    break;
                                case 5:
                                    j2 = j7;
                                    i2 = 4;
                                    break;
                                case 6:
                                    j2 = j7;
                                    i2 = 0;
                                    break;
                                case 7:
                                    j2 = j7;
                                    i2 = 3;
                                    break;
                                default:
                                    j2 = j7;
                                    i2 = 6;
                                    break;
                            }
                            long j8 = next.zzbub;
                            boolean z4 = z2;
                            StringBuilder sb2 = new StringBuilder(String.valueOf(str5).length() + 33);
                            sb2.append(str5);
                            sb2.append(".");
                            sb2.append(i2);
                            sb2.append(".");
                            sb2.append(j8);
                            sb.append(String.valueOf(sb2.toString()).concat("_"));
                            zzjnVar2 = zzjnVar;
                            it2 = it3;
                            str4 = str6;
                            j7 = j2;
                            z2 = z4;
                        }
                    } else {
                        zzjnVar2 = zzjnVar;
                    }
                } else {
                    z = z2;
                    str2 = str4;
                    j = j7;
                    strSubstring = sb.substring(0, Math.max(0, sb.length() - 1));
                }
            }
        }
        return new zzajh(zzjjVar, null, list, i, list2, list3, i3, j3, str3, z, zzwxVar, null, str, zzwyVar, null, j4, zzjnVar, j5, j6, j, str2, jSONObject, null, zzaigVar, list4, list5, z3, zzaelVar, strSubstring, this.zzbze.zzcos.zzbsr, this.zzbze.zzcos.zzcfl, this.zzbze.zzcoq, this.zzbze.zzcos.zzzl, this.zzbze.zzcor, this.zzbze.zzcos.zzcfp, this.zzbze.zzcos.zzbsp, this.zzbze.zzcos.zzzm, this.zzbze.zzcos.zzcfq);
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void onStop() {
    }

    @Override // com.google.android.gms.internal.ads.zzahw
    public final void zza(String str, int i) {
    }

    @Override // com.google.android.gms.internal.ads.zzahw
    public final void zzcb(String str) {
        synchronized (this.mLock) {
            this.zzcmf.add(str);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:116:0x004f A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:127:? -> B:36:0x00ba). Please report as a decompilation issue!!! */
    @Override // com.google.android.gms.internal.ads.zzajx
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zzdn() throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 442
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzahx.zzdn():void");
    }

    final /* synthetic */ void zzl(zzajh zzajhVar) {
        this.zzcmg.zzot().zzb(zzajhVar);
    }

    final /* synthetic */ void zzm(zzajh zzajhVar) {
        this.zzcmg.zzot().zzb(zzajhVar);
    }
}
