.class public Lcom/google/android/gms/internal/firebase_auth/zzad;
.super Ljava/lang/Object;


# instance fields
.field private zzji:Lcom/google/android/gms/internal/firebase_auth/zzac;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static zzk(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzad;
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzad;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzad;-><init>()V

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzac;->zzj(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzac;

    move-result-object p0

    iput-object p0, v0, Lcom/google/android/gms/internal/firebase_auth/zzad;->zzji:Lcom/google/android/gms/internal/firebase_auth/zzac;

    return-object v0
.end method


# virtual methods
.method public final zzar()Lcom/google/android/gms/internal/firebase_auth/zzac;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzad;->zzji:Lcom/google/android/gms/internal/firebase_auth/zzac;

    return-object v0
.end method
