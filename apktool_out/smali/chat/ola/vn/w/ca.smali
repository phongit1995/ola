.class public Lchat/ola/vn/w/ca;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# instance fields
.field private e:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 0

    iget-object p1, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/w/ca;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/w/ca;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    const/16 p1, 0x6e

    iget-object p3, p0, Lchat/ola/vn/w/ca;->e:Ljava/lang/String;

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 19

    move-object/from16 v6, p1

    const/16 v7, 0x8a

    invoke-virtual {v6, v7}, Lchat/ola/vn/w/s;->c(S)I

    move-result v8

    const/4 v0, 0x0

    const/4 v9, 0x0

    if-lez v8, :cond_3

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10, v8}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v6, v7, v9}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    move v2, v1

    const/4 v11, 0x0

    :goto_0
    if-ge v11, v8, :cond_4

    invoke-virtual {v6, v7, v2}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v12

    invoke-virtual {v6, v2}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v1

    const/16 v3, 0x8b

    invoke-virtual {v6, v3, v2, v12, v9}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v3

    int-to-short v3, v3

    invoke-static {v3}, Lchat/ola/vn/w/cc;->a(S)S

    move-result v3

    new-instance v13, Lchat/ola/vn/message/f;

    invoke-direct {v13, v1, v3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    const/16 v1, 0xcd

    invoke-virtual {v6, v1, v2, v12, v9}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v13, v1}, Lchat/ola/vn/message/f;->a(I)V

    :cond_0
    const/16 v1, 0x6e

    invoke-virtual {v6, v1, v2, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const/4 v0, 0x7

    invoke-virtual {v6, v0, v2, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x2

    const/4 v15, 0x2

    goto :goto_1

    :cond_1
    const/4 v1, 0x1

    const/4 v15, 0x1

    :goto_1
    new-instance v4, Lchat/ola/vn/message/d;

    invoke-direct {v4, v15}, Lchat/ola/vn/message/d;-><init>(B)V

    const/16 v1, 0x8

    invoke-virtual {v6, v1, v2, v12}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v5

    const/16 v1, 0x89

    invoke-virtual {v6, v1, v2, v12, v9}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v3

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    const/16 v1, 0x9

    const-wide/16 v16, 0x0

    move-object v0, v6

    move v7, v3

    move v3, v12

    move-object v9, v4

    move/from16 v18, v8

    move-object v8, v5

    move-wide/from16 v4, v16

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    invoke-virtual {v9, v0, v1}, Lchat/ola/vn/message/d;->a(J)V

    invoke-virtual {v9, v8}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v9, v14}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    invoke-virtual {v9, v7}, Lchat/ola/vn/message/d;->a(B)V

    invoke-static {v9, v15}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object v0

    iput-object v0, v13, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    move-object v0, v14

    goto :goto_2

    :cond_2
    move/from16 v18, v8

    :goto_2
    invoke-interface {v10, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v11, v11, 0x1

    move v2, v12

    move/from16 v8, v18

    const/16 v7, 0x8a

    const/4 v9, 0x0

    goto/16 :goto_0

    :cond_3
    move-object v10, v0

    :cond_4
    const/16 v1, 0xff

    const/4 v2, 0x0

    invoke-virtual {v6, v1, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {v6, v1, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v1

    int-to-short v1, v1

    move-object/from16 v2, p2

    invoke-interface {v2, v10, v0, v1}, Lchat/ola/vn/p/g;->b(Ljava/util/List;Ljava/lang/String;S)V

    return-void
.end method
