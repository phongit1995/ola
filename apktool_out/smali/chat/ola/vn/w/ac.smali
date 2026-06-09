.class Lchat/ola/vn/w/ac;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# instance fields
.field e:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 2

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x72

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ac;->e:Ljava/lang/String;

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    :try_start_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->G:[Ljava/lang/String;

    if-eqz p3, :cond_1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    if-eqz p3, :cond_1

    const/4 p3, 0x0

    :goto_0
    iget-object v0, p1, Lchat/ola/vn/w/bk;->G:[Ljava/lang/String;

    array-length v0, v0

    if-ge p3, v0, :cond_1

    const/4 v0, 0x4

    iget-object v1, p1, Lchat/ola/vn/w/bk;->G:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v0, 0x16

    iget-object v1, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :catch_0
    move-exception p3

    invoke-virtual {p3}, Ljava/lang/Throwable;->printStackTrace()V

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
    .locals 16

    move-object/from16 v0, p1

    const/4 v1, 0x0

    const/16 v2, 0x72

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v2

    const/16 v3, 0xff

    invoke-virtual {v0, v3, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v9, v3

    const/16 v3, 0x16

    const/4 v4, 0x7

    packed-switch v2, :pswitch_data_0

    :cond_0
    move-object/from16 v10, p0

    return-void

    :pswitch_0
    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    if-lez v2, :cond_0

    new-array v6, v2, [Ljava/lang/String;

    new-array v5, v2, [Ljava/lang/String;

    const/16 v7, 0x6d

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0, v4, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v7

    :goto_0
    if-ge v1, v2, :cond_2

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v5, v1

    invoke-virtual {v0, v4, v7}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v10

    invoke-virtual {v0, v3, v7, v10}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v6, v1

    aget-object v7, v6, v1

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    aget-object v7, v5, v1

    aput-object v7, v6, v1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    move v7, v10

    goto :goto_0

    :cond_2
    move-object/from16 v10, p0

    iget-object v7, v10, Lchat/ola/vn/w/ac;->e:Ljava/lang/String;

    move-object/from16 v4, p2

    invoke-interface/range {v4 .. v9}, Lchat/ola/vn/p/g;->a([Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :pswitch_1
    move-object/from16 v10, p0

    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    const/4 v5, 0x0

    if-lez v2, :cond_4

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v0, v4, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    const/4 v7, 0x4

    invoke-virtual {v0, v7, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v8

    move v11, v8

    move v8, v6

    const/4 v6, 0x0

    :goto_1
    if-ge v6, v2, :cond_4

    invoke-virtual {v0, v4, v8}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v12

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Lchat/ola/vn/message/f;

    invoke-direct {v14, v13, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v0, v11}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Lchat/ola/vn/message/f;->h(Ljava/lang/String;)V

    invoke-virtual {v0, v3, v8, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v15

    if-eqz v15, :cond_3

    goto :goto_2

    :cond_3
    move-object v13, v8

    :goto_2
    invoke-virtual {v14, v13}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    invoke-interface {v5, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v7, v11}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v11

    add-int/lit8 v6, v6, 0x1

    move v8, v12

    goto :goto_1

    :cond_4
    move-object/from16 v0, p2

    invoke-interface {v0, v5, v9}, Lchat/ola/vn/p/g;->c(Ljava/util/List;S)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
