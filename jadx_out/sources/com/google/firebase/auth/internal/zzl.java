package com.google.firebase.auth.internal;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzao;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseAuthProvider;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.FirebaseUserMetadata;
import com.google.firebase.auth.GetTokenResult;
import com.google.firebase.auth.UserInfo;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "DefaultFirebaseUserCreator")
public class zzl extends FirebaseUser {
    public static final Parcelable.Creator<zzl> CREATOR = new zzm();

    @SafeParcelable.Field(getter = "isNewUser", id = 10)
    private boolean zzak;

    @SafeParcelable.Field(getter = "getDefaultOAuthCredential", id = 11)
    private com.google.firebase.auth.zzd zzju;

    @SafeParcelable.Field(getter = "getCachedTokenState", id = 1)
    private zzao zzkw;

    @SafeParcelable.Field(getter = "getDefaultAuthUserInfo", id = 2)
    private zzh zzkx;

    @SafeParcelable.Field(getter = "getFirebaseAppName", id = 3)
    private String zzky;

    @SafeParcelable.Field(getter = "getUserType", id = 4)
    private String zzkz;

    @SafeParcelable.Field(getter = "getUserInfos", id = 5)
    private List<zzh> zzla;

    @SafeParcelable.Field(getter = "getProviders", id = 6)
    private List<String> zzlb;

    @SafeParcelable.Field(getter = "getCurrentVersion", id = 7)
    private String zzlc;

    @SafeParcelable.Field(getter = "isAnonymous", id = 8)
    private Boolean zzld;

    @SafeParcelable.Field(getter = "getMetadata", id = 9)
    private zzn zzle;

    @SafeParcelable.Constructor
    zzl(@SafeParcelable.Param(id = 1) zzao zzaoVar, @SafeParcelable.Param(id = 2) zzh zzhVar, @SafeParcelable.Param(id = 3) String str, @SafeParcelable.Param(id = 4) String str2, @SafeParcelable.Param(id = 5) List<zzh> list, @SafeParcelable.Param(id = 6) List<String> list2, @SafeParcelable.Param(id = 7) String str3, @SafeParcelable.Param(id = 8) Boolean bool, @SafeParcelable.Param(id = 9) zzn zznVar, @SafeParcelable.Param(id = 10) boolean z, @SafeParcelable.Param(id = 11) com.google.firebase.auth.zzd zzdVar) {
        this.zzkw = zzaoVar;
        this.zzkx = zzhVar;
        this.zzky = str;
        this.zzkz = str2;
        this.zzla = list;
        this.zzlb = list2;
        this.zzlc = str3;
        this.zzld = bool;
        this.zzle = zznVar;
        this.zzak = z;
        this.zzju = zzdVar;
    }

    public zzl(@NonNull FirebaseApp firebaseApp, @NonNull List<? extends UserInfo> list) {
        Preconditions.checkNotNull(firebaseApp);
        this.zzky = firebaseApp.getName();
        this.zzkz = "com.google.firebase.auth.internal.DefaultFirebaseUser";
        this.zzlc = "2";
        zza(list);
    }

    public static FirebaseUser zza(FirebaseApp firebaseApp, FirebaseUser firebaseUser) {
        zzn zznVar;
        zzl zzlVar = new zzl(firebaseApp, firebaseUser.getProviderData());
        if (firebaseUser instanceof zzl) {
            zzl zzlVar2 = (zzl) firebaseUser;
            zzlVar.zzlc = zzlVar2.zzlc;
            zzlVar.zzkz = zzlVar2.zzkz;
            zznVar = (zzn) zzlVar2.getMetadata();
        } else {
            zznVar = null;
        }
        zzlVar.zzle = zznVar;
        if (firebaseUser.zzp() != null) {
            zzlVar.zza(firebaseUser.zzp());
        }
        if (!firebaseUser.isAnonymous()) {
            zzlVar.zzn();
        }
        return zzlVar;
    }

    @Override // com.google.firebase.auth.FirebaseUser, com.google.firebase.auth.UserInfo
    @Nullable
    public String getDisplayName() {
        return this.zzkx.getDisplayName();
    }

    @Override // com.google.firebase.auth.FirebaseUser, com.google.firebase.auth.UserInfo
    @Nullable
    public String getEmail() {
        return this.zzkx.getEmail();
    }

    @Override // com.google.firebase.auth.FirebaseUser
    public FirebaseUserMetadata getMetadata() {
        return this.zzle;
    }

    @Override // com.google.firebase.auth.FirebaseUser, com.google.firebase.auth.UserInfo
    @Nullable
    public String getPhoneNumber() {
        return this.zzkx.getPhoneNumber();
    }

    @Override // com.google.firebase.auth.FirebaseUser, com.google.firebase.auth.UserInfo
    @Nullable
    public Uri getPhotoUrl() {
        return this.zzkx.getPhotoUrl();
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @NonNull
    public List<? extends UserInfo> getProviderData() {
        return this.zzla;
    }

    @Override // com.google.firebase.auth.FirebaseUser, com.google.firebase.auth.UserInfo
    @NonNull
    public String getProviderId() {
        return this.zzkx.getProviderId();
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @Nullable
    public final List<String> getProviders() {
        return this.zzlb;
    }

    @Override // com.google.firebase.auth.FirebaseUser, com.google.firebase.auth.UserInfo
    @NonNull
    public String getUid() {
        return this.zzkx.getUid();
    }

    @Override // com.google.firebase.auth.FirebaseUser
    public boolean isAnonymous() {
        if (this.zzld == null || this.zzld.booleanValue()) {
            String signInProvider = "";
            if (this.zzkw != null) {
                GetTokenResult getTokenResultZzag = zzy.zzag(this.zzkw.zzaw());
                signInProvider = getTokenResultZzag != null ? getTokenResultZzag.getSignInProvider() : "";
            }
            boolean z = true;
            if (getProviderData().size() > 1 || (signInProvider != null && signInProvider.equals("custom"))) {
                z = false;
            }
            this.zzld = Boolean.valueOf(z);
        }
        return this.zzld.booleanValue();
    }

    @Override // com.google.firebase.auth.UserInfo
    public boolean isEmailVerified() {
        return this.zzkx.isEmailVerified();
    }

    public final boolean isNewUser() {
        return this.zzak;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, zzp(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzkx, i, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzky, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzkz, false);
        SafeParcelWriter.writeTypedList(parcel, 5, this.zzla, false);
        SafeParcelWriter.writeStringList(parcel, 6, getProviders(), false);
        SafeParcelWriter.writeString(parcel, 7, this.zzlc, false);
        SafeParcelWriter.writeBooleanObject(parcel, 8, Boolean.valueOf(isAnonymous()), false);
        SafeParcelWriter.writeParcelable(parcel, 9, getMetadata(), i, false);
        SafeParcelWriter.writeBoolean(parcel, 10, this.zzak);
        SafeParcelWriter.writeParcelable(parcel, 11, this.zzju, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @NonNull
    public final FirebaseUser zza(@NonNull List<? extends UserInfo> list) {
        Preconditions.checkNotNull(list);
        this.zzla = new ArrayList(list.size());
        this.zzlb = new ArrayList(list.size());
        for (int i = 0; i < list.size(); i++) {
            UserInfo userInfo = list.get(i);
            if (userInfo.getProviderId().equals(FirebaseAuthProvider.PROVIDER_ID)) {
                this.zzkx = (zzh) userInfo;
            } else {
                this.zzlb.add(userInfo.getProviderId());
            }
            this.zzla.add((zzh) userInfo);
        }
        if (this.zzkx == null) {
            this.zzkx = this.zzla.get(0);
        }
        return this;
    }

    @Override // com.google.firebase.auth.FirebaseUser
    public final void zza(@NonNull zzao zzaoVar) {
        this.zzkw = (zzao) Preconditions.checkNotNull(zzaoVar);
    }

    public final void zza(zzn zznVar) {
        this.zzle = zznVar;
    }

    public final zzl zzae(@NonNull String str) {
        this.zzlc = str;
        return this;
    }

    @Nullable
    public final com.google.firebase.auth.zzd zzav() {
        return this.zzju;
    }

    public final List<zzh> zzbg() {
        return this.zzla;
    }

    public final void zzc(com.google.firebase.auth.zzd zzdVar) {
        this.zzju = zzdVar;
    }

    public final void zze(boolean z) {
        this.zzak = z;
    }

    @Override // com.google.firebase.auth.FirebaseUser
    public final /* synthetic */ FirebaseUser zzn() {
        this.zzld = false;
        return this;
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @NonNull
    public final FirebaseApp zzo() {
        return FirebaseApp.getInstance(this.zzky);
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @NonNull
    public final zzao zzp() {
        return this.zzkw;
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @NonNull
    public final String zzq() {
        return this.zzkw.toJson();
    }

    @Override // com.google.firebase.auth.FirebaseUser
    @NonNull
    public final String zzr() {
        return zzp().zzaw();
    }
}
