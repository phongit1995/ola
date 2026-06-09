package com.google.android.gms.flags;

import android.content.Context;
import com.google.android.gms.flags.Flag;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class FlagRegistry {
    private final Collection<Flag> zzacc = new ArrayList();
    private final Collection<Flag.StringFlag> zzacd = new ArrayList();
    private final Collection<Flag.StringFlag> zzace = new ArrayList();

    public static void initialize(Context context) {
        Singletons.flagValueProvider().initialize(context);
    }

    public List<String> getExperimentIdsFromClient() {
        ArrayList arrayList = new ArrayList();
        Iterator<Flag.StringFlag> it2 = this.zzacd.iterator();
        while (it2.hasNext()) {
            String str = it2.next().get();
            if (str != null) {
                arrayList.add(str);
            }
        }
        return arrayList;
    }

    public void registerClientExperimentId(Flag.StringFlag stringFlag) {
        this.zzacd.add(stringFlag);
    }

    public void registerFlag(Flag flag) {
        this.zzacc.add(flag);
    }

    public void registerServiceExperimentId(Flag.StringFlag stringFlag) {
        this.zzace.add(stringFlag);
    }

    public Collection<Flag> registeredFlags() {
        return Collections.unmodifiableCollection(this.zzacc);
    }

    public Collection<Flag.StringFlag> registeredServiceExperimentIdFlags() {
        return Collections.unmodifiableCollection(this.zzace);
    }
}
