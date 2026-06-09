package com.google.android.gms.flags;

import android.os.RemoteException;

/* JADX INFO: loaded from: classes.dex */
public abstract class Flag<T> {
    private final T mDefaultValue;
    private final String mKey;
    private final int zzacb;

    public static class BooleanFlag extends Flag<Boolean> {
        public BooleanFlag(int i, String str, Boolean bool) {
            super(i, str, bool);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.Flag
        public Boolean get(IFlagProvider iFlagProvider) {
            try {
                return Boolean.valueOf(iFlagProvider.getBooleanFlagValue(getKey(), getDefault().booleanValue(), getSource()));
            } catch (RemoteException unused) {
                return getDefault();
            }
        }
    }

    public static class IntegerFlag extends Flag<Integer> {
        public IntegerFlag(int i, String str, Integer num) {
            super(i, str, num);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.Flag
        public Integer get(IFlagProvider iFlagProvider) {
            try {
                return Integer.valueOf(iFlagProvider.getIntFlagValue(getKey(), getDefault().intValue(), getSource()));
            } catch (RemoteException unused) {
                return getDefault();
            }
        }
    }

    public static class LongFlag extends Flag<Long> {
        public LongFlag(int i, String str, Long l) {
            super(i, str, l);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.Flag
        public Long get(IFlagProvider iFlagProvider) {
            try {
                return Long.valueOf(iFlagProvider.getLongFlagValue(getKey(), getDefault().longValue(), getSource()));
            } catch (RemoteException unused) {
                return getDefault();
            }
        }
    }

    public static class StringFlag extends Flag<String> {
        public StringFlag(int i, String str, String str2) {
            super(i, str, str2);
        }

        @Override // com.google.android.gms.flags.Flag
        public String get(IFlagProvider iFlagProvider) {
            try {
                return iFlagProvider.getStringFlagValue(getKey(), getDefault(), getSource());
            } catch (RemoteException unused) {
                return getDefault();
            }
        }
    }

    private Flag(int i, String str, T t) {
        this.zzacb = i;
        this.mKey = str;
        this.mDefaultValue = t;
        Singletons.flagRegistry().registerFlag(this);
    }

    public static BooleanFlag define(int i, String str, Boolean bool) {
        return new BooleanFlag(i, str, bool);
    }

    public static IntegerFlag define(int i, String str, int i2) {
        return new IntegerFlag(i, str, Integer.valueOf(i2));
    }

    public static LongFlag define(int i, String str, long j) {
        return new LongFlag(i, str, Long.valueOf(j));
    }

    public static StringFlag define(int i, String str, String str2) {
        return new StringFlag(i, str, str2);
    }

    public static StringFlag defineClientExperimentId(int i, String str) {
        StringFlag stringFlagDefine = define(i, str, (String) null);
        Singletons.flagRegistry().registerClientExperimentId(stringFlagDefine);
        return stringFlagDefine;
    }

    public static StringFlag defineServiceExperimentId(int i, String str) {
        StringFlag stringFlagDefine = define(i, str, (String) null);
        Singletons.flagRegistry().registerServiceExperimentId(stringFlagDefine);
        return stringFlagDefine;
    }

    public T get() {
        return (T) Singletons.flagValueProvider().getFlagValue(this);
    }

    protected abstract T get(IFlagProvider iFlagProvider);

    public T getDefault() {
        return this.mDefaultValue;
    }

    public String getKey() {
        return this.mKey;
    }

    public int getSource() {
        return this.zzacb;
    }
}
