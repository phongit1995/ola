package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzdb;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfm extends zzdb<zzfm, zza> implements zzej {
    private static final zzfm zzuz = new zzfm();
    private static volatile zzer<zzfm> zzva;
    private long zzux;
    private int zzuy;

    public static final class zza extends zzdb.zza<zzfm, zza> implements zzej {
        private zza() {
            super(zzfm.zzuz);
        }

        /* synthetic */ zza(zzfn zzfnVar) {
            this();
        }
    }

    static {
        zzdb.zza((Class<zzfm>) zzfm.class, zzuz);
    }

    private zzfm() {
    }

    public static zzer<zzfm> zzfw() {
        return (zzer) zzuz.zza(zzdb.zze.zzrk, (Object) null, (Object) null);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzdb
    protected final Object zza(int i, Object obj, Object obj2) {
        zzer zzbVar;
        zzfn zzfnVar = null;
        switch (zzfn.zzvb[i - 1]) {
            case 1:
                return new zzfm();
            case 2:
                return new zza(zzfnVar);
            case 3:
                return new zzet(zzuz, "\u0000\u0002\u0000\u0000\u0001\u0002\u0002\u0000\u0000\u0000\u0001\u0002\u0002\u0004", new Object[]{"zzux", "zzuy"});
            case 4:
                return zzuz;
            case 5:
                zzer<zzfm> zzerVar = zzva;
                if (zzerVar != null) {
                    return zzerVar;
                }
                synchronized (zzfm.class) {
                    zzbVar = zzva;
                    if (zzbVar == null) {
                        zzbVar = new zzdb.zzb(zzuz);
                        zzva = zzbVar;
                    }
                    break;
                }
                return zzbVar;
            case 6:
                return (byte) 1;
            case 7:
                return null;
            default:
                throw new UnsupportedOperationException();
        }
    }
}
