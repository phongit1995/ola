.class final Lcom/google/firebase/auth/api/internal/zzaz;
.super Lcom/google/firebase/auth/api/internal/zzcy;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzda;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Lcom/google/firebase/auth/AuthResult;",
        "Lcom/google/firebase/auth/internal/zza;",
        ">;",
        "Lcom/google/firebase/auth/api/internal/zzda;"
    }
.end annotation


# instance fields
.field private final zzgx:Lcom/google/firebase/auth/PhoneAuthCredential;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/google/firebase/auth/PhoneAuthCredential;)V
    .locals 1
    .param p1    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    const-string v0, "credential cannot be null"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/PhoneAuthCredential;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzgx:Lcom/google/firebase/auth/PhoneAuthCredential;

    iput-object p0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzik:Lcom/google/firebase/auth/api/internal/zzda;

    return-void
.end method


# virtual methods
.method public final zza(Lcom/google/android/gms/common/api/Status;Lcom/google/firebase/auth/PhoneAuthCredential;)V
    .locals 5
    .param p1    # Lcom/google/android/gms/common/api/Status;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget v0, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzia:I

    const/4 v1, 0x0

    const/4 v2, 0x2

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget v2, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzia:I

    const/16 v3, 0x24

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v3, "Unexpected response type "

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iput-boolean v1, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzis:Z

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zziq:Lcom/google/firebase/auth/PhoneAuthCredential;

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzif:Lcom/google/firebase/auth/internal/zzw;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzif:Lcom/google/firebase/auth/internal/zzw;

    invoke-interface {p2, p1}, Lcom/google/firebase/auth/internal/zzw;->zza(Lcom/google/android/gms/common/api/Status;)V

    :cond_1
    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzc(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

.method public final zzaa()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzic:Lcom/google/firebase/auth/FirebaseUser;

    invoke-virtual {v1}, Lcom/google/firebase/auth/FirebaseUser;->zzq()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzgx:Lcom/google/firebase/auth/PhoneAuthCredential;

    iget-object v3, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2, v3}, Lcom/google/firebase/auth/api/internal/zzck;->zza(Ljava/lang/String;Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzeb:Lcom/google/firebase/FirebaseApp;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzim:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/FirebaseApp;Lcom/google/android/gms/internal/firebase_auth/zzaj;)Lcom/google/firebase/auth/internal/zzl;

    move-result-object v0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzie:Ljava/lang/Object;

    check-cast v1, Lcom/google/firebase/auth/internal/zza;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzaz;->zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-interface {v1, v2, v0}, Lcom/google/firebase/auth/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/firebase/auth/FirebaseUser;)V

    new-instance v1, Lcom/google/firebase/auth/internal/zzf;

    invoke-direct {v1, v0}, Lcom/google/firebase/auth/internal/zzf;-><init>(Lcom/google/firebase/auth/internal/zzl;)V

    invoke-virtual {p0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
