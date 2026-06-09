.class public Lchat/ola/vn/d/b;
.super Lchat/ola/vn/entry/c/e;


# instance fields
.field private a:Lchat/ola/vn/entry/b;


# direct methods
.method public constructor <init>(Lchat/ola/vn/entry/b;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/d/b;->a:Lchat/ola/vn/entry/b;

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x48

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    aget-object v1, p1, v0

    check-cast v1, Ljava/lang/String;

    const/4 v2, 0x1

    aget-object p1, p1, v2

    check-cast p1, Lchat/ola/vn/entity/i;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->k()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/d/b;->a:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "rss"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "mall"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    :goto_0
    array-length v3, v2

    if-ge v0, v3, :cond_0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/d/b;->a:Lchat/ola/vn/entry/b;

    iput-object v2, p1, Lchat/ola/vn/entry/b;->e:[Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/d/b;->a:Lchat/ola/vn/entry/b;

    iput-object v1, p1, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
