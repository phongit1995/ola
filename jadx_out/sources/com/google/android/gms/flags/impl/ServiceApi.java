package com.google.android.gms.flags.impl;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Binder;
import android.util.Log;
import com.google.android.gms.common.util.SharedPreferencesUtils;
import com.google.android.gms.flags.Flag;
import com.google.android.gms.flags.Singletons;
import com.google.android.gms.flags.impl.DataUtils;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ServiceApi {
    public static void persistGserviceValues(Context context) {
        try {
            SharedPreferences.Editor editorEdit = SharedPreferencesFactory.getSharedPreferences(context).edit();
            for (Flag flag : Singletons.flagRegistry().registeredFlags()) {
                if (flag.getSource() == 0) {
                    DataUtils dataUtilsForFlag = DataUtils.forFlag(flag);
                    dataUtilsForFlag.putInSharedPreferences(editorEdit, dataUtilsForFlag.getGservicesValue().get());
                }
            }
            SharedPreferencesUtils.publishWorldReadableSharedPreferences(context, editorEdit, "google_sdk_flags");
        } catch (Exception e) {
            String strValueOf = String.valueOf(e.getMessage());
            Log.e("FlagsServiceApi", strValueOf.length() != 0 ? "Failed to write shared flags: ".concat(strValueOf) : new String("Failed to write shared flags: "));
        }
    }

    public List<String> getExperimentIdsFromService() {
        ArrayList arrayList = new ArrayList();
        long jClearCallingIdentity = Binder.clearCallingIdentity();
        try {
            Iterator<Flag.StringFlag> it2 = Singletons.flagRegistry().registeredServiceExperimentIdFlags().iterator();
            while (it2.hasNext()) {
                String str = new DataUtils.StringUtils(it2.next()).getGservicesValue().get();
                if (str != null) {
                    arrayList.add(str);
                }
            }
            return arrayList;
        } finally {
            Binder.restoreCallingIdentity(jClearCallingIdentity);
        }
    }
}
