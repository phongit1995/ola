.class Lchat/ola/vn/w/ag;
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
    .locals 0

    iget p3, p1, Lchat/ola/vn/w/bk;->aa:I

    if-eqz p3, :cond_0

    const/16 p3, 0x27

    iget p1, p1, Lchat/ola/vn/w/bk;->aa:I

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SI)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 11

    const/4 p3, 0x0

    const/16 v0, 0x27

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result v0

    const/16 v1, 0x81

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    if-lez v2, :cond_0

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {p1, v1, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    :goto_0
    if-ge p3, v2, :cond_1

    invoke-virtual {p1, v1, v4}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x16

    invoke-virtual {p1, v7, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v7

    const/16 v8, 0xd

    invoke-virtual {p1, v8, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v8

    const/16 v9, 0x18

    invoke-virtual {p1, v9, v4, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v4

    new-instance v9, Lchat/ola/vn/message/f;

    const/4 v10, 0x2

    invoke-direct {v9, v6, v10}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v9, v7}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    invoke-virtual {v9, v8}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    invoke-virtual {v9, v10}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {v9, v4}, Lchat/ola/vn/message/f;->g(Ljava/lang/String;)V

    const/4 v4, 0x1

    invoke-virtual {v9, v4}, Lchat/ola/vn/message/f;->b(B)V

    invoke-interface {v3, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x1

    move v4, v5

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :cond_1
    invoke-interface {p2, v0, v3}, Lchat/ola/vn/p/g;->a(ILjava/util/List;)V

    return-void
.end method
