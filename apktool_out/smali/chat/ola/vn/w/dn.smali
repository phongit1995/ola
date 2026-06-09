.class Lchat/ola/vn/w/dn;
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

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->R:J

    const/16 p3, 0x64

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    iget-short p3, p1, Lchat/ola/vn/w/bk;->ai:S

    if-lez p3, :cond_0

    const/16 p3, 0xdc

    iget-short v0, p1, Lchat/ola/vn/w/bk;->ai:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    const/16 p3, 0x8

    iget-object p1, p1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 12

    const/4 p3, 0x0

    const/16 v0, 0x64

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const-wide/16 v1, 0x0

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v0

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
    if-ge v5, v3, :cond_0

    invoke-virtual {p1, v2, v6}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v7

    invoke-virtual {p1, v6}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v8

    const/16 v9, 0x8

    invoke-virtual {p1, v9, v6, v7}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v9

    const/16 v10, 0xdc

    invoke-virtual {p1, v10, v6, v7, p3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v10

    int-to-short v10, v10

    const/16 v11, 0x2d

    invoke-virtual {p1, v11, v6, v7, p3}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v6

    int-to-short v6, v6

    new-instance v11, Lchat/ola/vn/message/d;

    invoke-direct {v11}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v11, v8}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v11, v9}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v11, v10}, Lchat/ola/vn/message/d;->b(S)V

    invoke-virtual {v11, v6}, Lchat/ola/vn/message/d;->a(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v11, v8, v9}, Lchat/ola/vn/message/d;->a(J)V

    const/4 v6, 0x2

    invoke-virtual {v11, v6}, Lchat/ola/vn/message/d;->a(B)V

    const/4 v6, 0x1

    invoke-static {v11, v6}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object v6

    invoke-interface {v4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v5, v5, 0x1

    move v6, v7

    goto :goto_0

    :cond_0
    invoke-interface {p2, v0, v1, v4}, Lchat/ola/vn/p/g;->a(JLjava/util/List;)V

    :cond_1
    return-void
.end method
