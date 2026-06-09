.class Lchat/ola/vn/w/c;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->o:Ljava/lang/String;

    const/16 v0, 0x15

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    if-eqz p3, :cond_1

    const/4 p3, 0x0

    :goto_0
    iget-object v0, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    array-length v0, v0

    if-ge p3, v0, :cond_1

    const/4 v0, 0x7

    iget-object v1, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object v0, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    aget-object v0, v0, p3

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x16

    iget-object v1, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 16

    move-object/from16 v0, p1

    const/16 v1, 0x15

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x7

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->c(S)I

    move-result v3

    if-lez v3, :cond_0

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v3}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v5, 0x0

    invoke-virtual {v0, v2, v5}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    move v7, v6

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v3, :cond_1

    invoke-virtual {v0, v2, v7}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v8

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v9

    const/16 v10, 0x16

    invoke-virtual {v0, v10, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v10

    const/16 v11, 0x2d

    invoke-virtual {v0, v11, v7, v8, v5}, Lchat/ola/vn/w/s;->a(SIIB)B

    move-result v11

    int-to-short v11, v11

    const/16 v12, 0x26

    const/4 v13, -0x1

    invoke-virtual {v0, v12, v7, v8, v13}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v12

    int-to-short v12, v12

    const/16 v13, 0x56

    invoke-virtual {v0, v13, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0xc

    invoke-virtual {v0, v14, v7, v8, v5}, Lchat/ola/vn/w/s;->a(SIIS)B

    move-result v14

    int-to-short v14, v14

    const/16 v15, 0xd

    invoke-virtual {v0, v15, v7, v8}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v7

    new-instance v15, Lchat/ola/vn/message/f;

    invoke-direct {v15, v9, v5}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v15, v10}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    invoke-virtual {v15, v11}, Lchat/ola/vn/message/f;->e(S)V

    invoke-virtual {v15, v14}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {v15, v7}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    invoke-virtual {v15, v12}, Lchat/ola/vn/message/f;->c(S)V

    invoke-virtual {v15, v13}, Lchat/ola/vn/message/f;->f(Ljava/lang/String;)V

    const/4 v7, 0x1

    invoke-virtual {v15, v7}, Lchat/ola/vn/message/f;->b(B)V

    invoke-interface {v4, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v6, v6, 0x1

    move v7, v8

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    :cond_1
    move-object/from16 v0, p2

    invoke-interface {v0, v1, v4}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/util/List;)V

    return-void
.end method
