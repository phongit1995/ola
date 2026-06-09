.class final Lcom/google/firebase/auth/api/internal/zzb;
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


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzb;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1    # Ljava/lang/Object;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzb;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzao;)V

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

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzb;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method
