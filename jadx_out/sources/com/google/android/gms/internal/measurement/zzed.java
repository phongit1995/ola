package com.google.android.gms.internal.measurement;

import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

/* JADX INFO: loaded from: classes2.dex */
final class zzed extends zzjs {
    zzed(zzjt zzjtVar) {
        super(zzjtVar);
    }

    private final Boolean zza(double d, zzkj zzkjVar) {
        try {
            return zza(new BigDecimal(d), zzkjVar, Math.ulp(d));
        } catch (NumberFormatException unused) {
            return null;
        }
    }

    private final Boolean zza(long j, zzkj zzkjVar) {
        try {
            return zza(new BigDecimal(j), zzkjVar, 0.0d);
        } catch (NumberFormatException unused) {
            return null;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    private final Boolean zza(zzkh zzkhVar, String str, zzks[] zzksVarArr, long j) {
        Boolean boolZza;
        String str2;
        Object obj;
        if (zzkhVar.zzato != null) {
            Boolean boolZza2 = zza(j, zzkhVar.zzato);
            if (boolZza2 == null) {
                return null;
            }
            if (!boolZza2.booleanValue()) {
                return false;
            }
        }
        HashSet hashSet = new HashSet();
        for (zzki zzkiVar : zzkhVar.zzatm) {
            if (TextUtils.isEmpty(zzkiVar.zzatt)) {
                zzgi().zziy().zzg("null or empty param name in filter. event", zzgf().zzbm(str));
                return null;
            }
            hashSet.add(zzkiVar.zzatt);
        }
        ArrayMap arrayMap = new ArrayMap();
        for (zzks zzksVar : zzksVarArr) {
            if (hashSet.contains(zzksVar.name)) {
                if (zzksVar.zzave != null) {
                    str2 = zzksVar.name;
                    obj = zzksVar.zzave;
                } else if (zzksVar.zzasw != null) {
                    str2 = zzksVar.name;
                    obj = zzksVar.zzasw;
                } else {
                    if (zzksVar.zzale == null) {
                        zzgi().zziy().zze("Unknown value for param. event, param", zzgf().zzbm(str), zzgf().zzbn(zzksVar.name));
                        return null;
                    }
                    str2 = zzksVar.name;
                    obj = zzksVar.zzale;
                }
                arrayMap.put(str2, obj);
            }
        }
        for (zzki zzkiVar2 : zzkhVar.zzatm) {
            boolean zEquals = Boolean.TRUE.equals(zzkiVar2.zzats);
            String str3 = zzkiVar2.zzatt;
            if (TextUtils.isEmpty(str3)) {
                zzgi().zziy().zzg("Event has empty param name. event", zzgf().zzbm(str));
                return null;
            }
            V v = arrayMap.get(str3);
            if (v instanceof Long) {
                if (zzkiVar2.zzatr == null) {
                    zzgi().zziy().zze("No number filter for long param. event, param", zzgf().zzbm(str), zzgf().zzbn(str3));
                    return null;
                }
                Boolean boolZza3 = zza(((Long) v).longValue(), zzkiVar2.zzatr);
                if (boolZza3 == null) {
                    return null;
                }
                if ((true ^ boolZza3.booleanValue()) ^ zEquals) {
                    return false;
                }
            } else if (v instanceof Double) {
                if (zzkiVar2.zzatr == null) {
                    zzgi().zziy().zze("No number filter for double param. event, param", zzgf().zzbm(str), zzgf().zzbn(str3));
                    return null;
                }
                Boolean boolZza4 = zza(((Double) v).doubleValue(), zzkiVar2.zzatr);
                if (boolZza4 == null) {
                    return null;
                }
                if ((true ^ boolZza4.booleanValue()) ^ zEquals) {
                    return false;
                }
            } else {
                if (!(v instanceof String)) {
                    if (v == 0) {
                        zzgi().zzjc().zze("Missing param for filter. event, param", zzgf().zzbm(str), zzgf().zzbn(str3));
                        return false;
                    }
                    zzgi().zziy().zze("Unknown param type. event, param", zzgf().zzbm(str), zzgf().zzbn(str3));
                    return null;
                }
                if (zzkiVar2.zzatq != null) {
                    boolZza = zza((String) v, zzkiVar2.zzatq);
                } else {
                    if (zzkiVar2.zzatr == null) {
                        zzgi().zziy().zze("No filter for String param. event, param", zzgf().zzbm(str), zzgf().zzbn(str3));
                        return null;
                    }
                    String str4 = (String) v;
                    if (!zzjz.zzcf(str4)) {
                        zzgi().zziy().zze("Invalid param value for number filter. event, param", zzgf().zzbm(str), zzgf().zzbn(str3));
                        return null;
                    }
                    boolZza = zza(str4, zzkiVar2.zzatr);
                }
                if (boolZza == null) {
                    return null;
                }
                if ((true ^ boolZza.booleanValue()) ^ zEquals) {
                    return false;
                }
            }
        }
        return true;
    }

    private final Boolean zza(zzkk zzkkVar, zzkx zzkxVar) {
        zzfk zzfkVarZziy;
        String str;
        Boolean boolZza;
        zzki zzkiVar = zzkkVar.zzaud;
        if (zzkiVar == null) {
            zzfkVarZziy = zzgi().zziy();
            str = "Missing property filter. property";
        } else {
            boolean zEquals = Boolean.TRUE.equals(zzkiVar.zzats);
            if (zzkxVar.zzave != null) {
                if (zzkiVar.zzatr != null) {
                    boolZza = zza(zzkxVar.zzave.longValue(), zzkiVar.zzatr);
                    return zza(boolZza, zEquals);
                }
                zzfkVarZziy = zzgi().zziy();
                str = "No number filter for long property. property";
            } else if (zzkxVar.zzasw != null) {
                if (zzkiVar.zzatr != null) {
                    boolZza = zza(zzkxVar.zzasw.doubleValue(), zzkiVar.zzatr);
                    return zza(boolZza, zEquals);
                }
                zzfkVarZziy = zzgi().zziy();
                str = "No number filter for double property. property";
            } else {
                if (zzkxVar.zzale != null) {
                    if (zzkiVar.zzatq != null) {
                        boolZza = zza(zzkxVar.zzale, zzkiVar.zzatq);
                    } else {
                        if (zzkiVar.zzatr == null) {
                            zzgi().zziy().zzg("No string or number filter defined. property", zzgf().zzbo(zzkxVar.name));
                            return null;
                        }
                        if (!zzjz.zzcf(zzkxVar.zzale)) {
                            zzgi().zziy().zze("Invalid user property value for Numeric number filter. property, value", zzgf().zzbo(zzkxVar.name), zzkxVar.zzale);
                            return null;
                        }
                        boolZza = zza(zzkxVar.zzale, zzkiVar.zzatr);
                    }
                    return zza(boolZza, zEquals);
                }
                zzfkVarZziy = zzgi().zziy();
                str = "User property has no value, property";
            }
        }
        zzfkVarZziy.zzg(str, zzgf().zzbo(zzkxVar.name));
        return null;
    }

    @VisibleForTesting
    private static Boolean zza(Boolean bool, boolean z) {
        if (bool == null) {
            return null;
        }
        return Boolean.valueOf(bool.booleanValue() ^ z);
    }

    private final Boolean zza(String str, int i, boolean z, String str2, List<String> list, String str3) {
        boolean zStartsWith;
        if (str == null) {
            return null;
        }
        if (i == 6) {
            if (list == null || list.size() == 0) {
                return null;
            }
        } else if (str2 == null) {
            return null;
        }
        if (!z && i != 1) {
            str = str.toUpperCase(Locale.ENGLISH);
        }
        switch (i) {
            case 1:
                try {
                    return Boolean.valueOf(Pattern.compile(str3, z ? 0 : 66).matcher(str).matches());
                } catch (PatternSyntaxException unused) {
                    zzgi().zziy().zzg("Invalid regular expression in REGEXP audience filter. expression", str3);
                    return null;
                }
            case 2:
                zStartsWith = str.startsWith(str2);
                break;
            case 3:
                zStartsWith = str.endsWith(str2);
                break;
            case 4:
                zStartsWith = str.contains(str2);
                break;
            case 5:
                zStartsWith = str.equals(str2);
                break;
            case 6:
                zStartsWith = list.contains(str);
                break;
            default:
                return null;
        }
        return Boolean.valueOf(zStartsWith);
    }

    private final Boolean zza(String str, zzkj zzkjVar) {
        if (!zzjz.zzcf(str)) {
            return null;
        }
        try {
            return zza(new BigDecimal(str), zzkjVar, 0.0d);
        } catch (NumberFormatException unused) {
            return null;
        }
    }

    @VisibleForTesting
    private final Boolean zza(String str, zzkl zzklVar) {
        List<String> listAsList;
        Preconditions.checkNotNull(zzklVar);
        if (str == null || zzklVar.zzaue == null || zzklVar.zzaue.intValue() == 0) {
            return null;
        }
        if (zzklVar.zzaue.intValue() == 6) {
            if (zzklVar.zzauh == null || zzklVar.zzauh.length == 0) {
                return null;
            }
        } else if (zzklVar.zzauf == null) {
            return null;
        }
        int iIntValue = zzklVar.zzaue.intValue();
        boolean z = zzklVar.zzaug != null && zzklVar.zzaug.booleanValue();
        String upperCase = (z || iIntValue == 1 || iIntValue == 6) ? zzklVar.zzauf : zzklVar.zzauf.toUpperCase(Locale.ENGLISH);
        if (zzklVar.zzauh == null) {
            listAsList = null;
        } else {
            String[] strArr = zzklVar.zzauh;
            if (z) {
                listAsList = Arrays.asList(strArr);
            } else {
                ArrayList arrayList = new ArrayList();
                for (String str2 : strArr) {
                    arrayList.add(str2.toUpperCase(Locale.ENGLISH));
                }
                listAsList = arrayList;
            }
        }
        return zza(str, iIntValue, z, upperCase, listAsList, iIntValue == 1 ? upperCase : null);
    }

    /* JADX WARN: Code restructure failed: missing block: B:35:0x0070, code lost:
    
        if (r3 != null) goto L36;
     */
    @com.google.android.gms.common.util.VisibleForTesting
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static java.lang.Boolean zza(java.math.BigDecimal r7, com.google.android.gms.internal.measurement.zzkj r8, double r9) {
        /*
            Method dump skipped, instruction units count: 250
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzed.zza(java.math.BigDecimal, com.google.android.gms.internal.measurement.zzkj, double):java.lang.Boolean");
    }

    private final void zza(Integer num, Integer num2, zzki zzkiVar, Boolean bool, Boolean bool2) {
        if (zzkiVar == null) {
            zzgi().zziy().zze("The leaf filter of event or user property filter is null. audience ID, filter ID", num, num2);
            return;
        }
        boolean z = false;
        zzkiVar.zzatu = Boolean.valueOf((bool != null && bool.booleanValue()) || (bool2 != null && bool2.booleanValue()));
        if (bool2 != null && bool2.booleanValue()) {
            z = true;
        }
        zzkiVar.zzatv = Boolean.valueOf(z);
    }

    private static void zza(Map<Integer, Long> map, int i, long j) {
        Long l = map.get(Integer.valueOf(i));
        long j2 = j / 1000;
        if (l == null || j2 > l.longValue()) {
            map.put(Integer.valueOf(i), Long.valueOf(j2));
        }
    }

    private static zzkq[] zzd(Map<Integer, Long> map) {
        if (map == null) {
            return null;
        }
        int i = 0;
        zzkq[] zzkqVarArr = new zzkq[map.size()];
        for (Integer num : map.keySet()) {
            zzkq zzkqVar = new zzkq();
            zzkqVar.zzaux = num;
            zzkqVar.zzauy = map.get(num);
            zzkqVarArr[i] = zzkqVar;
            i++;
        }
        return zzkqVarArr;
    }

    @WorkerThread
    final void zza(String str, zzkg[] zzkgVarArr) {
        Preconditions.checkNotNull(zzkgVarArr);
        for (zzkg zzkgVar : zzkgVarArr) {
            for (zzkh zzkhVar : zzkgVar.zzatg) {
                String strZzal = AppMeasurement.Event.zzal(zzkhVar.zzatl);
                if (strZzal != null) {
                    zzkhVar.zzatl = strZzal;
                }
                for (zzki zzkiVar : zzkhVar.zzatm) {
                    String strZzal2 = AppMeasurement.Param.zzal(zzkiVar.zzatt);
                    if (strZzal2 != null) {
                        zzkiVar.zzatt = strZzal2;
                    }
                    zza(zzkgVar.zzate, zzkhVar.zzatk, zzkiVar, zzkgVar.zzath, zzkgVar.zzati);
                }
            }
            for (zzkk zzkkVar : zzkgVar.zzatf) {
                String strZzal3 = AppMeasurement.UserProperty.zzal(zzkkVar.zzauc);
                if (strZzal3 != null) {
                    zzkkVar.zzauc = strZzal3;
                }
                zza(zzkgVar.zzate, zzkkVar.zzatk, zzkkVar.zzaud, zzkgVar.zzath, zzkgVar.zzati);
            }
        }
        zzjh().zzb(str, zzkgVarArr);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:103:0x02b4  */
    /* JADX WARN: Removed duplicated region for block: B:111:0x02d2  */
    /* JADX WARN: Removed duplicated region for block: B:115:0x0311  */
    /* JADX WARN: Removed duplicated region for block: B:130:0x0382  */
    /* JADX WARN: Removed duplicated region for block: B:131:0x03d2  */
    /* JADX WARN: Removed duplicated region for block: B:134:0x03fa  */
    /* JADX WARN: Removed duplicated region for block: B:138:0x040f  */
    /* JADX WARN: Removed duplicated region for block: B:142:0x0420  */
    /* JADX WARN: Removed duplicated region for block: B:185:0x05b3  */
    /* JADX WARN: Removed duplicated region for block: B:187:0x05db  */
    /* JADX WARN: Removed duplicated region for block: B:188:0x05de  */
    /* JADX WARN: Removed duplicated region for block: B:193:0x05ff  */
    /* JADX WARN: Removed duplicated region for block: B:297:0x0972  */
    /* JADX WARN: Removed duplicated region for block: B:390:0x05e4 A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:62:0x01c2  */
    /* JADX WARN: Removed duplicated region for block: B:98:0x029b  */
    @android.support.annotation.WorkerThread
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final com.google.android.gms.internal.measurement.zzkp[] zza(java.lang.String r77, com.google.android.gms.internal.measurement.zzkr[] r78, com.google.android.gms.internal.measurement.zzkx[] r79) {
        /*
            Method dump skipped, instruction units count: 2848
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzed.zza(java.lang.String, com.google.android.gms.internal.measurement.zzkr[], com.google.android.gms.internal.measurement.zzkx[]):com.google.android.gms.internal.measurement.zzkp[]");
    }

    @Override // com.google.android.gms.internal.measurement.zzjs
    protected final boolean zzgn() {
        return false;
    }
}
