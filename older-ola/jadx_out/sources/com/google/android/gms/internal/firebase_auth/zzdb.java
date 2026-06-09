package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzdb;
import com.google.android.gms.internal.firebase_auth.zzdb.zza;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/* JADX INFO: loaded from: classes2.dex */
public abstract class zzdb<MessageType extends zzdb<MessageType, BuilderType>, BuilderType extends zza<MessageType, BuilderType>> extends zzbn<MessageType, BuilderType> {
    private static Map<Object, zzdb<?, ?>> zzqz = new ConcurrentHashMap();
    protected zzfq zzqx = zzfq.zzfz();
    private int zzqy = -1;

    public static abstract class zza<MessageType extends zzdb<MessageType, BuilderType>, BuilderType extends zza<MessageType, BuilderType>> extends zzbo<MessageType, BuilderType> {
        private final MessageType zzra;
        private MessageType zzrb;
        private boolean zzrc = false;

        protected zza(MessageType messagetype) {
            this.zzra = messagetype;
            this.zzrb = (MessageType) messagetype.zza(zze.zzrh, null, null);
        }

        private static void zza(MessageType messagetype, MessageType messagetype2) {
            zzes.zzfg().zzq(messagetype).zzc(messagetype, messagetype2);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzbo
        public /* synthetic */ Object clone() {
            zza zzaVar = (zza) this.zzra.zza(zze.zzri, null, null);
            if (!this.zzrc) {
                MessageType messagetype = this.zzrb;
                zzes.zzfg().zzq(messagetype).zze(messagetype);
                this.zzrc = true;
            }
            zzaVar.zza((zzdb) this.zzrb);
            return zzaVar;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzej
        public final boolean isInitialized() {
            return zzdb.zza(this.zzrb, false);
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzbo
        public final BuilderType zza(MessageType messagetype) {
            if (this.zzrc) {
                MessageType messagetype2 = (MessageType) this.zzrb.zza(zze.zzrh, null, null);
                zza(messagetype2, this.zzrb);
                this.zzrb = messagetype2;
                this.zzrc = false;
            }
            zza(this.zzrb, messagetype);
            return this;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzbo
        /* JADX INFO: renamed from: zzbq */
        public final /* synthetic */ zzbo clone() {
            return (zza) clone();
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzej
        public final /* synthetic */ zzeh zzeb() {
            return this.zzra;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzei
        public final /* synthetic */ zzeh zzec() {
            if (this.zzrc) {
                return this.zzrb;
            }
            MessageType messagetype = this.zzrb;
            zzes.zzfg().zzq(messagetype).zze(messagetype);
            this.zzrc = true;
            return this.zzrb;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzei
        public final /* synthetic */ zzeh zzed() {
            boolean zZzp = true;
            if (!this.zzrc) {
                MessageType messagetype = this.zzrb;
                zzes.zzfg().zzq(messagetype).zze(messagetype);
                this.zzrc = true;
            }
            MessageType messagetype2 = this.zzrb;
            boolean zBooleanValue = Boolean.TRUE.booleanValue();
            byte bByteValue = ((Byte) messagetype2.zza(zze.zzre, null, null)).byteValue();
            if (bByteValue != 1) {
                if (bByteValue == 0) {
                    zZzp = false;
                } else {
                    zZzp = zzes.zzfg().zzq(messagetype2).zzp(messagetype2);
                    if (zBooleanValue) {
                        messagetype2.zza(zze.zzrf, zZzp ? messagetype2 : null, null);
                    }
                }
            }
            if (zZzp) {
                return messagetype2;
            }
            throw new zzfo(messagetype2);
        }
    }

    public static class zzb<T extends zzdb<T, ?>> extends zzbp<T> {
        private T zzra;

        public zzb(T t) {
            this.zzra = t;
        }

        @Override // com.google.android.gms.internal.firebase_auth.zzer
        public final /* synthetic */ Object zza(zzcd zzcdVar, zzco zzcoVar) {
            return zzdb.zza(this.zzra, zzcdVar, zzcoVar);
        }
    }

    public static abstract class zzc<MessageType extends zzc<MessageType, BuilderType>, BuilderType> extends zzdb<MessageType, BuilderType> implements zzej {
        protected zzcs<Object> zzrd = zzcs.zzdp();
    }

    public static class zzd<ContainingType extends zzeh, Type> extends zzcm<ContainingType, Type> {
    }

    public enum zze {
        public static final int zzre = 1;
        public static final int zzrf = 2;
        public static final int zzrg = 3;
        public static final int zzrh = 4;
        public static final int zzri = 5;
        public static final int zzrj = 6;
        public static final int zzrk = 7;
        private static final /* synthetic */ int[] zzrl = {zzre, zzrf, zzrg, zzrh, zzri, zzrj, zzrk};
        public static final int zzrm = 1;
        public static final int zzrn = 2;
        private static final /* synthetic */ int[] zzro = {zzrm, zzrn};
        public static final int zzrp = 1;
        public static final int zzrq = 2;
        private static final /* synthetic */ int[] zzrr = {zzrp, zzrq};

        public static int[] values$50KLMJ33DTMIUPRFDTJMOP9FE1P6UT3FC9QMCBQ7CLN6ASJ1EHIM8JB5EDPM2PR59HKN8P949LIN8Q3FCHA6UIBEEPNMMP9R0() {
            return (int[]) zzrl.clone();
        }
    }

    static <T extends zzdb<T, ?>> T zza(T t, zzcd zzcdVar, zzco zzcoVar) throws zzdh {
        T t2 = (T) t.zza(zze.zzrh, null, null);
        try {
            zzes.zzfg().zzq(t2).zza(t2, zzcg.zza(zzcdVar), zzcoVar);
            zzes.zzfg().zzq(t2).zze(t2);
            return t2;
        } catch (IOException e) {
            if (e.getCause() instanceof zzdh) {
                throw ((zzdh) e.getCause());
            }
            throw new zzdh(e.getMessage()).zzg(t2);
        } catch (RuntimeException e2) {
            if (e2.getCause() instanceof zzdh) {
                throw ((zzdh) e2.getCause());
            }
            throw e2;
        }
    }

    static Object zza(Method method, Object obj, Object... objArr) {
        try {
            return method.invoke(obj, objArr);
        } catch (IllegalAccessException e) {
            throw new RuntimeException("Couldn't use Java reflection to implement protocol message reflection.", e);
        } catch (InvocationTargetException e2) {
            Throwable cause = e2.getCause();
            if (cause instanceof RuntimeException) {
                throw ((RuntimeException) cause);
            }
            if (cause instanceof Error) {
                throw ((Error) cause);
            }
            throw new RuntimeException("Unexpected exception thrown by generated accessor method.", cause);
        }
    }

    protected static <T extends zzdb<?, ?>> void zza(Class<T> cls, T t) {
        zzqz.put(cls, t);
    }

    protected static final <T extends zzdb<T, ?>> boolean zza(T t, boolean z) {
        byte bByteValue = ((Byte) t.zza(zze.zzre, null, null)).byteValue();
        if (bByteValue == 1) {
            return true;
        }
        if (bByteValue == 0) {
            return false;
        }
        return zzes.zzfg().zzq(t).zzp(t);
    }

    static <T extends zzdb<?, ?>> T zzd(Class<T> cls) {
        T t = (T) zzqz.get(cls);
        if (t == null) {
            try {
                Class.forName(cls.getName(), true, cls.getClassLoader());
                t = (T) zzqz.get(cls);
            } catch (ClassNotFoundException e) {
                throw new IllegalStateException("Class initialization cannot fail.", e);
            }
        }
        if (t != null) {
            return t;
        }
        String strValueOf = String.valueOf(cls.getName());
        throw new IllegalStateException(strValueOf.length() != 0 ? "Unable to get default instance for: ".concat(strValueOf) : new String("Unable to get default instance for: "));
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (((zzdb) zza(zze.zzrj, (Object) null, (Object) null)).getClass().isInstance(obj)) {
            return zzes.zzfg().zzq(this).equals(this, (zzdb) obj);
        }
        return false;
    }

    public int hashCode() {
        if (this.zzma != 0) {
            return this.zzma;
        }
        this.zzma = zzes.zzfg().zzq(this).hashCode(this);
        return this.zzma;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzej
    public final boolean isInitialized() {
        boolean zBooleanValue = Boolean.TRUE.booleanValue();
        byte bByteValue = ((Byte) zza(zze.zzre, (Object) null, (Object) null)).byteValue();
        if (bByteValue == 1) {
            return true;
        }
        if (bByteValue == 0) {
            return false;
        }
        boolean zZzp = zzes.zzfg().zzq(this).zzp(this);
        if (zBooleanValue) {
            zza(zze.zzrf, zZzp ? this : null, (Object) null);
        }
        return zZzp;
    }

    public String toString() {
        return zzek.zza(this, super.toString());
    }

    protected abstract Object zza(int i, Object obj, Object obj2);

    @Override // com.google.android.gms.internal.firebase_auth.zzeh
    public final void zzb(zzci zzciVar) {
        zzes.zzfg().zzf(getClass()).zza(this, zzck.zza(zzciVar));
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbn
    final int zzbp() {
        return this.zzqy;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeh
    public final int zzdq() {
        if (this.zzqy == -1) {
            this.zzqy = zzes.zzfg().zzq(this).zzo(this);
        }
        return this.zzqy;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeh
    public final /* synthetic */ zzei zzdz() {
        zza zzaVar = (zza) zza(zze.zzri, (Object) null, (Object) null);
        zzaVar.zza(this);
        return zzaVar;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzeh
    public final /* synthetic */ zzei zzea() {
        return (zza) zza(zze.zzri, (Object) null, (Object) null);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzej
    public final /* synthetic */ zzeh zzeb() {
        return (zzdb) zza(zze.zzrj, (Object) null, (Object) null);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzbn
    final void zzg(int i) {
        this.zzqy = i;
    }
}
