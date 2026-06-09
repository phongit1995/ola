.class public Lchat/ola/vn/w/eb;
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
    .locals 2

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_0

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    if-eqz p3, :cond_1

    const/4 p3, 0x0

    :goto_0
    iget-object v0, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    array-length v0, v0

    if-ge p3, v0, :cond_1

    const/16 v0, 0x6d

    iget-object v1, p1, Lchat/ola/vn/w/bk;->F:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v0, 0x18

    iget-object v1, p1, Lchat/ola/vn/w/bk;->t:[Ljava/lang/String;

    aget-object v1, v1, p3

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_3

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 10

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/16 v1, 0x6d

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->c(S)I

    move-result v2

    const/4 v3, 0x0

    if-lez v2, :cond_0

    new-array v3, v2, [Ljava/lang/String;

    new-array v4, v2, [Ljava/lang/String;

    invoke-virtual {p1, v1, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    const/16 v6, 0x18

    invoke-virtual {p1, v6, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v7

    move v8, v7

    move v7, v5

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v2, :cond_1

    invoke-virtual {p1, v7}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v3, v5

    invoke-virtual {p1, v8}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v4, v5

    invoke-virtual {p1, v1, v7}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v7

    invoke-virtual {p1, v6, v8}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v8

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_0
    move-object v4, v3

    :cond_1
    const/16 v1, 0x72

    invoke-virtual {p1, v1, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, p3}, Lchat/ola/vn/w/s;->a(IB)B

    move-result p1

    const/4 p3, 0x1

    if-eq p1, p3, :cond_2

    return-void

    :cond_2
    invoke-interface {p2, v3, v4, v0}, Lchat/ola/vn/p/g;->a([Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method
