.class final Lcom/facebook/accountkit/internal/AppEventsLogger;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;,
        Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;,
        Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;,
        Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;,
        Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;,
        Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;,
        Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;
    }
.end annotation


# static fields
.field private static final APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

.field private static final APP_EVENT_PREFERENCES:Ljava/lang/String; = "com.facebook.accountkit.sdk.appEventPreferences"

.field private static final FLUSH_PERIOD_IN_SECONDS:I = 0xf

.field private static final MAX_POOL_SIZE:I = 0x4

.field private static final NUM_LOG_EVENTS_TO_TRY_TO_FLUSH_AFTER:I = 0x1e

.field private static final TAG:Ljava/lang/String;

.field private static anonymousAppDeviceGUID:Ljava/lang/String;

.field private static requestInFlight:Z

.field private static final sAppEventExecutor:Ljava/util/concurrent/Executor;

.field private static final stateMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final applicationContext:Landroid/content/Context;

.field private final stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;


# direct methods
.method static constructor <clinit>()V
    .locals 10

    const-class v0, Lcom/facebook/accountkit/internal/AppEventsLogger;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateMap:Ljava/util/Map;

    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v7, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x100

    invoke-direct {v7, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v8, Lcom/facebook/accountkit/internal/AppEventsLogger$1;

    invoke-direct {v8}, Lcom/facebook/accountkit/internal/AppEventsLogger$1;-><init>()V

    new-instance v9, Lcom/facebook/accountkit/internal/AppEventsLogger$2;

    invoke-direct {v9}, Lcom/facebook/accountkit/internal/AppEventsLogger$2;-><init>()V

    const/4 v2, 0x1

    const/4 v3, 0x4

    const-wide/16 v4, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v9}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;Ljava/util/concurrent/RejectedExecutionHandler;)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->sAppEventExecutor:Ljava/util/concurrent/Executor;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getCurrentAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_1

    if-eqz p2, :cond_0

    invoke-virtual {v0}, Lcom/facebook/accountkit/AccessToken;->getApplicationId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    new-instance p2, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    invoke-direct {p2, v0}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;-><init>(Lcom/facebook/accountkit/AccessToken;)V

    iput-object p2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    goto :goto_0

    :cond_1
    if-nez p2, :cond_2

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getMetadataApplicationId()Ljava/lang/String;

    move-result-object p2

    :cond_2
    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p2}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    :goto_0
    iput-object p1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->applicationContext:Landroid/content/Context;

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/AppEventsLogger;->initializeTimersIfNeeded()V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$200(Lcom/facebook/accountkit/internal/AppEventsLogger;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    return-object p0
.end method

.method static synthetic access$300(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->getSessionEventsState(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400(Lcom/facebook/accountkit/internal/AppEventsLogger;)V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/AppEventsLogger;->flushIfNecessary()V

    return-void
.end method

.method static synthetic access$500(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->flushAndWait(Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V

    return-void
.end method

.method static synthetic access$700(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphResponse;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lcom/facebook/accountkit/internal/AppEventsLogger;->handleResponse(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphResponse;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)V

    return-void
.end method

.method private buildAndExecuteRequests(Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;Ljava/util/Set;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;",
            "Ljava/util/Set<",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;-><init>(Lcom/facebook/accountkit/internal/AppEventsLogger$1;)V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    invoke-direct {p0, v2}, Lcom/facebook/accountkit/internal/AppEventsLogger;->getSessionEventsState(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_0

    :cond_1
    invoke-direct {p0, v2, v3, v0}, Lcom/facebook/accountkit/internal/AppEventsLogger;->buildRequestForSession(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_3

    sget-object p2, Lcom/facebook/accountkit/LoggingBehavior;->APP_EVENTS:Lcom/facebook/accountkit/LoggingBehavior;

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger;->TAG:Ljava/lang/String;

    const-string v3, "Flushing %d events due to %s."

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    iget v0, v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->numEvents:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const/4 v5, 0x0

    aput-object v0, v4, v5

    const/4 v0, 0x1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->toString()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v4, v0

    invoke-static {p2, v2, v3, v4}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->sAppEventExecutor:Ljava/util/concurrent/Executor;

    new-array v1, v5, [Ljava/lang/Void;

    invoke-virtual {p2, v0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_1

    :cond_3
    return-void
.end method

.method private buildRequestForSession(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;
    .locals 9

    iget-object v0, p1, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;->applicationId:Ljava/lang/String;

    new-instance v7, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    const-string v1, "%s/events"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    sget-object v6, Lcom/facebook/accountkit/internal/HttpMethod;->POST:Lcom/facebook/accountkit/internal/HttpMethod;

    const/4 v2, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;-><init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Landroid/os/Bundle;ZLcom/facebook/accountkit/internal/HttpMethod;)V

    invoke-virtual {p2, v7}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;->populateRequest(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget v1, p3, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->numEvents:I

    add-int/2addr v1, v0

    iput v1, p3, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->numEvents:I

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    new-instance v8, Lcom/facebook/accountkit/internal/AppEventsLogger$6;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, v7

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/facebook/accountkit/internal/AppEventsLogger$6;-><init>(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)V

    invoke-direct {v0, v7, v8}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;)V

    return-object v0
.end method

.method private flush(Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->sAppEventExecutor:Ljava/util/concurrent/Executor;

    new-instance v1, Lcom/facebook/accountkit/internal/AppEventsLogger$5;

    invoke-direct {v1, p0, p1}, Lcom/facebook/accountkit/internal/AppEventsLogger$5;-><init>(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private flushAndWait(Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V
    .locals 3

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->requestInFlight:Z

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    const/4 v1, 0x1

    sput-boolean v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->requestInFlight:Z

    new-instance v1, Ljava/util/HashSet;

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateMap:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    invoke-direct {p0, p1, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->buildAndExecuteRequests(Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;Ljava/util/Set;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->TAG:Ljava/lang/String;

    const-string v1, "Caught unexpected exception while flushing: "

    invoke-static {v0, v1, p1}, Lcom/facebook/accountkit/internal/Utility;->logd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    sget-object p1, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    monitor-enter p1

    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->requestInFlight:Z

    monitor-exit p1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    :catchall_1
    move-exception p1

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw p1
.end method

.method private flushIfNecessary()V
    .locals 3

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    invoke-static {}, Lcom/facebook/accountkit/internal/AppEventsLogger;->getAccumulatedEventCount()I

    move-result v1

    const/16 v2, 0x1e

    if-le v1, v2, :cond_0

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EVENT_THRESHOLD:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    invoke-direct {p0, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->flush(Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private static getAccumulatedEventCount()I
    .locals 4

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateMap:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    invoke-virtual {v3}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;->getAccumulatedEventCount()I

    move-result v3

    add-int/2addr v1, v3

    goto :goto_0

    :cond_0
    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private static getAnonymousAppDeviceGUID(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    if-nez v0, :cond_1

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    if-nez v1, :cond_0

    const-string v1, "com.facebook.accountkit.sdk.appEventPreferences"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v1, "anonymousAppDeviceGUID"

    const/4 v2, 0x0

    invoke-interface {p0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "XZ"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v1, "anonymousAppDeviceGUID"

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    invoke-interface {p0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    :cond_1
    :goto_0
    sget-object p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->anonymousAppDeviceGUID:Ljava/lang/String;

    return-object p0
.end method

.method private getSessionEventsState(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;
    .locals 4

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    if-nez v0, :cond_1

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger;->APP_EVENTS_LOGGER_LOCK:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    if-nez v0, :cond_0

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->applicationContext:Landroid/content/Context;

    iget-object v3, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->applicationContext:Landroid/content/Context;

    invoke-static {v3}, Lcom/facebook/accountkit/internal/AppEventsLogger;->getAnonymousAppDeviceGUID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateMap:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception p1

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_1
    return-object v0
.end method

.method private handleResponse(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphResponse;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)V
    .locals 10
    .param p3    # Lcom/facebook/accountkit/internal/AccountKitGraphResponse;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    if-nez p3, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p3}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v0

    :goto_0
    const-string v1, "Success"

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->SUCCESS:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x2

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->getErrorCode()I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_1

    const-string v1, "Failed: No Connectivity"

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->NO_CONNECTIVITY:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    goto :goto_1

    :cond_1
    const-string v1, "Failed:\n  Response: %s\n  Error %s"

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {p3}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->toString()Ljava/lang/String;

    move-result-object p3

    aput-object p3, v2, v4

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/AccountKitRequestError;->toString()Ljava/lang/String;

    move-result-object p3

    aput-object p3, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->SERVER_ERROR:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    :cond_2
    :goto_1
    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getLoggingBehaviors()Lcom/facebook/accountkit/LoggingBehaviorCollection;

    move-result-object p3

    sget-object v6, Lcom/facebook/accountkit/LoggingBehavior;->APP_EVENTS:Lcom/facebook/accountkit/LoggingBehavior;

    invoke-virtual {p3, v6}, Lcom/facebook/accountkit/LoggingBehaviorCollection;->isEnabled(Lcom/facebook/accountkit/LoggingBehavior;)Z

    move-result p3

    if-eqz p3, :cond_3

    invoke-virtual {p2}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/String;

    :try_start_0
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6, p3}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v5}, Lorg/json/JSONArray;->toString(I)Ljava/lang/String;

    move-result-object p3
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    const-string p3, "<Can\'t encode events for debug logging>"

    :goto_2
    sget-object v6, Lcom/facebook/accountkit/LoggingBehavior;->APP_EVENTS:Lcom/facebook/accountkit/LoggingBehavior;

    sget-object v7, Lcom/facebook/accountkit/internal/AppEventsLogger;->TAG:Ljava/lang/String;

    const-string v8, "Flush completed\nParams: %s\n  Result: %s\n  Events JSON: %s"

    const/4 v9, 0x3

    new-array v9, v9, [Ljava/lang/Object;

    invoke-virtual {p2}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->getRequestObject()Lorg/json/JSONObject;

    move-result-object p2

    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v9, v4

    aput-object v1, v9, v3

    aput-object p3, v9, v5

    invoke-static {v6, v7, v8, v9}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_3
    if-eqz v0, :cond_4

    goto :goto_3

    :cond_4
    const/4 v3, 0x0

    :goto_3
    invoke-virtual {p4, v3}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;->clearInFlightAndStats(Z)V

    sget-object p2, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->NO_CONNECTIVITY:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    if-ne v2, p2, :cond_5

    iget-object p2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->applicationContext:Landroid/content/Context;

    invoke-static {p2, p1, p4}, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistEvents(Landroid/content/Context;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;)V

    :cond_5
    sget-object p1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->SUCCESS:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    if-eq v2, p1, :cond_6

    iget-object p1, p5, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->result:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    sget-object p2, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->NO_CONNECTIVITY:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    if-eq p1, p2, :cond_6

    iput-object v2, p5, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->result:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    :cond_6
    return-void
.end method

.method private initializeTimersIfNeeded()V
    .locals 7

    new-instance v1, Lcom/facebook/accountkit/internal/AppEventsLogger$4;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/internal/AppEventsLogger$4;-><init>(Lcom/facebook/accountkit/internal/AppEventsLogger;)V

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getBackgroundExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x0

    const-wide/16 v4, 0xf

    invoke-virtual/range {v0 .. v6}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method


# virtual methods
.method public getApplicationId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger;->stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;->applicationId:Ljava/lang/String;

    return-object v0
.end method

.method logSdkEvent(Ljava/lang/String;Ljava/lang/Double;Landroid/os/Bundle;)V
    .locals 2

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;

    const/4 v1, 0x1

    invoke-direct {v0, p1, p2, p3, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;-><init>(Ljava/lang/String;Ljava/lang/Double;Landroid/os/Bundle;Z)V

    sget-object p1, Lcom/facebook/accountkit/internal/AppEventsLogger;->sAppEventExecutor:Ljava/util/concurrent/Executor;

    new-instance p2, Lcom/facebook/accountkit/internal/AppEventsLogger$3;

    invoke-direct {p2, p0, v0}, Lcom/facebook/accountkit/internal/AppEventsLogger$3;-><init>(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;)V

    invoke-interface {p1, p2}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method
