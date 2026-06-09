package com.google.android.gms.internal.measurement;

import android.content.Context;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.WorkerThread;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.common.util.Clock;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.BitSet;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

/* JADX INFO: loaded from: classes2.dex */
public final class zzjz extends zzjs {
    zzjz(zzjt zzjtVar) {
        super(zzjtVar);
    }

    static zzks zza(zzkr zzkrVar, String str) {
        for (zzks zzksVar : zzkrVar.zzava) {
            if (zzksVar.name.equals(str)) {
                return zzksVar;
            }
        }
        return null;
    }

    private static void zza(StringBuilder sb, int i) {
        for (int i2 = 0; i2 < i; i2++) {
            sb.append("  ");
        }
    }

    private final void zza(StringBuilder sb, int i, zzki zzkiVar) {
        if (zzkiVar == null) {
            return;
        }
        zza(sb, i);
        sb.append("filter {\n");
        zza(sb, i, "complement", zzkiVar.zzats);
        zza(sb, i, "param_name", zzgf().zzbn(zzkiVar.zzatt));
        int i2 = i + 1;
        zzkl zzklVar = zzkiVar.zzatq;
        if (zzklVar != null) {
            zza(sb, i2);
            sb.append("string_filter");
            sb.append(" {\n");
            if (zzklVar.zzaue != null) {
                String str = "UNKNOWN_MATCH_TYPE";
                switch (zzklVar.zzaue.intValue()) {
                    case 1:
                        str = "REGEXP";
                        break;
                    case 2:
                        str = "BEGINS_WITH";
                        break;
                    case 3:
                        str = "ENDS_WITH";
                        break;
                    case 4:
                        str = "PARTIAL";
                        break;
                    case 5:
                        str = "EXACT";
                        break;
                    case 6:
                        str = "IN_LIST";
                        break;
                }
                zza(sb, i2, "match_type", str);
            }
            zza(sb, i2, "expression", zzklVar.zzauf);
            zza(sb, i2, "case_sensitive", zzklVar.zzaug);
            if (zzklVar.zzauh.length > 0) {
                zza(sb, i2 + 1);
                sb.append("expression_list {\n");
                for (String str2 : zzklVar.zzauh) {
                    zza(sb, i2 + 2);
                    sb.append(str2);
                    sb.append("\n");
                }
                sb.append("}\n");
            }
            zza(sb, i2);
            sb.append("}\n");
        }
        zza(sb, i2, "number_filter", zzkiVar.zzatr);
        zza(sb, i);
        sb.append("}\n");
    }

    private final void zza(StringBuilder sb, int i, String str, zzkj zzkjVar) {
        if (zzkjVar == null) {
            return;
        }
        zza(sb, i);
        sb.append(str);
        sb.append(" {\n");
        if (zzkjVar.zzatw != null) {
            String str2 = "UNKNOWN_COMPARISON_TYPE";
            switch (zzkjVar.zzatw.intValue()) {
                case 1:
                    str2 = "LESS_THAN";
                    break;
                case 2:
                    str2 = "GREATER_THAN";
                    break;
                case 3:
                    str2 = "EQUAL";
                    break;
                case 4:
                    str2 = "BETWEEN";
                    break;
            }
            zza(sb, i, "comparison_type", str2);
        }
        zza(sb, i, "match_as_float", zzkjVar.zzatx);
        zza(sb, i, "comparison_value", zzkjVar.zzaty);
        zza(sb, i, "min_comparison_value", zzkjVar.zzatz);
        zza(sb, i, "max_comparison_value", zzkjVar.zzaua);
        zza(sb, i);
        sb.append("}\n");
    }

    private static void zza(StringBuilder sb, int i, String str, zzkv zzkvVar) {
        if (zzkvVar == null) {
            return;
        }
        zza(sb, 3);
        sb.append(str);
        sb.append(" {\n");
        int i2 = 0;
        if (zzkvVar.zzawm != null) {
            zza(sb, 4);
            sb.append("results: ");
            long[] jArr = zzkvVar.zzawm;
            int length = jArr.length;
            int i3 = 0;
            int i4 = 0;
            while (i3 < length) {
                Long lValueOf = Long.valueOf(jArr[i3]);
                int i5 = i4 + 1;
                if (i4 != 0) {
                    sb.append(", ");
                }
                sb.append(lValueOf);
                i3++;
                i4 = i5;
            }
            sb.append('\n');
        }
        if (zzkvVar.zzawl != null) {
            zza(sb, 4);
            sb.append("status: ");
            long[] jArr2 = zzkvVar.zzawl;
            int length2 = jArr2.length;
            int i6 = 0;
            while (i2 < length2) {
                Long lValueOf2 = Long.valueOf(jArr2[i2]);
                int i7 = i6 + 1;
                if (i6 != 0) {
                    sb.append(", ");
                }
                sb.append(lValueOf2);
                i2++;
                i6 = i7;
            }
            sb.append('\n');
        }
        zza(sb, 3);
        sb.append("}\n");
    }

    private static void zza(StringBuilder sb, int i, String str, Object obj) {
        if (obj == null) {
            return;
        }
        zza(sb, i + 1);
        sb.append(str);
        sb.append(": ");
        sb.append(obj);
        sb.append('\n');
    }

    static boolean zza(long[] jArr, int i) {
        return i < (jArr.length << 6) && (jArr[i / 64] & (1 << (i % 64))) != 0;
    }

    static long[] zza(BitSet bitSet) {
        int length = (bitSet.length() + 63) / 64;
        long[] jArr = new long[length];
        for (int i = 0; i < length; i++) {
            jArr[i] = 0;
            for (int i2 = 0; i2 < 64; i2++) {
                int i3 = (i << 6) + i2;
                if (i3 < bitSet.length()) {
                    if (bitSet.get(i3)) {
                        jArr[i] = jArr[i] | (1 << i2);
                    }
                }
            }
        }
        return jArr;
    }

    static zzks[] zza(zzks[] zzksVarArr, String str, Object obj) {
        for (zzks zzksVar : zzksVarArr) {
            if (str.equals(zzksVar.name)) {
                zzksVar.zzave = null;
                zzksVar.zzale = null;
                zzksVar.zzasw = null;
                if (obj instanceof Long) {
                    zzksVar.zzave = (Long) obj;
                    return zzksVarArr;
                }
                if (obj instanceof String) {
                    zzksVar.zzale = (String) obj;
                    return zzksVarArr;
                }
                if (obj instanceof Double) {
                    zzksVar.zzasw = (Double) obj;
                }
                return zzksVarArr;
            }
        }
        zzks[] zzksVarArr2 = new zzks[zzksVarArr.length + 1];
        System.arraycopy(zzksVarArr, 0, zzksVarArr2, 0, zzksVarArr.length);
        zzks zzksVar2 = new zzks();
        zzksVar2.name = str;
        if (obj instanceof Long) {
            zzksVar2.zzave = (Long) obj;
        } else if (obj instanceof String) {
            zzksVar2.zzale = (String) obj;
        } else if (obj instanceof Double) {
            zzksVar2.zzasw = (Double) obj;
        }
        zzksVarArr2[zzksVarArr.length] = zzksVar2;
        return zzksVarArr2;
    }

    static Object zzb(zzkr zzkrVar, String str) {
        zzks zzksVarZza = zza(zzkrVar, str);
        if (zzksVarZza == null) {
            return null;
        }
        if (zzksVarZza.zzale != null) {
            return zzksVarZza.zzale;
        }
        if (zzksVarZza.zzave != null) {
            return zzksVarZza.zzave;
        }
        if (zzksVarZza.zzasw != null) {
            return zzksVarZza.zzasw;
        }
        return null;
    }

    static boolean zzcf(String str) {
        return str != null && str.matches("([+-])?([0-9]+\\.?[0-9]*|[0-9]*\\.?[0-9]+)") && str.length() <= 310;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    final <T extends Parcelable> T zza(byte[] bArr, Parcelable.Creator<T> creator) {
        if (bArr == null) {
            return null;
        }
        Parcel parcelObtain = Parcel.obtain();
        try {
            parcelObtain.unmarshall(bArr, 0, bArr.length);
            parcelObtain.setDataPosition(0);
            return creator.createFromParcel(parcelObtain);
        } catch (SafeParcelReader.ParseException unused) {
            zzgi().zziv().log("Failed to load parcelable from buffer");
            return null;
        } finally {
            parcelObtain.recycle();
        }
    }

    final String zza(zzkh zzkhVar) {
        if (zzkhVar == null) {
            return "null";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("\nevent_filter {\n");
        zza(sb, 0, "filter_id", zzkhVar.zzatk);
        zza(sb, 0, "event_name", zzgf().zzbm(zzkhVar.zzatl));
        zza(sb, 1, "event_count_filter", zzkhVar.zzato);
        sb.append("  filters {\n");
        for (zzki zzkiVar : zzkhVar.zzatm) {
            zza(sb, 2, zzkiVar);
        }
        zza(sb, 1);
        sb.append("}\n}\n");
        return sb.toString();
    }

    final String zza(zzkk zzkkVar) {
        if (zzkkVar == null) {
            return "null";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("\nproperty_filter {\n");
        zza(sb, 0, "filter_id", zzkkVar.zzatk);
        zza(sb, 0, "property_name", zzgf().zzbo(zzkkVar.zzauc));
        zza(sb, 1, zzkkVar.zzaud);
        sb.append("}\n");
        return sb.toString();
    }

    final void zza(zzks zzksVar, Object obj) {
        Preconditions.checkNotNull(obj);
        zzksVar.zzale = null;
        zzksVar.zzave = null;
        zzksVar.zzasw = null;
        if (obj instanceof String) {
            zzksVar.zzale = (String) obj;
            return;
        }
        if (obj instanceof Long) {
            zzksVar.zzave = (Long) obj;
        } else if (obj instanceof Double) {
            zzksVar.zzasw = (Double) obj;
        } else {
            zzgi().zziv().zzg("Ignoring invalid (type) event param value", obj);
        }
    }

    final void zza(zzkx zzkxVar, Object obj) {
        Preconditions.checkNotNull(obj);
        zzkxVar.zzale = null;
        zzkxVar.zzave = null;
        zzkxVar.zzasw = null;
        if (obj instanceof String) {
            zzkxVar.zzale = (String) obj;
            return;
        }
        if (obj instanceof Long) {
            zzkxVar.zzave = (Long) obj;
        } else if (obj instanceof Double) {
            zzkxVar.zzasw = (Double) obj;
        } else {
            zzgi().zziv().zzg("Ignoring invalid (type) user attribute value", obj);
        }
    }

    final boolean zza(long j, long j2) {
        return j == 0 || j2 <= 0 || Math.abs(zzbt().currentTimeMillis() - j) > j2;
    }

    final byte[] zza(zzkt zzktVar) {
        try {
            byte[] bArr = new byte[zzktVar.zzwb()];
            zzacb zzacbVarZzb = zzacb.zzb(bArr, 0, bArr.length);
            zzktVar.zza(zzacbVarZzb);
            zzacbVarZzb.zzvt();
            return bArr;
        } catch (IOException e) {
            zzgi().zziv().zzg("Data loss. Failed to serialize batch", e);
            return null;
        }
    }

    final byte[] zza(byte[] bArr) throws IOException {
        try {
            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bArr);
            GZIPInputStream gZIPInputStream = new GZIPInputStream(byteArrayInputStream);
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            byte[] bArr2 = new byte[1024];
            while (true) {
                int i = gZIPInputStream.read(bArr2);
                if (i <= 0) {
                    gZIPInputStream.close();
                    byteArrayInputStream.close();
                    return byteArrayOutputStream.toByteArray();
                }
                byteArrayOutputStream.write(bArr2, 0, i);
            }
        } catch (IOException e) {
            zzgi().zziv().zzg("Failed to ungzip content", e);
            throw e;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzab() {
        super.zzab();
    }

    final String zzb(zzkt zzktVar) {
        StringBuilder sb = new StringBuilder();
        sb.append("\nbatch {\n");
        if (zzktVar.zzavf != null) {
            for (zzku zzkuVar : zzktVar.zzavf) {
                if (zzkuVar != null && zzkuVar != null) {
                    zza(sb, 1);
                    sb.append("bundle {\n");
                    zza(sb, 1, "protocol_version", zzkuVar.zzavh);
                    zza(sb, 1, "platform", zzkuVar.zzavp);
                    zza(sb, 1, "gmp_version", zzkuVar.zzavt);
                    zza(sb, 1, "uploading_gmp_version", zzkuVar.zzavu);
                    zza(sb, 1, "config_version", zzkuVar.zzawf);
                    zza(sb, 1, "gmp_app_id", zzkuVar.zzafa);
                    zza(sb, 1, "app_id", zzkuVar.zzth);
                    zza(sb, 1, "app_version", zzkuVar.zztg);
                    zza(sb, 1, "app_version_major", zzkuVar.zzawb);
                    zza(sb, 1, "firebase_instance_id", zzkuVar.zzafc);
                    zza(sb, 1, "dev_cert_hash", zzkuVar.zzavx);
                    zza(sb, 1, "app_store", zzkuVar.zzafh);
                    zza(sb, 1, "upload_timestamp_millis", zzkuVar.zzavk);
                    zza(sb, 1, "start_timestamp_millis", zzkuVar.zzavl);
                    zza(sb, 1, "end_timestamp_millis", zzkuVar.zzavm);
                    zza(sb, 1, "previous_bundle_start_timestamp_millis", zzkuVar.zzavn);
                    zza(sb, 1, "previous_bundle_end_timestamp_millis", zzkuVar.zzavo);
                    zza(sb, 1, "app_instance_id", zzkuVar.zzaez);
                    zza(sb, 1, "resettable_device_id", zzkuVar.zzavv);
                    zza(sb, 1, "device_id", zzkuVar.zzawe);
                    zza(sb, 1, "ds_id", zzkuVar.zzawh);
                    zza(sb, 1, "limited_ad_tracking", zzkuVar.zzavw);
                    zza(sb, 1, "os_version", zzkuVar.zzavq);
                    zza(sb, 1, "device_model", zzkuVar.zzavr);
                    zza(sb, 1, "user_default_language", zzkuVar.zzahd);
                    zza(sb, 1, "time_zone_offset_minutes", zzkuVar.zzavs);
                    zza(sb, 1, "bundle_sequential_index", zzkuVar.zzavy);
                    zza(sb, 1, "service_upload", zzkuVar.zzavz);
                    zza(sb, 1, "health_monitor", zzkuVar.zzafy);
                    if (zzkuVar.zzawg != null && zzkuVar.zzawg.longValue() != 0) {
                        zza(sb, 1, "android_id", zzkuVar.zzawg);
                    }
                    if (zzkuVar.zzawj != null) {
                        zza(sb, 1, "retry_counter", zzkuVar.zzawj);
                    }
                    zzkx[] zzkxVarArr = zzkuVar.zzavj;
                    if (zzkxVarArr != null) {
                        for (zzkx zzkxVar : zzkxVarArr) {
                            if (zzkxVar != null) {
                                zza(sb, 2);
                                sb.append("user_property {\n");
                                zza(sb, 2, "set_timestamp_millis", zzkxVar.zzaws);
                                zza(sb, 2, "name", zzgf().zzbo(zzkxVar.name));
                                zza(sb, 2, "string_value", zzkxVar.zzale);
                                zza(sb, 2, "int_value", zzkxVar.zzave);
                                zza(sb, 2, "double_value", zzkxVar.zzasw);
                                zza(sb, 2);
                                sb.append("}\n");
                            }
                        }
                    }
                    zzkp[] zzkpVarArr = zzkuVar.zzawa;
                    if (zzkpVarArr != null) {
                        for (zzkp zzkpVar : zzkpVarArr) {
                            if (zzkpVar != null) {
                                zza(sb, 2);
                                sb.append("audience_membership {\n");
                                zza(sb, 2, "audience_id", zzkpVar.zzate);
                                zza(sb, 2, "new_audience", zzkpVar.zzauv);
                                zza(sb, 2, "current_data", zzkpVar.zzaut);
                                zza(sb, 2, "previous_data", zzkpVar.zzauu);
                                zza(sb, 2);
                                sb.append("}\n");
                            }
                        }
                    }
                    zzkr[] zzkrVarArr = zzkuVar.zzavi;
                    if (zzkrVarArr != null) {
                        for (zzkr zzkrVar : zzkrVarArr) {
                            if (zzkrVar != null) {
                                zza(sb, 2);
                                sb.append("event {\n");
                                zza(sb, 2, "name", zzgf().zzbm(zzkrVar.name));
                                zza(sb, 2, "timestamp_millis", zzkrVar.zzavb);
                                zza(sb, 2, "previous_timestamp_millis", zzkrVar.zzavc);
                                zza(sb, 2, "count", zzkrVar.count);
                                zzks[] zzksVarArr = zzkrVar.zzava;
                                if (zzksVarArr != null) {
                                    for (zzks zzksVar : zzksVarArr) {
                                        if (zzksVar != null) {
                                            zza(sb, 3);
                                            sb.append("param {\n");
                                            zza(sb, 3, "name", zzgf().zzbn(zzksVar.name));
                                            zza(sb, 3, "string_value", zzksVar.zzale);
                                            zza(sb, 3, "int_value", zzksVar.zzave);
                                            zza(sb, 3, "double_value", zzksVar.zzasw);
                                            zza(sb, 3);
                                            sb.append("}\n");
                                        }
                                    }
                                }
                                zza(sb, 2);
                                sb.append("}\n");
                            }
                        }
                    }
                    zza(sb, 1);
                    sb.append("}\n");
                }
            }
        }
        sb.append("}\n");
        return sb.toString();
    }

    final byte[] zzb(byte[] bArr) {
        try {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            GZIPOutputStream gZIPOutputStream = new GZIPOutputStream(byteArrayOutputStream);
            gZIPOutputStream.write(bArr);
            gZIPOutputStream.close();
            byteArrayOutputStream.close();
            return byteArrayOutputStream.toByteArray();
        } catch (IOException e) {
            zzgi().zziv().zzg("Failed to gzip content", e);
            throw e;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ Clock zzbt() {
        return super.zzbt();
    }

    @WorkerThread
    final boolean zzd(zzex zzexVar, zzeb zzebVar) {
        Preconditions.checkNotNull(zzexVar);
        Preconditions.checkNotNull(zzebVar);
        if (!TextUtils.isEmpty(zzebVar.zzafa)) {
            return true;
        }
        zzgl();
        return false;
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfu() {
        super.zzfu();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfv() {
        super.zzfv();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ void zzfw() {
        super.zzfw();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzer zzge() {
        return super.zzge();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzfg zzgf() {
        return super.zzgf();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzkd zzgg() {
        return super.zzgg();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzgi zzgh() {
        return super.zzgh();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzfi zzgi() {
        return super.zzgi();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzft zzgj() {
        return super.zzgj();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi
    public final /* bridge */ /* synthetic */ zzeh zzgk() {
        return super.zzgk();
    }

    @Override // com.google.android.gms.internal.measurement.zzhi, com.google.android.gms.internal.measurement.zzhk
    public final /* bridge */ /* synthetic */ zzee zzgl() {
        return super.zzgl();
    }

    @Override // com.google.android.gms.internal.measurement.zzjs
    protected final boolean zzgn() {
        return false;
    }

    @Override // com.google.android.gms.internal.measurement.zzjr
    public final /* bridge */ /* synthetic */ zzjz zzjf() {
        return super.zzjf();
    }

    @Override // com.google.android.gms.internal.measurement.zzjr
    public final /* bridge */ /* synthetic */ zzed zzjg() {
        return super.zzjg();
    }

    @Override // com.google.android.gms.internal.measurement.zzjr
    public final /* bridge */ /* synthetic */ zzek zzjh() {
        return super.zzjh();
    }
}
