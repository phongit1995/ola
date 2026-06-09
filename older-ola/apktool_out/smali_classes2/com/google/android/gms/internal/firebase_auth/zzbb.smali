.class public final Lcom/google/android/gms/internal/firebase_auth/zzbb;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdp;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdp<",
        "Lcom/google/android/gms/internal/firebase_auth/zzp;",
        ">;"
    }
.end annotation


# instance fields
.field private zzah:Ljava/lang/String;

.field private zzbh:Ljava/lang/String;

.field private zzbi:Ljava/lang/String;

.field private zzbt:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzbt:Z

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzah:Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzbi:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzbh:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzbt:Z

    return-void
.end method


# virtual methods
.method public final synthetic zzao()Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzp;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzp;-><init>()V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzah:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzp;->zzah:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbb;->zzbi:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzp;->zzbi:Ljava/lang/String;

    const/4 v1, 0x0

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzp;->zzbh:Ljava/lang/String;

    return-object v0
.end method
