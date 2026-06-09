package com.google.android.gms.flags.impl;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.util.Log;
import com.google.android.gms.common.util.DynamiteApi;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.flags.IFlagProvider;
import com.google.android.gms.flags.impl.DataUtils;

/* JADX INFO: loaded from: classes.dex */
@DynamiteApi
public class FlagProviderImpl extends IFlagProvider.Stub {
    private boolean zzacf = false;
    private SharedPreferences zzacu;

    @Override // com.google.android.gms.flags.IFlagProvider
    public boolean getBooleanFlagValue(String str, boolean z, int i) {
        return !this.zzacf ? z : DataUtils.BooleanUtils.getFromSharedPreferencesNoStrict(this.zzacu, str, Boolean.valueOf(z)).booleanValue();
    }

    @Override // com.google.android.gms.flags.IFlagProvider
    public int getIntFlagValue(String str, int i, int i2) {
        return !this.zzacf ? i : DataUtils.IntegerUtils.getFromSharedPreferencesNoStrict(this.zzacu, str, Integer.valueOf(i)).intValue();
    }

    @Override // com.google.android.gms.flags.IFlagProvider
    public long getLongFlagValue(String str, long j, int i) {
        return !this.zzacf ? j : DataUtils.LongUtils.getFromSharedPreferencesNoStrict(this.zzacu, str, Long.valueOf(j)).longValue();
    }

    @Override // com.google.android.gms.flags.IFlagProvider
    public String getStringFlagValue(String str, String str2, int i) {
        return !this.zzacf ? str2 : DataUtils.StringUtils.getFromSharedPreferencesNoStrict(this.zzacu, str, str2);
    }

    @Override // com.google.android.gms.flags.IFlagProvider
    public void init(IObjectWrapper iObjectWrapper) {
        Context context = (Context) ObjectWrapper.unwrap(iObjectWrapper);
        if (this.zzacf) {
            return;
        }
        try {
            this.zzacu = SharedPreferencesFactory.getSharedPreferences(context.createPackageContext("com.google.android.gms", 0));
            this.zzacf = true;
        } catch (PackageManager.NameNotFoundException unused) {
        } catch (Exception e) {
            String strValueOf = String.valueOf(e.getMessage());
            Log.w("FlagProviderImpl", strValueOf.length() != 0 ? "Could not retrieve sdk flags, continuing with defaults: ".concat(strValueOf) : new String("Could not retrieve sdk flags, continuing with defaults: "));
        }
    }
}
