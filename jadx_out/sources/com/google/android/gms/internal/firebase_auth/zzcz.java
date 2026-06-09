package com.google.android.gms.internal.firebase_auth;

import com.google.android.gms.internal.firebase_auth.zzco;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.ServiceConfigurationError;
import java.util.ServiceLoader;
import java.util.logging.Level;
import java.util.logging.Logger;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzcz<T extends zzco> {
    private static final Logger logger = Logger.getLogger(zzci.class.getName());
    private static String zzqv = "com.google.protobuf.BlazeGeneratedExtensionRegistryLiteLoader";

    zzcz() {
    }

    static <T extends zzco> T zza(Class<T> cls) {
        String str;
        ClassLoader classLoader = zzcz.class.getClassLoader();
        if (cls.equals(zzco.class)) {
            str = zzqv;
        } else {
            if (!cls.getPackage().equals(zzcz.class.getPackage())) {
                throw new IllegalArgumentException(cls.getName());
            }
            str = String.format("%s.BlazeGenerated%sLoader", cls.getPackage().getName(), cls.getSimpleName());
        }
        try {
            try {
                try {
                    return cls.cast(((zzcz) Class.forName(str, true, classLoader).getConstructor(new Class[0]).newInstance(new Object[0])).zzdx());
                } catch (NoSuchMethodException e) {
                    throw new IllegalStateException(e);
                } catch (InvocationTargetException e2) {
                    throw new IllegalStateException(e2);
                }
            } catch (IllegalAccessException e3) {
                throw new IllegalStateException(e3);
            } catch (InstantiationException e4) {
                throw new IllegalStateException(e4);
            }
        } catch (ClassNotFoundException unused) {
            Iterator it2 = ServiceLoader.load(zzcz.class, classLoader).iterator();
            ArrayList arrayList = new ArrayList();
            while (it2.hasNext()) {
                try {
                    arrayList.add(cls.cast(((zzcz) it2.next()).zzdx()));
                } catch (ServiceConfigurationError e5) {
                    Logger logger2 = logger;
                    Level level = Level.SEVERE;
                    String strValueOf = String.valueOf(cls.getSimpleName());
                    logger2.logp(level, "com.google.protobuf.GeneratedExtensionRegistryLoader", "load", strValueOf.length() != 0 ? "Unable to load ".concat(strValueOf) : new String("Unable to load "), (Throwable) e5);
                }
            }
            if (arrayList.size() == 1) {
                return (T) arrayList.get(0);
            }
            if (arrayList.size() == 0) {
                return null;
            }
            try {
                return (T) cls.getMethod("combine", Collection.class).invoke(null, arrayList);
            } catch (IllegalAccessException e6) {
                throw new IllegalStateException(e6);
            } catch (NoSuchMethodException e7) {
                throw new IllegalStateException(e7);
            } catch (InvocationTargetException e8) {
                throw new IllegalStateException(e8);
            }
        }
    }

    protected abstract T zzdx();
}
