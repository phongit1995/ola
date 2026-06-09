.class public Lcom/google/android/gms/internal/firebase_auth/zzco;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/internal/firebase_auth/zzco$zza;
    }
.end annotation


# static fields
.field private static volatile zznt:Z = false

.field private static final zznu:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static volatile zznv:Lcom/google/android/gms/internal/firebase_auth/zzco;

.field static final zznw:Lcom/google/android/gms/internal/firebase_auth/zzco;


# instance fields
.field private final zznx:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/google/android/gms/internal/firebase_auth/zzco$zza;",
            "Lcom/google/android/gms/internal/firebase_auth/zzdb$zzd<",
            "**>;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzco;->zzdj()Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznu:Ljava/lang/Class;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzco;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzco;-><init>(Z)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznw:Lcom/google/android/gms/internal/firebase_auth/zzco;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznx:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznx:Ljava/util/Map;

    return-void
.end method

.method static zzdi()Lcom/google/android/gms/internal/firebase_auth/zzco;
    .locals 1

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzco;

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcz;->zza(Ljava/lang/Class;)Lcom/google/android/gms/internal/firebase_auth/zzco;

    move-result-object v0

    return-object v0
.end method

.method private static zzdj()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    :try_start_0
    const-string v0, "com.google.protobuf.Extension"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static zzdk()Lcom/google/android/gms/internal/firebase_auth/zzco;
    .locals 1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcn;->zzdh()Lcom/google/android/gms/internal/firebase_auth/zzco;

    move-result-object v0

    return-object v0
.end method

.method public static zzdl()Lcom/google/android/gms/internal/firebase_auth/zzco;
    .locals 2

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznv:Lcom/google/android/gms/internal/firebase_auth/zzco;

    if-nez v0, :cond_1

    const-class v1, Lcom/google/android/gms/internal/firebase_auth/zzco;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznv:Lcom/google/android/gms/internal/firebase_auth/zzco;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcn;->zzdi()Lcom/google/android/gms/internal/firebase_auth/zzco;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznv:Lcom/google/android/gms/internal/firebase_auth/zzco;

    :cond_0
    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_1
    return-object v0
.end method


# virtual methods
.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzeh;I)Lcom/google/android/gms/internal/firebase_auth/zzdb$zzd;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<ContainingType::",
            "Lcom/google/android/gms/internal/firebase_auth/zzeh;",
            ">(TContainingType;I)",
            "Lcom/google/android/gms/internal/firebase_auth/zzdb$zzd<",
            "TContainingType;*>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzco;->zznx:Ljava/util/Map;

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzco$zza;

    invoke-direct {v1, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzco$zza;-><init>(Ljava/lang/Object;I)V

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zzd;

    return-object p1
.end method
