.class public Lbolts/f;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Closeable;


# instance fields
.field private final a:Ljava/lang/Object;

.field private b:Lbolts/g;

.field private c:Ljava/lang/Runnable;

.field private d:Z


# virtual methods
.method public close()V
    .locals 2

    iget-object v0, p0, Lbolts/f;->a:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/f;->d:Z

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    const/4 v1, 0x1

    iput-boolean v1, p0, Lbolts/f;->d:Z

    iget-object v1, p0, Lbolts/f;->b:Lbolts/g;

    invoke-virtual {v1, p0}, Lbolts/g;->a(Lbolts/f;)V

    const/4 v1, 0x0

    iput-object v1, p0, Lbolts/f;->b:Lbolts/g;

    iput-object v1, p0, Lbolts/f;->c:Ljava/lang/Runnable;

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
