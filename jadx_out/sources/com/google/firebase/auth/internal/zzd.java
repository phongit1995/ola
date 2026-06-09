package com.google.firebase.auth.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.firebase.analytics.FirebaseAnalytics;
import com.google.firebase.auth.AdditionalUserInfo;
import java.util.Map;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "DefaultAdditionalUserInfoCreator")
public final class zzd implements AdditionalUserInfo {
    public static final Parcelable.Creator<zzd> CREATOR = new zze();

    @SafeParcelable.Field(getter = "isNewUser", id = 3)
    private boolean zzak;

    @SafeParcelable.Field(getter = "getRawUserInfo", id = 2)
    private final String zzdf;

    @SafeParcelable.Field(getter = "getProviderId", id = 1)
    private final String zzj;
    private Map<String, Object> zzkr;

    @SafeParcelable.Constructor
    public zzd(@SafeParcelable.Param(id = 1) String str, @SafeParcelable.Param(id = 2) String str2, @SafeParcelable.Param(id = 3) boolean z) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        this.zzj = str;
        this.zzdf = str2;
        this.zzkr = zzz.zzai(str2);
        this.zzak = z;
    }

    public zzd(boolean z) {
        this.zzak = z;
        this.zzdf = null;
        this.zzj = null;
        this.zzkr = null;
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    @Override // com.google.firebase.auth.AdditionalUserInfo
    @Nullable
    public final Map<String, Object> getProfile() {
        return this.zzkr;
    }

    @Override // com.google.firebase.auth.AdditionalUserInfo
    @Nullable
    public final String getProviderId() {
        return this.zzj;
    }

    @Override // com.google.firebase.auth.AdditionalUserInfo
    @Nullable
    public final String getUsername() {
        Map<String, Object> map;
        String str;
        if ("github.com".equals(this.zzj)) {
            map = this.zzkr;
            str = FirebaseAnalytics.Event.LOGIN;
        } else {
            if (!"twitter.com".equals(this.zzj)) {
                return null;
            }
            map = this.zzkr;
            str = "screen_name";
        }
        return (String) map.get(str);
    }

    @Override // com.google.firebase.auth.AdditionalUserInfo
    public final boolean isNewUser() {
        return this.zzak;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getProviderId(), false);
        SafeParcelWriter.writeString(parcel, 2, this.zzdf, false);
        SafeParcelWriter.writeBoolean(parcel, 3, isNewUser());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
