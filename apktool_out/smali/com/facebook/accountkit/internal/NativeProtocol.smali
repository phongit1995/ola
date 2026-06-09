.class final Lcom/facebook/accountkit/internal/NativeProtocol;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/NativeProtocol$FBLiteAppInfo;,
        Lcom/facebook/accountkit/internal/NativeProtocol$WakizashiAppInfo;,
        Lcom/facebook/accountkit/internal/NativeProtocol$KatanaAppInfo;
    }
.end annotation


# static fields
.field static final CONTENT_SCHEME:Ljava/lang/String; = "content://"

.field static final EXTRA_APPLICATION_ID:Ljava/lang/String; = "com.facebook.platform.extra.APPLICATION_ID"

.field static final EXTRA_EXPIRES_SECONDS_SINCE_EPOCH:Ljava/lang/String; = "com.facebook.platform.extra.EXPIRES_SECONDS_SINCE_EPOCH"

.field static final EXTRA_SEAMLESS_LOGIN_TOKEN:Ljava/lang/String; = "com.facebook.platform.extra.SEAMLESS_LOGIN_TOKEN"

.field private static final INTENT_ACTION_FBLITE_PLATFORM_SERVICE:Ljava/lang/String; = "com.facebook.lite.platform.PLATFORM_SERVICE"

.field private static final INTENT_ACTION_PLATFORM_SERVICE:Ljava/lang/String; = "com.facebook.platform.PLATFORM_SERVICE"

.field static final MESSAGE_GET_AK_SEAMLESS_TOKEN_REPLY:I = 0x10009

.field static final MESSAGE_GET_AK_SEAMLESS_TOKEN_REQUEST:I = 0x10008

.field static final PLATFORM_PROVIDER:Ljava/lang/String; = ".provider.PlatformProvider"

.field static final PLATFORM_PROVIDER_VERSIONS:Ljava/lang/String; = ".provider.PlatformProvider/versions"

.field static final PLATFORM_PROVIDER_VERSION_COLUMN:Ljava/lang/String; = "version"

.field static final PROTOCOL_VERSION_20161017:I = 0x133a1f9

.field static final STATUS_ERROR_TYPE:Ljava/lang/String; = "com.facebook.platform.status.ERROR_TYPE"

.field private static facebookAppInfoList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/facebook/accountkit/internal/NativeAppInfo;",
            ">;"
        }
    .end annotation
.end field

.field private static protocolVersionsAsyncUpdating:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->protocolVersionsAsyncUpdating:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x3

    new-array v0, v0, [Lcom/facebook/accountkit/internal/NativeAppInfo;

    new-instance v2, Lcom/facebook/accountkit/internal/NativeProtocol$KatanaAppInfo;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lcom/facebook/accountkit/internal/NativeProtocol$KatanaAppInfo;-><init>(Lcom/facebook/accountkit/internal/NativeProtocol$1;)V

    aput-object v2, v0, v1

    new-instance v1, Lcom/facebook/accountkit/internal/NativeProtocol$WakizashiAppInfo;

    invoke-direct {v1, v3}, Lcom/facebook/accountkit/internal/NativeProtocol$WakizashiAppInfo;-><init>(Lcom/facebook/accountkit/internal/NativeProtocol$1;)V

    const/4 v2, 0x1

    aput-object v1, v0, v2

    new-instance v1, Lcom/facebook/accountkit/internal/NativeProtocol$FBLiteAppInfo;

    invoke-direct {v1, v3}, Lcom/facebook/accountkit/internal/NativeProtocol$FBLiteAppInfo;-><init>(Lcom/facebook/accountkit/internal/NativeProtocol$1;)V

    const/4 v2, 0x2

    aput-object v1, v0, v2

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->facebookAppInfoList:Ljava/util/List;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$300()Ljava/util/List;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->facebookAppInfoList:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$400()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->protocolVersionsAsyncUpdating:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static createPlatformServiceIntent(Landroid/content/Context;)Landroid/content/Intent;
    .locals 4

    sget-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->facebookAppInfoList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/facebook/accountkit/internal/NativeAppInfo;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/NativeAppInfo;->getPlatformServiceIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "android.intent.category.DEFAULT"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    invoke-static {p0, v2, v1}, Lcom/facebook/accountkit/internal/NativeProtocol;->validateServiceIntent(Landroid/content/Context;Landroid/content/Intent;Lcom/facebook/accountkit/internal/NativeAppInfo;)Landroid/content/Intent;

    move-result-object v1

    if-eqz v1, :cond_0

    return-object v1

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method static updateAllAvailableProtocolVersionsAsync()V
    .locals 3

    sget-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->protocolVersionsAsyncUpdating:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getThreadPoolExecutor()Ljava/util/concurrent/Executor;

    move-result-object v0

    new-instance v1, Lcom/facebook/accountkit/internal/NativeProtocol$1;

    invoke-direct {v1}, Lcom/facebook/accountkit/internal/NativeProtocol$1;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method static validateApplicationForService()Z
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->facebookAppInfoList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/facebook/accountkit/internal/NativeAppInfo;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/NativeAppInfo;->isAppInstalled()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method static validateProtocolVersionForService(I)Z
    .locals 3

    sget-object v0, Lcom/facebook/accountkit/internal/NativeProtocol;->facebookAppInfoList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/facebook/accountkit/internal/NativeAppInfo;

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/NativeAppInfo;->getAvailableVersions()Ljava/util/TreeSet;

    move-result-object v1

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/TreeSet;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method private static validateServiceIntent(Landroid/content/Context;Landroid/content/Intent;Lcom/facebook/accountkit/internal/NativeAppInfo;)Landroid/content/Intent;
    .locals 2

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->resolveService(Landroid/content/Intent;I)Landroid/content/pm/ResolveInfo;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, v0, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;

    iget-object v0, v0, Landroid/content/pm/ServiceInfo;->packageName:Ljava/lang/String;

    invoke-virtual {p2, p0, v0}, Lcom/facebook/accountkit/internal/NativeAppInfo;->validateSignature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    return-object v1

    :cond_1
    return-object p1
.end method
