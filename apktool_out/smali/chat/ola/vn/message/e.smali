.class public Lchat/ola/vn/message/e;
.super Ljava/lang/Object;


# direct methods
.method public static a(Lchat/ola/vn/message/d;BLjava/lang/String;)Lchat/ola/vn/message/aa;
    .locals 1

    new-instance v0, Lchat/ola/vn/message/aa;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/aa;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/aa;->a(Ljava/lang/String;)V

    return-object v0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)Lchat/ola/vn/message/c;
    .locals 3

    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    const v1, 0x7f0f028b

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/d;->c(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/d;->a(J)V

    new-instance p1, Lchat/ola/vn/message/c;

    const/4 v1, 0x1

    invoke-direct {p1, v0, v1}, Lchat/ola/vn/message/c;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/c;->a(Ljava/lang/String;)V

    return-object p1
.end method

.method public static a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;
    .locals 0

    invoke-static {p0, p1}, Lchat/ola/vn/message/e;->b(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;J)Lchat/ola/vn/message/j;
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, p2, v0}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;JB)Lchat/ola/vn/message/j;

    move-result-object p0

    return-object p0
.end method

.method private static a(Ljava/lang/String;JB)Lchat/ola/vn/message/j;
    .locals 3

    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->c(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/d;->a(J)V

    new-instance p0, Lchat/ola/vn/message/j;

    invoke-direct {p0, v0, p3}, Lchat/ola/vn/message/j;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/message/j;->c(J)V

    return-object p0
.end method

.method public static a(Lchat/ola/vn/message/d;BLjava/lang/String;Ljava/lang/String;)Lchat/ola/vn/message/k;
    .locals 1

    new-instance v0, Lchat/ola/vn/message/k;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/k;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/k;->a(Ljava/lang/String;)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/message/k;->n(Ljava/lang/String;)V

    return-object v0
.end method

.method public static a(Ljava/lang/String;JILchat/ola/vn/entity/ah;)Lchat/ola/vn/message/s;
    .locals 3

    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->c(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/d;->a(J)V

    new-instance p0, Lchat/ola/vn/message/s;

    const/4 v1, 0x2

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/message/s;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/message/s;->c(J)V

    invoke-virtual {p0, p3}, Lchat/ola/vn/message/s;->b(I)V

    invoke-virtual {p0, p4}, Lchat/ola/vn/message/s;->a(Lchat/ola/vn/entity/ah;)V

    return-object p0
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;SSB)Lchat/ola/vn/message/t;
    .locals 1

    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/d;->c(S)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/message/d;->a(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p0

    invoke-virtual {v0, p0, p1}, Lchat/ola/vn/message/d;->a(J)V

    new-instance p0, Lchat/ola/vn/message/t;

    invoke-direct {p0, v0, p4}, Lchat/ola/vn/message/t;-><init>(Lchat/ola/vn/message/d;B)V

    return-object p0
.end method

.method public static final a(J)Lchat/ola/vn/message/y;
    .locals 1

    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v0, p0, p1}, Lchat/ola/vn/message/d;->a(J)V

    new-instance p0, Lchat/ola/vn/message/y;

    invoke-direct {p0, v0}, Lchat/ola/vn/message/y;-><init>(Lchat/ola/vn/message/d;)V

    return-object p0
.end method

.method private static b(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;
    .locals 8

    const/4 v0, 0x0

    if-eqz p0, :cond_e

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->v()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v0, Lchat/ola/vn/message/l;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/l;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->v()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/l;->j(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/l;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/l;->f(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v0, Lchat/ola/vn/message/l;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v0, Lchat/ola/vn/message/l;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v0, Lchat/ola/vn/message/l;->x:Z

    return-object v0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    new-instance v0, Lchat/ola/vn/message/ab;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/ab;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/ab;->b(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/ab;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/ab;->f(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v0, Lchat/ola/vn/message/ab;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v0, Lchat/ola/vn/message/ab;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v0, Lchat/ola/vn/message/ab;->x:Z

    return-object v0

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/message/d;->y()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    new-instance v0, Lchat/ola/vn/message/r;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/r;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->y()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/r;->k(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/r;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/r;->f(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v0, Lchat/ola/vn/message/r;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v0, Lchat/ola/vn/message/r;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v0, Lchat/ola/vn/message/r;->x:Z

    return-object v0

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/message/d;->B()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    new-instance v0, Lchat/ola/vn/message/i;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/i;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->B()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/i;->m(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/i;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/i;->f(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v0, Lchat/ola/vn/message/i;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v0, Lchat/ola/vn/message/i;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v0, Lchat/ola/vn/message/i;->x:Z

    return-object v0

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_d

    invoke-static {v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v2

    if-eqz v2, :cond_a

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_a

    new-instance v3, Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-direct {v3, v4}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    move-object v4, v0

    :cond_4
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_5

    invoke-static {v5}, Lchat/ola/vn/entity/ab;->b(Ljava/lang/String;)Lchat/ola/vn/entity/ab;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_5
    if-nez v4, :cond_4

    move-object v4, v5

    goto :goto_0

    :cond_6
    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_8

    const/4 v2, 0x0

    :try_start_0
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/ab;

    iget-object v4, v2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    new-instance v4, Lchat/ola/vn/message/w;

    invoke-direct {v4, p0, p1}, Lchat/ola/vn/message/w;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/w;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/message/w;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/w;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/w;->a(B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/message/w;->b(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result v0

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/w;->b(S)V

    new-instance v0, Lchat/ola/vn/entity/w;

    invoke-direct {v0}, Lchat/ola/vn/entity/w;-><init>()V

    iget-object v2, v2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/w;->a(Lchat/ola/vn/entity/w;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->u()Ljava/util/List;

    move-result-object v0

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/w;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object v0, v4, Lchat/ola/vn/message/w;->p:Ljava/lang/Long;

    iget-boolean v0, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean v0, v4, Lchat/ola/vn/message/w;->w:Z

    iget-boolean v0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean v0, v4, Lchat/ola/vn/message/w;->x:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v4

    :catch_0
    :cond_7
    new-instance v0, Lchat/ola/vn/message/p;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/p;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/p;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/p;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->q()B

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/p;->a(B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/p;->b(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/p;->b(S)V

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->u()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/p;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v0, Lchat/ola/vn/message/p;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v0, Lchat/ola/vn/message/p;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v0, Lchat/ola/vn/message/p;->x:Z

    return-object v0

    :cond_8
    if-eqz v4, :cond_a

    invoke-static {v4}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v2

    const/4 v3, 0x3

    if-ne v2, v3, :cond_9

    new-instance v1, Lchat/ola/vn/message/aa;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/message/aa;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/aa;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/aa;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/aa;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->q()B

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/aa;->a(B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/aa;->b(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/aa;->b(S)V

    invoke-virtual {v1, v4}, Lchat/ola/vn/message/aa;->n(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->u()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/aa;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v1, Lchat/ola/vn/message/aa;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v1, Lchat/ola/vn/message/aa;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v1, Lchat/ola/vn/message/aa;->x:Z

    return-object v1

    :cond_9
    invoke-static {v4}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_a

    new-instance v1, Lchat/ola/vn/message/z;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/message/z;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/z;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/z;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/z;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->q()B

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/z;->a(B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/z;->b(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/z;->b(S)V

    invoke-virtual {v1, v4}, Lchat/ola/vn/message/z;->a(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->u()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/z;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v1, Lchat/ola/vn/message/z;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v1, Lchat/ola/vn/message/z;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v1, Lchat/ola/vn/message/z;->x:Z

    return-object v1

    :cond_a
    :try_start_1
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-object v2, v1

    :goto_1
    const-string v3, "(Y)"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_c

    const-string v3, ":-*"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_c

    const-string v3, ":*"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_c

    const-string v3, "\ud83d\udc8b"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_b

    goto :goto_2

    :cond_b
    new-instance v0, Lchat/ola/vn/message/x;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/message/x;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/x;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/x;->b(S)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/x;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/x;->h(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v0, Lchat/ola/vn/message/x;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v0, Lchat/ola/vn/message/x;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v0, Lchat/ola/vn/message/x;->x:Z

    return-object v0

    :cond_c
    :goto_2
    new-instance v1, Lchat/ola/vn/message/w;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/message/w;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/w;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v3

    invoke-virtual {v1, v3, v4}, Lchat/ola/vn/message/w;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->q()B

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->a(B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v3

    invoke-virtual {v1, v3, v4}, Lchat/ola/vn/message/w;->b(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->b(S)V

    new-instance p1, Lchat/ola/vn/entity/w;

    invoke-direct {p1}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {p1, v2}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->a(Lchat/ola/vn/entity/w;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->u()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v1, Lchat/ola/vn/message/w;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v1, Lchat/ola/vn/message/w;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v1, Lchat/ola/vn/message/w;->x:Z

    return-object v1

    :cond_d
    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result v1

    if-lez v1, :cond_e

    new-instance v1, Lchat/ola/vn/message/w;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/message/w;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/w;->f(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/w;->a(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->q()B

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->a(B)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/w;->b(J)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->b(S)V

    new-instance p1, Lchat/ola/vn/entity/w;

    invoke-direct {p1}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->o()S

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/w;->a(I)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->a(Lchat/ola/vn/entity/w;)V

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->u()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/w;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, v1, Lchat/ola/vn/message/w;->p:Ljava/lang/Long;

    iget-boolean p1, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean p1, v1, Lchat/ola/vn/message/w;->w:Z

    iget-boolean p0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-boolean p0, v1, Lchat/ola/vn/message/w;->x:Z

    return-object v1

    :cond_e
    return-object v0
.end method

.method public static b(Ljava/lang/String;J)Lchat/ola/vn/message/j;
    .locals 1

    const/4 v0, 0x2

    invoke-static {p0, p1, p2, v0}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;JB)Lchat/ola/vn/message/j;

    move-result-object p0

    return-object p0
.end method

.method public static b(Ljava/lang/String;JILchat/ola/vn/entity/ah;)Lchat/ola/vn/message/q;
    .locals 3

    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/d;->c(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/d;->a(J)V

    new-instance p0, Lchat/ola/vn/message/q;

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/message/q;-><init>(Lchat/ola/vn/message/d;B)V

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/message/q;->c(J)V

    invoke-virtual {p0, p3}, Lchat/ola/vn/message/q;->b(I)V

    invoke-virtual {p0, p4}, Lchat/ola/vn/message/q;->a(Lchat/ola/vn/entity/ah;)V

    return-object p0
.end method
