.class public Lchat/ola/vn/w/am;
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
    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-lez p3, :cond_1

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const/4 p3, 0x2

    iget-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_3

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    iget-object p3, p1, Lchat/ola/vn/w/bk;->l:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_4

    const/4 p3, 0x6

    iget-object p1, p1, Lchat/ola/vn/w/bk;->l:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_4
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 21

    move-object/from16 v6, p1

    move-object/from16 v7, p3

    const/4 v8, 0x0

    const/16 v0, 0xff

    invoke-virtual {v6, v0, v8}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {v6, v0, v8}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v9, v0

    const/4 v0, 0x2

    invoke-virtual {v6, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v10

    const/16 v0, 0x6d

    invoke-virtual {v6, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v11

    const/16 v12, 0x18

    invoke-virtual {v6, v12}, Lchat/ola/vn/w/s;->c(S)I

    move-result v13

    const/4 v0, 0x6

    invoke-virtual {v6, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v14

    if-lez v13, :cond_1

    new-instance v15, Ljava/util/ArrayList;

    invoke-direct {v15, v13}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v6, v12, v8}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    move v2, v0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v13, :cond_0

    invoke-virtual {v6, v12, v2}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    invoke-virtual {v6, v2}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v3

    const/16 v0, 0x16

    invoke-virtual {v6, v0, v2, v5}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    const/16 v0, 0xce

    invoke-virtual {v6, v0, v2, v5, v8}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v0

    const/16 v16, 0x9

    const-wide/16 v17, 0x0

    move v8, v0

    move-object v0, v6

    move-object v12, v1

    move/from16 v1, v16

    move-object/from16 v19, v3

    move v3, v5

    move/from16 v16, v4

    move/from16 v20, v5

    move-wide/from16 v4, v17

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    new-instance v2, Lchat/ola/vn/entity/i;

    invoke-direct {v2}, Lchat/ola/vn/entity/i;-><init>()V

    move-object/from16 v3, v19

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-virtual {v2, v12}, Lchat/ola/vn/entity/i;->c(Ljava/lang/String;)V

    invoke-virtual {v2, v8}, Lchat/ola/vn/entity/i;->b(I)V

    invoke-virtual {v2, v0, v1}, Lchat/ola/vn/entity/i;->a(J)V

    invoke-interface {v15, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v16, 0x1

    move/from16 v2, v20

    const/4 v8, 0x0

    const/16 v12, 0x18

    goto :goto_0

    :cond_0
    move-object v4, v15

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    move-object v4, v0

    :goto_1
    invoke-static {v10}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, v7, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    move-object v2, v0

    goto :goto_2

    :cond_2
    move-object v2, v10

    :goto_2
    iget-object v0, v7, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {v2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    move-object/from16 v0, p2

    invoke-interface {v0, v11, v4, v14, v9}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V

    return-void

    :cond_3
    move-object/from16 v0, p2

    move-object v1, v0

    move-object v3, v11

    move-object v5, v14

    move v6, v9

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V

    return-void
.end method
