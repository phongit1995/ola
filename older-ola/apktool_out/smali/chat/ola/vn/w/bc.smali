.class Lchat/ola/vn/w/bc;
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
    .locals 12

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    if-lez v2, :cond_1

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    const/4 v4, -0x1

    invoke-virtual {p1, v1, v4}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    const/16 v6, 0x3a

    invoke-virtual {p1, v6, v4}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v4

    move v7, v4

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_0

    invoke-virtual {p1, v5}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v8

    const-wide/16 v9, 0x0

    invoke-virtual {p1, v7, v9, v10}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v9

    invoke-virtual {p1, v1, v5}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v5

    invoke-virtual {p1, v6, v7}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v7

    new-instance v11, Lchat/ola/vn/message/f;

    invoke-direct {v11, v8, p3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v11, v9, v10}, Lchat/ola/vn/message/f;->a(J)V

    invoke-interface {v3, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    invoke-interface {p2, v3, v0}, Lchat/ola/vn/p/g;->b(Ljava/util/List;S)V

    :cond_1
    return-void
.end method
