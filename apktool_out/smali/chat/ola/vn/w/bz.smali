.class public Lchat/ola/vn/w/bz;
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
    .locals 0

    const/16 p1, 0x72

    const/4 p3, 0x1

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 18

    move-object/from16 v0, p1

    const/16 v1, 0x8a

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/16 v3, 0x8b

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    invoke-static {v3}, Lchat/ola/vn/w/cc;->a(S)S

    move-result v3

    const/16 v4, 0x16

    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x7

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x73

    invoke-virtual {v0, v6}, Lchat/ola/vn/w/s;->d(S)Z

    move-result v6

    const/16 v7, 0x72

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->d(S)Z

    move-result v7

    const/16 v8, 0x9

    invoke-virtual {v0, v8, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v8

    const-wide/16 v9, 0x0

    invoke-virtual {v0, v8, v9, v10}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v8

    const/16 v10, 0x58

    invoke-virtual {v0, v10, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v10

    const/4 v11, -0x1

    invoke-virtual {v0, v10, v11}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v10

    const/16 v12, 0x76

    invoke-virtual {v0, v12, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v12

    invoke-virtual {v0, v12, v2}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v12

    const/16 v13, 0xd

    invoke-virtual {v0, v13}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0x26

    invoke-virtual {v0, v14, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v14

    invoke-virtual {v0, v14, v11}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v11

    const/16 v14, 0x34

    invoke-virtual {v0, v14}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v14

    const/16 v15, 0x2d

    invoke-virtual {v0, v15, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v15

    invoke-virtual {v0, v15, v2}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v15

    move-object/from16 v16, v1

    const/16 v1, 0x7c

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/w/s;->a(II)I

    move-result v1

    move/from16 v17, v3

    const/16 v3, 0x7d

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->a(II)I

    move-result v0

    if-lez v15, :cond_0

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    invoke-virtual {v2, v15}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    new-instance v3, Lchat/ola/vn/message/v;

    invoke-direct {v3}, Lchat/ola/vn/message/v;-><init>()V

    invoke-virtual {v3, v5}, Lchat/ola/vn/message/v;->d(Ljava/lang/String;)V

    iput-object v4, v3, Lchat/ola/vn/message/v;->B:Ljava/lang/String;

    iput-boolean v6, v3, Lchat/ola/vn/message/v;->J:Z

    iput-boolean v7, v3, Lchat/ola/vn/message/v;->K:Z

    iput-wide v8, v3, Lchat/ola/vn/message/v;->C:J

    iput-byte v10, v3, Lchat/ola/vn/message/v;->F:B

    iput-byte v12, v3, Lchat/ola/vn/message/v;->G:B

    iput-byte v11, v3, Lchat/ola/vn/message/v;->H:B

    iput-object v14, v3, Lchat/ola/vn/message/v;->A:Ljava/lang/String;

    iput-object v2, v3, Lchat/ola/vn/message/v;->z:Lchat/ola/vn/entity/ah;

    iput-byte v15, v3, Lchat/ola/vn/message/v;->I:B

    iput v1, v3, Lchat/ola/vn/message/v;->D:I

    iput v0, v3, Lchat/ola/vn/message/v;->E:I

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual {v3, v0, v1}, Lchat/ola/vn/message/v;->a(J)V

    invoke-virtual {v3, v13}, Lchat/ola/vn/message/v;->f(Ljava/lang/String;)V

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    move/from16 v2, v17

    invoke-interface {v0, v1, v2, v3}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SLchat/ola/vn/message/v;)V

    return-void
.end method
