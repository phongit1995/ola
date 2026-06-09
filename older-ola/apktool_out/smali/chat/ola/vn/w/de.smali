.class public Lchat/ola/vn/w/de;
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
    .locals 4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p3, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x7

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    const/16 v0, 0x6e

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->Q:J

    const-wide/16 v2, 0x0

    cmp-long p3, v0, v2

    if-eqz p3, :cond_0

    const/16 p3, 0x82

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->Q:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_0
    iget-wide v0, p1, Lchat/ola/vn/w/bk;->U:J

    cmp-long p3, v0, v2

    if-eqz p3, :cond_1

    const/16 p3, 0x3b

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->U:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_1
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_2

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 12

    const/16 p3, 0x6f

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 p3, 0x6e

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x0

    const/16 v3, 0x2d

    invoke-virtual {p1, v3, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {p1, v3, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0x72

    invoke-virtual {p1, v4, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {p1, v4, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    const/16 v5, 0x82

    invoke-virtual {p1, v5, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    const-wide/16 v6, 0x0

    invoke-virtual {p1, v5, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v8

    const-wide/32 v10, 0x5265c00

    div-long/2addr v8, v10

    long-to-int v5, v8

    const/16 v8, 0x3b

    invoke-virtual {p1, v8, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v6

    new-instance p1, Lchat/ola/vn/entity/ah;

    invoke-direct {p1, v3}, Lchat/ola/vn/entity/ah;-><init>(I)V

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v0

    invoke-virtual {v0, v3}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/ah;->a(Ljava/lang/String;)V

    :cond_0
    invoke-virtual {p1, p3}, Lchat/ola/vn/entity/ah;->b(Ljava/lang/String;)V

    move-object v0, p2

    move v3, v4

    move-object v4, p1

    invoke-interface/range {v0 .. v7}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;SLchat/ola/vn/entity/ah;IJ)V

    return-void
.end method
