.class Lchat/ola/vn/w/ed;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# instance fields
.field private e:J


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 4

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->V:J

    iput-wide v0, p0, Lchat/ola/vn/w/ed;->e:J

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->V:J

    const/16 p3, 0x6c

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->S:J

    const-wide/16 v2, 0x0

    cmp-long p3, v0, v2

    if-eqz p3, :cond_0

    const/16 p3, 0x48

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->S:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_0
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
    .locals 32
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    move-object/from16 v6, p1

    const/4 v7, 0x0

    const/16 v0, 0xff

    invoke-virtual {v6, v0, v7}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {v6, v0, v7}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v8, v0

    move-object/from16 v0, p3

    iget-short v0, v0, Lchat/ola/vn/w/ci;->p:S

    if-eq v0, v8, :cond_0

    return-void

    :cond_0
    const/16 v9, 0x8

    invoke-virtual {v6, v9}, Lchat/ola/vn/w/s;->c(S)I

    move-result v0

    if-lez v0, :cond_a

    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12, v0}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v0, -0x1

    const/16 v13, 0x43

    invoke-virtual {v6, v13, v0}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v0

    move v1, v0

    const/4 v0, 0x0

    const/4 v2, 0x0

    :goto_0
    if-nez v0, :cond_9

    invoke-virtual {v6, v13, v1}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v14

    if-gez v14, :cond_1

    const/4 v15, 0x1

    goto :goto_1

    :cond_1
    move v15, v0

    :goto_1
    invoke-virtual {v6, v1}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    const/16 v0, 0x16

    invoke-virtual {v6, v0, v1, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    const/16 v0, 0x2d

    invoke-virtual {v6, v0, v1, v14, v7}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v0

    int-to-short v3, v0

    const/16 v0, 0x48

    invoke-virtual {v6, v0, v1}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v1

    move-object/from16 v16, v2

    move v2, v1

    const/4 v1, 0x0

    :goto_2
    if-nez v1, :cond_8

    invoke-virtual {v6, v0, v2, v14}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v17

    if-gez v17, :cond_2

    move v1, v14

    move/from16 v18, v1

    const/16 v17, 0x1

    goto :goto_3

    :cond_2
    move/from16 v18, v14

    move/from16 v31, v17

    move/from16 v17, v1

    move/from16 v1, v31

    :goto_3
    const-wide/16 v13, 0x0

    invoke-virtual {v6, v2, v13, v14}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v13

    if-nez v16, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_4

    :cond_3
    move-object/from16 v0, v16

    :goto_4
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ""

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v13, v14}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-interface {v0, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/16 v10, 0xdd

    invoke-virtual {v6, v10, v2, v1, v7}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v10

    int-to-short v10, v10

    const/16 v11, 0xdc

    invoke-virtual {v6, v11, v2, v1, v7}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v11

    int-to-short v11, v11

    const/16 v9, 0x7d

    invoke-virtual {v6, v9, v2, v1, v7}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v9

    const/16 v16, 0x9

    const-wide/16 v20, 0x0

    move-object/from16 v19, v0

    const/16 v22, 0x48

    move-object v0, v6

    move/from16 v23, v1

    move/from16 v1, v16

    move/from16 v24, v2

    move/from16 v25, v3

    move/from16 v3, v23

    move-object/from16 v26, v4

    move-object/from16 v27, v5

    move-wide/from16 v4, v20

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    const/16 v4, 0x8

    invoke-virtual {v6, v4, v2, v3}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    const/16 v4, 0x18

    invoke-virtual {v6, v4, v2, v3}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v4

    move/from16 v28, v15

    const/16 v15, 0x72

    invoke-virtual {v6, v15, v2, v3, v7}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v15

    const/16 v15, 0x26

    invoke-virtual {v6, v15, v2, v3}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v15

    new-instance v7, Lchat/ola/vn/entity/g;

    invoke-direct {v7}, Lchat/ola/vn/entity/g;-><init>()V

    move/from16 v29, v8

    const/16 v8, 0x71

    invoke-virtual {v6, v8, v2, v3}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_4

    :try_start_0
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "checkInId"

    invoke-virtual {v8, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string v2, "checkInId"

    invoke-virtual {v8, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v8, "null"

    invoke-static {v2, v8}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_4

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->k(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    invoke-virtual {v7, v13, v14}, Lchat/ola/vn/entity/g;->b(J)V

    move-object/from16 v2, v26

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->a(Ljava/lang/String;)V

    move/from16 v8, v25

    invoke-virtual {v7, v8}, Lchat/ola/vn/entity/g;->e(S)V

    move-object/from16 v30, v2

    move-object/from16 v2, v27

    invoke-virtual {v7, v2}, Lchat/ola/vn/entity/g;->i(Ljava/lang/String;)V

    invoke-virtual {v7, v9}, Lchat/ola/vn/entity/g;->b(I)V

    invoke-virtual {v7, v10}, Lchat/ola/vn/entity/g;->b(S)V

    if-lez v11, :cond_5

    new-instance v9, Lchat/ola/vn/entity/w;

    invoke-direct {v9}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v9, v11}, Lchat/ola/vn/entity/w;->a(I)V

    goto :goto_5

    :cond_5
    const/4 v9, 0x0

    :goto_5
    if-nez v9, :cond_6

    invoke-static {v4}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_6

    new-instance v9, Lchat/ola/vn/entity/w;

    invoke-direct {v9}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v9, v4}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    const/4 v4, 0x0

    :cond_6
    invoke-virtual {v7, v9}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/w;)V

    invoke-virtual {v7, v0, v1}, Lchat/ola/vn/entity/g;->a(J)V

    invoke-virtual {v7, v5}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    invoke-virtual {v7, v4}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    invoke-virtual {v7, v15}, Lchat/ola/vn/entity/g;->f(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-wide v4, v0, Lchat/ola/vn/w/ed;->e:J

    cmp-long v1, v4, v13

    if-nez v1, :cond_7

    const/4 v1, 0x1

    goto :goto_6

    :cond_7
    const/4 v1, 0x0

    :goto_6
    invoke-virtual {v7, v1}, Lchat/ola/vn/entity/g;->a(Z)V

    invoke-interface {v12, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object v5, v2

    move v2, v3

    move v3, v8

    move/from16 v1, v17

    move/from16 v14, v18

    move-object/from16 v16, v19

    move/from16 v15, v28

    move/from16 v8, v29

    move-object/from16 v4, v30

    const/16 v0, 0x48

    const/4 v7, 0x0

    const/16 v9, 0x8

    const/16 v13, 0x43

    goto/16 :goto_2

    :cond_8
    move-object/from16 v0, p0

    move/from16 v18, v14

    move/from16 v28, v15

    move-object/from16 v2, v16

    move/from16 v1, v18

    move/from16 v0, v28

    goto/16 :goto_0

    :cond_9
    move-object/from16 v0, p0

    move/from16 v29, v8

    new-instance v1, Lchat/ola/vn/e/c;

    const/4 v3, 0x0

    invoke-direct {v1, v3}, Lchat/ola/vn/e/c;-><init>(Z)V

    invoke-static {v12, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-static {v12}, Lchat/ola/vn/r/a/e;->e(Ljava/util/List;)V

    :try_start_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_7

    :cond_a
    move-object/from16 v0, p0

    move/from16 v29, v8

    const/4 v12, 0x0

    :catch_1
    :goto_7
    if-eqz v12, :cond_b

    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_b

    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    invoke-interface {v12, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/g;

    move-object/from16 v2, p2

    move/from16 v3, v29

    invoke-interface {v2, v1, v12, v3}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/entity/g;Ljava/util/List;S)V

    :cond_b
    return-void
.end method
