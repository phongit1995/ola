.class final Lcom/facebook/accountkit/internal/SeamlessLoginClient;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;
    }
.end annotation


# static fields
.field private static final MIN_PROTOCOL_VERSION:I = 0x133a1f9

.field private static final REPLY_MESSAGE:I = 0x10009

.field private static final REQUEST_MESSAGE:I = 0x10008


# instance fields
.field private final applicationId:Ljava/lang/String;

.field private final context:Landroid/content/Context;

.field private final handler:Landroid/os/Handler;

.field private listener:Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;

.field private final logger:Lcom/facebook/accountkit/internal/InternalLogger;

.field private running:Z

.field private sender:Landroid/os/Messenger;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalLogger;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->context:Landroid/content/Context;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->applicationId:Ljava/lang/String;

    iput-object p3, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    new-instance p1, Lcom/facebook/accountkit/internal/SeamlessLoginClient$1;

    invoke-direct {p1, p0}, Lcom/facebook/accountkit/internal/SeamlessLoginClient$1;-><init>(Lcom/facebook/accountkit/internal/SeamlessLoginClient;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->handler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/internal/SeamlessLoginClient;Landroid/os/Message;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->handleMessage(Landroid/os/Message;)V

    return-void
.end method

.method private callback(Landroid/os/Bundle;)V
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->running:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->running:Z

    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->listener:Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->listener:Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;->completed(Landroid/os/Bundle;)V

    :cond_1
    return-void
.end method

.method private handleMessage(Landroid/os/Message;)V
    .locals 2

    iget v0, p1, Landroid/os/Message;->what:I

    const v1, 0x10009

    if-ne v0, v1, :cond_1

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "com.facebook.platform.status.ERROR_TYPE"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->callback(Landroid/os/Bundle;)V

    :try_start_0
    iget-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->context:Landroid/content/Context;

    invoke-virtual {p1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private sendMessage()V
    .locals 4

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "com.facebook.platform.extra.APPLICATION_ID"

    iget-object v2, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->applicationId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x0

    const v2, 0x10008

    invoke-static {v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v2

    const v3, 0x133a1f9

    iput v3, v2, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v0}, Landroid/os/Message;->setData(Landroid/os/Bundle;)V

    new-instance v0, Landroid/os/Messenger;

    iget-object v3, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->handler:Landroid/os/Handler;

    invoke-direct {v0, v3}, Landroid/os/Messenger;-><init>(Landroid/os/Handler;)V

    iput-object v0, v2, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    :try_start_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->sender:Landroid/os/Messenger;

    invoke-virtual {v0, v2}, Landroid/os/Messenger;->send(Landroid/os/Message;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-direct {p0, v1}, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->callback(Landroid/os/Bundle;)V

    return-void
.end method


# virtual methods
.method public isRunning()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->running:Z

    return v0
.end method

.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0

    new-instance p1, Landroid/os/Messenger;

    invoke-direct {p1, p2}, Landroid/os/Messenger;-><init>(Landroid/os/IBinder;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->sender:Landroid/os/Messenger;

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->sendMessage()V

    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->sender:Landroid/os/Messenger;

    :try_start_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->context:Landroid/content/Context;

    invoke-virtual {v0, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->callback(Landroid/os/Bundle;)V

    return-void
.end method

.method public setCompletedListener(Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->listener:Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;

    return-void
.end method

.method public start()Z
    .locals 4

    iget-boolean v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->running:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    invoke-static {}, Lcom/facebook/accountkit/internal/NativeProtocol;->validateApplicationForService()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    const-string v2, "ak_fetch_seamless_login_token"

    sget-object v3, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_NATIVE_APP_INSTALLED:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {v0, v2, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logFetchEventError(Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    return v1

    :cond_1
    const v0, 0x133a1f9

    invoke-static {v0}, Lcom/facebook/accountkit/internal/NativeProtocol;->validateProtocolVersionForService(I)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->logger:Lcom/facebook/accountkit/internal/InternalLogger;

    const-string v2, "ak_fetch_seamless_login_token"

    sget-object v3, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNSUPPORTED_NATIVE_APP_VERSION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {v0, v2, v3}, Lcom/facebook/accountkit/internal/InternalLogger;->logFetchEventError(Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    return v1

    :cond_2
    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/NativeProtocol;->createPlatformServiceIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v0

    if-nez v0, :cond_3

    return v1

    :cond_3
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->running:Z

    iget-object v2, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->context:Landroid/content/Context;

    invoke-virtual {v2, v0, p0, v1}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    return v1
.end method
