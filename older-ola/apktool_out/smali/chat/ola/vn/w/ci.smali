.class public Lchat/ola/vn/w/ci;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/d;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field private A:J

.field private B:J

.field private C:J

.field private D:J

.field private E:J

.field private F:J

.field private G:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/w/bk;",
            ">;"
        }
    .end annotation
.end field

.field public e:J

.field f:Ljava/lang/String;

.field g:Ljava/lang/String;

.field h:Ljava/lang/String;

.field i:Ljava/lang/String;

.field j:Ljava/lang/String;

.field k:Ljava/lang/String;

.field l:Ljava/lang/String;

.field m:Ljava/lang/String;

.field n:I

.field o:S

.field p:S

.field q:J

.field r:J

.field s:I

.field private t:Lchat/ola/vn/w/dr;

.field private u:Lchat/ola/vn/w/dq;

.field private v:Lchat/ola/vn/p/g;

.field private w:[B

.field private x:J

.field private y:Lchat/ola/vn/entity/c;

.field private z:Z


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/w/ci;->g:Ljava/lang/String;

    const/4 v0, 0x0

    iput-short v0, p0, Lchat/ola/vn/w/ci;->o:S

    iput-short v0, p0, Lchat/ola/vn/w/ci;->p:S

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->q:J

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->r:J

    const/4 v3, 0x3

    iput v3, p0, Lchat/ola/vn/w/ci;->s:I

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->A:J

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->B:J

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->C:J

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->D:J

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->E:J

    iput-wide v1, p0, Lchat/ola/vn/w/ci;->F:J

    iput-boolean v0, p0, Lchat/ola/vn/w/ci;->z:Z

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/w/ci;->m:Ljava/lang/String;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/w/ci;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    return-object p0
.end method

.method private a(B)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$55;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$55;-><init>(Lchat/ola/vn/w/ci;B)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(BBLjava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 10

    new-instance v9, Lchat/ola/vn/w/ci$50;

    move-object v0, v9

    move-object v1, p0

    move v2, p1

    move v3, p2

    move-object v4, p4

    move-object v5, p3

    move-object v6, p5

    move-object/from16 v7, p6

    move/from16 v8, p7

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/w/ci$50;-><init>(Lchat/ola/vn/w/ci;BB[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    move-object v0, p0

    invoke-direct {v0, v9}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(BLjava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xbe

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->as:B

    iput-object p2, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method private a(BLjava/lang/String;JS)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$17;

    move-object v0, v7

    move-object v1, p0

    move v2, p1

    move-object v3, p2

    move-wide v4, p3

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$17;-><init>(Lchat/ola/vn/w/ci;BLjava/lang/String;JS)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xac

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->as:B

    iput-object p2, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iput-object p3, v0, Lchat/ola/vn/w/bk;->L:Ljava/lang/String;

    iput-object p4, v0, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iput-short p5, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method private a(BLjava/lang/String;Ljava/lang/String;SS)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$43;

    move-object v0, v7

    move-object v1, p0

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$43;-><init>(Lchat/ola/vn/w/ci;BLjava/lang/String;Ljava/lang/String;SS)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->f(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(BLjava/lang/String;SLjava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$52;

    move-object v0, v7

    move-object v1, p0

    move v2, p1

    move v3, p3

    move-object v4, p2

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$52;-><init>(Lchat/ola/vn/w/ci;BSLjava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->e(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(BLjava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$53;

    move-object v0, v6

    move-object v1, p0

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$53;-><init>(Lchat/ola/vn/w/ci;BLjava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->d(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$28;

    move-object v0, v7

    move-object v1, p0

    move v2, p1

    move-object v3, p3

    move-object v4, p4

    move-object v5, p2

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$28;-><init>(Lchat/ola/vn/w/ci;B[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(IB)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$58;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$58;-><init>(Lchat/ola/vn/w/ci;IB)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(Lchat/ola/vn/w/bk;)V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method private a(Lchat/ola/vn/w/bk;ZZ)V
    .locals 1

    if-eqz p2, :cond_0

    iget-boolean p2, p0, Lchat/ola/vn/w/ci;->z:Z

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    monitor-enter p2

    :try_start_0
    iget-object p3, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    invoke-interface {p3, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit p2

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    sget-object p2, Lchat/ola/vn/h;->Q:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lchat/ola/vn/w/ci$14;

    invoke-direct {v0, p0, p1, p3}, Lchat/ola/vn/w/ci$14;-><init>(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;Z)V

    invoke-interface {p2, v0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->A:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0x1388

    cmp-long v6, v4, v2

    if-gez v6, :cond_0

    sub-long v6, v2, v4

    add-long v2, v0, v6

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->A:J

    invoke-static {p1, v6, v7}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    iput-wide v0, p0, Lchat/ola/vn/w/ci;->A:J

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Ljava/lang/String;BS)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa7

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-byte p2, v0, Lchat/ola/vn/w/bk;->aq:B

    iput-short p3, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$27;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$27;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Z)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(Ljava/lang/String;SS)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa0

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    iput-short p2, v0, Lchat/ola/vn/w/bk;->ac:S

    iput-short p3, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method private a(Ljava/lang/String;Z)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x49

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-boolean p2, v0, Lchat/ola/vn/w/bk;->aw:Z

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method private a([Ljava/lang/String;S)V
    .locals 4

    if-eqz p1, :cond_2

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    aget-object v1, p1, v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x1

    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ";"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v3, p1, v1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    new-instance p1, Lchat/ola/vn/w/bk;

    const/16 v1, 0x95

    invoke-direct {p1, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-short p2, p1, Lchat/ola/vn/w/bk;->af:S

    invoke-direct {p0, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    :cond_2
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/w/ci;)Lchat/ola/vn/p/g;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    return-object p0
.end method

.method private b(BLjava/lang/String;JS)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xbd

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->as:B

    iput-object p2, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-wide p3, v0, Lchat/ola/vn/w/bk;->W:J

    iput-short p5, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method private b(BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$49;

    move-object v0, v7

    move-object v1, p0

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$49;-><init>(Lchat/ola/vn/w/ci;BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private b(Ljava/lang/Runnable;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->B:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0x1f4

    cmp-long v6, v4, v2

    if-gez v6, :cond_0

    sub-long v6, v2, v4

    add-long v2, v0, v6

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->B:J

    invoke-static {p1, v6, v7}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    iput-wide v0, p0, Lchat/ola/vn/w/ci;->B:J

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private c(Ljava/lang/Runnable;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->F:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0xbb8

    cmp-long v6, v4, v2

    if-gez v6, :cond_0

    sub-long v6, v2, v4

    add-long v2, v0, v6

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->F:J

    invoke-static {p1, v6, v7}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    iput-wide v0, p0, Lchat/ola/vn/w/ci;->F:J

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private c(Ljava/lang/String;SLjava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$29;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$29;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SLjava/lang/String;S)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/w/ci;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/w/ci;->z:Z

    return p0
.end method

.method static synthetic d(Lchat/ola/vn/w/ci;)Lchat/ola/vn/w/dr;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    return-object p0
.end method

.method private d(Ljava/lang/Runnable;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->C:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0x1388

    cmp-long v6, v4, v2

    if-gez v6, :cond_0

    sub-long v6, v2, v4

    add-long v2, v0, v6

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->C:J

    invoke-static {p1, v6, v7}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    iput-wide v0, p0, Lchat/ola/vn/w/ci;->C:J

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/w/ci;)Lchat/ola/vn/entity/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    return-object p0
.end method

.method private e(Ljava/lang/Runnable;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->D:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0x1f4

    cmp-long v6, v4, v2

    if-gez v6, :cond_0

    sub-long v6, v2, v4

    add-long v2, v0, v6

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->D:J

    invoke-static {p1, v6, v7}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    iput-wide v0, p0, Lchat/ola/vn/w/ci;->D:J

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private f(Ljava/lang/Runnable;)V
    .locals 8

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->E:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0x2710

    cmp-long v6, v4, v2

    if-gez v6, :cond_0

    sub-long v6, v2, v4

    add-long v2, v0, v6

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->E:J

    invoke-static {p1, v6, v7}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    iput-wide v0, p0, Lchat/ola/vn/w/ci;->E:J

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic f(Lchat/ola/vn/w/ci;)[B
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/w/ci;->w:[B

    return-object p0
.end method


# virtual methods
.method a()V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x60

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->c()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->g:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->f()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->d()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->g()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->a()I

    move-result v1

    iput v1, v0, Lchat/ola/vn/w/bk;->X:I

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->b()I

    move-result v1

    iput v1, v0, Lchat/ola/vn/w/bk;->Y:I

    iget-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    invoke-virtual {v1}, Lchat/ola/vn/entity/c;->e()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public a(I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$2;-><init>(Lchat/ola/vn/w/ci;I)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(J)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$16;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$16;-><init>(Lchat/ola/vn/w/ci;J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JJS)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$6;

    move-object v0, v7

    move-object v1, p0

    move-wide v2, p3

    move-wide v4, p1

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$6;-><init>(Lchat/ola/vn/w/ci;JJS)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JLjava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$22;

    move-object v0, v6

    move-object v1, p0

    move v2, p4

    move-wide v3, p1

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$22;-><init>(Lchat/ola/vn/w/ci;SJLjava/lang/String;)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$5;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$5;-><init>(Lchat/ola/vn/w/ci;JS)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JZLjava/lang/String;Ljava/lang/String;S)V
    .locals 9

    new-instance v8, Lchat/ola/vn/w/ci$19;

    move-object v0, v8

    move-object v1, p0

    move v2, p6

    move-wide v3, p1

    move-object v5, p4

    move-object v6, p5

    move v7, p3

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/w/ci$19;-><init>(Lchat/ola/vn/w/ci;SJLjava/lang/String;Ljava/lang/String;Z)V

    invoke-direct {p0, v8}, Lchat/ola/vn/w/ci;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JZS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$33;

    move-object v0, v6

    move-object v1, p0

    move-wide v2, p1

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$33;-><init>(Lchat/ola/vn/w/ci;JZS)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    return-void
.end method

.method public a(Lchat/ola/vn/p/g;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    iget-object p1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    iget-object v0, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/dq;->a(Lchat/ola/vn/p/g;)V

    iget-object p1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    invoke-virtual {p1, p0}, Lchat/ola/vn/w/dq;->a(Lchat/ola/vn/w/ci;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    iget-object v0, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/dr;->a(Lchat/ola/vn/p/g;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/io/InputStream;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/dq;

    invoke-direct {v0, p1}, Lchat/ola/vn/w/dq;-><init>(Ljava/io/InputStream;)V

    iput-object v0, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    iget-object p1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    iget-object v0, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/dq;->a(Lchat/ola/vn/p/g;)V

    iget-object p1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    invoke-virtual {p1, p0}, Lchat/ola/vn/w/dq;->a(Lchat/ola/vn/w/ci;)V

    return-void
.end method

.method public a(Ljava/io/OutputStream;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/dr;

    invoke-direct {v0, p1}, Lchat/ola/vn/w/dr;-><init>(Ljava/io/OutputStream;)V

    iput-object v0, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    iget-object p1, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    iget-object v0, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/dr;->a(Lchat/ola/vn/p/g;)V

    iget-object p1, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    invoke-virtual {p1, p0}, Lchat/ola/vn/w/dr;->a(Lchat/ola/vn/w/ci;)V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/w/ci$51;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$51;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;BLjava/lang/String;S)V
    .locals 6

    const/4 v1, 0x0

    move-object v0, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;BLjava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;ISS)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput p2, v0, Lchat/ola/vn/w/bk;->Z:I

    iput-short p3, v0, Lchat/ola/vn/w/bk;->ad:S

    iput-short p4, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;BS)V
    .locals 11

    const/4 v5, 0x2

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-object v4, p4

    move/from16 v6, p5

    move-object/from16 v7, p6

    move/from16 v9, p7

    move/from16 v10, p8

    invoke-virtual/range {v0 .. v10}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;Ljava/lang/String;BS)V

    return-void
.end method

.method public a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;Ljava/lang/String;BS)V
    .locals 13

    new-instance v12, Lchat/ola/vn/w/ci$15;

    move-object v0, v12

    move-object v1, p0

    move-object v2, p1

    move-wide v3, p2

    move-object/from16 v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move-object/from16 v8, p7

    move/from16 v9, p9

    move-object/from16 v10, p8

    move/from16 v11, p10

    invoke-direct/range {v0 .. v11}, Lchat/ola/vn/w/ci$15;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;BLjava/lang/String;S)V

    move-object v0, p0

    invoke-direct {v0, v12}, Lchat/ola/vn/w/ci;->f(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;JS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$4;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-wide v3, p2

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$4;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;JS)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;JZ)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$59;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-wide v3, p2

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$59;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;JZ)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/entity/c;S)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/w/ci;->g:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->g:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    iput-object p1, p0, Lchat/ola/vn/w/ci;->g:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/w/ci;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/w/ci;->l:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    iput-object p1, p0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    new-instance p1, Lchat/ola/vn/w/bk;

    const/16 v0, 0x61

    invoke-direct {p1, v0}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v0, 0x2

    iput-short v0, p1, Lchat/ola/vn/w/bk;->ac:S

    iget-object v0, p0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    iput-object v0, p1, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->c()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lchat/ola/vn/w/bk;->g:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->f()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->d()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->g()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->a()I

    move-result v0

    iput v0, p1, Lchat/ola/vn/w/bk;->X:I

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->b()I

    move-result v0

    iput v0, p1, Lchat/ola/vn/w/bk;->Y:I

    iget-object v0, p0, Lchat/ola/vn/w/ci;->l:Ljava/lang/String;

    iput-object v0, p1, Lchat/ola/vn/w/bk;->M:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/entity/c;->e()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    iput-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    const/4 p2, 0x0

    const/4 p3, 0x1

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p2, v1, v2

    new-array p2, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    aput-object v0, p2, v2

    invoke-virtual {p0, p1, v1, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;BLjava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$31;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p4

    move v5, p3

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$31;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;BS)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;IJS)V
    .locals 3

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa6

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    int-to-long p1, p3

    const-wide/16 v1, 0x18

    mul-long p1, p1, v1

    const-wide/16 v1, 0x3c

    mul-long p1, p1, v1

    mul-long p1, p1, v1

    const-wide/16 v1, 0x3e8

    mul-long p1, p1, v1

    iput-wide p1, v0, Lchat/ola/vn/w/bk;->Q:J

    const-wide/16 p1, 0x0

    cmp-long p3, p4, p1

    if-gez p3, :cond_1

    const-wide/16 p1, -0x1

    mul-long p4, p4, p1

    :cond_1
    iput-wide p4, v0, Lchat/ola/vn/w/bk;->U:J

    iput-short p6, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;JS)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/w/ci;->w:[B

    invoke-static {v0, p2}, Lchat/ola/vn/j/a;->b([BLjava/lang/String;)[B

    move-result-object p2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7b

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-wide p3, v0, Lchat/ola/vn/w/bk;->U:J

    iput-object p2, v0, Lchat/ola/vn/w/bk;->am:[B

    iput-short p5, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;[B)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xc

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iput-object p1, v0, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    :cond_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iput-object p2, v0, Lchat/ola/vn/w/bk;->j:Ljava/lang/String;

    :cond_1
    if-eqz p3, :cond_2

    iput-object p3, v0, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    :cond_2
    if-eqz p4, :cond_3

    iput-object p4, v0, Lchat/ola/vn/w/bk;->P:Ljava/lang/Byte;

    :cond_3
    if-eqz p5, :cond_4

    iput-object p5, v0, Lchat/ola/vn/w/bk;->ao:[B

    :cond_4
    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$10;

    invoke-direct {v0, p0, p2, p1, p3}, Lchat/ola/vn/w/ci$10;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;BS)V
    .locals 3

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    new-instance v1, Lchat/ola/vn/w/bk;

    const/4 v2, 0x2

    invoke-direct {v1, v2}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v1, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/w/ci;->w:[B

    invoke-static {p1, p2}, Lchat/ola/vn/j/a;->b([BLjava/lang/String;)[B

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/w/bk;->am:[B

    iput-object p2, v1, Lchat/ola/vn/w/bk;->f:Ljava/lang/String;

    iput-object p3, v1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iput-object p4, v1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    iput-object p5, v1, Lchat/ola/vn/w/bk;->d:Ljava/lang/String;

    iput-object p6, v1, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    iput-byte p7, v1, Lchat/ola/vn/w/bk;->ar:B

    iput-short p8, v1, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v1, v0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/String;BS)V
    .locals 3

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    new-instance v1, Lchat/ola/vn/w/bk;

    const/4 v2, 0x2

    invoke-direct {v1, v2}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v1, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/w/ci;->w:[B

    invoke-static {p1, p2}, Lchat/ola/vn/j/a;->b([BLjava/lang/String;)[B

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/w/bk;->am:[B

    iput-object p2, v1, Lchat/ola/vn/w/bk;->f:Ljava/lang/String;

    iput-object p3, v1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    iput-object p4, v1, Lchat/ola/vn/w/bk;->j:Ljava/lang/String;

    iput-object p5, v1, Lchat/ola/vn/w/bk;->d:Ljava/lang/String;

    iput-object p6, v1, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    iput-object p7, v1, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    iput-byte p8, v1, Lchat/ola/vn/w/bk;->ar:B

    iput-short p9, v1, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v1, v0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x4b

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->H:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/w/bk;->I:Ljava/lang/String;

    iput-object p3, v0, Lchat/ola/vn/w/bk;->J:Ljava/lang/String;

    iput-object p4, v0, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    iput-short p5, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$9;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p2

    move v3, p4

    move-object v4, p1

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$9;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 6

    new-instance p5, Lchat/ola/vn/w/ci$64;

    move-object v0, p5

    move-object v1, p0

    move-object v2, p2

    move-object v3, p1

    move v4, p4

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$64;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;)V

    invoke-direct {p0, p5}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$30;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$30;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;BS)V
    .locals 11

    const-wide/16 v2, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v4, p2

    move v6, p3

    move-object v7, p4

    move-object/from16 v8, p5

    move/from16 v9, p6

    move/from16 v10, p7

    invoke-virtual/range {v0 .. v10}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;Ljava/lang/String;BS)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/w/ci$56;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/w/ci$56;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    invoke-direct {p0, v7}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 6

    const/4 v1, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;Ljava/lang/String;SS)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 4

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    if-eqz p3, :cond_2

    array-length v1, p3

    if-lez v1, :cond_2

    new-instance v0, Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    aget-object v1, p3, v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x1

    :goto_0
    array-length v2, p3

    if-ge v1, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ";"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v3, p3, v1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_2
    new-instance p3, Lchat/ola/vn/w/bk;

    const/16 v1, 0x9e

    invoke-direct {p3, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object v0, p3, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-object p2, p3, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    iput-object p1, p3, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iput-short p4, p3, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, p3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SS)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/16 v1, 0xd

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    int-to-byte p1, p2

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->av:B

    iput-object p3, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;S)V
    .locals 7

    const/4 v0, 0x2

    if-eq p2, v0, :cond_0

    if-nez p2, :cond_1

    :cond_0
    new-instance v0, Lchat/ola/vn/w/ci$65;

    move-object v1, v0

    move-object v2, p0

    move-object v3, p1

    move v4, p2

    move-object v5, p3

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/w/ci$65;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SLjava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;SZ)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$60;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$60;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SZ)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;S[I[I)V
    .locals 4

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    new-instance p1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    invoke-virtual {p1, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/4 p2, 0x1

    const/4 v1, 0x0

    if-eqz p3, :cond_0

    const/16 v2, 0x8

    invoke-virtual {p1, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    aget v2, p3, v1

    int-to-short v2, v2

    invoke-static {v2}, Lchat/ola/vn/util/e;->a(S)[B

    move-result-object v2

    array-length v3, v2

    invoke-virtual {p1, v2, v1, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    aget p3, p3, p2

    int-to-short p3, p3

    invoke-static {p3}, Lchat/ola/vn/util/e;->a(S)[B

    move-result-object p3

    array-length v2, p3

    invoke-virtual {p1, p3, v1, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    :cond_0
    const/16 p3, 0x9

    invoke-virtual {p1, p3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    :goto_0
    aget p3, p4, v1

    int-to-short p3, p3

    invoke-static {p3}, Lchat/ola/vn/util/e;->a(S)[B

    move-result-object p3

    array-length v2, p3

    invoke-virtual {p1, p3, v1, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    aget p3, p4, p2

    int-to-short p3, p3

    invoke-static {p3}, Lchat/ola/vn/util/e;->a(S)[B

    move-result-object p3

    array-length p4, p3

    invoke-virtual {p1, p3, v1, p4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->ap:[B

    invoke-direct {p0, v0, p2, p2}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;[BS)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    if-eqz p2, :cond_1

    array-length v0, p2

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/w/ci$38;

    invoke-direct {v0, p0, p2, p3, p1}, Lchat/ola/vn/w/ci$38;-><init>(Lchat/ola/vn/w/ci;[BSLjava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 4

    if-eqz p2, :cond_2

    array-length v0, p2

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    aget-object v1, p2, v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x1

    :goto_0
    array-length v2, p2

    if-ge v1, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ";"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v3, p2, v1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    new-instance p2, Lchat/ola/vn/w/bk;

    const/16 v1, 0x9f

    invoke-direct {p2, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-object p1, p2, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    invoke-direct {p0, p2}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    :cond_2
    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 9

    if-eqz p2, :cond_1

    array-length v0, p2

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v7, 0x0

    move-object v1, p0

    move-object v5, p2

    move-object v6, p1

    move v8, p3

    invoke-direct/range {v1 .. v8}, Lchat/ola/vn/w/ci;->a(BBLjava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$12;

    invoke-direct {v0, p0, p2, p3, p1}, Lchat/ola/vn/w/ci$12;-><init>(Lchat/ola/vn/w/ci;[Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 6

    const/4 v1, 0x2

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->b(BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/util/List;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;Z)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/w/ci$63;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$63;-><init>(Lchat/ola/vn/w/ci;Ljava/util/List;Z)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$18;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$18;-><init>(Lchat/ola/vn/w/ci;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(SLjava/lang/String;Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$34;

    move-object v0, v6

    move-object v1, p0

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$34;-><init>(Lchat/ola/vn/w/ci;SLjava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->c(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(SS)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x94

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-short p1, v0, Lchat/ola/vn/w/bk;->ac:S

    iput-short p2, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public a(Z)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    if-nez p1, :cond_0

    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "No device for connection"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/w/ci;->q:J

    const/4 p1, 0x3

    iput p1, p0, Lchat/ola/vn/w/ci;->s:I

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/w/ci;->z:Z

    invoke-virtual {p0}, Lchat/ola/vn/w/ci;->a()V

    return-void

    :cond_2
    :goto_0
    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "No Input Stream, Output Stream or Listener"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method a([B)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci;->w:[B

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-interface {p1}, Lchat/ola/vn/p/g;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a([Ljava/lang/String;)V
    .locals 1

    if-eqz p1, :cond_1

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/w/ci$40;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$40;-><init>(Lchat/ola/vn/w/ci;[Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    :cond_1
    return-void
.end method

.method public a([Ljava/lang/String;[Ljava/lang/String;)V
    .locals 2

    if-eqz p1, :cond_2

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    array-length v0, p1

    array-length v1, p2

    if-eq v0, v1, :cond_1

    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "Buddy Id array is not the same length with alias array"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x36

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    :cond_2
    return-void
.end method

.method public a([Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/c;S)Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/ci;->w:[B

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return v1

    :cond_2
    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    return v1

    :cond_3
    iput-object p1, p0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v2, 0xce

    invoke-direct {v0, v2}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/w/ci;->w:[B

    invoke-static {p1, p2}, Lchat/ola/vn/j/a;->b([BLjava/lang/String;)[B

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->am:[B

    iput-object p3, v0, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    invoke-virtual {p5}, Lchat/ola/vn/entity/c;->e()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    iput-object p4, v0, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    invoke-virtual {p5}, Lchat/ola/vn/entity/c;->c()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->g:Ljava/lang/String;

    invoke-virtual {p5}, Lchat/ola/vn/entity/c;->f()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    invoke-virtual {p5}, Lchat/ola/vn/entity/c;->d()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    invoke-virtual {p5}, Lchat/ola/vn/entity/c;->g()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    iput-short p6, v0, Lchat/ola/vn/w/bk;->aj:S

    iput-object p2, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-direct {p0, v0, v1, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    const/4 p1, 0x1

    return p1

    :cond_4
    return v1
.end method

.method b()V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/w/ci$1;-><init>(Lchat/ola/vn/w/ci;)V

    invoke-static {v0}, Lchat/ola/vn/h;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$11;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$11;-><init>(Lchat/ola/vn/w/ci;I)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(J)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x56

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-wide p1, v0, Lchat/ola/vn/w/bk;->R:J

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public b(JLjava/lang/String;S)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p0, p2, p1, p3, p4}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(JS)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, p0

    move-wide v3, p1

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->b(BLjava/lang/String;JS)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/w/ci$61;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$61;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;BS)V
    .locals 11

    const/4 v5, 0x1

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-object v4, p4

    move/from16 v6, p5

    move-object/from16 v7, p6

    move/from16 v9, p7

    move/from16 v10, p8

    invoke-virtual/range {v0 .. v10}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;Ljava/lang/String;BS)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x41

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p2, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/w/bk;->u:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$13;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$13;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xc4

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x1

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iput-object p3, v0, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    iput-object p4, v0, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    iput-short p5, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/w/ci$48;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci$48;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v6}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 6

    const/4 v1, 0x1

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;Ljava/lang/String;SS)V

    return-void
.end method

.method public b(Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SS)V

    return-void
.end method

.method public b(Ljava/lang/String;SLjava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/16 v1, 0xc

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    int-to-byte p1, p2

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->av:B

    iput-object p3, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public b(Ljava/lang/String;SLjava/lang/String;S)V
    .locals 7

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v2, 0x2

    move-object v1, p0

    move-object v3, p1

    move v4, p2

    move-object v5, p3

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;[BS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$39;

    invoke-direct {v0, p0, p2, p3, p1}, Lchat/ola/vn/w/ci$39;-><init>(Lchat/ola/vn/w/ci;[BSLjava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void
.end method

.method public b(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$54;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$54;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->d(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(S)V
    .locals 7

    const-wide/16 v1, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move v6, p1

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/w/ci;->a(JZLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(Z)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    const-string v1, "tabConversation"

    const-string v2, " clear "

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lchat/ola/vn/w/ci;->G:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    :goto_0
    new-instance v0, Lchat/ola/vn/w/bk;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->as:B

    goto :goto_1

    :cond_0
    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    :goto_1
    invoke-direct {p0, v0, v1, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public b([Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/w/ci;->a([Ljava/lang/String;S)V

    return-void
.end method

.method public b([Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->b(BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public c()V
    .locals 7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/w/ci;->q:J

    sub-long v4, v0, v2

    const-wide/32 v2, 0xafc8

    cmp-long v6, v4, v2

    if-ltz v6, :cond_2

    iget v2, p0, Lchat/ola/vn/w/ci;->s:I

    const/4 v3, 0x0

    if-nez v2, :cond_0

    iput-boolean v3, p0, Lchat/ola/vn/w/ci;->z:Z

    iget-object v0, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-interface {v0}, Lchat/ola/vn/p/g;->a()V

    return-void

    :cond_0
    iget v2, p0, Lchat/ola/vn/w/ci;->s:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lchat/ola/vn/w/ci;->s:I

    iget v2, p0, Lchat/ola/vn/w/ci;->s:I

    if-gez v2, :cond_1

    iput v3, p0, Lchat/ola/vn/w/ci;->s:I

    :cond_1
    new-instance v2, Lchat/ola/vn/w/bk;

    const/16 v4, 0x2a

    invoke-direct {v2, v4}, Lchat/ola/vn/w/bk;-><init>(S)V

    invoke-direct {p0, v2, v3, v3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    iput-wide v0, p0, Lchat/ola/vn/w/ci;->q:J

    :cond_2
    iget-wide v2, p0, Lchat/ola/vn/w/ci;->r:J

    sub-long v4, v0, v2

    const-wide/32 v0, 0x493e0

    cmp-long v2, v4, v0

    if-ltz v2, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/w/ci;->d()V

    :cond_3
    return-void
.end method

.method public c(J)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$20;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$20;-><init>(Lchat/ola/vn/w/ci;J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(JS)V
    .locals 6

    const/4 v1, 0x1

    const/4 v2, 0x0

    move-object v0, p0

    move-wide v3, p1

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->b(BLjava/lang/String;JS)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$8;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$8;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    new-array p1, v0, [Ljava/lang/String;

    aput-object p2, p1, v2

    invoke-virtual {p0, v1, p1}, Lchat/ola/vn/w/ci;->a([Ljava/lang/String;[Ljava/lang/String;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$36;

    invoke-direct {v0, p0, p2, p3, p1}, Lchat/ola/vn/w/ci$36;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public c(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa5

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    iput-short p2, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public c(Ljava/lang/String;SLjava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/16 v1, 0xf

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    int-to-byte p1, p2

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->av:B

    iput-object p3, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public c(S)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x3

    invoke-direct {p0, v0, v1, v0, p1}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/w/ci;->z:Z

    return-void
.end method

.method public c([Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/w/ci;->a([Ljava/lang/String;S)V

    return-void
.end method

.method public d()V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$23;

    invoke-direct {v0, p0}, Lchat/ola/vn/w/ci$23;-><init>(Lchat/ola/vn/w/ci;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(J)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$21;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$21;-><init>(Lchat/ola/vn/w/ci;J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$35;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$35;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$37;

    invoke-direct {v0, p0, p2, p3, p1}, Lchat/ola/vn/w/ci$37;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x3

    invoke-virtual {p0, v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public d(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$26;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/w/ci$26;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;SLjava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/16 v1, 0x10

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    int-to-byte p1, p2

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->av:B

    iput-object p3, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public d(S)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x2

    invoke-direct {p0, v0, v1, v0, p1}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public d(Z)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$62;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$62;-><init>(Lchat/ola/vn/w/ci;Z)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d([Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/w/ci;->a([Ljava/lang/String;S)V

    return-void
.end method

.method e()V
    .locals 1

    const/4 v0, 0x3

    iput v0, p0, Lchat/ola/vn/w/ci;->s:I

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 6

    const/4 v1, 0x1

    const-wide/16 v3, 0x0

    const/4 v5, 0x1

    move-object v0, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;JS)V

    return-void
.end method

.method e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x2

    invoke-virtual {p0, p1, v0, p2, v1}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    const/16 v0, 0xc

    invoke-virtual {p0, v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public e(Ljava/lang/String;S)V
    .locals 6

    const/4 v1, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v2, p1

    move v5, p2

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public e(S)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x4

    invoke-direct {p0, v0, v1, v0, p1}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public f()V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/w/ci$3;-><init>(Lchat/ola/vn/w/ci;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 6

    const/4 v1, 0x1

    const-wide/16 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;JS)V

    return-void
.end method

.method f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0, p2, v0}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$41;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$41;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public f(Ljava/lang/String;S)V
    .locals 2

    const/4 v0, 0x5

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1, p2}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public f(S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7c

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-short p1, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public g()V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/w/ci$7;-><init>(Lchat/ola/vn/w/ci;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$24;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$24;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$42;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/w/ci$42;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$47;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$47;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;S)V
    .locals 2

    const/4 v0, 0x6

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1, p2}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public g(S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$32;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$32;-><init>(Lchat/ola/vn/w/ci;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public h()V
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/w/ci;->c(Z)V

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->q:J

    iput-object v1, p0, Lchat/ola/vn/w/ci;->w:[B

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->x:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->e:J

    iput-object v1, p0, Lchat/ola/vn/w/ci;->h:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/w/ci;->i:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/w/ci;->j:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/w/ci;->k:Ljava/lang/String;

    iput v0, p0, Lchat/ola/vn/w/ci;->n:I

    iput-short v0, p0, Lchat/ola/vn/w/ci;->o:S

    iput-object v1, p0, Lchat/ola/vn/w/ci;->y:Lchat/ola/vn/entity/c;

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->q:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->r:J

    const/4 v0, 0x3

    iput v0, p0, Lchat/ola/vn/w/ci;->s:I

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->A:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->B:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->C:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->D:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->E:J

    iput-wide v2, p0, Lchat/ola/vn/w/ci;->F:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    invoke-virtual {v0}, Lchat/ola/vn/w/dq;->a()V

    iput-object v1, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    invoke-virtual {v0}, Lchat/ola/vn/w/dr;->a()V

    iput-object v1, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    :cond_1
    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public h(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7a

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x4

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ah:S

    iput-object p1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public h(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xc8

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    iput-short p3, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public h(Ljava/lang/String;S)V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1, p2}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public h(S)V
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0xb

    invoke-virtual {p0, v1, v0, v0, p1}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public i()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    return-object v0
.end method

.method public i(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public i(Ljava/lang/String;S)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1, p2}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/w/ci;->v:Lchat/ola/vn/p/g;

    invoke-interface {v1, p1, v0, p2}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SS)V

    :cond_0
    return-void
.end method

.method public i(S)V
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0xd

    invoke-virtual {p0, v1, v0, v0, p1}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public j(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p0, v0, p1, v1}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method public j(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$57;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/w/ci$57;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public j(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x93

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-short p2, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public j(S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-short p1, v0, Lchat/ola/vn/w/bk;->aj:S

    const/4 p1, 0x0

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public j()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/w/ci;->z:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/w/ci;->t:Lchat/ola/vn/w/dr;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public k()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->i:Ljava/lang/String;

    return-object v0
.end method

.method public k(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x96

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public k(Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;BS)V

    return-void
.end method

.method public l()V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$25;

    invoke-direct {v0, p0}, Lchat/ola/vn/w/ci$25;-><init>(Lchat/ola/vn/w/ci;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xc3

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    const/4 p1, 0x0

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public l(Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;BS)V

    return-void
.end method

.method public m()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/w/ci;->o:S

    if-gez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-short v0, p0, Lchat/ola/vn/w/ci;->o:S

    return v0
.end method

.method public m(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;)V

    return-void
.end method

.method public m(Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public n()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->h:Ljava/lang/String;

    return-object v0
.end method

.method public n(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/w/ci;->a(BLjava/lang/String;)V

    return-void
.end method

.method public n(Ljava/lang/String;S)V
    .locals 2

    const/4 v0, 0x5

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1, p1, p2}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public o()V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$46;

    invoke-direct {v0, p0}, Lchat/ola/vn/w/ci$46;-><init>(Lchat/ola/vn/w/ci;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$44;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$44;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public o(Ljava/lang/String;S)V
    .locals 2

    const/16 v0, 0x8

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1, p2}, Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public p()Lchat/ola/vn/w/dq;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/w/ci;->u:Lchat/ola/vn/w/dq;

    return-object v0
.end method

.method public p(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/w/ci$45;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/w/ci$45;-><init>(Lchat/ola/vn/w/ci;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method public p(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xca

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    iput-short p2, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public q()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(B)V

    return-void
.end method

.method public q(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Z)V

    return-void
.end method

.method public q(Ljava/lang/String;S)V
    .locals 9

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v7, 0x0

    move-object v1, p0

    move-object v6, p1

    move v8, p2

    invoke-direct/range {v1 .. v8}, Lchat/ola/vn/w/ci;->a(BBLjava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public r()V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/w/ci;->a(IB)V

    return-void
.end method

.method public r(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Z)V

    return-void
.end method

.method public r(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6b

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-short p2, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public s(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7a

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x0

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ah:S

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public s(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {v1, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/4 p1, 0x4

    invoke-virtual {v1, p1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->ap:[B

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public t(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7a

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x1

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ah:S

    iput-object p1, v0, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public t(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {v1, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/4 p1, 0x5

    invoke-virtual {v1, p1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->ap:[B

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public u(Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x7a

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x5

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ah:S

    iput-object p1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;)V

    return-void
.end method

.method public u(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {v1, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/4 p1, 0x6

    invoke-virtual {v1, p1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->ap:[B

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public v(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {v1, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/4 p1, 0x7

    invoke-virtual {v1, p1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/w/bk;->ap:[B

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public w(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x1

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iput-short p2, v0, Lchat/ola/vn/w/bk;->aj:S

    invoke-direct {p0, v0, v1, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public x(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x4

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    int-to-byte p1, p2

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->av:B

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method

.method public y(Ljava/lang/String;S)V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x3

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iput-object p1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    int-to-byte p1, p2

    iput-byte p1, v0, Lchat/ola/vn/w/bk;->av:B

    const/4 p1, 0x1

    invoke-direct {p0, v0, p1, p1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
