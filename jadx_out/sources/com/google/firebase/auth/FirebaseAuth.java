package com.google.firebase.auth;

import android.app.Activity;
import android.support.annotation.Keep;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.firebase_auth.zzax;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseError;
import com.google.firebase.auth.PhoneAuthProvider;
import com.google.firebase.auth.api.internal.zzao;
import com.google.firebase.auth.api.internal.zzce;
import com.google.firebase.auth.api.internal.zzcn;
import com.google.firebase.auth.api.internal.zzcq;
import com.google.firebase.auth.api.internal.zzcw;
import com.google.firebase.auth.internal.InternalAuthProvider;
import com.google.firebase.auth.internal.zzaa;
import com.google.firebase.auth.internal.zzab;
import com.google.firebase.auth.internal.zzad;
import com.google.firebase.auth.internal.zzae;
import com.google.firebase.internal.InternalTokenResult;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.Executor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes2.dex */
public class FirebaseAuth implements InternalAuthProvider {
    private FirebaseApp zzeb;
    private final List<IdTokenListener> zzec;
    private final List<com.google.firebase.auth.internal.IdTokenListener> zzed;
    private List<AuthStateListener> zzee;
    private zzao zzef;
    private FirebaseUser zzeg;
    private com.google.firebase.auth.internal.zzk zzeh;
    private final Object zzei;
    private String zzej;
    private zzaa zzek;
    private zzab zzel;
    private zzad zzem;

    public interface AuthStateListener {
        void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth);
    }

    public interface IdTokenListener {
        void onIdTokenChanged(@NonNull FirebaseAuth firebaseAuth);
    }

    @VisibleForTesting
    class zza implements com.google.firebase.auth.internal.zza {
        zza() {
        }

        @Override // com.google.firebase.auth.internal.zza
        public final void zza(@NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, @NonNull FirebaseUser firebaseUser) {
            Preconditions.checkNotNull(zzaoVar);
            Preconditions.checkNotNull(firebaseUser);
            firebaseUser.zza(zzaoVar);
            FirebaseAuth.this.zza(firebaseUser, zzaoVar, true);
        }
    }

    @VisibleForTesting
    class zzb extends zza implements com.google.firebase.auth.internal.zza, com.google.firebase.auth.internal.zzw {
        zzb() {
            super();
        }

        @Override // com.google.firebase.auth.internal.zzw
        public final void zza(Status status) {
            if (status.getStatusCode() == 17011 || status.getStatusCode() == 17021 || status.getStatusCode() == 17005) {
                FirebaseAuth.this.signOut();
            }
        }
    }

    class zzc extends zza implements com.google.firebase.auth.internal.zza, com.google.firebase.auth.internal.zzw {
        zzc(FirebaseAuth firebaseAuth) {
            super();
        }

        @Override // com.google.firebase.auth.internal.zzw
        public final void zza(Status status) {
        }
    }

    public FirebaseAuth(FirebaseApp firebaseApp) {
        this(firebaseApp, zzcn.zza(firebaseApp.getApplicationContext(), new zzcq(firebaseApp.getOptions().getApiKey()).zzah()), new zzaa(firebaseApp.getApplicationContext(), firebaseApp.getPersistenceKey()));
    }

    @VisibleForTesting
    private FirebaseAuth(FirebaseApp firebaseApp, zzao zzaoVar, zzaa zzaaVar) {
        com.google.android.gms.internal.firebase_auth.zzao zzaoVarZzh;
        this.zzei = new Object();
        this.zzeb = (FirebaseApp) Preconditions.checkNotNull(firebaseApp);
        this.zzef = (zzao) Preconditions.checkNotNull(zzaoVar);
        this.zzek = (zzaa) Preconditions.checkNotNull(zzaaVar);
        this.zzeh = new com.google.firebase.auth.internal.zzk();
        this.zzec = new CopyOnWriteArrayList();
        this.zzed = new CopyOnWriteArrayList();
        this.zzee = new CopyOnWriteArrayList();
        this.zzem = zzad.zzbn();
        this.zzeg = this.zzek.zzbl();
        if (this.zzeg == null || (zzaoVarZzh = this.zzek.zzh(this.zzeg)) == null) {
            return;
        }
        zza(this.zzeg, zzaoVarZzh, false);
    }

    @Keep
    public static FirebaseAuth getInstance() {
        return (FirebaseAuth) FirebaseApp.getInstance().get(FirebaseAuth.class);
    }

    @Keep
    public static FirebaseAuth getInstance(@NonNull FirebaseApp firebaseApp) {
        return (FirebaseAuth) firebaseApp.get(FirebaseAuth.class);
    }

    @NonNull
    private final Task<Void> zza(@NonNull FirebaseUser firebaseUser, zzae zzaeVar) {
        Preconditions.checkNotNull(firebaseUser);
        return this.zzef.zza(this.zzeb, firebaseUser, zzaeVar);
    }

    @VisibleForTesting
    private final synchronized void zza(zzab zzabVar) {
        this.zzel = zzabVar;
        this.zzeb.setIdTokenListenersCountChangedListener(zzabVar);
    }

    private final void zzb(@Nullable FirebaseUser firebaseUser) {
        String str;
        String string;
        if (firebaseUser != null) {
            str = "FirebaseAuth";
            String uid = firebaseUser.getUid();
            StringBuilder sb = new StringBuilder(String.valueOf(uid).length() + 45);
            sb.append("Notifying id token listeners about user ( ");
            sb.append(uid);
            sb.append(" ).");
            string = sb.toString();
        } else {
            str = "FirebaseAuth";
            string = "Notifying id token listeners about a sign-out event.";
        }
        Log.d(str, string);
        this.zzem.execute(new zzk(this, new InternalTokenResult(firebaseUser != null ? firebaseUser.zzr() : null)));
    }

    private final void zzc(@Nullable FirebaseUser firebaseUser) {
        if (firebaseUser != null) {
            String uid = firebaseUser.getUid();
            StringBuilder sb = new StringBuilder(String.valueOf(uid).length() + 47);
            sb.append("Notifying auth state listeners about user ( ");
            sb.append(uid);
            sb.append(" ).");
            Log.d("FirebaseAuth", sb.toString());
        } else {
            Log.d("FirebaseAuth", "Notifying auth state listeners about a sign-out event.");
        }
        this.zzem.execute(new zzl(this));
    }

    @VisibleForTesting
    private final synchronized zzab zzl() {
        if (this.zzel == null) {
            zza(new zzab(this.zzeb));
        }
        return this.zzel;
    }

    public void addAuthStateListener(@NonNull AuthStateListener authStateListener) {
        this.zzee.add(authStateListener);
        this.zzem.execute(new zzj(this, authStateListener));
    }

    public void addIdTokenListener(@NonNull IdTokenListener idTokenListener) {
        this.zzec.add(idTokenListener);
        this.zzem.execute(new zzi(this, idTokenListener));
    }

    @Override // com.google.firebase.auth.internal.InternalAuthProvider
    @KeepForSdk
    public void addIdTokenListener(@NonNull com.google.firebase.auth.internal.IdTokenListener idTokenListener) {
        Preconditions.checkNotNull(idTokenListener);
        this.zzed.add(idTokenListener);
        this.zzel.zzf(this.zzed.size());
    }

    @NonNull
    public Task<Void> applyActionCode(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzef.zzd(this.zzeb, str);
    }

    @NonNull
    public Task<ActionCodeResult> checkActionCode(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzef.zzc(this.zzeb, str);
    }

    @NonNull
    public Task<Void> confirmPasswordReset(@NonNull String str, @NonNull String str2) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        return this.zzef.zza(this.zzeb, str, str2);
    }

    @NonNull
    public Task<AuthResult> createUserWithEmailAndPassword(@NonNull String str, @NonNull String str2) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        return this.zzef.zza(this.zzeb, str, str2, new zza());
    }

    @NonNull
    @Deprecated
    public Task<ProviderQueryResult> fetchProvidersForEmail(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzef.zza(this.zzeb, str);
    }

    @NonNull
    public Task<SignInMethodQueryResult> fetchSignInMethodsForEmail(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzef.zzb(this.zzeb, str);
    }

    @Override // com.google.firebase.auth.internal.InternalAuthProvider, com.google.firebase.internal.InternalTokenProvider
    @NonNull
    public Task<GetTokenResult> getAccessToken(boolean z) {
        return zza(this.zzeg, z);
    }

    public FirebaseApp getApp() {
        return this.zzeb;
    }

    @Nullable
    public FirebaseUser getCurrentUser() {
        return this.zzeg;
    }

    public FirebaseAuthSettings getFirebaseAuthSettings() {
        return this.zzeh;
    }

    @Nullable
    public String getLanguageCode() {
        String str;
        synchronized (this.zzei) {
            str = this.zzej;
        }
        return str;
    }

    @Override // com.google.firebase.auth.internal.InternalAuthProvider, com.google.firebase.internal.InternalTokenProvider
    @Nullable
    public String getUid() {
        if (this.zzeg == null) {
            return null;
        }
        return this.zzeg.getUid();
    }

    public boolean isSignInWithEmailLink(@NonNull String str) {
        return EmailAuthCredential.isSignInWithEmailLink(str);
    }

    public void removeAuthStateListener(@NonNull AuthStateListener authStateListener) {
        this.zzee.remove(authStateListener);
    }

    public void removeIdTokenListener(@NonNull IdTokenListener idTokenListener) {
        this.zzec.remove(idTokenListener);
    }

    @Override // com.google.firebase.auth.internal.InternalAuthProvider
    @KeepForSdk
    public void removeIdTokenListener(@NonNull com.google.firebase.auth.internal.IdTokenListener idTokenListener) {
        Preconditions.checkNotNull(idTokenListener);
        this.zzed.remove(idTokenListener);
        this.zzel.zzf(this.zzed.size());
    }

    @NonNull
    public Task<Void> sendPasswordResetEmail(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return sendPasswordResetEmail(str, null);
    }

    @NonNull
    public Task<Void> sendPasswordResetEmail(@NonNull String str, @Nullable ActionCodeSettings actionCodeSettings) {
        Preconditions.checkNotEmpty(str);
        if (actionCodeSettings == null) {
            actionCodeSettings = ActionCodeSettings.zze();
        }
        if (this.zzej != null) {
            actionCodeSettings.zza(this.zzej);
        }
        actionCodeSettings.zzb(1);
        return this.zzef.zza(this.zzeb, str, actionCodeSettings);
    }

    public Task<Void> sendSignInLinkToEmail(@NonNull String str, @NonNull ActionCodeSettings actionCodeSettings) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(actionCodeSettings);
        if (!actionCodeSettings.canHandleCodeInApp()) {
            throw new IllegalArgumentException("You must set canHandleCodeInApp in your ActionCodeSettings to true for Email-Link Sign-in.");
        }
        if (this.zzej != null) {
            actionCodeSettings.zza(this.zzej);
        }
        return this.zzef.zzb(this.zzeb, str, actionCodeSettings);
    }

    public Task<Void> setFirebaseUIVersion(@Nullable String str) {
        return this.zzef.setFirebaseUIVersion(str);
    }

    public void setLanguageCode(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        synchronized (this.zzei) {
            this.zzej = str;
        }
    }

    @NonNull
    public Task<AuthResult> signInAnonymously() {
        if (this.zzeg == null || !this.zzeg.isAnonymous()) {
            return this.zzef.zza(this.zzeb, new zza());
        }
        com.google.firebase.auth.internal.zzl zzlVar = (com.google.firebase.auth.internal.zzl) this.zzeg;
        zzlVar.zze(false);
        return Tasks.forResult(new com.google.firebase.auth.internal.zzf(zzlVar));
    }

    @NonNull
    public Task<AuthResult> signInWithCredential(@NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(authCredential);
        if (authCredential instanceof EmailAuthCredential) {
            EmailAuthCredential emailAuthCredential = (EmailAuthCredential) authCredential;
            return !emailAuthCredential.zzj() ? this.zzef.zzb(this.zzeb, emailAuthCredential.getEmail(), emailAuthCredential.getPassword(), new zza()) : this.zzef.zza(this.zzeb, emailAuthCredential, (com.google.firebase.auth.internal.zza) new zza());
        }
        if (authCredential instanceof PhoneAuthCredential) {
            return this.zzef.zza(this.zzeb, (PhoneAuthCredential) authCredential, (com.google.firebase.auth.internal.zza) new zza());
        }
        return this.zzef.zza(this.zzeb, authCredential, new zza());
    }

    @NonNull
    public Task<AuthResult> signInWithCustomToken(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzef.zza(this.zzeb, str, new zza());
    }

    @NonNull
    public Task<AuthResult> signInWithEmailAndPassword(@NonNull String str, @NonNull String str2) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotEmpty(str2);
        return this.zzef.zzb(this.zzeb, str, str2, new zza());
    }

    @NonNull
    public Task<AuthResult> signInWithEmailLink(@NonNull String str, @NonNull String str2) {
        return signInWithCredential(EmailAuthProvider.getCredentialWithLink(str, str2));
    }

    public void signOut() {
        zzk();
        if (this.zzel != null) {
            this.zzel.cancel();
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v3, types: [com.google.firebase.auth.FirebaseAuth$zzc, com.google.firebase.auth.internal.zzae] */
    public Task<Void> updateCurrentUser(@NonNull FirebaseUser firebaseUser) {
        if (firebaseUser == null) {
            throw new IllegalArgumentException("Cannot update current user with null user!");
        }
        String apiKey = firebaseUser.zzo().getOptions().getApiKey();
        String apiKey2 = this.zzeb.getOptions().getApiKey();
        if (!firebaseUser.zzp().isValid() || !apiKey2.equals(apiKey)) {
            return zza(firebaseUser, (zzae) new zzc(this));
        }
        zza(com.google.firebase.auth.internal.zzl.zza(this.zzeb, firebaseUser), firebaseUser.zzp(), true);
        return Tasks.forResult(null);
    }

    public void useAppLanguage() {
        synchronized (this.zzei) {
            this.zzej = zzcw.zzal();
        }
    }

    @NonNull
    public Task<String> verifyPasswordResetCode(@NonNull String str) {
        Preconditions.checkNotEmpty(str);
        return this.zzef.zze(this.zzeb, str);
    }

    @NonNull
    public final Task<Void> zza(@Nullable ActionCodeSettings actionCodeSettings, @NonNull String str) {
        Preconditions.checkNotEmpty(str);
        if (this.zzej != null) {
            if (actionCodeSettings == null) {
                actionCodeSettings = ActionCodeSettings.zze();
            }
            actionCodeSettings.zza(this.zzej);
        }
        return this.zzef.zza(this.zzeb, actionCodeSettings, str);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference failed for: r2v1, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference failed for: r2v2, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference failed for: r6v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<Void> zza(@NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(authCredential);
        if (!EmailAuthCredential.class.isAssignableFrom(authCredential.getClass())) {
            return authCredential instanceof PhoneAuthCredential ? this.zzef.zzb(this.zzeb, firebaseUser, (PhoneAuthCredential) authCredential, (zzae) new zzb()) : this.zzef.zza(this.zzeb, firebaseUser, authCredential, (zzae) new zzb());
        }
        EmailAuthCredential emailAuthCredential = (EmailAuthCredential) authCredential;
        return "password".equals(emailAuthCredential.getSignInMethod()) ? this.zzef.zza(this.zzeb, firebaseUser, emailAuthCredential.getEmail(), emailAuthCredential.getPassword(), (zzae) new zzb()) : this.zzef.zza(this.zzeb, firebaseUser, emailAuthCredential, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<Void> zza(@NonNull FirebaseUser firebaseUser, @NonNull PhoneAuthCredential phoneAuthCredential) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(phoneAuthCredential);
        return this.zzef.zza(this.zzeb, firebaseUser, phoneAuthCredential, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<Void> zza(@NonNull FirebaseUser firebaseUser, @NonNull UserProfileChangeRequest userProfileChangeRequest) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(userProfileChangeRequest);
        return this.zzef.zza(this.zzeb, firebaseUser, userProfileChangeRequest, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<AuthResult> zza(@NonNull FirebaseUser firebaseUser, @NonNull String str) {
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(firebaseUser);
        return this.zzef.zzd(this.zzeb, firebaseUser, str, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.internal.zzae, com.google.firebase.auth.zzm] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<GetTokenResult> zza(@Nullable FirebaseUser firebaseUser, boolean z) {
        if (firebaseUser == null) {
            return Tasks.forException(zzce.zzb(new Status(FirebaseError.ERROR_NO_SIGNED_IN_USER)));
        }
        com.google.android.gms.internal.firebase_auth.zzao zzaoVarZzp = this.zzeg.zzp();
        return (!zzaoVarZzp.isValid() || z) ? this.zzef.zza(this.zzeb, firebaseUser, zzaoVarZzp.zzap(), (zzae) new zzm(this)) : Tasks.forResult(com.google.firebase.auth.internal.zzy.zzag(zzaoVarZzp.zzaw()));
    }

    public final void zza(@NonNull FirebaseUser firebaseUser, @NonNull com.google.android.gms.internal.firebase_auth.zzao zzaoVar, boolean z) {
        boolean z2;
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(zzaoVar);
        boolean z3 = true;
        if (this.zzeg == null) {
            z2 = true;
        } else {
            boolean z4 = !this.zzeg.zzp().zzaw().equals(zzaoVar.zzaw());
            boolean zEquals = this.zzeg.getUid().equals(firebaseUser.getUid());
            z2 = !zEquals || z4;
            if (zEquals) {
                z3 = false;
            }
        }
        Preconditions.checkNotNull(firebaseUser);
        if (this.zzeg == null) {
            this.zzeg = firebaseUser;
        } else {
            this.zzeg.zza(firebaseUser.getProviderData());
            if (!firebaseUser.isAnonymous()) {
                this.zzeg.zzn();
            }
        }
        if (z) {
            this.zzek.zzg(this.zzeg);
        }
        if (z2) {
            if (this.zzeg != null) {
                this.zzeg.zza(zzaoVar);
            }
            zzb(this.zzeg);
        }
        if (z3) {
            zzc(this.zzeg);
        }
        if (z) {
            this.zzek.zza(firebaseUser, zzaoVar);
        }
        zzl().zzc(this.zzeg.zzp());
    }

    @NonNull
    public final void zza(@NonNull String str, long j, TimeUnit timeUnit, @NonNull PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, @Nullable Activity activity, @NonNull Executor executor, boolean z) {
        long jConvert = TimeUnit.SECONDS.convert(j, timeUnit);
        if (jConvert < 0 || jConvert > 120) {
            throw new IllegalArgumentException("We only support 0-120 seconds for sms-auto-retrieval timeout");
        }
        this.zzef.zza(this.zzeb, new zzax(str, jConvert, z, this.zzej), (this.zzeh.zzbf() && str.equals(this.zzeh.getPhoneNumber())) ? new zzn(this, onVerificationStateChangedCallbacks) : onVerificationStateChangedCallbacks, activity, executor);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference failed for: r2v1, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference failed for: r2v2, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference failed for: r6v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    public final Task<AuthResult> zzb(@NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotNull(authCredential);
        if (!EmailAuthCredential.class.isAssignableFrom(authCredential.getClass())) {
            return authCredential instanceof PhoneAuthCredential ? this.zzef.zzc(this.zzeb, firebaseUser, authCredential, (zzae) new zzb()) : this.zzef.zzb(this.zzeb, firebaseUser, authCredential, (zzae) new zzb());
        }
        EmailAuthCredential emailAuthCredential = (EmailAuthCredential) authCredential;
        return "password".equals(emailAuthCredential.getSignInMethod()) ? this.zzef.zzb(this.zzeb, firebaseUser, emailAuthCredential.getEmail(), emailAuthCredential.getPassword(), new zzb()) : this.zzef.zzb(this.zzeb, firebaseUser, emailAuthCredential, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<Void> zzb(@NonNull FirebaseUser firebaseUser, @NonNull String str) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotEmpty(str);
        return this.zzef.zzb(this.zzeb, firebaseUser, str, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<AuthResult> zzc(@NonNull FirebaseUser firebaseUser, @NonNull AuthCredential authCredential) {
        Preconditions.checkNotNull(authCredential);
        Preconditions.checkNotNull(firebaseUser);
        return this.zzef.zzd(this.zzeb, firebaseUser, authCredential, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @NonNull
    public final Task<Void> zzc(@NonNull FirebaseUser firebaseUser, @NonNull String str) {
        Preconditions.checkNotNull(firebaseUser);
        Preconditions.checkNotEmpty(str);
        return this.zzef.zzc(this.zzeb, firebaseUser, str, (zzae) new zzb());
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0, types: [com.google.firebase.auth.FirebaseAuth$zzb, com.google.firebase.auth.internal.zzae] */
    public final Task<Void> zzd(@NonNull FirebaseUser firebaseUser) {
        return zza(firebaseUser, (zzae) new zzb());
    }

    @NonNull
    public final Task<Void> zze(@NonNull FirebaseUser firebaseUser) {
        Preconditions.checkNotNull(firebaseUser);
        return this.zzef.zza(firebaseUser, new zzo(this, firebaseUser));
    }

    public final void zzk() {
        if (this.zzeg != null) {
            zzaa zzaaVar = this.zzek;
            FirebaseUser firebaseUser = this.zzeg;
            Preconditions.checkNotNull(firebaseUser);
            zzaaVar.clear(String.format("com.google.firebase.auth.GET_TOKEN_RESPONSE.%s", firebaseUser.getUid()));
            this.zzeg = null;
        }
        this.zzek.clear("com.google.firebase.auth.FIREBASE_USER");
        zzb((FirebaseUser) null);
        zzc((FirebaseUser) null);
    }
}
