.class final Lcom/google/firebase/auth/api/internal/zzv;
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
.field final synthetic zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

.field private final synthetic zzfm:Lcom/google/firebase/auth/api/internal/zza;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzv;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzv;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

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

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzaw()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzag;

    invoke-direct {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzag;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzv;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    invoke-static {v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zza;)Lcom/google/firebase/auth/api/internal/zzdi;

    move-result-object v0

    new-instance v2, Lcom/google/firebase/auth/api/internal/zzw;

    invoke-direct {v2, p0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzw;-><init>(Lcom/google/firebase/auth/api/internal/zzv;Lcom/google/firebase/auth/api/internal/zzdk;Lcom/google/android/gms/internal/firebase_auth/zzao;)V

    invoke-virtual {v0, v1, v2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzag;Lcom/google/firebase/auth/api/internal/zzdk;)V

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

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzv;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method
