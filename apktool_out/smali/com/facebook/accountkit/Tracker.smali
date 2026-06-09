.class public abstract Lcom/facebook/accountkit/Tracker;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/Tracker$TrackerBroadcastReceiver;
    }
.end annotation


# static fields
.field public static final EXTRA_LOGIN_ERROR:Ljava/lang/String; = "com.facebook.accountkit.sdk.EXTRA_LOGIN_ERROR"

.field public static final EXTRA_LOGIN_MODEL:Ljava/lang/String; = "com.facebook.accountkit.sdk.EXTRA_LOGIN_MODEL"

.field public static final EXTRA_LOGIN_STATUS:Ljava/lang/String; = "com.facebook.accountkit.sdk.EXTRA_LOGIN_STATUS"


# instance fields
.field private isPaused:Z

.field private isTracking:Z

.field private final pendingBroadcasts:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation
.end field

.field private final receiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isPaused:Z

    iput-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isTracking:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/Tracker;->pendingBroadcasts:Ljava/util/List;

    new-instance v0, Lcom/facebook/accountkit/Tracker$TrackerBroadcastReceiver;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/Tracker$TrackerBroadcastReceiver;-><init>(Lcom/facebook/accountkit/Tracker;)V

    iput-object v0, p0, Lcom/facebook/accountkit/Tracker;->receiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/Tracker;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/Tracker;->pendingBroadcasts:Ljava/util/List;

    return-object p0
.end method

.method private addBroadcastReceiver()V
    .locals 3

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/Tracker;->getActionsStateChanged()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/facebook/accountkit/Tracker;->receiver:Landroid/content/BroadcastReceiver;

    invoke-direct {p0, v1, v0}, Lcom/facebook/accountkit/Tracker;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    return-void
.end method

.method private registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/Tracker;->isLocal()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {v0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Landroid/support/v4/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    return-void

    :cond_0
    invoke-virtual {v0, p1, p2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method private unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/Tracker;->isLocal()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {v0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/support/v4/content/LocalBroadcastManager;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void

    :cond_0
    invoke-virtual {v0, p1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method


# virtual methods
.method protected abstract getActionsStateChanged()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method

.method protected isLocal()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public isPaused()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isPaused:Z

    return v0
.end method

.method public isTracking()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isTracking:Z

    return v0
.end method

.method protected abstract onReceive(Landroid/content/Intent;)V
.end method

.method public pauseTracking()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isPaused:Z

    return-void
.end method

.method public startTracking()V
    .locals 3

    iget-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isTracking:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isTracking:Z

    invoke-direct {p0}, Lcom/facebook/accountkit/Tracker;->addBroadcastReceiver()V

    :cond_0
    iget-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isPaused:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isPaused:Z

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/facebook/accountkit/Tracker;->pendingBroadcasts:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iget-object v1, p0, Lcom/facebook/accountkit/Tracker;->pendingBroadcasts:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/facebook/accountkit/Tracker;->isTracking()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p0, v1}, Lcom/facebook/accountkit/Tracker;->onReceive(Landroid/content/Intent;)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method public stopTracking()V
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isTracking:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/Tracker;->isTracking:Z

    iget-object v0, p0, Lcom/facebook/accountkit/Tracker;->receiver:Landroid/content/BroadcastReceiver;

    invoke-direct {p0, v0}, Lcom/facebook/accountkit/Tracker;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lcom/facebook/accountkit/Tracker;->pendingBroadcasts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    return-void
.end method
