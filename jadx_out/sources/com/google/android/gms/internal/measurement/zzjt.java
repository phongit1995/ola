package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.content.pm.PackageManager;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Size;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import android.util.Pair;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.Wrappers;
import com.google.android.gms.internal.measurement.zzez;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/* JADX INFO: loaded from: classes2.dex */
public class zzjt implements zzhk {
    private static volatile zzjt zzarr;
    private final zzgn zzacv;
    private zzgh zzars;
    private zzfm zzart;
    private zzek zzaru;
    private zzfr zzarv;
    private zzjp zzarw;
    private zzed zzarx;
    private final zzjz zzary;
    private boolean zzarz;

    @VisibleForTesting
    private long zzasa;
    private List<Runnable> zzasb;
    private int zzasc;
    private int zzasd;
    private boolean zzase;
    private boolean zzasf;
    private boolean zzasg;
    private FileLock zzash;
    private FileChannel zzasi;
    private List<Long> zzasj;
    private List<Long> zzask;
    private long zzasl;
    private boolean zzvn;

    class zza implements zzem {
        zzku zzasp;
        List<Long> zzasq;
        List<zzkr> zzasr;
        private long zzass;

        private zza() {
        }

        /* synthetic */ zza(zzjt zzjtVar, zzju zzjuVar) {
            this();
        }

        private static long zza(zzkr zzkrVar) {
            return ((zzkrVar.zzavb.longValue() / 1000) / 60) / 60;
        }

        @Override // com.google.android.gms.internal.measurement.zzem
        public final boolean zza(long j, zzkr zzkrVar) {
            Preconditions.checkNotNull(zzkrVar);
            if (this.zzasr == null) {
                this.zzasr = new ArrayList();
            }
            if (this.zzasq == null) {
                this.zzasq = new ArrayList();
            }
            if (this.zzasr.size() > 0 && zza(this.zzasr.get(0)) != zza(zzkrVar)) {
                return false;
            }
            long jZzwb = this.zzass + ((long) zzkrVar.zzwb());
            if (jZzwb >= Math.max(0, zzez.zzaim.get().intValue())) {
                return false;
            }
            this.zzass = jZzwb;
            this.zzasr.add(zzkrVar);
            this.zzasq.add(Long.valueOf(j));
            return this.zzasr.size() < Math.max(1, zzez.zzain.get().intValue());
        }

        @Override // com.google.android.gms.internal.measurement.zzem
        public final void zzb(zzku zzkuVar) {
            Preconditions.checkNotNull(zzkuVar);
            this.zzasp = zzkuVar;
        }
    }

    private zzjt(zzjy zzjyVar) {
        this(zzjyVar, null);
    }

    private zzjt(zzjy zzjyVar, zzgn zzgnVar) {
        this.zzvn = false;
        Preconditions.checkNotNull(zzjyVar);
        this.zzacv = zzgn.zza(zzjyVar.zzqx, null, null);
        this.zzasl = -1L;
        zzjz zzjzVar = new zzjz(this);
        zzjzVar.zzm();
        this.zzary = zzjzVar;
        zzfm zzfmVar = new zzfm(this);
        zzfmVar.zzm();
        this.zzart = zzfmVar;
        zzgh zzghVar = new zzgh(this);
        zzghVar.zzm();
        this.zzars = zzghVar;
        this.zzacv.zzgh().zzc(new zzju(this, zzjyVar));
    }

    @WorkerThread
    @VisibleForTesting
    private final int zza(FileChannel fileChannel) {
        zzab();
        if (fileChannel == null || !fileChannel.isOpen()) {
            this.zzacv.zzgi().zziv().log("Bad channel to read from");
            return 0;
        }
        ByteBuffer byteBufferAllocate = ByteBuffer.allocate(4);
        try {
            fileChannel.position(0L);
            int i = fileChannel.read(byteBufferAllocate);
            if (i == 4) {
                byteBufferAllocate.flip();
                return byteBufferAllocate.getInt();
            }
            if (i != -1) {
                this.zzacv.zzgi().zziy().zzg("Unexpected data length. Bytes read", Integer.valueOf(i));
            }
            return 0;
        } catch (IOException e) {
            this.zzacv.zzgi().zziv().zzg("Failed to read from channel", e);
            return 0;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:18:0x0057 A[Catch: NameNotFoundException -> 0x00bb, TryCatch #1 {NameNotFoundException -> 0x00bb, blocks: (B:16:0x004c, B:18:0x0057, B:20:0x0065, B:21:0x006a), top: B:34:0x004c }] */
    /* JADX WARN: Removed duplicated region for block: B:23:0x006f  */
    /* JADX WARN: Removed duplicated region for block: B:26:0x0087  */
    /* JADX WARN: Removed duplicated region for block: B:27:0x008a  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final com.google.android.gms.internal.measurement.zzeb zza(android.content.Context r26, java.lang.String r27, java.lang.String r28, boolean r29, boolean r30, boolean r31, long r32) {
        /*
            Method dump skipped, instruction units count: 207
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzjt.zza(android.content.Context, java.lang.String, java.lang.String, boolean, boolean, boolean, long):com.google.android.gms.internal.measurement.zzeb");
    }

    private static void zza(zzjs zzjsVar) {
        if (zzjsVar == null) {
            throw new IllegalStateException("Upload Component not created");
        }
        if (zzjsVar.isInitialized()) {
            return;
        }
        String strValueOf = String.valueOf(zzjsVar.getClass());
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 27);
        sb.append("Component not initialized: ");
        sb.append(strValueOf);
        throw new IllegalStateException(sb.toString());
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zza(zzjy zzjyVar) {
        this.zzacv.zzgh().zzab();
        zzek zzekVar = new zzek(this);
        zzekVar.zzm();
        this.zzaru = zzekVar;
        this.zzacv.zzgk().zza(this.zzars);
        zzed zzedVar = new zzed(this);
        zzedVar.zzm();
        this.zzarx = zzedVar;
        zzjp zzjpVar = new zzjp(this);
        zzjpVar.zzm();
        this.zzarw = zzjpVar;
        this.zzarv = new zzfr(this);
        if (this.zzasc != this.zzasd) {
            this.zzacv.zzgi().zziv().zze("Not all upload components initialized", Integer.valueOf(this.zzasc), Integer.valueOf(this.zzasd));
        }
        this.zzvn = true;
    }

    @WorkerThread
    @VisibleForTesting
    private final boolean zza(int i, FileChannel fileChannel) {
        zzab();
        if (fileChannel == null || !fileChannel.isOpen()) {
            this.zzacv.zzgi().zziv().log("Bad channel to read from");
            return false;
        }
        ByteBuffer byteBufferAllocate = ByteBuffer.allocate(4);
        byteBufferAllocate.putInt(i);
        byteBufferAllocate.flip();
        try {
            fileChannel.truncate(0L);
            fileChannel.write(byteBufferAllocate);
            fileChannel.force(true);
            if (fileChannel.size() != 4) {
                this.zzacv.zzgi().zziv().zzg("Error writing to channel. Bytes written", Long.valueOf(fileChannel.size()));
            }
            return true;
        } catch (IOException e) {
            this.zzacv.zzgi().zziv().zzg("Failed to write to channel", e);
            return false;
        }
    }

    private final boolean zza(String str, zzex zzexVar) {
        long jLongValue;
        zzkc zzkcVar;
        String string = zzexVar.zzahg.getString(FirebaseAnalytics.Param.CURRENCY);
        if (FirebaseAnalytics.Event.ECOMMERCE_PURCHASE.equals(zzexVar.name)) {
            double dDoubleValue = zzexVar.zzahg.zzbk(FirebaseAnalytics.Param.VALUE).doubleValue() * 1000000.0d;
            if (dDoubleValue == 0.0d) {
                dDoubleValue = zzexVar.zzahg.getLong(FirebaseAnalytics.Param.VALUE).longValue() * 1000000.0d;
            }
            if (dDoubleValue > 9.223372036854776E18d || dDoubleValue < -9.223372036854776E18d) {
                this.zzacv.zzgi().zziy().zze("Data lost. Currency value is too big. appId", zzfi.zzbp(str), Double.valueOf(dDoubleValue));
                return false;
            }
            jLongValue = Math.round(dDoubleValue);
        } else {
            jLongValue = zzexVar.zzahg.getLong(FirebaseAnalytics.Param.VALUE).longValue();
        }
        if (!TextUtils.isEmpty(string)) {
            String upperCase = string.toUpperCase(Locale.US);
            if (upperCase.matches("[A-Z]{3}")) {
                String strValueOf = String.valueOf("_ltv_");
                String strValueOf2 = String.valueOf(upperCase);
                String strConcat = strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf);
                zzkc zzkcVarZzh = zzjh().zzh(str, strConcat);
                if (zzkcVarZzh == null || !(zzkcVarZzh.value instanceof Long)) {
                    zzek zzekVarZzjh = zzjh();
                    int iZzb = this.zzacv.zzgk().zzb(str, zzez.zzaji) - 1;
                    Preconditions.checkNotEmpty(str);
                    zzekVarZzjh.zzab();
                    zzekVarZzjh.zzch();
                    try {
                        zzekVarZzjh.getWritableDatabase().execSQL("delete from user_attributes where app_id=? and name in (select name from user_attributes where app_id=? and name like '_ltv_%' order by set_timestamp desc limit ?,10);", new String[]{str, str, String.valueOf(iZzb)});
                    } catch (SQLiteException e) {
                        zzekVarZzjh.zzgi().zziv().zze("Error pruning currencies. appId", zzfi.zzbp(str), e);
                    }
                    zzkcVar = new zzkc(str, zzexVar.origin, strConcat, this.zzacv.zzbt().currentTimeMillis(), Long.valueOf(jLongValue));
                } else {
                    zzkcVar = new zzkc(str, zzexVar.origin, strConcat, this.zzacv.zzbt().currentTimeMillis(), Long.valueOf(((Long) zzkcVarZzh.value).longValue() + jLongValue));
                }
                if (!zzjh().zza(zzkcVar)) {
                    this.zzacv.zzgi().zziv().zzd("Too many unique user properties are set. Ignoring user property. appId", zzfi.zzbp(str), this.zzacv.zzgf().zzbo(zzkcVar.name), zzkcVar.value);
                    this.zzacv.zzgg().zza(str, 9, (String) null, (String) null, 0);
                }
            }
        }
        return true;
    }

    private final zzkp[] zza(String str, zzkx[] zzkxVarArr, zzkr[] zzkrVarArr) {
        Preconditions.checkNotEmpty(str);
        return zzjg().zza(str, zzkrVarArr, zzkxVarArr);
    }

    @WorkerThread
    private final void zzab() {
        this.zzacv.zzgh().zzab();
    }

    @WorkerThread
    private final void zzb(zzea zzeaVar) {
        ArrayMap arrayMap;
        zzab();
        if (TextUtils.isEmpty(zzeaVar.getGmpAppId())) {
            zzb(zzeaVar.zzah(), 204, null, null, null);
            return;
        }
        zzeh zzehVarZzgk = this.zzacv.zzgk();
        String gmpAppId = zzeaVar.getGmpAppId();
        String appInstanceId = zzeaVar.getAppInstanceId();
        Uri.Builder builder = new Uri.Builder();
        Uri.Builder builderEncodedAuthority = builder.scheme(zzez.zzaii.get()).encodedAuthority(zzez.zzaij.get());
        String strValueOf = String.valueOf(gmpAppId);
        builderEncodedAuthority.path(strValueOf.length() != 0 ? "config/app/".concat(strValueOf) : new String("config/app/")).appendQueryParameter("app_instance_id", appInstanceId).appendQueryParameter("platform", AccountKitGraphConstants.SDK_TYPE_ANDROID).appendQueryParameter("gmp_version", String.valueOf(zzehVarZzgk.zzgw()));
        String string = builder.build().toString();
        try {
            URL url = new URL(string);
            this.zzacv.zzgi().zzjc().zzg("Fetching remote configuration", zzeaVar.zzah());
            zzkn zzknVarZzbx = zzky().zzbx(zzeaVar.zzah());
            String strZzby = zzky().zzby(zzeaVar.zzah());
            if (zzknVarZzbx == null || TextUtils.isEmpty(strZzby)) {
                arrayMap = null;
            } else {
                ArrayMap arrayMap2 = new ArrayMap();
                arrayMap2.put("If-Modified-Since", strZzby);
                arrayMap = arrayMap2;
            }
            this.zzase = true;
            zzfm zzfmVarZzkz = zzkz();
            String strZzah = zzeaVar.zzah();
            zzjw zzjwVar = new zzjw(this);
            zzfmVarZzkz.zzab();
            zzfmVarZzkz.zzch();
            Preconditions.checkNotNull(url);
            Preconditions.checkNotNull(zzjwVar);
            zzfmVarZzkz.zzgh().zzd(new zzfq(zzfmVarZzkz, strZzah, url, null, arrayMap, zzjwVar));
        } catch (MalformedURLException unused) {
            this.zzacv.zzgi().zziv().zze("Failed to parse config URL. Not fetching. appId", zzfi.zzbp(zzeaVar.zzah()), string);
        }
    }

    @WorkerThread
    private final Boolean zzc(zzea zzeaVar) {
        try {
            if (zzeaVar.zzgu() != -2147483648L) {
                if (zzeaVar.zzgu() == Wrappers.packageManager(this.zzacv.getContext()).getPackageInfo(zzeaVar.zzah(), 0).versionCode) {
                    return true;
                }
            } else {
                String str = Wrappers.packageManager(this.zzacv.getContext()).getPackageInfo(zzeaVar.zzah(), 0).versionName;
                if (zzeaVar.zzag() != null && zzeaVar.zzag().equals(str)) {
                    return true;
                }
            }
            return false;
        } catch (PackageManager.NameNotFoundException unused) {
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:139:0x05c9 A[Catch: all -> 0x063d, TryCatch #0 {all -> 0x063d, blocks: (B:32:0x0105, B:34:0x0112, B:41:0x0131, B:43:0x0177, B:45:0x017c, B:46:0x0195, B:50:0x01a6, B:52:0x01bd, B:54:0x01c3, B:55:0x01dc, B:59:0x01fe, B:63:0x0226, B:64:0x023f, B:67:0x024e, B:69:0x026d, B:70:0x028b, B:72:0x0299, B:73:0x02b0, B:75:0x02d3, B:78:0x02e3, B:81:0x031f, B:83:0x0346, B:87:0x0398, B:91:0x03b6, B:93:0x03c6, B:95:0x03d0, B:97:0x03d4, B:109:0x043e, B:111:0x048d, B:113:0x0493, B:114:0x0495, B:116:0x04a1, B:117:0x0503, B:118:0x0522, B:120:0x0528, B:122:0x055b, B:123:0x0563, B:125:0x056b, B:126:0x0571, B:128:0x0577, B:137:0x05c3, B:139:0x05c9, B:142:0x05e3, B:144:0x05f7, B:131:0x0586, B:133:0x05ae, B:141:0x05cd, B:98:0x03e1, B:100:0x03f3, B:102:0x03f7, B:104:0x0409, B:108:0x043c, B:105:0x0421, B:107:0x0427, B:90:0x03b0, B:86:0x0391, B:82:0x0338, B:36:0x011c, B:38:0x0122), top: B:150:0x0105, inners: #1 }] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void zzc(com.google.android.gms.internal.measurement.zzex r32, com.google.android.gms.internal.measurement.zzeb r33) {
        /*
            Method dump skipped, instruction units count: 1607
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzjt.zzc(com.google.android.gms.internal.measurement.zzex, com.google.android.gms.internal.measurement.zzeb):void");
    }

    @WorkerThread
    private final zzeb zzce(String str) {
        String str2;
        Object objZzbp;
        zzfk zzfkVarZzjb;
        String str3 = str;
        zzea zzeaVarZzbf = zzjh().zzbf(str3);
        if (zzeaVarZzbf == null || TextUtils.isEmpty(zzeaVarZzbf.zzag())) {
            str2 = "No app data available; dropping";
            zzfkVarZzjb = this.zzacv.zzgi().zzjb();
            objZzbp = str3;
        } else {
            Boolean boolZzc = zzc(zzeaVarZzbf);
            if (boolZzc == null || boolZzc.booleanValue()) {
                return new zzeb(str3, zzeaVarZzbf.getGmpAppId(), zzeaVarZzbf.zzag(), zzeaVarZzbf.zzgu(), zzeaVarZzbf.zzgv(), zzeaVarZzbf.zzgw(), zzeaVarZzbf.zzgx(), (String) null, zzeaVarZzbf.isMeasurementEnabled(), false, zzeaVarZzbf.zzgr(), zzeaVarZzbf.zzhk(), 0L, 0, zzeaVarZzbf.zzhl(), zzeaVarZzbf.zzhm(), false);
            }
            str2 = "App version does not match; dropping. appId";
            zzfkVarZzjb = this.zzacv.zzgi().zziv();
            objZzbp = zzfi.zzbp(str);
        }
        zzfkVarZzjb.zzg(str2, objZzbp);
        return null;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:100:0x0248 A[Catch: all -> 0x0b96, PHI: r3 r4 r6
      0x0248: PHI (r3v4 ??) = (r3v57 ??), (r3v58 ??) binds: [B:120:0x0282, B:99:0x0246] A[DONT_GENERATE, DONT_INLINE]
      0x0248: PHI (r4v2 ??) = (r4v44 ??), (r4v45 ??) binds: [B:120:0x0282, B:99:0x0246] A[DONT_GENERATE, DONT_INLINE]
      0x0248: PHI (r6v6 ??) = (r6v181 ??), (r6v182 ??) binds: [B:120:0x0282, B:99:0x0246] A[DONT_GENERATE, DONT_INLINE], TRY_ENTER, TRY_LEAVE, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:173:0x039b A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:176:0x03a9 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:188:0x0432 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:191:0x04a3  */
    /* JADX WARN: Removed duplicated region for block: B:205:0x04db  */
    /* JADX WARN: Removed duplicated region for block: B:213:0x0538 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:223:0x0571  */
    /* JADX WARN: Removed duplicated region for block: B:224:0x0573 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:225:0x0580 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:227:0x0599 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:240:0x05ef  */
    /* JADX WARN: Removed duplicated region for block: B:316:0x07fd A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:317:0x080c  */
    /* JADX WARN: Removed duplicated region for block: B:319:0x080f A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:321:0x0831 A[Catch: all -> 0x0b96, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:431:0x0b92 A[Catch: all -> 0x0b96, TRY_ENTER, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:453:0x0145 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:492:? A[Catch: all -> 0x0b96, SYNTHETIC, TRY_LEAVE, TryCatch #12 {all -> 0x0b96, blocks: (B:3:0x0009, B:26:0x0088, B:122:0x0285, B:124:0x0289, B:130:0x0297, B:131:0x02b4, B:133:0x02bc, B:135:0x02d4, B:137:0x0305, B:143:0x0319, B:145:0x0323, B:242:0x05f8, B:147:0x0340, B:149:0x0350, B:165:0x038a, B:227:0x0599, B:229:0x05a3, B:231:0x05a7, B:234:0x05ad, B:236:0x05ba, B:237:0x05ce, B:238:0x05d2, B:241:0x05f0, B:239:0x05da, B:156:0x036d, B:159:0x0377, B:162:0x0381, B:171:0x0397, B:173:0x039b, B:174:0x03a0, B:176:0x03a9, B:178:0x03bb, B:182:0x03dd, B:179:0x03c7, B:181:0x03d3, B:186:0x03f0, B:188:0x0432, B:189:0x0472, B:192:0x04a4, B:194:0x04a9, B:196:0x04b7, B:198:0x04c0, B:199:0x04c6, B:201:0x04c9, B:202:0x04d2, B:203:0x04d5, B:206:0x04dc, B:209:0x04e6, B:211:0x0519, B:213:0x0538, B:219:0x0555, B:216:0x054a, B:222:0x0560, B:224:0x0573, B:225:0x0580, B:243:0x05fe, B:245:0x0608, B:247:0x0614, B:249:0x0622, B:252:0x0627, B:254:0x066b, B:255:0x068b, B:257:0x0690, B:259:0x069e, B:263:0x06aa, B:266:0x06ca, B:260:0x06a4, B:253:0x064e, B:267:0x06e2, B:269:0x06fe, B:271:0x0719, B:273:0x0725, B:275:0x0738, B:276:0x0747, B:278:0x074b, B:280:0x0757, B:281:0x0766, B:283:0x076a, B:285:0x0772, B:287:0x078a, B:356:0x097b, B:291:0x07a4, B:295:0x07b7, B:297:0x07bd, B:299:0x07cb, B:301:0x07cf, B:316:0x07fd, B:319:0x080f, B:321:0x0831, B:323:0x083b, B:325:0x084b, B:326:0x0883, B:330:0x0893, B:332:0x089a, B:334:0x08a4, B:336:0x08a8, B:338:0x08ac, B:340:0x08b0, B:341:0x08bc, B:343:0x08c2, B:345:0x08e0, B:346:0x08e9, B:347:0x08ff, B:349:0x091b, B:351:0x094a, B:352:0x0958, B:353:0x0969, B:355:0x0971, B:303:0x07d7, B:305:0x07db, B:307:0x07e3, B:309:0x07e7, B:312:0x07f1, B:357:0x0989, B:359:0x0991, B:360:0x0999, B:361:0x09a1, B:363:0x09a7, B:365:0x09be, B:366:0x09d2, B:368:0x09d7, B:370:0x09eb, B:371:0x09ef, B:373:0x09ff, B:374:0x0a03, B:375:0x0a06, B:377:0x0a16, B:393:0x0a8a, B:395:0x0a8f, B:397:0x0aa2, B:400:0x0aa7, B:401:0x0aa9, B:406:0x0ad4, B:402:0x0aac, B:404:0x0ab6, B:405:0x0abd, B:407:0x0add, B:408:0x0af4, B:411:0x0afc, B:412:0x0b01, B:413:0x0b11, B:415:0x0b2b, B:416:0x0b44, B:417:0x0b4c, B:422:0x0b6e, B:421:0x0b5d, B:378:0x0a2e, B:380:0x0a33, B:382:0x0a3d, B:384:0x0a43, B:390:0x0a55, B:392:0x0a5b, B:425:0x0b7e, B:53:0x0136, B:77:0x01d7, B:431:0x0b92, B:432:0x0b95, B:100:0x0248), top: B:449:0x0009, inners: #5 }] */
    /* JADX WARN: Removed duplicated region for block: B:51:0x0123 A[Catch: all -> 0x013b, SQLiteException -> 0x0140, TRY_ENTER, TRY_LEAVE, TryCatch #20 {SQLiteException -> 0x0140, all -> 0x013b, blocks: (B:51:0x0123, B:63:0x015c, B:67:0x0178), top: B:455:0x0121 }] */
    /* JADX WARN: Type inference failed for: r12v0 */
    /* JADX WARN: Type inference failed for: r12v1 */
    /* JADX WARN: Type inference failed for: r12v2, types: [java.lang.String] */
    /* JADX WARN: Type inference failed for: r12v3 */
    /* JADX WARN: Type inference failed for: r12v45 */
    /* JADX WARN: Type inference failed for: r12v56 */
    /* JADX WARN: Type inference failed for: r12v58, types: [java.lang.String[]] */
    /* JADX WARN: Type inference failed for: r12v60 */
    /* JADX WARN: Type inference failed for: r12v62 */
    /* JADX WARN: Type inference failed for: r12v68 */
    /* JADX WARN: Type inference failed for: r12v71, types: [java.lang.String[]] */
    /* JADX WARN: Type inference failed for: r12v76 */
    /* JADX WARN: Type inference failed for: r12v80, types: [java.lang.String] */
    /* JADX WARN: Type inference failed for: r12v82 */
    /* JADX WARN: Type inference failed for: r15v18, types: [android.database.sqlite.SQLiteDatabase] */
    /* JADX WARN: Type inference failed for: r16v10 */
    /* JADX WARN: Type inference failed for: r16v11, types: [java.lang.String[]] */
    /* JADX WARN: Type inference failed for: r16v12 */
    /* JADX WARN: Type inference failed for: r3v1 */
    /* JADX WARN: Type inference failed for: r3v2 */
    /* JADX WARN: Type inference failed for: r3v3 */
    /* JADX WARN: Type inference failed for: r3v4 */
    /* JADX WARN: Type inference failed for: r3v42 */
    /* JADX WARN: Type inference failed for: r3v47 */
    /* JADX WARN: Type inference failed for: r3v49, types: [java.lang.String] */
    /* JADX WARN: Type inference failed for: r3v5, types: [java.lang.Object] */
    /* JADX WARN: Type inference failed for: r3v54 */
    /* JADX WARN: Type inference failed for: r3v57 */
    /* JADX WARN: Type inference failed for: r3v58 */
    /* JADX WARN: Type inference failed for: r3v6 */
    /* JADX WARN: Type inference failed for: r3v7 */
    /* JADX WARN: Type inference failed for: r4v0, types: [com.google.android.gms.internal.measurement.zzek, com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzjs] */
    /* JADX WARN: Type inference failed for: r4v1 */
    /* JADX WARN: Type inference failed for: r4v2 */
    /* JADX WARN: Type inference failed for: r4v3, types: [com.google.android.gms.internal.measurement.zzhi] */
    /* JADX WARN: Type inference failed for: r4v42 */
    /* JADX WARN: Type inference failed for: r4v43 */
    /* JADX WARN: Type inference failed for: r4v44 */
    /* JADX WARN: Type inference failed for: r4v45 */
    /* JADX WARN: Type inference failed for: r4v5, types: [com.google.android.gms.internal.measurement.zzfk] */
    /* JADX WARN: Type inference failed for: r4v6 */
    /* JADX WARN: Type inference failed for: r4v7 */
    /* JADX WARN: Type inference failed for: r6v0 */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v148 */
    /* JADX WARN: Type inference failed for: r6v149 */
    /* JADX WARN: Type inference failed for: r6v150 */
    /* JADX WARN: Type inference failed for: r6v151 */
    /* JADX WARN: Type inference failed for: r6v152 */
    /* JADX WARN: Type inference failed for: r6v153 */
    /* JADX WARN: Type inference failed for: r6v154 */
    /* JADX WARN: Type inference failed for: r6v155 */
    /* JADX WARN: Type inference failed for: r6v156 */
    /* JADX WARN: Type inference failed for: r6v161 */
    /* JADX WARN: Type inference failed for: r6v162 */
    /* JADX WARN: Type inference failed for: r6v168, types: [boolean] */
    /* JADX WARN: Type inference failed for: r6v172, types: [boolean] */
    /* JADX WARN: Type inference failed for: r6v173 */
    /* JADX WARN: Type inference failed for: r6v175, types: [com.google.android.gms.internal.measurement.zzfk] */
    /* JADX WARN: Type inference failed for: r6v178 */
    /* JADX WARN: Type inference failed for: r6v179 */
    /* JADX WARN: Type inference failed for: r6v180 */
    /* JADX WARN: Type inference failed for: r6v181 */
    /* JADX WARN: Type inference failed for: r6v182 */
    /* JADX WARN: Type inference failed for: r6v183 */
    /* JADX WARN: Type inference failed for: r6v3 */
    /* JADX WARN: Type inference failed for: r6v5, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r6v6, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r6v7 */
    /* JADX WARN: Type inference failed for: r6v8 */
    /* JADX WARN: Type inference failed for: r6v9 */
    /* JADX WARN: Type inference failed for: r9v11, types: [java.lang.String[]] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final boolean zzd(java.lang.String r60, long r61) {
        /*
            Method dump skipped, instruction units count: 2986
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzjt.zzd(java.lang.String, long):boolean");
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:32:0x00ce  */
    /* JADX WARN: Removed duplicated region for block: B:40:0x00f4  */
    /* JADX WARN: Removed duplicated region for block: B:43:0x0102  */
    /* JADX WARN: Removed duplicated region for block: B:51:0x012c  */
    /* JADX WARN: Removed duplicated region for block: B:54:0x013a  */
    /* JADX WARN: Removed duplicated region for block: B:57:0x0148  */
    /* JADX WARN: Removed duplicated region for block: B:59:0x0150  */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final com.google.android.gms.internal.measurement.zzea zzg(com.google.android.gms.internal.measurement.zzeb r9) {
        /*
            Method dump skipped, instruction units count: 344
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzjt.zzg(com.google.android.gms.internal.measurement.zzeb):com.google.android.gms.internal.measurement.zzea");
    }

    public static zzjt zzg(Context context) {
        Preconditions.checkNotNull(context);
        Preconditions.checkNotNull(context.getApplicationContext());
        if (zzarr == null) {
            synchronized (zzjt.class) {
                if (zzarr == null) {
                    zzarr = new zzjt(new zzjy(context));
                }
            }
        }
        return zzarr;
    }

    private final zzgh zzky() {
        zza(this.zzars);
        return this.zzars;
    }

    private final zzfr zzla() {
        if (this.zzarv == null) {
            throw new IllegalStateException("Network broadcast receiver not created");
        }
        return this.zzarv;
    }

    private final zzjp zzlb() {
        zza(this.zzarw);
        return this.zzarw;
    }

    private final long zzld() {
        long jCurrentTimeMillis = this.zzacv.zzbt().currentTimeMillis();
        zzft zzftVarZzgj = this.zzacv.zzgj();
        zzftVarZzgj.zzch();
        zzftVarZzgj.zzab();
        long j = zzftVarZzgj.zzalx.get();
        if (j == 0) {
            long jNextInt = ((long) zzftVarZzgj.zzgg().zzlo().nextInt(86400000)) + 1;
            zzftVarZzgj.zzalx.set(jNextInt);
            j = jNextInt;
        }
        return ((((jCurrentTimeMillis + j) / 1000) / 60) / 60) / 24;
    }

    private final boolean zzlf() {
        zzab();
        zzlc();
        return zzjh().zzia() || !TextUtils.isEmpty(zzjh().zzhv());
    }

    @WorkerThread
    private final void zzlg() {
        zzez.zza<Long> zzaVar;
        long jMin;
        zzab();
        zzlc();
        if (zzlk()) {
            if (this.zzasa > 0) {
                long jAbs = 3600000 - Math.abs(this.zzacv.zzbt().elapsedRealtime() - this.zzasa);
                if (jAbs > 0) {
                    this.zzacv.zzgi().zzjc().zzg("Upload has been suspended. Will update scheduling later in approximately ms", Long.valueOf(jAbs));
                    zzla().unregister();
                    zzlb().cancel();
                    return;
                }
                this.zzasa = 0L;
            }
            if (!this.zzacv.zzkg() || !zzlf()) {
                this.zzacv.zzgi().zzjc().log("Nothing to upload or uploading impossible");
                zzla().unregister();
                zzlb().cancel();
                return;
            }
            long jCurrentTimeMillis = this.zzacv.zzbt().currentTimeMillis();
            long jMax = Math.max(0L, zzez.zzaje.get().longValue());
            boolean z = zzjh().zzib() || zzjh().zzhw();
            if (z) {
                String strZzhs = this.zzacv.zzgk().zzhs();
                zzaVar = (TextUtils.isEmpty(strZzhs) || ".none.".equals(strZzhs)) ? zzez.zzaiy : zzez.zzaiz;
            } else {
                zzaVar = zzez.zzaix;
            }
            long jMax2 = Math.max(0L, zzaVar.get().longValue());
            long j = this.zzacv.zzgj().zzalt.get();
            long j2 = this.zzacv.zzgj().zzalu.get();
            long jMax3 = Math.max(zzjh().zzhy(), zzjh().zzhz());
            if (jMax3 == 0) {
                jMin = 0;
            } else {
                long jAbs2 = jCurrentTimeMillis - Math.abs(jMax3 - jCurrentTimeMillis);
                long jAbs3 = jCurrentTimeMillis - Math.abs(j - jCurrentTimeMillis);
                long jAbs4 = jCurrentTimeMillis - Math.abs(j2 - jCurrentTimeMillis);
                long jMax4 = Math.max(jAbs3, jAbs4);
                jMin = jAbs2 + jMax;
                if (z && jMax4 > 0) {
                    jMin = Math.min(jAbs2, jMax4) + jMax2;
                }
                if (!zzjf().zza(jMax4, jMax2)) {
                    jMin = jMax4 + jMax2;
                }
                if (jAbs4 != 0 && jAbs4 >= jAbs2) {
                    int i = 0;
                    while (i < Math.min(20, Math.max(0, zzez.zzajg.get().intValue()))) {
                        long jMax5 = jMin + (Math.max(0L, zzez.zzajf.get().longValue()) * (1 << i));
                        if (jMax5 > jAbs4) {
                            jMin = jMax5;
                            break;
                        } else {
                            i++;
                            jMin = jMax5;
                        }
                    }
                    jMin = 0;
                }
            }
            if (jMin == 0) {
                this.zzacv.zzgi().zzjc().log("Next upload time is 0");
                zzla().unregister();
                zzlb().cancel();
                return;
            }
            if (!zzkz().zzex()) {
                this.zzacv.zzgi().zzjc().log("No network");
                zzla().zzeu();
                zzlb().cancel();
                return;
            }
            long j3 = this.zzacv.zzgj().zzalv.get();
            long jMax6 = Math.max(0L, zzez.zzaiv.get().longValue());
            if (!zzjf().zza(j3, jMax6)) {
                jMin = Math.max(jMin, j3 + jMax6);
            }
            zzla().unregister();
            long jCurrentTimeMillis2 = jMin - this.zzacv.zzbt().currentTimeMillis();
            if (jCurrentTimeMillis2 <= 0) {
                jCurrentTimeMillis2 = Math.max(0L, zzez.zzaja.get().longValue());
                this.zzacv.zzgj().zzalt.set(this.zzacv.zzbt().currentTimeMillis());
            }
            this.zzacv.zzgi().zzjc().zzg("Upload scheduled in approximately ms", Long.valueOf(jCurrentTimeMillis2));
            zzlb().zzh(jCurrentTimeMillis2);
        }
    }

    @WorkerThread
    private final void zzlh() {
        zzab();
        if (this.zzase || this.zzasf || this.zzasg) {
            this.zzacv.zzgi().zzjc().zzd("Not stopping services. fetch, network, upload", Boolean.valueOf(this.zzase), Boolean.valueOf(this.zzasf), Boolean.valueOf(this.zzasg));
            return;
        }
        this.zzacv.zzgi().zzjc().log("Stopping uploading service(s)");
        if (this.zzasb == null) {
            return;
        }
        Iterator<Runnable> it2 = this.zzasb.iterator();
        while (it2.hasNext()) {
            it2.next().run();
        }
        this.zzasb.clear();
    }

    @WorkerThread
    @VisibleForTesting
    private final boolean zzli() {
        zzfk zzfkVarZziv;
        String str;
        zzab();
        try {
            this.zzasi = new RandomAccessFile(new File(this.zzacv.getContext().getFilesDir(), "google_app_measurement.db"), "rw").getChannel();
            this.zzash = this.zzasi.tryLock();
            if (this.zzash != null) {
                this.zzacv.zzgi().zzjc().log("Storage concurrent access okay");
                return true;
            }
            this.zzacv.zzgi().zziv().log("Storage concurrent data access panic");
            return false;
        } catch (FileNotFoundException e) {
            e = e;
            zzfkVarZziv = this.zzacv.zzgi().zziv();
            str = "Failed to acquire storage lock";
            zzfkVarZziv.zzg(str, e);
            return false;
        } catch (IOException e2) {
            e = e2;
            zzfkVarZziv = this.zzacv.zzgi().zziv();
            str = "Failed to access storage lock file";
            zzfkVarZziv.zzg(str, e);
            return false;
        }
    }

    @WorkerThread
    private final boolean zzlk() {
        zzab();
        zzlc();
        return this.zzarz;
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final Context getContext() {
        return this.zzacv.getContext();
    }

    @WorkerThread
    protected final void start() {
        this.zzacv.zzgh().zzab();
        zzjh().zzhx();
        if (this.zzacv.zzgj().zzalt.get() == 0) {
            this.zzacv.zzgj().zzalt.set(this.zzacv.zzbt().currentTimeMillis());
        }
        zzlg();
    }

    @WorkerThread
    @VisibleForTesting
    final void zza(int i, Throwable th, byte[] bArr, String str) {
        zzab();
        zzlc();
        if (bArr == null) {
            try {
                bArr = new byte[0];
            } catch (Throwable th2) {
                this.zzasf = false;
                zzlh();
                throw th2;
            }
        }
        List<Long> list = this.zzasj;
        this.zzasj = null;
        boolean z = true;
        if ((i == 200 || i == 204) && th == null) {
            try {
                this.zzacv.zzgj().zzalt.set(this.zzacv.zzbt().currentTimeMillis());
                this.zzacv.zzgj().zzalu.set(0L);
                zzlg();
                this.zzacv.zzgi().zzjc().zze("Successful upload. Got network response. code, size", Integer.valueOf(i), Integer.valueOf(bArr.length));
                zzjh().beginTransaction();
                try {
                    for (Long l : list) {
                        try {
                            zzek zzekVarZzjh = zzjh();
                            long jLongValue = l.longValue();
                            zzekVarZzjh.zzab();
                            zzekVarZzjh.zzch();
                            try {
                                if (zzekVarZzjh.getWritableDatabase().delete("queue", "rowid=?", new String[]{String.valueOf(jLongValue)}) != 1) {
                                    throw new SQLiteException("Deleted fewer rows from queue than expected");
                                }
                                continue;
                            } catch (SQLiteException e) {
                                zzekVarZzjh.zzgi().zziv().zzg("Failed to delete a bundle in a queue table", e);
                                throw e;
                            }
                        } catch (SQLiteException e2) {
                            if (this.zzask == null || !this.zzask.contains(l)) {
                                throw e2;
                            }
                        }
                    }
                    zzjh().setTransactionSuccessful();
                    zzjh().endTransaction();
                    this.zzask = null;
                    if (zzkz().zzex() && zzlf()) {
                        zzle();
                    } else {
                        this.zzasl = -1L;
                        zzlg();
                    }
                    this.zzasa = 0L;
                } catch (Throwable th3) {
                    zzjh().endTransaction();
                    throw th3;
                }
            } catch (SQLiteException e3) {
                this.zzacv.zzgi().zziv().zzg("Database error while trying to delete uploaded bundles", e3);
                this.zzasa = this.zzacv.zzbt().elapsedRealtime();
                this.zzacv.zzgi().zzjc().zzg("Disable upload, time", Long.valueOf(this.zzasa));
            }
        } else {
            this.zzacv.zzgi().zzjc().zze("Network upload failed. Will retry later. code, error", Integer.valueOf(i), th);
            this.zzacv.zzgj().zzalu.set(this.zzacv.zzbt().currentTimeMillis());
            if (i != 503 && i != 429) {
                z = false;
            }
            if (z) {
                this.zzacv.zzgj().zzalv.set(this.zzacv.zzbt().currentTimeMillis());
            }
            if (this.zzacv.zzgk().zzay(str)) {
                zzjh().zzc(list);
            }
            zzlg();
        }
        this.zzasf = false;
        zzlh();
    }

    /* JADX WARN: Multi-variable type inference failed */
    @WorkerThread
    public final byte[] zza(@NonNull zzex zzexVar, @Size(min = 1) String str) {
        zzkc zzkcVarZzh;
        zzku zzkuVar;
        long j;
        zzea zzeaVar;
        Bundle bundle;
        zzkt zzktVar;
        byte[] bArr;
        long j2;
        zzfk zzfkVarZziy;
        String str2;
        Object objZzbp;
        zzlc();
        zzab();
        this.zzacv.zzfu();
        Preconditions.checkNotNull(zzexVar);
        Preconditions.checkNotEmpty(str);
        zzkt zzktVar2 = new zzkt();
        zzjh().beginTransaction();
        try {
            zzea zzeaVarZzbf = zzjh().zzbf(str);
            if (zzeaVarZzbf == null) {
                this.zzacv.zzgi().zzjb().zzg("Log and bundle not available. package_name", str);
            } else {
                if (zzeaVarZzbf.isMeasurementEnabled()) {
                    if (("_iap".equals(zzexVar.name) || FirebaseAnalytics.Event.ECOMMERCE_PURCHASE.equals(zzexVar.name)) && !zza(str, zzexVar)) {
                        this.zzacv.zzgi().zziy().zzg("Failed to handle purchase event at single event bundle creation. appId", zzfi.zzbp(str));
                    }
                    boolean zZzaw = this.zzacv.zzgk().zzaw(str);
                    Long l = 0L;
                    if (zZzaw && "_e".equals(zzexVar.name)) {
                        if (zzexVar.zzahg == null || zzexVar.zzahg.size() == 0) {
                            zzfkVarZziy = this.zzacv.zzgi().zziy();
                            str2 = "The engagement event does not contain any parameters. appId";
                            objZzbp = zzfi.zzbp(str);
                        } else if (zzexVar.zzahg.getLong("_et") == null) {
                            zzfkVarZziy = this.zzacv.zzgi().zziy();
                            str2 = "The engagement event does not include duration. appId";
                            objZzbp = zzfi.zzbp(str);
                        } else {
                            l = zzexVar.zzahg.getLong("_et");
                        }
                        zzfkVarZziy.zzg(str2, objZzbp);
                    }
                    zzku zzkuVar2 = new zzku();
                    zzktVar2.zzavf = new zzku[]{zzkuVar2};
                    zzkuVar2.zzavh = 1;
                    zzkuVar2.zzavp = AccountKitGraphConstants.SDK_TYPE_ANDROID;
                    zzkuVar2.zzth = zzeaVarZzbf.zzah();
                    zzkuVar2.zzafh = zzeaVarZzbf.zzgv();
                    zzkuVar2.zztg = zzeaVarZzbf.zzag();
                    long jZzgu = zzeaVarZzbf.zzgu();
                    zzkuVar2.zzawb = jZzgu == -2147483648L ? null : Integer.valueOf((int) jZzgu);
                    zzkuVar2.zzavt = Long.valueOf(zzeaVarZzbf.zzgw());
                    zzkuVar2.zzafa = zzeaVarZzbf.getGmpAppId();
                    zzkuVar2.zzavx = Long.valueOf(zzeaVarZzbf.zzgx());
                    if (this.zzacv.isEnabled() && zzeh.zzht() && this.zzacv.zzgk().zzau(zzkuVar2.zzth)) {
                        zzkuVar2.zzawh = null;
                    }
                    Pair<String, Boolean> pairZzbr = this.zzacv.zzgj().zzbr(zzeaVarZzbf.zzah());
                    if (zzeaVarZzbf.zzhl() && pairZzbr != null && !TextUtils.isEmpty((CharSequence) pairZzbr.first)) {
                        zzkuVar2.zzavv = (String) pairZzbr.first;
                        zzkuVar2.zzavw = (Boolean) pairZzbr.second;
                    }
                    this.zzacv.zzge().zzch();
                    zzkuVar2.zzavr = Build.MODEL;
                    this.zzacv.zzge().zzch();
                    zzkuVar2.zzavq = Build.VERSION.RELEASE;
                    zzkuVar2.zzavs = Integer.valueOf((int) this.zzacv.zzge().zzik());
                    zzkuVar2.zzahd = this.zzacv.zzge().zzil();
                    zzkuVar2.zzaez = zzeaVarZzbf.getAppInstanceId();
                    zzkuVar2.zzafc = zzeaVarZzbf.zzgr();
                    List<zzkc> listZzbe = zzjh().zzbe(zzeaVarZzbf.zzah());
                    zzkuVar2.zzavj = new zzkx[listZzbe.size()];
                    if (zZzaw) {
                        zzkcVarZzh = zzjh().zzh(zzkuVar2.zzth, "_lte");
                        if (zzkcVarZzh == null || zzkcVarZzh.value == null) {
                            zzkcVarZzh = new zzkc(zzkuVar2.zzth, "auto", "_lte", this.zzacv.zzbt().currentTimeMillis(), l);
                        } else if (l.longValue() > 0) {
                            zzkcVarZzh = new zzkc(zzkuVar2.zzth, "auto", "_lte", this.zzacv.zzbt().currentTimeMillis(), Long.valueOf(((Long) zzkcVarZzh.value).longValue() + l.longValue()));
                        }
                    } else {
                        zzkcVarZzh = null;
                    }
                    zzkx zzkxVar = null;
                    for (int i = 0; i < listZzbe.size(); i++) {
                        zzkx zzkxVar2 = new zzkx();
                        zzkuVar2.zzavj[i] = zzkxVar2;
                        zzkxVar2.name = listZzbe.get(i).name;
                        zzkxVar2.zzaws = Long.valueOf(listZzbe.get(i).zzast);
                        zzjf().zza(zzkxVar2, listZzbe.get(i).value);
                        if (zZzaw && "_lte".equals(zzkxVar2.name)) {
                            zzkxVar2.zzave = (Long) zzkcVarZzh.value;
                            zzkxVar2.zzaws = Long.valueOf(this.zzacv.zzbt().currentTimeMillis());
                            zzkxVar = zzkxVar2;
                        }
                    }
                    if (zZzaw && zzkxVar == null) {
                        zzkx zzkxVar3 = new zzkx();
                        zzkxVar3.name = "_lte";
                        zzkxVar3.zzaws = Long.valueOf(this.zzacv.zzbt().currentTimeMillis());
                        zzkxVar3.zzave = (Long) zzkcVarZzh.value;
                        zzkuVar2.zzavj = (zzkx[]) Arrays.copyOf(zzkuVar2.zzavj, zzkuVar2.zzavj.length + 1);
                        zzkuVar2.zzavj[zzkuVar2.zzavj.length - 1] = zzkxVar3;
                    }
                    if (l.longValue() > 0) {
                        zzjh().zza(zzkcVarZzh);
                    }
                    Bundle bundleZzin = zzexVar.zzahg.zzin();
                    if ("_iap".equals(zzexVar.name)) {
                        bundleZzin.putLong("_c", 1L);
                        this.zzacv.zzgi().zzjb().log("Marking in-app purchase as real-time");
                        bundleZzin.putLong("_r", 1L);
                    }
                    bundleZzin.putString("_o", zzexVar.origin);
                    if (this.zzacv.zzgg().zzcn(zzkuVar2.zzth)) {
                        this.zzacv.zzgg().zza(bundleZzin, "_dbg", (Object) 1L);
                        this.zzacv.zzgg().zza(bundleZzin, "_r", (Object) 1L);
                    }
                    zzet zzetVarZzf = zzjh().zzf(str, zzexVar.name);
                    if (zzetVarZzf == null) {
                        zzkuVar = zzkuVar2;
                        j = 0;
                        zzeaVar = zzeaVarZzbf;
                        bundle = bundleZzin;
                        zzktVar = zzktVar2;
                        bArr = null;
                        zzjh().zza(new zzet(str, zzexVar.name, 1L, 0L, zzexVar.zzahr, 0L, null, null, null));
                        j2 = 0;
                    } else {
                        zzkuVar = zzkuVar2;
                        j = 0;
                        zzeaVar = zzeaVarZzbf;
                        bundle = bundleZzin;
                        zzktVar = zzktVar2;
                        bArr = null;
                        long j3 = zzetVarZzf.zzahj;
                        zzjh().zza(zzetVarZzf.zzah(zzexVar.zzahr).zzim());
                        j2 = j3;
                    }
                    zzes zzesVar = new zzes(this.zzacv, zzexVar.origin, str, zzexVar.name, zzexVar.zzahr, j2, bundle);
                    zzkr zzkrVar = new zzkr();
                    zzku zzkuVar3 = zzkuVar;
                    zzkuVar3.zzavi = new zzkr[]{zzkrVar};
                    zzkrVar.zzavb = Long.valueOf(zzesVar.timestamp);
                    zzkrVar.name = zzesVar.name;
                    zzkrVar.zzavc = Long.valueOf(zzesVar.zzahf);
                    zzkrVar.zzava = new zzks[zzesVar.zzahg.size()];
                    int i2 = 0;
                    for (String str3 : zzesVar.zzahg) {
                        zzks zzksVar = new zzks();
                        zzkrVar.zzava[i2] = zzksVar;
                        zzksVar.name = str3;
                        zzjf().zza(zzksVar, zzesVar.zzahg.get(str3));
                        i2++;
                    }
                    zzea zzeaVar2 = zzeaVar;
                    zzkuVar3.zzawa = zza(zzeaVar2.zzah(), zzkuVar3.zzavj, zzkuVar3.zzavi);
                    zzkuVar3.zzavl = zzkrVar.zzavb;
                    zzkuVar3.zzavm = zzkrVar.zzavb;
                    long jZzgt = zzeaVar2.zzgt();
                    zzkuVar3.zzavo = jZzgt != j ? Long.valueOf(jZzgt) : bArr;
                    long jZzgs = zzeaVar2.zzgs();
                    if (jZzgs != j) {
                        jZzgt = jZzgs;
                    }
                    zzkuVar3.zzavn = jZzgt != j ? Long.valueOf(jZzgt) : bArr;
                    zzeaVar2.zzhb();
                    zzkuVar3.zzavy = Integer.valueOf((int) zzeaVar2.zzgy());
                    zzkuVar3.zzavu = Long.valueOf(this.zzacv.zzgk().zzgw());
                    zzkuVar3.zzavk = Long.valueOf(this.zzacv.zzbt().currentTimeMillis());
                    zzkuVar3.zzavz = Boolean.TRUE;
                    zzeaVar2.zzr(zzkuVar3.zzavl.longValue());
                    zzeaVar2.zzs(zzkuVar3.zzavm.longValue());
                    zzjh().zza(zzeaVar2);
                    zzjh().setTransactionSuccessful();
                    zzjh().endTransaction();
                    zzkt zzktVar3 = zzktVar;
                    try {
                        byte[] bArr2 = new byte[zzktVar3.zzwb()];
                        zzacb zzacbVarZzb = zzacb.zzb(bArr2, 0, bArr2.length);
                        zzktVar3.zza(zzacbVarZzb);
                        zzacbVarZzb.zzvt();
                        return zzjf().zzb(bArr2);
                    } catch (IOException e) {
                        this.zzacv.zzgi().zziv().zze("Data loss. Failed to bundle and serialize. appId", zzfi.zzbp(str), e);
                        return bArr;
                    }
                }
                this.zzacv.zzgi().zzjb().zzg("Log and bundle disabled. package_name", str);
            }
            return new byte[0];
        } finally {
            zzjh().endTransaction();
        }
    }

    @WorkerThread
    final void zzb(zzef zzefVar, zzeb zzebVar) {
        zzfk zzfkVarZziv;
        String str;
        Object objZzbp;
        String strZzbo;
        Object value;
        zzfk zzfkVarZziv2;
        String str2;
        Object objZzbp2;
        String strZzbo2;
        Object obj;
        Preconditions.checkNotNull(zzefVar);
        Preconditions.checkNotEmpty(zzefVar.packageName);
        Preconditions.checkNotNull(zzefVar.origin);
        Preconditions.checkNotNull(zzefVar.zzage);
        Preconditions.checkNotEmpty(zzefVar.zzage.name);
        zzab();
        zzlc();
        if (TextUtils.isEmpty(zzebVar.zzafa)) {
            return;
        }
        if (!zzebVar.zzafk) {
            zzg(zzebVar);
            return;
        }
        zzef zzefVar2 = new zzef(zzefVar);
        boolean z = false;
        zzefVar2.active = false;
        zzjh().beginTransaction();
        try {
            zzef zzefVarZzi = zzjh().zzi(zzefVar2.packageName, zzefVar2.zzage.name);
            if (zzefVarZzi != null && !zzefVarZzi.origin.equals(zzefVar2.origin)) {
                this.zzacv.zzgi().zziy().zzd("Updating a conditional user property with different origin. name, origin, origin (from DB)", this.zzacv.zzgf().zzbo(zzefVar2.zzage.name), zzefVar2.origin, zzefVarZzi.origin);
            }
            if (zzefVarZzi != null && zzefVarZzi.active) {
                zzefVar2.origin = zzefVarZzi.origin;
                zzefVar2.creationTimestamp = zzefVarZzi.creationTimestamp;
                zzefVar2.triggerTimeout = zzefVarZzi.triggerTimeout;
                zzefVar2.triggerEventName = zzefVarZzi.triggerEventName;
                zzefVar2.zzagg = zzefVarZzi.zzagg;
                zzefVar2.active = zzefVarZzi.active;
                zzefVar2.zzage = new zzka(zzefVar2.zzage.name, zzefVarZzi.zzage.zzast, zzefVar2.zzage.getValue(), zzefVarZzi.zzage.origin);
            } else if (TextUtils.isEmpty(zzefVar2.triggerEventName)) {
                zzefVar2.zzage = new zzka(zzefVar2.zzage.name, zzefVar2.creationTimestamp, zzefVar2.zzage.getValue(), zzefVar2.zzage.origin);
                zzefVar2.active = true;
                z = true;
            }
            if (zzefVar2.active) {
                zzka zzkaVar = zzefVar2.zzage;
                zzkc zzkcVar = new zzkc(zzefVar2.packageName, zzefVar2.origin, zzkaVar.name, zzkaVar.zzast, zzkaVar.getValue());
                if (zzjh().zza(zzkcVar)) {
                    zzfkVarZziv2 = this.zzacv.zzgi().zzjb();
                    str2 = "User property updated immediately";
                    objZzbp2 = zzefVar2.packageName;
                    strZzbo2 = this.zzacv.zzgf().zzbo(zzkcVar.name);
                    obj = zzkcVar.value;
                } else {
                    zzfkVarZziv2 = this.zzacv.zzgi().zziv();
                    str2 = "(2)Too many active user properties, ignoring";
                    objZzbp2 = zzfi.zzbp(zzefVar2.packageName);
                    strZzbo2 = this.zzacv.zzgf().zzbo(zzkcVar.name);
                    obj = zzkcVar.value;
                }
                zzfkVarZziv2.zzd(str2, objZzbp2, strZzbo2, obj);
                if (z && zzefVar2.zzagg != null) {
                    zzc(new zzex(zzefVar2.zzagg, zzefVar2.creationTimestamp), zzebVar);
                }
            }
            if (zzjh().zza(zzefVar2)) {
                zzfkVarZziv = this.zzacv.zzgi().zzjb();
                str = "Conditional property added";
                objZzbp = zzefVar2.packageName;
                strZzbo = this.zzacv.zzgf().zzbo(zzefVar2.zzage.name);
                value = zzefVar2.zzage.getValue();
            } else {
                zzfkVarZziv = this.zzacv.zzgi().zziv();
                str = "Too many conditional properties, ignoring";
                objZzbp = zzfi.zzbp(zzefVar2.packageName);
                strZzbo = this.zzacv.zzgf().zzbo(zzefVar2.zzage.name);
                value = zzefVar2.zzage.getValue();
            }
            zzfkVarZziv.zzd(str, objZzbp, strZzbo, value);
            zzjh().setTransactionSuccessful();
        } finally {
            zzjh().endTransaction();
        }
    }

    @WorkerThread
    final void zzb(zzex zzexVar, zzeb zzebVar) {
        List<zzef> listZzb;
        List<zzef> listZzb2;
        List<zzef> listZzb3;
        zzfk zzfkVarZziv;
        String str;
        Object objZzbp;
        String strZzbo;
        Object obj;
        Preconditions.checkNotNull(zzebVar);
        Preconditions.checkNotEmpty(zzebVar.packageName);
        zzab();
        zzlc();
        String str2 = zzebVar.packageName;
        long j = zzexVar.zzahr;
        if (zzjf().zzd(zzexVar, zzebVar)) {
            if (!zzebVar.zzafk) {
                zzg(zzebVar);
                return;
            }
            zzjh().beginTransaction();
            try {
                zzek zzekVarZzjh = zzjh();
                Preconditions.checkNotEmpty(str2);
                zzekVarZzjh.zzab();
                zzekVarZzjh.zzch();
                if (j < 0) {
                    zzekVarZzjh.zzgi().zziy().zze("Invalid time querying timed out conditional properties", zzfi.zzbp(str2), Long.valueOf(j));
                    listZzb = Collections.emptyList();
                } else {
                    listZzb = zzekVarZzjh.zzb("active=0 and app_id=? and abs(? - creation_timestamp) > trigger_timeout", new String[]{str2, String.valueOf(j)});
                }
                for (zzef zzefVar : listZzb) {
                    if (zzefVar != null) {
                        this.zzacv.zzgi().zzjb().zzd("User property timed out", zzefVar.packageName, this.zzacv.zzgf().zzbo(zzefVar.zzage.name), zzefVar.zzage.getValue());
                        if (zzefVar.zzagf != null) {
                            zzc(new zzex(zzefVar.zzagf, j), zzebVar);
                        }
                        zzjh().zzj(str2, zzefVar.zzage.name);
                    }
                }
                zzek zzekVarZzjh2 = zzjh();
                Preconditions.checkNotEmpty(str2);
                zzekVarZzjh2.zzab();
                zzekVarZzjh2.zzch();
                if (j < 0) {
                    zzekVarZzjh2.zzgi().zziy().zze("Invalid time querying expired conditional properties", zzfi.zzbp(str2), Long.valueOf(j));
                    listZzb2 = Collections.emptyList();
                } else {
                    listZzb2 = zzekVarZzjh2.zzb("active<>0 and app_id=? and abs(? - triggered_timestamp) > time_to_live", new String[]{str2, String.valueOf(j)});
                }
                ArrayList arrayList = new ArrayList(listZzb2.size());
                for (zzef zzefVar2 : listZzb2) {
                    if (zzefVar2 != null) {
                        this.zzacv.zzgi().zzjb().zzd("User property expired", zzefVar2.packageName, this.zzacv.zzgf().zzbo(zzefVar2.zzage.name), zzefVar2.zzage.getValue());
                        zzjh().zzg(str2, zzefVar2.zzage.name);
                        if (zzefVar2.zzagh != null) {
                            arrayList.add(zzefVar2.zzagh);
                        }
                        zzjh().zzj(str2, zzefVar2.zzage.name);
                    }
                }
                ArrayList arrayList2 = arrayList;
                int size = arrayList2.size();
                int i = 0;
                while (i < size) {
                    Object obj2 = arrayList2.get(i);
                    i++;
                    zzc(new zzex((zzex) obj2, j), zzebVar);
                }
                zzek zzekVarZzjh3 = zzjh();
                String str3 = zzexVar.name;
                Preconditions.checkNotEmpty(str2);
                Preconditions.checkNotEmpty(str3);
                zzekVarZzjh3.zzab();
                zzekVarZzjh3.zzch();
                if (j < 0) {
                    zzekVarZzjh3.zzgi().zziy().zzd("Invalid time querying triggered conditional properties", zzfi.zzbp(str2), zzekVarZzjh3.zzgf().zzbm(str3), Long.valueOf(j));
                    listZzb3 = Collections.emptyList();
                } else {
                    listZzb3 = zzekVarZzjh3.zzb("active=0 and app_id=? and trigger_event_name=? and abs(? - creation_timestamp) <= trigger_timeout", new String[]{str2, str3, String.valueOf(j)});
                }
                ArrayList arrayList3 = new ArrayList(listZzb3.size());
                Iterator<zzef> it2 = listZzb3.iterator();
                while (it2.hasNext()) {
                    zzef next = it2.next();
                    if (next != null) {
                        zzka zzkaVar = next.zzage;
                        Iterator<zzef> it3 = it2;
                        zzkc zzkcVar = new zzkc(next.packageName, next.origin, zzkaVar.name, j, zzkaVar.getValue());
                        if (zzjh().zza(zzkcVar)) {
                            zzfkVarZziv = this.zzacv.zzgi().zzjb();
                            str = "User property triggered";
                            objZzbp = next.packageName;
                            strZzbo = this.zzacv.zzgf().zzbo(zzkcVar.name);
                            obj = zzkcVar.value;
                        } else {
                            zzfkVarZziv = this.zzacv.zzgi().zziv();
                            str = "Too many active user properties, ignoring";
                            objZzbp = zzfi.zzbp(next.packageName);
                            strZzbo = this.zzacv.zzgf().zzbo(zzkcVar.name);
                            obj = zzkcVar.value;
                        }
                        zzfkVarZziv.zzd(str, objZzbp, strZzbo, obj);
                        if (next.zzagg != null) {
                            arrayList3.add(next.zzagg);
                        }
                        next.zzage = new zzka(zzkcVar);
                        next.active = true;
                        zzjh().zza(next);
                        it2 = it3;
                    }
                }
                zzc(zzexVar, zzebVar);
                ArrayList arrayList4 = arrayList3;
                int size2 = arrayList4.size();
                int i2 = 0;
                while (i2 < size2) {
                    Object obj3 = arrayList4.get(i2);
                    i2++;
                    zzc(new zzex((zzex) obj3, j), zzebVar);
                }
                zzjh().setTransactionSuccessful();
            } finally {
                zzjh().endTransaction();
            }
        }
    }

    final void zzb(zzjs zzjsVar) {
        this.zzasc++;
    }

    @WorkerThread
    final void zzb(zzka zzkaVar, zzeb zzebVar) {
        zzab();
        zzlc();
        if (TextUtils.isEmpty(zzebVar.zzafa)) {
            return;
        }
        if (!zzebVar.zzafk) {
            zzg(zzebVar);
            return;
        }
        int iZzcj = this.zzacv.zzgg().zzcj(zzkaVar.name);
        if (iZzcj != 0) {
            this.zzacv.zzgg();
            this.zzacv.zzgg().zza(zzebVar.packageName, iZzcj, "_ev", zzkd.zza(zzkaVar.name, 24, true), zzkaVar.name != null ? zzkaVar.name.length() : 0);
            return;
        }
        int iZzi = this.zzacv.zzgg().zzi(zzkaVar.name, zzkaVar.getValue());
        if (iZzi != 0) {
            this.zzacv.zzgg();
            String strZza = zzkd.zza(zzkaVar.name, 24, true);
            Object value = zzkaVar.getValue();
            this.zzacv.zzgg().zza(zzebVar.packageName, iZzi, "_ev", strZza, (value == null || !((value instanceof String) || (value instanceof CharSequence))) ? 0 : String.valueOf(value).length());
            return;
        }
        Object objZzj = this.zzacv.zzgg().zzj(zzkaVar.name, zzkaVar.getValue());
        if (objZzj == null) {
            return;
        }
        zzkc zzkcVar = new zzkc(zzebVar.packageName, zzkaVar.origin, zzkaVar.name, zzkaVar.zzast, objZzj);
        this.zzacv.zzgi().zzjb().zze("Setting user property", this.zzacv.zzgf().zzbo(zzkcVar.name), objZzj);
        zzjh().beginTransaction();
        try {
            zzg(zzebVar);
            boolean zZza = zzjh().zza(zzkcVar);
            zzjh().setTransactionSuccessful();
            if (zZza) {
                this.zzacv.zzgi().zzjb().zze("User property set", this.zzacv.zzgf().zzbo(zzkcVar.name), zzkcVar.value);
            } else {
                this.zzacv.zzgi().zziv().zze("Too many unique user properties are set. Ignoring user property", this.zzacv.zzgf().zzbo(zzkcVar.name), zzkcVar.value);
                this.zzacv.zzgg().zza(zzebVar.packageName, 9, (String) null, (String) null, 0);
            }
        } finally {
            zzjh().endTransaction();
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:57:0x0136 A[Catch: all -> 0x017d, TryCatch #0 {all -> 0x017d, blocks: (B:8:0x002d, B:17:0x0049, B:64:0x0171, B:22:0x0065, B:29:0x00b4, B:30:0x00c9, B:33:0x00d1, B:36:0x00dd, B:38:0x00e3, B:43:0x00f0, B:55:0x0120, B:57:0x0136, B:59:0x015e, B:61:0x0168, B:63:0x016e, B:58:0x0146, B:49:0x0107, B:51:0x0111), top: B:71:0x002d, outer: #1 }] */
    /* JADX WARN: Removed duplicated region for block: B:58:0x0146 A[Catch: all -> 0x017d, TryCatch #0 {all -> 0x017d, blocks: (B:8:0x002d, B:17:0x0049, B:64:0x0171, B:22:0x0065, B:29:0x00b4, B:30:0x00c9, B:33:0x00d1, B:36:0x00dd, B:38:0x00e3, B:43:0x00f0, B:55:0x0120, B:57:0x0136, B:59:0x015e, B:61:0x0168, B:63:0x016e, B:58:0x0146, B:49:0x0107, B:51:0x0111), top: B:71:0x002d, outer: #1 }] */
    @android.support.annotation.WorkerThread
    @com.google.android.gms.common.util.VisibleForTesting
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final void zzb(java.lang.String r7, int r8, java.lang.Throwable r9, byte[] r10, java.util.Map<java.lang.String, java.util.List<java.lang.String>> r11) {
        /*
            Method dump skipped, instruction units count: 396
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzjt.zzb(java.lang.String, int, java.lang.Throwable, byte[], java.util.Map):void");
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final Clock zzbt() {
        return this.zzacv.zzbt();
    }

    @WorkerThread
    final void zzc(zzef zzefVar, zzeb zzebVar) {
        Preconditions.checkNotNull(zzefVar);
        Preconditions.checkNotEmpty(zzefVar.packageName);
        Preconditions.checkNotNull(zzefVar.zzage);
        Preconditions.checkNotEmpty(zzefVar.zzage.name);
        zzab();
        zzlc();
        if (TextUtils.isEmpty(zzebVar.zzafa)) {
            return;
        }
        if (!zzebVar.zzafk) {
            zzg(zzebVar);
            return;
        }
        zzjh().beginTransaction();
        try {
            zzg(zzebVar);
            zzef zzefVarZzi = zzjh().zzi(zzefVar.packageName, zzefVar.zzage.name);
            if (zzefVarZzi != null) {
                this.zzacv.zzgi().zzjb().zze("Removing conditional user property", zzefVar.packageName, this.zzacv.zzgf().zzbo(zzefVar.zzage.name));
                zzjh().zzj(zzefVar.packageName, zzefVar.zzage.name);
                if (zzefVarZzi.active) {
                    zzjh().zzg(zzefVar.packageName, zzefVar.zzage.name);
                }
                if (zzefVar.zzagh != null) {
                    zzc(this.zzacv.zzgg().zza(zzefVar.packageName, zzefVar.zzagh.name, zzefVar.zzagh.zzahg != null ? zzefVar.zzagh.zzahg.zzin() : null, zzefVarZzi.origin, zzefVar.zzagh.zzahr, true, false), zzebVar);
                }
            } else {
                this.zzacv.zzgi().zziy().zze("Conditional user property doesn't exist", zzfi.zzbp(zzefVar.packageName), this.zzacv.zzgf().zzbo(zzefVar.zzage.name));
            }
            zzjh().setTransactionSuccessful();
        } finally {
            zzjh().endTransaction();
        }
    }

    @WorkerThread
    final void zzc(zzex zzexVar, String str) {
        zzea zzeaVarZzbf = zzjh().zzbf(str);
        if (zzeaVarZzbf == null || TextUtils.isEmpty(zzeaVarZzbf.zzag())) {
            this.zzacv.zzgi().zzjb().zzg("No app data available; dropping event", str);
            return;
        }
        Boolean boolZzc = zzc(zzeaVarZzbf);
        if (boolZzc == null) {
            if (!"_ui".equals(zzexVar.name)) {
                this.zzacv.zzgi().zziy().zzg("Could not find package. appId", zzfi.zzbp(str));
            }
        } else if (!boolZzc.booleanValue()) {
            this.zzacv.zzgi().zziv().zzg("App version does not match; dropping event. appId", zzfi.zzbp(str));
            return;
        }
        zzb(zzexVar, new zzeb(str, zzeaVarZzbf.getGmpAppId(), zzeaVarZzbf.zzag(), zzeaVarZzbf.zzgu(), zzeaVarZzbf.zzgv(), zzeaVarZzbf.zzgw(), zzeaVarZzbf.zzgx(), (String) null, zzeaVarZzbf.isMeasurementEnabled(), false, zzeaVarZzbf.zzgr(), zzeaVarZzbf.zzhk(), 0L, 0, zzeaVarZzbf.zzhl(), zzeaVarZzbf.zzhm(), false));
    }

    @WorkerThread
    final void zzc(zzka zzkaVar, zzeb zzebVar) {
        zzab();
        zzlc();
        if (TextUtils.isEmpty(zzebVar.zzafa)) {
            return;
        }
        if (!zzebVar.zzafk) {
            zzg(zzebVar);
            return;
        }
        this.zzacv.zzgi().zzjb().zzg("Removing user property", this.zzacv.zzgf().zzbo(zzkaVar.name));
        zzjh().beginTransaction();
        try {
            zzg(zzebVar);
            zzjh().zzg(zzebVar.packageName, zzkaVar.name);
            zzjh().setTransactionSuccessful();
            this.zzacv.zzgi().zzjb().zzg("User property removed", this.zzacv.zzgf().zzbo(zzkaVar.name));
        } finally {
            zzjh().endTransaction();
        }
    }

    @WorkerThread
    @VisibleForTesting
    final void zzd(zzeb zzebVar) {
        if (this.zzasj != null) {
            this.zzask = new ArrayList();
            this.zzask.addAll(this.zzasj);
        }
        zzek zzekVarZzjh = zzjh();
        String str = zzebVar.packageName;
        Preconditions.checkNotEmpty(str);
        zzekVarZzjh.zzab();
        zzekVarZzjh.zzch();
        try {
            SQLiteDatabase writableDatabase = zzekVarZzjh.getWritableDatabase();
            String[] strArr = {str};
            int iDelete = writableDatabase.delete("apps", "app_id=?", strArr) + 0 + writableDatabase.delete("events", "app_id=?", strArr) + writableDatabase.delete("user_attributes", "app_id=?", strArr) + writableDatabase.delete("conditional_properties", "app_id=?", strArr) + writableDatabase.delete("raw_events", "app_id=?", strArr) + writableDatabase.delete("raw_events_metadata", "app_id=?", strArr) + writableDatabase.delete("queue", "app_id=?", strArr) + writableDatabase.delete("audience_filter_values", "app_id=?", strArr) + writableDatabase.delete("main_event_params", "app_id=?", strArr);
            if (iDelete > 0) {
                zzekVarZzjh.zzgi().zzjc().zze("Reset analytics data. app, records", str, Integer.valueOf(iDelete));
            }
        } catch (SQLiteException e) {
            zzekVarZzjh.zzgi().zziv().zze("Error resetting analytics data. appId, error", zzfi.zzbp(str), e);
        }
        zzeb zzebVarZza = zza(this.zzacv.getContext(), zzebVar.packageName, zzebVar.zzafa, zzebVar.zzafk, zzebVar.zzafm, zzebVar.zzafn, zzebVar.zzaga);
        if (!this.zzacv.zzgk().zzbc(zzebVar.packageName) || zzebVar.zzafk) {
            zzf(zzebVarZza);
        }
    }

    final void zze(zzeb zzebVar) {
        zzab();
        zzlc();
        Preconditions.checkNotEmpty(zzebVar.packageName);
        zzg(zzebVar);
    }

    @WorkerThread
    final void zze(zzef zzefVar) {
        zzeb zzebVarZzce = zzce(zzefVar.packageName);
        if (zzebVarZzce != null) {
            zzb(zzefVar, zzebVarZzce);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:114:0x03b6 A[Catch: all -> 0x03df, TryCatch #3 {all -> 0x03df, blocks: (B:24:0x008f, B:26:0x009d, B:28:0x00a3, B:30:0x00af, B:31:0x00d7, B:33:0x0132, B:37:0x0146, B:40:0x015b, B:42:0x0166, B:44:0x0170, B:45:0x0191, B:46:0x0195, B:48:0x019b, B:50:0x01a7, B:51:0x01c9, B:53:0x01ce, B:54:0x01d6, B:59:0x01ea, B:61:0x01f7, B:63:0x0246, B:65:0x024a, B:66:0x024f, B:68:0x025b, B:99:0x0311, B:101:0x032c, B:102:0x0331, B:103:0x0341, B:112:0x0398, B:113:0x03b2, B:117:0x03d0, B:70:0x0272, B:76:0x029f, B:78:0x02a7, B:80:0x02af, B:82:0x02b7, B:86:0x02c1, B:87:0x02cf, B:93:0x02fc, B:95:0x0301, B:96:0x0306, B:98:0x030c, B:91:0x02e3, B:74:0x0286, B:106:0x0348, B:108:0x037e, B:110:0x0382, B:111:0x0387, B:114:0x03b6, B:116:0x03ba, B:56:0x01dd), top: B:129:0x008f, inners: #0, #1, #2 }] */
    /* JADX WARN: Removed duplicated region for block: B:59:0x01ea A[Catch: all -> 0x03df, TryCatch #3 {all -> 0x03df, blocks: (B:24:0x008f, B:26:0x009d, B:28:0x00a3, B:30:0x00af, B:31:0x00d7, B:33:0x0132, B:37:0x0146, B:40:0x015b, B:42:0x0166, B:44:0x0170, B:45:0x0191, B:46:0x0195, B:48:0x019b, B:50:0x01a7, B:51:0x01c9, B:53:0x01ce, B:54:0x01d6, B:59:0x01ea, B:61:0x01f7, B:63:0x0246, B:65:0x024a, B:66:0x024f, B:68:0x025b, B:99:0x0311, B:101:0x032c, B:102:0x0331, B:103:0x0341, B:112:0x0398, B:113:0x03b2, B:117:0x03d0, B:70:0x0272, B:76:0x029f, B:78:0x02a7, B:80:0x02af, B:82:0x02b7, B:86:0x02c1, B:87:0x02cf, B:93:0x02fc, B:95:0x0301, B:96:0x0306, B:98:0x030c, B:91:0x02e3, B:74:0x0286, B:106:0x0348, B:108:0x037e, B:110:0x0382, B:111:0x0387, B:114:0x03b6, B:116:0x03ba, B:56:0x01dd), top: B:129:0x008f, inners: #0, #1, #2 }] */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final void zzf(com.google.android.gms.internal.measurement.zzeb r21) {
        /*
            Method dump skipped, instruction units count: 1001
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzjt.zzf(com.google.android.gms.internal.measurement.zzeb):void");
    }

    @WorkerThread
    final void zzf(zzef zzefVar) {
        zzeb zzebVarZzce = zzce(zzefVar.packageName);
        if (zzebVarZzce != null) {
            zzc(zzefVar, zzebVarZzce);
        }
    }

    @WorkerThread
    final void zzg(Runnable runnable) {
        zzab();
        if (this.zzasb == null) {
            this.zzasb = new ArrayList();
        }
        this.zzasb.add(runnable);
    }

    public final zzfg zzgf() {
        return this.zzacv.zzgf();
    }

    public final zzkd zzgg() {
        return this.zzacv.zzgg();
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final zzgi zzgh() {
        return this.zzacv.zzgh();
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final zzfi zzgi() {
        return this.zzacv.zzgi();
    }

    public final zzeh zzgk() {
        return this.zzacv.zzgk();
    }

    @Override // com.google.android.gms.internal.measurement.zzhk
    public final zzee zzgl() {
        return this.zzacv.zzgl();
    }

    final String zzh(zzeb zzebVar) {
        try {
            return (String) this.zzacv.zzgh().zzb(new zzjx(this, zzebVar)).get(30000L, TimeUnit.MILLISECONDS);
        } catch (InterruptedException | ExecutionException | TimeoutException e) {
            this.zzacv.zzgi().zziv().zze("Failed to get app instance id. appId", zzfi.zzbp(zzebVar.packageName), e);
            return null;
        }
    }

    public final zzjz zzjf() {
        zza(this.zzary);
        return this.zzary;
    }

    public final zzed zzjg() {
        zza(this.zzarx);
        return this.zzarx;
    }

    public final zzek zzjh() {
        zza(this.zzaru);
        return this.zzaru;
    }

    public final zzfm zzkz() {
        zza(this.zzart);
        return this.zzart;
    }

    final void zzlc() {
        if (!this.zzvn) {
            throw new IllegalStateException("UploadController is not initialized");
        }
    }

    @WorkerThread
    final void zzle() {
        zzea zzeaVarZzbf;
        String str;
        zzfk zzfkVarZzjc;
        String str2;
        zzab();
        zzlc();
        this.zzasg = true;
        try {
            this.zzacv.zzgl();
            Boolean boolZzkr = this.zzacv.zzga().zzkr();
            if (boolZzkr == null) {
                zzfkVarZzjc = this.zzacv.zzgi().zziy();
                str2 = "Upload data called on the client side before use of service was decided";
            } else {
                if (!boolZzkr.booleanValue()) {
                    if (this.zzasa > 0) {
                        zzlg();
                    } else {
                        zzab();
                        if (this.zzasj != null) {
                            zzfkVarZzjc = this.zzacv.zzgi().zzjc();
                            str2 = "Uploading requested multiple times";
                        } else if (zzkz().zzex()) {
                            long jCurrentTimeMillis = this.zzacv.zzbt().currentTimeMillis();
                            zzd(null, jCurrentTimeMillis - zzeh.zzhr());
                            long j = this.zzacv.zzgj().zzalt.get();
                            if (j != 0) {
                                this.zzacv.zzgi().zzjb().zzg("Uploading events. Elapsed time since last upload attempt (ms)", Long.valueOf(Math.abs(jCurrentTimeMillis - j)));
                            }
                            String strZzhv = zzjh().zzhv();
                            if (TextUtils.isEmpty(strZzhv)) {
                                this.zzasl = -1L;
                                String strZzag = zzjh().zzag(jCurrentTimeMillis - zzeh.zzhr());
                                if (!TextUtils.isEmpty(strZzag) && (zzeaVarZzbf = zzjh().zzbf(strZzag)) != null) {
                                    zzb(zzeaVarZzbf);
                                }
                            } else {
                                if (this.zzasl == -1) {
                                    this.zzasl = zzjh().zzic();
                                }
                                List<Pair<zzku, Long>> listZzb = zzjh().zzb(strZzhv, this.zzacv.zzgk().zzb(strZzhv, zzez.zzaik), Math.max(0, this.zzacv.zzgk().zzb(strZzhv, zzez.zzail)));
                                if (!listZzb.isEmpty()) {
                                    Iterator<Pair<zzku, Long>> it2 = listZzb.iterator();
                                    while (true) {
                                        if (!it2.hasNext()) {
                                            str = null;
                                            break;
                                        }
                                        zzku zzkuVar = (zzku) it2.next().first;
                                        if (!TextUtils.isEmpty(zzkuVar.zzavv)) {
                                            str = zzkuVar.zzavv;
                                            break;
                                        }
                                    }
                                    if (str != null) {
                                        int i = 0;
                                        while (true) {
                                            if (i >= listZzb.size()) {
                                                break;
                                            }
                                            zzku zzkuVar2 = (zzku) listZzb.get(i).first;
                                            if (!TextUtils.isEmpty(zzkuVar2.zzavv) && !zzkuVar2.zzavv.equals(str)) {
                                                listZzb = listZzb.subList(0, i);
                                                break;
                                            }
                                            i++;
                                        }
                                    }
                                    zzkt zzktVar = new zzkt();
                                    zzktVar.zzavf = new zzku[listZzb.size()];
                                    ArrayList arrayList = new ArrayList(listZzb.size());
                                    boolean z = zzeh.zzht() && this.zzacv.zzgk().zzau(strZzhv);
                                    for (int i2 = 0; i2 < zzktVar.zzavf.length; i2++) {
                                        zzktVar.zzavf[i2] = (zzku) listZzb.get(i2).first;
                                        arrayList.add((Long) listZzb.get(i2).second);
                                        zzktVar.zzavf[i2].zzavu = Long.valueOf(this.zzacv.zzgk().zzgw());
                                        zzktVar.zzavf[i2].zzavk = Long.valueOf(jCurrentTimeMillis);
                                        zzku zzkuVar3 = zzktVar.zzavf[i2];
                                        this.zzacv.zzgl();
                                        zzkuVar3.zzavz = false;
                                        if (!z) {
                                            zzktVar.zzavf[i2].zzawh = null;
                                        }
                                    }
                                    String strZzb = this.zzacv.zzgi().isLoggable(2) ? zzjf().zzb(zzktVar) : null;
                                    byte[] bArrZza = zzjf().zza(zzktVar);
                                    String str3 = zzez.zzaiu.get();
                                    try {
                                        URL url = new URL(str3);
                                        Preconditions.checkArgument(!arrayList.isEmpty());
                                        if (this.zzasj != null) {
                                            this.zzacv.zzgi().zziv().log("Set uploading progress before finishing the previous upload");
                                        } else {
                                            this.zzasj = new ArrayList(arrayList);
                                        }
                                        this.zzacv.zzgj().zzalu.set(jCurrentTimeMillis);
                                        this.zzacv.zzgi().zzjc().zzd("Uploading data. app, uncompressed size, data", zzktVar.zzavf.length > 0 ? zzktVar.zzavf[0].zzth : "?", Integer.valueOf(bArrZza.length), strZzb);
                                        this.zzasf = true;
                                        zzfm zzfmVarZzkz = zzkz();
                                        zzjv zzjvVar = new zzjv(this, strZzhv);
                                        zzfmVarZzkz.zzab();
                                        zzfmVarZzkz.zzch();
                                        Preconditions.checkNotNull(url);
                                        Preconditions.checkNotNull(bArrZza);
                                        Preconditions.checkNotNull(zzjvVar);
                                        zzfmVarZzkz.zzgh().zzd(new zzfq(zzfmVarZzkz, strZzhv, url, bArrZza, null, zzjvVar));
                                    } catch (MalformedURLException unused) {
                                        this.zzacv.zzgi().zziv().zze("Failed to parse upload URL. Not uploading. appId", zzfi.zzbp(strZzhv), str3);
                                    }
                                }
                            }
                        } else {
                            this.zzacv.zzgi().zzjc().log("Network not connected, ignoring upload request");
                            zzlg();
                        }
                    }
                }
                zzfkVarZzjc = this.zzacv.zzgi().zziv();
                str2 = "Upload called in the client side when service should be used";
            }
            zzfkVarZzjc.log(str2);
        } finally {
            this.zzasg = false;
            zzlh();
        }
    }

    @WorkerThread
    final void zzlj() {
        zzfk zzfkVarZziv;
        String str;
        zzab();
        zzlc();
        if (this.zzarz) {
            return;
        }
        this.zzacv.zzgi().zzja().log("This instance being marked as an uploader");
        zzab();
        zzlc();
        if (zzlk() && zzli()) {
            int iZza = zza(this.zzasi);
            int iZzis = this.zzacv.zzfz().zzis();
            zzab();
            if (iZza > iZzis) {
                zzfkVarZziv = this.zzacv.zzgi().zziv();
                str = "Panic: can't downgrade version. Previous, current version";
            } else if (iZza < iZzis) {
                if (zza(iZzis, this.zzasi)) {
                    zzfkVarZziv = this.zzacv.zzgi().zzjc();
                    str = "Storage version upgraded. Previous, current version";
                } else {
                    zzfkVarZziv = this.zzacv.zzgi().zziv();
                    str = "Storage version upgrade failed. Previous, current version";
                }
            }
            zzfkVarZziv.zze(str, Integer.valueOf(iZza), Integer.valueOf(iZzis));
        }
        this.zzarz = true;
        zzlg();
    }

    final void zzll() {
        this.zzasd++;
    }

    final zzgn zzlm() {
        return this.zzacv;
    }

    final void zzm(boolean z) {
        zzlg();
    }
}
