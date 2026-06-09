.class final Lcom/google/firebase/auth/api/internal/zzdg;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final synthetic zzja:Lcom/google/firebase/auth/api/internal/zzdh;

.field private final synthetic zzjb:Lcom/google/firebase/auth/api/internal/zzdb;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zzdb;Lcom/google/firebase/auth/api/internal/zzdh;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdg;->zzjb:Lcom/google/firebase/auth/api/internal/zzdb;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzdg;->zzja:Lcom/google/firebase/auth/api/internal/zzdh;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdg;->zzjb:Lcom/google/firebase/auth/api/internal/zzdb;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdg;->zzjb:Lcom/google/firebase/auth/api/internal/zzdb;

    iget-object v1, v1, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v1, v1, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdg;->zzja:Lcom/google/firebase/auth/api/internal/zzdh;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzdg;->zzjb:Lcom/google/firebase/auth/api/internal/zzdb;

    iget-object v2, v2, Lcom/google/firebase/auth/api/internal/zzdb;->zziw:Lcom/google/firebase/auth/api/internal/zzcy;

    iget-object v2, v2, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    const/4 v3, 0x0

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v1, v2, v3}, Lcom/google/firebase/auth/api/internal/zzdh;->zza(Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;[Ljava/lang/Object;)V

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
