.class public Lchat/ola/vn/r/a/c;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/k;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/entry/e;",
            ">;"
        }
    .end annotation
.end field

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/e;",
            ">;"
        }
    .end annotation
.end field

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/e;",
            ">;"
        }
    .end annotation
.end field

.field private e:Lchat/ola/vn/o/e;

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/e;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/lang/String;

.field private h:J


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->g:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/r/a/c;->h:J

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->b:Ljava/util/Map;

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->n()V

    return-void
.end method

.method private n()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->b:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    const v1, 0x7f0f00f1

    const v2, 0x7f080799

    invoke-static {v1, v2, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/o/e;

    invoke-direct {v0}, Lchat/ola/vn/o/e;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->e:Lchat/ola/vn/o/e;

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->e:Lchat/ola/vn/o/e;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    const v1, 0x7f0f00f5

    const v2, 0x7f08079b

    invoke-static {v1, v2, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    const v1, 0x7f0f00fb

    const v2, 0x7f08079f

    invoke-static {v1, v2, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    const v1, 0x7f0f00ea

    const v2, 0x7f080795

    invoke-static {v1, v2, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    new-instance v1, Lchat/ola/vn/o/a;

    invoke-direct {v1}, Lchat/ola/vn/o/a;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    const v1, 0x7f0f00ee

    const v2, 0x7f080796

    invoke-static {v1, v2, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f00f2

    const v1, 0x7f080819

    invoke-static {v0, v1, v0}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v0

    const v1, 0x7f0f02b0

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    const v1, 0x7f0f00ef

    const v2, 0x7f080694

    invoke-static {v1, v2, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    new-instance v1, Lchat/ola/vn/o/f;

    invoke-direct {v1}, Lchat/ola/vn/o/f;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0}, Lchat/ola/vn/r/a/c;->a()V

    return-void
.end method

.method private o()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, 0x3

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    :goto_0
    if-ge v2, v3, :cond_2

    iget-object v4, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entry/e;

    invoke-virtual {v4}, Lchat/ola/vn/entry/e;->c()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_3

    new-instance v2, Lchat/ola/vn/entry/e;

    invoke-direct {v2}, Lchat/ola/vn/entry/e;-><init>()V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lchat/ola/vn/entry/e;->a(B)V

    const v4, 0x7f0f0580

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Lchat/ola/vn/entry/e;->a(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    new-instance v0, Lchat/ola/vn/entry/e;

    invoke-direct {v0}, Lchat/ola/vn/entry/e;-><init>()V

    invoke-virtual {v0, v3}, Lchat/ola/vn/entry/e;->a(B)V

    const v2, 0x7f0f00dc

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/e;->a(Ljava/lang/String;)V

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method


# virtual methods
.method public a(I)Lchat/ola/vn/entry/e;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/lang/String;)Lchat/ola/vn/entry/e;
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {v1}, Lchat/ola/vn/entry/e;->g()Ljava/lang/String;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    aget-object v2, v2, v3

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    if-eqz v2, :cond_0

    return-object v1

    :catch_1
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/e;

    invoke-virtual {v1}, Lchat/ola/vn/entry/e;->k()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->b:Ljava/util/Map;

    invoke-virtual {v1}, Lchat/ola/vn/entry/e;->k()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->k()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, ";"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_1
    array-length v3, v0

    if-ge v2, v3, :cond_4

    aget-object v3, v0, v2

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_3

    :try_start_1
    aget-object v3, v0, v2

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_3

    aget-object v4, v3, v1

    const/4 v5, 0x1

    aget-object v3, v3, v5

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    iget-object v6, p0, Lchat/ola/vn/r/a/c;->b:Ljava/util/Map;

    invoke-interface {v6, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entry/e;

    if-eqz v4, :cond_3

    invoke-virtual {v4}, Lchat/ola/vn/entry/e;->l()I

    move-result v6

    if-gt v6, v3, :cond_2

    invoke-virtual {v4, v3}, Lchat/ola/vn/entry/e;->c(I)V

    invoke-virtual {v4, v5}, Lchat/ola/vn/entry/e;->a(Z)V

    invoke-virtual {v4, v5}, Lchat/ola/vn/entry/e;->b(Z)V

    goto :goto_2

    :cond_2
    invoke-virtual {v4, v1}, Lchat/ola/vn/entry/e;->b(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :cond_3
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :catchall_0
    move-exception v0

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    throw v0

    :catch_1
    :cond_4
    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    return-void
.end method

.method public a(Lchat/ola/vn/entry/e;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entry/e;I)V
    .locals 1

    if-ltz p2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-gt p2, v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0, p2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/e;",
            ">;)V"
        }
    .end annotation

    if-eqz p2, :cond_4

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->f:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->f:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->removeAll(Ljava/util/Collection;)Z

    :cond_0
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/e;

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    :try_start_0
    invoke-virtual {v1}, Lchat/ola/vn/entry/e;->e()I

    move-result v2

    if-ltz v2, :cond_2

    iget-object v3, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-gt v2, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v3, v2, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object v2, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    iput-object p2, p0, Lchat/ola/vn/r/a/c;->f:Ljava/util/List;

    iput-object p1, p0, Lchat/ola/vn/r/a/c;->g:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    :cond_4
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/k;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->g()V

    return-void
.end method

.method public b(I)Lchat/ola/vn/entry/e;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/e;

    invoke-virtual {v1}, Lchat/ola/vn/entry/e;->d()I

    move-result v2

    if-ne v2, p1, :cond_0

    return-object v1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public b()V
    .locals 1

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->n()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/c;->g:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->f:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public c()I
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/e;

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->c()Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return v0
.end method

.method public d()Lchat/ola/vn/entry/e;
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/e;

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->c()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->d()I

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v4, 0x7f0f00f1

    if-ne v3, v4, :cond_0

    return-object v2

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public e()Lchat/ola/vn/entry/e;
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/e;

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->c()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    return-object v2

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public f()Ljava/lang/String;
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/r/a/c;->c()I

    move-result v0

    if-lez v0, :cond_2

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/r/a/c;->e()Lchat/ola/vn/entry/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entry/e;->h()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x5

    if-le v1, v2, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return-object v0

    :catch_0
    :cond_2
    const/4 v0, 0x0

    return-object v0
.end method

.method public g()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    invoke-static {}, Lchat/ola/vn/m/d;->c()Lchat/ola/vn/m/d;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/m/d;->c()Lchat/ola/vn/m/d;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/d;->d()V

    :cond_0
    return-void
.end method

.method public h()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    if-eqz v0, :cond_1

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljava/util/Random;-><init>(J)V

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/k;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    iget-object v3, v1, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {v2, v3}, Lchat/ola/vn/util/b;->k(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/r/a/c;->a:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->e:Lchat/ola/vn/o/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/o/e;->a(Lchat/ola/vn/entity/k;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->e:Lchat/ola/vn/o/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/o/e;->a(Lchat/ola/vn/entity/k;)V

    invoke-direct {p0}, Lchat/ola/vn/r/a/c;->o()V

    return-void
.end method

.method public i()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/c;->g:Ljava/lang/String;

    return-object v0
.end method

.method public j()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/c;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public k()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/r/a/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/e;

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->k()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->a()Z

    move-result v3

    if-eqz v3, :cond_0

    if-nez v0, :cond_1

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->j()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ";"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Lchat/ola/vn/entry/e;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/e;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public l()Z
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/r/a/c;->h:J

    sub-long v4, v0, v2

    const-wide/32 v0, 0x36ee80

    cmp-long v2, v4, v0

    if-ltz v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, p0, Lchat/ola/vn/r/a/c;->h:J

    return v0
.end method

.method public m()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/k;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    return-object v0
.end method
