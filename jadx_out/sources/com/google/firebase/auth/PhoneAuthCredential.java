package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "PhoneAuthCredentialCreator")
public class PhoneAuthCredential extends AuthCredential implements Cloneable {
    public static final Parcelable.Creator<PhoneAuthCredential> CREATOR = new zzv();

    @SafeParcelable.Field(getter = "getPhoneNumber", id = 4)
    private String zzbd;

    @SafeParcelable.Field(getter = "getAutoCreate", id = 5)
    private boolean zzcf;

    @SafeParcelable.Field(getter = "getSessionInfo", id = 1)
    private String zzey;

    @SafeParcelable.Field(getter = "getSmsCode", id = 2)
    private String zzez;

    @SafeParcelable.Field(getter = "getHasVerificationProof", id = 3)
    private boolean zzfa;

    @SafeParcelable.Field(getter = "getTemporaryProof", id = 6)
    private String zzfb;

    @SafeParcelable.Constructor
    PhoneAuthCredential(@SafeParcelable.Param(id = 1) @Nullable String str, @SafeParcelable.Param(id = 2) @Nullable String str2, @SafeParcelable.Param(id = 3) boolean z, @SafeParcelable.Param(id = 4) @Nullable String str3, @SafeParcelable.Param(id = 5) boolean z2, @SafeParcelable.Param(id = 6) @Nullable String str4) {
        Preconditions.checkArgument((z && !TextUtils.isEmpty(str3)) || !((TextUtils.isEmpty(str) || TextUtils.isEmpty(str2)) && (TextUtils.isEmpty(str3) || TextUtils.isEmpty(str4))), "Cannot create PhoneAuthCredential without either verificationProof, sessionInfo, ortemprary proof.");
        this.zzey = str;
        this.zzez = str2;
        this.zzfa = z;
        this.zzbd = str3;
        this.zzcf = z2;
        this.zzfb = str4;
    }

    public /* synthetic */ Object clone() {
        return new PhoneAuthCredential(this.zzey, getSmsCode(), this.zzfa, this.zzbd, this.zzcf, this.zzfb);
    }

    @Override // com.google.firebase.auth.AuthCredential
    @NonNull
    public String getProvider() {
        return "phone";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return "phone";
    }

    @Nullable
    public String getSmsCode() {
        return this.zzez;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzey, false);
        SafeParcelWriter.writeString(parcel, 2, getSmsCode(), false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzfa);
        SafeParcelWriter.writeString(parcel, 4, this.zzbd, false);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zzcf);
        SafeParcelWriter.writeString(parcel, 6, this.zzfb, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final PhoneAuthCredential zza(boolean z) {
        this.zzcf = false;
        return this;
    }
}
