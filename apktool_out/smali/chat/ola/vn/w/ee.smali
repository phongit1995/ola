.class Lchat/ola/vn/w/ee;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field private e:Ljava/lang/String;

.field private f:J

.field private g:Lchat/ola/vn/e/c;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/w/ee;->e:Ljava/lang/String;

    return-void
.end method

.method private a(Ljava/lang/String;)Lchat/ola/vn/entity/g;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-short v1, Lchat/ola/vn/h;->H:S

    if-lez v1, :cond_1

    return-object v0

    :cond_1
    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "av"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "md"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "lk"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "#ola"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "#apk"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "#hai"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "me"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "rs"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    :cond_2
    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->w()Z

    move-result p1

    if-eqz p1, :cond_4

    sget-boolean p1, Lchat/ola/vn/util/a;->c:Z

    if-nez p1, :cond_3

    return-object v0

    :cond_3
    new-instance p1, Lchat/ola/vn/entity/g;

    invoke-direct {p1}, Lchat/ola/vn/entity/g;-><init>()V

    const/4 v1, 0x5

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/g;->d(S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_4
    return-object v0
.end method

.method private b(Ljava/lang/String;)Lchat/ola/vn/entity/g;
    .locals 9

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->C()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sget-wide v5, Lchat/ola/vn/r/a/e;->c:J

    const/4 p1, 0x0

    sub-long v7, v3, v5

    const-wide/32 v3, 0x493e0

    cmp-long p1, v7, v3

    if-ltz p1, :cond_0

    sput v2, Lchat/ola/vn/r/a/e;->b:I

    sput-object v0, Lchat/ola/vn/r/a/e;->a:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sput-wide v3, Lchat/ola/vn/r/a/e;->c:J

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;S)V

    :cond_0
    return-object v0

    :cond_1
    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->x()Z

    move-result v1

    if-nez v1, :cond_2

    return-object v0

    :cond_2
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "av"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "md"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "lk"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "#ola"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "#apk"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "#hai"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "me"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "rs"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_8

    :cond_3
    new-instance p1, Lchat/ola/vn/entity/g;

    invoke-direct {p1}, Lchat/ola/vn/entity/g;-><init>()V

    const/16 v1, 0x9

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/g;->d(S)V

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->A()I

    move-result v1

    const/4 v3, 0x1

    const/16 v4, 0x64

    if-le v1, v4, :cond_7

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->A()I

    move-result v1

    sget v5, Lchat/ola/vn/r/a/e;->b:I

    sub-int/2addr v1, v5

    if-le v1, v4, :cond_4

    const/16 v1, 0x64

    :cond_4
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v1, :cond_5

    sget-object v6, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget v7, Lchat/ola/vn/r/a/e;->b:I

    invoke-virtual {v6, v7}, Lchat/ola/vn/message/g;->f(I)Lchat/ola/vn/message/f;

    move-result-object v6

    invoke-interface {v4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget v6, Lchat/ola/vn/r/a/e;->b:I

    add-int/2addr v6, v3

    sput v6, Lchat/ola/vn/r/a/e;->b:I

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_5
    sget v1, Lchat/ola/vn/r/a/e;->b:I

    sget-object v5, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v5}, Lchat/ola/vn/message/g;->A()I

    move-result v5

    if-lt v1, v5, :cond_6

    sput v2, Lchat/ola/vn/r/a/e;->b:I

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;S)V

    :cond_6
    iput-object v4, p1, Lchat/ola/vn/entity/g;->d:Ljava/util/List;

    goto :goto_1

    :cond_7
    new-instance v1, Ljava/util/ArrayList;

    sget-object v4, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v4}, Lchat/ola/vn/message/g;->y()Ljava/util/List;

    move-result-object v4

    invoke-direct {v1, v4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v1, p1, Lchat/ola/vn/entity/g;->d:Ljava/util/List;

    sput v2, Lchat/ola/vn/r/a/e;->b:I

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;S)V

    :goto_1
    sput-boolean v3, Lchat/ola/vn/entry/b/aa;->l:Z

    const-wide/16 v1, 0x0

    invoke-virtual {p1, v1, v2}, Lchat/ola/vn/entity/g;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_8
    return-object v0
.end method

.method private b(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 5

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/16 v1, 0x48

    invoke-virtual {p1, v1, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    const-wide/16 v2, 0x0

    invoke-virtual {p1, v1, v2, v3}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v1

    const/16 v3, 0x6d

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x7c

    invoke-virtual {p1, v4, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {p1, v4, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result p1

    const-string p3, "refresh"

    invoke-static {v3, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_0

    invoke-interface {p2, v1, v2, p1, v0}, Lchat/ola/vn/p/g;->a(JIS)V

    return-void

    :cond_0
    if-lez p1, :cond_1

    invoke-interface {p2, v1, v2, p1, v0}, Lchat/ola/vn/p/g;->b(JIS)V

    :cond_1
    return-void
.end method

.method private c(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 75

    move-object/from16 v0, p0

    move-object/from16 v7, p1

    move-object/from16 v8, p2

    const/4 v9, 0x0

    const/16 v1, 0xff

    invoke-virtual {v7, v1, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {v7, v1, v9}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v1

    int-to-short v10, v1

    move-object/from16 v1, p3

    iget-short v1, v1, Lchat/ola/vn/w/ci;->p:S

    if-eq v1, v10, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x7

    invoke-virtual {v7, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    iget-object v2, v0, Lchat/ola/vn/w/ee;->e:Ljava/lang/String;

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, v0, Lchat/ola/vn/w/ee;->e:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    :cond_1
    return-void

    :cond_2
    const/16 v11, 0x43

    if-eqz v1, :cond_5

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v7, v11}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    if-gtz v2, :cond_5

    :try_start_0
    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    if-eqz v2, :cond_3

    array-length v3, v2

    if-nez v3, :cond_4

    :cond_3
    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    :cond_4
    invoke-virtual {v7, v11, v2}, Lchat/ola/vn/w/s;->a(S[B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    move-object v12, v1

    const/16 v1, 0x42

    invoke-virtual {v7, v1}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v1

    if-eqz v1, :cond_6

    aget-byte v1, v1, v9

    int-to-short v1, v1

    move v13, v1

    goto :goto_0

    :cond_6
    const/4 v13, 0x0

    :goto_0
    const/4 v14, 0x3

    const/4 v15, 0x0

    if-ne v13, v14, :cond_7

    invoke-interface {v8, v12, v13, v15, v10}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLjava/util/List;S)V

    return-void

    :cond_7
    const/16 v5, 0x8

    invoke-virtual {v7, v5}, Lchat/ola/vn/w/s;->c(S)I

    move-result v1

    if-lez v1, :cond_3f

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v1, -0x1

    invoke-virtual {v7, v11, v1}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v1

    invoke-static {v12}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_9

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v12, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    goto :goto_1

    :cond_8
    move v2, v1

    move-object v3, v15

    const/4 v1, 0x0

    const/16 v16, 0x0

    goto :goto_2

    :cond_9
    :goto_1
    move v2, v1

    move-object v3, v15

    const/4 v1, 0x0

    const/16 v16, 0x1

    :goto_2
    if-nez v1, :cond_36

    invoke-virtual {v7, v11, v2}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    if-gez v5, :cond_a

    const/16 v18, 0x1

    goto :goto_3

    :cond_a
    move/from16 v18, v1

    :goto_3
    invoke-virtual {v7, v2}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    const/16 v4, 0x6d

    invoke-virtual {v7, v4, v2, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v4

    const/16 v11, 0x16

    invoke-virtual {v7, v11, v2, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v11

    const/16 v14, 0x2d

    invoke-virtual {v7, v14, v2, v5, v9}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v14

    int-to-short v14, v14

    const/16 v15, 0x48

    invoke-virtual {v7, v15, v2}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v2

    move-object/from16 v20, v3

    move v3, v2

    const/4 v2, 0x0

    :goto_4
    if-nez v2, :cond_35

    invoke-virtual {v7, v15, v3, v5}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v21

    if-gez v21, :cond_b

    move v2, v5

    move/from16 v24, v2

    move-object/from16 v23, v6

    move/from16 v22, v10

    const-wide/16 v9, 0x0

    const/16 v21, 0x1

    goto :goto_5

    :cond_b
    move/from16 v24, v5

    move-object/from16 v23, v6

    move/from16 v22, v10

    const-wide/16 v9, 0x0

    move/from16 v74, v21

    move/from16 v21, v2

    move/from16 v2, v74

    :goto_5
    invoke-virtual {v7, v3, v9, v10}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v5

    const/16 v9, 0x88

    const-wide/16 v25, 0x0

    move-object v10, v1

    move-object v1, v7

    move/from16 v27, v2

    move v2, v9

    move v9, v3

    move-object v15, v4

    move/from16 v4, v27

    move-object/from16 v28, v12

    move/from16 v29, v13

    move-object/from16 v8, v23

    move/from16 v17, v24

    const/16 v0, 0x8

    move-wide v12, v5

    move-wide/from16 v5, v25

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v5

    const/16 v1, 0xdd

    const/4 v2, 0x0

    invoke-virtual {v7, v1, v9, v4, v2}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v1

    int-to-short v3, v1

    const/16 v1, 0xdc

    invoke-virtual {v7, v1, v9, v4, v2}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v1

    int-to-short v1, v1

    const/16 v0, 0x7d

    invoke-virtual {v7, v0, v9, v4, v2}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v0

    move/from16 v30, v1

    const/16 v1, 0x7c

    invoke-virtual {v7, v1, v9, v4, v2}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v19

    const/16 v1, 0x7e

    invoke-virtual {v7, v1, v9, v4, v2}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v1

    move/from16 v31, v1

    const/16 v1, 0x5a

    invoke-virtual {v7, v1, v9, v4, v2}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v1

    int-to-short v2, v1

    const/16 v23, 0x9

    const-wide/16 v24, 0x0

    move/from16 v32, v30

    move/from16 v33, v31

    move-object v1, v7

    move/from16 v34, v2

    move/from16 v2, v23

    move/from16 v35, v3

    move v3, v9

    move/from16 v36, v4

    move-object/from16 v38, v10

    move-object/from16 v37, v11

    move-wide v10, v5

    move-wide/from16 v5, v24

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v5

    const/16 v3, 0x8

    invoke-virtual {v7, v3, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v2

    const/16 v1, 0x18

    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    const/16 v3, 0xc

    move-object/from16 v39, v1

    const/4 v1, 0x0

    invoke-virtual {v7, v3, v9, v4, v1}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v3

    int-to-short v3, v3

    invoke-static {v3}, Lchat/ola/vn/entity/g;->a(S)Z

    move-result v1

    if-nez v1, :cond_c

    move v3, v4

    move-object v6, v8

    move-object v4, v15

    move/from16 v5, v17

    move/from16 v2, v21

    move/from16 v10, v22

    move-object/from16 v12, v28

    move/from16 v13, v29

    move-object/from16 v11, v37

    move-object/from16 v1, v38

    :goto_6
    move-object/from16 v0, p0

    move-object/from16 v8, p2

    const/4 v9, 0x0

    const/16 v15, 0x48

    goto/16 :goto_4

    :cond_c
    const/16 v1, 0x26

    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v40, v1

    const/16 v1, 0x1d

    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_d

    move-object/from16 v41, v2

    const-string v2, ";"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    goto :goto_7

    :cond_d
    move-object/from16 v41, v2

    const/4 v2, 0x0

    :goto_7
    const/16 v23, 0x82

    const-wide/16 v24, 0x0

    move-object/from16 v44, v1

    move-object/from16 v42, v39

    move-object/from16 v43, v40

    move-object v1, v7

    move-object/from16 v46, v2

    move-object/from16 v45, v41

    move/from16 v2, v23

    move/from16 v47, v3

    const/16 v23, 0x8

    move v3, v9

    move/from16 v48, v4

    move-wide/from16 v49, v5

    move-wide/from16 v5, v24

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v1

    move/from16 v3, v34

    const/4 v4, 0x1

    if-ne v3, v4, :cond_e

    add-int/lit8 v19, v19, 0x1

    :cond_e
    move/from16 v5, v19

    new-instance v6, Lchat/ola/vn/entity/g;

    invoke-direct {v6}, Lchat/ola/vn/entity/g;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/g;->c(S)V

    const/4 v4, 0x6

    move-object/from16 v51, v8

    move/from16 v8, v47

    if-eq v8, v4, :cond_23

    packed-switch v8, :pswitch_data_0

    move/from16 v63, v0

    move-wide/from16 v52, v1

    move/from16 v61, v8

    move-wide/from16 v64, v10

    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    move-object/from16 v1, v42

    move/from16 v4, v48

    move-wide/from16 v14, v67

    goto/16 :goto_19

    :pswitch_0
    move-wide/from16 v52, v1

    move/from16 v4, v48

    const/16 v1, 0x70

    :try_start_1
    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1b

    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "title"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_9

    if-eqz v1, :cond_1a

    :try_start_2
    const-string v1, "title"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v54, v1

    const-string v1, "slogan"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_7

    if-eqz v1, :cond_f

    :try_start_3
    const-string v1, "slogan"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_9

    move-object/from16 v55, v1

    goto :goto_8

    :cond_f
    const/16 v55, 0x0

    :goto_8
    :try_start_4
    const-string v1, "description"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_7

    if-eqz v1, :cond_10

    :try_start_5
    const-string v1, "description"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_9

    move-object/from16 v56, v1

    goto :goto_9

    :cond_10
    const/16 v56, 0x0

    :goto_9
    :try_start_6
    const-string v1, "adId"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_7

    if-eqz v1, :cond_11

    :try_start_7
    const-string v1, "adId"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_9

    move-object/from16 v57, v1

    goto :goto_a

    :cond_11
    const/16 v57, 0x0

    :goto_a
    :try_start_8
    const-string v1, "downloadUrl"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_7

    if-eqz v1, :cond_12

    :try_start_9
    const-string v1, "downloadUrl"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_9

    move-object/from16 v58, v1

    goto :goto_b

    :cond_12
    const/16 v58, 0x0

    :goto_b
    :try_start_a
    const-string v1, "appIconUrl"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_7

    if-eqz v1, :cond_13

    :try_start_b
    const-string v1, "appIconUrl"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_9

    move-object/from16 v59, v1

    goto :goto_c

    :cond_13
    const/16 v59, 0x0

    :goto_c
    :try_start_c
    const-string v1, "youtubeCode"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_7

    if-eqz v1, :cond_14

    :try_start_d
    const-string v1, "youtubeCode"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_9

    move-object/from16 v60, v1

    goto :goto_d

    :cond_14
    const/16 v60, 0x0

    :goto_d
    :try_start_e
    const-string v1, "bannerMediaCode"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_e
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_7

    if-eqz v1, :cond_17

    :try_start_f
    const-string v1, "bannerMediaCode"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_f
    .catch Ljava/lang/Throwable; {:try_start_f .. :try_end_f} :catch_4

    move/from16 v61, v8

    :try_start_10
    const-string v8, ";"

    invoke-static {v1, v8}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v8
    :try_end_10
    .catch Ljava/lang/Throwable; {:try_start_10 .. :try_end_10} :catch_2

    if-eqz v8, :cond_15

    move-object/from16 v62, v1

    :try_start_11
    array-length v1, v8
    :try_end_11
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_1

    move/from16 v63, v0

    const/4 v0, 0x1

    if-le v1, v0, :cond_16

    :try_start_12
    new-instance v0, Ljava/util/Random;
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_3

    move-wide/from16 v64, v10

    :try_start_13
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v10

    invoke-direct {v0, v10, v11}, Ljava/util/Random;-><init>(J)V

    array-length v1, v8

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    aget-object v1, v8, v0
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_5

    move-object/from16 v62, v1

    goto :goto_f

    :catch_1
    move/from16 v63, v0

    goto :goto_e

    :catch_2
    :cond_15
    move/from16 v63, v0

    move-object/from16 v62, v1

    :catch_3
    :cond_16
    :goto_e
    move-wide/from16 v64, v10

    goto :goto_f

    :catch_4
    :cond_17
    move/from16 v63, v0

    move/from16 v61, v8

    move-wide/from16 v64, v10

    const/16 v62, 0x0

    :catch_5
    :goto_f
    :try_start_14
    const-string v0, "downloadDetails"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_18

    const-string v0, "downloadDetails"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_10

    :cond_18
    const/4 v0, 0x0

    :goto_10
    const-string v1, "rating"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_14
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_8

    if-eqz v1, :cond_19

    :try_start_15
    const-string v1, "rating"

    invoke-virtual {v2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Float;->valueOf(Ljava/lang/String;)Ljava/lang/Float;

    move-result-object v1
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_15 .. :try_end_15} :catch_6

    move/from16 v70, v4

    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    move-object/from16 v2, v56

    move-object/from16 v8, v57

    move-object/from16 v10, v58

    move-object/from16 v11, v59

    move-object/from16 v12, v60

    move-object/from16 v14, v62

    move-object v13, v0

    move-object v15, v1

    move-object/from16 v0, v54

    move-object/from16 v1, v55

    goto :goto_11

    :catch_6
    :cond_19
    move/from16 v70, v4

    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    move-object/from16 v1, v55

    move-object/from16 v2, v56

    move-object/from16 v8, v57

    move-object/from16 v10, v58

    move-object/from16 v11, v59

    move-object/from16 v12, v60

    move-object/from16 v14, v62

    const/4 v15, 0x0

    move-object v13, v0

    move-object/from16 v0, v54

    goto :goto_11

    :catch_7
    move/from16 v63, v0

    move/from16 v61, v8

    move-wide/from16 v64, v10

    :catch_8
    move/from16 v70, v4

    goto :goto_12

    :cond_1a
    move/from16 v63, v0

    move/from16 v61, v8

    move-wide/from16 v64, v10

    move/from16 v70, v4

    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v8, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    :goto_11
    :try_start_16
    new-instance v4, Lchat/ola/vn/entity/k;

    invoke-direct {v4}, Lchat/ola/vn/entity/k;-><init>()V

    iput-object v0, v4, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    iput-object v1, v4, Lchat/ola/vn/entity/k;->e:Ljava/lang/String;

    iput-object v2, v4, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    iput-object v8, v4, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    iput-object v10, v4, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    iput-object v11, v4, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    iput-object v14, v4, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    iput-object v12, v4, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    iput-object v13, v4, Lchat/ola/vn/entity/k;->l:Ljava/lang/String;

    iput-object v15, v4, Lchat/ola/vn/entity/k;->n:Ljava/lang/Float;

    iput-object v4, v6, Lchat/ola/vn/entity/g;->a:Lchat/ola/vn/entity/k;

    invoke-virtual {v6, v3}, Lchat/ola/vn/entity/g;->c(S)V

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/g;->a(I)V

    move/from16 v0, v33

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->c(I)V

    move-object/from16 v2, v46

    invoke-virtual {v6, v2}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_a

    goto :goto_13

    :cond_1b
    move/from16 v63, v0

    move/from16 v70, v4

    move/from16 v61, v8

    move-wide/from16 v64, v10

    goto :goto_12

    :catch_9
    move/from16 v63, v0

    move/from16 v70, v4

    move/from16 v61, v8

    move-wide/from16 v64, v10

    :goto_12
    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    :catch_a
    :goto_13
    move-object/from16 v1, v42

    move/from16 v4, v70

    goto/16 :goto_18

    :pswitch_1
    move/from16 v63, v0

    move-wide/from16 v52, v1

    move/from16 v61, v8

    move-wide/from16 v64, v10

    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    move/from16 v0, v33

    move-object/from16 v2, v46

    move/from16 v70, v48

    const/16 v1, 0x6f

    move/from16 v4, v70

    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_1f

    :try_start_17
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "commands"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    if-eqz v1, :cond_1f

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v8

    if-lez v8, :cond_1f

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v8

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10, v8}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v11, 0x0

    :goto_14
    if-ge v11, v8, :cond_1e

    invoke-virtual {v1, v11}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v12

    const-string v13, "label"

    invoke-virtual {v12, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Lchat/ola/vn/entity/d;

    invoke-direct {v14}, Lchat/ola/vn/entity/d;-><init>()V

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lchat/ola/vn/entity/d;->a(Z)V

    if-ne v3, v15, :cond_1c

    const/4 v15, 0x1

    goto :goto_15

    :cond_1c
    const/4 v15, 0x0

    :goto_15
    invoke-virtual {v14, v15}, Lchat/ola/vn/entity/d;->b(Z)V

    invoke-virtual {v14, v13}, Lchat/ola/vn/entity/d;->f(Ljava/lang/String;)V

    const-string v13, "action"

    invoke-virtual {v12, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v15

    if-nez v15, :cond_1d

    invoke-virtual {v14, v13}, Lchat/ola/vn/entity/d;->a(Ljava/lang/String;)V
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_e

    :try_start_18
    const-string v13, "price"

    invoke-virtual {v12, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v14, v13}, Lchat/ola/vn/entity/d;->h(Ljava/lang/String;)V
    :try_end_18
    .catch Ljava/lang/Throwable; {:try_start_18 .. :try_end_18} :catch_b

    :catch_b
    :try_start_19
    const-string v13, "para1"

    invoke-virtual {v12, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v14, v13}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_c

    :catch_c
    :try_start_1a
    const-string v13, "para2"

    invoke-virtual {v12, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v14, v12}, Lchat/ola/vn/entity/d;->e(Ljava/lang/String;)V
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_d

    :catch_d
    :cond_1d
    :try_start_1b
    invoke-interface {v10, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v11, v11, 0x1

    goto :goto_14

    :cond_1e
    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->a(Ljava/util/List;)V

    invoke-virtual {v6, v3}, Lchat/ola/vn/entity/g;->c(S)V

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/g;->a(I)V

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->c(I)V

    invoke-virtual {v6, v2}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_e

    :catch_e
    :cond_1f
    const/16 v1, 0x70

    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_22

    :try_start_1c
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "label"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v10, "id"

    invoke-virtual {v8, v10}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->h(Ljava/lang/String;)V

    new-instance v10, Lchat/ola/vn/entity/d;

    invoke-direct {v10}, Lchat/ola/vn/entity/d;-><init>()V

    const/4 v11, 0x1

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/d;->a(Z)V

    if-ne v3, v11, :cond_20

    const/4 v11, 0x1

    goto :goto_16

    :cond_20
    const/4 v11, 0x0

    :goto_16
    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/d;->b(Z)V

    invoke-virtual {v10, v1}, Lchat/ola/vn/entity/d;->f(Ljava/lang/String;)V
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_12

    :try_start_1d
    const-string v1, "action"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_21

    invoke-virtual {v10, v1}, Lchat/ola/vn/entity/d;->a(Ljava/lang/String;)V
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_11

    :try_start_1e
    const-string v1, "price"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v10, v1}, Lchat/ola/vn/entity/d;->h(Ljava/lang/String;)V
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_f

    :catch_f
    :try_start_1f
    const-string v1, "para1"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v10, v1}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_10

    :catch_10
    :try_start_20
    const-string v1, "para2"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v10, v1}, Lchat/ola/vn/entity/d;->e(Ljava/lang/String;)V
    :try_end_20
    .catch Ljava/lang/Throwable; {:try_start_20 .. :try_end_20} :catch_11

    :catch_11
    :cond_21
    :try_start_21
    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/d;)V

    invoke-virtual {v6, v3}, Lchat/ola/vn/entity/g;->c(S)V

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/g;->a(I)V

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->c(I)V

    invoke-virtual {v6, v2}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V
    :try_end_21
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_12

    :catch_12
    :cond_22
    move-object/from16 v1, v42

    goto/16 :goto_18

    :cond_23
    move/from16 v63, v0

    move-wide/from16 v52, v1

    move/from16 v61, v8

    move-wide/from16 v64, v10

    move-wide/from16 v67, v12

    move/from16 v66, v14

    move-object/from16 v69, v15

    move/from16 v0, v33

    move-object/from16 v2, v46

    move/from16 v4, v48

    const/16 v1, 0x70

    invoke-virtual {v7, v1, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_22

    :try_start_22
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "label"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_24

    const-string v1, "label"

    invoke-virtual {v8, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15
    :try_end_22
    .catch Ljava/lang/Throwable; {:try_start_22 .. :try_end_22} :catch_12

    move-object/from16 v1, v42

    goto :goto_17

    :cond_24
    move-object/from16 v1, v42

    const/4 v15, 0x0

    :goto_17
    :try_start_23
    invoke-virtual {v6, v1}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    move-object/from16 v10, v44

    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->j(Ljava/lang/String;)V

    const-wide/16 v10, 0x0

    invoke-virtual {v6, v10, v11}, Lchat/ola/vn/entity/g;->a(J)V

    new-instance v10, Lchat/ola/vn/entity/d;

    invoke-direct {v10}, Lchat/ola/vn/entity/d;-><init>()V

    const/4 v11, 0x1

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/d;->a(Z)V

    invoke-virtual {v10, v15}, Lchat/ola/vn/entity/d;->f(Ljava/lang/String;)V

    const-string v11, "action"

    invoke-virtual {v8, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v12

    if-nez v12, :cond_25

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/d;->a(Ljava/lang/String;)V
    :try_end_23
    .catch Ljava/lang/Throwable; {:try_start_23 .. :try_end_23} :catch_16

    :try_start_24
    const-string v11, "price"

    invoke-virtual {v8, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/d;->h(Ljava/lang/String;)V
    :try_end_24
    .catch Ljava/lang/Throwable; {:try_start_24 .. :try_end_24} :catch_13

    :catch_13
    :try_start_25
    const-string v11, "para1"

    invoke-virtual {v8, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V
    :try_end_25
    .catch Ljava/lang/Throwable; {:try_start_25 .. :try_end_25} :catch_14

    :catch_14
    :try_start_26
    const-string v11, "para2"

    invoke-virtual {v8, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v10, v8}, Lchat/ola/vn/entity/d;->e(Ljava/lang/String;)V
    :try_end_26
    .catch Ljava/lang/Throwable; {:try_start_26 .. :try_end_26} :catch_15

    :catch_15
    :cond_25
    :try_start_27
    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/d;)V

    invoke-virtual {v6, v3}, Lchat/ola/vn/entity/g;->c(S)V

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/g;->a(I)V

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->c(I)V

    invoke-virtual {v6, v2}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V
    :try_end_27
    .catch Ljava/lang/Throwable; {:try_start_27 .. :try_end_27} :catch_16

    :catch_16
    :goto_18
    const-wide/16 v14, 0x0

    :goto_19
    const/16 v0, 0x71

    invoke-virtual {v7, v0, v9, v4}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_28

    :try_start_28
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_28
    .catch Ljava/lang/Throwable; {:try_start_28 .. :try_end_28} :catch_19

    :try_start_29
    const-string v0, "repliedMeId"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_26

    const-string v0, "repliedMeId"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "null"

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_26

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8

    invoke-virtual {v6, v8, v9}, Lchat/ola/vn/entity/g;->d(J)V
    :try_end_29
    .catch Ljava/lang/Throwable; {:try_start_29 .. :try_end_29} :catch_17

    :catch_17
    :cond_26
    :try_start_2a
    const-string v0, "targetMeId"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_27

    const-string v0, "targetMeId"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "null"

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_27

    new-instance v3, Lchat/ola/vn/entity/h;

    invoke-direct {v3}, Lchat/ola/vn/entity/h;-><init>()V

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8

    invoke-virtual {v3, v8, v9}, Lchat/ola/vn/entity/h;->a(J)V

    invoke-virtual {v6, v3}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/h;)V
    :try_end_2a
    .catch Ljava/lang/Throwable; {:try_start_2a .. :try_end_2a} :catch_18

    :catch_18
    :cond_27
    :try_start_2b
    const-string v0, "checkInId"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_28

    const-string v0, "checkInId"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "null"

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_28

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->k(Ljava/lang/String;)V
    :try_end_2b
    .catch Ljava/lang/Throwable; {:try_start_2b .. :try_end_2b} :catch_19

    :catch_19
    :cond_28
    move-object/from16 v0, v69

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->d(Ljava/lang/String;)V

    move-wide/from16 v2, v67

    invoke-virtual {v6, v2, v3}, Lchat/ola/vn/entity/g;->b(J)V

    move-wide/from16 v2, v64

    invoke-virtual {v6, v2, v3}, Lchat/ola/vn/entity/g;->e(J)V

    move-object/from16 v5, v38

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/g;->a(Ljava/lang/String;)V

    move/from16 v8, v66

    invoke-virtual {v6, v8}, Lchat/ola/vn/entity/g;->e(S)V

    move-object/from16 v9, v37

    invoke-virtual {v6, v9}, Lchat/ola/vn/entity/g;->i(Ljava/lang/String;)V

    move/from16 v10, v63

    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->b(I)V

    move/from16 v10, v35

    invoke-virtual {v6, v10}, Lchat/ola/vn/entity/g;->b(S)V

    move/from16 v10, v32

    if-lez v10, :cond_29

    new-instance v11, Lchat/ola/vn/entity/w;

    invoke-direct {v11}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v11, v10}, Lchat/ola/vn/entity/w;->a(I)V

    goto :goto_1a

    :cond_29
    const/4 v11, 0x0

    :goto_1a
    if-nez v11, :cond_2a

    invoke-static {v1}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_2a

    new-instance v11, Lchat/ola/vn/entity/w;

    invoke-direct {v11}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {v11, v1}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_2a
    invoke-virtual {v6, v11}, Lchat/ola/vn/entity/g;->a(Lchat/ola/vn/entity/w;)V

    move-wide/from16 v10, v49

    invoke-virtual {v6, v10, v11}, Lchat/ola/vn/entity/g;->a(J)V

    move-object/from16 v12, v45

    invoke-virtual {v6, v12}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    invoke-virtual {v6, v1}, Lchat/ola/vn/entity/g;->c(Ljava/lang/String;)V

    move/from16 v13, v61

    invoke-virtual {v6, v13}, Lchat/ola/vn/entity/g;->d(S)V

    if-nez v13, :cond_2f

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2f

    :try_start_2c
    invoke-static {v12}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v1

    if-eqz v1, :cond_2c

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_2c

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19
    :try_end_2c
    .catch Ljava/lang/Throwable; {:try_start_2c .. :try_end_2c} :catch_1b

    move-object/from16 v71, v0

    :try_start_2d
    move-object/from16 v0, v19

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v0

    move-object/from16 v72, v1

    const/16 v1, 0x50

    if-ne v0, v1, :cond_2b

    const/4 v0, 0x0

    goto :goto_1c

    :cond_2b
    move-object/from16 v0, v71

    move-object/from16 v1, v72

    goto :goto_1b

    :cond_2c
    move-object/from16 v71, v0

    const/4 v0, 0x1

    :goto_1c
    if-eqz v0, :cond_2e

    invoke-static {v12}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2d

    const/4 v1, 0x2

    invoke-virtual {v6, v1}, Lchat/ola/vn/entity/g;->d(S)V

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->l(Ljava/lang/String;)V

    goto :goto_1d

    :cond_2d
    invoke-static {v12}, Lchat/ola/vn/util/i;->f(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2e

    invoke-static {v12}, Lchat/ola/vn/util/i;->g(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1
    :try_end_2d
    .catch Ljava/lang/Throwable; {:try_start_2d .. :try_end_2d} :catch_1a

    move/from16 v73, v4

    :try_start_2e
    invoke-static {v12}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_30

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_30

    const/4 v1, 0x2

    invoke-virtual {v6, v1}, Lchat/ola/vn/entity/g;->d(S)V

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->m(Ljava/lang/String;)V

    goto :goto_1e

    :catch_1a
    :cond_2e
    :goto_1d
    move/from16 v73, v4

    goto :goto_1e

    :catch_1b
    move-object/from16 v71, v0

    goto :goto_1d

    :cond_2f
    move-object/from16 v71, v0

    move/from16 v73, v4

    const/16 v0, 0xb

    if-ne v13, v0, :cond_30

    invoke-static {v12}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4
    :try_end_2e
    .catch Ljava/lang/Throwable; {:try_start_2e .. :try_end_2e} :catch_1d

    if-nez v4, :cond_30

    :try_start_2f
    invoke-virtual {v6}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v14

    invoke-virtual {v6, v14, v15}, Lchat/ola/vn/entity/g;->b(J)V

    const/4 v4, 0x0

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/g;->b(I)V

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/g;->a(I)V

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/g;->c(I)V

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/g;->c(S)V

    const v4, 0x7f0f053b

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->d(S)V

    invoke-virtual {v6, v1}, Lchat/ola/vn/entity/g;->l(Ljava/lang/String;)V
    :try_end_2f
    .catch Ljava/lang/Throwable; {:try_start_2f .. :try_end_2f} :catch_1c

    :catch_1c
    const-wide/16 v14, 0x0

    :catch_1d
    :cond_30
    :goto_1e
    const-wide/16 v0, 0x0

    cmp-long v4, v14, v0

    if-eqz v4, :cond_32

    if-nez v20, :cond_31

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_1f

    :cond_31
    move-object/from16 v0, v20

    :goto_1f
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v20, v0

    :cond_32
    move-object/from16 v0, v43

    invoke-virtual {v6, v0}, Lchat/ola/vn/entity/g;->f(Ljava/lang/String;)V

    move-wide/from16 v0, v52

    invoke-virtual {v6, v0, v1}, Lchat/ola/vn/entity/g;->c(J)V

    if-nez v13, :cond_34

    const-wide/32 v0, 0x1b77400

    cmp-long v4, v10, v0

    if-gtz v4, :cond_34

    if-eqz v16, :cond_34

    const-wide/16 v0, 0x0

    cmp-long v4, v2, v0

    if-nez v4, :cond_34

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_33

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_34

    :cond_33
    invoke-static {v12}, Lchat/ola/vn/util/m;->n(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v6, Lchat/ola/vn/entity/g;->c:Z

    :cond_34
    move-object/from16 v0, v51

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object v6, v0

    move-object v1, v5

    move v14, v8

    move-object v11, v9

    move/from16 v5, v17

    move/from16 v2, v21

    move/from16 v10, v22

    move-object/from16 v12, v28

    move/from16 v13, v29

    move-object/from16 v4, v71

    move/from16 v3, v73

    goto/16 :goto_6

    :cond_35
    move/from16 v17, v5

    const/16 v23, 0x8

    move/from16 v2, v17

    move/from16 v1, v18

    move-object/from16 v3, v20

    move-object/from16 v0, p0

    const/16 v5, 0x8

    const/16 v11, 0x43

    const/4 v14, 0x3

    goto/16 :goto_2

    :cond_36
    move-object v1, v0

    move-object v0, v6

    move/from16 v22, v10

    move-object/from16 v28, v12

    move/from16 v29, v13

    iget-object v2, v1, Lchat/ola/vn/w/ee;->g:Lchat/ola/vn/e/c;

    if-nez v2, :cond_37

    new-instance v2, Lchat/ola/vn/e/c;

    const/4 v4, 0x0

    invoke-direct {v2, v4}, Lchat/ola/vn/e/c;-><init>(Z)V

    iput-object v2, v1, Lchat/ola/vn/w/ee;->g:Lchat/ola/vn/e/c;

    :cond_37
    iget-object v2, v1, Lchat/ola/vn/w/ee;->g:Lchat/ola/vn/e/c;

    invoke-static {v0, v2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-wide v4, v1, Lchat/ola/vn/w/ee;->f:J

    const-wide/16 v6, 0x0

    cmp-long v2, v4, v6

    if-nez v2, :cond_38

    invoke-static {}, Lchat/ola/vn/r/a/e;->z()V

    :cond_38
    invoke-static {v0}, Lchat/ola/vn/r/a/e;->e(Ljava/util/List;)V

    :try_start_30
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;)V
    :try_end_30
    .catch Ljava/lang/Throwable; {:try_start_30 .. :try_end_30} :catch_1e

    :catch_1e
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x4

    if-le v2, v3, :cond_39

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x2

    rem-long/2addr v2, v4

    const-wide/16 v4, 0x0

    cmp-long v6, v2, v4

    move-object/from16 v2, v28

    invoke-direct {v1, v2}, Lchat/ola/vn/w/ee;->a(Ljava/lang/String;)Lchat/ola/vn/entity/g;

    move-result-object v3

    if-eqz v3, :cond_3a

    new-instance v4, Ljava/util/Random;

    invoke-direct {v4}, Ljava/util/Random;-><init>()V

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    const/4 v5, 0x1

    add-int/2addr v4, v5

    invoke-interface {v0, v4, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_20

    :cond_39
    move-object/from16 v2, v28

    :cond_3a
    :goto_20
    iget-wide v3, v1, Lchat/ola/vn/w/ee;->f:J

    const-wide/16 v5, 0x0

    cmp-long v7, v3, v5

    if-nez v7, :cond_3b

    invoke-static {v2}, Lchat/ola/vn/r/a/e;->d(Ljava/lang/String;)Lchat/ola/vn/entity/g;

    move-result-object v3

    if-eqz v3, :cond_3b

    const/4 v4, 0x0

    invoke-interface {v0, v4, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_21

    :cond_3b
    const/4 v4, 0x0

    :goto_21
    invoke-direct {v1, v2}, Lchat/ola/vn/w/ee;->b(Ljava/lang/String;)Lchat/ola/vn/entity/g;

    move-result-object v3

    if-eqz v3, :cond_3e

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    const/4 v6, 0x5

    if-le v5, v6, :cond_3c

    const/4 v5, 0x5

    :cond_3c
    const/4 v6, 0x1

    if-le v5, v6, :cond_3d

    new-instance v4, Ljava/util/Random;

    invoke-direct {v4}, Ljava/util/Random;-><init>()V

    sub-int/2addr v5, v6

    invoke-virtual {v4, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    const/4 v5, 0x2

    add-int/lit8 v9, v4, 0x2

    move v4, v9

    :cond_3d
    invoke-interface {v0, v4, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_3e
    move-object v4, v0

    move/from16 v3, v22

    move/from16 v9, v29

    move-object/from16 v0, p2

    goto :goto_22

    :cond_3f
    move-object v1, v0

    move-object v2, v12

    move-object v0, v8

    move v3, v10

    move v9, v13

    const/4 v4, 0x0

    :goto_22
    invoke-interface {v0, v2, v9, v4, v3}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLjava/util/List;S)V

    return-void

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 5

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x7

    invoke-virtual {p3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-wide v0, p1, Lchat/ola/vn/w/bk;->S:J

    iput-wide v0, p0, Lchat/ola/vn/w/ee;->f:J

    const-wide/16 v0, 0x0

    iget-wide v2, p0, Lchat/ola/vn/w/ee;->f:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    const/16 v0, 0x48

    iget-wide v1, p0, Lchat/ola/vn/w/ee;->f:J

    invoke-virtual {p2, v0, v1, v2}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_1
    iget-byte v0, p1, Lchat/ola/vn/w/bk;->at:B

    if-eqz v0, :cond_2

    const/16 p3, 0x73

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->at:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    goto :goto_0

    :cond_2
    iput-object p3, p0, Lchat/ola/vn/w/ee;->e:Ljava/lang/String;

    :goto_0
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_3

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0x73

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/w/ee;->b(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V

    return-void

    :pswitch_1
    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/w/ee;->c(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
