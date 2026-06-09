.class Lchat/ola/vn/w/m;
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

    const/16 p3, 0xc

    const/4 v0, 0x2

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p1, p1, Lchat/ola/vn/w/bk;->r:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0xd

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 19

    move-object/from16 v6, p1

    const/4 v7, 0x7

    invoke-virtual {v6, v7}, Lchat/ola/vn/w/s;->c(S)I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-array v8, v0, [Lchat/ola/vn/message/f;

    const/4 v9, 0x0

    invoke-virtual {v6, v7, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    move v2, v0

    const/4 v0, 0x0

    const/4 v10, 0x0

    :goto_0
    if-nez v0, :cond_2

    invoke-virtual {v6, v7, v2}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v11

    if-gtz v11, :cond_1

    const/4 v13, 0x1

    goto :goto_1

    :cond_1
    move v13, v0

    :goto_1
    const/4 v0, -0x1

    invoke-virtual {v6, v2}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v14

    const/16 v1, 0xc

    invoke-virtual {v6, v1, v2, v11}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v1

    invoke-virtual {v6, v1, v9}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v1

    int-to-short v15, v1

    const/16 v1, 0x2d

    invoke-virtual {v6, v1, v2, v11, v9}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v1

    int-to-short v4, v1

    const/16 v1, 0x26

    invoke-virtual {v6, v1, v2, v11, v0}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v0

    int-to-short v5, v0

    const/16 v0, 0xd

    invoke-virtual {v6, v0, v2, v11}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v3

    const/16 v1, 0x3a

    const-wide/16 v16, 0x0

    move-object v0, v6

    move-object v7, v3

    move v3, v11

    move v12, v4

    move/from16 v18, v5

    move-wide/from16 v4, v16

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    new-instance v2, Lchat/ola/vn/message/f;

    invoke-direct {v2, v14, v9}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    aput-object v2, v8, v10

    aget-object v2, v8, v10

    invoke-virtual {v2, v12}, Lchat/ola/vn/message/f;->e(S)V

    aget-object v2, v8, v10

    move/from16 v3, v18

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/f;->c(S)V

    aget-object v2, v8, v10

    invoke-virtual {v2, v15}, Lchat/ola/vn/message/f;->b(S)V

    aget-object v2, v8, v10

    invoke-virtual {v2, v7}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    aget-object v2, v8, v10

    invoke-virtual {v2, v0, v1}, Lchat/ola/vn/message/f;->c(J)V

    const/4 v0, 0x1

    add-int/2addr v10, v0

    move v2, v11

    move v0, v13

    const/4 v7, 0x7

    goto :goto_0

    :cond_2
    move-object/from16 v0, p2

    invoke-interface {v0, v8}, Lchat/ola/vn/p/g;->a([Lchat/ola/vn/message/f;)V

    return-void
.end method
