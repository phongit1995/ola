.class final Lcom/facebook/accountkit/internal/Validate;
.super Ljava/lang/Object;


# static fields
.field private static final NO_INTERNET_PERMISSION_REASON:Ljava/lang/String; = "No internet permissions granted for the app, please add <uses-permission android:name=\"android.permission.INTERNET\" /> to your AndroidManifest.xml."


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static checkInternetPermissionAndThrow(Landroid/content/Context;)V
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "android.permission.INTERNET"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result p0

    const/4 v0, -0x1

    if-ne p0, v0, :cond_0

    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "No internet permissions granted for the app, please add <uses-permission android:name=\"android.permission.INTERNET\" /> to your AndroidManifest.xml."

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    return-void
.end method

.method static isEquals(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;)V
    .locals 1

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/Utility;->notEquals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    new-instance p0, Lcom/facebook/accountkit/AccountKitException;

    sget-object p1, Lcom/facebook/accountkit/AccountKitError$Type;->ARGUMENT_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NOT_EQUAL_OBJECTS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p0, p1, v0, p2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/String;)V

    throw p0

    :cond_0
    return-void
.end method

.method static loginModelInProgress(Lcom/facebook/accountkit/internal/LoginModelImpl;)V
    .locals 2

    if-nez p0, :cond_0

    new-instance p0, Lcom/facebook/accountkit/AccountKitException;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->ARGUMENT_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_LOGIN_ATTEMPT_IN_PROGRESS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p0, v0, v1}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw p0

    :cond_0
    return-void
.end method

.method static loginModelsEqual(Lcom/facebook/accountkit/internal/LoginModelImpl;Lcom/facebook/accountkit/internal/LoginModelImpl;)V
    .locals 1

    invoke-static {p0, p1}, Lcom/facebook/accountkit/internal/Utility;->notEquals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    new-instance p0, Lcom/facebook/accountkit/AccountKitException;

    sget-object p1, Lcom/facebook/accountkit/AccountKitError$Type;->ARGUMENT_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->DIFFERENT_LOGIN_ATTEMPT_IN_PROGRESS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw p0

    :cond_0
    return-void
.end method

.method static sdkInitialized()V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/AccountKitException;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->INITIALIZATION_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->SDK_NOT_INITIALIZED:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw v0

    :cond_0
    return-void
.end method
