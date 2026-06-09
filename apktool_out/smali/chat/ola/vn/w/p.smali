.class public Lchat/ola/vn/w/p;
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
    .locals 1

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_0

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget p3, p1, Lchat/ola/vn/w/bk;->aa:I

    if-eqz p3, :cond_1

    const/16 p3, 0x7c

    iget v0, p1, Lchat/ola/vn/w/bk;->aa:I

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SI)V

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
    .locals 20

    move-object/from16 v0, p1

    const/4 v1, 0x0

    const/16 v2, 0xff

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v2, v2

    const/16 v3, 0x72

    invoke-virtual {v0, v3, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0x6d

    packed-switch v3, :pswitch_data_0

    return-void

    :pswitch_0
    :try_start_0
    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_12

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v0}, Ljava/util/ArrayList;-><init>(I)V

    :goto_0
    if-ge v1, v0, :cond_f

    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "title"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_e

    const-string v6, "title"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v8, "slogan"

    invoke-virtual {v5, v8}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    const-string v8, "slogan"

    invoke-virtual {v5, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    goto :goto_1

    :cond_0
    const/4 v8, 0x0

    :goto_1
    const-string v9, "description"

    invoke-virtual {v5, v9}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_1

    const-string v9, "description"

    invoke-virtual {v5, v9}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    goto :goto_2

    :cond_1
    const/4 v9, 0x0

    :goto_2
    const-string v10, "adId"

    invoke-virtual {v5, v10}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_2

    const-string v10, "adId"

    invoke-virtual {v5, v10}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    goto :goto_3

    :cond_2
    const/4 v10, 0x0

    :goto_3
    const-string v11, "appId"

    invoke-virtual {v5, v11}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_3

    const-string v11, "appId"

    invoke-virtual {v5, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    goto :goto_4

    :cond_3
    const/4 v11, 0x0

    :goto_4
    const-string v12, "downloadUrl"

    invoke-virtual {v5, v12}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_4

    const-string v12, "downloadUrl"

    invoke-virtual {v5, v12}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v11}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_5

    invoke-static {v12}, Lchat/ola/vn/util/m;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    goto :goto_5

    :cond_4
    const/4 v12, 0x0

    :cond_5
    :goto_5
    const-string v13, "shareUrl"

    invoke-virtual {v5, v13}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_6

    const-string v13, "shareUrl"

    invoke-virtual {v5, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    goto :goto_6

    :cond_6
    const/4 v13, 0x0

    :goto_6
    const-string v14, "appIconUrl"

    invoke-virtual {v5, v14}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_7

    const-string v14, "appIconUrl"

    invoke-virtual {v5, v14}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    goto :goto_7

    :cond_7
    const/4 v14, 0x0

    :goto_7
    const-string v15, "youtubeCode"

    invoke-virtual {v5, v15}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v15

    if-eqz v15, :cond_8

    const-string v15, "youtubeCode"

    invoke-virtual {v5, v15}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    goto :goto_8

    :cond_8
    const/4 v15, 0x0

    :goto_8
    const-string v7, "bannerMediaCode"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_7

    if-eqz v7, :cond_b

    :try_start_1
    const-string v7, "bannerMediaCode"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    move/from16 v16, v0

    :try_start_2
    const-string v0, ";"

    invoke-static {v7, v0}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    if-eqz v0, :cond_9

    move-object/from16 v17, v3

    :try_start_3
    array-length v3, v0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    move-object/from16 v18, v6

    const/4 v6, 0x1

    if-le v3, v6, :cond_a

    :try_start_4
    new-instance v3, Ljava/util/Random;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    move-object/from16 v19, v7

    :try_start_5
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v6

    invoke-direct {v3, v6, v7}, Ljava/util/Random;-><init>(J)V

    array-length v6, v0

    invoke-virtual {v3, v6}, Ljava/util/Random;->nextInt(I)I

    move-result v3

    aget-object v7, v0, v3
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    goto :goto_9

    :cond_9
    move-object/from16 v17, v3

    move-object/from16 v18, v6

    goto :goto_9

    :catch_0
    move-object/from16 v17, v3

    :catch_1
    move-object/from16 v18, v6

    :catch_2
    :cond_a
    :goto_9
    move-object/from16 v19, v7

    goto :goto_a

    :catch_3
    move/from16 v16, v0

    move-object/from16 v17, v3

    move-object/from16 v18, v6

    const/16 v19, 0x0

    :catch_4
    :goto_a
    move-object/from16 v7, v19

    goto :goto_b

    :cond_b
    move/from16 v16, v0

    move-object/from16 v17, v3

    move-object/from16 v18, v6

    const/4 v7, 0x0

    :goto_b
    :try_start_6
    const-string v0, "downloadDetails"

    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    const-string v0, "downloadDetails"

    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_c

    :cond_c
    const/4 v0, 0x0

    :goto_c
    const-string v3, "rating"

    invoke-virtual {v5, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_7

    if-eqz v3, :cond_d

    :try_start_7
    const-string v3, "rating"

    invoke-virtual {v5, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Float;->valueOf(Ljava/lang/String;)Ljava/lang/Float;

    move-result-object v3
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    move-object v5, v3

    move-object v3, v0

    move-object/from16 v0, v18

    goto :goto_d

    :catch_5
    :cond_d
    move-object v3, v0

    move-object/from16 v0, v18

    const/4 v5, 0x0

    goto :goto_d

    :cond_e
    move/from16 v16, v0

    move-object/from16 v17, v3

    const/4 v0, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    :goto_d
    :try_start_8
    new-instance v6, Lchat/ola/vn/entity/k;

    invoke-direct {v6}, Lchat/ola/vn/entity/k;-><init>()V

    iput-object v0, v6, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    iput-object v8, v6, Lchat/ola/vn/entity/k;->e:Ljava/lang/String;

    iput-object v9, v6, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    iput-object v10, v6, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    iput-object v12, v6, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    iput-object v13, v6, Lchat/ola/vn/entity/k;->i:Ljava/lang/String;

    iput-object v14, v6, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    iput-object v7, v6, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    iput-object v15, v6, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    iput-object v3, v6, Lchat/ola/vn/entity/k;->l:Ljava/lang/String;

    iput-object v5, v6, Lchat/ola/vn/entity/k;->n:Ljava/lang/Float;

    iput-object v11, v6, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-interface {v4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    move/from16 v0, v16

    move-object/from16 v3, v17

    goto/16 :goto_0

    :cond_f
    move-object/from16 v3, p2

    invoke-interface {v3, v4, v2}, Lchat/ola/vn/p/g;->d(Ljava/util/List;S)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_7

    return-void

    :pswitch_1
    move-object/from16 v3, p2

    const-wide/16 v5, 0x0

    :try_start_9
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/e;->c()J

    move-result-wide v7
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_6

    goto :goto_e

    :catch_6
    move-wide v7, v5

    :goto_e
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    sub-long v11, v9, v7

    const-wide/32 v7, 0xa4cb80

    cmp-long v2, v11, v7

    if-ltz v2, :cond_12

    const/16 v2, 0x1c

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v7, 0x82

    invoke-virtual {v0, v7, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v7

    invoke-virtual {v0, v7, v5, v6}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v7

    const/16 v5, 0x7c

    invoke-virtual {v0, v5, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    invoke-virtual {v0, v5, v1}, Lchat/ola/vn/w/s;->a(II)I

    move-result v13

    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v9

    const/16 v1, 0x6e

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v11

    const/16 v1, 0x6f

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v12

    const/16 v1, 0x70

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v4, 0x71

    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v14

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_10

    invoke-static {v9}, Lchat/ola/vn/util/m;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v10, v0

    goto :goto_f

    :cond_10
    move-object v10, v1

    :goto_f
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, v10}, Lchat/ola/vn/util/b;->k(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, v13}, Lchat/ola/vn/e;->a(I)V

    return-void

    :cond_11
    move-object v5, v3

    move-object v6, v2

    invoke-interface/range {v5 .. v14}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    :catch_7
    :cond_12
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
