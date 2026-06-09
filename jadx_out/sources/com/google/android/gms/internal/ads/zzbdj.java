package com.google.android.gms.internal.ads;

import java.lang.reflect.Field;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
final class zzbdj {
    private final int flags;
    private final Object[] zzdwh;
    private final int zzdwi;
    private final int zzdwj;
    private final int zzdwk;
    private final int[] zzdwq;
    private final zzbdk zzdxf;
    private Class<?> zzdxg;
    private final int zzdxh;
    private final int zzdxi;
    private final int zzdxj;
    private final int zzdxk;
    private final int zzdxl;
    private final int zzdxm;
    private int zzdxn;
    private int zzdxo;
    private int zzdxp = Integer.MAX_VALUE;
    private int zzdxq = Integer.MIN_VALUE;
    private int zzdxr = 0;
    private int zzdxs = 0;
    private int zzdxt = 0;
    private int zzdxu = 0;
    private int zzdxv = 0;
    private int zzdxw;
    private int zzdxx;
    private int zzdxy;
    private int zzdxz;
    private int zzdya;
    private Field zzdyb;
    private Object zzdyc;
    private Object zzdyd;
    private Object zzdye;

    zzbdj(Class<?> cls, String str, Object[] objArr) {
        this.zzdxg = cls;
        this.zzdxf = new zzbdk(str);
        this.zzdwh = objArr;
        this.flags = this.zzdxf.next();
        this.zzdxh = this.zzdxf.next();
        if (this.zzdxh == 0) {
            this.zzdxi = 0;
            this.zzdxj = 0;
            this.zzdwi = 0;
            this.zzdwj = 0;
            this.zzdxk = 0;
            this.zzdxl = 0;
            this.zzdwk = 0;
            this.zzdxm = 0;
            this.zzdwq = null;
            return;
        }
        this.zzdxi = this.zzdxf.next();
        this.zzdxj = this.zzdxf.next();
        this.zzdwi = this.zzdxf.next();
        this.zzdwj = this.zzdxf.next();
        this.zzdxl = this.zzdxf.next();
        this.zzdwk = this.zzdxf.next();
        this.zzdxk = this.zzdxf.next();
        this.zzdxm = this.zzdxf.next();
        int next = this.zzdxf.next();
        this.zzdwq = next != 0 ? new int[next] : null;
        this.zzdxn = (this.zzdxi << 1) + this.zzdxj;
    }

    private static Field zza(Class<?> cls, String str) {
        try {
            return cls.getDeclaredField(str);
        } catch (NoSuchFieldException unused) {
            Field[] declaredFields = cls.getDeclaredFields();
            for (Field field : declaredFields) {
                if (str.equals(field.getName())) {
                    return field;
                }
            }
            String name = cls.getName();
            String string = Arrays.toString(declaredFields);
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 40 + String.valueOf(name).length() + String.valueOf(string).length());
            sb.append("Field ");
            sb.append(str);
            sb.append(" for ");
            sb.append(name);
            sb.append(" not found. Known fields are ");
            sb.append(string);
            throw new RuntimeException(sb.toString());
        }
    }

    private final Object zzaey() {
        Object[] objArr = this.zzdwh;
        int i = this.zzdxn;
        this.zzdxn = i + 1;
        return objArr[i];
    }

    private final boolean zzafa() {
        return (this.flags & 1) == 1;
    }

    /* JADX WARN: Code restructure failed: missing block: B:40:0x00d5, code lost:
    
        if (zzafa() != false) goto L41;
     */
    /* JADX WARN: Code restructure failed: missing block: B:41:0x00d7, code lost:
    
        r5.zzdyd = zzaey();
     */
    /* JADX WARN: Code restructure failed: missing block: B:42:0x00dd, code lost:
    
        return true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:71:0x0161, code lost:
    
        if (((r5.zzdxx & 2048) != 0) != false) goto L41;
     */
    /* JADX WARN: Code restructure failed: missing block: B:74:0x0169, code lost:
    
        if (zzafa() != false) goto L41;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    final boolean next() {
        /*
            Method dump skipped, instruction units count: 374
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbdj.next():boolean");
    }

    final int zzaci() {
        return this.zzdxw;
    }

    final int zzaez() {
        return this.zzdxy;
    }

    final boolean zzafb() {
        return this.zzdxy > zzbbj.MAP.id();
    }

    final Field zzafc() {
        int i = this.zzdxz << 1;
        Object obj = this.zzdwh[i];
        if (obj instanceof Field) {
            return (Field) obj;
        }
        Field fieldZza = zza(this.zzdxg, (String) obj);
        this.zzdwh[i] = fieldZza;
        return fieldZza;
    }

    final Field zzafd() {
        int i = (this.zzdxz << 1) + 1;
        Object obj = this.zzdwh[i];
        if (obj instanceof Field) {
            return (Field) obj;
        }
        Field fieldZza = zza(this.zzdxg, (String) obj);
        this.zzdwh[i] = fieldZza;
        return fieldZza;
    }

    final Field zzafe() {
        return this.zzdyb;
    }

    final boolean zzaff() {
        return zzafa() && this.zzdxy <= zzbbj.GROUP.id();
    }

    final Field zzafg() {
        int i = (this.zzdxi << 1) + (this.zzdya / 32);
        Object obj = this.zzdwh[i];
        if (obj instanceof Field) {
            return (Field) obj;
        }
        Field fieldZza = zza(this.zzdxg, (String) obj);
        this.zzdwh[i] = fieldZza;
        return fieldZza;
    }

    final int zzafh() {
        return this.zzdya % 32;
    }

    final boolean zzafi() {
        return (this.zzdxx & 256) != 0;
    }

    final boolean zzafj() {
        return (this.zzdxx & 512) != 0;
    }

    final Object zzafk() {
        return this.zzdyc;
    }

    final Object zzafl() {
        return this.zzdyd;
    }

    final Object zzafm() {
        return this.zzdye;
    }
}
