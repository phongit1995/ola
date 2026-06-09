.class public final Lcom/facebook/accountkit/AccountKit;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/AccountKit$InitializeCallback;
    }
.end annotation


# static fields
.field public static final APPLICATION_DEFAULT_LANGUAGE:Ljava/lang/String; = "com.facebook.accountkit.DefaultLanguage"

.field public static final APPLICATION_ID_PROPERTY:Ljava/lang/String; = "com.facebook.sdk.ApplicationId"

.field public static final APPLICATION_NAME_PROPERTY:Ljava/lang/String; = "com.facebook.accountkit.ApplicationName"

.field public static final CLIENT_TOKEN_PROPERTY:Ljava/lang/String; = "com.facebook.accountkit.ClientToken"

.field public static final FACEBOOK_APP_EVENTS_ENABLED_PROPERTY:Ljava/lang/String; = "com.facebook.accountkit.AccountKitFacebookAppEventsEnabled"

.field private static final LOCK:Ljava/lang/Object;

.field private static volatile executor:Ljava/util/concurrent/Executor;

.field private static final loggingBehaviors:Lcom/facebook/accountkit/LoggingBehaviorCollection;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/AccountKit;->LOCK:Ljava/lang/Object;

    new-instance v0, Lcom/facebook/accountkit/LoggingBehaviorCollection;

    invoke-direct {v0}, Lcom/facebook/accountkit/LoggingBehaviorCollection;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/AccountKit;->loggingBehaviors:Lcom/facebook/accountkit/LoggingBehaviorCollection;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static cancelLogin()V
    .locals 0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->cancelLogin()V

    return-void
.end method

.method public static getAccountKitFacebookAppEventsEnabled()Z
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getAccountKitFacebookAppEventsEnabled()Z

    move-result v0

    return v0
.end method

.method public static getApplicationId()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getApplicationName()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getClientToken()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getClientToken()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    return-object v0
.end method

.method public static getCurrentAccount(Lcom/facebook/accountkit/AccountKitCallback;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/facebook/accountkit/AccountKitCallback<",
            "Lcom/facebook/accountkit/Account;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lcom/facebook/accountkit/internal/AccountKitController;->getCurrentAccount(Lcom/facebook/accountkit/AccountKitCallback;)V

    return-void
.end method

.method public static getCurrentEmailLogInModel()Lcom/facebook/accountkit/EmailLoginModel;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getCurrentEmailLogInModel()Lcom/facebook/accountkit/EmailLoginModel;

    move-result-object v0

    return-object v0
.end method

.method public static getCurrentLogInModel()Lcom/facebook/accountkit/LoginModel;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getCurrentEmailLogInModel()Lcom/facebook/accountkit/EmailLoginModel;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public static getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getCurrentPhoneNumberLogInModel()Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object v0

    return-object v0
.end method

.method public static getExecutor()Ljava/util/concurrent/Executor;
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/AccountKit;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/facebook/accountkit/AccountKit;->executor:Ljava/util/concurrent/Executor;

    if-nez v1, :cond_0

    sget-object v1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    sput-object v1, Lcom/facebook/accountkit/AccountKit;->executor:Ljava/util/concurrent/Executor;

    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sget-object v0, Lcom/facebook/accountkit/AccountKit;->executor:Ljava/util/concurrent/Executor;

    return-object v0

    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static getLoggingBehaviors()Lcom/facebook/accountkit/LoggingBehaviorCollection;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/AccountKit;->loggingBehaviors:Lcom/facebook/accountkit/LoggingBehaviorCollection;

    return-object v0
.end method

.method public static declared-synchronized initialize(Landroid/content/Context;)V
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-class v0, Lcom/facebook/accountkit/AccountKit;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    invoke-static {p0, v1}, Lcom/facebook/accountkit/AccountKit;->initialize(Landroid/content/Context;Lcom/facebook/accountkit/AccountKit$InitializeCallback;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static initialize(Landroid/content/Context;Lcom/facebook/accountkit/AccountKit$InitializeCallback;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitController;->initialize(Landroid/content/Context;Lcom/facebook/accountkit/AccountKit$InitializeCallback;)V

    return-void
.end method

.method public static isInitialized()Z
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->isInitialized()Z

    move-result v0

    return v0
.end method

.method public static logInWithEmail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/EmailLoginModel;
    .locals 0
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/internal/AccountKitController;->logInWithEmail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/EmailLoginModel;

    move-result-object p0

    return-object p0
.end method

.method public static logInWithPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;Lcom/facebook/accountkit/ui/NotificationChannel;Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/PhoneLoginModel;
    .locals 1
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->logOut()V

    :cond_0
    invoke-static {p0, p1, p2, p3}, Lcom/facebook/accountkit/internal/AccountKitController;->logInWithPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;Lcom/facebook/accountkit/ui/NotificationChannel;Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/PhoneLoginModel;

    move-result-object p0

    return-object p0
.end method

.method public static logOut()V
    .locals 0

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->logOut()V

    return-void
.end method

.method private static logOut(Lcom/facebook/accountkit/AccountKitCallback;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/facebook/accountkit/AccountKitCallback<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lcom/facebook/accountkit/internal/AccountKitController;->logOut(Lcom/facebook/accountkit/AccountKitCallback;)V

    return-void
.end method

.method public static loginResultWithIntent(Landroid/content/Intent;)Lcom/facebook/accountkit/AccountKitLoginResult;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    const-string v1, "account_kit_log_in_result"

    invoke-virtual {p0, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p0

    instance-of v1, p0, Lcom/facebook/accountkit/AccountKitLoginResult;

    if-nez v1, :cond_1

    return-object v0

    :cond_1
    check-cast p0, Lcom/facebook/accountkit/AccountKitLoginResult;

    return-object p0
.end method

.method public static onActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitController;->onActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public static onActivityDestroy(Landroid/app/Activity;)V
    .locals 0

    invoke-static {p0}, Lcom/facebook/accountkit/internal/AccountKitController;->onActivityDestroy(Landroid/app/Activity;)V

    return-void
.end method

.method public static onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitController;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public static setExecutor(Ljava/util/concurrent/Executor;)V
    .locals 1
    .param p0    # Ljava/util/concurrent/Executor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    sget-object v0, Lcom/facebook/accountkit/AccountKit;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sput-object p0, Lcom/facebook/accountkit/AccountKit;->executor:Ljava/util/concurrent/Executor;

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method
