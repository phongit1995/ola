.class public Lbolts/j;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lbolts/j$a;,
        Lbolts/j$b;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<TResult:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# static fields
.field public static final a:Ljava/util/concurrent/ExecutorService;

.field public static final b:Ljava/util/concurrent/Executor;

.field private static final c:Ljava/util/concurrent/Executor;

.field private static volatile d:Lbolts/j$b;

.field private static m:Lbolts/j;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lbolts/j<",
            "*>;"
        }
    .end annotation
.end field

.field private static n:Lbolts/j;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lbolts/j<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static o:Lbolts/j;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lbolts/j<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static p:Lbolts/j;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lbolts/j<",
            "*>;"
        }
    .end annotation
.end field


# instance fields
.field private final e:Ljava/lang/Object;

.field private f:Z

.field private g:Z

.field private h:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TTResult;"
        }
    .end annotation
.end field

.field private i:Ljava/lang/Exception;

.field private j:Z

.field private k:Lbolts/l;

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lbolts/h<",
            "TTResult;",
            "Ljava/lang/Void;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    invoke-static {}, Lbolts/d;->a()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lbolts/j;->a:Ljava/util/concurrent/ExecutorService;

    invoke-static {}, Lbolts/d;->b()Ljava/util/concurrent/Executor;

    move-result-object v0

    sput-object v0, Lbolts/j;->c:Ljava/util/concurrent/Executor;

    invoke-static {}, Lbolts/a;->b()Ljava/util/concurrent/Executor;

    move-result-object v0

    sput-object v0, Lbolts/j;->b:Ljava/util/concurrent/Executor;

    new-instance v0, Lbolts/j;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lbolts/j;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lbolts/j;->m:Lbolts/j;

    new-instance v0, Lbolts/j;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-direct {v0, v2}, Lbolts/j;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lbolts/j;->n:Lbolts/j;

    new-instance v0, Lbolts/j;

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-direct {v0, v2}, Lbolts/j;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lbolts/j;->o:Lbolts/j;

    new-instance v0, Lbolts/j;

    invoke-direct {v0, v1}, Lbolts/j;-><init>(Z)V

    sput-object v0, Lbolts/j;->p:Lbolts/j;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lbolts/j;->l:Ljava/util/List;

    return-void
.end method

.method private constructor <init>(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TTResult;)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lbolts/j;->l:Ljava/util/List;

    invoke-virtual {p0, p1}, Lbolts/j;->b(Ljava/lang/Object;)Z

    return-void
.end method

.method private constructor <init>(Z)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lbolts/j;->l:Ljava/util/List;

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lbolts/j;->i()Z

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lbolts/j;->b(Ljava/lang/Object;)Z

    return-void
.end method

.method public static a()Lbolts/j$b;
    .locals 1

    sget-object v0, Lbolts/j;->d:Lbolts/j$b;

    return-object v0
.end method

.method public static a(Ljava/lang/Exception;)Lbolts/j;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TResult:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Exception;",
            ")",
            "Lbolts/j<",
            "TTResult;>;"
        }
    .end annotation

    new-instance v0, Lbolts/k;

    invoke-direct {v0}, Lbolts/k;-><init>()V

    invoke-virtual {v0, p0}, Lbolts/k;->b(Ljava/lang/Exception;)V

    invoke-virtual {v0}, Lbolts/k;->a()Lbolts/j;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/Object;)Lbolts/j;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TResult:",
            "Ljava/lang/Object;",
            ">(TTResult;)",
            "Lbolts/j<",
            "TTResult;>;"
        }
    .end annotation

    if-nez p0, :cond_0

    sget-object p0, Lbolts/j;->m:Lbolts/j;

    return-object p0

    :cond_0
    instance-of v0, p0, Ljava/lang/Boolean;

    if-eqz v0, :cond_2

    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    if-eqz p0, :cond_1

    sget-object p0, Lbolts/j;->n:Lbolts/j;

    return-object p0

    :cond_1
    sget-object p0, Lbolts/j;->o:Lbolts/j;

    return-object p0

    :cond_2
    new-instance v0, Lbolts/k;

    invoke-direct {v0}, Lbolts/k;-><init>()V

    invoke-virtual {v0, p0}, Lbolts/k;->b(Ljava/lang/Object;)V

    invoke-virtual {v0}, Lbolts/k;->a()Lbolts/j;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V
    .locals 0

    invoke-static {p0, p1, p2, p3, p4}, Lbolts/j;->c(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V

    return-void
.end method

.method public static b()Lbolts/j$a;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TResult:",
            "Ljava/lang/Object;",
            ">()",
            "Lbolts/j<",
            "TTResult;>.a;"
        }
    .end annotation

    new-instance v0, Lbolts/j;

    invoke-direct {v0}, Lbolts/j;-><init>()V

    new-instance v1, Lbolts/j$a;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v1, v0}, Lbolts/j$a;-><init>(Lbolts/j;)V

    return-object v1
.end method

.method static synthetic b(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V
    .locals 0

    invoke-static {p0, p1, p2, p3, p4}, Lbolts/j;->d(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V

    return-void
.end method

.method private static c(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            "TResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/k<",
            "TTContinuationResult;>;",
            "Lbolts/h<",
            "TTResult;TTContinuationResult;>;",
            "Lbolts/j<",
            "TTResult;>;",
            "Ljava/util/concurrent/Executor;",
            "Lbolts/e;",
            ")V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lbolts/j$4;

    invoke-direct {v0, p4, p0, p1, p2}, Lbolts/j$4;-><init>(Lbolts/e;Lbolts/k;Lbolts/h;Lbolts/j;)V

    invoke-interface {p3, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance p2, Lbolts/ExecutorException;

    invoke-direct {p2, p1}, Lbolts/ExecutorException;-><init>(Ljava/lang/Exception;)V

    invoke-virtual {p0, p2}, Lbolts/k;->b(Ljava/lang/Exception;)V

    return-void
.end method

.method private static d(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            "TResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/k<",
            "TTContinuationResult;>;",
            "Lbolts/h<",
            "TTResult;",
            "Lbolts/j<",
            "TTContinuationResult;>;>;",
            "Lbolts/j<",
            "TTResult;>;",
            "Ljava/util/concurrent/Executor;",
            "Lbolts/e;",
            ")V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lbolts/j$5;

    invoke-direct {v0, p4, p0, p1, p2}, Lbolts/j$5;-><init>(Lbolts/e;Lbolts/k;Lbolts/h;Lbolts/j;)V

    invoke-interface {p3, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance p2, Lbolts/ExecutorException;

    invoke-direct {p2, p1}, Lbolts/ExecutorException;-><init>(Ljava/lang/Exception;)V

    invoke-virtual {p0, p2}, Lbolts/k;->b(Ljava/lang/Exception;)V

    return-void
.end method

.method public static h()Lbolts/j;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TResult:",
            "Ljava/lang/Object;",
            ">()",
            "Lbolts/j<",
            "TTResult;>;"
        }
    .end annotation

    sget-object v0, Lbolts/j;->p:Lbolts/j;

    return-object v0
.end method

.method private j()V
    .locals 3

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lbolts/j;->l:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lbolts/h;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-interface {v2, p0}, Lbolts/h;->then(Lbolts/j;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v1

    :try_start_2
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    :catch_1
    move-exception v1

    throw v1

    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lbolts/j;->l:Ljava/util/List;

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method


# virtual methods
.method public a(Lbolts/h;)Lbolts/j;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/h<",
            "TTResult;TTContinuationResult;>;)",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    sget-object v0, Lbolts/j;->c:Ljava/util/concurrent/Executor;

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lbolts/j;->a(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;

    move-result-object p1

    return-object p1
.end method

.method public a(Lbolts/h;Ljava/util/concurrent/Executor;)Lbolts/j;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/h<",
            "TTResult;",
            "Lbolts/j<",
            "TTContinuationResult;>;>;",
            "Ljava/util/concurrent/Executor;",
            ")",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lbolts/j;->b(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;

    move-result-object p1

    return-object p1
.end method

.method public a(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/h<",
            "TTResult;TTContinuationResult;>;",
            "Ljava/util/concurrent/Executor;",
            "Lbolts/e;",
            ")",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    new-instance v6, Lbolts/k;

    invoke-direct {v6}, Lbolts/k;-><init>()V

    iget-object v7, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v7

    :try_start_0
    invoke-virtual {p0}, Lbolts/j;->c()Z

    move-result v8

    if-nez v8, :cond_0

    iget-object v9, p0, Lbolts/j;->l:Ljava/util/List;

    new-instance v10, Lbolts/j$1;

    move-object v0, v10

    move-object v1, p0

    move-object v2, v6

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lbolts/j$1;-><init>(Lbolts/j;Lbolts/k;Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)V

    invoke-interface {v9, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v8, :cond_1

    invoke-static {v6, p1, p0, p2, p3}, Lbolts/j;->c(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V

    :cond_1
    invoke-virtual {v6}, Lbolts/k;->a()Lbolts/j;

    move-result-object p1

    return-object p1

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public b(Lbolts/h;)Lbolts/j;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/h<",
            "TTResult;TTContinuationResult;>;)",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    sget-object v0, Lbolts/j;->c:Ljava/util/concurrent/Executor;

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lbolts/j;->c(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;

    move-result-object p1

    return-object p1
.end method

.method public b(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/h<",
            "TTResult;",
            "Lbolts/j<",
            "TTContinuationResult;>;>;",
            "Ljava/util/concurrent/Executor;",
            "Lbolts/e;",
            ")",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    new-instance v6, Lbolts/k;

    invoke-direct {v6}, Lbolts/k;-><init>()V

    iget-object v7, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v7

    :try_start_0
    invoke-virtual {p0}, Lbolts/j;->c()Z

    move-result v8

    if-nez v8, :cond_0

    iget-object v9, p0, Lbolts/j;->l:Ljava/util/List;

    new-instance v10, Lbolts/j$2;

    move-object v0, v10

    move-object v1, p0

    move-object v2, v6

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lbolts/j$2;-><init>(Lbolts/j;Lbolts/k;Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)V

    invoke-interface {v9, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v8, :cond_1

    invoke-static {v6, p1, p0, p2, p3}, Lbolts/j;->d(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V

    :cond_1
    invoke-virtual {v6}, Lbolts/k;->a()Lbolts/j;

    move-result-object p1

    return-object p1

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method b(Ljava/lang/Exception;)Z
    .locals 3

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/j;->f:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    monitor-exit v0

    return v2

    :cond_0
    const/4 v1, 0x1

    iput-boolean v1, p0, Lbolts/j;->f:Z

    iput-object p1, p0, Lbolts/j;->i:Ljava/lang/Exception;

    iput-boolean v2, p0, Lbolts/j;->j:Z

    iget-object p1, p0, Lbolts/j;->e:Ljava/lang/Object;

    invoke-virtual {p1}, Ljava/lang/Object;->notifyAll()V

    invoke-direct {p0}, Lbolts/j;->j()V

    iget-boolean p1, p0, Lbolts/j;->j:Z

    if-nez p1, :cond_1

    invoke-static {}, Lbolts/j;->a()Lbolts/j$b;

    move-result-object p1

    if-eqz p1, :cond_1

    new-instance p1, Lbolts/l;

    invoke-direct {p1, p0}, Lbolts/l;-><init>(Lbolts/j;)V

    iput-object p1, p0, Lbolts/j;->k:Lbolts/l;

    :cond_1
    monitor-exit v0

    return v1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method b(Ljava/lang/Object;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TTResult;)Z"
        }
    .end annotation

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/j;->f:Z

    if-eqz v1, :cond_0

    const/4 p1, 0x0

    monitor-exit v0

    return p1

    :cond_0
    const/4 v1, 0x1

    iput-boolean v1, p0, Lbolts/j;->f:Z

    iput-object p1, p0, Lbolts/j;->h:Ljava/lang/Object;

    iget-object p1, p0, Lbolts/j;->e:Ljava/lang/Object;

    invoke-virtual {p1}, Ljava/lang/Object;->notifyAll()V

    invoke-direct {p0}, Lbolts/j;->j()V

    monitor-exit v0

    return v1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public c(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TContinuationResult:",
            "Ljava/lang/Object;",
            ">(",
            "Lbolts/h<",
            "TTResult;TTContinuationResult;>;",
            "Ljava/util/concurrent/Executor;",
            "Lbolts/e;",
            ")",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    new-instance v0, Lbolts/j$3;

    invoke-direct {v0, p0, p3, p1}, Lbolts/j$3;-><init>(Lbolts/j;Lbolts/e;Lbolts/h;)V

    invoke-virtual {p0, v0, p2}, Lbolts/j;->a(Lbolts/h;Ljava/util/concurrent/Executor;)Lbolts/j;

    move-result-object p1

    return-object p1
.end method

.method public c()Z
    .locals 2

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/j;->f:Z

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public d()Z
    .locals 2

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/j;->g:Z

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public e()Z
    .locals 2

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Lbolts/j;->g()Ljava/lang/Exception;

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public f()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TTResult;"
        }
    .end annotation

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lbolts/j;->h:Ljava/lang/Object;

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public g()Ljava/lang/Exception;
    .locals 2

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lbolts/j;->i:Ljava/lang/Exception;

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    iput-boolean v1, p0, Lbolts/j;->j:Z

    iget-object v1, p0, Lbolts/j;->k:Lbolts/l;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lbolts/j;->k:Lbolts/l;

    invoke-virtual {v1}, Lbolts/l;->a()V

    const/4 v1, 0x0

    iput-object v1, p0, Lbolts/j;->k:Lbolts/l;

    :cond_0
    iget-object v1, p0, Lbolts/j;->i:Ljava/lang/Exception;

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method i()Z
    .locals 3

    iget-object v0, p0, Lbolts/j;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-boolean v1, p0, Lbolts/j;->f:Z

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    monitor-exit v0

    return v1

    :cond_0
    const/4 v1, 0x1

    iput-boolean v1, p0, Lbolts/j;->f:Z

    iput-boolean v1, p0, Lbolts/j;->g:Z

    iget-object v2, p0, Lbolts/j;->e:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->notifyAll()V

    invoke-direct {p0}, Lbolts/j;->j()V

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
