.class public final Lcom/facebook/accountkit/internal/Initializer;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/Initializer$State;,
        Lcom/facebook/accountkit/internal/Initializer$Data;
    }
.end annotation


# instance fields
.field private final callbacks:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/facebook/accountkit/AccountKit$InitializeCallback;",
            ">;"
        }
    .end annotation
.end field

.field private volatile data:Lcom/facebook/accountkit/internal/Initializer$Data;

.field private volatile state:Lcom/facebook/accountkit/internal/Initializer$State;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->callbacks:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    sget-object v0, Lcom/facebook/accountkit/internal/Initializer$State;->UNINITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->state:Lcom/facebook/accountkit/internal/Initializer$State;

    return-void
.end method

.method private static fixSamsungClipboardUIManagerMemoryLeak(Landroid/content/Context;)V
    .locals 6

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_0

    :try_start_0
    const-string v0, "android.sec.clipboard.ClipboardUIManager"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "getInstance"

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/Class;

    const-class v4, Landroid/content/Context;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    const/4 v1, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p0, v2, v5

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private static getRequiredString(Landroid/os/Bundle;Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalAccountKitError;)Ljava/lang/String;
    .locals 0

    invoke-virtual {p0, p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-nez p0, :cond_0

    new-instance p0, Lcom/facebook/accountkit/AccountKitException;

    sget-object p1, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw p0

    :cond_0
    return-object p0
.end method

.method private isValidLocale(Ljava/lang/String;)Z
    .locals 5

    invoke-static {}, Ljava/util/Locale;->getAvailableLocales()[Ljava/util/Locale;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    invoke-virtual {v4}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return v2
.end method

.method private declared-synchronized loadAccessToken()V
    .locals 2

    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->accessTokenManager:Lcom/facebook/accountkit/internal/AccessTokenManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/AccessTokenManager;->loadCurrentAccessToken()Z

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->callbacks:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/facebook/accountkit/AccountKit$InitializeCallback;

    invoke-interface {v1}, Lcom/facebook/accountkit/AccountKit$InitializeCallback;->onInitialized()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->callbacks:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private setDefaultLocale(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/internal/Initializer;->isValidLocale(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/util/Locale;

    invoke-direct {v0, p2}, Ljava/util/Locale;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p2

    iput-object v0, p2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    :cond_0
    return-void
.end method


# virtual methods
.method getAccessTokenManager()Lcom/facebook/accountkit/internal/AccessTokenManager;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->accessTokenManager:Lcom/facebook/accountkit/internal/AccessTokenManager;

    return-object v0
.end method

.method getAccountKitFacebookAppEventsEnabled()Z
    .locals 1

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/InternalLogger;->getFacebookAppEventsEnabled()Z

    move-result v0

    return v0
.end method

.method public getApplicationContext()Landroid/content/Context;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->applicationContext:Landroid/content/Context;

    return-object v0
.end method

.method public getApplicationId()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->applicationId:Ljava/lang/String;

    return-object v0
.end method

.method getApplicationName()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->applicationName:Ljava/lang/String;

    return-object v0
.end method

.method getClientToken()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->clientToken:Ljava/lang/String;

    return-object v0
.end method

.method public getLogger()Lcom/facebook/accountkit/internal/InternalLogger;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/LoginManager;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object v0

    return-object v0
.end method

.method getLoginManager()Lcom/facebook/accountkit/internal/LoginManager;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->loginManager:Lcom/facebook/accountkit/internal/LoginManager;

    return-object v0
.end method

.method getUpdateManager()Lcom/facebook/accountkit/internal/UpdateManager;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/Initializer$Data;->updateManager:Lcom/facebook/accountkit/internal/UpdateManager;

    return-object v0
.end method

.method public declared-synchronized initialize(Landroid/content/Context;Lcom/facebook/accountkit/AccountKit$InitializeCallback;)V
    .locals 11
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/Initializer;->isInitialized()Z

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p2, :cond_0

    invoke-interface {p2}, Lcom/facebook/accountkit/AccountKit$InitializeCallback;->onInitialized()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :cond_1
    if-eqz p2, :cond_2

    :try_start_1
    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->callbacks:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_2
    invoke-static {p1}, Lcom/facebook/accountkit/internal/Validate;->checkInternetPermissionAndThrow(Landroid/content/Context;)V

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Initializer;->fixSamsungClipboardUIManagerMemoryLeak(Landroid/content/Context;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 p2, 0x0

    :try_start_2
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x80

    invoke-virtual {v0, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0
    :try_end_2
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    move-object v0, p2

    :goto_0
    if-eqz v0, :cond_5

    :try_start_3
    iget-object v2, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    if-nez v2, :cond_3

    goto/16 :goto_1

    :cond_3
    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v2, "com.facebook.sdk.ApplicationId"

    sget-object v3, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_APP_ID:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {v0, v2, v3}, Lcom/facebook/accountkit/internal/Initializer;->getRequiredString(Landroid/os/Bundle;Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalAccountKitError;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.facebook.accountkit.ClientToken"

    sget-object v4, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_CLIENT_TOKEN:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {v0, v3, v4}, Lcom/facebook/accountkit/internal/Initializer;->getRequiredString(Landroid/os/Bundle;Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalAccountKitError;)Ljava/lang/String;

    move-result-object v4

    const-string v3, "com.facebook.accountkit.ApplicationName"

    sget-object v5, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_APP_NAME:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-static {v0, v3, v5}, Lcom/facebook/accountkit/internal/Initializer;->getRequiredString(Landroid/os/Bundle;Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalAccountKitError;)Ljava/lang/String;

    move-result-object v3

    const-string v5, "com.facebook.accountkit.AccountKitFacebookAppEventsEnabled"

    const/4 v6, 0x1

    invoke-virtual {v0, v5, v6}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v5

    const-string v6, "com.facebook.accountkit.DefaultLanguage"

    const-string v7, "en-us"

    invoke-virtual {v0, v6, v7}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/internal/Initializer;->setDefaultLocale(Landroid/content/Context;Ljava/lang/String;)V

    invoke-static {v1}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v6

    new-instance v0, Lcom/facebook/accountkit/internal/InternalLogger;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v7

    invoke-direct {v0, v7, v2, v5}, Lcom/facebook/accountkit/internal/InternalLogger;-><init>(Landroid/content/Context;Ljava/lang/String;Z)V

    new-instance v5, Lcom/facebook/accountkit/internal/AccessTokenManager;

    invoke-direct {v5, v1, v6}, Lcom/facebook/accountkit/internal/AccessTokenManager;-><init>(Landroid/content/Context;Landroid/support/v4/content/LocalBroadcastManager;)V

    new-instance v9, Lcom/facebook/accountkit/internal/LoginManager;

    invoke-direct {v9, v0, v5, v6}, Lcom/facebook/accountkit/internal/LoginManager;-><init>(Lcom/facebook/accountkit/internal/InternalLogger;Lcom/facebook/accountkit/internal/AccessTokenManager;Landroid/support/v4/content/LocalBroadcastManager;)V

    new-instance v8, Lcom/facebook/accountkit/internal/UpdateManager;

    invoke-direct {v8, v0, v6}, Lcom/facebook/accountkit/internal/UpdateManager;-><init>(Lcom/facebook/accountkit/internal/InternalLogger;Landroid/support/v4/content/LocalBroadcastManager;)V

    new-instance v10, Lcom/facebook/accountkit/internal/Initializer$Data;

    move-object v0, v10

    move-object v7, v9

    invoke-direct/range {v0 .. v8}, Lcom/facebook/accountkit/internal/Initializer$Data;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/internal/AccessTokenManager;Landroid/support/v4/content/LocalBroadcastManager;Lcom/facebook/accountkit/internal/LoginManager;Lcom/facebook/accountkit/internal/UpdateManager;)V

    iput-object v10, p0, Lcom/facebook/accountkit/internal/Initializer;->data:Lcom/facebook/accountkit/internal/Initializer$Data;

    invoke-static {}, Ljava/net/CookieManager;->getDefault()Ljava/net/CookieHandler;

    move-result-object v0

    if-nez v0, :cond_4

    new-instance v0, Ljava/net/CookieManager;

    new-instance v1, Lcom/facebook/accountkit/internal/AccountKitCookieStore;

    invoke-direct {v1, p1}, Lcom/facebook/accountkit/internal/AccountKitCookieStore;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v1, p2}, Ljava/net/CookieManager;-><init>(Ljava/net/CookieStore;Ljava/net/CookiePolicy;)V

    invoke-static {v0}, Ljava/net/CookieManager;->setDefault(Ljava/net/CookieHandler;)V

    :cond_4
    invoke-direct {p0}, Lcom/facebook/accountkit/internal/Initializer;->loadAccessToken()V

    sget-object p1, Lcom/facebook/accountkit/internal/Initializer$State;->INITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/Initializer;->state:Lcom/facebook/accountkit/internal/Initializer$State;

    invoke-virtual {v9}, Lcom/facebook/accountkit/internal/LoginManager;->getLogger()Lcom/facebook/accountkit/internal/InternalLogger;

    move-result-object p1

    const-string p2, "ak_sdk_init"

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/internal/InternalLogger;->logEvent(Ljava/lang/String;)V

    invoke-static {}, Lcom/facebook/accountkit/internal/NativeProtocol;->updateAllAvailableProtocolVersionsAsync()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    monitor-exit p0

    return-void

    :cond_5
    :goto_1
    :try_start_4
    sget-object p1, Lcom/facebook/accountkit/internal/Initializer$State;->FAILED:Lcom/facebook/accountkit/internal/Initializer$State;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/Initializer;->state:Lcom/facebook/accountkit/internal/Initializer$State;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public isInitialized()Z
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/Initializer;->state:Lcom/facebook/accountkit/internal/Initializer$State;

    sget-object v1, Lcom/facebook/accountkit/internal/Initializer$State;->INITIALIZED:Lcom/facebook/accountkit/internal/Initializer$State;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method
