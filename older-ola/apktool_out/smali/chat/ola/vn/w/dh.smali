.class Lchat/ola/vn/w/dh;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/c;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    const/16 v0, 0x8a

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->av:B

    const/4 v0, 0x2

    if-ne p3, v0, :cond_0

    const/4 p3, 0x1

    :goto_0
    iput-byte p3, p1, Lchat/ola/vn/w/bk;->av:B

    goto :goto_1

    :cond_0
    const/4 p3, 0x0

    goto :goto_0

    :goto_1
    const/16 p3, 0x8b

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->av:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    const/16 p3, 0x89

    iget-short v0, p1, Lchat/ola/vn/w/bk;->ac:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/16 p3, 0x6e

    iget-object p1, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 21

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const/16 v2, 0x8a

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/16 v4, 0x8b

    invoke-virtual {v0, v4, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {v0, v4, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    const/4 v5, 0x2

    const/4 v6, 0x1

    if-nez v4, :cond_0

    const/4 v4, 0x0

    goto :goto_0

    :cond_0
    if-ne v4, v6, :cond_a

    const/4 v4, 0x2

    :goto_0
    const/4 v7, 0x7

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v7

    const/16 v8, 0x6e

    invoke-virtual {v0, v8}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    const/16 v9, 0x6f

    invoke-virtual {v0, v9}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v9

    const/16 v10, 0x8

    invoke-virtual {v0, v10}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v10

    const/16 v11, 0xdc

    invoke-virtual {v0, v11, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v11

    invoke-virtual {v0, v11, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v11

    int-to-short v11, v11

    const/16 v12, 0x89

    invoke-virtual {v0, v12, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v12

    invoke-virtual {v0, v12, v3}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v12

    const/16 v13, 0x9

    invoke-virtual {v0, v13, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v13

    const-wide/16 v14, 0x0

    invoke-virtual {v0, v13, v14, v15}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v16

    const/16 v13, 0x82

    invoke-virtual {v0, v13, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v13

    invoke-virtual {v0, v13, v14, v15}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v18

    cmp-long v0, v16, v14

    if-nez v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v16

    :cond_1
    move-wide/from16 v13, v16

    if-nez v10, :cond_2

    const-string v10, ""

    :cond_2
    new-array v0, v6, [Ljava/lang/String;

    aput-object v8, v0, v3

    const/16 v15, 0x2c

    :try_start_0
    invoke-virtual {v8, v15}, Ljava/lang/String;->indexOf(I)I

    move-result v15

    if-lez v15, :cond_3

    const-string v6, ","

    invoke-static {v8, v6}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    :goto_1
    move-object v0, v6

    goto :goto_2

    :cond_3
    new-array v6, v6, [Ljava/lang/String;

    aput-object v8, v6, v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :goto_2
    array-length v6, v0

    if-ge v3, v6, :cond_a

    new-instance v6, Lchat/ola/vn/message/d;

    invoke-direct {v6}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v6, v7}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    sget-object v8, Lchat/ola/vn/w/dh;->b:Ljava/lang/String;

    invoke-static {v10, v8}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    sget-object v8, Lchat/ola/vn/w/dh;->a:Ljava/lang/String;

    move-object v10, v8

    :cond_4
    invoke-virtual {v6, v10}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v6, v11}, Lchat/ola/vn/message/d;->b(S)V

    invoke-virtual {v6, v13, v14}, Lchat/ola/vn/message/d;->a(J)V

    invoke-virtual {v6, v13, v14}, Lchat/ola/vn/message/d;->b(J)V

    aget-object v8, v0, v3

    invoke-virtual {v6, v8}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    invoke-virtual {v6, v12}, Lchat/ola/vn/message/d;->a(B)V

    if-nez v9, :cond_7

    if-nez v4, :cond_6

    invoke-interface {v1, v2, v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Lchat/ola/vn/message/d;)V

    :cond_5
    :goto_3
    move-object/from16 v20, v7

    goto :goto_4

    :cond_6
    if-ne v4, v5, :cond_5

    invoke-interface {v1, v2, v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;Lchat/ola/vn/message/d;)V

    goto :goto_3

    :cond_7
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v15

    move-object/from16 v20, v7

    add-long v7, v15, v18

    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    iput-object v7, v6, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    if-nez v4, :cond_8

    invoke-interface {v1, v2, v9, v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    goto :goto_4

    :cond_8
    if-ne v4, v5, :cond_9

    invoke-interface {v1, v2, v9, v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/message/d;)V

    :cond_9
    :goto_4
    add-int/lit8 v3, v3, 0x1

    move-object/from16 v7, v20

    goto :goto_2

    :cond_a
    return-void
.end method
