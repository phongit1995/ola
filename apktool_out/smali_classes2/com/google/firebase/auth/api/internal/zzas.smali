.class final Lcom/google/firebase/auth/api/internal/zzas;
.super Lcom/google/firebase/auth/api/internal/zzcy;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Lcom/google/firebase/auth/AuthResult;",
        "Lcom/google/firebase/auth/internal/zza;",
        ">;"
    }
.end annotation


# instance fields
.field private zzah:Ljava/lang/String;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field

.field private zzbi:Ljava/lang/String;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    const-string v0, "email cannot be null or empty"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzah:Ljava/lang/String;

    const-string p1, "password cannot be null or empty"

    invoke-static {p2, p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzbi:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzah:Ljava/lang/String;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzbi:Ljava/lang/String;

    iget-object v3, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2, v3}, Lcom/google/firebase/auth/api/internal/zzck;->zzc(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzeb:Lcom/google/firebase/FirebaseApp;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzim:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/FirebaseApp;Lcom/google/android/gms/internal/firebase_auth/zzaj;)Lcom/google/firebase/auth/internal/zzl;

    move-result-object v0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzie:Ljava/lang/Object;

    check-cast v1, Lcom/google/firebase/auth/internal/zza;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzas;->zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-interface {v1, v2, v0}, Lcom/google/firebase/auth/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/firebase/auth/FirebaseUser;)V

    new-instance v1, Lcom/google/firebase/auth/internal/zzf;

    invoke-direct {v1, v0}, Lcom/google/firebase/auth/internal/zzf;-><init>(Lcom/google/firebase/auth/internal/zzl;)V

    invoke-virtual {p0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
