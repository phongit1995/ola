package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.Strings;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "ProviderUserInfoListCreator")
@SafeParcelable.Reserved({1})
public final class zzas extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzas> CREATOR = new zzat();

    @SafeParcelable.Field(getter = "getProviderUserInfos", id = 2)
    private List<zzaq> zzka;

    public zzas() {
        this.zzka = new ArrayList();
    }

    @SafeParcelable.Constructor
    zzas(@SafeParcelable.Param(id = 2) List<zzaq> list) {
        this.zzka = (list == null || list.isEmpty()) ? Collections.emptyList() : Collections.unmodifiableList(list);
    }

    public static zzas zza(zzas zzasVar) {
        List<zzaq> list = zzasVar.zzka;
        zzas zzasVar2 = new zzas();
        if (list != null) {
            zzasVar2.zzka.addAll(list);
        }
        return zzasVar2;
    }

    public static zzas zza(zzt[] zztVarArr) {
        ArrayList arrayList = new ArrayList();
        for (zzt zztVar : zztVarArr) {
            arrayList.add(new zzaq(Strings.emptyToNull(zztVar.zzcg), Strings.emptyToNull(zztVar.zzbh), Strings.emptyToNull(zztVar.zzbr), Strings.emptyToNull(zztVar.zzj), null, Strings.emptyToNull(zztVar.zzbd), Strings.emptyToNull(zztVar.zzah)));
        }
        return new zzas(arrayList);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 2, this.zzka, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final List<zzaq> zzat() {
        return this.zzka;
    }
}
