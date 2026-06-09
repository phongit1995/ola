package com.google.android.gms.internal.firebase_auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.Strings;
import com.google.android.gms.internal.firebase_auth.zzg;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "CreateAuthUriResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzx extends AbstractSafeParcelable implements com.google.firebase.auth.api.internal.zzcg<zzx, zzg.zza> {
    public static final Parcelable.Creator<zzx> CREATOR = new zzy();

    @SafeParcelable.Field(getter = "getProviderId", id = 4)
    private String zzj;

    @SafeParcelable.Field(getter = "isForExistingProvider", id = 5)
    private boolean zzjf;

    @SafeParcelable.Field(getter = "getStringList", id = 6)
    private zzbd zzjg;

    @SafeParcelable.Field(getter = "getSignInMethods", id = 7)
    private List<String> zzjh;

    @SafeParcelable.Field(getter = "getAuthUri", id = 2)
    private String zzx;

    @SafeParcelable.Field(getter = "isRegistered", id = 3)
    private boolean zzz;

    public zzx() {
        this.zzjg = zzbd.zzbd();
    }

    @SafeParcelable.Constructor
    public zzx(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) boolean z, @SafeParcelable.Param(id = 4) String str2, @SafeParcelable.Param(id = 5) boolean z2, @SafeParcelable.Param(id = 6) zzbd zzbdVar, @SafeParcelable.Param(id = 7) List<String> list) {
        this.zzx = str;
        this.zzz = z;
        this.zzj = str2;
        this.zzjf = z2;
        this.zzjg = zzbdVar == null ? zzbd.zzbd() : zzbd.zza(zzbdVar);
        this.zzjh = list;
    }

    @Nullable
    public final List<String> getAllProviders() {
        return this.zzjg.zzbc();
    }

    @Nullable
    public final List<String> getSignInMethods() {
        return this.zzjh;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzx, false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzz);
        SafeParcelWriter.writeString(parcel, 4, this.zzj, false);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zzjf);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzjg, i, false);
        SafeParcelWriter.writeStringList(parcel, 7, this.zzjh, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final /* synthetic */ com.google.firebase.auth.api.internal.zzcg zza(zzgt zzgtVar) {
        zzg.zza zzaVar = (zzg.zza) zzgtVar;
        this.zzx = Strings.emptyToNull(zzaVar.zzx);
        this.zzz = zzaVar.zzz;
        this.zzj = Strings.emptyToNull(zzaVar.zzj);
        this.zzjf = zzaVar.zzaa;
        this.zzjg = zzaVar.zzy == null ? zzbd.zzbd() : new zzbd(1, Arrays.asList(zzaVar.zzy));
        this.zzjh = zzaVar.zzac == null ? new ArrayList<>(0) : Arrays.asList(zzaVar.zzac);
        return this;
    }

    @Override // com.google.firebase.auth.api.internal.zzcg
    public final Class<zzg.zza> zzag() {
        return zzg.zza.class;
    }
}
