.class public final Lcom/google/firebase/auth/api/internal/zzcb;
.super Ljava/lang/Object;


# instance fields
.field private final zzdx:Lcom/google/android/gms/common/logging/Logger;

.field private final zzhh:Lcom/google/firebase/auth/api/internal/zzch;


# direct methods
.method public constructor <init>(Lcom/google/firebase/auth/api/internal/zzch;Lcom/google/android/gms/common/logging/Logger;)V
    .locals 0
    .param p1    # Lcom/google/firebase/auth/api/internal/zzch;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/common/logging/Logger;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/api/internal/zzch;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/common/logging/Logger;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    return-void
.end method


# virtual methods
.method public final onFailure(Lcom/google/android/gms/common/api/Status;)V
    .locals 3
    .param p1    # Lcom/google/android/gms/common/api/Status;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzch;->onFailure(Lcom/google/android/gms/common/api/Status;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "RemoteException when sending failure result."

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, p1, v2}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V
    .locals 2
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/internal/firebase_auth/zzaj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0, p1, p2}, Lcom/google/firebase/auth/api/internal/zzch;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v0, "RemoteException when sending get token and account info user response"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p2, v0, p1, v1}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzav;)V
    .locals 3
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzav;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzch;->zza(Lcom/google/android/gms/internal/firebase_auth/zzav;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "RemoteException when sending password reset response."

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, p1, v2}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzx;)V
    .locals 3
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzx;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzch;->zza(Lcom/google/android/gms/internal/firebase_auth/zzx;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "RemoteException when sending create auth uri response."

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, p1, v2}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zzac()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0}, Lcom/google/firebase/auth/api/internal/zzch;->zzac()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v2, "RemoteException when sending delete account response."

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v0, v3}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zzad()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0}, Lcom/google/firebase/auth/api/internal/zzch;->zzad()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v2, "RemoteException when sending email verification response."

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v0, v3}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zzae()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0}, Lcom/google/firebase/auth/api/internal/zzch;->zzae()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v2, "RemoteException when setting FirebaseUI Version"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v0, v3}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zzb(Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    .locals 3
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzch;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "RemoteException when sending token result."

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, p1, v2}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method

.method public final zzd(Ljava/lang/String;)V
    .locals 3
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzhh:Lcom/google/firebase/auth/api/internal/zzch;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzch;->zzd(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcb;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "RemoteException when sending set account info response."

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, p1, v2}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-void
.end method
