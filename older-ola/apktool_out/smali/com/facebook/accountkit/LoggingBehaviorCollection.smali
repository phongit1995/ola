.class public final Lcom/facebook/accountkit/LoggingBehaviorCollection;
.super Ljava/lang/Object;


# instance fields
.field private final loggingBehaviors:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Lcom/facebook/accountkit/LoggingBehavior;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashSet;

    sget-object v1, Lcom/facebook/accountkit/LoggingBehavior;->DEVELOPER_ERRORS:Lcom/facebook/accountkit/LoggingBehavior;

    invoke-static {v1}, Ljava/util/Collections;->singleton(Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    return-void
.end method


# virtual methods
.method public add(Lcom/facebook/accountkit/LoggingBehavior;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    invoke-virtual {v1, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public clear()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    invoke-virtual {v1}, Ljava/util/HashSet;->clear()V

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public get()Ljava/util/Set;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Lcom/facebook/accountkit/LoggingBehavior;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    monitor-enter v0

    :try_start_0
    new-instance v1, Ljava/util/HashSet;

    iget-object v2, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public isEnabled(Lcom/facebook/accountkit/LoggingBehavior;)Z
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    invoke-virtual {v1, p1}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result p1

    monitor-exit v0

    return p1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public remove(Lcom/facebook/accountkit/LoggingBehavior;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/facebook/accountkit/LoggingBehaviorCollection;->loggingBehaviors:Ljava/util/HashSet;

    invoke-virtual {v1, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method
