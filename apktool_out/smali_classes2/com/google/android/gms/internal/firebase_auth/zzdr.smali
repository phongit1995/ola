.class abstract Lcom/google/android/gms/internal/firebase_auth/zzdr;
.super Ljava/lang/Object;


# static fields
.field private static final zzst:Lcom/google/android/gms/internal/firebase_auth/zzdr;

.field private static final zzsu:Lcom/google/android/gms/internal/firebase_auth/zzdr;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzdt;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdt;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzds;)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzst:Lcom/google/android/gms/internal/firebase_auth/zzdr;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzdu;

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdu;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzds;)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzsu:Lcom/google/android/gms/internal/firebase_auth/zzdr;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzds;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzdr;-><init>()V

    return-void
.end method

.method static zzeq()Lcom/google/android/gms/internal/firebase_auth/zzdr;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzst:Lcom/google/android/gms/internal/firebase_auth/zzdr;

    return-object v0
.end method

.method static zzer()Lcom/google/android/gms/internal/firebase_auth/zzdr;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzsu:Lcom/google/android/gms/internal/firebase_auth/zzdr;

    return-object v0
.end method


# virtual methods
.method abstract zza(Ljava/lang/Object;J)Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<",
            "L:Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "J)",
            "Ljava/util/List<",
            "T",
            "L;",
            ">;"
        }
    .end annotation
.end method

.method abstract zza(Ljava/lang/Object;Ljava/lang/Object;J)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<",
            "L:Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "J)V"
        }
    .end annotation
.end method

.method abstract zzb(Ljava/lang/Object;J)V
.end method
