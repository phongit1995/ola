package com.google.firebase.auth.api.internal;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.api.GoogleApi;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamite.DynamiteModule;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseError;
import com.google.firebase.FirebaseExceptionMapper;
import com.google.firebase.auth.ActionCodeResult;
import com.google.firebase.auth.ActionCodeSettings;
import com.google.firebase.auth.AuthCredential;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.EmailAuthCredential;
import com.google.firebase.auth.FirebaseAuthProvider;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GetTokenResult;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthProvider;
import com.google.firebase.auth.ProviderQueryResult;
import com.google.firebase.auth.SignInMethodQueryResult;
import com.google.firebase.auth.UserProfileChangeRequest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes2.dex */
public final class zzao extends zzah {

    @NonNull
    private final Context zzgs;

    @NonNull
    private final zzcp zzgt;

    zzao(@NonNull Context context, @NonNull zzcp zzcpVar) {
        this.zzgs = context;
        this.zzgt = zzcpVar;
    }

    private static <ResultT, CallbackT> zzbb<ResultT, CallbackT> zza(zzcy<ResultT, CallbackT> zzcyVar, String str) {
        return new zzbb<>(zzcyVar, str);
    }

    @VisibleForTesting
    @NonNull
    static com.google.firebase.auth.internal.zzl zza(@NonNull FirebaseApp firebaseApp, @NonNull com.google.android.gms.internal.firebase_auth.zzaj zzajVar) {
        Preconditions.checkNotNull(firebaseApp);
        Preconditions.checkNotNull(zzajVar);
        ArrayList arrayList = new ArrayList();
        arrayList.add(new com.google.firebase.auth.internal.zzh(zzajVar, FirebaseAuthProvider.PROVIDER_ID));
        List<com.google.android.gms.internal.firebase_auth.zzaq> listZzat = zzajVar.zzat();
        if (listZzat != null && !listZzat.isEmpty()) {
            for (int i = 0; i < listZzat.size(); i++) {
                arrayList.add(new com.google.firebase.auth.internal.zzh(listZzat.get(i)));
            }
        }
        com.google.firebase.auth.internal.zzl zzlVar = new com.google.firebase.auth.internal.zzl(firebaseApp, arrayList);
        zzlVar.zza(new com.google.firebase.auth.internal.zzn(zzajVar.getLastSignInTimestamp(), zzajVar.getCreationTimestamp()));
        zzlVar.zze(zzajVar.isNewUser());
        zzlVar.zzc(zzajVar.zzav());
        return zzlVar;
    }

    @NonNull
    private final GoogleApi<zzcp> zzb(boolean z) {
        zzcp zzcpVar = (zzcp) this.zzgt.clone();
        zzcpVar.zzgn = z;
        return new zzal(this.zzgs, zzcn.zzhn, zzcpVar, new FirebaseExceptionMapper());
    }

    @NonNull
    public final Task<Void> setFirebaseUIVersion(@NonNull String str) {
        return zzb(zza(new zzbm(str), "setFirebaseUIVersion"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull ActionCodeSettings actionCodeSettings, @NonNull String str) {
        return zzb(zza(new zzbk(str, actionCodeSettings).zza(firebaseApp), "sendEmailVerification"));
    }

    public final Task<AuthResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull AuthCredential authCredential, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzbo(authCredential).zza(firebaseApp).zza(zzaVar), "signInWithCredential"));
    }

    public final Task<AuthResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull EmailAuthCredential emailAuthCredential, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzbr(emailAuthCredential).zza(firebaseApp).zza(zzaVar), "sendSignInLinkToEmail"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbc(authCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithCredential"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull EmailAuthCredential emailAuthCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbe(emailAuthCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithEmailLink"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull PhoneAuthCredential phoneAuthCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbx(phoneAuthCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "updatePhoneNumber"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull UserProfileChangeRequest userProfileChangeRequest, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzby(userProfileChangeRequest).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "updateProfile"));
    }

    @NonNull
    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zza(zza(new zzbj().zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reload"));
    }

    public final Task<GetTokenResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull String str, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zza(zza(new zzaw(str).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "getAccessToken"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull String str, @NonNull String str2, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbg(str, str2).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithEmailPassword"));
    }

    public final Task<AuthResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull PhoneAuthCredential phoneAuthCredential, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzbs(phoneAuthCredential).zza(firebaseApp).zza(zzaVar), "signInWithPhoneNumber"));
    }

    public final Task<AuthResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzbn().zza(firebaseApp).zza(zzaVar), "signInAnonymously"));
    }

    public final Task<ProviderQueryResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull String str) {
        return zza(zza(new zzau(str).zza(firebaseApp), "fetchProvidersForEmail"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull String str, @NonNull ActionCodeSettings actionCodeSettings) {
        actionCodeSettings.zzb(1);
        return zzb(zza(new zzbl(str, actionCodeSettings).zza(firebaseApp), "sendPasswordResetEmail"));
    }

    public final Task<AuthResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull String str, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzbp(str).zza(firebaseApp).zza(zzaVar), "signInWithCustomToken"));
    }

    public final Task<Void> zza(@NonNull FirebaseApp firebaseApp, @NonNull String str, @NonNull String str2) {
        return zzb(zza(new zzar(str, str2).zza(firebaseApp), "confirmPasswordReset"));
    }

    public final Task<AuthResult> zza(@NonNull FirebaseApp firebaseApp, @NonNull String str, @NonNull String str2, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzas(str, str2).zza(firebaseApp).zza(zzaVar), "createUserWithEmailAndPassword"));
    }

    @NonNull
    public final Task<Void> zza(@NonNull FirebaseUser firebaseUser, @NonNull com.google.firebase.auth.internal.zzv zzvVar) {
        return zzb(zza(new zzat().zzf(firebaseUser).zza(zzvVar).zza((com.google.firebase.auth.internal.zzw) zzvVar), "delete"));
    }

    public final void zza(@NonNull FirebaseApp firebaseApp, @NonNull com.google.android.gms.internal.firebase_auth.zzax zzaxVar, @NonNull PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, @Nullable Activity activity, @NonNull Executor executor) {
        zzb(zza(new zzca(zzaxVar).zza(firebaseApp).zza(onVerificationStateChangedCallbacks, activity, executor), "verifyPhoneNumber"));
    }

    public final Task<AuthResult> zzb(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbd(authCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithCredentialWithData"));
    }

    public final Task<AuthResult> zzb(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull EmailAuthCredential emailAuthCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbf(emailAuthCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithEmailLinkWithData"));
    }

    public final Task<Void> zzb(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull PhoneAuthCredential phoneAuthCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbi(phoneAuthCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithPhoneCredential"));
    }

    public final Task<Void> zzb(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull String str, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbv(str).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "updateEmail"));
    }

    public final Task<AuthResult> zzb(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull String str, @NonNull String str2, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbh(str, str2).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithEmailPasswordWithData"));
    }

    public final Task<SignInMethodQueryResult> zzb(@NonNull FirebaseApp firebaseApp, @NonNull String str) {
        return zza(zza(new zzav(str).zza(firebaseApp), "fetchSignInMethodsForEmail"));
    }

    public final Task<Void> zzb(@NonNull FirebaseApp firebaseApp, @NonNull String str, @NonNull ActionCodeSettings actionCodeSettings) {
        actionCodeSettings.zzb(6);
        return zzb(zza(new zzbl(str, actionCodeSettings).zza(firebaseApp), "sendSignInLinkToEmail"));
    }

    public final Task<AuthResult> zzb(@NonNull FirebaseApp firebaseApp, @NonNull String str, @NonNull String str2, @NonNull com.google.firebase.auth.internal.zza zzaVar) {
        return zzb(zza(new zzbq(str, str2).zza(firebaseApp).zza(zzaVar), "signInWithEmailAndPassword"));
    }

    public final Task<AuthResult> zzc(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbd(authCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "reauthenticateWithPhoneCredentialWithData"));
    }

    public final Task<Void> zzc(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull String str, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        return zzb(zza(new zzbw(str).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "updatePassword"));
    }

    public final Task<ActionCodeResult> zzc(@NonNull FirebaseApp firebaseApp, @NonNull String str) {
        return zzb(zza(new zzaq(str).zza(firebaseApp), "checkActionCode"));
    }

    public final Task<AuthResult> zzd(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        Preconditions.checkNotNull(firebaseApp);
        Preconditions.checkNotNull(authCredential);
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(zzaeVar);
        List<String> providers = firebaseUser.getProviders();
        if (providers != null && providers.contains(authCredential.getProvider())) {
            return Tasks.forException(zzce.zzb(new Status(FirebaseError.ERROR_PROVIDER_ALREADY_LINKED)));
        }
        if (authCredential instanceof EmailAuthCredential) {
            EmailAuthCredential emailAuthCredential = (EmailAuthCredential) authCredential;
            return !emailAuthCredential.zzj() ? zzb(zza(new zzax(emailAuthCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "linkEmailAuthCredential")) : zzb(zza(new zzba(emailAuthCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "linkEmailAuthCredential"));
        }
        if (authCredential instanceof PhoneAuthCredential) {
            return zzb(zza(new zzaz((PhoneAuthCredential) authCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "linkPhoneAuthCredential"));
        }
        Preconditions.checkNotNull(firebaseApp);
        Preconditions.checkNotNull(authCredential);
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(zzaeVar);
        return zzb(zza(new zzay(authCredential).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "linkFederatedCredential"));
    }

    public final Task<AuthResult> zzd(@NonNull FirebaseApp firebaseApp, @NonNull FirebaseUser firebaseUser, @NonNull String str, @NonNull com.google.firebase.auth.internal.zzae zzaeVar) {
        Preconditions.checkNotNull(firebaseApp);
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(zzaeVar);
        List<String> providers = firebaseUser.getProviders();
        if ((providers != null && !providers.contains(str)) || firebaseUser.isAnonymous()) {
            return Tasks.forException(zzce.zzb(new Status(FirebaseError.ERROR_NO_SUCH_PROVIDER, str)));
        }
        byte b = -1;
        if (str.hashCode() == 1216985755 && str.equals("password")) {
            b = 0;
        }
        return b != 0 ? zzb(zza(new zzbu(str).zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "unlinkFederatedCredential")) : zzb(zza(new zzbt().zza(firebaseApp).zzf(firebaseUser).zza(zzaeVar).zza((com.google.firebase.auth.internal.zzw) zzaeVar), "unlinkEmailCredential"));
    }

    public final Task<Void> zzd(@NonNull FirebaseApp firebaseApp, @NonNull String str) {
        return zzb(zza(new zzap(str).zza(firebaseApp), "applyActionCode"));
    }

    public final Task<String> zze(@NonNull FirebaseApp firebaseApp, @NonNull String str) {
        return zzb(zza(new zzbz(str).zza(firebaseApp), "verifyPasswordResetCode"));
    }

    @Override // com.google.firebase.auth.api.internal.zzah
    final zzai zzw() {
        int remoteVersion = DynamiteModule.getRemoteVersion(this.zzgs, "com.google.android.gms.firebase_auth");
        GoogleApi<zzcp> googleApiZzb = zzb(false);
        int localVersion = DynamiteModule.getLocalVersion(this.zzgs, "com.google.firebase.auth");
        return new zzai(googleApiZzb, localVersion != 0 ? zzb(true) : null, new zzak(remoteVersion, localVersion, Collections.emptyMap(), true));
    }
}
