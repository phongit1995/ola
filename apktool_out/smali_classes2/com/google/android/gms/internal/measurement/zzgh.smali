.class public final Lcom/google/android/gms/internal/measurement/zzgh;
.super Lcom/google/android/gms/internal/measurement/zzjs;

# interfaces
.implements Lcom/google/android/gms/internal/measurement/zzej;


# static fields
.field private static zzane:I = 0xffff
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation
.end field

.field private static zzanf:I = 0x2
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation
.end field


# instance fields
.field private final zzang:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private final zzanh:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation
.end field

.field private final zzani:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation
.end field

.field private final zzanj:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/google/android/gms/internal/measurement/zzkn;",
            ">;"
        }
    .end annotation
.end field

.field private final zzank:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;>;"
        }
    .end annotation
.end field

.field private final zzanl:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method constructor <init>(Lcom/google/android/gms/internal/measurement/zzjt;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/measurement/zzjs;-><init>(Lcom/google/android/gms/internal/measurement/zzjt;)V

    new-instance p1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {p1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzang:Ljava/util/Map;

    new-instance p1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {p1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanh:Ljava/util/Map;

    new-instance p1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {p1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzani:Ljava/util/Map;

    new-instance p1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {p1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    new-instance p1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {p1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanl:Ljava/util/Map;

    new-instance p1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {p1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzank:Ljava/util/Map;

    return-void
.end method

.method private final zza(Ljava/lang/String;[B)Lcom/google/android/gms/internal/measurement/zzkn;
    .locals 4
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    if-nez p2, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/measurement/zzkn;

    invoke-direct {p1}, Lcom/google/android/gms/internal/measurement/zzkn;-><init>()V

    return-object p1

    :cond_0
    const/4 v0, 0x0

    array-length v1, p2

    invoke-static {p2, v0, v1}, Lcom/google/android/gms/internal/measurement/zzaca;->zza([BII)Lcom/google/android/gms/internal/measurement/zzaca;

    move-result-object p2

    new-instance v0, Lcom/google/android/gms/internal/measurement/zzkn;

    invoke-direct {v0}, Lcom/google/android/gms/internal/measurement/zzkn;-><init>()V

    :try_start_0
    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/measurement/zzacj;->zzb(Lcom/google/android/gms/internal/measurement/zzaca;)Lcom/google/android/gms/internal/measurement/zzacj;

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object p2

    invoke-virtual {p2}, Lcom/google/android/gms/internal/measurement/zzfi;->zzjc()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object p2

    const-string v1, "Parsed config. version, gmp_app_id"

    iget-object v2, v0, Lcom/google/android/gms/internal/measurement/zzkn;->zzaum:Ljava/lang/Long;

    iget-object v3, v0, Lcom/google/android/gms/internal/measurement/zzkn;->zzafa:Ljava/lang/String;

    invoke-virtual {p2, v1, v2, v3}, Lcom/google/android/gms/internal/measurement/zzfk;->zze(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p2

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/measurement/zzfi;->zziy()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object v0

    const-string v1, "Unable to merge remote config. appId"

    invoke-static {p1}, Lcom/google/android/gms/internal/measurement/zzfi;->zzbp(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, v1, p1, p2}, Lcom/google/android/gms/internal/measurement/zzfk;->zze(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    new-instance p1, Lcom/google/android/gms/internal/measurement/zzkn;

    invoke-direct {p1}, Lcom/google/android/gms/internal/measurement/zzkn;-><init>()V

    return-object p1
.end method

.method private static zza(Lcom/google/android/gms/internal/measurement/zzkn;)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/internal/measurement/zzkn;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    if-eqz p0, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkn;->zzauo:[Lcom/google/android/gms/internal/measurement/zzko;

    if-eqz v1, :cond_1

    iget-object p0, p0, Lcom/google/android/gms/internal/measurement/zzkn;->zzauo:[Lcom/google/android/gms/internal/measurement/zzko;

    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p0, v2

    if-eqz v3, :cond_0

    iget-object v4, v3, Lcom/google/android/gms/internal/measurement/zzko;->zzny:Ljava/lang/String;

    iget-object v3, v3, Lcom/google/android/gms/internal/measurement/zzko;->value:Ljava/lang/String;

    invoke-interface {v0, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private final zza(Ljava/lang/String;Lcom/google/android/gms/internal/measurement/zzkn;)V
    .locals 9

    new-instance v0, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v0}, Landroid/support/v4/util/ArrayMap;-><init>()V

    new-instance v1, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v1}, Landroid/support/v4/util/ArrayMap;-><init>()V

    new-instance v2, Landroid/support/v4/util/ArrayMap;

    invoke-direct {v2}, Landroid/support/v4/util/ArrayMap;-><init>()V

    if-eqz p2, :cond_5

    iget-object v3, p2, Lcom/google/android/gms/internal/measurement/zzkn;->zzaup:[Lcom/google/android/gms/internal/measurement/zzkm;

    if-eqz v3, :cond_5

    iget-object p2, p2, Lcom/google/android/gms/internal/measurement/zzkn;->zzaup:[Lcom/google/android/gms/internal/measurement/zzkm;

    array-length v3, p2

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_5

    aget-object v5, p2, v4

    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object v5

    invoke-virtual {v5}, Lcom/google/android/gms/internal/measurement/zzfi;->zziy()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object v5

    const-string v6, "EventConfig contained null event name"

    invoke-virtual {v5, v6}, Lcom/google/android/gms/internal/measurement/zzfk;->log(Ljava/lang/String;)V

    goto :goto_2

    :cond_0
    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    invoke-static {v6}, Lcom/google/android/gms/measurement/AppMeasurement$Event;->zzal(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_1

    iput-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    :cond_1
    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    iget-object v7, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzauj:Ljava/lang/Boolean;

    invoke-interface {v0, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    iget-object v7, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzauk:Ljava/lang/Boolean;

    invoke-interface {v1, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzaul:Ljava/lang/Integer;

    if-eqz v6, :cond_4

    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzaul:Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    sget v7, Lcom/google/android/gms/internal/measurement/zzgh;->zzanf:I

    if-lt v6, v7, :cond_3

    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzaul:Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    sget v7, Lcom/google/android/gms/internal/measurement/zzgh;->zzane:I

    if-le v6, v7, :cond_2

    goto :goto_1

    :cond_2
    iget-object v6, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    iget-object v5, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzaul:Ljava/lang/Integer;

    invoke-interface {v2, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_3
    :goto_1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/android/gms/internal/measurement/zzfi;->zziy()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object v6

    const-string v7, "Invalid sampling rate. Event name, sample rate"

    iget-object v8, v5, Lcom/google/android/gms/internal/measurement/zzkm;->name:Ljava/lang/String;

    iget-object v5, v5, Lcom/google/android/gms/internal/measurement/zzkm;->zzaul:Ljava/lang/Integer;

    invoke-virtual {v6, v7, v8, v5}, Lcom/google/android/gms/internal/measurement/zzfk;->zze(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    :cond_4
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    iget-object p2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanh:Ljava/util/Map;

    invoke-interface {p2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzani:Ljava/util/Map;

    invoke-interface {p2, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzank:Ljava/util/Map;

    invoke-interface {p2, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private final zzbw(Ljava/lang/String;)V
    .locals 4
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzch()V

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzjr;->zzjh()Lcom/google/android/gms/internal/measurement/zzek;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/measurement/zzek;->zzbh(Ljava/lang/String;)[B

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzang:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanh:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzani:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanl:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzank:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_0
    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/measurement/zzgh;->zza(Ljava/lang/String;[B)Lcom/google/android/gms/internal/measurement/zzkn;

    move-result-object v0

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzang:Ljava/util/Map;

    invoke-static {v0}, Lcom/google/android/gms/internal/measurement/zzgh;->zza(Lcom/google/android/gms/internal/measurement/zzkn;)Ljava/util/Map;

    move-result-object v3

    invoke-interface {v2, p1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/measurement/zzgh;->zza(Ljava/lang/String;Lcom/google/android/gms/internal/measurement/zzkn;)V

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanl:Ljava/util/Map;

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    return-void
.end method


# virtual methods
.method public final bridge synthetic getContext()Landroid/content/Context;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->getContext()Landroid/content/Context;

    move-result-object v0

    return-object v0
.end method

.method protected final zza(Ljava/lang/String;[BLjava/lang/String;)Z
    .locals 6
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzch()V

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/internal/measurement/zzgh;->zza(Ljava/lang/String;[B)Lcom/google/android/gms/internal/measurement/zzkn;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/measurement/zzgh;->zza(Ljava/lang/String;Lcom/google/android/gms/internal/measurement/zzkn;)V

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanl:Ljava/util/Map;

    invoke-interface {v2, p1, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzang:Ljava/util/Map;

    invoke-static {v0}, Lcom/google/android/gms/internal/measurement/zzgh;->zza(Lcom/google/android/gms/internal/measurement/zzkn;)Ljava/util/Map;

    move-result-object v2

    invoke-interface {p3, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzjr;->zzjg()Lcom/google/android/gms/internal/measurement/zzed;

    move-result-object p3

    iget-object v2, v0, Lcom/google/android/gms/internal/measurement/zzkn;->zzauq:[Lcom/google/android/gms/internal/measurement/zzkg;

    invoke-virtual {p3, p1, v2}, Lcom/google/android/gms/internal/measurement/zzed;->zza(Ljava/lang/String;[Lcom/google/android/gms/internal/measurement/zzkg;)V

    const/4 p3, 0x0

    :try_start_0
    iput-object p3, v0, Lcom/google/android/gms/internal/measurement/zzkn;->zzauq:[Lcom/google/android/gms/internal/measurement/zzkg;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/measurement/zzacj;->zzwb()I

    move-result p3

    new-array p3, p3, [B

    array-length v2, p3

    invoke-static {p3, v1, v2}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb([BII)Lcom/google/android/gms/internal/measurement/zzacb;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/measurement/zzacj;->zza(Lcom/google/android/gms/internal/measurement/zzacb;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-object p2, p3

    goto :goto_0

    :catch_0
    move-exception p3

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/measurement/zzfi;->zziy()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object v0

    const-string v2, "Unable to serialize reduced-size config. Storing full config instead. appId"

    invoke-static {p1}, Lcom/google/android/gms/internal/measurement/zzfi;->zzbp(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v2, v3, p3}, Lcom/google/android/gms/internal/measurement/zzfk;->zze(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    :goto_0
    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzjr;->zzjh()Lcom/google/android/gms/internal/measurement/zzek;

    move-result-object p3

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-virtual {p3}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-virtual {p3}, Lcom/google/android/gms/internal/measurement/zzjs;->zzch()V

    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    const-string v2, "remote_config"

    invoke-virtual {v0, v2, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;[B)V

    const/4 p2, 0x1

    :try_start_1
    invoke-virtual {p3}, Lcom/google/android/gms/internal/measurement/zzek;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    const-string v3, "apps"

    const-string v4, "app_id = ?"

    new-array v5, p2, [Ljava/lang/String;

    aput-object p1, v5, v1

    invoke-virtual {v2, v3, v0, v4, v5}, Landroid/database/sqlite/SQLiteDatabase;->update(Ljava/lang/String;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    int-to-long v0, v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-nez v4, :cond_1

    invoke-virtual {p3}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/measurement/zzfi;->zziv()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object v0

    const-string v1, "Failed to update remote config (got 0). appId"

    invoke-static {p1}, Lcom/google/android/gms/internal/measurement/zzfi;->zzbp(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/internal/measurement/zzfk;->zzg(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_1
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_1 .. :try_end_1} :catch_1

    return p2

    :catch_1
    move-exception v0

    invoke-virtual {p3}, Lcom/google/android/gms/internal/measurement/zzhi;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object p3

    invoke-virtual {p3}, Lcom/google/android/gms/internal/measurement/zzfi;->zziv()Lcom/google/android/gms/internal/measurement/zzfk;

    move-result-object p3

    const-string v1, "Error storing remote config. appId"

    invoke-static {p1}, Lcom/google/android/gms/internal/measurement/zzfi;->zzbp(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p3, v1, p1, v0}, Lcom/google/android/gms/internal/measurement/zzfk;->zze(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    :cond_1
    return p2
.end method

.method public final bridge synthetic zzab()V
    .locals 0

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzab()V

    return-void
.end method

.method public final bridge synthetic zzbt()Lcom/google/android/gms/common/util/Clock;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzbt()Lcom/google/android/gms/common/util/Clock;

    move-result-object v0

    return-object v0
.end method

.method protected final zzbx(Ljava/lang/String;)Lcom/google/android/gms/internal/measurement/zzkn;
    .locals 1
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzch()V

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzbw(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/measurement/zzkn;

    return-object p1
.end method

.method protected final zzby(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanl:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    return-object p1
.end method

.method protected final zzbz(Ljava/lang/String;)V
    .locals 2
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanl:Ljava/util/Map;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method final zzca(Ljava/lang/String;)V
    .locals 1
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method final zzcb(Ljava/lang/String;)Z
    .locals 2

    const-string v0, "1"

    const-string v1, "measurement.upload.blacklist_internal"

    invoke-virtual {p0, p1, v1}, Lcom/google/android/gms/internal/measurement/zzgh;->zze(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method final zzcc(Ljava/lang/String;)Z
    .locals 2

    const-string v0, "1"

    const-string v1, "measurement.upload.blacklist_public"

    invoke-virtual {p0, p1, v1}, Lcom/google/android/gms/internal/measurement/zzgh;->zze(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final zze(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzbw(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzang:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Map;

    if-eqz p1, :cond_0

    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public final bridge synthetic zzfu()V
    .locals 0

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzfu()V

    return-void
.end method

.method public final bridge synthetic zzfv()V
    .locals 0

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzfv()V

    return-void
.end method

.method public final bridge synthetic zzfw()V
    .locals 0

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzfw()V

    return-void
.end method

.method public final bridge synthetic zzge()Lcom/google/android/gms/internal/measurement/zzer;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzge()Lcom/google/android/gms/internal/measurement/zzer;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgf()Lcom/google/android/gms/internal/measurement/zzfg;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgf()Lcom/google/android/gms/internal/measurement/zzfg;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgg()Lcom/google/android/gms/internal/measurement/zzkd;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgg()Lcom/google/android/gms/internal/measurement/zzkd;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgh()Lcom/google/android/gms/internal/measurement/zzgi;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgh()Lcom/google/android/gms/internal/measurement/zzgi;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgi()Lcom/google/android/gms/internal/measurement/zzfi;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgi()Lcom/google/android/gms/internal/measurement/zzfi;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgj()Lcom/google/android/gms/internal/measurement/zzft;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgj()Lcom/google/android/gms/internal/measurement/zzft;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgk()Lcom/google/android/gms/internal/measurement/zzeh;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgk()Lcom/google/android/gms/internal/measurement/zzeh;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzgl()Lcom/google/android/gms/internal/measurement/zzee;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzgl()Lcom/google/android/gms/internal/measurement/zzee;

    move-result-object v0

    return-object v0
.end method

.method protected final zzgn()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public final bridge synthetic zzjf()Lcom/google/android/gms/internal/measurement/zzjz;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzjf()Lcom/google/android/gms/internal/measurement/zzjz;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzjg()Lcom/google/android/gms/internal/measurement/zzed;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzjg()Lcom/google/android/gms/internal/measurement/zzed;

    move-result-object v0

    return-object v0
.end method

.method public final bridge synthetic zzjh()Lcom/google/android/gms/internal/measurement/zzek;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzjs;->zzjh()Lcom/google/android/gms/internal/measurement/zzek;

    move-result-object v0

    return-object v0
.end method

.method final zzn(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzbw(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzcb(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-static {p2}, Lcom/google/android/gms/internal/measurement/zzkd;->zzcm(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzcc(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p2}, Lcom/google/android/gms/internal/measurement/zzkd;->zzcg(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return v1

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzanh:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Map;

    const/4 v0, 0x0

    if-eqz p1, :cond_3

    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    if-nez p1, :cond_2

    return v0

    :cond_2
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1

    :cond_3
    return v0
.end method

.method final zzo(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzbw(Ljava/lang/String;)V

    const-string v0, "ecommerce_purchase"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzani:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Map;

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    if-nez p1, :cond_1

    return v0

    :cond_1
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1

    :cond_2
    return v0
.end method

.method final zzp(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .annotation build Landroid/support/annotation/WorkerThread;
    .end annotation

    invoke-virtual {p0}, Lcom/google/android/gms/internal/measurement/zzhi;->zzab()V

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/measurement/zzgh;->zzbw(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzgh;->zzank:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Map;

    const/4 v0, 0x1

    if-eqz p1, :cond_1

    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    if-nez p1, :cond_0

    return v0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1

    :cond_1
    return v0
.end method
