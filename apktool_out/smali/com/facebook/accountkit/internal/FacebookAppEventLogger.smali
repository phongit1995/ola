.class final Lcom/facebook/accountkit/internal/FacebookAppEventLogger;
.super Ljava/lang/Object;


# static fields
.field private static final FB_EVENT_NAME_LOGIN_ATTEMPT:Ljava/lang/String; = "fb_ak_login_attempt"

.field private static final FB_EVENT_NAME_LOGIN_COMPLETE:Ljava/lang/String; = "fb_ak_login_complete"

.field private static final FB_EVENT_NAME_LOGIN_DIALOG_IMPRESSION:Ljava/lang/String; = "fb_ak_login_dialog_impression"

.field private static final FB_EVENT_NAME_LOGIN_START:Ljava/lang/String; = "fb_ak_login_start"

.field private static final TAG:Ljava/lang/String;

.field private static final eventNameMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private fbAppEventLogger:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    new-instance v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/internal/FacebookAppEventLogger$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->eventNameMap:Ljava/util/Map;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 7

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->fbAppEventLogger:Ljava/lang/Object;

    invoke-static {}, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->isFacebookSDKInitialized()Z

    move-result v1

    if-eqz v1, :cond_0

    :try_start_0
    const-string v1, "com.facebook.appevents.AppEventsLogger"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    const-string v2, "newLogger"

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Landroid/content/Context;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/NoSuchMethodException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_2

    :try_start_2
    new-array v2, v3, [Ljava/lang/Object;

    aput-object p1, v2, v6

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->fbAppEventLogger:Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_2

    return-void

    :catch_0
    move-exception p1

    :try_start_3
    sget-object v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/Exception;)V
    :try_end_3
    .catch Ljava/lang/NoSuchMethodException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_1
    move-exception p1

    :try_start_4
    sget-object v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/Exception;)V
    :try_end_4
    .catch Ljava/lang/ClassNotFoundException; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    :cond_0
    return-void
.end method

.method static isFacebookSDKInitialized()Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    const-string v1, "com.facebook.FacebookSdk"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    const-string v2, "isInitialized"

    new-array v3, v0, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/NoSuchMethodException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_2

    const/4 v2, 0x0

    :try_start_2
    new-array v3, v0, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_2

    return v1

    :catch_0
    move-exception v1

    :try_start_3
    sget-object v2, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/Exception;)V
    :try_end_3
    .catch Ljava/lang/NoSuchMethodException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_2

    return v0

    :catch_1
    move-exception v1

    :try_start_4
    sget-object v2, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    invoke-static {v2, v1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/Exception;)V
    :try_end_4
    .catch Ljava/lang/ClassNotFoundException; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return v0
.end method


# virtual methods
.method logFacebookAppEvents(Ljava/lang/String;Ljava/lang/Double;Landroid/os/Bundle;)V
    .locals 8

    sget-object v0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->eventNameMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->fbAppEventLogger:Ljava/lang/Object;

    if-eqz v0, :cond_1

    :try_start_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->fbAppEventLogger:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "logSdkEvent"

    const/4 v2, 0x3

    new-array v3, v2, [Ljava/lang/Class;

    const-class v4, Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const-class v4, Ljava/lang/Double;

    const/4 v6, 0x1

    aput-object v4, v3, v6

    const-class v4, Landroid/os/Bundle;

    const/4 v7, 0x2

    aput-object v4, v3, v7

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, p0, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->fbAppEventLogger:Ljava/lang/Object;

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p1, v2, v5

    aput-object p2, v2, v6

    aput-object p3, v2, v7

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception p1

    :try_start_2
    sget-object p2, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    invoke-static {p2, p1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/Exception;)V
    :try_end_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    sget-object p2, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->TAG:Ljava/lang/String;

    invoke-static {p2, p1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/Exception;)V

    :cond_1
    return-void
.end method

.method public logImpression(Ljava/lang/String;Landroid/os/Bundle;Z)V
    .locals 0

    if-eqz p3, :cond_0

    const/4 p3, 0x0

    invoke-virtual {p0, p1, p3, p2}, Lcom/facebook/accountkit/internal/FacebookAppEventLogger;->logFacebookAppEvents(Ljava/lang/String;Ljava/lang/Double;Landroid/os/Bundle;)V

    :cond_0
    return-void
.end method
