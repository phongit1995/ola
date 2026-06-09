.class final Lcom/google/android/gms/internal/firebase_auth/zzbz;
.super Ljava/lang/Object;


# instance fields
.field private final buffer:[B

.field private final zzmo:Lcom/google/android/gms/internal/firebase_auth/zzci;


# direct methods
.method private constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-array p1, p1, [B

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbz;->buffer:[B

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbz;->buffer:[B

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb([B)Lcom/google/android/gms/internal/firebase_auth/zzci;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbz;->zzmo:Lcom/google/android/gms/internal/firebase_auth/zzci;

    return-void
.end method

.method synthetic constructor <init>(ILcom/google/android/gms/internal/firebase_auth/zzbv;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzbz;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final zzca()Lcom/google/android/gms/internal/firebase_auth/zzbu;
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbz;->zzmo:Lcom/google/android/gms/internal/firebase_auth/zzci;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzdc()I

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Did not write as much data as expected."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcb;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbz;->buffer:[B

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcb;-><init>([B)V

    return-object v0
.end method

.method public final zzcb()Lcom/google/android/gms/internal/firebase_auth/zzci;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbz;->zzmo:Lcom/google/android/gms/internal/firebase_auth/zzci;

    return-object v0
.end method
