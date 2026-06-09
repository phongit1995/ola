.class public Lchat/ola/vn/w/ay;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/4 p3, 0x7

    iget-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

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
    .locals 16

    move-object/from16 v0, p1

    const/4 v1, 0x0

    const/16 v2, 0xff

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v11, v2

    const/4 v2, 0x7

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v2, 0x72

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v6, v2

    const/16 v2, 0x6f

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v7

    const/16 v2, 0x82

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    const-wide/16 v8, 0x0

    invoke-virtual {v0, v2, v8, v9}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v2

    cmp-long v5, v2, v8

    if-ltz v5, :cond_2

    const-wide/32 v12, 0x36ee80

    div-long v14, v2, v12

    long-to-int v5, v14

    rem-long/2addr v2, v12

    cmp-long v10, v2, v8

    if-eqz v10, :cond_0

    add-int/lit8 v5, v5, 0x1

    :cond_0
    div-int/lit8 v2, v5, 0x18

    rem-int/lit8 v5, v5, 0x18

    if-eqz v5, :cond_1

    add-int/lit8 v2, v2, 0x1

    :cond_1
    move v5, v2

    goto :goto_0

    :cond_2
    const/4 v2, -0x1

    const/4 v5, -0x1

    :goto_0
    const/16 v2, 0x9

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v8, v9}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v8

    const/16 v2, 0x6d

    invoke-virtual {v0, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x6e

    invoke-virtual {v0, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v10, 0x70

    invoke-virtual {v0, v10}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const-string v10, ";"

    invoke-static {v2, v10}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    const-string v10, ";"

    invoke-static {v3, v10}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    const/4 v10, 0x0

    if-eqz v0, :cond_3

    const-string v12, ";"

    invoke-static {v0, v12}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_3
    move-object v0, v10

    :goto_1
    if-eqz v2, :cond_5

    array-length v12, v2

    if-lez v12, :cond_5

    new-instance v10, Ljava/util/ArrayList;

    array-length v12, v2

    invoke-direct {v10, v12}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v12, 0x0

    :goto_2
    array-length v13, v2

    if-ge v12, v13, :cond_5

    new-instance v13, Lchat/ola/vn/entity/ah;

    aget-object v14, v2, v12

    invoke-static {v14}, Ljava/lang/Short;->parseShort(Ljava/lang/String;)S

    move-result v14

    invoke-direct {v13, v14}, Lchat/ola/vn/entity/ah;-><init>(I)V

    aget-object v14, v3, v12

    invoke-virtual {v13, v14}, Lchat/ola/vn/entity/ah;->b(Ljava/lang/String;)V

    if-eqz v0, :cond_4

    aget-object v14, v0, v12

    if-eqz v14, :cond_4

    aget-object v14, v0, v12

    const-string v15, "1"

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    invoke-virtual {v13, v14}, Lchat/ola/vn/entity/ah;->a(Z)V

    goto :goto_3

    :cond_4
    invoke-virtual {v13, v1}, Lchat/ola/vn/entity/ah;->a(Z)V

    :goto_3
    invoke-interface {v10, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    :cond_5
    move-object/from16 v3, p2

    invoke-interface/range {v3 .. v11}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;S)V

    return-void
.end method
