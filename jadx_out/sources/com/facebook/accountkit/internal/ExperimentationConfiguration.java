package com.facebook.accountkit.internal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.SharedPreferences;
import android.support.annotation.Nullable;
import java.util.Calendar;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public final class ExperimentationConfiguration {
    private final SharedPreferences mSharedPrefs;
    private static final String TAG = "ExperimentationConfiguration";
    private static final String PREFERENCE_PREFIX = TAG;
    private static final String AK_PREFERENCES = PREFERENCE_PREFIX + ".AK_PREFERENCES";
    private static final String PREF_CREATE_TIME = PREFERENCE_PREFIX + ".PREF_CREATE_TIME";
    private static final String PREF_TTL = PREFERENCE_PREFIX + ".PREF_TTL";
    private static final String PREF_UNIT_ID = PREFERENCE_PREFIX + ".PREF_UNIT_ID";
    private static final long DEFAULT_TTL = TimeUnit.DAYS.toMillis(3);

    ExperimentationConfiguration(Context context) {
        this.mSharedPrefs = getSharedPreferences(context);
    }

    private static SharedPreferences getSharedPreferences(Context context) {
        return context.getApplicationContext().getSharedPreferences(AK_PREFERENCES, 0);
    }

    static void load(Context context, String str, Long l, @Nullable Long l2, Map<Integer, Integer> map) {
        if (str == null || l == null) {
            return;
        }
        saveConfiguration(context, str, l.longValue(), l2, map);
    }

    @SuppressLint({"CommitPrefEdits"})
    private static void saveConfiguration(Context context, String str, long j, @Nullable Long l, Map<Integer, Integer> map) {
        SharedPreferences.Editor editorEdit = getSharedPreferences(context).edit();
        editorEdit.clear();
        editorEdit.putLong(PREF_CREATE_TIME, j);
        if (l != null) {
            editorEdit.putLong(PREF_TTL, l.longValue());
        }
        editorEdit.putString(PREF_UNIT_ID, str);
        for (Integer num : map.keySet()) {
            editorEdit.putInt(PREFERENCE_PREFIX + num, map.get(num).intValue());
        }
        editorEdit.commit();
    }

    public boolean exists() {
        return this.mSharedPrefs.getLong(PREF_CREATE_TIME, -1L) > 0;
    }

    public boolean getBooleanValue(Feature feature) {
        return getIntValue(feature) > 0;
    }

    public int getIntValue(Feature feature) {
        return this.mSharedPrefs.getInt(PREFERENCE_PREFIX + feature.getPrefKey(), feature.getDefaultValue());
    }

    @Nullable
    String getUnitID() {
        return this.mSharedPrefs.getString(PREF_UNIT_ID, null);
    }

    boolean isStale() {
        long time = Calendar.getInstance().getTime().getTime();
        return Math.abs(time - this.mSharedPrefs.getLong(PREF_CREATE_TIME, time)) > this.mSharedPrefs.getLong(PREF_TTL, DEFAULT_TTL);
    }
}
