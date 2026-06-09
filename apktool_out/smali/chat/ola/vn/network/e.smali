.class public Lchat/ola/vn/network/e;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/g;


# static fields
.field public static b:I


# instance fields
.field protected a:Lchat/ola/vn/network/OlaNetworkService;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/network/OlaNetworkService;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/network/e;Ljava/lang/String;SLchat/ola/vn/message/d;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/network/e;->a(Ljava/lang/String;SLchat/ola/vn/message/d;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/network/e;->a(Ljava/lang/String;SLjava/lang/String;Lchat/ola/vn/message/d;)V

    return-void
.end method

.method private a(Lchat/ola/vn/w/ci;)V
    .locals 3

    invoke-virtual {p1}, Lchat/ola/vn/w/ci;->n()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/x;->d:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    sget-short v1, Lchat/ola/vn/c/x;->j:S

    const/16 v2, 0x4000

    and-int/2addr v1, v2

    if-eq v1, v2, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/e;->f()S

    move-result v1

    sput-short v1, Lchat/ola/vn/c/x;->j:S

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    sget-short v2, Lchat/ola/vn/c/x;->j:S

    invoke-virtual {v1, v2}, Lchat/ola/vn/e;->d(I)V

    :goto_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/w/ci;->k()Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/h/b;->h(Ljava/lang/String;)B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->k:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->j(Ljava/lang/String;)B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->n:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->n(Ljava/lang/String;)B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->o:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->q(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->q:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->o(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->v:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->g(Ljava/lang/String;)B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->m:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->k(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->h:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->l(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->x:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->m(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->y:Z

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/h/b;->r(Ljava/lang/String;)Lchat/ola/vn/me/a;

    move-result-object p1

    if-eqz p1, :cond_1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/me/a;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method private a(Ljava/lang/String;SLchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->q()B

    move-result p2

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/message/d;->a(BZ)V

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/message/d;->b(J)V

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->q()B

    move-result p2

    const/4 v0, 0x3

    if-ne p2, v0, :cond_0

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/d;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private a(Ljava/lang/String;SLjava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/message/g;->c(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    :cond_0
    invoke-virtual {v0, p3}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object p1

    const/4 v1, 0x2

    if-eqz p1, :cond_2

    iget-object p2, p4, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p2, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    invoke-virtual {p4}, Lchat/ola/vn/message/d;->y()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    invoke-static {p4, v1}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    invoke-virtual {v0, p3, p1}, Lchat/ola/vn/message/f;->a(Ljava/lang/String;Lchat/ola/vn/message/d;)V

    return-void

    :cond_1
    invoke-virtual {p4}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    invoke-virtual {p4}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {p4}, Lchat/ola/vn/message/d;->t()J

    move-result-wide p2

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/message/d;->b(J)V

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/d;->b(B)V

    return-void

    :cond_2
    if-nez p2, :cond_3

    invoke-static {p4, v1}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    iget-object p2, p4, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p2, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$50;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e$50;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$67;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$67;-><init>(Lchat/ola/vn/network/e;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(ILjava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p2}, Lchat/ola/vn/h/b;->d(Ljava/lang/String;Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/network/e$54;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$54;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(ISLjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 9

    new-instance v8, Lchat/ola/vn/network/e$1;

    move-object v0, v8

    move-object v1, p0

    move v2, p1

    move v3, p6

    move-object v4, p3

    move-object v5, p4

    move v6, p2

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/network/e$1;-><init>(Lchat/ola/vn/network/e;ISLjava/lang/String;[BS[Lchat/ola/vn/entity/d;)V

    invoke-static {v8}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JIS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$121;

    move-object v0, v6

    move-object v1, p0

    move-wide v2, p1

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$121;-><init>(Lchat/ola/vn/network/e;JIS)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JLchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public a(JLjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(JLjava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-static {p1, p2}, Lchat/ola/vn/k/a;->a(J)Lchat/ola/vn/entity/m;

    move-result-object p1

    invoke-virtual {p1, p4}, Lchat/ola/vn/entity/m;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    const/16 v0, 0x38

    move/from16 v9, p7

    if-eq v9, v0, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/lang/Long;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    new-instance v0, Lchat/ola/vn/network/e$58;

    move-object v1, v0

    move-object v2, p0

    move-wide v3, p1

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    move-object/from16 v8, p6

    invoke-direct/range {v1 .. v9}, Lchat/ola/vn/network/e$58;-><init>(Lchat/ola/vn/network/e;JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JLjava/lang/String;[BLjava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-static {p1, p2}, Lchat/ola/vn/k/a;->a(J)Lchat/ola/vn/entity/m;

    move-result-object p1

    invoke-virtual {p1, p4, p5}, Lchat/ola/vn/entity/m;->a([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(JLjava/lang/String;[Ljava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/network/e$94;

    move-object v0, v7

    move-object v1, p0

    move-wide v2, p1

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$94;-><init>(Lchat/ola/vn/network/e;JLjava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JLjava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$59;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$59;-><init>(Lchat/ola/vn/network/e;JLjava/util/List;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(JS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$93;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$93;-><init>(Lchat/ola/vn/network/e;JS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/ad;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$11;

    move-object v0, v6

    move-object v1, p0

    move v2, p4

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$11;-><init>(Lchat/ola/vn/network/e;SLchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ad;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/entity/t;

    invoke-direct {v0, p1}, Lchat/ola/vn/entity/t;-><init>(Lchat/ola/vn/entity/ad;)V

    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/t;->a(Z)V

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->f()V

    new-instance p1, Lchat/ola/vn/network/e$15;

    invoke-direct {p1, p0, p2, v0}, Lchat/ola/vn/network/e$15;-><init>(Lchat/ola/vn/network/e;SLchat/ola/vn/entity/t;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 6

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    :cond_0
    const/4 v0, 0x0

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    if-eqz v1, :cond_1

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v0, v0, Lchat/ola/vn/entity/ag;->u:S

    :cond_1
    sput-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    if-lez v0, :cond_2

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v1, v1, Lchat/ola/vn/entity/ag;->u:S

    if-nez v1, :cond_2

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iput-short v0, v1, Lchat/ola/vn/entity/ag;->u:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_2
    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    const v1, 0x7f0f00f5

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/c;->b(I)Lchat/ola/vn/entry/e;

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    const/4 v1, 0x0

    :try_start_2
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/n;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catch_0
    move-object v2, v1

    :goto_0
    :try_start_3
    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v3

    const/4 v4, 0x2

    if-eqz v3, :cond_8

    sget-object v3, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    sget-object v3, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v3, v3, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v3, :cond_8

    :cond_3
    const-string v3, "!"

    invoke-virtual {v0, v3}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/e;->b(I)V

    const-string v3, ""

    sget-object v4, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v4, v4, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    move-object v2, v1

    goto :goto_1

    :cond_4
    sget-object v4, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iput-object v2, v4, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    :goto_1
    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v4

    if-eqz v4, :cond_5

    sget-object v4, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_5

    sget-object v4, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v4, v4, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    sget-object v4, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    sget-object v5, Lchat/ola/vn/h;->S:Ljava/lang/String;

    iput-object v5, v4, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v5, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-virtual {v4, v2, v5, v1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;)V

    :cond_5
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    const v1, 0x7f0f0173

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_2

    :cond_6
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v1, :cond_7

    const v1, 0x7f0f02e3

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    :cond_7
    :goto_2
    invoke-virtual {v0, v3}, Lchat/ola/vn/entry/e;->d(Ljava/lang/String;)V

    goto :goto_4

    :cond_8
    sget-object v3, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-byte v3, v3, Lchat/ola/vn/entity/ag;->w:B

    const/4 v5, -0x1

    if-ne v3, v5, :cond_9

    const-string v1, "!"

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/e;->b(I)V

    const v1, 0x7f0f035b

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    :goto_3
    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->d(Ljava/lang/String;)V

    goto :goto_4

    :cond_9
    sget-object v3, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_a

    sget-object v3, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iput-object v2, v3, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3, v2, v1, v1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;)V

    :cond_a
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/e;->b(I)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    :catch_1
    move-exception v0

    :try_start_4
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    :cond_b
    :goto_4
    new-instance v0, Lchat/ola/vn/network/e$12;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$12;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/entity/ag;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/b;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$62;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$62;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/entity/b;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$51;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$51;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/entity/g;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/message/d;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$103;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$103;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/message/d;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/message/t;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$18;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$18;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/message/t;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/ci;S)V
    .locals 18

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const/4 v2, 0x0

    sput v2, Lchat/ola/vn/network/e;->b:I

    iget-wide v3, v1, Lchat/ola/vn/w/ci;->e:J

    sput-wide v3, Lchat/ola/vn/h;->m:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sput-wide v3, Lchat/ola/vn/h;->y:J

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/ci;->i()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/ci;->m()S

    move-result v3

    sput-short v3, Lchat/ola/vn/h;->H:S

    const-wide/16 v3, 0x0

    sput-wide v3, Lchat/ola/vn/h;->o:J

    sput-boolean v2, Lchat/ola/vn/OlaApplication;->d:Z

    iget-object v5, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iput-boolean v2, v5, Lchat/ola/vn/network/OlaNetworkService;->k:Z

    const/4 v5, 0x1

    :try_start_0
    iget-object v6, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-string v7, "ola"

    invoke-virtual {v6, v7, v5, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object v6, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-string v7, "#hai"

    invoke-virtual {v6, v7, v5, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    const/4 v6, 0x0

    new-instance v7, Lchat/ola/vn/entity/ag;

    invoke-direct {v7}, Lchat/ola/vn/entity/ag;-><init>()V

    sput-object v7, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v7, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v7, v6, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v6, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v6, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(S)V

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/ci;->i()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lchat/ola/vn/h/b;->f(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v6

    if-eqz v6, :cond_1

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/w/ci;->i()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lchat/ola/vn/h/b;->i(Ljava/lang/String;)Z

    move-result v11

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v7

    invoke-virtual {v7}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v15

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v7

    invoke-virtual {v7}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    cmp-long v10, v8, v3

    if-lez v10, :cond_0

    iget-object v8, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    const/4 v14, 0x0

    move-object v12, v15

    move-object v13, v7

    invoke-virtual/range {v8 .. v14}, Lchat/ola/vn/network/OlaNetworkService;->a(JZLjava/lang/String;Ljava/lang/String;S)V

    goto :goto_0

    :cond_0
    invoke-static {v15}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v12, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v13

    const/16 v17, 0x0

    move-object/from16 v16, v7

    invoke-virtual/range {v12 .. v17}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;Ljava/lang/String;S)V

    :cond_1
    :goto_0
    new-instance v3, Lchat/ola/vn/network/e$33;

    invoke-direct {v3, v0}, Lchat/ola/vn/network/e$33;-><init>(Lchat/ola/vn/network/e;)V

    const-wide/16 v6, 0x7530

    invoke-static {v3, v6, v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    invoke-direct/range {p0 .. p1}, Lchat/ola/vn/network/e;->a(Lchat/ola/vn/w/ci;)V

    :try_start_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/c/f;->b(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v3

    new-instance v4, Lchat/ola/vn/network/e$44;

    invoke-direct {v4, v0}, Lchat/ola/vn/network/e$44;-><init>(Lchat/ola/vn/network/e;)V

    invoke-virtual {v3, v4}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance v4, Lchat/ola/vn/c/e;

    invoke-direct {v4}, Lchat/ola/vn/c/e;-><init>()V

    new-array v6, v5, [Lchat/ola/vn/c/f;

    aput-object v3, v6, v2

    invoke-virtual {v4, v6}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    new-instance v3, Lchat/ola/vn/network/e$45;

    invoke-direct {v3, v0}, Lchat/ola/vn/network/e$45;-><init>(Lchat/ola/vn/network/e;)V

    new-array v4, v5, [Ljava/lang/String;

    sget-object v5, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v5}, Lchat/ola/vn/r/a/c;->i()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-virtual {v3, v4}, Lchat/ola/vn/network/e$45;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_2
    invoke-static {}, Lchat/ola/vn/d;->i()V

    invoke-static {}, Lchat/ola/vn/d;->h()V

    new-instance v2, Lchat/ola/vn/network/e$46;

    invoke-direct {v2, v0, v1}, Lchat/ola/vn/network/e$46;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/w/ci;)V

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$60;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$60;-><init>(Lchat/ola/vn/network/e;Ljava/lang/Short;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    new-instance p1, Lchat/ola/vn/network/e$22;

    invoke-direct {p1, p0}, Lchat/ola/vn/network/e$22;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;S)V
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "IS",
            "Ljava/lang/String;",
            "J",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;S)V"
        }
    .end annotation

    new-instance v10, Lchat/ola/vn/network/e$77;

    move-object v0, v10

    move-object v1, p0

    move v2, p2

    move-object v3, p1

    move v4, p3

    move-object v5, p4

    move-wide/from16 v6, p5

    move-object/from16 v8, p7

    move/from16 v9, p8

    invoke-direct/range {v0 .. v9}, Lchat/ola/vn/network/e$77;-><init>(Lchat/ola/vn/network/e;ILjava/lang/String;SLjava/lang/String;JLjava/util/List;S)V

    invoke-static {v10}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;I[I[I)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$30;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p4

    move v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$30;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;[II[I)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;J)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$104;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$104;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;J)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;JS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$100;

    move-object v0, v6

    move-object v1, p0

    move-wide v2, p2

    move-object v4, p1

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$100;-><init>(Lchat/ola/vn/network/e;JLjava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/entity/i;Lchat/ola/vn/entity/l;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$120;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$120;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/entity/i;Lchat/ola/vn/entity/l;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$31;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$31;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/w/ci;)V
    .locals 2

    :try_start_0
    sget-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    const/4 v0, 0x1

    if-eqz p2, :cond_0

    sget-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_0

    sget-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    sget-object v1, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int/2addr v1, v0

    invoke-interface {p2, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_0
    sget-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    if-nez p2, :cond_1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    sput-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    :cond_1
    sget-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_2
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 v0, 0x0

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1}, Lchat/ola/vn/network/OlaNetworkService;->x(Ljava/lang/String;)V

    if-eqz v0, :cond_4

    sget-object p2, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object p1, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-static {p1}, Lchat/ola/vn/h/b;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$32;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$32;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JS)V
    .locals 8

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/h;->b(Ljava/lang/String;)V

    invoke-static {p3}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p7

    invoke-virtual {p7, p1}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p7

    invoke-virtual {p7, p3}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V

    new-instance p7, Lchat/ola/vn/network/e$10;

    move-object v0, p7

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-wide v6, p5

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/network/e$10;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-static {p7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9

    new-instance v8, Lchat/ola/vn/network/e$118;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p3

    move-object v3, p5

    move-object v4, p6

    move-object v5, p4

    move-object v6, p2

    move-object v7, p1

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/network/e$118;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v8}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 11

    new-instance v10, Lchat/ola/vn/network/e$98;

    move-object v0, v10

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move-object/from16 v8, p7

    move/from16 v9, p8

    invoke-direct/range {v0 .. v9}, Lchat/ola/vn/network/e$98;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-static {v10}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 10

    new-instance v9, Lchat/ola/vn/network/e$117;

    move-object v0, v9

    move-object v1, p0

    move-object v2, p3

    move-object v3, p1

    move-object v4, p5

    move-object/from16 v5, p6

    move-object v6, p4

    move/from16 v7, p7

    move-object v8, p2

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/network/e$117;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;)V

    invoke-static {v9}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/network/e$108;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$108;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0

    sput-object p2, Lchat/ola/vn/h;->L:Ljava/lang/String;

    sput-object p1, Lchat/ola/vn/h;->M:Ljava/lang/String;

    sput-object p4, Lchat/ola/vn/h;->N:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$99;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$99;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v7, Lchat/ola/vn/network/e$133;

    move-object v0, v7

    move-object v1, p0

    move v2, p5

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$133;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ac;",
            ">;S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$86;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$86;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$71;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$71;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SLchat/ola/vn/entity/ah;IJ)V
    .locals 8

    new-instance p3, Lchat/ola/vn/network/e$79;

    move-object v0, p3

    move-object v1, p0

    move-object v2, p2

    move-wide v3, p6

    move v5, p5

    move-object v6, p4

    move-object v7, p1

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/network/e$79;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;JILchat/ola/vn/entity/ah;Ljava/lang/String;)V

    invoke-static {p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V
    .locals 8

    new-instance v7, Lchat/ola/vn/network/e$3;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p2

    move-object v3, p1

    move v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$3;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;SS)V
    .locals 6

    new-instance p5, Lchat/ola/vn/network/e$7;

    move-object v0, p5

    move-object v1, p0

    move-object v2, p2

    move-object v3, p1

    move v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$7;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;)V

    invoke-static {p5}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$48;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$48;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$17;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$17;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$132;

    move-object v0, v6

    move-object v1, p0

    move v2, p4

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$132;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;Ljava/util/List;Ljava/lang/String;)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$55;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$55;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;SI)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$126;

    invoke-direct {v0, p0, p2, p1, p3}, Lchat/ola/vn/network/e$126;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SIJS)V
    .locals 9

    new-instance v8, Lchat/ola/vn/network/e$83;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move-wide v5, p4

    move v7, p6

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/network/e$83;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SIJS)V

    invoke-static {v8}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SIS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$84;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$84;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SIS)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLchat/ola/vn/message/v;)V
    .locals 0

    if-eqz p2, :cond_0

    return-void

    :cond_0
    new-instance p2, Lchat/ola/vn/network/e$38;

    invoke-direct {p2, p0, p1, p3}, Lchat/ola/vn/network/e$38;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/v;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$39;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$39;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$96;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$96;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;Z)V
    .locals 8

    new-instance v7, Lchat/ola/vn/network/e$40;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p5

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$40;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;ZLjava/lang/String;)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;S)V"
        }
    .end annotation

    new-instance v7, Lchat/ola/vn/network/e$4;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p4

    move-object v5, p3

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$4;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/util/List;Ljava/lang/String;S)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;SS)V
    .locals 0

    new-instance p4, Lchat/ola/vn/network/e$95;

    invoke-direct {p4, p0, p1, p2, p3}, Lchat/ola/vn/network/e$95;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;)V

    invoke-static {p4}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;Z)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$42;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$42;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;Z)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/util/List;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$49;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$49;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/util/List;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;SS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$76;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$76;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;[B)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$97;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$97;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;[B)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$47;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$47;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/util/List;I)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;I)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$92;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$92;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$89;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$89;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/util/List;Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ac;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$82;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$82;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$57;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$57;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$105;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$105;-><init>(Lchat/ola/vn/network/e;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(SS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$78;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$78;-><init>(Lchat/ola/vn/network/e;SS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a([BS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$61;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$61;-><init>(Lchat/ola/vn/network/e;[BS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a([Lchat/ola/vn/entity/j;IS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$68;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$68;-><init>(Lchat/ola/vn/network/e;[Lchat/ola/vn/entity/j;IS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a([Lchat/ola/vn/message/f;)V
    .locals 8

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    array-length v1, p1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_4

    aget-object v4, p1, v3

    sget-object v5, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6, v2}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v5

    if-eqz v5, :cond_3

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->g()S

    move-result v6

    invoke-virtual {v5}, Lchat/ola/vn/message/f;->g()S

    move-result v7

    if-eq v6, v7, :cond_1

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {v4}, Lchat/ola/vn/message/f;->g()S

    move-result v6

    invoke-virtual {v5, v6}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->g()S

    move-result v6

    const/4 v7, 0x2

    if-eq v6, v7, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    iput-wide v6, v5, Lchat/ola/vn/message/f;->N:J

    :cond_2
    invoke-virtual {v4}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v6

    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/message/f;->c(J)V

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->i()S

    move-result v6

    invoke-virtual {v5, v6}, Lchat/ola/vn/message/f;->e(S)V

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->h()S

    move-result v4

    invoke-virtual {v5, v4}, Lchat/ola/vn/message/f;->c(S)V

    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_4
    new-instance p1, Lchat/ola/vn/network/e$114;

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/network/e$114;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a([Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 8

    new-instance v7, Lchat/ola/vn/network/e$21;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    move-object v4, p4

    move-object v5, p2

    move v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$21;-><init>(Lchat/ola/vn/network/e;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a([Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$124;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e$124;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$43;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$43;-><init>(Lchat/ola/vn/network/e;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(JIS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$122;

    move-object v0, v6

    move-object v1, p0

    move-wide v2, p1

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$122;-><init>(Lchat/ola/vn/network/e;JIS)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(JLjava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$91;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$91;-><init>(Lchat/ola/vn/network/e;JLjava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(JS)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$8;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$8;-><init>(Lchat/ola/vn/network/e;JS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/ad;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$13;

    move-object v0, v6

    move-object v1, p0

    move v2, p4

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$13;-><init>(Lchat/ola/vn/network/e;SLchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Lchat/ola/vn/message/t;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$19;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$19;-><init>(Lchat/ola/vn/network/e;Lchat/ola/vn/message/t;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$70;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$70;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;I)V
    .locals 0

    new-instance p1, Lchat/ola/vn/network/e$24;

    invoke-direct {p1, p0}, Lchat/ola/vn/network/e$24;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$34;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$34;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$35;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$35;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$107;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$107;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/a;",
            ">;S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$87;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$87;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$16;

    move-object v0, v6

    move-object v1, p0

    move v2, p4

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$16;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$109;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$109;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$90;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$90;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/aa;",
            ">;S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$5;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$5;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$63;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$63;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;SI)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$128;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$128;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SI)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;SIS)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$85;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$85;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;SIS)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;S)V"
        }
    .end annotation

    new-instance v7, Lchat/ola/vn/network/e$6;

    move-object v0, v7

    move-object v1, p0

    move v2, p5

    move-object v3, p1

    move v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/network/e$6;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;SLjava/lang/String;Ljava/util/List;)V

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$119;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$119;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/util/List;Ljava/lang/String;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$36;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/network/e$36;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    new-instance p2, Lchat/ola/vn/network/e$69;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/network/e$69;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$41;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$41;-><init>(Lchat/ola/vn/network/e;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(SS)V
    .locals 1

    invoke-static {p1}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/x;->e:Ljava/lang/Short;

    new-instance v0, Lchat/ola/vn/network/e$2;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$2;-><init>(Lchat/ola/vn/network/e;SS)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    new-instance v0, Lchat/ola/vn/network/e$23;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e$23;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/ad;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    new-instance v6, Lchat/ola/vn/network/e$14;

    move-object v0, v6

    move-object v1, p0

    move v2, p4

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$14;-><init>(Lchat/ola/vn/network/e;SLchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$72;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$72;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;I)V
    .locals 0

    new-instance p1, Lchat/ola/vn/network/e$25;

    invoke-direct {p1, p0}, Lchat/ola/vn/network/e$25;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$53;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$53;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$52;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$52;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$110;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$110;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$88;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$88;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/e$56;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$56;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public c(Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    new-instance v0, Lchat/ola/vn/network/e$75;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$75;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d()V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$65;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e$65;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$80;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$80;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$26;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$26;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$113;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$113;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$111;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$111;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$130;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$130;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public d(Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/k;",
            ">;S)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_0

    const/4 p2, 0x0

    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/k;

    sput-object p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    :cond_0
    new-instance p2, Lchat/ola/vn/network/e$20;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/network/e$20;-><init>(Lchat/ola/vn/network/e;Ljava/util/List;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public e()V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$66;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e$66;-><init>(Lchat/ola/vn/network/e;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$81;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$81;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public e(Ljava/lang/String;I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$27;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$27;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$115;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$115;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/e$112;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/e$112;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public e(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$131;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$131;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public f()V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$123;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$123;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public f(Ljava/lang/String;I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$28;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$28;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$116;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$116;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public f(Ljava/lang/String;S)V
    .locals 0

    sput-object p1, Lchat/ola/vn/h;->e:Ljava/lang/String;

    return-void
.end method

.method public g()V
    .locals 0

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$125;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$125;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;I)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$29;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$29;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;I)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$64;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$64;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public g(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$101;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$101;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$127;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/e$127;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public h(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$73;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$73;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public h(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$106;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$106;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$74;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$74;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public i(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$129;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/network/e$129;-><init>(Lchat/ola/vn/network/e;SLjava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public j(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-nez v0, :cond_2

    const-string v0, ";"

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_2

    array-length v0, p2

    if-lez v0, :cond_2

    move-object v3, v2

    const/4 v0, 0x0

    :goto_0
    array-length v4, p2

    if-ge v0, v4, :cond_3

    aget-object v4, p2, v0

    const-string v5, "id="

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    aget-object v2, p2, v0

    const/4 v4, 0x3

    invoke-virtual {v2, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    :cond_0
    aget-object v4, p2, v0

    const-string v5, "chatgroupId="

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    aget-object v3, p2, v0

    const-string v4, "chatgroupId="

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    move-object v3, v2

    :cond_3
    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_4

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 p2, 0x2

    invoke-virtual {p1, v3, p2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    goto :goto_1

    :cond_4
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p1, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    :goto_1
    if-eqz p1, :cond_5

    invoke-virtual {p1, v2}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object p1

    if-eqz p1, :cond_5

    new-instance p2, Lchat/ola/vn/network/e$102;

    invoke-direct {p2, p0, v2, p1}, Lchat/ola/vn/network/e$102;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    return-void
.end method

.method public j(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$9;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$9;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public k(Ljava/lang/String;S)V
    .locals 1

    new-instance v0, Lchat/ola/vn/network/e$37;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/network/e$37;-><init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method
