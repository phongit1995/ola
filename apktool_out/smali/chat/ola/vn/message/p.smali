.class public Lchat/ola/vn/message/p;
.super Lchat/ola/vn/message/d;


# instance fields
.field protected z:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public a()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method a(Lchat/ola/vn/message/d;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/message/d;->a(Lchat/ola/vn/message/d;)V

    :try_start_0
    check-cast p1, Lchat/ola/vn/message/p;

    iget-object v0, p1, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object p1, p1, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/message/p;->z:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/message/p;->z:Ljava/util/List;

    return-void
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public w()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
