.class public Lchat/ola/vn/w/ec;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 4

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x72

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/4 p3, 0x7

    iget-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const-wide/16 v0, 0x0

    iget-wide v2, p1, Lchat/ola/vn/w/bk;->W:J

    cmp-long p3, v0, v2

    if-eqz p3, :cond_1

    const/16 p3, 0x82

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->W:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

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
    .locals 25

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const/4 v2, 0x0

    const/16 v3, 0xff

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0x72

    invoke-virtual {v0, v4, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {v0, v4, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    const/4 v5, 0x7

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x1c

    invoke-virtual {v0, v6}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0xd

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v7

    if-nez v5, :cond_0

    move-object/from16 v5, p3

    iget-object v5, v5, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    :cond_0
    const/16 v5, 0x6d

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->c(S)I

    move-result v8

    if-lez v8, :cond_6

    new-array v11, v8, [Lchat/ola/vn/entity/g;

    invoke-virtual {v0, v5, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v12

    const/16 v13, 0x6e

    invoke-virtual {v0, v13, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v14

    const/16 v15, 0x9

    invoke-virtual {v0, v15, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v16

    const/16 v9, 0x82

    invoke-virtual {v0, v9, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v17

    move v9, v14

    move/from16 v15, v16

    move/from16 v13, v17

    move v14, v12

    const/4 v12, 0x0

    :goto_0
    if-ge v12, v8, :cond_5

    invoke-virtual {v0, v5, v14}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v10

    invoke-virtual {v0, v14}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v9}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v2

    move/from16 v18, v8

    const/16 v8, 0x8

    invoke-virtual {v0, v8, v14, v10}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v8

    const/16 v1, 0x18

    invoke-virtual {v0, v1, v14, v10}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    move/from16 v19, v3

    const/16 v3, 0xdc

    move-object/from16 v20, v6

    const/4 v6, 0x0

    invoke-virtual {v0, v3, v14, v10, v6}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v3

    int-to-short v3, v3

    move-object/from16 v21, v7

    const/16 v7, 0x2d

    invoke-virtual {v0, v7, v14, v10, v6}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v7

    int-to-short v7, v7

    move/from16 v22, v7

    const-wide/16 v6, 0x0

    move/from16 v23, v9

    move/from16 v24, v10

    invoke-virtual {v0, v15, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v9

    invoke-virtual {v0, v13, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v6

    new-instance v14, Lchat/ola/vn/entity/g;

    invoke-direct {v14}, Lchat/ola/vn/entity/g;-><init>()V

    aput-object v14, v11, v12

    aget-object v14, v11, v12

    invoke-virtual {v14, v5}, Lchat/ola/vn/entity/g;->e(Ljava/lang/String;)V

    aget-object v5, v11, v12

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->a(Ljava/lang/String;)V

    aget-object v2, v11, v12

    invoke-virtual {v2, v8}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    aget-object v2, v11, v12

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    if-lez v3, :cond_1

    new-instance v2, Lchat/ola/vn/entity/w;

    invoke-direct {v2}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/w;->a(I)V

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    :goto_1
    if-nez v2, :cond_2

    invoke-static {v1}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    new-instance v2, Lchat/ola/vn/entity/w;

    invoke-direct {v2}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    :cond_2
    aget-object v1, v11, v12

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/w;)V

    aget-object v1, v11, v12

    move/from16 v2, v22

    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->e(S)V

    aget-object v1, v11, v12

    invoke-virtual {v1, v9, v10}, Lchat/ola/vn/entity/g;->a(J)V

    aget-object v1, v11, v12

    invoke-virtual {v1, v6, v7}, Lchat/ola/vn/entity/g;->c(J)V

    if-nez v4, :cond_4

    aget-object v1, v11, v12

    const/4 v2, 0x1

    :goto_2
    invoke-virtual {v1, v2}, Lchat/ola/vn/entity/g;->a(B)V

    :cond_3
    move/from16 v14, v23

    const/16 v1, 0x6e

    goto :goto_3

    :cond_4
    const/4 v2, 0x1

    if-ne v4, v2, :cond_3

    aget-object v1, v11, v12

    const/4 v2, 0x2

    goto :goto_2

    :goto_3
    invoke-virtual {v0, v1, v14}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v9

    const/16 v2, 0x9

    invoke-virtual {v0, v2, v15}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v15

    const/16 v3, 0x82

    invoke-virtual {v0, v3, v13}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v13

    add-int/lit8 v12, v12, 0x1

    move/from16 v8, v18

    move/from16 v3, v19

    move-object/from16 v6, v20

    move-object/from16 v7, v21

    move/from16 v14, v24

    move-object/from16 v1, p2

    const/4 v2, 0x0

    const/16 v5, 0x6d

    goto/16 :goto_0

    :cond_5
    move/from16 v19, v3

    move-object/from16 v20, v6

    move-object/from16 v21, v7

    goto :goto_4

    :cond_6
    move/from16 v19, v3

    move-object/from16 v20, v6

    move-object/from16 v21, v7

    const/4 v11, 0x0

    :goto_4
    if-nez v4, :cond_7

    move/from16 v1, v19

    move-object/from16 v2, v20

    move-object/from16 v3, v21

    move-object/from16 v0, p2

    invoke-interface {v0, v2, v3, v11, v1}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V

    return-void

    :cond_7
    move/from16 v1, v19

    move-object/from16 v2, v20

    move-object/from16 v3, v21

    move-object/from16 v0, p2

    const/4 v5, 0x1

    if-ne v4, v5, :cond_8

    invoke-interface {v0, v2, v3, v11, v1}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V

    :cond_8
    return-void
.end method
