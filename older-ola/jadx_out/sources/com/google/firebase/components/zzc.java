package com.google.firebase.components;

import android.content.ComponentName;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.pm.ServiceInfo;
import android.os.Bundle;
import android.support.annotation.VisibleForTesting;
import android.util.Log;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public final class zzc {
    private final Context zza;
    private final zzb zzb;

    static class zza implements zzb {
        private zza() {
        }

        /* synthetic */ zza(byte b) {
            this();
        }

        private static Bundle zzb(Context context) {
            try {
                PackageManager packageManager = context.getPackageManager();
                if (packageManager == null) {
                    Log.w("ComponentDiscovery", "Context has no PackageManager.");
                    return null;
                }
                ServiceInfo serviceInfo = packageManager.getServiceInfo(new ComponentName(context, (Class<?>) ComponentDiscoveryService.class), 128);
                if (serviceInfo != null) {
                    return serviceInfo.metaData;
                }
                Log.w("ComponentDiscovery", "ComponentDiscoveryService has no service info.");
                return null;
            } catch (PackageManager.NameNotFoundException unused) {
                Log.w("ComponentDiscovery", "Application info not found.");
                return null;
            }
        }

        @Override // com.google.firebase.components.zzc.zzb
        public final List<String> zza(Context context) {
            Bundle bundleZzb = zzb(context);
            if (bundleZzb == null) {
                Log.w("ComponentDiscovery", "Could not retrieve metadata, returning empty list of registrars.");
                return Collections.emptyList();
            }
            ArrayList arrayList = new ArrayList();
            for (String str : bundleZzb.keySet()) {
                if ("com.google.firebase.components.ComponentRegistrar".equals(bundleZzb.get(str)) && str.startsWith("com.google.firebase.components:")) {
                    arrayList.add(str.substring(31));
                }
            }
            return arrayList;
        }
    }

    @VisibleForTesting
    interface zzb {
        List<String> zza(Context context);
    }

    public zzc(Context context) {
        this(context, new zza((byte) 0));
    }

    @VisibleForTesting
    private zzc(Context context, zzb zzbVar) {
        this.zza = context;
        this.zzb = zzbVar;
    }

    private static List<ComponentRegistrar> zza(List<String> list) {
        String str;
        String str2;
        Object[] objArr;
        ArrayList arrayList = new ArrayList();
        for (String str3 : list) {
            try {
                Class<?> cls = Class.forName(str3);
                if (ComponentRegistrar.class.isAssignableFrom(cls)) {
                    arrayList.add((ComponentRegistrar) cls.newInstance());
                } else {
                    Log.w("ComponentDiscovery", String.format("Class %s is not an instance of %s", str3, "com.google.firebase.components.ComponentRegistrar"));
                }
            } catch (ClassNotFoundException e) {
                e = e;
                str = "ComponentDiscovery";
                str2 = "Class %s is not an found.";
                objArr = new Object[]{str3};
                Log.w(str, String.format(str2, objArr), e);
            } catch (IllegalAccessException e2) {
                e = e2;
                str = "ComponentDiscovery";
                str2 = "Could not instantiate %s.";
                objArr = new Object[]{str3};
                Log.w(str, String.format(str2, objArr), e);
            } catch (InstantiationException e3) {
                e = e3;
                str = "ComponentDiscovery";
                str2 = "Could not instantiate %s.";
                objArr = new Object[]{str3};
                Log.w(str, String.format(str2, objArr), e);
            }
        }
        return arrayList;
    }

    public final List<ComponentRegistrar> zza() {
        return zza(this.zzb.zza(this.zza));
    }
}
