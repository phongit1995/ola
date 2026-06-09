package com.google.android.gms.internal.ads;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzbat implements zzbdl {
    private int tag;
    private final zzbaq zzdqi;
    private int zzdqj;
    private int zzdqk = 0;

    private zzbat(zzbaq zzbaqVar) {
        this.zzdqi = (zzbaq) zzbbq.zza(zzbaqVar, "input");
        this.zzdqi.zzdqa = this;
    }

    public static zzbat zza(zzbaq zzbaqVar) {
        return zzbaqVar.zzdqa != null ? zzbaqVar.zzdqa : new zzbat(zzbaqVar);
    }

    private final Object zza(zzbes zzbesVar, Class<?> cls, zzbbb zzbbbVar) throws zzbbv {
        switch (zzbau.zzdql[zzbesVar.ordinal()]) {
            case 1:
                return Boolean.valueOf(zzabq());
            case 2:
                return zzabs();
            case 3:
                return Double.valueOf(readDouble());
            case 4:
                return Integer.valueOf(zzabu());
            case 5:
                return Integer.valueOf(zzabp());
            case 6:
                return Long.valueOf(zzabo());
            case 7:
                return Float.valueOf(readFloat());
            case 8:
                return Integer.valueOf(zzabn());
            case 9:
                return Long.valueOf(zzabm());
            case 10:
                zzbv(2);
                return zzc(zzbdg.zzaeo().zze(cls), zzbbbVar);
            case 11:
                return Integer.valueOf(zzabv());
            case 12:
                return Long.valueOf(zzabw());
            case 13:
                return Integer.valueOf(zzabx());
            case 14:
                return Long.valueOf(zzaby());
            case 15:
                return zzabr();
            case 16:
                return Integer.valueOf(zzabt());
            case 17:
                return Long.valueOf(zzabl());
            default:
                throw new RuntimeException("unsupported field type.");
        }
    }

    private final void zza(List<String> list, boolean z) throws zzbbv {
        int iZzabk;
        int iZzabk2;
        if ((this.tag & 7) != 2) {
            throw zzbbu.zzadq();
        }
        if (!(list instanceof zzbcd) || z) {
            do {
                list.add(z ? zzabr() : readString());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbcd zzbcdVar = (zzbcd) list;
        do {
            zzbcdVar.zzap(zzabs());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    private final void zzbv(int i) throws zzbbv {
        if ((this.tag & 7) != i) {
            throw zzbbu.zzadq();
        }
    }

    private static void zzbw(int i) throws zzbbu {
        if ((i & 7) != 0) {
            throw zzbbu.zzadr();
        }
    }

    private static void zzbx(int i) throws zzbbu {
        if ((i & 3) != 0) {
            throw zzbbu.zzadr();
        }
    }

    private final void zzby(int i) throws zzbbu {
        if (this.zzdqi.zzacb() != i) {
            throw zzbbu.zzadl();
        }
    }

    private final <T> T zzc(zzbdm<T> zzbdmVar, zzbbb zzbbbVar) throws zzbbu {
        int iZzabt = this.zzdqi.zzabt();
        if (this.zzdqi.zzdpx >= this.zzdqi.zzdpy) {
            throw new zzbbu("Protocol message had too many levels of nesting.  May be malicious.  Use CodedInputStream.setRecursionLimit() to increase the depth limit.");
        }
        int iZzbr = this.zzdqi.zzbr(iZzabt);
        T tNewInstance = zzbdmVar.newInstance();
        this.zzdqi.zzdpx++;
        zzbdmVar.zza(tNewInstance, this, zzbbbVar);
        zzbdmVar.zzo(tNewInstance);
        this.zzdqi.zzbp(0);
        zzbaq zzbaqVar = this.zzdqi;
        zzbaqVar.zzdpx--;
        this.zzdqi.zzbs(iZzbr);
        return tNewInstance;
    }

    private final <T> T zzd(zzbdm<T> zzbdmVar, zzbbb zzbbbVar) {
        int i = this.zzdqj;
        this.zzdqj = ((this.tag >>> 3) << 3) | 4;
        try {
            T tNewInstance = zzbdmVar.newInstance();
            zzbdmVar.zza(tNewInstance, this, zzbbbVar);
            zzbdmVar.zzo(tNewInstance);
            if (this.tag != this.zzdqj) {
                throw zzbbu.zzadr();
            }
            return tNewInstance;
        } finally {
            this.zzdqj = i;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int getTag() {
        return this.tag;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final double readDouble() throws zzbbv {
        zzbv(1);
        return this.zzdqi.readDouble();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final float readFloat() throws zzbbv {
        zzbv(5);
        return this.zzdqi.readFloat();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final String readString() throws zzbbv {
        zzbv(2);
        return this.zzdqi.readString();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void readStringList(List<String> list) throws zzbbv {
        zza(list, false);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final <T> T zza(zzbdm<T> zzbdmVar, zzbbb zzbbbVar) throws zzbbv {
        zzbv(2);
        return (T) zzc(zzbdmVar, zzbbbVar);
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.ads.zzbdl
    public final <T> void zza(List<T> list, zzbdm<T> zzbdmVar, zzbbb zzbbbVar) throws zzbbv {
        int iZzabk;
        if ((this.tag & 7) != 2) {
            throw zzbbu.zzadq();
        }
        int i = this.tag;
        do {
            list.add(zzc(zzbdmVar, zzbbbVar));
            if (this.zzdqi.zzaca() || this.zzdqk != 0) {
                return;
            } else {
                iZzabk = this.zzdqi.zzabk();
            }
        } while (iZzabk == i);
        this.zzdqk = iZzabk;
    }

    /* JADX WARN: Code restructure failed: missing block: B:18:0x005c, code lost:
    
        r6.put(r1, r2);
     */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x0064, code lost:
    
        return;
     */
    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.ads.zzbdl
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final <K, V> void zza(java.util.Map<K, V> r6, com.google.android.gms.internal.ads.zzbcn<K, V> r7, com.google.android.gms.internal.ads.zzbbb r8) throws com.google.android.gms.internal.ads.zzbbv {
        /*
            r5 = this;
            r0 = 2
            r5.zzbv(r0)
            com.google.android.gms.internal.ads.zzbaq r0 = r5.zzdqi
            int r0 = r0.zzabt()
            com.google.android.gms.internal.ads.zzbaq r1 = r5.zzdqi
            int r0 = r1.zzbr(r0)
            K r1 = r7.zzdvz
            V r2 = r7.zzdwb
        L14:
            int r3 = r5.zzaci()     // Catch: java.lang.Throwable -> L65
            r4 = 2147483647(0x7fffffff, float:NaN)
            if (r3 == r4) goto L5c
            com.google.android.gms.internal.ads.zzbaq r4 = r5.zzdqi     // Catch: java.lang.Throwable -> L65
            boolean r4 = r4.zzaca()     // Catch: java.lang.Throwable -> L65
            if (r4 != 0) goto L5c
            switch(r3) {
                case 1: goto L3b;
                case 2: goto L2d;
                default: goto L28;
            }
        L28:
            boolean r3 = r5.zzacj()     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            goto L44
        L2d:
            com.google.android.gms.internal.ads.zzbes r3 = r7.zzdwa     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            V r4 = r7.zzdwb     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            java.lang.Class r4 = r4.getClass()     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            java.lang.Object r3 = r5.zza(r3, r4, r8)     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            r2 = r3
            goto L14
        L3b:
            com.google.android.gms.internal.ads.zzbes r3 = r7.zzdvy     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            r4 = 0
            java.lang.Object r3 = r5.zza(r3, r4, r4)     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            r1 = r3
            goto L14
        L44:
            if (r3 != 0) goto L14
            com.google.android.gms.internal.ads.zzbbu r3 = new com.google.android.gms.internal.ads.zzbbu     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            java.lang.String r4 = "Unable to parse map entry."
            r3.<init>(r4)     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
            throw r3     // Catch: com.google.android.gms.internal.ads.zzbbv -> L4e java.lang.Throwable -> L65
        L4e:
            boolean r3 = r5.zzacj()     // Catch: java.lang.Throwable -> L65
            if (r3 != 0) goto L14
            com.google.android.gms.internal.ads.zzbbu r6 = new com.google.android.gms.internal.ads.zzbbu     // Catch: java.lang.Throwable -> L65
            java.lang.String r7 = "Unable to parse map entry."
            r6.<init>(r7)     // Catch: java.lang.Throwable -> L65
            throw r6     // Catch: java.lang.Throwable -> L65
        L5c:
            r6.put(r1, r2)     // Catch: java.lang.Throwable -> L65
            com.google.android.gms.internal.ads.zzbaq r6 = r5.zzdqi
            r6.zzbs(r0)
            return
        L65:
            r6 = move-exception
            com.google.android.gms.internal.ads.zzbaq r7 = r5.zzdqi
            r7.zzbs(r0)
            throw r6
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzbat.zza(java.util.Map, com.google.android.gms.internal.ads.zzbcn, com.google.android.gms.internal.ads.zzbbb):void");
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzaa(List<Integer> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbp)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zzdqi.zzabu()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Integer.valueOf(this.zzdqi.zzabu()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbbp zzbbpVar = (zzbbp) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbbpVar.zzco(this.zzdqi.zzabu());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbbpVar.zzco(this.zzdqi.zzabu());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzab(List<Integer> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbp)) {
            int i = this.tag & 7;
            if (i == 2) {
                int iZzabt = this.zzdqi.zzabt();
                zzbx(iZzabt);
                int iZzacb = this.zzdqi.zzacb() + iZzabt;
                do {
                    list.add(Integer.valueOf(this.zzdqi.zzabv()));
                } while (this.zzdqi.zzacb() < iZzacb);
                return;
            }
            if (i != 5) {
                throw zzbbu.zzadq();
            }
            do {
                list.add(Integer.valueOf(this.zzdqi.zzabv()));
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbbp zzbbpVar = (zzbbp) list;
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzabt2 = this.zzdqi.zzabt();
            zzbx(iZzabt2);
            int iZzacb2 = this.zzdqi.zzacb() + iZzabt2;
            do {
                zzbbpVar.zzco(this.zzdqi.zzabv());
            } while (this.zzdqi.zzacb() < iZzacb2);
            return;
        }
        if (i2 != 5) {
            throw zzbbu.zzadq();
        }
        do {
            zzbbpVar.zzco(this.zzdqi.zzabv());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final long zzabl() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabl();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final long zzabm() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabm();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzabn() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabn();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final long zzabo() throws zzbbv {
        zzbv(1);
        return this.zzdqi.zzabo();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzabp() throws zzbbv {
        zzbv(5);
        return this.zzdqi.zzabp();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final boolean zzabq() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabq();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final String zzabr() throws zzbbv {
        zzbv(2);
        return this.zzdqi.zzabr();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final zzbah zzabs() throws zzbbv {
        zzbv(2);
        return this.zzdqi.zzabs();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzabt() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabt();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzabu() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabu();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzabv() throws zzbbv {
        zzbv(5);
        return this.zzdqi.zzabv();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final long zzabw() throws zzbbv {
        zzbv(1);
        return this.zzdqi.zzabw();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzabx() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzabx();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final long zzaby() throws zzbbv {
        zzbv(0);
        return this.zzdqi.zzaby();
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzac(List<Long> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbci)) {
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzabt = this.zzdqi.zzabt();
                    zzbw(iZzabt);
                    int iZzacb = this.zzdqi.zzacb() + iZzabt;
                    do {
                        list.add(Long.valueOf(this.zzdqi.zzabw()));
                    } while (this.zzdqi.zzacb() < iZzacb);
                    return;
                default:
                    throw zzbbu.zzadq();
            }
            do {
                list.add(Long.valueOf(this.zzdqi.zzabw()));
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbci zzbciVar = (zzbci) list;
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzabt2 = this.zzdqi.zzabt();
                zzbw(iZzabt2);
                int iZzacb2 = this.zzdqi.zzacb() + iZzabt2;
                do {
                    zzbciVar.zzw(this.zzdqi.zzabw());
                } while (this.zzdqi.zzacb() < iZzacb2);
                return;
            default:
                throw zzbbu.zzadq();
        }
        do {
            zzbciVar.zzw(this.zzdqi.zzabw());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final int zzaci() {
        if (this.zzdqk != 0) {
            this.tag = this.zzdqk;
            this.zzdqk = 0;
        } else {
            this.tag = this.zzdqi.zzabk();
        }
        if (this.tag == 0 || this.tag == this.zzdqj) {
            return Integer.MAX_VALUE;
        }
        return this.tag >>> 3;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final boolean zzacj() {
        if (this.zzdqi.zzaca() || this.tag == this.zzdqj) {
            return false;
        }
        return this.zzdqi.zzbq(this.tag);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzad(List<Integer> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbp)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zzdqi.zzabx()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Integer.valueOf(this.zzdqi.zzabx()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbbp zzbbpVar = (zzbbp) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbbpVar.zzco(this.zzdqi.zzabx());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbbpVar.zzco(this.zzdqi.zzabx());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzae(List<Long> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbci)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Long.valueOf(this.zzdqi.zzaby()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Long.valueOf(this.zzdqi.zzaby()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbci zzbciVar = (zzbci) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbciVar.zzw(this.zzdqi.zzaby());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbciVar.zzw(this.zzdqi.zzaby());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final <T> T zzb(zzbdm<T> zzbdmVar, zzbbb zzbbbVar) throws zzbbv {
        zzbv(3);
        return (T) zzd(zzbdmVar, zzbbbVar);
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.ads.zzbdl
    public final <T> void zzb(List<T> list, zzbdm<T> zzbdmVar, zzbbb zzbbbVar) throws zzbbv {
        int iZzabk;
        if ((this.tag & 7) != 3) {
            throw zzbbu.zzadq();
        }
        int i = this.tag;
        do {
            list.add(zzd(zzbdmVar, zzbbbVar));
            if (this.zzdqi.zzaca() || this.zzdqk != 0) {
                return;
            } else {
                iZzabk = this.zzdqi.zzabk();
            }
        } while (iZzabk == i);
        this.zzdqk = iZzabk;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzp(List<Double> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbay)) {
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzabt = this.zzdqi.zzabt();
                    zzbw(iZzabt);
                    int iZzacb = this.zzdqi.zzacb() + iZzabt;
                    do {
                        list.add(Double.valueOf(this.zzdqi.readDouble()));
                    } while (this.zzdqi.zzacb() < iZzacb);
                    return;
                default:
                    throw zzbbu.zzadq();
            }
            do {
                list.add(Double.valueOf(this.zzdqi.readDouble()));
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbay zzbayVar = (zzbay) list;
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzabt2 = this.zzdqi.zzabt();
                zzbw(iZzabt2);
                int iZzacb2 = this.zzdqi.zzacb() + iZzabt2;
                do {
                    zzbayVar.zzd(this.zzdqi.readDouble());
                } while (this.zzdqi.zzacb() < iZzacb2);
                return;
            default:
                throw zzbbu.zzadq();
        }
        do {
            zzbayVar.zzd(this.zzdqi.readDouble());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzq(List<Float> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbm)) {
            int i = this.tag & 7;
            if (i == 2) {
                int iZzabt = this.zzdqi.zzabt();
                zzbx(iZzabt);
                int iZzacb = this.zzdqi.zzacb() + iZzabt;
                do {
                    list.add(Float.valueOf(this.zzdqi.readFloat()));
                } while (this.zzdqi.zzacb() < iZzacb);
                return;
            }
            if (i != 5) {
                throw zzbbu.zzadq();
            }
            do {
                list.add(Float.valueOf(this.zzdqi.readFloat()));
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbbm zzbbmVar = (zzbbm) list;
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzabt2 = this.zzdqi.zzabt();
            zzbx(iZzabt2);
            int iZzacb2 = this.zzdqi.zzacb() + iZzabt2;
            do {
                zzbbmVar.zzd(this.zzdqi.readFloat());
            } while (this.zzdqi.zzacb() < iZzacb2);
            return;
        }
        if (i2 != 5) {
            throw zzbbu.zzadq();
        }
        do {
            zzbbmVar.zzd(this.zzdqi.readFloat());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzr(List<Long> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbci)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Long.valueOf(this.zzdqi.zzabl()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Long.valueOf(this.zzdqi.zzabl()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbci zzbciVar = (zzbci) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbciVar.zzw(this.zzdqi.zzabl());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbciVar.zzw(this.zzdqi.zzabl());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzs(List<Long> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbci)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Long.valueOf(this.zzdqi.zzabm()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Long.valueOf(this.zzdqi.zzabm()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbci zzbciVar = (zzbci) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbciVar.zzw(this.zzdqi.zzabm());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbciVar.zzw(this.zzdqi.zzabm());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzt(List<Integer> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbp)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zzdqi.zzabn()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Integer.valueOf(this.zzdqi.zzabn()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbbp zzbbpVar = (zzbbp) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbbpVar.zzco(this.zzdqi.zzabn());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbbpVar.zzco(this.zzdqi.zzabn());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzu(List<Long> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbci)) {
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzabt = this.zzdqi.zzabt();
                    zzbw(iZzabt);
                    int iZzacb = this.zzdqi.zzacb() + iZzabt;
                    do {
                        list.add(Long.valueOf(this.zzdqi.zzabo()));
                    } while (this.zzdqi.zzacb() < iZzacb);
                    return;
                default:
                    throw zzbbu.zzadq();
            }
            do {
                list.add(Long.valueOf(this.zzdqi.zzabo()));
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbci zzbciVar = (zzbci) list;
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzabt2 = this.zzdqi.zzabt();
                zzbw(iZzabt2);
                int iZzacb2 = this.zzdqi.zzacb() + iZzabt2;
                do {
                    zzbciVar.zzw(this.zzdqi.zzabo());
                } while (this.zzdqi.zzacb() < iZzacb2);
                return;
            default:
                throw zzbbu.zzadq();
        }
        do {
            zzbciVar.zzw(this.zzdqi.zzabo());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzv(List<Integer> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbp)) {
            int i = this.tag & 7;
            if (i == 2) {
                int iZzabt = this.zzdqi.zzabt();
                zzbx(iZzabt);
                int iZzacb = this.zzdqi.zzacb() + iZzabt;
                do {
                    list.add(Integer.valueOf(this.zzdqi.zzabp()));
                } while (this.zzdqi.zzacb() < iZzacb);
                return;
            }
            if (i != 5) {
                throw zzbbu.zzadq();
            }
            do {
                list.add(Integer.valueOf(this.zzdqi.zzabp()));
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk = this.zzdqi.zzabk();
                }
            } while (iZzabk == this.tag);
            this.zzdqk = iZzabk;
            return;
        }
        zzbbp zzbbpVar = (zzbbp) list;
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzabt2 = this.zzdqi.zzabt();
            zzbx(iZzabt2);
            int iZzacb2 = this.zzdqi.zzacb() + iZzabt2;
            do {
                zzbbpVar.zzco(this.zzdqi.zzabp());
            } while (this.zzdqi.zzacb() < iZzacb2);
            return;
        }
        if (i2 != 5) {
            throw zzbbu.zzadq();
        }
        do {
            zzbbpVar.zzco(this.zzdqi.zzabp());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk2 = this.zzdqi.zzabk();
            }
        } while (iZzabk2 == this.tag);
        this.zzdqk = iZzabk2;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzw(List<Boolean> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbaf)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Boolean.valueOf(this.zzdqi.zzabq()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Boolean.valueOf(this.zzdqi.zzabq()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbaf zzbafVar = (zzbaf) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbafVar.addBoolean(this.zzdqi.zzabq());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbafVar.addBoolean(this.zzdqi.zzabq());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzx(List<String> list) throws zzbbv {
        zza(list, true);
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzy(List<zzbah> list) throws zzbbv {
        int iZzabk;
        if ((this.tag & 7) != 2) {
            throw zzbbu.zzadq();
        }
        do {
            list.add(zzabs());
            if (this.zzdqi.zzaca()) {
                return;
            } else {
                iZzabk = this.zzdqi.zzabk();
            }
        } while (iZzabk == this.tag);
        this.zzdqk = iZzabk;
    }

    @Override // com.google.android.gms.internal.ads.zzbdl
    public final void zzz(List<Integer> list) throws zzbbu {
        int iZzabk;
        int iZzabk2;
        if (!(list instanceof zzbbp)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zzdqi.zzabt()));
                    if (this.zzdqi.zzaca()) {
                        return;
                    } else {
                        iZzabk = this.zzdqi.zzabk();
                    }
                } while (iZzabk == this.tag);
                this.zzdqk = iZzabk;
                return;
            }
            if (i != 2) {
                throw zzbbu.zzadq();
            }
            int iZzacb = this.zzdqi.zzacb() + this.zzdqi.zzabt();
            do {
                list.add(Integer.valueOf(this.zzdqi.zzabt()));
            } while (this.zzdqi.zzacb() < iZzacb);
            zzby(iZzacb);
            return;
        }
        zzbbp zzbbpVar = (zzbbp) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbbpVar.zzco(this.zzdqi.zzabt());
                if (this.zzdqi.zzaca()) {
                    return;
                } else {
                    iZzabk2 = this.zzdqi.zzabk();
                }
            } while (iZzabk2 == this.tag);
            this.zzdqk = iZzabk2;
            return;
        }
        if (i2 != 2) {
            throw zzbbu.zzadq();
        }
        int iZzacb2 = this.zzdqi.zzacb() + this.zzdqi.zzabt();
        do {
            zzbbpVar.zzco(this.zzdqi.zzabt());
        } while (this.zzdqi.zzacb() < iZzacb2);
        zzby(iZzacb2);
    }
}
