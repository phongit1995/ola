.class final Lcom/google/firebase/auth/api/internal/zzat;
.super Lcom/google/firebase/auth/api/internal/zzcy;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Ljava/lang/Void;",
        "Lcom/google/firebase/auth/internal/zzv;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x5

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzat;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzat;->zzic:Lcom/google/firebase/auth/FirebaseUser;

    invoke-virtual {v1}, Lcom/google/firebase/auth/FirebaseUser;->zzq()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzat;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/auth/api/internal/zzck;->zzg(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzat;->zzie:Ljava/lang/Object;

    check-cast v0, Lcom/google/firebase/auth/internal/zzv;

    invoke-interface {v0}, Lcom/google/firebase/auth/internal/zzv;->zzm()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
