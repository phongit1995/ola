.class abstract Lcom/facebook/accountkit/internal/NativeAppInfo;
.super Ljava/lang/Object;


# static fields
.field private static final FBI_HASH:Ljava/lang/String; = "a4b7452e2ed8f5f191058ca7bbfd26b0d3214bfc"

.field private static final FBL2_HASH:Ljava/lang/String; = "df6b721c8b4d3b6eb44c861d4415007e5a35fc95"

.field private static final FBL_HASH:Ljava/lang/String; = "5e8f16062ea3cd2c4a0d547876baa6f38cabf625"

.field private static final FBR2_HASH:Ljava/lang/String; = "cc2751449a350f668590264ed76692694a80308a"

.field private static final FBR_HASH:Ljava/lang/String; = "8a3c4b262d721acd49a4bf97d5213199c86fa2b9"

.field private static final TAG:Ljava/lang/String; = "NativeAppInfo"

.field private static final validAppSignatureHashes:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private appInstalled:Z

.field private availableVersions:Ljava/util/TreeSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/TreeSet<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/NativeAppInfo;->buildAppSignatureHashes()Ljava/util/HashSet;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/NativeAppInfo;->validAppSignatureHashes:Ljava/util/HashSet;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static buildAppSignatureHashes()Ljava/util/HashSet;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashSet<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    const-string v1, "8a3c4b262d721acd49a4bf97d5213199c86fa2b9"

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    const-string v1, "cc2751449a350f668590264ed76692694a80308a"

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    const-string v1, "a4b7452e2ed8f5f191058ca7bbfd26b0d3214bfc"

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    const-string v1, "5e8f16062ea3cd2c4a0d547876baa6f38cabf625"

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    const-string v1, "df6b721c8b4d3b6eb44c861d4415007e5a35fc95"

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    return-object v0
.end method


# virtual methods
.method public declared-synchronized fetchAvailableVersions(Z)V
    .locals 9

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->availableVersions:Ljava/util/TreeSet;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v0, :cond_0

    if-nez p1, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    new-instance p1, Ljava/util/TreeSet;

    invoke-direct {p1}, Ljava/util/TreeSet;-><init>()V

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const/4 v0, 0x1

    new-array v3, v0, [Ljava/lang/String;

    const-string v2, "version"

    const/4 v4, 0x0

    aput-object v2, v3, v4

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "content://"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/NativeAppInfo;->getPackage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ".provider.PlatformProvider/versions"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const/4 v7, 0x0

    :try_start_2
    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/NativeAppInfo;->getPackage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, ".provider.PlatformProvider"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-virtual {v5, v6, v4}, Landroid/content/pm/PackageManager;->resolveContentProvider(Ljava/lang/String;I)Landroid/content/pm/ProviderInfo;

    move-result-object v4
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v4

    :try_start_4
    sget-object v5, Lcom/facebook/accountkit/internal/NativeAppInfo;->TAG:Ljava/lang/String;

    const-string v6, "Failed to query content resolver."

    invoke-static {v5, v6, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-object v4, v7

    :goto_0
    if-eqz v4, :cond_1

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    :try_start_5
    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1
    :try_end_5
    .catch Ljava/lang/NullPointerException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-object v7, v1

    goto :goto_1

    :catch_1
    :try_start_6
    sget-object v1, Lcom/facebook/accountkit/internal/NativeAppInfo;->TAG:Ljava/lang/String;

    const-string v2, "Failed to query content resolver."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    if-eqz v7, :cond_1

    :goto_2
    invoke-interface {v7}, Landroid/database/Cursor;->moveToNext()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "version"

    invoke-interface {v7, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v7, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_2

    :cond_1
    if-eqz v7, :cond_2

    :try_start_7
    iput-boolean v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->appInstalled:Z

    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_2
    iput-object p1, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->availableVersions:Ljava/util/TreeSet;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    if-eqz v7, :cond_3

    :try_start_8
    iput-boolean v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->appInstalled:Z

    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_3
    throw p1
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    :catchall_1
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public getAvailableVersions()Ljava/util/TreeSet;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/TreeSet<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->availableVersions:Ljava/util/TreeSet;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/internal/NativeAppInfo;->fetchAvailableVersions(Z)V

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->availableVersions:Ljava/util/TreeSet;

    return-object v0
.end method

.method protected abstract getPackage()Ljava/lang/String;
.end method

.method protected abstract getPlatformServiceIntent()Landroid/content/Intent;
.end method

.method public isAppInstalled()Z
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->availableVersions:Ljava/util/TreeSet;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/internal/NativeAppInfo;->fetchAvailableVersions(Z)V

    :cond_0
    iget-boolean v0, p0, Lcom/facebook/accountkit/internal/NativeAppInfo;->appInstalled:Z

    return v0
.end method

.method public validateSignature(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 5

    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->flags:I

    const-string v2, "generic"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    and-int/lit8 v0, v1, 0x2

    if-eqz v0, :cond_0

    return v2

    :cond_0
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p1

    const/16 v1, 0x40

    invoke-virtual {p1, p2, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p1
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    iget-object p2, p1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    if-eqz p2, :cond_4

    iget-object p2, p1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    array-length p2, p2

    if-gtz p2, :cond_1

    return v0

    :cond_1
    iget-object p1, p1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    array-length p2, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p2, :cond_3

    aget-object v3, p1, v1

    invoke-virtual {v3}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v3

    invoke-static {v3}, Lcom/facebook/accountkit/internal/Utility;->sha1hash([B)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lcom/facebook/accountkit/internal/NativeAppInfo;->validAppSignatureHashes:Ljava/util/HashSet;

    invoke-virtual {v4, v3}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v0

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    return v2

    :catch_0
    :cond_4
    return v0
.end method
