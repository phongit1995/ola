.class public Lchat/ola/vn/c/e;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xb
.end annotation


# static fields
.field public static a:I

.field public static b:Ljava/util/concurrent/Executor;

.field private static c:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs a([Lchat/ola/vn/c/f;)V
    .locals 11

    :try_start_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/c/e;->b:Ljava/util/concurrent/Executor;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v0, :cond_1

    :try_start_1
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v0, v0, -0x1

    if-gez v0, :cond_0

    goto :goto_0

    :cond_0
    move v1, v0

    :catch_0
    :goto_0
    :try_start_2
    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    add-int/lit8 v4, v1, 0x1

    const-wide/16 v5, 0x2710

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v8, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x14

    invoke-direct {v8, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v9, Lchat/ola/vn/c/e$1;

    invoke-direct {v9, p0}, Lchat/ola/vn/c/e$1;-><init>(Lchat/ola/vn/c/e;)V

    move-object v2, v0

    move v3, v4

    invoke-direct/range {v2 .. v9}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    sput-object v0, Lchat/ola/vn/c/e;->b:Ljava/util/concurrent/Executor;

    :cond_1
    new-instance v0, Lchat/ola/vn/c/d;

    invoke-direct {v0}, Lchat/ola/vn/c/d;-><init>()V

    sget-object v1, Lchat/ola/vn/c/e;->b:Ljava/util/concurrent/Executor;

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/c/d;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    sget-object v0, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v2, 0xf

    const-wide/16 v3, 0x0

    if-lt v0, v2, :cond_5

    sget-wide v5, Lchat/ola/vn/c/e;->c:J

    cmp-long p1, v5, v3

    if-nez p1, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/c/e;->c:J

    return-void

    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sget-wide v7, Lchat/ola/vn/c/e;->c:J

    const/4 p1, 0x0

    sub-long v9, v5, v7

    const-wide/32 v5, 0xea60

    cmp-long p1, v9, v5

    if-lez p1, :cond_4

    sput-wide v3, Lchat/ola/vn/c/e;->c:J

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/c/d;->a:Ljava/lang/Integer;

    :cond_4
    return-void

    :cond_5
    sput-wide v3, Lchat/ola/vn/c/e;->c:J

    new-instance v0, Lchat/ola/vn/c/d;

    invoke-direct {v0}, Lchat/ola/vn/c/d;-><init>()V

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/d;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
