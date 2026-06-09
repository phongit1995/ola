package com.google.android.gms.flags.impl;

import android.content.SharedPreferences;
import android.util.Log;
import com.google.android.gms.common.config.GservicesValue;
import com.google.android.gms.flags.Flag;
import com.google.android.gms.flags.impl.util.StrictModeUtil;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public abstract class DataUtils<T> {

    public static class BooleanUtils extends DataUtils<Boolean> {
        private final Flag.BooleanFlag zzack;

        BooleanUtils(Flag.BooleanFlag booleanFlag) {
            this.zzack = booleanFlag;
        }

        public static Boolean getFromSharedPreferencesNoStrict(SharedPreferences sharedPreferences, String str, Boolean bool) {
            try {
                return (Boolean) StrictModeUtil.runWithLaxStrictMode(new zza(sharedPreferences, str, bool));
            } catch (Exception e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.w("FlagDataUtils", strValueOf.length() != 0 ? "Flag value not available, returning default: ".concat(strValueOf) : new String("Flag value not available, returning default: "));
                return bool;
            }
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.impl.DataUtils
        public Boolean getFromJSONObject(JSONObject jSONObject) {
            return Boolean.valueOf(jSONObject.optBoolean(this.zzack.getKey(), this.zzack.getDefault().booleanValue()));
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.impl.DataUtils
        public Boolean getFromSharedPreferences(SharedPreferences sharedPreferences) {
            return Boolean.valueOf(sharedPreferences.getBoolean(this.zzack.getKey(), this.zzack.getDefault().booleanValue()));
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public GservicesValue<Boolean> getGservicesValue() {
            return GservicesValue.value(this.zzack.getKey(), this.zzack.getDefault().booleanValue());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putInSharedPreferences(SharedPreferences.Editor editor, Boolean bool) {
            editor.putBoolean(this.zzack.getKey(), bool.booleanValue());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putStringOverrideInSharedPreferences(SharedPreferences.Editor editor, String str) {
            editor.putBoolean(this.zzack.getKey(), Boolean.parseBoolean(str));
        }
    }

    public static class IntegerUtils extends DataUtils<Integer> {
        private final Flag.IntegerFlag zzaco;

        IntegerUtils(Flag.IntegerFlag integerFlag) {
            this.zzaco = integerFlag;
        }

        public static Integer getFromSharedPreferencesNoStrict(SharedPreferences sharedPreferences, String str, Integer num) {
            try {
                return (Integer) StrictModeUtil.runWithLaxStrictMode(new zzb(sharedPreferences, str, num));
            } catch (Exception e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.w("FlagDataUtils", strValueOf.length() != 0 ? "Flag value not available, returning default: ".concat(strValueOf) : new String("Flag value not available, returning default: "));
                return num;
            }
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.impl.DataUtils
        public Integer getFromJSONObject(JSONObject jSONObject) {
            return Integer.valueOf(jSONObject.optInt(this.zzaco.getKey(), this.zzaco.getDefault().intValue()));
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.impl.DataUtils
        public Integer getFromSharedPreferences(SharedPreferences sharedPreferences) {
            return Integer.valueOf(sharedPreferences.getInt(this.zzaco.getKey(), this.zzaco.getDefault().intValue()));
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public GservicesValue<Integer> getGservicesValue() {
            return GservicesValue.value(this.zzaco.getKey(), this.zzaco.getDefault());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putInSharedPreferences(SharedPreferences.Editor editor, Integer num) {
            editor.putInt(this.zzaco.getKey(), num.intValue());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putStringOverrideInSharedPreferences(SharedPreferences.Editor editor, String str) {
            editor.putInt(this.zzaco.getKey(), Integer.parseInt(str));
        }
    }

    public static class LongUtils extends DataUtils<Long> {
        private final Flag.LongFlag zzacq;

        LongUtils(Flag.LongFlag longFlag) {
            this.zzacq = longFlag;
        }

        public static Long getFromSharedPreferencesNoStrict(SharedPreferences sharedPreferences, String str, Long l) {
            try {
                return (Long) StrictModeUtil.runWithLaxStrictMode(new zzc(sharedPreferences, str, l));
            } catch (Exception e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.w("FlagDataUtils", strValueOf.length() != 0 ? "Flag value not available, returning default: ".concat(strValueOf) : new String("Flag value not available, returning default: "));
                return l;
            }
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.impl.DataUtils
        public Long getFromJSONObject(JSONObject jSONObject) {
            return Long.valueOf(jSONObject.optLong(this.zzacq.getKey(), this.zzacq.getDefault().longValue()));
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // com.google.android.gms.flags.impl.DataUtils
        public Long getFromSharedPreferences(SharedPreferences sharedPreferences) {
            return Long.valueOf(sharedPreferences.getLong(this.zzacq.getKey(), this.zzacq.getDefault().longValue()));
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public GservicesValue<Long> getGservicesValue() {
            return GservicesValue.value(this.zzacq.getKey(), this.zzacq.getDefault());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putInSharedPreferences(SharedPreferences.Editor editor, Long l) {
            editor.putLong(this.zzacq.getKey(), l.longValue());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putStringOverrideInSharedPreferences(SharedPreferences.Editor editor, String str) {
            editor.putLong(this.zzacq.getKey(), Long.parseLong(str));
        }
    }

    public static class StringUtils extends DataUtils<String> {
        private final Flag.StringFlag zzacs;

        StringUtils(Flag.StringFlag stringFlag) {
            this.zzacs = stringFlag;
        }

        public static String getFromSharedPreferencesNoStrict(SharedPreferences sharedPreferences, String str, String str2) {
            try {
                return (String) StrictModeUtil.runWithLaxStrictMode(new zzd(sharedPreferences, str, str2));
            } catch (Exception e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.w("FlagDataUtils", strValueOf.length() != 0 ? "Flag value not available, returning default: ".concat(strValueOf) : new String("Flag value not available, returning default: "));
                return str2;
            }
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public String getFromJSONObject(JSONObject jSONObject) {
            return jSONObject.optString(this.zzacs.getKey(), this.zzacs.getDefault());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public String getFromSharedPreferences(SharedPreferences sharedPreferences) {
            return sharedPreferences.getString(this.zzacs.getKey(), this.zzacs.getDefault());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public GservicesValue<String> getGservicesValue() {
            return GservicesValue.value(this.zzacs.getKey(), this.zzacs.getDefault());
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putInSharedPreferences(SharedPreferences.Editor editor, String str) {
            editor.putString(this.zzacs.getKey(), str);
        }

        @Override // com.google.android.gms.flags.impl.DataUtils
        public void putStringOverrideInSharedPreferences(SharedPreferences.Editor editor, String str) {
            editor.putString(this.zzacs.getKey(), String.valueOf(str));
        }
    }

    public static DataUtils forFlag(Flag flag) {
        if (flag instanceof Flag.BooleanFlag) {
            return new BooleanUtils((Flag.BooleanFlag) flag);
        }
        if (flag instanceof Flag.IntegerFlag) {
            return new IntegerUtils((Flag.IntegerFlag) flag);
        }
        if (flag instanceof Flag.LongFlag) {
            return new LongUtils((Flag.LongFlag) flag);
        }
        if (flag instanceof Flag.StringFlag) {
            return new StringUtils((Flag.StringFlag) flag);
        }
        String strValueOf = String.valueOf(flag.getClass().getName());
        throw new IllegalArgumentException(strValueOf.length() != 0 ? "Unexpected flag type: ".concat(strValueOf) : new String("Unexpected flag type: "));
    }

    public abstract T getFromJSONObject(JSONObject jSONObject);

    public abstract T getFromSharedPreferences(SharedPreferences sharedPreferences);

    public abstract GservicesValue<T> getGservicesValue();

    public abstract void putInSharedPreferences(SharedPreferences.Editor editor, T t);

    public abstract void putStringOverrideInSharedPreferences(SharedPreferences.Editor editor, String str);
}
