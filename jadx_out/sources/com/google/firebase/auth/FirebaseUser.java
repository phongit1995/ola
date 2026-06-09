package com.google.firebase.auth;

import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.internal.firebase_auth.zzao;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public abstract class FirebaseUser extends AbstractSafeParcelable implements UserInfo {
    @NonNull
    public Task<Void> delete() {
        return FirebaseAuth.getInstance(zzo()).zze(this);
    }

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public abstract String getDisplayName();

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public abstract String getEmail();

    @NonNull
    public Task<GetTokenResult> getIdToken(boolean z) {
        return FirebaseAuth.getInstance(zzo()).zza(this, z);
    }

    @Nullable
    public abstract FirebaseUserMetadata getMetadata();

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public abstract String getPhoneNumber();

    @Override // com.google.firebase.auth.UserInfo
    @Nullable
    public abstract Uri getPhotoUrl();

    @NonNull
    public abstract List<? extends UserInfo> getProviderData();

    @Override // com.google.firebase.auth.UserInfo
    @NonNull
    public abstract String getProviderId();

    @Nullable
    public abstract List<String> getProviders();

    @Override // com.google.firebase.auth.UserInfo
    @NonNull
    public abstract String getUid();

    public abstract boolean isAnonymous();

    @NonNull
    public Task<AuthResult> linkWithCredential(@NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(authCredential);
        return FirebaseAuth.getInstance(zzo()).zzc(this, authCredential);
    }

    public Task<Void> reauthenticate(@NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(authCredential);
        return FirebaseAuth.getInstance(zzo()).zza(this, authCredential);
    }

    public Task<AuthResult> reauthenticateAndRetrieveData(@NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(authCredential);
        return FirebaseAuth.getInstance(zzo()).zzb(this, authCredential);
    }

    @NonNull
    public Task<Void> reload() {
        return FirebaseAuth.getInstance(zzo()).zzd(this);
    }

    @NonNull
    public Task<Void> sendEmailVerification() {
        return FirebaseAuth.getInstance(zzo()).zza(this, false).continueWithTask(new zzq(this));
    }

    @NonNull
    public Task<Void> sendEmailVerification(ActionCodeSettings actionCodeSettings) {
        return FirebaseAuth.getInstance(zzo()).zza(this, false).continueWithTask(new zzr(this, actionCodeSettings));
    }

    public Task<AuthResult> unlink(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return FirebaseAuth.getInstance(zzo()).zza(this, str);
    }

    @NonNull
    public Task<Void> updateEmail(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return FirebaseAuth.getInstance(zzo()).zzb(this, str);
    }

    @NonNull
    public Task<Void> updatePassword(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return FirebaseAuth.getInstance(zzo()).zzc(this, str);
    }

    public Task<Void> updatePhoneNumber(@NonNull PhoneAuthCredential phoneAuthCredential) {
        return FirebaseAuth.getInstance(zzo()).zza(this, phoneAuthCredential);
    }

    @NonNull
    public Task<Void> updateProfile(@NonNull UserProfileChangeRequest userProfileChangeRequest) {
        Preconditions.checkNotNull(userProfileChangeRequest);
        return FirebaseAuth.getInstance(zzo()).zza(this, userProfileChangeRequest);
    }

    @NonNull
    public abstract FirebaseUser zza(@NonNull List<? extends UserInfo> list);

    public abstract void zza(@NonNull zzao zzaoVar);

    public abstract FirebaseUser zzn();

    @NonNull
    public abstract FirebaseApp zzo();

    @NonNull
    public abstract zzao zzp();

    @NonNull
    public abstract String zzq();

    @NonNull
    public abstract String zzr();
}
