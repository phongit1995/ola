.class public abstract Lcom/google/firebase/auth/api/internal/zzah;
.super Ljava/lang/Object;


# static fields
.field private static zzdx:Lcom/google/android/gms/common/logging/Logger;


# instance fields
.field private zzgj:Lcom/google/firebase/auth/api/internal/zzai;
    .annotation build Landroid/support/annotation/GuardedBy;
        value = "this"
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "BiChannelGoogleApi"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "FirebaseAuth: "

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/common/logging/Logger;-><init>(Ljava/lang/String;[Ljava/lang/String;)V

    sput-object v0, Lcom/google/firebase/auth/api/internal/zzah;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final zzc(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/common/api/GoogleApi;
    .locals 5

    invoke-direct {p0}, Lcom/google/firebase/auth/api/internal/zzah;->zzx()Lcom/google/firebase/auth/api/internal/zzai;

    move-result-object v0

    iget-object v1, v0, Lcom/google/firebase/auth/api/internal/zzai;->zzgm:Lcom/google/firebase/auth/api/internal/zzan;

    invoke-interface {v1, p1}, Lcom/google/firebase/auth/api/internal/zzan;->zzd(Lcom/google/firebase/auth/api/internal/zzam;)Z

    move-result p1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    sget-object p1, Lcom/google/firebase/auth/api/internal/zzah;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    iget-object v2, v0, Lcom/google/firebase/auth/api/internal/zzai;->zzgl:Lcom/google/android/gms/common/api/GoogleApi;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x2b

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v3, "getGoogleApiForMethod() returned Fallback: "

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p1, v2, v1}, Lcom/google/android/gms/common/logging/Logger;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, v0, Lcom/google/firebase/auth/api/internal/zzai;->zzgl:Lcom/google/android/gms/common/api/GoogleApi;

    return-object p1

    :cond_0
    sget-object p1, Lcom/google/firebase/auth/api/internal/zzah;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    iget-object v2, v0, Lcom/google/firebase/auth/api/internal/zzai;->zzgk:Lcom/google/android/gms/common/api/GoogleApi;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x26

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v3, "getGoogleApiForMethod() returned Gms: "

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p1, v2, v1}, Lcom/google/android/gms/common/logging/Logger;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, v0, Lcom/google/firebase/auth/api/internal/zzai;->zzgk:Lcom/google/android/gms/common/api/GoogleApi;

    return-object p1
.end method

.method private final zzx()Lcom/google/firebase/auth/api/internal/zzai;
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzah;->zzgj:Lcom/google/firebase/auth/api/internal/zzai;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/google/firebase/auth/api/internal/zzah;->zzw()Lcom/google/firebase/auth/api/internal/zzai;

    move-result-object v0

    iput-object v0, p0, Lcom/google/firebase/auth/api/internal/zzah;->zzgj:Lcom/google/firebase/auth/api/internal/zzai;

    :cond_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzah;->zzgj:Lcom/google/firebase/auth/api/internal/zzai;

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method


# virtual methods
.method public final zza(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TResult:",
            "Ljava/lang/Object;",
            "A::",
            "Lcom/google/android/gms/common/api/Api$AnyClient;",
            ">(",
            "Lcom/google/firebase/auth/api/internal/zzam<",
            "TA;TTResult;>;)",
            "Lcom/google/android/gms/tasks/Task<",
            "TTResult;>;"
        }
    .end annotation

    invoke-direct {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzc(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/common/api/GoogleApi;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance p1, Lcom/google/android/gms/common/api/Status;

    const/16 v0, 0x445b

    const-string v1, "Unable to connect to GoogleApi instance - Google Play Services may be unavailable"

    invoke-direct {p1, v0, v1}, Lcom/google/android/gms/common/api/Status;-><init>(ILjava/lang/String;)V

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;)Lcom/google/firebase/FirebaseException;

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forException(Ljava/lang/Exception;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/google/android/gms/common/api/GoogleApi;->doRead(Lcom/google/android/gms/common/api/internal/TaskApiCall;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TResult:",
            "Ljava/lang/Object;",
            "A::",
            "Lcom/google/android/gms/common/api/Api$AnyClient;",
            ">(",
            "Lcom/google/firebase/auth/api/internal/zzam<",
            "TA;TTResult;>;)",
            "Lcom/google/android/gms/tasks/Task<",
            "TTResult;>;"
        }
    .end annotation

    invoke-direct {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzc(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/common/api/GoogleApi;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance p1, Lcom/google/android/gms/common/api/Status;

    const/16 v0, 0x445b

    const-string v1, "Unable to connect to GoogleApi instance - Google Play Services may be unavailable"

    invoke-direct {p1, v0, v1}, Lcom/google/android/gms/common/api/Status;-><init>(ILjava/lang/String;)V

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;)Lcom/google/firebase/FirebaseException;

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forException(Ljava/lang/Exception;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/google/android/gms/common/api/GoogleApi;->doWrite(Lcom/google/android/gms/common/api/internal/TaskApiCall;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method abstract zzw()Lcom/google/firebase/auth/api/internal/zzai;
.end method
