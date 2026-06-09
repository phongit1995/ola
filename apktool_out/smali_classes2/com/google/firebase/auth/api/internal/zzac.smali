.class final Lcom/google/firebase/auth/api/internal/zzac;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdk;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdk<",
        "Lcom/google/android/gms/internal/firebase_auth/zzao;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

.field private final synthetic zzfm:Lcom/google/firebase/auth/api/internal/zza;

.field private final synthetic zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/UserProfileChangeRequest;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 3
    .param p1    # Ljava/lang/Object;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;-><init>()V

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzaw()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzv(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {v1}, Lcom/google/firebase/auth/UserProfileChangeRequest;->zzu()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {v1}, Lcom/google/firebase/auth/UserProfileChangeRequest;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    :cond_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {v1}, Lcom/google/firebase/auth/UserProfileChangeRequest;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzy(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;

    :cond_1
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {v1}, Lcom/google/firebase/auth/UserProfileChangeRequest;->zzv()Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {v1}, Lcom/google/firebase/auth/UserProfileChangeRequest;->getPhotoUri()Landroid/net/Uri;

    move-result-object v1

    if-eqz v1, :cond_3

    :cond_2
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzgh:Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {v1}, Lcom/google/firebase/auth/UserProfileChangeRequest;->zzt()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzz(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;

    :cond_3
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-static {v1, v2, p1, v0, p0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/firebase/auth/internal/zzq;->zzaf(Ljava/lang/String;)Lcom/google/android/gms/common/api/Status;

    move-result-object p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzac;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method
