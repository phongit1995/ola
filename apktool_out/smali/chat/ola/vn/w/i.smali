.class Lchat/ola/vn/w/i;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 2

    const/4 p3, 0x0

    :goto_0
    iget-object v0, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    array-length v0, v0

    if-ge p3, v0, :cond_1

    const/4 v0, 0x7

    iget-object v1, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object v0, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    aget-object v0, v0, p3

    if-eqz v0, :cond_0

    const/16 v0, 0x16

    iget-object v1, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 8

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->c(S)I

    move-result v0

    if-lez v0, :cond_1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x0

    invoke-virtual {p1, p3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    move v4, v3

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v0, :cond_0

    invoke-virtual {p1, p3, v4}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x16

    invoke-virtual {p1, v7, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v4

    new-instance v7, Lchat/ola/vn/message/f;

    invoke-direct {v7, v6, v2}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v7, v4}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;)V

    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    move v4, v5

    goto :goto_0

    :cond_0
    invoke-interface {p2, v1}, Lchat/ola/vn/p/g;->b(Ljava/util/List;)V

    :cond_1
    return-void
.end method
