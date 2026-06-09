.class public Lchat/ola/vn/w/e;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;S)V
    .locals 7

    const/16 p2, 0x6e

    invoke-virtual {p1, p2}, Lchat/ola/vn/w/s;->c(S)I

    move-result p3

    if-lez p3, :cond_2

    new-instance p4, Ljava/util/ArrayList;

    invoke-direct {p4, p3}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    move v2, v1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p3, :cond_2

    invoke-virtual {p1, p2, v2}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v3

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x14

    invoke-virtual {p1, v5, v2, v3}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v5

    invoke-virtual {p1, v5, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v5

    int-to-short v5, v5

    if-nez v5, :cond_0

    const/4 v5, 0x0

    goto :goto_1

    :cond_0
    const/4 v6, 0x1

    if-ne v5, v6, :cond_1

    const/4 v5, 0x2

    :goto_1
    const/16 v6, 0x7c

    invoke-virtual {p1, v6, v2, v3}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v2

    invoke-virtual {p1, v2, v0}, Lchat/ola/vn/w/s;->a(II)I

    move-result v2

    if-lez v2, :cond_1

    new-instance v6, Lchat/ola/vn/message/f;

    invoke-direct {v6, v4, v5}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v6, v2}, Lchat/ola/vn/message/f;->a(I)V

    invoke-interface {p4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v1, v1, 0x1

    move v2, v3

    goto :goto_0

    :cond_2
    return-void
.end method

.method private a(Lchat/ola/vn/w/s;SLchat/ola/vn/p/g;Lchat/ola/vn/w/ci;S)V
    .locals 29

    move-object/from16 v6, p1

    move/from16 v7, p2

    move-object/from16 v8, p4

    const/16 v0, 0x6e

    invoke-virtual {v6, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v9

    const/16 v10, 0x14

    const/4 v11, 0x0

    invoke-virtual {v6, v10, v11}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {v6, v0, v11}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    const/4 v12, 0x7

    invoke-virtual {v6, v12}, Lchat/ola/vn/w/s;->c(S)I

    move-result v13

    const/16 v1, 0x70

    invoke-virtual {v6, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    const-string v1, "null"

    :cond_0
    move-object v14, v1

    const/4 v5, 0x0

    const/4 v4, 0x1

    if-nez v0, :cond_1

    const/4 v3, 0x0

    goto :goto_0

    :cond_1
    if-ne v0, v4, :cond_e

    const/4 v3, 0x2

    :goto_0
    const/4 v0, 0x0

    if-lez v13, :cond_9

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v13}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v6, v12, v11}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    move-object/from16 v16, v0

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v13, :cond_8

    invoke-virtual {v6, v12, v1}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v0

    invoke-virtual {v6, v1}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v12

    const/16 v17, 0x9

    const-wide/16 v18, 0x0

    move/from16 v20, v0

    move-object v0, v6

    move/from16 v21, v1

    move/from16 v1, v17

    move/from16 v17, v2

    move/from16 v2, v21

    move/from16 v22, v3

    move/from16 v3, v20

    move-object/from16 v23, v5

    const/4 v10, 0x1

    move-wide/from16 v4, v18

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v4

    const/16 v1, 0x82

    move-wide/from16 v24, v4

    move-wide/from16 v4, v18

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    const/16 v2, 0x8

    move/from16 v4, v20

    move/from16 v3, v21

    invoke-virtual {v6, v2, v3, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v2

    const/16 v5, 0x6f

    invoke-virtual {v6, v5, v3, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    const/16 v15, 0xdc

    invoke-virtual {v6, v15, v3, v4}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v15

    invoke-virtual {v6, v15, v11}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v15

    int-to-short v15, v15

    const/16 v10, 0x2d

    invoke-virtual {v6, v10, v3, v4}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v10

    invoke-virtual {v6, v10, v11}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v10

    int-to-short v10, v10

    move/from16 v26, v13

    const/16 v13, 0x74

    invoke-virtual {v6, v13, v3, v4}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v13

    invoke-virtual {v6, v13, v11}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v13

    const/4 v11, 0x1

    if-ne v13, v11, :cond_2

    const/4 v13, 0x1

    goto :goto_2

    :cond_2
    const/4 v13, 0x0

    :goto_2
    const/16 v11, 0x75

    invoke-virtual {v6, v11, v3, v4}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v11

    move-object/from16 v27, v9

    const/4 v9, 0x0

    invoke-virtual {v6, v11, v9}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v11

    const/4 v9, 0x1

    if-ne v11, v9, :cond_3

    const/4 v9, 0x1

    goto :goto_3

    :cond_3
    const/4 v9, 0x0

    :goto_3
    const/16 v11, 0x89

    invoke-virtual {v6, v11, v3, v4}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v3

    const/4 v11, 0x0

    invoke-virtual {v6, v3, v11}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v3

    new-instance v11, Lchat/ola/vn/message/d;

    invoke-direct {v11}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v11, v12}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v11, v5}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    move/from16 v28, v4

    move-wide/from16 v4, v24

    invoke-virtual {v11, v4, v5}, Lchat/ola/vn/message/d;->a(J)V

    invoke-virtual {v11, v3}, Lchat/ola/vn/message/d;->a(B)V

    invoke-virtual {v11, v2}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v11, v15}, Lchat/ola/vn/message/d;->b(S)V

    invoke-virtual {v11, v10}, Lchat/ola/vn/message/d;->a(S)V

    invoke-virtual {v11, v14}, Lchat/ola/vn/message/d;->i(Ljava/lang/String;)V

    iput-boolean v13, v11, Lchat/ola/vn/message/d;->w:Z

    iput-boolean v9, v11, Lchat/ola/vn/message/d;->x:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    add-long v4, v2, v0

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, v11, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iget-object v0, v8, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {v0, v12}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x2

    :goto_4
    invoke-static {v11, v0}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object v1

    goto :goto_5

    :cond_4
    const/4 v0, 0x1

    goto :goto_4

    :goto_5
    :try_start_0
    invoke-virtual {v1}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/4 v2, 0x3

    if-ne v0, v2, :cond_6

    if-nez v16, :cond_5

    new-instance v0, Ljava/util/ArrayList;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/16 v2, 0x14

    :try_start_1
    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_6

    :cond_5
    const/16 v2, 0x14

    move-object/from16 v0, v16

    :goto_6
    :try_start_2
    move-object v3, v1

    check-cast v3, Lchat/ola/vn/message/aa;

    invoke-virtual {v3}, Lchat/ola/vn/message/aa;->C()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-object/from16 v16, v0

    goto :goto_7

    :catch_1
    :cond_6
    const/16 v2, 0x14

    :catch_2
    :goto_7
    if-eqz v1, :cond_7

    move-object/from16 v0, v23

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_8

    :cond_7
    move-object/from16 v0, v23

    :goto_8
    add-int/lit8 v1, v17, 0x1

    move-object v5, v0

    move v2, v1

    move/from16 v3, v22

    move/from16 v13, v26

    move-object/from16 v9, v27

    move/from16 v1, v28

    const/4 v4, 0x1

    const/16 v10, 0x14

    const/4 v11, 0x0

    const/4 v12, 0x7

    goto/16 :goto_1

    :cond_8
    move/from16 v22, v3

    move-object v0, v5

    move-object/from16 v27, v9

    move-object/from16 v0, v16

    goto :goto_9

    :cond_9
    move/from16 v22, v3

    move-object/from16 v27, v9

    :goto_9
    const/4 v1, 0x1

    if-ne v7, v1, :cond_a

    move/from16 v11, v22

    int-to-short v3, v11

    move-object/from16 v1, p3

    move-object/from16 v2, v27

    move-object v4, v14

    move/from16 v6, p5

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V

    goto :goto_a

    :cond_a
    move/from16 v11, v22

    const/4 v1, 0x2

    if-ne v7, v1, :cond_b

    int-to-short v3, v11

    move-object/from16 v1, p3

    move-object/from16 v2, v27

    move-object v4, v14

    move/from16 v6, p5

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V

    :cond_b
    :goto_a
    if-eqz v0, :cond_d

    :try_start_3
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_d

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    :goto_b
    array-length v3, v1

    if-ge v2, v3, :cond_c

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_b

    :cond_c
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "inbox:"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, v8, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v8, v0, v1, v2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;S)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_d
    return-void

    :cond_e
    move-object/from16 v27, v9

    const/4 v1, 0x1

    if-ne v7, v1, :cond_f

    int-to-short v3, v0

    const/4 v5, 0x0

    move-object/from16 v1, p3

    move-object/from16 v2, v27

    move-object v4, v14

    move/from16 v6, p5

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V

    return-void

    :cond_f
    const/4 v1, 0x2

    if-ne v7, v1, :cond_10

    int-to-short v3, v0

    move-object/from16 v1, p3

    move-object/from16 v2, v27

    move-object v4, v14

    move/from16 v6, p5

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V

    :cond_10
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_0

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget-short p3, p1, Lchat/ola/vn/w/bk;->al:S

    if-eqz p3, :cond_1

    const/16 p3, 0x14

    iget-short v0, p1, Lchat/ola/vn/w/bk;->al:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_3

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    iget-object p3, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_4

    const/16 p3, 0x70

    iget-object v0, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_4
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_5

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_5
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 8

    const/4 v0, 0x0

    const/16 v1, 0xff

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v1

    int-to-short v7, v1

    const/16 v1, 0x72

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    int-to-short v4, v0

    move-object v2, p0

    move-object v3, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v2 .. v7}, Lchat/ola/vn/w/e;->a(Lchat/ola/vn/w/s;SLchat/ola/vn/p/g;Lchat/ola/vn/w/ci;S)V

    return-void

    :pswitch_1
    invoke-direct {p0, p1, p2, p3, v7}, Lchat/ola/vn/w/e;->a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;S)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method
