.class public Lchat/ola/vn/r/a/b;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/r/a;


# instance fields
.field a:Lchat/ola/vn/r/a/a;

.field private b:Lchat/ola/vn/p/h;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/g;",
            ">;"
        }
    .end annotation
.end field

.field private d:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/entry/g;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lchat/ola/vn/r/a/a;

    invoke-direct {v0}, Lchat/ola/vn/r/a/a;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/b;->a:Lchat/ola/vn/r/a/a;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    return-void
.end method

.method private d()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/b;->a:Lchat/ola/vn/r/a/a;

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method


# virtual methods
.method public a(I)Lchat/ola/vn/entry/g;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/g;

    return-object p1
.end method

.method public a(Ljava/lang/String;)Lchat/ola/vn/entry/g;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/g;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/g;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    return-object v0
.end method

.method public a(Lchat/ola/vn/entry/g;)V
    .locals 3

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/g;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->c()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/entry/g;->a(J)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/r/a/b;->d()V

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->b:Lchat/ola/vn/p/h;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->b:Lchat/ola/vn/p/h;

    invoke-interface {v0, p0, p1}, Lchat/ola/vn/p/h;->a(Lchat/ola/vn/r/a;Lchat/ola/vn/entry/g;)V

    :cond_2
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/g;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_2

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/g;

    invoke-virtual {v1}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v2

    if-eqz v1, :cond_0

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-interface {v3, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-interface {v3, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/r/a/b;->d()V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/r/a/b;->b:Lchat/ola/vn/p/h;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->b:Lchat/ola/vn/p/h;

    invoke-interface {v0, p0, p1}, Lchat/ola/vn/p/h;->a(Lchat/ola/vn/r/a;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method public b()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public c()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->d:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->t()V

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->b:Lchat/ola/vn/p/h;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/b;->b:Lchat/ola/vn/p/h;

    invoke-interface {v0, p0}, Lchat/ola/vn/p/h;->a(Lchat/ola/vn/r/a;)V

    :cond_0
    return-void
.end method
