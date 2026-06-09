.class public Lchat/ola/vn/r/b;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation
.end field

.field private c:Z

.field private d:Z

.field private e:J


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/r/b;->e:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/r/b;->d:Z

    iput-boolean v0, p0, Lchat/ola/vn/r/b;->c:Z

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lchat/ola/vn/entity/t;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 1

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/r/b;->a(Ljava/lang/String;)Lchat/ola/vn/entity/t;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    new-instance v0, Lchat/ola/vn/e/d;

    invoke-direct {v0}, Lchat/ola/vn/e/d;-><init>()V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/r/b;->c:Z

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    if-nez v0, :cond_0

    iput-object p1, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/r/b;->c:Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/r/b;->d:Z

    return v0
.end method

.method public b(Ljava/lang/String;)Lchat/ola/vn/entity/t;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Lchat/ola/vn/entity/t;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->m()S

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    sget-boolean v0, Lchat/ola/vn/c/x;->t:Z

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/r/b;->b(Ljava/lang/String;)Lchat/ola/vn/entity/t;

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    new-instance v0, Lchat/ola/vn/e/d;

    invoke-direct {v0}, Lchat/ola/vn/e/d;-><init>()V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    :cond_3
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/r/b;->d:Z

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    if-nez v0, :cond_0

    iput-object p1, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/r/b;->d:Z

    return-void
.end method

.method public b()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/r/b;->c:Z

    return v0
.end method

.method public c()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    return-object v0
.end method

.method public c(Lchat/ola/vn/entity/t;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public d()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    return-object v0
.end method

.method public d(Lchat/ola/vn/entity/t;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public e()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_0
    return-void
.end method

.method public f()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_0
    return-void
.end method

.method public g()V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/m/j;->c()Lchat/ola/vn/m/j;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/j;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h()V
    .locals 5

    invoke-virtual {p0}, Lchat/ola/vn/r/b;->b()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->a:Ljava/util/List;

    invoke-static {v0}, Lchat/ola/vn/h/b;->c(Ljava/util/List;)[B

    move-result-object v0

    new-instance v1, Lchat/ola/vn/entity/aa;

    invoke-direct {v1}, Lchat/ola/vn/entity/aa;-><init>()V

    const-string v2, "rssbookmark"

    iput-object v2, v1, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_2

    array-length v4, v0

    if-nez v4, :cond_1

    goto :goto_0

    :cond_1
    iput-object v0, v1, Lchat/ola/vn/entity/aa;->b:[B

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v4, "rss"

    new-array v2, v2, [Lchat/ola/vn/entity/aa;

    aput-object v1, v2, v3

    invoke-virtual {v0, v4, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void

    :cond_2
    :goto_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v4, "rss"

    new-array v2, v2, [Lchat/ola/vn/entity/aa;

    aput-object v1, v2, v3

    invoke-virtual {v0, v4, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public i()V
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/r/b;->e:J

    sub-long v4, v0, v2

    const-wide/16 v0, 0x7530

    cmp-long v2, v4, v0

    if-gez v2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/r/b;->a()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/b;->b:Ljava/util/List;

    invoke-static {v0}, Lchat/ola/vn/h/b;->c(Ljava/util/List;)[B

    move-result-object v0

    new-instance v1, Lchat/ola/vn/entity/aa;

    invoke-direct {v1}, Lchat/ola/vn/entity/aa;-><init>()V

    const-string v2, "rsshistory"

    iput-object v2, v1, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_3

    array-length v4, v0

    if-nez v4, :cond_2

    goto :goto_0

    :cond_2
    iput-object v0, v1, Lchat/ola/vn/entity/aa;->b:[B

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v4, "rss"

    new-array v2, v2, [Lchat/ola/vn/entity/aa;

    aput-object v1, v2, v3

    invoke-virtual {v0, v4, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    goto :goto_1

    :cond_3
    :goto_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v4, "rss"

    new-array v2, v2, [Lchat/ola/vn/entity/aa;

    aput-object v1, v2, v3

    invoke-virtual {v0, v4, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/r/b;->e:J

    return-void
.end method

.method public j()V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/r/b;->c:Z

    iput-boolean v0, p0, Lchat/ola/vn/r/b;->d:Z

    invoke-virtual {p0}, Lchat/ola/vn/r/b;->e()V

    invoke-virtual {p0}, Lchat/ola/vn/r/b;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
