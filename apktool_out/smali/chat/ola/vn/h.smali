.class public Lchat/ola/vn/h;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field public static A:I = 0x0

.field public static B:Ljava/lang/Integer; = null

.field public static C:Ljava/lang/Integer; = null

.field public static D:Ljava/lang/Integer; = null

.field public static E:J = 0x0L

.field public static F:Z = true

.field public static G:I = 0x0

.field public static H:S = 0x0s

.field public static I:Z = false

.field public static J:Z = false

.field public static K:I = 0x0

.field public static L:Ljava/lang/String; = null

.field public static M:Ljava/lang/String; = null

.field public static N:Ljava/lang/String; = null

.field public static O:Lchat/ola/vn/entity/ag; = null

.field public static P:Ljava/util/concurrent/ScheduledExecutorService; = null

.field public static Q:Ljava/util/concurrent/ExecutorService; = null

.field public static R:Ljava/util/concurrent/ExecutorService; = null

.field public static S:Ljava/lang/String; = null

.field public static T:Ljava/lang/String; = "US"

.field private static U:Ljava/lang/String; = null

.field private static V:Ljava/lang/String; = null

.field private static W:Ljava/lang/String; = null

.field private static X:Ljava/lang/String; = null

.field private static Y:I = 0x0

.field private static Z:Ljava/util/concurrent/ExecutorService; = null

.field public static a:Z = false

.field public static b:Z = false

.field public static c:I = 0x0

.field public static d:I = 0x0

.field public static e:Ljava/lang/String; = null

.field public static f:Ljava/lang/String; = null

.field public static g:Ljava/lang/String; = null

.field public static h:Z = false

.field public static i:I = 0x0

.field public static j:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static k:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static l:Z = false

.field public static m:J = 0x7fffffffffffffffL

.field public static n:J = 0x0L

.field public static o:J = 0x0L

.field public static p:J = -0x1L

.field public static q:I = -0x1

.field public static r:I

.field public static s:Lchat/ola/vn/r/b;

.field public static t:Lchat/ola/vn/message/g;

.field public static u:Lchat/ola/vn/r/a/e;

.field public static v:Lchat/ola/vn/r/a/c;

.field public static w:Lchat/ola/vn/r/a;

.field public static x:Lchat/ola/vn/r/a/f;

.field public static y:J

.field public static z:I


# direct methods
.method static constructor <clinit>()V
    .locals 19

    new-instance v0, Lchat/ola/vn/r/b;

    invoke-direct {v0}, Lchat/ola/vn/r/b;-><init>()V

    sput-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    new-instance v0, Lchat/ola/vn/message/g;

    invoke-direct {v0}, Lchat/ola/vn/message/g;-><init>()V

    sput-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    new-instance v0, Lchat/ola/vn/r/a/e;

    invoke-direct {v0}, Lchat/ola/vn/r/a/e;-><init>()V

    sput-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    new-instance v0, Lchat/ola/vn/r/a/c;

    invoke-direct {v0}, Lchat/ola/vn/r/a/c;-><init>()V

    sput-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    new-instance v0, Lchat/ola/vn/r/a/b;

    invoke-direct {v0}, Lchat/ola/vn/r/a/b;-><init>()V

    sput-object v0, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    new-instance v0, Lchat/ola/vn/r/a/f;

    invoke-direct {v0}, Lchat/ola/vn/r/a/f;-><init>()V

    sput-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    new-instance v0, Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    new-instance v1, Lchat/ola/vn/h$1;

    invoke-direct {v1}, Lchat/ola/vn/h$1;-><init>()V

    const/4 v2, 0x1

    invoke-direct {v0, v2, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;-><init>(ILjava/util/concurrent/ThreadFactory;)V

    sput-object v0, Lchat/ola/vn/h;->P:Ljava/util/concurrent/ScheduledExecutorService;

    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v8, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v9, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v9}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    new-instance v10, Lchat/ola/vn/h$2;

    invoke-direct {v10}, Lchat/ola/vn/h$2;-><init>()V

    const/4 v4, 0x1

    const/4 v5, 0x1

    const-wide/16 v6, 0x2710

    move-object v3, v0

    invoke-direct/range {v3 .. v10}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    sput-object v0, Lchat/ola/vn/h;->Q:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v16, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v1, Ljava/util/concurrent/LinkedBlockingQueue;

    const/4 v2, 0x5

    invoke-direct {v1, v2}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v2, Lchat/ola/vn/h$3;

    invoke-direct {v2}, Lchat/ola/vn/h$3;-><init>()V

    const/4 v12, 0x1

    const/4 v13, 0x2

    const-wide/16 v14, 0x1388

    move-object v11, v0

    move-object/from16 v17, v1

    move-object/from16 v18, v2

    invoke-direct/range {v11 .. v18}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    sput-object v0, Lchat/ola/vn/h;->R:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public static a()Ljava/lang/String;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    sget-object v0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    return-object v0
.end method

.method public static a(Ljava/lang/Runnable;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->R:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0, p0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string v0, "OlaChat"

    const-string v1, "---executeShortTask---"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method public static a(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    const-string v0, "fb:"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p0, :cond_0

    const/4 p0, 0x0

    return p0

    :catch_0
    :cond_0
    const/4 p0, 0x1

    return p0
.end method

.method public static b()Ljava/lang/String;
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->V:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/h/b;->c(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/h;->V:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    sget-object v0, Lchat/ola/vn/h;->V:Ljava/lang/String;

    return-object v0
.end method

.method public static b(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lchat/ola/vn/h;->V:Ljava/lang/String;

    return-void
.end method

.method public static c()Ljava/lang/String;
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->W:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/h/b;->d(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/h;->W:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    sget-object v0, Lchat/ola/vn/h;->W:Ljava/lang/String;

    return-object v0
.end method

.method public static c(Ljava/lang/String;)V
    .locals 1

    sput-object p0, Lchat/ola/vn/h;->X:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p0}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V

    return-void
.end method

.method public static d()V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/h;->Z:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v1}, Ljava/util/concurrent/ExecutorService;->shutdown()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    sput-object v0, Lchat/ola/vn/h;->Z:Ljava/util/concurrent/ExecutorService;

    throw v1

    :catch_0
    :goto_0
    sput-object v0, Lchat/ola/vn/h;->Z:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public static d(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->g()V

    sget-object p0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p0}, Lchat/ola/vn/message/g;->k()V

    sget-object p0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p0}, Lchat/ola/vn/r/a/e;->e()V

    sget-object p0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p0}, Lchat/ola/vn/r/b;->j()V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-nez v0, :cond_3

    const/4 v0, 0x0

    if-eqz p0, :cond_1

    :try_start_1
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    goto :goto_0

    :cond_1
    sput-object v0, Lchat/ola/vn/h;->U:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :try_start_2
    sput-object v0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    :goto_0
    sput-object v0, Lchat/ola/vn/h;->V:Ljava/lang/String;

    sput-object v0, Lchat/ola/vn/h;->W:Ljava/lang/String;

    sput-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    sput-object v0, Lchat/ola/vn/h;->X:Ljava/lang/String;

    const/4 p0, 0x0

    sput-short p0, Lchat/ola/vn/h;->H:S

    invoke-static {}, Lchat/ola/vn/c/x;->g()V

    sget-object p0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p0}, Lchat/ola/vn/message/g;->k()V

    sget-object p0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p0}, Lchat/ola/vn/r/a/e;->e()V

    sget-object p0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p0}, Lchat/ola/vn/r/b;->j()V

    sget-object p0, Lchat/ola/vn/h;->U:Ljava/lang/String;

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    if-nez p0, :cond_2

    :try_start_3
    new-instance p0, Lchat/ola/vn/h$5;

    invoke-direct {p0}, Lchat/ola/vn/h$5;-><init>()V

    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :try_start_4
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/h/b;->p(Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    invoke-static {}, Lchat/ola/vn/h/b;->e()Ljava/util/List;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/h/b;->s(Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/h$6;

    invoke-direct {v2, v0, v1, p0}, Lchat/ola/vn/h$6;-><init>(Ljava/util/List;Ljava/util/List;Ljava/util/List;)V

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    return-void

    :cond_2
    :try_start_5
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, v0}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0, v0}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    return-void

    :catch_2
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_3
    :cond_3
    return-void
.end method

.method public static e()Ljava/util/concurrent/ExecutorService;
    .locals 10

    sget-object v0, Lchat/ola/vn/h;->Z:Ljava/util/concurrent/ExecutorService;

    if-nez v0, :cond_1

    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0

    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    new-instance v9, Ljava/util/concurrent/ThreadPoolExecutor;

    add-int/lit8 v3, v0, 0x2

    const-wide/16 v4, 0x1388

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v7, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v7}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    new-instance v8, Lchat/ola/vn/h$4;

    invoke-direct {v8}, Lchat/ola/vn/h$4;-><init>()V

    move-object v1, v9

    move v2, v3

    invoke-direct/range {v1 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    sput-object v9, Lchat/ola/vn/h;->Z:Ljava/util/concurrent/ExecutorService;

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->Z:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method public static f()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->X:Ljava/lang/String;

    if-nez v0, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->j()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/h;->X:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    sget-object v0, Lchat/ola/vn/h;->X:Ljava/lang/String;

    return-object v0
.end method

.method public static g()Z
    .locals 1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public static h()Z
    .locals 1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public static i()Z
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->T:Ljava/lang/String;

    const-string v1, "VN"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic j()I
    .locals 1

    sget v0, Lchat/ola/vn/h;->Y:I

    return v0
.end method

.method static synthetic k()I
    .locals 1

    sget v0, Lchat/ola/vn/h;->Y:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lchat/ola/vn/h;->Y:I

    return v0
.end method
