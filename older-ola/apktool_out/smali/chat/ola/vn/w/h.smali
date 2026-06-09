.class public Lchat/ola/vn/w/h;
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
    const/16 p3, 0xcd

    iget v0, p1, Lchat/ola/vn/w/bk;->Z:I

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SI)V

    const/16 p3, 0x2d

    iget-short v0, p1, Lchat/ola/vn/w/bk;->ad:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

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

    move-object/from16 v1, p2

    const/4 v2, 0x0

    const/16 v3, 0xff

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v6, v3

    const/4 v3, 0x7

    invoke-virtual {v0, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x2d

    invoke-virtual {v0, v4, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {v0, v4, v2}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v4

    const/16 v5, 0x9

    invoke-virtual {v0, v5, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    const-wide/16 v7, -0x1

    invoke-virtual {v0, v5, v7, v8}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v9

    const-wide/16 v11, 0x0

    cmp-long v5, v9, v11

    if-ltz v5, :cond_2

    const-wide/32 v13, 0x36ee80

    div-long v7, v9, v13

    long-to-int v5, v7

    rem-long/2addr v9, v13

    cmp-long v7, v9, v11

    if-eqz v7, :cond_0

    add-int/lit8 v5, v5, 0x1

    :cond_0
    div-int/lit8 v7, v5, 0x18

    rem-int/lit8 v5, v5, 0x18

    if-eqz v5, :cond_1

    add-int/lit8 v7, v7, 0x1

    :cond_1
    move v5, v7

    goto :goto_0

    :cond_2
    const/4 v5, -0x1

    :goto_0
    const/16 v7, 0x3b

    invoke-virtual {v0, v7, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    const-wide/16 v7, -0x1

    invoke-virtual {v0, v2, v7, v8}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v7

    if-eqz v3, :cond_5

    move-object/from16 v0, p3

    iget-object v0, v0, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_1

    :cond_3
    cmp-long v0, v7, v11

    if-ltz v0, :cond_4

    int-to-short v0, v4

    invoke-interface {v1, v3, v0, v5, v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SIS)V

    return-void

    :cond_4
    int-to-short v0, v4

    invoke-interface {v1, v3, v0, v5, v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;SIS)V

    return-void

    :cond_5
    :goto_1
    int-to-short v2, v4

    move-object v0, v1

    move-object v1, v3

    move v3, v5

    move-wide v4, v7

    invoke-interface/range {v0 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;SIJS)V

    return-void
.end method
