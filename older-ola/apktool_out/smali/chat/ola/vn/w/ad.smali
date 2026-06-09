.class public Lchat/ola/vn/w/ad;
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

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short v0, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/4 p3, 0x2

    iget-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->l:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const/4 p3, 0x6

    iget-object p1, p1, Lchat/ola/vn/w/bk;->l:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 24

    move-object/from16 v6, p1

    move-object/from16 v7, p2

    move-object/from16 v8, p3

    const/4 v9, 0x0

    const/16 v0, 0xff

    invoke-virtual {v6, v0, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {v6, v0, v9}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v10, v0

    const/16 v11, 0x6d

    invoke-virtual {v6, v11}, Lchat/ola/vn/w/s;->c(S)I

    move-result v12

    const/4 v0, 0x6

    invoke-virtual {v6, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v13

    if-lez v12, :cond_1

    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14, v12}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v6, v11, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const/16 v15, 0xcf

    invoke-virtual {v6, v15, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    move v5, v0

    move v3, v1

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v12, :cond_2

    invoke-virtual {v6, v5}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v11, v5}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v1

    invoke-virtual {v6, v3}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v0

    const/16 v11, 0x45

    invoke-virtual {v6, v11, v5, v1, v9}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v11

    int-to-short v11, v11

    const/16 v15, 0x3e

    invoke-virtual {v6, v15, v5, v1, v9}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v15

    int-to-short v15, v15

    const/16 v16, 0x9

    const-wide/16 v17, 0x0

    move-object/from16 v19, v0

    move-object v0, v6

    move/from16 v20, v1

    move/from16 v1, v16

    move-object/from16 v21, v2

    move v2, v5

    move/from16 v22, v3

    move/from16 v3, v20

    move/from16 v16, v4

    move v9, v5

    move-wide/from16 v4, v17

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    const/16 v2, 0xcd

    const/4 v4, 0x0

    invoke-virtual {v6, v2, v9, v3, v4}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v2

    if-gez v2, :cond_0

    const/4 v2, 0x0

    :cond_0
    const/16 v5, 0xce

    invoke-virtual {v6, v5, v9, v3, v4}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v5

    new-instance v4, Lchat/ola/vn/entity/l;

    invoke-direct {v4}, Lchat/ola/vn/entity/l;-><init>()V

    move/from16 v23, v12

    move-object/from16 v12, v21

    iput-object v12, v4, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    move-object/from16 v12, v19

    iput-object v12, v4, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    iput-short v11, v4, Lchat/ola/vn/entity/l;->i:S

    iput-short v15, v4, Lchat/ola/vn/entity/l;->j:S

    iput-wide v0, v4, Lchat/ola/vn/entity/l;->f:J

    iput v2, v4, Lchat/ola/vn/entity/l;->g:I

    iput v5, v4, Lchat/ola/vn/entity/l;->h:I

    const/16 v0, 0x18

    invoke-virtual {v6, v0, v9, v3}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v4, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    move/from16 v1, v22

    const/16 v0, 0xcf

    invoke-virtual {v6, v0, v1}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v1

    invoke-interface {v14, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v16, 0x1

    move v5, v3

    move/from16 v12, v23

    const/4 v9, 0x0

    const/16 v11, 0x6d

    const/16 v15, 0xcf

    move v3, v1

    goto :goto_0

    :cond_1
    const/4 v14, 0x0

    :cond_2
    const/4 v0, 0x2

    invoke-virtual {v6, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v0, v8, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    :cond_3
    iget-object v1, v8, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v7, v14, v13, v10}, Lchat/ola/vn/p/g;->a(Ljava/util/List;Ljava/lang/String;S)V

    return-void

    :cond_4
    invoke-interface {v7, v0, v14, v13, v10}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V

    return-void
.end method
