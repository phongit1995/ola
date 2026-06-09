package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "GetAccountInfoUserListCreator")
@SafeParcelable.Reserved({1})
public final class zzal extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzal> CREATOR = new zzam();

    @SafeParcelable.Field(getter = "getUsers", id = 2)
    private List<zzaj> zzjv;

    public zzal() {
        this.zzjv = new ArrayList();
    }

    @SafeParcelable.Constructor
    zzal(@SafeParcelable.Param(id = 2) List<zzaj> list) {
        this.zzjv = list == null ? Collections.emptyList() : Collections.unmodifiableList(list);
    }

    public static zzal zza(zzal zzalVar) {
        List<zzaj> list = zzalVar.zzjv;
        zzal zzalVar2 = new zzal();
        if (list != null && !list.isEmpty()) {
            zzalVar2.zzjv.addAll(list);
        }
        return zzalVar2;
    }

    public static zzal zza(zzg.zzc zzcVar) {
        ArrayList arrayList = new ArrayList(zzcVar.zzan.length);
        for (int i = 0; i < zzcVar.zzan.length; i++) {
            zzu zzuVar = zzcVar.zzan[i];
            arrayList.add(new zzaj(Strings.emptyToNull(zzuVar.zzad), Strings.emptyToNull(zzuVar.zzah), zzuVar.zzbk, Strings.emptyToNull(zzuVar.zzbh), Strings.emptyToNull(zzuVar.zzbr), zzas.zza(zzuVar.zzbx), Strings.emptyToNull(zzuVar.zzdr), Strings.emptyToNull(zzuVar.zzbd), zzuVar.zzbw, zzuVar.zzbv, false, null));
        }
        return new zzal(arrayList);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 2, this.zzjv, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final List<zzaj> zzas() {
        return this.zzjv;
    }
}
