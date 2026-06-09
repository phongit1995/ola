.class public final Lcom/google/firebase/auth/api/internal/zzcp;
.super Lcom/google/firebase/auth/api/internal/zzaj;

# interfaces
.implements Lcom/google/android/gms/common/api/Api$ApiOptions$HasOptions;


# instance fields
.field private final zzho:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Lcom/google/firebase/auth/api/internal/zzaj;-><init>()V

    const-string v0, "A valid API key must be provided"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcp;->zzho:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzco;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/firebase/auth/api/internal/zzcp;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final synthetic clone()Ljava/lang/Object;
    .locals 2

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzcq;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzcp;->zzho:Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/google/firebase/auth/api/internal/zzcq;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/google/firebase/auth/api/internal/zzcq;->zzah()Lcom/google/firebase/auth/api/internal/zzcp;

    move-result-object v0

    return-object v0
.end method

.method public final getApiKey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcp;->zzho:Ljava/lang/String;

    return-object v0
.end method

.method public final synthetic zzy()Lcom/google/firebase/auth/api/internal/zzaj;
    .locals 1

    invoke-virtual {p0}, Lcom/google/firebase/auth/api/internal/zzaj;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/api/internal/zzcp;

    return-object v0
.end method
