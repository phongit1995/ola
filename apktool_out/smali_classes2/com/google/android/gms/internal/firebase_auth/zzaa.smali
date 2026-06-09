.class public final Lcom/google/android/gms/internal/firebase_auth/zzaa;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdp;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdp<",
        "Lcom/google/android/gms/internal/firebase_auth/zzj;",
        ">;"
    }
.end annotation


# static fields
.field private static final zzdx:Lcom/google/android/gms/common/logging/Logger;


# instance fields
.field private final zzaf:Ljava/lang/String;

.field private final zzah:Ljava/lang/String;

.field private final zzdy:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "EmailLinkSignInRequest"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/common/logging/Logger;-><init>(Ljava/lang/String;[Ljava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    return-void
.end method

.method public constructor <init>(Lcom/google/firebase/auth/EmailAuthCredential;Ljava/lang/String;)V
    .locals 1
    .param p1    # Lcom/google/firebase/auth/EmailAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Lcom/google/firebase/auth/EmailAuthCredential;->getEmail()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzah:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/google/firebase/auth/EmailAuthCredential;->zzg()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzdy:Ljava/lang/String;

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzaf:Ljava/lang/String;

    return-void
.end method

.method private static zzi(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    invoke-static {p0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p0

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v1

    const-string v2, "oobCode"

    invoke-interface {v1, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v1, "oobCode"

    invoke-virtual {p0, v1}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const-string v2, "link"

    invoke-interface {v1, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "link"

    invoke-virtual {p0, v1}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p0

    const-string v1, "oobCode"

    invoke-virtual {p0, v1}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/UnsupportedOperationException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :cond_1
    return-object v0

    :catch_0
    move-exception p0

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v2, "EmailLinkSignInRequest"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "No oobCode in signInLink: "

    invoke-virtual {p0}, Ljava/lang/UnsupportedOperationException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v6

    if-eqz v6, :cond_2

    invoke-virtual {v5, p0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_2
    new-instance p0, Ljava/lang/String;

    invoke-direct {p0, v5}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    :goto_0
    aput-object p0, v3, v4

    invoke-virtual {v1, v2, v3}, Lcom/google/android/gms/common/logging/Logger;->v(Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v0
.end method


# virtual methods
.method public final synthetic zzao()Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzj;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzj;-><init>()V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzah:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzj;->zzah:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzdy:Ljava/lang/String;

    invoke-static {v1}, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzi(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzj;->zzag:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaa;->zzaf:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzj;->zzaf:Ljava/lang/String;

    return-object v0
.end method
