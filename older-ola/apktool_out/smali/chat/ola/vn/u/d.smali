.class Lchat/ola/vn/u/d;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static h:Lchat/ola/vn/u/d;


# instance fields
.field protected a:Ljava/net/Socket;

.field protected b:Lchat/ola/vn/u/n;

.field protected c:Lchat/ola/vn/u/h;

.field d:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;"
        }
    .end annotation
.end field

.field private f:Ljava/lang/Runnable;

.field private g:Ljava/util/concurrent/LinkedBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/LinkedBlockingQueue<",
            "Lchat/ola/vn/u/e;",
            ">;"
        }
    .end annotation
.end field

.field private i:Ljava/util/concurrent/ExecutorService;


# direct methods
.method private constructor <init>()V
    .locals 10

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/u/d;->f:Ljava/lang/Runnable;

    iput-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;

    iput-object v0, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    iput-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    sget-object v1, Lchat/ola/vn/f/d;->f_:[Ljava/lang/String;

    array-length v1, v1

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    sget-object v1, Lchat/ola/vn/f/d;->f_:[Ljava/lang/String;

    aget-object v1, v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x1

    move v4, v0

    const/4 v0, 0x0

    const/4 v5, 0x0

    :goto_0
    if-nez v0, :cond_3

    :try_start_0
    new-instance v6, Ljava/net/Socket;

    invoke-direct {v6}, Ljava/net/Socket;-><init>()V

    iput-object v6, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    new-instance v6, Ljava/net/InetSocketAddress;

    const/16 v7, 0x4d8

    invoke-direct {v6, v1, v7}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    iget-object v7, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    const/16 v8, 0x7530

    invoke-virtual {v7, v6, v8}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    iget-object v6, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    invoke-virtual {v6, v3}, Ljava/net/Socket;->setKeepAlive(Z)V

    new-instance v6, Lchat/ola/vn/u/n;

    iget-object v7, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    invoke-virtual {v7}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v7

    invoke-direct {v6, v7}, Lchat/ola/vn/u/n;-><init>(Ljava/io/OutputStream;)V

    iput-object v6, p0, Lchat/ola/vn/u/d;->b:Lchat/ola/vn/u/n;

    new-instance v6, Lchat/ola/vn/u/h;

    iget-object v7, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    invoke-virtual {v7}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v7

    invoke-direct {v6, v7, p0}, Lchat/ola/vn/u/h;-><init>(Ljava/io/InputStream;Lchat/ola/vn/u/d;)V

    iput-object v6, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    goto :goto_0

    :catch_0
    move-exception v1

    add-int/lit8 v5, v5, 0x1

    sget-object v6, Lchat/ola/vn/f/d;->f_:[Ljava/lang/String;

    array-length v6, v6

    if-ne v5, v6, :cond_0

    const-string v1, "stinger.ola.vn"

    goto :goto_0

    :cond_0
    sget-object v6, Lchat/ola/vn/f/d;->f_:[Ljava/lang/String;

    array-length v6, v6

    add-int/2addr v6, v3

    if-lt v5, v6, :cond_1

    throw v1

    :cond_1
    add-int/lit8 v1, v4, 0x1

    sget-object v4, Lchat/ola/vn/f/d;->f_:[Ljava/lang/String;

    array-length v4, v4

    if-lt v1, v4, :cond_2

    const/4 v1, 0x0

    :cond_2
    sget-object v4, Lchat/ola/vn/f/d;->f_:[Ljava/lang/String;

    aget-object v4, v4, v1

    move-object v9, v4

    move v4, v1

    move-object v1, v9

    goto :goto_0

    :cond_3
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;

    iget-object v1, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/u/h;->a(Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/u/d$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/u/d$1;-><init>(Lchat/ola/vn/u/d;)V

    iput-object v0, p0, Lchat/ola/vn/u/d;->f:Ljava/lang/Runnable;

    new-instance v0, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    iget-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    if-nez v0, :cond_4

    invoke-static {v3}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    iget-object v1, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    invoke-static {}, Lchat/ola/vn/h;->e()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    invoke-interface {v0, p0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/u/d;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    return-object p0
.end method

.method public static declared-synchronized d()Lchat/ola/vn/u/d;
    .locals 2

    const-class v0, Lchat/ola/vn/u/d;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lchat/ola/vn/u/d;->h:Lchat/ola/vn/u/d;

    if-nez v1, :cond_0

    new-instance v1, Lchat/ola/vn/u/d;

    invoke-direct {v1}, Lchat/ola/vn/u/d;-><init>()V

    sput-object v1, Lchat/ola/vn/u/d;->h:Lchat/ola/vn/u/d;

    :cond_0
    sget-object v1, Lchat/ola/vn/u/d;->h:Lchat/ola/vn/u/d;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method declared-synchronized a()V
    .locals 3

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :cond_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/u/d;->f:Ljava/lang/Runnable;

    const-wide/32 v1, 0x2bf20

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_1
    :goto_0
    monitor-exit p0

    return-void
.end method

.method public a(Lchat/ola/vn/u/e;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/LinkedBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Lchat/ola/vn/u/g;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_2

    iget-object v2, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/u/g;

    invoke-interface {v2}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    iget-object v0, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public declared-synchronized a(Ljava/lang/String;)V
    .locals 3

    monitor-enter p0

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/u/g;

    invoke-interface {v2}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1

    :catch_0
    :cond_1
    monitor-exit p0

    return-void
.end method

.method declared-synchronized b()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/u/g;

    invoke-interface {v1}, Lchat/ola/vn/u/g;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_0
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/u/d;->c()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-void

    :goto_1
    monitor-exit p0

    throw v0
.end method

.method public b(Lchat/ola/vn/u/e;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->Q:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lchat/ola/vn/u/d$2;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/u/d$2;-><init>(Lchat/ola/vn/u/d;Lchat/ola/vn/u/e;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public declared-synchronized c()V
    .locals 3

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    if-nez v0, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    const/4 v0, 0x0

    :try_start_1
    iput-object v0, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;

    iget-object v2, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-virtual {v1, v2}, Lchat/ola/vn/u/h;->a(Ljava/util/List;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    :cond_1
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/u/d;->b:Lchat/ola/vn/u/n;

    invoke-virtual {v1}, Lchat/ola/vn/u/n;->a()V

    iput-object v0, p0, Lchat/ola/vn/u/d;->b:Lchat/ola/vn/u/n;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    :catch_0
    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;

    invoke-virtual {v1}, Lchat/ola/vn/u/h;->a()V

    iput-object v0, p0, Lchat/ola/vn/u/d;->c:Lchat/ola/vn/u/h;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_4

    :catch_1
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :catch_2
    :try_start_5
    iput-object v0, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    goto :goto_0

    :catchall_0
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/u/d;->a:Ljava/net/Socket;

    throw v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    :goto_0
    :try_start_6
    iget-object v1, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;

    const/4 v2, 0x1

    invoke-interface {v1, v2}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    :try_start_7
    iput-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;

    :goto_1
    iput-object v0, p0, Lchat/ola/vn/u/d;->f:Ljava/lang/Runnable;

    goto :goto_2

    :catchall_1
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;

    iput-object v0, p0, Lchat/ola/vn/u/d;->f:Ljava/lang/Runnable;

    throw v1

    :catch_3
    iput-object v0, p0, Lchat/ola/vn/u/d;->d:Ljava/util/concurrent/ScheduledFuture;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    goto :goto_1

    :goto_2
    :try_start_8
    iget-object v1, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v1}, Ljava/util/concurrent/LinkedBlockingQueue;->clear()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    :catch_4
    :try_start_9
    iput-object v0, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    goto :goto_3

    :catchall_2
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    throw v1

    :goto_3
    invoke-static {}, Lchat/ola/vn/h;->d()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    :try_start_a
    iget-object v1, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v1}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_5
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    :try_start_b
    iput-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    :goto_4
    sput-object v0, Lchat/ola/vn/u/d;->h:Lchat/ola/vn/u/d;

    goto :goto_5

    :catchall_3
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;

    sput-object v0, Lchat/ola/vn/u/d;->h:Lchat/ola/vn/u/d;

    throw v1

    :catch_5
    iput-object v0, p0, Lchat/ola/vn/u/d;->i:Ljava/util/concurrent/ExecutorService;
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    goto :goto_4

    :goto_5
    monitor-exit p0

    return-void

    :catchall_4
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public run()V
    .locals 4

    const/4 v0, 0x1

    :goto_0
    if-eqz v0, :cond_1

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/d;->g:Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v1}, Ljava/util/concurrent/LinkedBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/u/e;

    iget-short v2, v1, Lchat/ola/vn/u/e;->j:S

    invoke-static {v2}, Lchat/ola/vn/u/k;->a(S)Lchat/ola/vn/u/a;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v3, p0, Lchat/ola/vn/u/d;->e:Ljava/util/List;

    invoke-interface {v2, v1, v3}, Lchat/ola/vn/u/a;->a(Lchat/ola/vn/u/e;Ljava/util/List;)Lchat/ola/vn/w/cg;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lchat/ola/vn/u/d;->b:Lchat/ola/vn/u/n;

    invoke-virtual {v2, v1}, Lchat/ola/vn/u/n;->a(Lchat/ola/vn/w/cg;)V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/u/d;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    invoke-virtual {p0}, Lchat/ola/vn/u/d;->b()V

    goto :goto_0

    :cond_1
    return-void
.end method
