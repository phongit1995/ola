.class public interface abstract Lcom/google/android/gms/signin/internal/ISignInCallbacks;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/IInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/signin/internal/ISignInCallbacks$Stub;
    }
.end annotation


# virtual methods
.method public abstract onAuthAccountComplete(Lcom/google/android/gms/common/ConnectionResult;Lcom/google/android/gms/signin/internal/AuthAccountResult;)V
.end method

.method public abstract onGetCurrentAccountComplete(Lcom/google/android/gms/common/api/Status;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V
.end method

.method public abstract onRecordConsentComplete(Lcom/google/android/gms/common/api/Status;)V
.end method

.method public abstract onSaveAccountToSessionStoreComplete(Lcom/google/android/gms/common/api/Status;)V
.end method

.method public abstract onSignInComplete(Lcom/google/android/gms/signin/internal/SignInResponse;)V
.end method
