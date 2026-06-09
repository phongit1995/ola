.class final Lcom/google/firebase/auth/api/internal/zzau;
.super Lcom/google/firebase/auth/api/internal/zzcy;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Lcom/google/firebase/auth/ProviderQueryResult;",
        "Lcom/google/firebase/auth/internal/zza;",
        ">;"
    }
.end annotation


# instance fields
.field private final zzah:Ljava/lang/String;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    const-string v0, "email cannot be null or empty"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzau;->zzah:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzau;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzau;->zzah:Ljava/lang/String;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzau;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/auth/api/internal/zzck;->zzc(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 2

    new-instance v0, Lcom/google/firebase/auth/internal/zzp;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzau;->zzin:Lcom/google/android/gms/internal/firebase_auth/zzx;

    invoke-direct {v0, v1}, Lcom/google/firebase/auth/internal/zzp;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzx;)V

    invoke-virtual {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
