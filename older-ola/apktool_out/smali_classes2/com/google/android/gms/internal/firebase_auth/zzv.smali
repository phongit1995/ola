.class public Lcom/google/android/gms/internal/firebase_auth/zzv;
.super Ljava/lang/RuntimeException;


# instance fields
.field private zzfi:Lcom/google/android/gms/internal/firebase_auth/zzad;


# direct methods
.method public constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzad;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/RuntimeException;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzad;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzv;->zzfi:Lcom/google/android/gms/internal/firebase_auth/zzad;

    return-void
.end method

.method public constructor <init>(Ljava/lang/Throwable;)V
    .locals 0

    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    return-void
.end method


# virtual methods
.method public final getErrorMessage()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzv;->zzfi:Lcom/google/android/gms/internal/firebase_auth/zzad;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzv;->zzfi:Lcom/google/android/gms/internal/firebase_auth/zzad;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzad;->zzar()Lcom/google/android/gms/internal/firebase_auth/zzac;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzac;->getErrorMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzv;->getMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
