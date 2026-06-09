.class public Lcom/google/android/gms/internal/firebase_auth/zzdo;
.super Ljava/lang/Object;


# static fields
.field private static final zzmc:Lcom/google/android/gms/internal/firebase_auth/zzco;


# instance fields
.field private zzsn:Lcom/google/android/gms/internal/firebase_auth/zzbu;

.field private volatile zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

.field private volatile zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzco;->zzdk()Lcom/google/android/gms/internal/firebase_auth/zzco;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzmc:Lcom/google/android/gms/internal/firebase_auth/zzco;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final zzh(Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzeh;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    if-nez v0, :cond_1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    if-eqz v0, :cond_0

    :goto_0
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :cond_0
    :try_start_1
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmi:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;
    :try_end_1
    .catch Lcom/google/android/gms/internal/firebase_auth/zzdh; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    :try_start_2
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmi:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p1

    :cond_1
    :goto_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    return-object p1
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 2

    if-ne p0, p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdo;

    if-nez v0, :cond_1

    const/4 p1, 0x0

    return p1

    :cond_1
    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdo;

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    iget-object v1, p1, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    if-nez v0, :cond_2

    if-nez v1, :cond_2

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzbo()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object v0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzbo()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_2
    if-eqz v0, :cond_3

    if-eqz v1, :cond_3

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_3
    if-eqz v0, :cond_4

    invoke-interface {v0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzeb()Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object v1

    invoke-direct {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzh(Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_4
    invoke-interface {v1}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzeb()Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzh(Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public hashCode()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public final zzbo()Lcom/google/android/gms/internal/firebase_auth/zzbu;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    return-object v0

    :cond_0
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    monitor-exit p0

    return-object v0

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    if-nez v0, :cond_2

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmi:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    :goto_0
    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    invoke-interface {v0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzbo()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object v0

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public final zzdq()I
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result v0

    return v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    invoke-interface {v0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzdq()I

    move-result v0

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public final zzi(Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzeh;
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsn:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    iput-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzsp:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzso:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    return-object v0
.end method
