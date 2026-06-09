.class Lchat/ola/vn/w/ah;
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
    .locals 1

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short v0, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    const/16 p3, 0x81

    iget-object p1, p1, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 11

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/16 v1, 0x81

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x7

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->c(S)I

    move-result v3

    if-lez v3, :cond_1

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {p1, v2, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    move v6, v5

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v3, :cond_2

    invoke-virtual {p1, v2, v6}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v7

    invoke-virtual {p1, v6}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v8

    const/16 v9, 0x16

    invoke-virtual {p1, v9, v6, v7}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v9

    const/16 v10, 0x2d

    invoke-virtual {p1, v10, v6, v7, p3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v6

    int-to-short v6, v6

    sget-object v10, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v10, v8}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v10

    if-nez v10, :cond_0

    new-instance v10, Lchat/ola/vn/message/f;

    invoke-direct {v10, v8, p3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v10, v9}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;)V

    invoke-virtual {v10, v6}, Lchat/ola/vn/message/f;->d(S)V

    :cond_0
    invoke-interface {v4, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v5, v5, 0x1

    move v6, v7

    goto :goto_0

    :cond_1
    const/4 v4, 0x0

    :cond_2
    invoke-interface {p2, v1, v4, v0}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/util/List;S)V

    return-void
.end method
