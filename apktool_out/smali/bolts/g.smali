.class public Lbolts/g;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Closeable;


# instance fields
.field private final a:Ljava/lang/Object;

.field private final b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lbolts/f;",
            ">;"
        }
    .end annotation
.end field

.field private c:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field private d:Z

.field private e:Z


# direct methods
.method private b()V
    .locals 2

    iget-boolean v0, p0, Lbolts/g;->e:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Object already closed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method

.method private c()V
    .locals 2

    iget-object v0, p0, Lbolts/g;->c:Ljava/util/concurrent/ScheduledFuture;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lbolts/g;->c:Ljava/util/concurrent/ScheduledFuture;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    const/4 v0, 0x0

    iput-object v0, p0, Lbolts/g;->c:Ljava/util/concurrent/ScheduledFuture;

    :cond_0
    return-void
.end method


# virtual methods
.method a(Lbolts/f;)V
    .locals 2

    iget-object v0, p0, Lbolts/g;->a:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    invoke-direct {p0}, Lbolts/g;->b()V

    iget-object v1, p0, Lbolts/g;->b:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public a()Z
    .locals 2

    iget-object v0, p0, Lbolts/g;->a:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    invoke-direct {p0}, Lbolts/g;->b()V

    iget-boolean v1, p0, Lbolts/g;->d:Z

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public close()V
    .locals 3

    iget-object v0, p0, Lbolts/g;->a:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/g;->e:Z

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    invoke-direct {p0}, Lbolts/g;->c()V

    iget-object v1, p0, Lbolts/g;->b:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lbolts/f;

    invoke-virtual {v2}, Lbolts/f;->close()V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lbolts/g;->b:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lbolts/g;->e:Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v1, "%s@%s[cancellationRequested=%s]"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    aput-object v3, v2, v4

    invoke-virtual {p0}, Lbolts/g;->a()Z

    move-result v3

    invoke-static {v3}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
