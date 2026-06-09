.class final Lcom/google/android/gms/internal/firebase_auth/zzfb;
.super Lcom/google/android/gms/internal/firebase_auth/zzfh;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzfh;"
    }
.end annotation


# instance fields
.field private final synthetic zzur:Lcom/google/android/gms/internal/firebase_auth/zzey;


# direct methods
.method private constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzey;)V
    .locals 1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfb;->zzur:Lcom/google/android/gms/internal/firebase_auth/zzey;

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzfh;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzey;Lcom/google/android/gms/internal/firebase_auth/zzez;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzey;Lcom/google/android/gms/internal/firebase_auth/zzez;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfb;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzey;)V

    return-void
.end method


# virtual methods
.method public final iterator()Ljava/util/Iterator;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "Ljava/util/Map$Entry<",
            "TK;TV;>;>;"
        }
    .end annotation

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfa;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzfb;->zzur:Lcom/google/android/gms/internal/firebase_auth/zzey;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfa;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzey;Lcom/google/android/gms/internal/firebase_auth/zzez;)V

    return-object v0
.end method
