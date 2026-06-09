.class public Lchat/ola/vn/u/j;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/u/e;Ljava/util/List;)Lchat/ola/vn/w/cg;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/u/e;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)",
            "Lchat/ola/vn/w/cg;"
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Lchat/ola/vn/w/s;Ljava/util/List;)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x5

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x0

    const/4 v1, 0x2

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(II)I

    move-result v4

    const/16 v1, 0x8

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(II)I

    move-result v5

    const/16 v1, 0xb

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->c(S)I

    move-result v6

    const/16 v7, 0xc

    invoke-virtual {p1, v7, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v7

    const/4 v8, -0x1

    invoke-virtual {p1, v7, v8}, Lchat/ola/vn/w/s;->a(II)I

    move-result v7

    const/4 v9, 0x0

    if-ltz v7, :cond_0

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    goto :goto_0

    :cond_0
    move-object v7, v9

    :goto_0
    if-lez v6, :cond_2

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v6}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v10

    :goto_1
    if-ge v0, v6, :cond_2

    invoke-virtual {p1, v10, v8}, Lchat/ola/vn/w/s;->a(II)I

    move-result v11

    if-ltz v11, :cond_1

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-interface {v9, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {p1, v1, v10}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v10

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    move-object v6, v9

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_3
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    move-object v1, p2

    check-cast v1, Lchat/ola/vn/u/g;

    invoke-interface {v1}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object p2

    invoke-static {v2, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-interface/range {v1 .. v7}, Lchat/ola/vn/u/g;->a(Ljava/lang/String;Ljava/lang/String;IILjava/util/List;Ljava/lang/Integer;)V

    :cond_4
    return-void
.end method
