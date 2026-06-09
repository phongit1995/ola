.class public Lchat/ola/vn/entry/c/c;
.super Lchat/ola/vn/entry/c/e;


# instance fields
.field public a:Ljava/lang/String;

.field protected b:J


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/c/c;->a:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entry/c/c;->b:J

    iput-wide p2, p0, Lchat/ola/vn/entry/c/c;->b:J

    iput-object p1, p0, Lchat/ola/vn/entry/c/c;->a:Ljava/lang/String;

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 4

    if-nez p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->i()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/r/a/e;->d:J

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/util/List;)V

    :cond_1
    return-void
.end method

.method private a(Ljava/lang/String;SLjava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/r/a/e;->b(Ljava/lang/String;SLjava/util/List;)V

    return-void
.end method

.method private a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/e;->c(Ljava/util/List;)V

    return-void
.end method

.method private b()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/entry/c/c;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-wide v0, p0, Lchat/ola/vn/entry/c/c;->b:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/c/c;->a:Ljava/lang/String;

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->i()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_1

    new-instance v4, Lchat/ola/vn/entry/a;

    invoke-direct {v4}, Lchat/ola/vn/entry/a;-><init>()V

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    iput-object v5, v4, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    iput-object v2, v4, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->a()S

    move-result v2

    iput-short v2, v4, Lchat/ola/vn/entry/a;->e:S

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->r()I

    move-result v2

    iput v2, v4, Lchat/ola/vn/entry/a;->c:I

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->s()I

    move-result v2

    iput v2, v4, Lchat/ola/vn/entry/a;->d:I

    iget-object v2, v4, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    invoke-interface {v2, v3}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    invoke-virtual {v1, v4}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/a;)V

    :cond_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const/4 v3, 0x0

    invoke-direct {p0, v0, v3, v2}, Lchat/ola/vn/entry/c/c;->a(Ljava/lang/String;SLjava/util/List;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/c/c;->a(Ljava/lang/String;)V

    invoke-virtual {v1, v3}, Lchat/ola/vn/r/a/e;->a(I)V

    invoke-virtual {v1, v3}, Lchat/ola/vn/r/a/e;->a(Z)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f0169

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    return-void

    :cond_2
    :goto_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f06e4

    const v2, 0x7f0f024f

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/4 v0, 0x4

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 2

    :try_start_0
    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/16 p3, 0x22

    if-eq p1, p3, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/c/c;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    :cond_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-wide p3, p0, Lchat/ola/vn/entry/c/c;->b:J

    const-wide/16 v0, 0x0

    cmp-long p1, p3, v0

    if-nez p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/entry/c/c;->b()V

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const p3, 0x7f0f019e

    invoke-static {p1, p3}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    :goto_0
    const/4 p1, 0x0

    :try_start_2
    invoke-virtual {p2, p1}, Lchat/ola/vn/r/a/e;->a(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 12

    const/4 v0, 0x0

    aget-object v1, p1, v0

    check-cast v1, Ljava/lang/String;

    const/4 v2, 0x1

    aget-object v3, p1, v2

    check-cast v3, Ljava/lang/Short;

    invoke-virtual {v3}, Ljava/lang/Short;->shortValue()S

    move-result v3

    const/4 v4, 0x2

    aget-object p1, p1, v4

    check-cast p1, Ljava/util/List;

    sget-object v4, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v4}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_0

    invoke-virtual {v4}, Lchat/ola/vn/r/a/e;->i()Ljava/util/List;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v7

    if-lez v7, :cond_0

    new-instance v7, Lchat/ola/vn/entry/a;

    invoke-direct {v7}, Lchat/ola/vn/entry/a;-><init>()V

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    iput-object v8, v7, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    iput-object v5, v7, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    invoke-virtual {v4}, Lchat/ola/vn/r/a/e;->a()S

    move-result v5

    iput-short v5, v7, Lchat/ola/vn/entry/a;->e:S

    invoke-virtual {v4}, Lchat/ola/vn/r/a/e;->r()I

    move-result v5

    iput v5, v7, Lchat/ola/vn/entry/a;->c:I

    invoke-virtual {v4}, Lchat/ola/vn/r/a/e;->s()I

    move-result v5

    iput v5, v7, Lchat/ola/vn/entry/a;->d:I

    iget-object v5, v7, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    invoke-interface {v5, v6}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    invoke-virtual {v4, v7}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/a;)V

    :cond_0
    iget-wide v5, p0, Lchat/ola/vn/entry/c/c;->b:J

    const-wide/16 v7, 0x0

    cmp-long v9, v5, v7

    if-nez v9, :cond_4

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    if-nez p1, :cond_1

    invoke-virtual {v4, v2}, Lchat/ola/vn/r/a/e;->a(I)V

    :goto_0
    invoke-virtual {v4, v0}, Lchat/ola/vn/r/a/e;->a(Z)V

    return-void

    :cond_1
    :try_start_0
    sget-object v5, Lchat/ola/vn/h;->L:Ljava/lang/String;

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    new-instance v5, Lchat/ola/vn/entity/g;

    invoke-direct {v5}, Lchat/ola/vn/entity/g;-><init>()V

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v2}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v9, Lchat/ola/vn/entity/d;

    invoke-direct {v9}, Lchat/ola/vn/entity/d;-><init>()V

    const v10, 0x7f0f0382

    invoke-static {v10}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Lchat/ola/vn/entity/d;->f(Ljava/lang/String;)V

    const-string v11, "wap"

    invoke-virtual {v9, v11}, Lchat/ola/vn/entity/d;->a(Ljava/lang/String;)V

    invoke-virtual {v9, v2}, Lchat/ola/vn/entity/d;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    sget-object v2, Lchat/ola/vn/h;->L:Ljava/lang/String;

    invoke-virtual {v9, v2}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v5, v6}, Lchat/ola/vn/entity/g;->a(Ljava/util/List;)V

    invoke-virtual {v5, v7, v8}, Lchat/ola/vn/entity/g;->b(J)V

    invoke-static {v10}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->a(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Lchat/ola/vn/entity/g;->e(S)V

    invoke-static {v10}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->i(Ljava/lang/String;)V

    const v2, 0x7f0f02c9

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->g(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Lchat/ola/vn/entity/g;->b(I)V

    invoke-virtual {v5, v7, v8}, Lchat/ola/vn/entity/g;->a(J)V

    sget-object v2, Lchat/ola/vn/h;->M:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    sget-object v2, Lchat/ola/vn/h;->M:Ljava/lang/String;

    :goto_1
    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    goto :goto_2

    :cond_2
    const v2, 0x7f0f0383

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :goto_2
    sget-object v2, Lchat/ola/vn/h;->N:Ljava/lang/String;

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    const/4 v2, 0x3

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->d(S)V

    const-string v2, "update"

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->f(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/entity/g;->c(J)V

    invoke-interface {p1, v0, v5}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    invoke-direct {p0, v1, v3, p1}, Lchat/ola/vn/entry/c/c;->a(Ljava/lang/String;SLjava/util/List;)V

    goto :goto_3

    :cond_4
    invoke-direct {p0, p1}, Lchat/ola/vn/entry/c/c;->a(Ljava/util/List;)V

    :goto_3
    invoke-direct {p0, v1}, Lchat/ola/vn/entry/c/c;->a(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Lchat/ola/vn/r/a/e;->a(I)V

    goto/16 :goto_0
.end method
