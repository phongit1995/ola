.class Lchat/ola/vn/w/bf;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/16 p3, 0x4f

    iget-object v0, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_1

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 24

    move-object/from16 v0, p1

    const/4 v1, 0x0

    const/16 v2, 0xff

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v10, v2

    const/16 v2, 0x64

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    const-wide/16 v3, 0x0

    invoke-virtual {v0, v2, v3, v4}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v4

    const/16 v2, 0x65

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v6

    const/16 v2, 0x68

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    :try_start_0
    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/r/a/f;->a(J)Lchat/ola/vn/entity/s;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lchat/ola/vn/entity/s;->f()Ljava/lang/String;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v2, v3

    :catch_0
    :cond_0
    move-object v7, v2

    const/4 v2, 0x7

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->c(S)I

    move-result v3

    const/4 v8, 0x0

    if-lez v3, :cond_8

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8, v3}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v11

    move v12, v11

    const/4 v11, 0x0

    :goto_0
    if-ge v11, v3, :cond_7

    invoke-virtual {v0, v2, v12}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v13

    invoke-virtual {v0, v12}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v14

    const/16 v15, 0xd

    invoke-virtual {v0, v15, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v15

    const/16 v2, 0x56

    invoke-virtual {v0, v2, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v2

    const/16 v1, 0x16

    invoke-virtual {v0, v1, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    move/from16 v16, v3

    const/16 v3, 0x6d

    invoke-virtual {v0, v3, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v3

    move/from16 v17, v10

    const/16 v10, 0x2d

    move-object/from16 v18, v7

    const/4 v7, 0x0

    invoke-virtual {v0, v10, v12, v13, v7}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v10

    int-to-short v10, v10

    move-object/from16 v19, v6

    const/16 v6, 0x73

    invoke-virtual {v0, v6, v12, v13, v7}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_1

    move-wide/from16 v20, v4

    const/4 v6, 0x1

    goto :goto_1

    :cond_1
    move-wide/from16 v20, v4

    const/4 v6, 0x0

    :goto_1
    const/16 v4, 0x72

    const/4 v5, 0x0

    invoke-virtual {v0, v4, v12, v13, v5}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v4

    if-ne v4, v7, :cond_2

    const/4 v4, 0x1

    goto :goto_2

    :cond_2
    const/4 v4, 0x0

    :goto_2
    const/16 v5, 0x26

    const/4 v7, -0x1

    invoke-virtual {v0, v5, v12, v13, v7}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v5

    int-to-short v5, v5

    move/from16 v22, v11

    const/16 v11, 0x58

    invoke-virtual {v0, v11, v12, v13, v7}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v7

    const/16 v11, 0x4f

    invoke-virtual {v0, v11, v12, v13}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v11

    move-object/from16 v12, p3

    iget-object v0, v12, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {v0, v14}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v12, 0x0

    goto :goto_4

    :cond_3
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, v14}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_4

    new-instance v0, Lchat/ola/vn/message/f;

    const/4 v12, 0x0

    invoke-direct {v0, v14, v12}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    goto :goto_3

    :cond_4
    const/4 v12, 0x0

    :goto_3
    const/4 v1, 0x2

    if-eqz v11, :cond_5

    const-string v14, " "

    invoke-static {v11, v14}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v11

    if-eqz v11, :cond_5

    array-length v14, v11

    if-lt v14, v1, :cond_5

    aget-object v14, v11, v12

    invoke-virtual {v0, v14}, Lchat/ola/vn/message/f;->j(Ljava/lang/String;)V

    const/4 v14, 0x1

    aget-object v11, v11, v14

    invoke-virtual {v0, v11}, Lchat/ola/vn/message/f;->k(Ljava/lang/String;)V

    :cond_5
    invoke-virtual {v0, v2}, Lchat/ola/vn/message/f;->f(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {v0, v15}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    invoke-virtual {v0, v10}, Lchat/ola/vn/message/f;->e(S)V

    invoke-virtual {v0, v5}, Lchat/ola/vn/message/f;->c(S)V

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/f;->i(Ljava/lang/String;)V

    invoke-virtual {v0, v7}, Lchat/ola/vn/message/f;->a(B)V

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->c(Z)V

    invoke-interface {v8, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-eqz v6, :cond_6

    invoke-interface {v9, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    :goto_4
    add-int/lit8 v11, v22, 0x1

    move v12, v13

    move/from16 v3, v16

    move/from16 v10, v17

    move-object/from16 v7, v18

    move-object/from16 v6, v19

    move-wide/from16 v4, v20

    move-object/from16 v0, p1

    const/4 v1, 0x0

    const/4 v2, 0x7

    goto/16 :goto_0

    :cond_7
    move-wide/from16 v20, v4

    move-object/from16 v19, v6

    move-object/from16 v18, v7

    move/from16 v17, v10

    goto :goto_5

    :cond_8
    move-wide/from16 v20, v4

    move-object/from16 v19, v6

    move-object/from16 v18, v7

    move/from16 v17, v10

    move-object v9, v8

    :goto_5
    move-object/from16 v3, p2

    move-wide/from16 v4, v20

    move-object/from16 v6, v19

    move-object/from16 v7, v18

    move/from16 v10, v17

    invoke-interface/range {v3 .. v10}, Lchat/ola/vn/p/g;->a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V

    return-void
.end method
