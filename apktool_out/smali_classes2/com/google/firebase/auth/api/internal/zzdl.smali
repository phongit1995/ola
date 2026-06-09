.class public final Lcom/google/firebase/auth/api/internal/zzdl;
.super Ljava/lang/Object;


# instance fields
.field private final packageName:Ljava/lang/String;

.field private final zzjc:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zzdl;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdl;->packageName:Ljava/lang/String;

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzdl;->packageName:Ljava/lang/String;

    invoke-static {p1, v1}, Lcom/google/android/gms/common/util/AndroidUtilsLight;->getPackageCertificateHashBytes(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object p1
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p1, :cond_1

    const-string p1, "FBA-PackageInfo"

    const-string v1, "single cert required: "

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_0
    new-instance p2, Ljava/lang/String;

    invoke-direct {p2, v1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    :goto_0
    invoke-static {p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iput-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdl;->zzjc:Ljava/lang/String;

    return-void

    :cond_1
    const/4 p2, 0x0

    invoke-static {p1, p2}, Lcom/google/android/gms/common/util/Hex;->bytesToStringUppercase([BZ)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzdl;->zzjc:Ljava/lang/String;

    return-void

    :catch_0
    const-string p1, "FBA-PackageInfo"

    const-string v1, "no pkg: "

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v1, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_1

    :cond_2
    new-instance p2, Ljava/lang/String;

    invoke-direct {p2, v1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    :goto_1
    invoke-static {p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iput-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdl;->zzjc:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final getPackageName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdl;->packageName:Ljava/lang/String;

    return-object v0
.end method

.method public final zzan()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzdl;->zzjc:Ljava/lang/String;

    return-object v0
.end method
