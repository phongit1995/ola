package com.google.android.gms.internal.firebase_auth;

import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
final class zzcg implements zzeu {
    private int tag;
    private final zzcd zznb;
    private int zznc;
    private int zznd = 0;

    private zzcg(zzcd zzcdVar) {
        this.zznb = (zzcd) zzdd.zza(zzcdVar, "input");
        this.zznb.zzmt = this;
    }

    public static zzcg zza(zzcd zzcdVar) {
        return zzcdVar.zzmt != null ? zzcdVar.zzmt : new zzcg(zzcdVar);
    }

    private final Object zza(zzgd zzgdVar, Class<?> cls, zzco zzcoVar) throws zzdi {
        switch (zzch.zzne[zzgdVar.ordinal()]) {
            case 1:
                return Boolean.valueOf(zzci());
            case 2:
                return zzck();
            case 3:
                return Double.valueOf(readDouble());
            case 4:
                return Integer.valueOf(zzcm());
            case 5:
                return Integer.valueOf(zzch());
            case 6:
                return Long.valueOf(zzcg());
            case 7:
                return Float.valueOf(readFloat());
            case 8:
                return Integer.valueOf(zzcf());
            case 9:
                return Long.valueOf(zzce());
            case 10:
                zzs(2);
                return zzc(zzes.zzfg().zzf(cls), zzcoVar);
            case 11:
                return Integer.valueOf(zzcn());
            case 12:
                return Long.valueOf(zzco());
            case 13:
                return Integer.valueOf(zzcp());
            case 14:
                return Long.valueOf(zzcq());
            case 15:
                return zzcj();
            case 16:
                return Integer.valueOf(zzcl());
            case 17:
                return Long.valueOf(zzcd());
            default:
                throw new RuntimeException("unsupported field type.");
        }
    }

    private final void zza(List<String> list, boolean z) throws zzdi {
        int iZzcc;
        int iZzcc2;
        if ((this.tag & 7) != 2) {
            throw zzdh.zzei();
        }
        if (!(list instanceof zzdq) || z) {
            do {
                list.add(z ? zzcj() : readString());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzdq zzdqVar = (zzdq) list;
        do {
            zzdqVar.zzc(zzck());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    private final <T> T zzc(zzev<T> zzevVar, zzco zzcoVar) throws zzdh {
        int iZzcl = this.zznb.zzcl();
        if (this.zznb.zzmq >= this.zznb.zzmr) {
            throw zzdh.zzej();
        }
        int iZzp = this.zznb.zzp(iZzcl);
        T tNewInstance = zzevVar.newInstance();
        this.zznb.zzmq++;
        zzevVar.zza(tNewInstance, this, zzcoVar);
        zzevVar.zze(tNewInstance);
        this.zznb.zzm(0);
        zzcd zzcdVar = this.zznb;
        zzcdVar.zzmq--;
        this.zznb.zzq(iZzp);
        return tNewInstance;
    }

    private final <T> T zzd(zzev<T> zzevVar, zzco zzcoVar) {
        int i = this.zznc;
        this.zznc = ((this.tag >>> 3) << 3) | 4;
        try {
            T tNewInstance = zzevVar.newInstance();
            zzevVar.zza(tNewInstance, this, zzcoVar);
            zzevVar.zze(tNewInstance);
            if (this.tag != this.zznc) {
                throw zzdh.zzek();
            }
            return tNewInstance;
        } finally {
            this.zznc = i;
        }
    }

    private final void zzs(int i) throws zzdi {
        if ((this.tag & 7) != i) {
            throw zzdh.zzei();
        }
    }

    private static void zzt(int i) throws zzdh {
        if ((i & 7) != 0) {
            throw zzdh.zzek();
        }
    }

    private static void zzu(int i) throws zzdh {
        if ((i & 3) != 0) {
            throw zzdh.zzek();
        }
    }

    private final void zzv(int i) throws zzdh {
        if (this.zznb.zzct() != i) {
            throw zzdh.zzee();
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int getTag() {
        return this.tag;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final double readDouble() throws zzdi {
        zzs(1);
        return this.zznb.readDouble();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final float readFloat() throws zzdi {
        zzs(5);
        return this.zznb.readFloat();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final String readString() throws zzdi {
        zzs(2);
        return this.zznb.readString();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void readStringList(List<String> list) throws zzdi {
        zza(list, false);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final <T> T zza(zzev<T> zzevVar, zzco zzcoVar) throws zzdi {
        zzs(2);
        return (T) zzc(zzevVar, zzcoVar);
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final <T> void zza(List<T> list, zzev<T> zzevVar, zzco zzcoVar) throws zzdi {
        int iZzcc;
        if ((this.tag & 7) != 2) {
            throw zzdh.zzei();
        }
        int i = this.tag;
        do {
            list.add(zzc(zzevVar, zzcoVar));
            if (this.zznb.zzcs() || this.zznd != 0) {
                return;
            } else {
                iZzcc = this.zznb.zzcc();
            }
        } while (iZzcc == i);
        this.zznd = iZzcc;
    }

    /* JADX WARN: Code restructure failed: missing block: B:18:0x005c, code lost:
    
        r6.put(r1, r2);
     */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x0064, code lost:
    
        return;
     */
    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final <K, V> void zza(java.util.Map<K, V> r6, com.google.android.gms.internal.firebase_auth.zzea<K, V> r7, com.google.android.gms.internal.firebase_auth.zzco r8) throws com.google.android.gms.internal.firebase_auth.zzdi {
        /*
            r5 = this;
            r0 = 2
            r5.zzs(r0)
            com.google.android.gms.internal.firebase_auth.zzcd r0 = r5.zznb
            int r0 = r0.zzcl()
            com.google.android.gms.internal.firebase_auth.zzcd r1 = r5.zznb
            int r0 = r1.zzp(r0)
            K r1 = r7.zztc
            V r2 = r7.zzte
        L14:
            int r3 = r5.zzda()     // Catch: java.lang.Throwable -> L65
            r4 = 2147483647(0x7fffffff, float:NaN)
            if (r3 == r4) goto L5c
            com.google.android.gms.internal.firebase_auth.zzcd r4 = r5.zznb     // Catch: java.lang.Throwable -> L65
            boolean r4 = r4.zzcs()     // Catch: java.lang.Throwable -> L65
            if (r4 != 0) goto L5c
            switch(r3) {
                case 1: goto L3b;
                case 2: goto L2d;
                default: goto L28;
            }
        L28:
            boolean r3 = r5.zzdb()     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            goto L44
        L2d:
            com.google.android.gms.internal.firebase_auth.zzgd r3 = r7.zztd     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            V r4 = r7.zzte     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            java.lang.Class r4 = r4.getClass()     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            java.lang.Object r3 = r5.zza(r3, r4, r8)     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            r2 = r3
            goto L14
        L3b:
            com.google.android.gms.internal.firebase_auth.zzgd r3 = r7.zztb     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            r4 = 0
            java.lang.Object r3 = r5.zza(r3, r4, r4)     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            r1 = r3
            goto L14
        L44:
            if (r3 != 0) goto L14
            com.google.android.gms.internal.firebase_auth.zzdh r3 = new com.google.android.gms.internal.firebase_auth.zzdh     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            java.lang.String r4 = "Unable to parse map entry."
            r3.<init>(r4)     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
            throw r3     // Catch: com.google.android.gms.internal.firebase_auth.zzdi -> L4e java.lang.Throwable -> L65
        L4e:
            boolean r3 = r5.zzdb()     // Catch: java.lang.Throwable -> L65
            if (r3 != 0) goto L14
            com.google.android.gms.internal.firebase_auth.zzdh r6 = new com.google.android.gms.internal.firebase_auth.zzdh     // Catch: java.lang.Throwable -> L65
            java.lang.String r7 = "Unable to parse map entry."
            r6.<init>(r7)     // Catch: java.lang.Throwable -> L65
            throw r6     // Catch: java.lang.Throwable -> L65
        L5c:
            r6.put(r1, r2)     // Catch: java.lang.Throwable -> L65
            com.google.android.gms.internal.firebase_auth.zzcd r6 = r5.zznb
            r6.zzq(r0)
            return
        L65:
            r6 = move-exception
            com.google.android.gms.internal.firebase_auth.zzcd r7 = r5.zznb
            r7.zzq(r0)
            throw r6
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.firebase_auth.zzcg.zza(java.util.Map, com.google.android.gms.internal.firebase_auth.zzea, com.google.android.gms.internal.firebase_auth.zzco):void");
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final <T> T zzb(zzev<T> zzevVar, zzco zzcoVar) throws zzdi {
        zzs(3);
        return (T) zzd(zzevVar, zzcoVar);
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final <T> void zzb(List<T> list, zzev<T> zzevVar, zzco zzcoVar) throws zzdi {
        int iZzcc;
        if ((this.tag & 7) != 3) {
            throw zzdh.zzei();
        }
        int i = this.tag;
        do {
            list.add(zzd(zzevVar, zzcoVar));
            if (this.zznb.zzcs() || this.zznd != 0) {
                return;
            } else {
                iZzcc = this.zznb.zzcc();
            }
        } while (iZzcc == i);
        this.zznd = iZzcc;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzc(List<Double> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzcl)) {
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzcl = this.zznb.zzcl();
                    zzt(iZzcl);
                    int iZzct = this.zznb.zzct() + iZzcl;
                    do {
                        list.add(Double.valueOf(this.zznb.readDouble()));
                    } while (this.zznb.zzct() < iZzct);
                    return;
                default:
                    throw zzdh.zzei();
            }
            do {
                list.add(Double.valueOf(this.zznb.readDouble()));
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzcl zzclVar = (zzcl) list;
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzcl2 = this.zznb.zzcl();
                zzt(iZzcl2);
                int iZzct2 = this.zznb.zzct() + iZzcl2;
                do {
                    zzclVar.zzc(this.zznb.readDouble());
                } while (this.zznb.zzct() < iZzct2);
                return;
            default:
                throw zzdh.zzei();
        }
        do {
            zzclVar.zzc(this.zznb.readDouble());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final long zzcd() throws zzdi {
        zzs(0);
        return this.zznb.zzcd();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final long zzce() throws zzdi {
        zzs(0);
        return this.zznb.zzce();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzcf() throws zzdi {
        zzs(0);
        return this.zznb.zzcf();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final long zzcg() throws zzdi {
        zzs(1);
        return this.zznb.zzcg();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzch() throws zzdi {
        zzs(5);
        return this.zznb.zzch();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final boolean zzci() throws zzdi {
        zzs(0);
        return this.zznb.zzci();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final String zzcj() throws zzdi {
        zzs(2);
        return this.zznb.zzcj();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final zzbu zzck() throws zzdi {
        zzs(2);
        return this.zznb.zzck();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzcl() throws zzdi {
        zzs(0);
        return this.zznb.zzcl();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzcm() throws zzdi {
        zzs(0);
        return this.zznb.zzcm();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzcn() throws zzdi {
        zzs(5);
        return this.zznb.zzcn();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final long zzco() throws zzdi {
        zzs(1);
        return this.zznb.zzco();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzcp() throws zzdi {
        zzs(0);
        return this.zznb.zzcp();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final long zzcq() throws zzdi {
        zzs(0);
        return this.zznb.zzcq();
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzd(List<Float> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzcy)) {
            int i = this.tag & 7;
            if (i == 2) {
                int iZzcl = this.zznb.zzcl();
                zzu(iZzcl);
                int iZzct = this.zznb.zzct() + iZzcl;
                do {
                    list.add(Float.valueOf(this.zznb.readFloat()));
                } while (this.zznb.zzct() < iZzct);
                return;
            }
            if (i != 5) {
                throw zzdh.zzei();
            }
            do {
                list.add(Float.valueOf(this.zznb.readFloat()));
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzcy zzcyVar = (zzcy) list;
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzcl2 = this.zznb.zzcl();
            zzu(iZzcl2);
            int iZzct2 = this.zznb.zzct() + iZzcl2;
            do {
                zzcyVar.zzc(this.zznb.readFloat());
            } while (this.zznb.zzct() < iZzct2);
            return;
        }
        if (i2 != 5) {
            throw zzdh.zzei();
        }
        do {
            zzcyVar.zzc(this.zznb.readFloat());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final int zzda() {
        if (this.zznd != 0) {
            this.tag = this.zznd;
            this.zznd = 0;
        } else {
            this.tag = this.zznb.zzcc();
        }
        if (this.tag == 0 || this.tag == this.zznc) {
            return Integer.MAX_VALUE;
        }
        return this.tag >>> 3;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final boolean zzdb() {
        if (this.zznb.zzcs() || this.tag == this.zznc) {
            return false;
        }
        return this.zznb.zzn(this.tag);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zze(List<Long> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdv)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Long.valueOf(this.zznb.zzcd()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Long.valueOf(this.zznb.zzcd()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdv zzdvVar = (zzdv) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdvVar.zzl(this.zznb.zzcd());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdvVar.zzl(this.zznb.zzcd());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzf(List<Long> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdv)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Long.valueOf(this.zznb.zzce()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Long.valueOf(this.zznb.zzce()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdv zzdvVar = (zzdv) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdvVar.zzl(this.zznb.zzce());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdvVar.zzl(this.zznb.zzce());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzg(List<Integer> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdc)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zznb.zzcf()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Integer.valueOf(this.zznb.zzcf()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdc zzdcVar = (zzdc) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdcVar.zzal(this.zznb.zzcf());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdcVar.zzal(this.zznb.zzcf());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzh(List<Long> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdv)) {
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzcl = this.zznb.zzcl();
                    zzt(iZzcl);
                    int iZzct = this.zznb.zzct() + iZzcl;
                    do {
                        list.add(Long.valueOf(this.zznb.zzcg()));
                    } while (this.zznb.zzct() < iZzct);
                    return;
                default:
                    throw zzdh.zzei();
            }
            do {
                list.add(Long.valueOf(this.zznb.zzcg()));
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzdv zzdvVar = (zzdv) list;
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzcl2 = this.zznb.zzcl();
                zzt(iZzcl2);
                int iZzct2 = this.zznb.zzct() + iZzcl2;
                do {
                    zzdvVar.zzl(this.zznb.zzcg());
                } while (this.zznb.zzct() < iZzct2);
                return;
            default:
                throw zzdh.zzei();
        }
        do {
            zzdvVar.zzl(this.zznb.zzcg());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzi(List<Integer> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdc)) {
            int i = this.tag & 7;
            if (i == 2) {
                int iZzcl = this.zznb.zzcl();
                zzu(iZzcl);
                int iZzct = this.zznb.zzct() + iZzcl;
                do {
                    list.add(Integer.valueOf(this.zznb.zzch()));
                } while (this.zznb.zzct() < iZzct);
                return;
            }
            if (i != 5) {
                throw zzdh.zzei();
            }
            do {
                list.add(Integer.valueOf(this.zznb.zzch()));
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzdc zzdcVar = (zzdc) list;
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzcl2 = this.zznb.zzcl();
            zzu(iZzcl2);
            int iZzct2 = this.zznb.zzct() + iZzcl2;
            do {
                zzdcVar.zzal(this.zznb.zzch());
            } while (this.zznb.zzct() < iZzct2);
            return;
        }
        if (i2 != 5) {
            throw zzdh.zzei();
        }
        do {
            zzdcVar.zzal(this.zznb.zzch());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzj(List<Boolean> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzbs)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Boolean.valueOf(this.zznb.zzci()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Boolean.valueOf(this.zznb.zzci()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzbs zzbsVar = (zzbs) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzbsVar.addBoolean(this.zznb.zzci());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzbsVar.addBoolean(this.zznb.zzci());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzk(List<String> list) throws zzdi {
        zza(list, true);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzl(List<zzbu> list) throws zzdi {
        int iZzcc;
        if ((this.tag & 7) != 2) {
            throw zzdh.zzei();
        }
        do {
            list.add(zzck());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc = this.zznb.zzcc();
            }
        } while (iZzcc == this.tag);
        this.zznd = iZzcc;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzm(List<Integer> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdc)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zznb.zzcl()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Integer.valueOf(this.zznb.zzcl()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdc zzdcVar = (zzdc) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdcVar.zzal(this.zznb.zzcl());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdcVar.zzal(this.zznb.zzcl());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzn(List<Integer> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdc)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zznb.zzcm()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Integer.valueOf(this.zznb.zzcm()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdc zzdcVar = (zzdc) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdcVar.zzal(this.zznb.zzcm());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdcVar.zzal(this.zznb.zzcm());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzo(List<Integer> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdc)) {
            int i = this.tag & 7;
            if (i == 2) {
                int iZzcl = this.zznb.zzcl();
                zzu(iZzcl);
                int iZzct = this.zznb.zzct() + iZzcl;
                do {
                    list.add(Integer.valueOf(this.zznb.zzcn()));
                } while (this.zznb.zzct() < iZzct);
                return;
            }
            if (i != 5) {
                throw zzdh.zzei();
            }
            do {
                list.add(Integer.valueOf(this.zznb.zzcn()));
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzdc zzdcVar = (zzdc) list;
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzcl2 = this.zznb.zzcl();
            zzu(iZzcl2);
            int iZzct2 = this.zznb.zzct() + iZzcl2;
            do {
                zzdcVar.zzal(this.zznb.zzcn());
            } while (this.zznb.zzct() < iZzct2);
            return;
        }
        if (i2 != 5) {
            throw zzdh.zzei();
        }
        do {
            zzdcVar.zzal(this.zznb.zzcn());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzp(List<Long> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdv)) {
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzcl = this.zznb.zzcl();
                    zzt(iZzcl);
                    int iZzct = this.zznb.zzct() + iZzcl;
                    do {
                        list.add(Long.valueOf(this.zznb.zzco()));
                    } while (this.zznb.zzct() < iZzct);
                    return;
                default:
                    throw zzdh.zzei();
            }
            do {
                list.add(Long.valueOf(this.zznb.zzco()));
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc = this.zznb.zzcc();
                }
            } while (iZzcc == this.tag);
            this.zznd = iZzcc;
            return;
        }
        zzdv zzdvVar = (zzdv) list;
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzcl2 = this.zznb.zzcl();
                zzt(iZzcl2);
                int iZzct2 = this.zznb.zzct() + iZzcl2;
                do {
                    zzdvVar.zzl(this.zznb.zzco());
                } while (this.zznb.zzct() < iZzct2);
                return;
            default:
                throw zzdh.zzei();
        }
        do {
            zzdvVar.zzl(this.zznb.zzco());
            if (this.zznb.zzcs()) {
                return;
            } else {
                iZzcc2 = this.zznb.zzcc();
            }
        } while (iZzcc2 == this.tag);
        this.zznd = iZzcc2;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzq(List<Integer> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdc)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Integer.valueOf(this.zznb.zzcp()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Integer.valueOf(this.zznb.zzcp()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdc zzdcVar = (zzdc) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdcVar.zzal(this.zznb.zzcp());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdcVar.zzal(this.zznb.zzcp());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeu
    public final void zzr(List<Long> list) throws zzdh {
        int iZzcc;
        int iZzcc2;
        if (!(list instanceof zzdv)) {
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    list.add(Long.valueOf(this.zznb.zzcq()));
                    if (this.zznb.zzcs()) {
                        return;
                    } else {
                        iZzcc = this.zznb.zzcc();
                    }
                } while (iZzcc == this.tag);
                this.zznd = iZzcc;
                return;
            }
            if (i != 2) {
                throw zzdh.zzei();
            }
            int iZzct = this.zznb.zzct() + this.zznb.zzcl();
            do {
                list.add(Long.valueOf(this.zznb.zzcq()));
            } while (this.zznb.zzct() < iZzct);
            zzv(iZzct);
            return;
        }
        zzdv zzdvVar = (zzdv) list;
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                zzdvVar.zzl(this.zznb.zzcq());
                if (this.zznb.zzcs()) {
                    return;
                } else {
                    iZzcc2 = this.zznb.zzcc();
                }
            } while (iZzcc2 == this.tag);
            this.zznd = iZzcc2;
            return;
        }
        if (i2 != 2) {
            throw zzdh.zzei();
        }
        int iZzct2 = this.zznb.zzct() + this.zznb.zzcl();
        do {
            zzdvVar.zzl(this.zznb.zzcq());
        } while (this.zznb.zzct() < iZzct2);
        zzv(iZzct2);
    }
}
