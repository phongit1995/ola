.class Lchat/ola/vn/w/at;
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
    .locals 0

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 16

    move-object/from16 v0, p1

    const/16 v1, 0x64

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    const/4 v3, 0x0

    const/16 v4, 0xff

    invoke-virtual {v0, v4, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {v0, v4, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    if-lez v2, :cond_0

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v0, v1, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    const/16 v7, 0x65

    invoke-virtual {v0, v7, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v8

    move v9, v8

    move v8, v6

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v2, :cond_1

    invoke-virtual {v0, v1, v8}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v10

    const-wide/16 v11, 0x0

    invoke-virtual {v0, v8, v11, v12}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v11

    invoke-virtual {v0, v9}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Lchat/ola/vn/entity/s;

    invoke-direct {v14, v11, v12, v13}, Lchat/ola/vn/entity/s;-><init>(JLjava/lang/String;)V

    const/16 v11, 0x6d

    invoke-virtual {v0, v11, v8, v10}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v11

    const/16 v12, 0x68

    invoke-virtual {v0, v12, v8, v10}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v12

    const/16 v13, 0x67

    invoke-virtual {v0, v13, v8, v10, v3}, Lchat/ola/vn/w/s;->a(SIII)I

    move-result v13

    int-to-short v13, v13

    const/16 v15, 0x1e

    invoke-virtual {v0, v15, v8, v10}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v14, v11}, Lchat/ola/vn/entity/s;->b(Ljava/lang/String;)V

    invoke-virtual {v14, v12}, Lchat/ola/vn/entity/s;->c(Ljava/lang/String;)V

    int-to-long v11, v13

    invoke-virtual {v14, v11, v12}, Lchat/ola/vn/entity/s;->a(J)V

    invoke-virtual {v14, v10}, Lchat/ola/vn/entity/s;->d(Ljava/lang/String;)V

    invoke-interface {v5, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v1, v8}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v8

    invoke-virtual {v0, v7, v9}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v9

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_0
    const/4 v5, 0x0

    :cond_1
    move-object/from16 v0, p2

    invoke-interface {v0, v5, v4}, Lchat/ola/vn/p/g;->a(Ljava/util/List;S)V

    return-void
.end method
