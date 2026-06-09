.class final Lcom/google/firebase/auth/api/internal/zzdb;
.super Lcom/google/firebase/auth/api/internal/zzci;


# instance fields
.field final synthetic zziw:Lcom/google/firebase/auth/api/internal/zzcy;


# direct methods
.method private constructor <init>(Lcom/google/firebase/auth/api/internal/zzcy;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-direct {p0}, Lcom/google/firebase/auth/api/internal/zzci;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/firebase/auth/api/internal/zzcy;Lcom/google/firebase/auth/api/internal/zzcz;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/firebase/auth/api/internal/zzdb;-><init>(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method private final zza(Lcom/google/firebase/auth/api/internal/zzdh;)V
    .locals 2

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzij:Ljava/util/concurrent/Executor;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzdg;

    invoke-direct {v1, p0, p1}, Lcom/google/firebase/auth/api/internal/zzdg;-><init>(Lcom/google/firebase/auth/api/internal/zzdb;Lcom/google/firebase/auth/api/internal/zzdh;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public final onFailure(Lcom/google/android/gms/common/api/Status;)V
    .locals 2
    .param p1    # Lcom/google/android/gms/common/api/Status;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Z)Z

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzis:Z

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzdf;

    invoke-direct {v0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzdf;-><init>(Lcom/google/firebase/auth/api/internal/zzdb;Lcom/google/android/gms/common/api/Status;)V

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzdb;->zza(Lcom/google/firebase/auth/api/internal/zzdh;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Lcom/google/android/gms/common/api/Status;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzc(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

.method public final onVerificationCompleted(Lcom/google/firebase/auth/PhoneAuthCredential;)V
    .locals 5
    .param p1    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x1

    const/16 v2, 0x8

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v2, v2, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v3, 0x24

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v3, "Unexpected response type "

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Z)Z

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-boolean v1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzis:Z

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzdd;

    invoke-direct {v0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzdd;-><init>(Lcom/google/firebase/auth/api/internal/zzdb;Lcom/google/firebase/auth/PhoneAuthCredential;)V

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzdb;->zza(Lcom/google/firebase/auth/api/internal/zzdh;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/common/api/Status;Lcom/google/firebase/auth/PhoneAuthCredential;)V
    .locals 2
    .param p1    # Lcom/google/android/gms/common/api/Status;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzik:Lcom/google/firebase/auth/api/internal/zzda;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Z)Z

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzik:Lcom/google/firebase/auth/api/internal/zzda;

    invoke-interface {v0, p1, p2}, Lcom/google/firebase/auth/api/internal/zzda;->zza(Lcom/google/android/gms/common/api/Status;Lcom/google/firebase/auth/PhoneAuthCredential;)V

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzdb;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V
    .locals 4
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/internal/firebase_auth/zzaj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x25

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type: "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p2, p1, Lcom/google/firebase/auth/api/internal/zzcy;->zzim:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzav;)V
    .locals 4
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzav;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzio:Lcom/google/android/gms/internal/firebase_auth/zzav;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzx;)V
    .locals 4
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzx;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzin:Lcom/google/android/gms/internal/firebase_auth/zzx;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zzac()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zzad()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zzae()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zzb(Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    .locals 4
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x25

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type: "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zzd(Ljava/lang/String;)V
    .locals 4
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzip:Ljava/lang/String;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;)V

    return-void
.end method

.method public final zze(Ljava/lang/String;)V
    .locals 4
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v2, 0x24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v2, "Unexpected response type "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzey:Ljava/lang/String;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzdc;

    invoke-direct {v0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzdc;-><init>(Lcom/google/firebase/auth/api/internal/zzdb;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzdb;->zza(Lcom/google/firebase/auth/api/internal/zzdh;)V

    return-void
.end method

.method public final zzf(Ljava/lang/String;)V
    .locals 5
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/4 v1, 0x1

    const/16 v2, 0x8

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget v2, v2, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    const/16 v3, 0x24

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v3, "Unexpected response type "

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-object p1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzey:Ljava/lang/String;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    invoke-static {v0, v1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Z)Z

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iput-boolean v1, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzis:Z

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzde;

    invoke-direct {v0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzde;-><init>(Lcom/google/firebase/auth/api/internal/zzdb;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzdb;->zza(Lcom/google/firebase/auth/api/internal/zzdh;)V

    return-void
.end method
