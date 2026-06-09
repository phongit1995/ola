.class Lchat/ola/vn/w/cj;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->u:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x1e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->u:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->D:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/16 p3, 0x71

    iget-object v0, p1, Lchat/ola/vn/w/bk;->D:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_2

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 17

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const/4 v2, 0x0

    const/16 v3, 0xff

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0x1f

    invoke-virtual {v0, v4, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {v0, v4, v2}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v4

    const/16 v5, 0x1d

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->c(S)I

    move-result v6

    new-instance v7, Lchat/ola/vn/entity/ad;

    invoke-direct {v7}, Lchat/ola/vn/entity/ad;-><init>()V

    const/16 v8, 0x6e

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lchat/ola/vn/entity/ad;->i(Ljava/lang/String;)V

    const/16 v8, 0x6f

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lchat/ola/vn/entity/ad;->h(Ljava/lang/String;)V

    const/16 v8, 0x6d

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lchat/ola/vn/entity/ad;->f(Ljava/lang/String;)V

    const/16 v8, 0xcf

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lchat/ola/vn/entity/ad;->e(Ljava/lang/String;)V

    const/16 v8, 0x71

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    if-lez v6, :cond_2

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v6}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v0, v5, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v10

    const/16 v11, 0x1e

    invoke-virtual {v0, v11, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v12

    move v13, v10

    const/4 v10, 0x0

    :goto_0
    if-ge v10, v6, :cond_3

    invoke-virtual {v0, v11, v12}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v14

    new-instance v15, Lchat/ola/vn/entity/ad;

    invoke-direct {v15}, Lchat/ola/vn/entity/ad;-><init>()V

    invoke-virtual {v0, v13}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v15, v11}, Lchat/ola/vn/entity/ad;->f(Ljava/lang/String;)V

    invoke-virtual {v0, v12}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v15, v5}, Lchat/ola/vn/entity/ad;->e(Ljava/lang/String;)V

    const/16 v5, 0x18

    invoke-virtual {v0, v5, v12, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v15, v5}, Lchat/ola/vn/entity/ad;->d(Ljava/lang/String;)V

    const/16 v5, 0x8

    invoke-virtual {v0, v5, v12, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v15, v5}, Lchat/ola/vn/entity/ad;->c(Ljava/lang/String;)V

    const/16 v5, 0x7c

    invoke-virtual {v0, v5, v12, v14, v2}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v5

    invoke-virtual {v15, v5}, Lchat/ola/vn/entity/ad;->b(I)V

    const/16 v5, 0x7d

    invoke-virtual {v0, v5, v12, v14, v2}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v5

    invoke-virtual {v15, v5}, Lchat/ola/vn/entity/ad;->c(I)V

    const/16 v5, 0x1d

    invoke-virtual {v0, v5, v13}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v13

    invoke-static {v11}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v12

    if-nez v12, :cond_1

    const-string v12, "null"

    invoke-static {v11, v12}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_0

    goto :goto_1

    :cond_0
    invoke-interface {v9, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    :goto_1
    add-int/lit8 v10, v10, 0x1

    move v12, v14

    const/16 v11, 0x1e

    goto :goto_0

    :cond_2
    const/4 v9, 0x0

    :cond_3
    int-to-short v0, v4

    invoke-virtual {v7, v0}, Lchat/ola/vn/entity/ad;->a(S)V

    packed-switch v4, :pswitch_data_0

    invoke-interface {v1, v7, v9, v8, v3}, Lchat/ola/vn/p/g;->c(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V

    return-void

    :pswitch_0
    invoke-interface {v1, v7, v9, v8, v3}, Lchat/ola/vn/p/g;->b(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V

    return-void

    :pswitch_1
    invoke-interface {v1, v7, v9, v8, v3}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
