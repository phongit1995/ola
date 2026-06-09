.class Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "PersistedEvents"
.end annotation


# static fields
.field private static final PERSISTED_EVENTS_FILENAME:Ljava/lang/String; = "AccountKitAppEventsLogger.persistedevents"

.field private static final PERSISTED_EVENTS_LOCK:Ljava/lang/Object;


# instance fields
.field private final context:Landroid/content/Context;

.field private persistedEvents:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;",
            "Ljava/util/List<",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->PERSISTED_EVENTS_LOCK:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistedEvents:Ljava/util/HashMap;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->context:Landroid/content/Context;

    return-void
.end method

.method static persistEvents(Landroid/content/Context;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;)V
    .locals 1

    invoke-virtual {p2}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;->getEventsToPersist()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->PERSISTED_EVENTS_LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    invoke-static {p0}, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->readAndClearStore(Landroid/content/Context;)Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->addEvents(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Ljava/util/List;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->write()V

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method static readAndClearStore(Landroid/content/Context;)Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->PERSISTED_EVENTS_LOCK:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    new-instance v1, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;-><init>(Landroid/content/Context;)V

    invoke-direct {v1}, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->readAndClearStore()V

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private readAndClearStore()V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/BufferedInputStream;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->context:Landroid/content/Context;

    const-string v3, "AccountKitAppEventsLogger.persistedevents"

    invoke-virtual {v2, v3}, Landroid/content/Context;->openFileInput(Ljava/lang/String;)Ljava/io/FileInputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    new-instance v0, Ljava/io/ObjectInputStream;

    invoke-direct {v0, v1}, Ljava/io/ObjectInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    invoke-virtual {v0}, Ljava/io/ObjectInputStream;->readObject()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/HashMap;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->context:Landroid/content/Context;

    const-string v3, "AccountKitAppEventsLogger.persistedevents"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getFileStreamPath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$000()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Error deleting file: AccountKitAppEventsLogger.persistedevents"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iput-object v1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistedEvents:Ljava/util/HashMap;
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_2

    :catchall_0
    move-exception v0

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_1

    :catch_0
    move-exception v0

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_0

    :catch_1
    move-object v0, v1

    goto :goto_2

    :catchall_1
    move-exception v1

    goto :goto_1

    :catch_2
    move-exception v1

    :goto_0
    :try_start_3
    invoke-static {}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Got unexpected exception: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_2

    :goto_1
    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    throw v1

    :catch_3
    :goto_2
    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    return-void
.end method

.method private write()V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->context:Landroid/content/Context;

    const-string v2, "AccountKitAppEventsLogger.persistedevents"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->openFileOutput(Ljava/lang/String;I)Ljava/io/FileOutputStream;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    new-instance v0, Ljava/io/BufferedOutputStream;

    invoke-direct {v0, v1}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    new-instance v1, Ljava/io/ObjectOutputStream;

    invoke-direct {v1, v0}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :try_start_3
    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistedEvents:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    invoke-static {v1}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    return-void

    :catchall_0
    move-exception v0

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_1

    :catch_0
    move-exception v0

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_0

    :catchall_1
    move-exception v1

    goto :goto_1

    :catch_1
    move-exception v1

    :goto_0
    :try_start_4
    invoke-static {}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Got unexpected exception: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    return-void

    :goto_1
    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    throw v1
.end method


# virtual methods
.method addEvents(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;",
            "Ljava/util/List<",
            "Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistedEvents:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistedEvents:Ljava/util/HashMap;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v0, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$PersistedEvents;->persistedEvents:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method
