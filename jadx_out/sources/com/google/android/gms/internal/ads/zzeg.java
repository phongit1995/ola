package com.google.android.gms.internal.ads;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class zzeg {
    private static final String TAG = "zzeg";
    private final String className;
    private final zzcz zzps;
    private final String zztx;
    private final Class<?>[] zzua;
    private final int zzty = 2;
    private volatile Method zztz = null;
    private CountDownLatch zzub = new CountDownLatch(1);

    public zzeg(zzcz zzczVar, String str, String str2, Class<?>... clsArr) {
        this.zzps = zzczVar;
        this.className = str;
        this.zztx = str2;
        this.zzua = clsArr;
        this.zzps.zzab().submit(new zzeh(this));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzav() {
        try {
            try {
                Class clsLoadClass = this.zzps.zzac().loadClass(zzb(this.zzps.zzae(), this.className));
                if (clsLoadClass != null) {
                    this.zztz = clsLoadClass.getMethod(zzb(this.zzps.zzae(), this.zztx), this.zzua);
                    Method method = this.zztz;
                }
            } finally {
                this.zzub.countDown();
            }
        } catch (zzcl | UnsupportedEncodingException | ClassNotFoundException | NoSuchMethodException | NullPointerException unused) {
        }
    }

    private final String zzb(byte[] bArr, String str) {
        return new String(this.zzps.zzad().zza(bArr, str), "UTF-8");
    }

    public final Method zzaw() {
        if (this.zztz != null) {
            return this.zztz;
        }
        try {
            if (this.zzub.await(2L, TimeUnit.SECONDS)) {
                return this.zztz;
            }
            return null;
        } catch (InterruptedException unused) {
            return null;
        }
    }
}
