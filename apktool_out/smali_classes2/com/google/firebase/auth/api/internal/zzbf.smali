.class final Lcom/google/firebase/auth/api/internal/zzbf;
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
.field private final zzgv:Lcom/google/firebase/auth/EmailAuthCredential;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/google/firebase/auth/EmailAuthCredential;)V
    .locals 1
    .param p1    # Lcom/google/firebase/auth/EmailAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    const-string v0, "credential cannot be null or empty"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/EmailAuthCredential;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzgv:Lcom/google/firebase/auth/EmailAuthCredential;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzgv:Lcom/google/firebase/auth/EmailAuthCredential;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/auth/api/internal/zzck;->zza(Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzeb:Lcom/google/firebase/FirebaseApp;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzim:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/FirebaseApp;Lcom/google/android/gms/internal/firebase_auth/zzaj;)Lcom/google/firebase/auth/internal/zzl;

    move-result-object v0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzic:Lcom/google/firebase/auth/FirebaseUser;

    invoke-virtual {v1}, Lcom/google/firebase/auth/FirebaseUser;->getUid()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lcom/google/firebase/auth/FirebaseUser;->getUid()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzie:Ljava/lang/Object;

    check-cast v1, Lcom/google/firebase/auth/internal/zza;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzbf;->zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-interface {v1, v2, v0}, Lcom/google/firebase/auth/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/firebase/auth/FirebaseUser;)V

    new-instance v1, Lcom/google/firebase/auth/internal/zzf;

    invoke-direct {v1, v0}, Lcom/google/firebase/auth/internal/zzf;-><init>(Lcom/google/firebase/auth/internal/zzl;)V

    invoke-virtual {p0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void

    :cond_0
    new-instance v0, Lcom/google/android/gms/common/api/Status;

    const/16 v1, 0x4280

    invoke-direct {v0, v1}, Lcom/google/android/gms/common/api/Status;-><init>(I)V

    invoke-virtual {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzc(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method
